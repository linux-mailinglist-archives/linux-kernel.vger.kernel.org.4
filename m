Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C3A680F19
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 14:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236195AbjA3Nfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 08:35:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233646AbjA3Nfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 08:35:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5714126E0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 05:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675085694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wBidcN355LgGDZ/WwxPjWGavaMBTZvOjDpvFtA2pY6Q=;
        b=Z3Geplrag4iAzCqmwXfqtx/X7F8kZ+KOL1amOFAYQ967RER3p0bgd6Zaf90EhYz1wBcoC1
        8k6G+PCQABZhl14zDbPAa2xG2oXVtt/Fj2gGha97aK4dmbUdaegUZQ5KffGJJu2aIz8AJQ
        hCEiy/8B6cJW9AxmXbIIJEelRvZO8/k=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-81-q5zBWIXVMYe_VVdOFm8K1g-1; Mon, 30 Jan 2023 08:34:52 -0500
X-MC-Unique: q5zBWIXVMYe_VVdOFm8K1g-1
Received: by mail-ed1-f70.google.com with SMTP id y20-20020a056402271400b0046c9a6ec30fso8199098edd.14
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 05:34:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wBidcN355LgGDZ/WwxPjWGavaMBTZvOjDpvFtA2pY6Q=;
        b=O6vuOomIdyToGsECgOP9glEBQogEb3LkIGJPhle09hvuH9B6ZrzvJridk5Z4vxB7Fn
         ZhWd8DSljohHnktIedvltG7CjuC3Z9Njaf9jMSktE/zTjnGUny5NI1fKpe6BmU9kzvR2
         gyP93R2euG3K5AUxsx3CeJR3gWaZp/PMzCvdDKuP4yqFk7+xeFryvlncywK7um8mOy0h
         vikVT+rP27CwD8vIqqsjy9FIk/EN4ThQAoIvqx7R/G0HVXSSDpQxf892awiCOPA1qwma
         DPWMXSJAiJEVnOF9gmQHneP6WqopcTdSq6TWCtfgbaOzPrw4Ewotc9PxJVFUfeVdUa/3
         9xlQ==
X-Gm-Message-State: AO0yUKUO3jUjvbWVFO03z8qx+WZGDz9wxSnqubWgvpsvw8OodVlxbtls
        qX2Vza5x6CJBmPeJ+XkJuwURwCaEAyM4iJUvaM9OHazZkRy68gqdd5cLmRTTE0A4cNFqILIFxUW
        mfY8y1PqCiYknVhci+dYqb/3t
X-Received: by 2002:a17:906:8a5a:b0:88a:724:244c with SMTP id gx26-20020a1709068a5a00b0088a0724244cmr1572498ejc.71.1675085691492;
        Mon, 30 Jan 2023 05:34:51 -0800 (PST)
X-Google-Smtp-Source: AK7set+KI7swegxN8oLc8yfJgEQ5MDl6ktQBCiOdmdqynjEQDkJCyWdaqwGw/rB7CesS+aZutIFmfA==
X-Received: by 2002:a17:906:8a5a:b0:88a:724:244c with SMTP id gx26-20020a1709068a5a00b0088a0724244cmr1572488ejc.71.1675085691283;
        Mon, 30 Jan 2023 05:34:51 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id fy15-20020a1709069f0f00b0084c62b7b7d8sm6806766ejc.187.2023.01.30.05.34.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 05:34:50 -0800 (PST)
Message-ID: <4f5e1fc2-ab18-30f7-b0d5-5b99be7a1a67@redhat.com>
Date:   Mon, 30 Jan 2023 14:34:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] platform/x86/amd: pmc: add CONFIG_SERIO dependency
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>, Mark Gross <markgross@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Naveen Krishna Chatradhi <NaveenKrishna.Chatradhi@amd.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230127093950.2368575-1-arnd@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230127093950.2368575-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/27/23 10:39, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Using the serio subsystem now requires the code to be reachable:
> 
> x86_64-linux-ld: drivers/platform/x86/amd/pmc.o: in function `amd_pmc_suspend_handler':
> pmc.c:(.text+0x86c): undefined reference to `serio_bus'
> 
> Add the usual dependency: as other users of serio use 'select'
> rather than 'depends on', use the same here.
> 
> Fixes: 8e60615e8932 ("platform/x86/amd: pmc: Disable IRQ1 wakeup for RN/CZN")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

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
>  drivers/platform/x86/amd/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/amd/Kconfig b/drivers/platform/x86/amd/Kconfig
> index a825af8126c8..2ce8cb2170df 100644
> --- a/drivers/platform/x86/amd/Kconfig
> +++ b/drivers/platform/x86/amd/Kconfig
> @@ -8,6 +8,7 @@ source "drivers/platform/x86/amd/pmf/Kconfig"
>  config AMD_PMC
>  	tristate "AMD SoC PMC driver"
>  	depends on ACPI && PCI && RTC_CLASS
> +	select SERIO
>  	help
>  	  The driver provides support for AMD Power Management Controller
>  	  primarily responsible for S2Idle transactions that are driven from

