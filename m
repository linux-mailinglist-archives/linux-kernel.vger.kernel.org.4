Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290CB63E061
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 19:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiK3S6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 13:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiK3S6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 13:58:16 -0500
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FD69D810;
        Wed, 30 Nov 2022 10:58:08 -0800 (PST)
Received: by mail-qv1-f52.google.com with SMTP id s14so837193qvo.11;
        Wed, 30 Nov 2022 10:58:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NV+aRXYKE3DBJkVT9Hd67uMEpdGk6soKLvDOrRjSNtA=;
        b=w4RcxxKftt4X0fjNm1LtCCzIouoJuiFvvtWEAidXDB1FWV63JtNxl/fa9Zkm7A4EpD
         R4jBWHuRs4dxmzzCbBiTeqKzHcecpKTUGh4ikKC0rYtbB7GEltLWUZLlbD6dF2hQIA5E
         qXM0LzeFIAfyi+jwp6YutV9YoPT6d2L6Fika/aNqWoQnLuhnfsi0iHb4xrqRvr0e+WPq
         UlMjF745nyPwEuUz3aHljRZf60C4M3mrEcrUiMxUGIbvsP19q6VjmYmxHG7JvU2Wwq3s
         KRECC6iS9iLHu/q1w1UPZ+V0SmDC6jIRsFknTStQ+Tu+bighz4lY6KiM0GhdWSNhnCEo
         5+PA==
X-Gm-Message-State: ANoB5pnMhM6HC124U5od+fMbwmacBUwQfKpc5eDQ5e+Ft80D7EkFKXCs
        H4xxaSCY95dIBI39HFq8a8rbMPck9H43mGwvyd2tY78H
X-Google-Smtp-Source: AA0mqf6JIen0xJ+raeq9RHWsftljVBvuBEfkR0LnNkUAF/LU5cSSc7sUepqo5TOLYZwnlMqJAXGMlMdNc3ZKRmn74o8=
X-Received: by 2002:a0c:c582:0:b0:4af:b750:b569 with SMTP id
 a2-20020a0cc582000000b004afb750b569mr41510179qvj.83.1669834687400; Wed, 30
 Nov 2022 10:58:07 -0800 (PST)
MIME-Version: 1.0
References: <20221121153540.10494-1-ggherdovich@suse.cz>
In-Reply-To: <20221121153540.10494-1-ggherdovich@suse.cz>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 30 Nov 2022 19:57:56 +0100
Message-ID: <CAJZ5v0iFe-jeVw_VfqG+xgxN_VVWXHEx9r4S_dGERWsWDNPxPA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Add Sapphire Rapids support in
 no-HWP mode
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 4:35 PM Giovanni Gherdovich <ggherdovich@suse.cz> wrote:
>
> Users may disable HWP in firmware, in which case intel_pstate wouldn't load
> unless the CPU model is explicitly supported.
>
> See also the following past commits:
>
> commit d8de7a44e11f ("cpufreq: intel_pstate: Add Skylake servers support")
> commit 706c5328851d ("cpufreq: intel_pstate: Add Cometlake support in
> no-HWP mode")
> commit fbdc21e9b038 ("cpufreq: intel_pstate: Add Icelake servers support in
> no-HWP mode")
> commit 71bb5c82aaae ("cpufreq: intel_pstate: Add Tigerlake support in
> no-HWP mode")
>
> Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
> ---
>  drivers/cpufreq/intel_pstate.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 6ff73c30769f..181cd6b045ff 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2378,6 +2378,7 @@ static const struct x86_cpu_id intel_pstate_cpu_ids[] = {
>         X86_MATCH(COMETLAKE,            core_funcs),
>         X86_MATCH(ICELAKE_X,            core_funcs),
>         X86_MATCH(TIGERLAKE,            core_funcs),
> +       X86_MATCH(SAPPHIRERAPIDS_X,     core_funcs),
>         {}
>  };
>  MODULE_DEVICE_TABLE(x86cpu, intel_pstate_cpu_ids);
> --

Applied as 6.2 material, thanks!
