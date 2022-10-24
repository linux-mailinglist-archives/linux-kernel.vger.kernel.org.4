Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C36460BFD1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 02:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbiJYAm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 20:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiJYAmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 20:42:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92DB5E560
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 16:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666653213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dTJ78Wi/Bn4a7gXM5FhlU/stXOGbP+8r4N7PUdsa5sU=;
        b=Tdwbi5G8cxRjaD3j6vOF0u+nb1ZOYq1e4DtRu+U3qBMJiDlnZAGy+daYimfRCwKgwjVnwC
        W032Fi/sotbUNEFOo09OE6E/gmLCDCx937N3DxVySEsyYS+QRp8JxxSe6C1Xp3Yfvweqbv
        1T/Zq30bmZuRzon/GhOKWHcgRjdsjD4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-54-aNqE7AK-P1uBwaztmcCojA-1; Mon, 24 Oct 2022 09:27:44 -0400
X-MC-Unique: aNqE7AK-P1uBwaztmcCojA-1
Received: by mail-ed1-f72.google.com with SMTP id z11-20020a056402274b00b00461dba91468so2127421edd.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 06:27:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dTJ78Wi/Bn4a7gXM5FhlU/stXOGbP+8r4N7PUdsa5sU=;
        b=bzXU/ORkv6yI1lEKD5CpA8OWxxC8f1t96SrW1TJ4gicfKBCH4KuQ+SQkkdsBy3H+Io
         fyi3ulbhu4ImAEwUb+ZD9oZm0Pnl/CF5thiQSfcfL3aeSum7Hum4v7C4VGe6BdwI0L+d
         wZbGhBs8y1HgwECookdcz3GFDlE8NZ//r3a9hzESzzUtOqVbb4Jfx7OSmdfb7v55uj9/
         BF8MEcWnCsYA2YaYuNtAM5YIIz40Augn1wOiQSeJjk38iiRtN9MuQHnolqePe70hXOi1
         INzUa+W/sYyK1Pn7D8EBnw4JmTCBB7u7W5+sfLulbO+gpY9JwqE6O7lZqM3s4lwiCWWS
         PVzA==
X-Gm-Message-State: ACrzQf3s53Q7CiOuK2fmaW4GWk98X8X8yF2CCUZIPUNcbE30fuEjETy7
        jGhR1ra7er05pC3Dlxr3k/gdrIh3BvXxl39BBzclKn/g0WPJg3lPx8PyHZvMW4NB9lGkt/7/ufI
        tCBeD/7RtlLmWM/ZwyNfeR+wb
X-Received: by 2002:a17:906:ef8c:b0:78d:96b9:a0ad with SMTP id ze12-20020a170906ef8c00b0078d96b9a0admr27988620ejb.529.1666618062845;
        Mon, 24 Oct 2022 06:27:42 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6PLjdH/SJdBXM7kRQutOhLpzW+wJVl2He++jL7fQe3kHCU8K+TJwxVcv/vyNeVOcmgxY6WUw==
X-Received: by 2002:a17:906:ef8c:b0:78d:96b9:a0ad with SMTP id ze12-20020a170906ef8c00b0078d96b9a0admr27988610ejb.529.1666618062644;
        Mon, 24 Oct 2022 06:27:42 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id p17-20020a05640210d100b00461c1804cdasm2100885edu.3.2022.10.24.06.27.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 06:27:42 -0700 (PDT)
Message-ID: <116e3615-a0fc-3b88-18e1-c03c29bf78fd@redhat.com>
Date:   Mon, 24 Oct 2022 15:27:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] platform/x86/amd/pmf: pass the struct by reference
Content-Language: en-US
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Mark Gross <markgross@kernel.org>
Cc:     kernel@collabora.com, kernel-janitors@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221004081019.619193-1-usama.anjum@collabora.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221004081019.619193-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/4/22 10:10, Muhammad Usama Anjum wrote:
> The out structure should be passed by reference instead of passing by
> value. This saves the extra copy of the structure.
> 
> Fixes: 1738061c9ec8 ("platform/x86/amd/pmf: Add support for CnQF")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

Applied (minus the fixes tag as this is not a bug-fix):

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



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

