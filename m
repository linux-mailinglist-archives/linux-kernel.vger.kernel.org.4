Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F11618768
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 19:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbiKCSXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 14:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbiKCSXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 14:23:23 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682EC1C41B;
        Thu,  3 Nov 2022 11:23:18 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id k26so1720147qkg.2;
        Thu, 03 Nov 2022 11:23:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2dFb6rZ5bt2NV1nIbgkeTWjI2dI/pMrKJLB7Uqjr+ac=;
        b=UL3GBE5rY3CmQIdbacX9euc90wWmuFAH29Q1QuvqxD6kTPxqcIcmPD2PRgbD3BvfE6
         c3azklaj6hlnrG9S5XTXzaHq4HtUMmERmXrmTQVYQc4/oDNMF2Qg8CmtTnD4oE+3SBDa
         c4wtvLb/9rpF9cMuBpJHzb3y4tFeWxv0i1VUc6KB/yhQb4xcJ6UZL8KRrbLYbJCLrNE9
         lBnGMD7HE0q9DrQ5oqYchNlyXQHXI/x856CqjJ0x5I1WQIChGDnu3xXnJCm3T6aoHhtA
         B3IhCRyimfr02syOdQ9Lkf0hd+FUXwsm6usqcSlV4sv4rPLtMaihpFRnqQ1oexFbNadw
         WWuA==
X-Gm-Message-State: ACrzQf1fURtuWe+zcLRvFKoPJhySEhE/lYeyK3Ar6dcY33IJTw/SCOvR
        jqq94LxBFjENRcxZh8Y1HWbjwcV13M0wY4FbD5w=
X-Google-Smtp-Source: AMsMyM4CDZhlAt2ukEk/+kcVwcvKOPMZZoOkUERLVsZFVXm3QwzhI2AzKPUZbaFIuTn3fvE1zF934QJTJ4LCZ3MUr6k=
X-Received: by 2002:a37:65c9:0:b0:6fa:1ef8:fa10 with SMTP id
 z192-20020a3765c9000000b006fa1ef8fa10mr20146711qkb.648.1667499797516; Thu, 03
 Nov 2022 11:23:17 -0700 (PDT)
MIME-Version: 1.0
References: <20221027171947.1465343-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20221027171947.1465343-1-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 3 Nov 2022 19:23:06 +0100
Message-ID: <CAJZ5v0h=1UuPLPo1cS6zr+AFhYE-7F9YN-t+p8dgkOFs1EQ+SQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Allow EPP 0x80 setting by the firmware
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     rafael@kernel.org, lenb@kernel.org, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, Oct 27, 2022 at 7:19 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> With the
> "commit 3d13058ed2a6 ("cpufreq: intel_pstate: Use firmware default EPP")"
> the firmware can set an EPP, which driver will not overwrite. But the
> driver has a valid range check for:
> 0x40 > firmware epp < 0x80.
> Hence firmware can't specify EPP of 0x80.
>
> If the firmware didn't specify in the valid range, the driver has a
> hard coded EPP of 102. But some Chrome hardware vendors don't want
> this overwrite and wants to boot with chipset default EPP of 0x80 as
> this improves battery life.
>
> In this case they want to have capability to specify EPP of 0x80 via
> the firmware. This require the valid range to include 0x80 also.
> But here the valid range can't be simply extended to include 0x80 as
> this is the chipset default EPP. Even without any firmware specifying
> EPP, the chipset will always boot with EPP of 0x80.
>
> To make sure that firmware specified EPP of 0x80 and not by the
> chipset default, it will require additional check to make sure HWP
> was enabled by the firmware before boot. Only way the firmware can
> update EPP, is to enable HWP and update EPP via MSR_HWP_REQUEST.
>
> This driver already checks, if the HWP is enabled by the firmware.
> Use the same flag and extend valid range to include 0x80.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index fc3ebeb0bbe5..c41875abd8be 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -297,6 +297,7 @@ static int hwp_active __read_mostly;
>  static int hwp_mode_bdw __read_mostly;
>  static bool per_cpu_limits __read_mostly;
>  static bool hwp_boost __read_mostly;
> +static bool hwp_forced __read_mostly;
>
>  static struct cpufreq_driver *intel_pstate_driver __read_mostly;
>
> @@ -1705,12 +1706,12 @@ static void intel_pstate_update_epp_defaults(struct cpudata *cpudata)
>                 return;
>
>         /*
> -        * If powerup EPP is something other than chipset default 0x80 and
> -        * - is more performance oriented than 0x80 (default balance_perf EPP)
> +        * If the EPP is set by firmware, which means that firmware enabled HWP
> +        * - Is equal or less than 0x80 (default balance_perf EPP)
>          * - But less performance oriented than performance EPP
>          *   then use this as new balance_perf EPP.
>          */
> -       if (cpudata->epp_default < HWP_EPP_BALANCE_PERFORMANCE &&
> +       if (hwp_forced && cpudata->epp_default <= HWP_EPP_BALANCE_PERFORMANCE &&
>             cpudata->epp_default > HWP_EPP_PERFORMANCE) {
>                 epp_values[EPP_INDEX_BALANCE_PERFORMANCE] = cpudata->epp_default;
>                 return;
> @@ -3423,7 +3424,7 @@ static int __init intel_pstate_init(void)
>
>         id = x86_match_cpu(hwp_support_ids);
>         if (id) {
> -               bool hwp_forced = intel_pstate_hwp_is_enabled();
> +               hwp_forced = intel_pstate_hwp_is_enabled();
>
>                 if (hwp_forced)
>                         pr_info("HWP enabled by BIOS\n");
> --

Applied as 6.2 material, thanks!
