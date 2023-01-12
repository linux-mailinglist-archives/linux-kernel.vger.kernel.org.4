Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70AF9667F4C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 20:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240682AbjALTa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 14:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234912AbjALT3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 14:29:22 -0500
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B7113CF4;
        Thu, 12 Jan 2023 11:24:16 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id w14so10929710edi.5;
        Thu, 12 Jan 2023 11:24:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YMnmIzijuaqZflMjTtYj3OMB+Pw4CnTvILOcUfn79Dg=;
        b=GnH5pCZrAoVhTAwmLW5XkDZmMnLaT05kH+wjAQec+0FMdrFjdBxBre7ZwCM4sbnGFS
         DLguLmpvZr9F5Pn7aibq6TYF42MdryglhBPN0BEJN5G3a2MepTJtw6pVIPUm9+Fuyb/o
         xUGdO+OFvB48KUmyCrR96JwpIVDRcsw7/9U0bM1Sp9LlXFIqxRL3FycKjm1A8ZbUhbrH
         U9kmGS2/GIo0uPRGeN0BkldtnZRjpblsoVVc/VSelJz0tpDOC122eys05MaSVw1G6yWh
         cySrRJeCiwMtT0CtfZUh7WJgebao4C2sD0sR9i1jjRuJNH8URm0QIbFBiFElU+ZAkIZj
         XvWQ==
X-Gm-Message-State: AFqh2kp6TLtj60SIjZwMhMSs4kh+MznXtYGm/soyW22cgOVY34WzGTun
        0ojK6buDTulLV5GAhm8lnE3eWbeWJwSEMY8MYIY=
X-Google-Smtp-Source: AMrXdXtQgP05F0VUbaSSiLUXXPpwhzoqg6IKpiGRNLVL+VBYmqdsS7uJgawpVSSYXoJNM82CAMH0k6IcttIrGpYHJK8=
X-Received: by 2002:aa7:c853:0:b0:47e:4f0b:7ad9 with SMTP id
 g19-20020aa7c853000000b0047e4f0b7ad9mr5614791edt.239.1673551454572; Thu, 12
 Jan 2023 11:24:14 -0800 (PST)
MIME-Version: 1.0
References: <20230110151029.1945544-1-perry.yuan@amd.com>
In-Reply-To: <20230110151029.1945544-1-perry.yuan@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 12 Jan 2023 20:24:03 +0100
Message-ID: <CAJZ5v0hvvm4j+LvQsL_Uz9o8gD95L=mn257E5yMWvCRC25bV7w@mail.gmail.com>
Subject: Re: [PATCH v3] cpufreq: amd-pstate: fix kernel hang issue while
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

On Tue, Jan 10, 2023 at 4:11 PM Perry Yuan <perry.yuan@amd.com> wrote:
>
> In the amd_pstate_adjust_perf(), there is one cpufreq_cpu_get() call to
> increase increments the kobject reference count of policy and make it as
> busy. Therefore, a corresponding call to cpufreq_cpu_put() is needed to
> decrement the kobject reference count back, it will resolve the kernel
> hang issue when unregistering the amd-pstate driver and register the
> `amd_pstate_epp` driver instance.
>
> Fixes: 1d215f0319 ("cpufreq: amd-pstate: Add fast switch function for AMD P-State")
> Acked-by: Huang Rui <ray.huang@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Tested-by: Wyes Karny <wyes.karny@amd.com>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> Cc: stable@vger.kernel.org
>
> v3: add Fixes tag
> v2: add test-by flag from Wyes.
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

Applied as 6.2-rc material, thanks!
