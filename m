Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49915BCAEB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 13:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiISLjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 07:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiISLjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 07:39:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53CABE1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 04:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663587570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bQ6zwKhiizSCTbZXM4hYel5ioxpL+B7BAbfA/FrZv8U=;
        b=IFsWfNXFmqkTZ9NqsO1X3EQRNjYTsxOGtRJALq9R/i1qyLvMy1zhYsg+cE10/7Xrah1xxx
        hxwdwYIsqJSEzXEARt9PrExcQ78ohrfQsrJFhsQ7sB4NWRfVkLMWJI98zpytKayq7Bn7Cb
        KS9XU38kCYnPfLc0giXvxBReTZ/upns=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-86-iv7Bv9NSOw2daID41s_Law-1; Mon, 19 Sep 2022 07:39:28 -0400
X-MC-Unique: iv7Bv9NSOw2daID41s_Law-1
Received: by mail-ed1-f72.google.com with SMTP id h13-20020a056402280d00b004528c8400afso11740080ede.6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 04:39:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=bQ6zwKhiizSCTbZXM4hYel5ioxpL+B7BAbfA/FrZv8U=;
        b=GnQ34Ot9S+wCq1E70pWfs3fb2v8dnva0Rd71rtVrDswI3kVfxn5LfLqOwQSNBRk4Ej
         IuyyZ4uVdm7mrh+9mq95O9lc1fmDmDZ2EPbsZgRxZekanSKZyw4q7yOiKDMITbAGkvZN
         EKpuv2G2To45wCbvp+2aOhasP6c1No95wcys75xkyTs8lOmQg5nMsZZbM1pUHe1HoaqK
         sNBV+MCbgsp8BOdyzuXkaCQmCMZYH14Zut77d7wS8HZ8YwvSDmQRgpTCPJB4roTuo2ja
         2gQeRy7cKeqFKLF2bb5MMiIrHz2aeFMicwIsGf3ELigWoCaXLjZCTLi2hU5tg9nfiekK
         /jcQ==
X-Gm-Message-State: ACrzQf0HjGjBIncZ3DfMXRNa0VGxHGiojDMunlyvIh+Fsedu10ElWYPH
        xpqP77x3yHxiBLcwWusEQC7U/yBSCzNKnBCJd1sXx7kvb8P5bWUSrevT96u/LNKc10blKZZAg+2
        nRbGWyiSYPDWgRFrZQ3MTLnyj
X-Received: by 2002:a17:906:4786:b0:780:ed2a:ed6a with SMTP id cw6-20020a170906478600b00780ed2aed6amr7074838ejc.769.1663587567724;
        Mon, 19 Sep 2022 04:39:27 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7y38ljAWNfKtMrDEWP8DJQZxSxjHC04BKrT2b3l3n2kt5naoWRx4HyyTQts4SVkNvtIXTVgw==
X-Received: by 2002:a17:906:4786:b0:780:ed2a:ed6a with SMTP id cw6-20020a170906478600b00780ed2aed6amr7074827ejc.769.1663587567562;
        Mon, 19 Sep 2022 04:39:27 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id fq32-20020a1709069da000b00770812e2394sm15392871ejc.160.2022.09.19.04.39.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 04:39:26 -0700 (PDT)
Message-ID: <5160c28f-03df-b1a7-d02a-3f567fde249b@redhat.com>
Date:   Mon, 19 Sep 2022 12:39:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v2 1/1] hp-wmi: Setting thermal profile fails with 0x06
Content-Language: en-US
To:     Jorge Lopez <jorgealtxwork@gmail.com>, balalic.enver@gmail.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     markgross@kernel.org
References: <20220912192603.4001-1-jorge.lopez2@hp.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220912192603.4001-1-jorge.lopez2@hp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/12/22 20:26, Jorge Lopez wrote:
> Error 0x06 (invalid command parameter) is reported by hp-wmi module
> when reading the current thermal profile and then proceed to set it
> back. The failing condition occurs in Linux NixOS after user
> configures the thermal profile to ‘quiet mode’ in Windows.  Quiet Fan
> Mode is supported in Windows but was not supported in hp-wmi module.
> 
> This fix adds support for PLATFORM_PROFILE_QUIET in hp-wmi module for
> HP notebooks other than HP Omen series.  Quiet thermal profile is not
> supported in HP Omen series notebooks.
> 
> Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>

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

> 
> ---
> Based on the latest platform-drivers-x86.git/for-next
> 
> Version 2 - Set bit (PROFILE_QUIET) only for non HP Omen Notebooks
> Version 1 - Original patch
> ---
>  drivers/platform/x86/hp-wmi.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
> index bc7020e9df9e..9a64601e217f 100644
> --- a/drivers/platform/x86/hp-wmi.c
> +++ b/drivers/platform/x86/hp-wmi.c
> @@ -177,7 +177,8 @@ enum hp_thermal_profile_omen_v1 {
>  enum hp_thermal_profile {
>  	HP_THERMAL_PROFILE_PERFORMANCE	= 0x00,
>  	HP_THERMAL_PROFILE_DEFAULT		= 0x01,
> -	HP_THERMAL_PROFILE_COOL			= 0x02
> +	HP_THERMAL_PROFILE_COOL			= 0x02,
> +	HP_THERMAL_PROFILE_QUIET		= 0x03,
>  };
>  
>  #define IS_HWBLOCKED(x) ((x & HPWMI_POWER_FW_OR_HW) != HPWMI_POWER_FW_OR_HW)
> @@ -1194,6 +1195,9 @@ static int hp_wmi_platform_profile_get(struct platform_profile_handler *pprof,
>  	case HP_THERMAL_PROFILE_COOL:
>  		*profile =  PLATFORM_PROFILE_COOL;
>  		break;
> +	case HP_THERMAL_PROFILE_QUIET:
> +		*profile = PLATFORM_PROFILE_QUIET;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -1216,6 +1220,10 @@ static int hp_wmi_platform_profile_set(struct platform_profile_handler *pprof,
>  	case PLATFORM_PROFILE_COOL:
>  		tp =  HP_THERMAL_PROFILE_COOL;
>  		break;
> +	case PLATFORM_PROFILE_QUIET:
> +		tp = HP_THERMAL_PROFILE_QUIET;
> +		break;
> +
>  	default:
>  		return -EOPNOTSUPP;
>  	}
> @@ -1263,6 +1271,8 @@ static int thermal_profile_setup(void)
>  
>  		platform_profile_handler.profile_get = hp_wmi_platform_profile_get;
>  		platform_profile_handler.profile_set = hp_wmi_platform_profile_set;
> +
> +		set_bit(PLATFORM_PROFILE_QUIET, platform_profile_handler.choices);
>  	}
>  
>  	set_bit(PLATFORM_PROFILE_COOL, platform_profile_handler.choices);

