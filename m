Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F04632DE7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 21:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiKUU0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 15:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiKUU0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 15:26:42 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7849258BEB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 12:26:41 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id q21so9489426iod.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 12:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BT3mLeHRkLjM2lO8vf497JZzDmMVUHMTAFUn4ckIutY=;
        b=CdBYlIOSIqKuWicrjZMzvlZNXbIRaST36jwlM8ONNYvOVpe/IC9NEvEOCoewE8Dfl3
         Lg9Nzn+n7z4wNA+t9/9Tt4vGcZM5eemgz4fghrdkzHQv/ECxyT7YXndJIVPwLXqQSSPD
         IKbvtR8g4NcmXzURDq13WsIg1muQ9hpnoibAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BT3mLeHRkLjM2lO8vf497JZzDmMVUHMTAFUn4ckIutY=;
        b=t8b/soImOQmU9NdXZmE31txcqQRlWDVIs7rE2nkF4D/PgJWmZxTLT/jqlfEmjQyt5C
         fnT1Iob5W8nnS6UvGHPKx+f70B2+H1ERAXBQnMpLnleGTvPPQDtNDQQo5QhtXwTBubOl
         U6FcqxriGERkA5U3FUi+3bdCy+vjhhxgdqBoFIdBPpQk27+SVMIT2DEOuPr2s9jbkh9h
         FoZAtGfDQOCbXU9+rb8uDSaFqtINolCtfSBhlbbgP2kVsQbKMdNc80Zjprds419KDF4h
         skykIKhNfERCnY9CLL/GUs2UG70byy8yNiQmtxdbcLf85VVQQELagornZnKqhoUAxbvp
         CvpQ==
X-Gm-Message-State: ANoB5pko5ttadZCEbCtJi0r/a5iJ/Gej/0HJ8hAyVnAkE8uWSG77OUFE
        WRGlcuanbvccp6LNz12yOQd8gw==
X-Google-Smtp-Source: AA0mqf4viaC/2FMw9Yg+yVv4pZ9rf3EjSlzLe32WS/WlhlpTJfMnhBccItkmdgRrDse9ZmhxeOYQrA==
X-Received: by 2002:a5d:8b5a:0:b0:6de:1b3c:e97d with SMTP id c26-20020a5d8b5a000000b006de1b3ce97dmr3989479iot.202.1669062400804;
        Mon, 21 Nov 2022 12:26:40 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id m14-20020a92710e000000b0030014a5556bsm4159640ilc.69.2022.11.21.12.26.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 12:26:39 -0800 (PST)
Message-ID: <25b0ccf5-cc0e-370c-aef9-5fdfd11b2c30@linuxfoundation.org>
Date:   Mon, 21 Nov 2022 13:26:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] tools/cpupower: Choose first online CPU to display
 details
Content-Language: en-US
To:     Saket Kumar Bhaskar <skb99@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Cc:     trenn@suse.com, shuah@kernel.org, ray.huang@amd.com,
        linux-pm@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20221121053530.103600-1-skb99@linux.vnet.ibm.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221121053530.103600-1-skb99@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/22 22:35, Saket Kumar Bhaskar wrote:
> The default output of cpupower info utils shows unexpected output
> when CPU 0 is disabled.
> 
> Considering a case where CPU 0 is disabled, output of cpupower idle-info:
> 
> Before change:
> cpupower idle-info
> CPUidle driver: pseries_idle
> CPUidle governor: menu
> analyzing CPU 0:
>   *is offline
> 
> After change:
> ./cpupower idle-info
> CPUidle driver: pseries_idle
> CPUidle governor: menu
> analyzing CPU 0:
>   *is offline
> analyzing CPU 1:
> 
> Number of idle states: 2
> Available idle states: snooze Shared Cede
> snooze:
> Flags/Description: snooze
> Latency: 0
> Usage: 919
> Duration: 68227
> Shared Cede:
> Flags/Description: Shared Cede
> Latency: 10
> Usage: 99324
> Duration: 67871518243
> 
> If -c option is not passed, CPU 0 was chosen as the default chosen CPU to
> display details. However when CPU 0 is offline, it results in showing
> unexpected output. This commit chooses the first online CPU
> instead of CPU 0, hence keeping the output more relevant in all cases.
> 
> Somewhat similar logic to set all CPUs in default case is present in
> cpufreq-set.c, cpuidle-set.c, cpupower-set.c. But here we have added
> logic to stop at first online CPU.
> 
> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.vnet.ibm.com>
> ---
>   tools/power/cpupower/utils/cpufreq-info.c  | 15 ++++++++++++---
>   tools/power/cpupower/utils/cpuidle-info.c  | 15 ++++++++++++---
>   tools/power/cpupower/utils/cpupower-info.c | 16 +++++++++++++---
>   3 files changed, 37 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/power/cpupower/utils/cpufreq-info.c b/tools/power/cpupower/utils/cpufreq-info.c
> index 0646f615fe2d..4001a5934494 100644
> --- a/tools/power/cpupower/utils/cpufreq-info.c
> +++ b/tools/power/cpupower/utils/cpufreq-info.c
> @@ -508,6 +508,7 @@ int cmd_freq_info(int argc, char **argv)
>   	unsigned int cpu = 0;
>   	unsigned int human = 0;
>   	int output_param = 0;
> +	bool is_default = false;
>   
>   	do {
>   		ret = getopt_long(argc, argv, "oefwldpgrasmybnc", info_opts,
> @@ -572,9 +573,11 @@ int cmd_freq_info(int argc, char **argv)
>   
>   	ret = 0;
>   
> -	/* Default is: show output of CPU 0 only */
> -	if (bitmask_isallclear(cpus_chosen))
> -		bitmask_setbit(cpus_chosen, 0);

Why can't we just use base_cpu here instead of 0 and it will
all work without any more code - you can update the comment
to say default is base_cpu info.

thanks,
-- Shuah
