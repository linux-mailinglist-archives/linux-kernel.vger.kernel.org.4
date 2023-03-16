Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12C96BD32E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 16:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjCPPPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 11:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjCPPPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:15:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4E55FEB7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 08:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678979673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rgNFu0HUYKtw8RWi6zJrI5fEIZ3MEylYsjpsor26NCE=;
        b=STaG/R6+0/xNbY06Wq8ZyPg+Rc/miyqFfvlChSqQfO3X4pt8KUVRYP0nrJes0APuppN8iw
        3qYSMn35sKbPgBUZB88f6YXToU1Ts8/Zfj5GAmYGoHI4KP/g2657LlPiFFbexzGVuM0gjx
        IaE+AcrHbD9WbxE7KvqViqGAsg/Z4/0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-ib6dwUyfOJqUdzt2k15iFQ-1; Thu, 16 Mar 2023 11:14:30 -0400
X-MC-Unique: ib6dwUyfOJqUdzt2k15iFQ-1
Received: by mail-ed1-f72.google.com with SMTP id w6-20020a05640234c600b004fc0e5b4433so3463628edc.18
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 08:14:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678979669;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rgNFu0HUYKtw8RWi6zJrI5fEIZ3MEylYsjpsor26NCE=;
        b=EW9gM+1ik80j//PJB7IN2uZU/5jzqf8XTj14+kusDbwFsrCWKV3Hu1aJV68L4dzbPp
         El2AOE7uSzMqDcNdbwYF8jBc4jvcgc/cyrjrOa6ySFCthZicvnY7IcXrAgkOYOou0VVX
         km39L6Wp+JyIB2t04aA3EmEkbqQX/sE+wM5E3oMG3a88Xm3P6JJW//aKnmrpR5EWHxZf
         T3o3tKqlGdRbsl0W2/KUG9btyRDLwP4JIIGnxlBK0uWuQJj7AF4IijGLkeQCYkOSIZAw
         jrUSg4o+/qCWAWw3NRtXqaAng14qFEj7mQ6our0s1+fVhhU+w+Ja1lyjXvqHKXginLTz
         6nCA==
X-Gm-Message-State: AO0yUKU7vLAtjc/F0zSCtBevjEP6jASkffZ+y4ddwKUdmtHVvpXcg6/F
        D3rYL0/ilBz0Rb+KFXtYLHHXURV8w7KzbQd6z4dwn835zk+8dP4ieWTJ8ccJ2VOvdEUJR8GizlA
        OuZaxIUuYBIMLxpuXNVdhIFQr
X-Received: by 2002:aa7:cd94:0:b0:4fb:de7d:b05a with SMTP id x20-20020aa7cd94000000b004fbde7db05amr5654685edv.40.1678979669844;
        Thu, 16 Mar 2023 08:14:29 -0700 (PDT)
X-Google-Smtp-Source: AK7set+XIgp7QXQ3ba0FT49wfaNVrxVtnOUdiaK2i2AZkhtOMIBtu2Us/b2gwSqe74sClFcf3ZR6EA==
X-Received: by 2002:aa7:cd94:0:b0:4fb:de7d:b05a with SMTP id x20-20020aa7cd94000000b004fbde7db05amr5654664edv.40.1678979669562;
        Thu, 16 Mar 2023 08:14:29 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id f16-20020a170906739000b008b1797b77b2sm3928248ejl.221.2023.03.16.08.14.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 08:14:29 -0700 (PDT)
Message-ID: <81eeac36-f80b-0f9f-2524-189d41b257a5@redhat.com>
Date:   Thu, 16 Mar 2023 16:14:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/3] platform: classmate: mark SPI related data as maybe
 unused
Content-Language: en-US, nl
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Gross <markgross@kernel.org>,
        Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>,
        Daniel Oliveira Nascimento <don@syst.com.br>,
        Mattia Dongili <malattia@linux.it>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230312132624.352703-1-krzysztof.kozlowski@linaro.org>
 <20230312132624.352703-2-krzysztof.kozlowski@linaro.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230312132624.352703-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/12/23 14:26, Krzysztof Kozlowski wrote:
> The driver can be compile tested as built-in making certain data unused:
> 
>   drivers/platform/x86/classmate-laptop.c:1137:36: error: ‘cmpc_device_ids’ defined but not used [-Werror=unused-const-variable=]
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thank you for your patch, I've applied this patch and patch 3/3
to my review-hans branch:
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
>  drivers/platform/x86/classmate-laptop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/classmate-laptop.c b/drivers/platform/x86/classmate-laptop.c
> index 8b6a14611859..2edaea2492df 100644
> --- a/drivers/platform/x86/classmate-laptop.c
> +++ b/drivers/platform/x86/classmate-laptop.c
> @@ -1134,7 +1134,7 @@ static void cmpc_exit(void)
>  module_init(cmpc_init);
>  module_exit(cmpc_exit);
>  
> -static const struct acpi_device_id cmpc_device_ids[] = {
> +static const struct acpi_device_id cmpc_device_ids[] __maybe_unused = {
>  	{CMPC_ACCEL_HID, 0},
>  	{CMPC_ACCEL_HID_V4, 0},
>  	{CMPC_TABLET_HID, 0},

