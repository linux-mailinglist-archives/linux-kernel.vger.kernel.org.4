Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44D16ABD98
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 12:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjCFLBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 06:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjCFLBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 06:01:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC3125E15
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 03:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678100452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j/uyFRnZOVBleK7HwqPlNsmqQb5QIuiDIm33dv9xHSE=;
        b=WnQB64llvS5lKKESffSnS3dtAdLq57dFWfs7iJwE/d+nR6/0ZvT5s045maoCwwZXyyIkFw
        iEO2bcFrLF4K9FmDt+KC2jTwWGwiUwSKoxc3weQsWTPa59FilD6UqwIjEa5EQHm8sBPS/a
        B6YNP/pfNjtJLc5IiDjVaNn3O291LqU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-c6g544tDNCWlxzQskArW9w-1; Mon, 06 Mar 2023 06:00:51 -0500
X-MC-Unique: c6g544tDNCWlxzQskArW9w-1
Received: by mail-ed1-f71.google.com with SMTP id b1-20020aa7dc01000000b004ad062fee5eso13092150edu.17
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 03:00:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678100449;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j/uyFRnZOVBleK7HwqPlNsmqQb5QIuiDIm33dv9xHSE=;
        b=mRZZRA1iiGmk3XN4yZSAjtHEiPQfW/5TAb48ISSgE+iy1bCj6t54+O8DzAhi2E3OA9
         JScVzx8hN+GVh1SXiIkDNqyefnzaN7J3JL2YeacNXTuWrteR6+Y07D3XnyelJnJ2RHML
         19/7qSaU48UbVHLuVuMVGePVHuRrhgsYhc8au67hj6gAwspM1XHjRxDDlaf09Xx2rxD+
         iLjqICj0+30URMIdzVmk3+Ug+fYPHeLKf5k0wgN/RuKCeYGJHdSu9TXsGM0Bkmx0hVWf
         3BFvjpeiD+0D4hQGlIPtwAfnD7PXnuX1nLUk43p/eYEGtlgspgdVY2tS4ancZAsHknns
         w3Yg==
X-Gm-Message-State: AO0yUKUn5FW3Ijn6ZKBICmpcKqMuoT9dqNpE+7EgVk9sjup/n1eKlU9v
        TiulwE0w6wD0lmQqBPhGiSs+/8cNClCzY6EbTxd/pEkkWJsJosL37vLrIxJw8VWFZhOtG8xopQM
        U/Eo7JWOc4B8csOJzApVDOjUt
X-Received: by 2002:a17:907:6ea6:b0:8b1:7dea:cc40 with SMTP id sh38-20020a1709076ea600b008b17deacc40mr12709314ejc.9.1678100448991;
        Mon, 06 Mar 2023 03:00:48 -0800 (PST)
X-Google-Smtp-Source: AK7set9+1CRyeY7/ASMYi2TUCACaO7zSdQk1yMY1jvi+dDmM/fOhWfEDMBgL9KNpItYfajL0Mw/62Q==
X-Received: by 2002:a17:907:6ea6:b0:8b1:7dea:cc40 with SMTP id sh38-20020a1709076ea600b008b17deacc40mr12709294ejc.9.1678100448758;
        Mon, 06 Mar 2023 03:00:48 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id f5-20020a170906390500b008c0b8dd4cbdsm4415232eje.112.2023.03.06.03.00.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 03:00:48 -0800 (PST)
Message-ID: <e8f5e2aa-d7fa-88ff-6306-4c1ee8feeade@redhat.com>
Date:   Mon, 6 Mar 2023 12:00:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] Input: i8042 - Add quirk for Fujitsu Lifebook A574/H
Content-Language: en-US
To:     Jonathan Denose <jdenose@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Denose <jdenose@google.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Takashi Iwai <tiwai@suse.de>,
        Werner Sembach <wse@tuxedocomputers.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-input@vger.kernel.org
References: <20230303152623.45859-1-jdenose@google.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230303152623.45859-1-jdenose@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 3/3/23 16:26, Jonathan Denose wrote:
> Fujitsu Lifebook A574/H requires the nomux option to properly
> probe the touchpad, especially when waking from sleep.
> 
> Signed-off-by: Jonathan Denose <jdenose@google.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
> 
>  drivers/input/serio/i8042-acpipnpio.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/input/serio/i8042-acpipnpio.h b/drivers/input/serio/i8042-acpipnpio.h
> index efc61736099b..fe7ffe30997c 100644
> --- a/drivers/input/serio/i8042-acpipnpio.h
> +++ b/drivers/input/serio/i8042-acpipnpio.h
> @@ -610,6 +610,14 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
>  		},
>  		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
>  	},
> +	{
> +		/* Fujitsu Lifebook A574/H */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "FMVA0501PZ"),
> +		},
> +		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
> +	},
>  	{
>  		/* Gigabyte M912 */
>  		.matches = {

