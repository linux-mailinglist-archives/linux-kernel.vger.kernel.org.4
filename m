Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7965F3EC5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiJDItK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbiJDItF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:49:05 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9524A10F;
        Tue,  4 Oct 2022 01:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=LiAbRkAexfNIkeNb/y4I//H9Ig3RPY6KfEDNNseQzrY=;
  b=L3ZXJpBjPxOf6M8wKP45P3tnFKMVN0Mg44ivRbe2vQtlCwc/O9RiJpAK
   1zM3MugsDDY2DAS4bnv6wvhrXlZrJbHX7o657CYBqY1HwgaBjz3o8ffPI
   QfjJWGDyrMhjz0dlNqamcMP+LqlTXZFfTLInTtYEmoChnWkkHoRoxGfc2
   4=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.93,367,1654552800"; 
   d="scan'208";a="25403802"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 10:49:01 +0200
Date:   Tue, 4 Oct 2022 10:49:00 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
cc:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>, kernel@collabora.com,
        kernel-janitors@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86/amd/pmf: pass the struct by reference
In-Reply-To: <20221004081019.619193-1-usama.anjum@collabora.com>
Message-ID: <5ac457fa-3159-849f-e814-b8ae3eae9d17@inria.fr>
References: <20221004081019.619193-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 4 Oct 2022, Muhammad Usama Anjum wrote:

> The out structure should be passed by reference instead of passing by
> value. This saves the extra copy of the structure.

This seems like a common issue.  Many of the structures are small, but
some contain multiple ints, pointers, etc.

julia

>
> Fixes: 1738061c9ec8 ("platform/x86/amd/pmf: Add support for CnQF")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  drivers/platform/x86/amd/pmf/cnqf.c | 92 ++++++++++++++---------------
>  1 file changed, 46 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/platform/x86/amd/pmf/cnqf.c b/drivers/platform/x86/amd/pmf/cnqf.c
> index 668c7c0fea83..3f9731a2ac28 100644
> --- a/drivers/platform/x86/amd/pmf/cnqf.c
> +++ b/drivers/platform/x86/amd/pmf/cnqf.c
> @@ -158,100 +158,100 @@ int amd_pmf_trans_cnqf(struct amd_pmf_dev *dev, int socket_power, ktime_t time_l
>  	return 0;
>  }
>
> -static void amd_pmf_update_trans_data(int idx, struct apmf_dyn_slider_output out)
> +static void amd_pmf_update_trans_data(int idx, struct apmf_dyn_slider_output *out)
>  {
>  	struct cnqf_tran_params *tp;
>
>  	tp = &config_store.trans_param[idx][CNQF_TRANSITION_TO_QUIET];
> -	tp->time_constant = out.t_balanced_to_quiet;
> +	tp->time_constant = out->t_balanced_to_quiet;
>  	tp->target_mode = CNQF_MODE_QUIET;
>  	tp->shifting_up = false;
>
>  	tp = &config_store.trans_param[idx][CNQF_TRANSITION_FROM_BALANCE_TO_PERFORMANCE];
> -	tp->time_constant = out.t_balanced_to_perf;
> +	tp->time_constant = out->t_balanced_to_perf;
>  	tp->target_mode = CNQF_MODE_PERFORMANCE;
>  	tp->shifting_up = true;
>
>  	tp = &config_store.trans_param[idx][CNQF_TRANSITION_FROM_QUIET_TO_BALANCE];
> -	tp->time_constant = out.t_quiet_to_balanced;
> +	tp->time_constant = out->t_quiet_to_balanced;
>  	tp->target_mode = CNQF_MODE_BALANCE;
>  	tp->shifting_up = true;
>
>  	tp = &config_store.trans_param[idx][CNQF_TRANSITION_FROM_PERFORMANCE_TO_BALANCE];
> -	tp->time_constant = out.t_perf_to_balanced;
> +	tp->time_constant = out->t_perf_to_balanced;
>  	tp->target_mode = CNQF_MODE_BALANCE;
>  	tp->shifting_up = false;
>
>  	tp = &config_store.trans_param[idx][CNQF_TRANSITION_FROM_TURBO_TO_PERFORMANCE];
> -	tp->time_constant = out.t_turbo_to_perf;
> +	tp->time_constant = out->t_turbo_to_perf;
>  	tp->target_mode = CNQF_MODE_PERFORMANCE;
>  	tp->shifting_up = false;
>
>  	tp = &config_store.trans_param[idx][CNQF_TRANSITION_TO_TURBO];
> -	tp->time_constant = out.t_perf_to_turbo;
> +	tp->time_constant = out->t_perf_to_turbo;
>  	tp->target_mode = CNQF_MODE_TURBO;
>  	tp->shifting_up = true;
>  }
>
> -static void amd_pmf_update_mode_set(int idx, struct apmf_dyn_slider_output out)
> +static void amd_pmf_update_mode_set(int idx, struct apmf_dyn_slider_output *out)
>  {
>  	struct cnqf_mode_settings *ms;
>
>  	/* Quiet Mode */
>  	ms = &config_store.mode_set[idx][CNQF_MODE_QUIET];
> -	ms->power_floor = out.ps[APMF_CNQF_QUIET].pfloor;
> -	ms->power_control.fppt = out.ps[APMF_CNQF_QUIET].fppt;
> -	ms->power_control.sppt = out.ps[APMF_CNQF_QUIET].sppt;
> -	ms->power_control.sppt_apu_only = out.ps[APMF_CNQF_QUIET].sppt_apu_only;
> -	ms->power_control.spl = out.ps[APMF_CNQF_QUIET].spl;
> -	ms->power_control.stt_min = out.ps[APMF_CNQF_QUIET].stt_min_limit;
> +	ms->power_floor = out->ps[APMF_CNQF_QUIET].pfloor;
> +	ms->power_control.fppt = out->ps[APMF_CNQF_QUIET].fppt;
> +	ms->power_control.sppt = out->ps[APMF_CNQF_QUIET].sppt;
> +	ms->power_control.sppt_apu_only = out->ps[APMF_CNQF_QUIET].sppt_apu_only;
> +	ms->power_control.spl = out->ps[APMF_CNQF_QUIET].spl;
> +	ms->power_control.stt_min = out->ps[APMF_CNQF_QUIET].stt_min_limit;
>  	ms->power_control.stt_skin_temp[STT_TEMP_APU] =
> -		out.ps[APMF_CNQF_QUIET].stt_skintemp[STT_TEMP_APU];
> +		out->ps[APMF_CNQF_QUIET].stt_skintemp[STT_TEMP_APU];
>  	ms->power_control.stt_skin_temp[STT_TEMP_HS2] =
> -		out.ps[APMF_CNQF_QUIET].stt_skintemp[STT_TEMP_HS2];
> -	ms->fan_control.fan_id = out.ps[APMF_CNQF_QUIET].fan_id;
> +		out->ps[APMF_CNQF_QUIET].stt_skintemp[STT_TEMP_HS2];
> +	ms->fan_control.fan_id = out->ps[APMF_CNQF_QUIET].fan_id;
>
>  	/* Balance Mode */
>  	ms = &config_store.mode_set[idx][CNQF_MODE_BALANCE];
> -	ms->power_floor = out.ps[APMF_CNQF_BALANCE].pfloor;
> -	ms->power_control.fppt = out.ps[APMF_CNQF_BALANCE].fppt;
> -	ms->power_control.sppt = out.ps[APMF_CNQF_BALANCE].sppt;
> -	ms->power_control.sppt_apu_only = out.ps[APMF_CNQF_BALANCE].sppt_apu_only;
> -	ms->power_control.spl = out.ps[APMF_CNQF_BALANCE].spl;
> -	ms->power_control.stt_min = out.ps[APMF_CNQF_BALANCE].stt_min_limit;
> +	ms->power_floor = out->ps[APMF_CNQF_BALANCE].pfloor;
> +	ms->power_control.fppt = out->ps[APMF_CNQF_BALANCE].fppt;
> +	ms->power_control.sppt = out->ps[APMF_CNQF_BALANCE].sppt;
> +	ms->power_control.sppt_apu_only = out->ps[APMF_CNQF_BALANCE].sppt_apu_only;
> +	ms->power_control.spl = out->ps[APMF_CNQF_BALANCE].spl;
> +	ms->power_control.stt_min = out->ps[APMF_CNQF_BALANCE].stt_min_limit;
>  	ms->power_control.stt_skin_temp[STT_TEMP_APU] =
> -		out.ps[APMF_CNQF_BALANCE].stt_skintemp[STT_TEMP_APU];
> +		out->ps[APMF_CNQF_BALANCE].stt_skintemp[STT_TEMP_APU];
>  	ms->power_control.stt_skin_temp[STT_TEMP_HS2] =
> -		out.ps[APMF_CNQF_BALANCE].stt_skintemp[STT_TEMP_HS2];
> -	ms->fan_control.fan_id = out.ps[APMF_CNQF_BALANCE].fan_id;
> +		out->ps[APMF_CNQF_BALANCE].stt_skintemp[STT_TEMP_HS2];
> +	ms->fan_control.fan_id = out->ps[APMF_CNQF_BALANCE].fan_id;
>
>  	/* Performance Mode */
>  	ms = &config_store.mode_set[idx][CNQF_MODE_PERFORMANCE];
> -	ms->power_floor = out.ps[APMF_CNQF_PERFORMANCE].pfloor;
> -	ms->power_control.fppt = out.ps[APMF_CNQF_PERFORMANCE].fppt;
> -	ms->power_control.sppt = out.ps[APMF_CNQF_PERFORMANCE].sppt;
> -	ms->power_control.sppt_apu_only = out.ps[APMF_CNQF_PERFORMANCE].sppt_apu_only;
> -	ms->power_control.spl = out.ps[APMF_CNQF_PERFORMANCE].spl;
> -	ms->power_control.stt_min = out.ps[APMF_CNQF_PERFORMANCE].stt_min_limit;
> +	ms->power_floor = out->ps[APMF_CNQF_PERFORMANCE].pfloor;
> +	ms->power_control.fppt = out->ps[APMF_CNQF_PERFORMANCE].fppt;
> +	ms->power_control.sppt = out->ps[APMF_CNQF_PERFORMANCE].sppt;
> +	ms->power_control.sppt_apu_only = out->ps[APMF_CNQF_PERFORMANCE].sppt_apu_only;
> +	ms->power_control.spl = out->ps[APMF_CNQF_PERFORMANCE].spl;
> +	ms->power_control.stt_min = out->ps[APMF_CNQF_PERFORMANCE].stt_min_limit;
>  	ms->power_control.stt_skin_temp[STT_TEMP_APU] =
> -		out.ps[APMF_CNQF_PERFORMANCE].stt_skintemp[STT_TEMP_APU];
> +		out->ps[APMF_CNQF_PERFORMANCE].stt_skintemp[STT_TEMP_APU];
>  	ms->power_control.stt_skin_temp[STT_TEMP_HS2] =
> -		out.ps[APMF_CNQF_PERFORMANCE].stt_skintemp[STT_TEMP_HS2];
> -	ms->fan_control.fan_id = out.ps[APMF_CNQF_PERFORMANCE].fan_id;
> +		out->ps[APMF_CNQF_PERFORMANCE].stt_skintemp[STT_TEMP_HS2];
> +	ms->fan_control.fan_id = out->ps[APMF_CNQF_PERFORMANCE].fan_id;
>
>  	/* Turbo Mode */
>  	ms = &config_store.mode_set[idx][CNQF_MODE_TURBO];
> -	ms->power_floor = out.ps[APMF_CNQF_TURBO].pfloor;
> -	ms->power_control.fppt = out.ps[APMF_CNQF_TURBO].fppt;
> -	ms->power_control.sppt = out.ps[APMF_CNQF_TURBO].sppt;
> -	ms->power_control.sppt_apu_only = out.ps[APMF_CNQF_TURBO].sppt_apu_only;
> -	ms->power_control.spl = out.ps[APMF_CNQF_TURBO].spl;
> -	ms->power_control.stt_min = out.ps[APMF_CNQF_TURBO].stt_min_limit;
> +	ms->power_floor = out->ps[APMF_CNQF_TURBO].pfloor;
> +	ms->power_control.fppt = out->ps[APMF_CNQF_TURBO].fppt;
> +	ms->power_control.sppt = out->ps[APMF_CNQF_TURBO].sppt;
> +	ms->power_control.sppt_apu_only = out->ps[APMF_CNQF_TURBO].sppt_apu_only;
> +	ms->power_control.spl = out->ps[APMF_CNQF_TURBO].spl;
> +	ms->power_control.stt_min = out->ps[APMF_CNQF_TURBO].stt_min_limit;
>  	ms->power_control.stt_skin_temp[STT_TEMP_APU] =
> -		out.ps[APMF_CNQF_TURBO].stt_skintemp[STT_TEMP_APU];
> +		out->ps[APMF_CNQF_TURBO].stt_skintemp[STT_TEMP_APU];
>  	ms->power_control.stt_skin_temp[STT_TEMP_HS2] =
> -		out.ps[APMF_CNQF_TURBO].stt_skintemp[STT_TEMP_HS2];
> -	ms->fan_control.fan_id = out.ps[APMF_CNQF_TURBO].fan_id;
> +		out->ps[APMF_CNQF_TURBO].stt_skintemp[STT_TEMP_HS2];
> +	ms->fan_control.fan_id = out->ps[APMF_CNQF_TURBO].fan_id;
>  }
>
>  static int amd_pmf_check_flags(struct amd_pmf_dev *dev)
> @@ -284,8 +284,8 @@ static int amd_pmf_load_defaults_cnqf(struct amd_pmf_dev *dev)
>  			return ret;
>  		}
>
> -		amd_pmf_update_mode_set(i, out);
> -		amd_pmf_update_trans_data(i, out);
> +		amd_pmf_update_mode_set(i, &out);
> +		amd_pmf_update_trans_data(i, &out);
>  		amd_pmf_update_power_threshold(i);
>
>  		for (j = 0; j < CNQF_MODE_MAX; j++) {
> --
> 2.30.2
>
>
