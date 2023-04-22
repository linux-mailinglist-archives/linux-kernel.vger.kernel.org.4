Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03AB26EBAB5
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 19:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjDVRat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 13:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjDVRao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 13:30:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9672B211E
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 10:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682184593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Whc1PiL8cvCrwQXfR2j4EkLjnYvdXwSxmXSEz6X/dk=;
        b=NC8FX9cARPe5dub4NXsC9EKmIx23Q1uqDYtenSYDbbhRwQzeHY4ukLjoYYkIx3HlRgNNjc
        pl6Yjy6EbZcMnGEg/28wybmJW/fMnp93ZeVrlYtYtUK4fwPiwvdJUI1vefgjyjjo+jm//8
        xqv489U83zbe0u3OD6upFX7jQfIwOd4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-_lWhMZWGMraENTAqy75WIw-1; Sat, 22 Apr 2023 13:29:46 -0400
X-MC-Unique: _lWhMZWGMraENTAqy75WIw-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5067d65c251so2621444a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 10:29:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682184585; x=1684776585;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Whc1PiL8cvCrwQXfR2j4EkLjnYvdXwSxmXSEz6X/dk=;
        b=Onuwo10f+pHAdWQCD/xPFD2/bs53mAgReT/Gwqg+gfmjZpGUBhnw025UE8FMwgyHUr
         QZNOwVHue0h3c313HDdClQSP/EOC/JPjb44nZOd3K+112sYAlQlo2vtE9u6Ia4RCdHZe
         9mniZHxPeNao2PjCo8PRBe4KXLX3++SGm9Bgb3AxO9ReNXr0xlaxnAXzuaJseppaYe9a
         YA7wR+aHCTp7vBnidNXeILX+KjxQUbmiBC8ECVbubUj+qrvFcJEbF+MdUFyqNPBoI1Iz
         jZpoFerizuG9fi2VQ4CbQIm5uy7/hKK+u16z3PPn1gu9y7Yu/IKED1CoBxUiZKUaGhrP
         kjcg==
X-Gm-Message-State: AAQBX9f4W+zWei2Oa6q5ahYV54w14u7ldt3J44aHYnTMoGnh+U/VpBNF
        U8AzH7Tb21RsL1cuR3tFOydlJMdXBNpC2RmFlb3B0Kc5Gthz+86xs19aurjlzbzF49zszgI13Dw
        4oXatHzZJl2P320tsQTPE7iwO
X-Received: by 2002:a17:906:c784:b0:94e:23b:75e9 with SMTP id cw4-20020a170906c78400b0094e023b75e9mr5850087ejb.43.1682184585506;
        Sat, 22 Apr 2023 10:29:45 -0700 (PDT)
X-Google-Smtp-Source: AKy350bfxC5TrRKzuNYFzFcfcAlfJa3Anku1Neu32ewCdS//eMbcwm/KNtEl+o7e4DvFbZXBE/SxQw==
X-Received: by 2002:a17:906:c784:b0:94e:23b:75e9 with SMTP id cw4-20020a170906c78400b0094e023b75e9mr5850083ejb.43.1682184585208;
        Sat, 22 Apr 2023 10:29:45 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id bj10-20020a170906b04a00b0094f5f6ba306sm3488679ejb.41.2023.04.22.10.29.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Apr 2023 10:29:44 -0700 (PDT)
Message-ID: <5ff4416c-a195-7ac7-9eb1-16d667fd3ad6@redhat.com>
Date:   Sat, 22 Apr 2023 19:29:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] ACPI: x86: utils: Remove Lenovo Yoga Tablet 2's MAGN0001
To:     Marius Hoch <mail@mariushoch.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230422164401.5986-1-mail@mariushoch.de>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230422164401.5986-1-mail@mariushoch.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/22/23 18:44, Marius Hoch wrote:
> The LSM303D on the Lenovo Yoga Tablet 2 series is present
> as both ACCL0001 and MAGN0001. As we can only ever register an
> i2c client for one of them, ignore MAGN0001.
> 
> Currently this errors:
> i2c i2c-4: Failed to register i2c client MAGN0001:00 at 0x1d (-16)
> 
> Tested on a Lenovo Yoga Tablet 2 1051-F.
> 
> Signed-off-by: Marius Hoch <mail@mariushoch.de>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/acpi/x86/utils.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
> index ba420a28a4aa..9c2d6f35f88a 100644
> --- a/drivers/acpi/x86/utils.c
> +++ b/drivers/acpi/x86/utils.c
> @@ -143,6 +143,16 @@ static const struct override_status_id override_status_ids[] = {
>  		DMI_EXACT_MATCH(DMI_BOARD_SERIAL, "Default string"),
>  		DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Default string"),
>  	      }),
> +
> +	/*
> +	 * The LSM303D on the Lenovo Yoga Tablet 2 series is present
> +	 * as both ACCL0001 and MAGN0001. As we can only ever register an
> +	 * i2c client for one of them, ignore MAGN0001.
> +	 */
> +	NOT_PRESENT_ENTRY_HID("MAGN0001", "1", ATOM_SILVERMONT, {
> +		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +		DMI_MATCH(DMI_PRODUCT_FAMILY, "YOGATablet2"),
> +	      }),
>  };
>  
>  bool acpi_device_override_status(struct acpi_device *adev, unsigned long long *status)

