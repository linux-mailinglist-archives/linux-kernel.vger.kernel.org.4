Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152C16A6A5B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 11:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjCAKC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 05:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjCAKCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 05:02:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8416F1BAED
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 02:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677664925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+CmpZYgS8cyJAY4aGQ2XeT6FRJGQsQto3CcSnsJTEbk=;
        b=EJtVAGCtqDvSOI4E9miOwa8Ir09pOIIkTRBYVEOMFI769FfhowowlIQO4lWXNcFaS35yKO
        bldjFfn7slizlLGwInsJNSryzfGvQi2nrwstep+mZMKV/Kn+ISueT+tRljVT78tzt8GCLy
        EpX5AvJqhafO+rCoGvsAqrOw1m9F7A0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-349-cMWcrBDwMnOaJnQcrx7vMw-1; Wed, 01 Mar 2023 05:02:04 -0500
X-MC-Unique: cMWcrBDwMnOaJnQcrx7vMw-1
Received: by mail-ed1-f70.google.com with SMTP id w11-20020a05640234cb00b004b3247589b3so15794626edc.23
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 02:02:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+CmpZYgS8cyJAY4aGQ2XeT6FRJGQsQto3CcSnsJTEbk=;
        b=5KaPUPSUIe2lOFsLVZ3m8Vlit6qpZbXrexi+HdcmPtvJyH89tGCSCXKl/Yiu67GHSa
         urk8Bsp95I+Ti2D5t9dIQPx/u8EzluPOSPUX1T+/tSJ1+Q6gB10R+TTQcDJOGps8eor7
         hUv8fmlNXOKUrbsliPdKEXJMhbkyUGclCLXQK9c+qt5PlFxiXLsAwooI7a+qly2DOkvI
         yP5rrfg6J9c/GUTecm48NNTBlB79x8IkSAXkkgI4M1tEUFJejg37KW4EXvV3o67+CsMn
         1twRZZpIxrqOvBTSd5NQ5cSSvC+oaZiIMVQgkbPj0wNZzlPCNZ7b5QLrwoI4CvhYA909
         kG7w==
X-Gm-Message-State: AO0yUKVypbLqHyNrCUlL8BbnmNCR1Moxh0o7JPr9a0keWBPXUTKoaRZN
        ik9NXJqlnT52tp5aQmO/L7ghjsgiPUIL+vPGpWk4Jmz1euE1XDVMvUikFY93IkoxXgT9aFHyJRz
        sXwAVuTgmevpU05iZ8aJah/hInYhCNA==
X-Received: by 2002:aa7:c943:0:b0:4af:60c1:1961 with SMTP id h3-20020aa7c943000000b004af60c11961mr6992453edt.23.1677664923206;
        Wed, 01 Mar 2023 02:02:03 -0800 (PST)
X-Google-Smtp-Source: AK7set/GggeBAGZhLUiKkJSJWW7waawi9RJEmyLbnrOGLTTGiOrYg+18cbbXLXxev7s49Vb6IDIhVQ==
X-Received: by 2002:aa7:c943:0:b0:4af:60c1:1961 with SMTP id h3-20020aa7c943000000b004af60c11961mr6992435edt.23.1677664922944;
        Wed, 01 Mar 2023 02:02:02 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id h11-20020a50c38b000000b004bc9d44478fsm385501edf.51.2023.03.01.02.02.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 02:02:02 -0800 (PST)
Message-ID: <00ac121d-9b32-de8f-9f33-6440cd446ac4@redhat.com>
Date:   Wed, 1 Mar 2023 11:02:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/3] mfd: intel_soc_pmic_chtwc: Add Lenovo Yoga Book X90F
 to intel_cht_wc_models
To:     Andy Shevchenko <andy@kernel.org>, Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org
References: <20230301095402.28582-1-hdegoede@redhat.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230301095402.28582-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Note this is not [patch 2/3] that was a mistake from my side, this is
a standalone patch.

Regards,

Hans

On 3/1/23 10:54, Hans de Goede wrote:
> The Android Lenovo Yoga Book X90F / X90L uses the same charger / fuelgauge
> setup as the already supported Windows Lenovo Yoga Book X91F/L, add
> a DMI match for this to intel_cht_wc_models with driver_data
> set to INTEL_CHT_WC_LENOVO_YOGABOOK1.
> 
> When the quirk for the X91F/L was initially added it was written to
> also apply to the X90F/L but this does not work because the Android
> version of the Yoga Book uses completely different DMI strings.
> Also adjust the X91F/L quirk to reflect that it only applies to
> the X91F/L models.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/mfd/intel_soc_pmic_chtwc.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mfd/intel_soc_pmic_chtwc.c b/drivers/mfd/intel_soc_pmic_chtwc.c
> index d53dae255490..871776d511e3 100644
> --- a/drivers/mfd/intel_soc_pmic_chtwc.c
> +++ b/drivers/mfd/intel_soc_pmic_chtwc.c
> @@ -159,11 +159,19 @@ static const struct dmi_system_id cht_wc_model_dmi_ids[] = {
>  			DMI_MATCH(DMI_PRODUCT_NAME, "Mipad2"),
>  		},
>  	}, {
> -		/* Lenovo Yoga Book X90F / X91F / X91L */
> +		/* Lenovo Yoga Book X90F / X90L */
>  		.driver_data = (void *)(long)INTEL_CHT_WC_LENOVO_YOGABOOK1,
>  		.matches = {
> -			/* Non exact match to match all versions */
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Lenovo YB1-X9"),
> +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "CHERRYVIEW D1 PLATFORM"),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "YETI-11"),
> +		},
> +	}, {
> +		/* Lenovo Yoga Book X91F / X91L */
> +		.driver_data = (void *)(long)INTEL_CHT_WC_LENOVO_YOGABOOK1,
> +		.matches = {
> +			/* Non exact match to match F + L versions */
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Lenovo YB1-X91"),
>  		},
>  	}, {
>  		/* Lenovo Yoga Tab 3 Pro YT3-X90F */

