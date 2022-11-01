Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5DB614719
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 10:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiKAJpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 05:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiKAJpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 05:45:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4ECD2A8
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 02:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667295896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wN5Zj+HNDuVOWSv9ywqMHRuaX9Hk9EF12EEHKex5ah0=;
        b=JSCDNl4f093z8g4PpPJf4WRINWOY/USAXy+CMKHm8aiddZk+R1eWfrzzMFIjIzkTH5FQIG
        ADA5JvoSGNhBikGg6xcpdJCdFR4vWqSMNCDSph4zWyk2AChPuSRwIJwA38epNAxJFJljUp
        VqWb6EnzpfPC8+iUkW608jmR4tzY0Po=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-184-qqbjmbbIPnWa3iR0C64PtA-1; Tue, 01 Nov 2022 05:44:55 -0400
X-MC-Unique: qqbjmbbIPnWa3iR0C64PtA-1
Received: by mail-ed1-f71.google.com with SMTP id b14-20020a056402278e00b004621a2642d7so9538384ede.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 02:44:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wN5Zj+HNDuVOWSv9ywqMHRuaX9Hk9EF12EEHKex5ah0=;
        b=Yqa/cEdgu7VHSSuqrK7sK5t7HLs+I3CquOn3PqrGKL0ila2XPf8BBGvTZSrJOA1iCY
         BYhwtFCPTNlh7GWieBq63fGFc5Cp8IuOL+b3Qn3nU5Zd6DVxC1/Sjtu3fBFB+ZN1Icim
         unFJXFvZ0/NhCo/j0O1uM3UTGV8SdyVdx8I1ELmZo+gqelVJpmOGIOUZ0THJvTJa20CM
         LLBnTI8vXTcsOK2nRJnuDLc07T0e2LP/QYLtXK1aBEHiD+UjSFJlKY9I0pRJeU6a859X
         gW3jINgaqaQlN7ROK2BuI5ZpjZYdAHbIxHp2FfUkQhNqhsiLjQGSDPUD5o2jMjeyh8mK
         1ZIQ==
X-Gm-Message-State: ACrzQf2rLWTOhVwvHBvlB7N4SArjCo93iax4aaVF5gzy6QaASJxvWSNu
        chf/6Sno2mRiRUvJmoXt4JYZkqfLsk/dQ+soq11y0xUuFuCypIapShiA6jCCBnbLAM5jwab+Ql6
        InG+D9mY4Zp0Mar8Dqm1b1nAV
X-Received: by 2002:a05:6402:ca:b0:45c:dbdd:8143 with SMTP id i10-20020a05640200ca00b0045cdbdd8143mr18323987edu.213.1667295894212;
        Tue, 01 Nov 2022 02:44:54 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6W8LGaQhqVFAp7Uf71y2hx1hSIcKZvip/jquxYuBPWRaqCCMLgxmR1eXQ2UKJd1jbb2POc5g==
X-Received: by 2002:a05:6402:ca:b0:45c:dbdd:8143 with SMTP id i10-20020a05640200ca00b0045cdbdd8143mr18323975edu.213.1667295894009;
        Tue, 01 Nov 2022 02:44:54 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id 26-20020a170906311a00b0079800b8173asm3993677ejx.158.2022.11.01.02.44.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 02:44:53 -0700 (PDT)
Message-ID: <6593b620-9db5-3020-1817-c3a9ca839803@redhat.com>
Date:   Tue, 1 Nov 2022 10:44:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] mfd: intel_soc_pmic: allow COMPILE_TEST or
 I2C_DESIGNWARE_PLATFORM
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Lee Jones <lee@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20221101055433.16891-1-rdunlap@infradead.org>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221101055433.16891-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/1/22 06:54, Randy Dunlap wrote:
> Linus expressed a desire to have intel_soc_pmic_crc.o (INTEL_SOC_PMIC,
> for Crystal Cove) be built on an "allmodconfig" build, when
> I2C_DESIGNWARE_PLATFORM=m, to enhance build test coverage.
> 
> The PMIC driver won't work in this case since it requires
> I2C_DESIGNWARE_PLATFORM=y to operate properly, but adding
> "|| COMPILE_TEST" does improve the build test coverage.
> 
> Link: https://lore.kernel.org/all/CAHk-=wg=hh8xkPjiySnjAyR66AG64eyZ1Y9gHw+MCs8uuSZReA@mail.gmail.com/
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/mfd/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -- a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -603,7 +603,7 @@ config INTEL_SOC_PMIC
>  	bool "Support for Crystal Cove PMIC"
>  	depends on HAS_IOMEM && I2C=y && GPIOLIB && COMMON_CLK
>  	depends on (X86 && ACPI) || COMPILE_TEST
> -	depends on I2C_DESIGNWARE_PLATFORM=y
> +	depends on I2C_DESIGNWARE_PLATFORM=y || COMPILE_TEST
>  	select MFD_CORE
>  	select REGMAP_I2C
>  	select REGMAP_IRQ
> 

