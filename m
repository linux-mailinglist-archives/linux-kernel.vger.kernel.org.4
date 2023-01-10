Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB5C664100
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 13:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238557AbjAJM5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 07:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238533AbjAJM5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 07:57:44 -0500
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F38C517C0;
        Tue, 10 Jan 2023 04:57:43 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id x10so14505930edd.10;
        Tue, 10 Jan 2023 04:57:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bCpIXeaT7dr+gvqh2JjBH/RM0pRf6k7P06lJN2lqs6E=;
        b=fcOQGKVg/bSdFFx12pTay6f9COe2Xswj6mWm3tXZLLTNj1x/KA6VkeHbCA82UzFisw
         yP8S0hyYTU8+JPeGVAy33caXhI3ivyixJ0o0LGIPueW2gYmILZ2WpQAaN0b1pIOzmpDf
         7Pfpjkt94oTzqSy/BsTkEd5SVBO+vi5rOskGTZqaNTSCgdWKr+NrxX8hlox/mC3dP9/p
         8C9P3WZGMCLKmdSLgp3jla2T5JTqnl5q1d1kcB8GBpxIycBvZW4EMqNgBj9d4ug18Ps8
         vBYYsQHSb/chd1T0tTJDXXkQhkyFWd3dHSuvsIHKjT0kGm1UBBavrFEbcWHsKtDrVZcV
         1pkQ==
X-Gm-Message-State: AFqh2koAyIYjHLFVFEvH8s/XGHtiCi2xJkx2TtT6lkDzsphKeiXaWNYJ
        53MM+Axa5GW5Xr1Ml0pwb9hivVPrOBDcZc5QjKg=
X-Google-Smtp-Source: AMrXdXsypCv28KKT1wfLEIZOZUy/HBgFz+BEZs64KF3uoFbDQVVNOmfV2pGY4iz4P+2pDfVQo8nPd76XOmMvJ0/21G0=
X-Received: by 2002:a50:eb49:0:b0:46d:731c:2baf with SMTP id
 z9-20020a50eb49000000b0046d731c2bafmr6748706edp.280.1673355461927; Tue, 10
 Jan 2023 04:57:41 -0800 (PST)
MIME-Version: 1.0
References: <20230110124940.1622798-1-perry.yuan@amd.com>
In-Reply-To: <20230110124940.1622798-1-perry.yuan@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 10 Jan 2023 13:57:30 +0100
Message-ID: <CAJZ5v0j1ioh5aSRMB8DTvtKzX22n3AmLfgmDmbKCYQMAoJx6aQ@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: amd-pstate: fix kernel hang issue while
 amd-pstate unregistering
To:     Perry Yuan <perry.yuan@amd.com>
Cc:     rafael.j.wysocki@intel.com, Mario.Limonciello@amd.com,
        ray.huang@amd.com, viresh.kumar@linaro.org, Deepak.Sharma@amd.com,
        Nathan.Fontenot@amd.com, Alexander.Deucher@amd.com,
        Shimmer.Huang@amd.com, Xiaojian.Du@amd.com, Li.Meng@amd.com,
        wyes.karny@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 1:50 PM Perry Yuan <perry.yuan@amd.com> wrote:
>
> In the amd_pstate_adjust_perf(), there is one cpufreq_cpu_get() call to
> increase increments the kobject reference count of policy and make it as
> busy. Therefore, a corresponding call to cpufreq_cpu_put() is needed to
> decrement the kobject reference count back, it will resolve the kernel
> hang issue when unregistering the amd-pstate driver and register the
> `amd_pstate_epp` driver instance.
>
> Acked-by: Huang Rui <ray.huang@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> Tested-by: Wyes Karny <wyes.karny@amd.com>
> Cc: stable@vger.kernel.org

Can you provide a Fixes tag, please?

Also, what's the difference between this and the previous version?

> ---
>  drivers/cpufreq/amd-pstate.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 204e39006dda..c17bd845f5fc 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -307,6 +307,7 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>                 max_perf = min_perf;
>
>         amd_pstate_update(cpudata, min_perf, des_perf, max_perf, true);
> +       cpufreq_cpu_put(policy);
>  }
>
>  static int amd_get_min_freq(struct amd_cpudata *cpudata)
> --
> 2.34.1
>
