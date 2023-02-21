Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437E869DC4A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 09:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbjBUImR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 03:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233236AbjBUIlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 03:41:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1521E284
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 00:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676968854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xXB0QqcA/xnbVHMNJUF4fAMOxD/knIqAfT0ePxSyKdM=;
        b=bAVPM7XVDOhXp3CITtgVcxF9pDDrq6G0Vb/C0HHaEQlDW8R5y5NCo3+wom+FYpg9gmf/+r
        6ICzDCoY85rMykB7jtuifV/HHQbAU36sgG+xIiESEETcQkbguSkK0MdbBr7L9gRhad/s7v
        K41vaZ7F4Ji8LqXwfcunf8P2lbLoOeg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-517-9Ui3glkvNlOeRZZ4vke0tQ-1; Tue, 21 Feb 2023 03:40:53 -0500
X-MC-Unique: 9Ui3glkvNlOeRZZ4vke0tQ-1
Received: by mail-ed1-f71.google.com with SMTP id cf11-20020a0564020b8b00b0049ec3a108beso4816642edb.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 00:40:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xXB0QqcA/xnbVHMNJUF4fAMOxD/knIqAfT0ePxSyKdM=;
        b=baaa4VDppnNxcX7HXBXQKQQQPv2JmiqJZ+2mtwmpPuaDwhxQVMwffIp5maULp5zQo+
         pzRjA21yUnAIn5kAwjaZyRa01Uxvf2W/plS4kRTdbfdz24cWrPXIdKdZQ87IjS6RjF26
         Dasi/FEXAb3H1cyub7WRZtJJxxtDCGquewBqVEjNsDJQBXvmarui2KAobvShoOfHUr/i
         IMabyY4I4rH/hbpZ44E+Rzb4K4yqfqzsHG4v5uZKJnbnHx2rwJk6u9la5AT6hLTlwL4V
         tVy+UoXl8WgQUlRG8lIux3PIe3zgQQtWKa095XzVx23cKGosp22eDW7S5KwT1ls23sXo
         YzJw==
X-Gm-Message-State: AO0yUKX0GYK4V8Qe5/+iDoIH8Z9cXI7cbD4uxEVPCdvTOvjyRBNpq8gL
        8DcNua1FVBX7x8EXYNztgufZuGjvO3/98+a4G2AVlaGkfd8p6zqiqLKNemtMpOgPEgSU0Ghc22A
        p68oez609yWFrsjSotUmGCoRZ
X-Received: by 2002:a05:6402:115a:b0:4ad:5220:79f0 with SMTP id g26-20020a056402115a00b004ad522079f0mr3434342edw.5.1676968851180;
        Tue, 21 Feb 2023 00:40:51 -0800 (PST)
X-Google-Smtp-Source: AK7set97fa+DxWfBZ3M2//mYdiUimfAg1GVrgdeq4FW2cI/iJAnXF+aAlhWP8k8/whF+2pquPCIPSA==
X-Received: by 2002:a05:6402:115a:b0:4ad:5220:79f0 with SMTP id g26-20020a056402115a00b004ad522079f0mr3434323edw.5.1676968850900;
        Tue, 21 Feb 2023 00:40:50 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id c14-20020a50d64e000000b004a249a97d84sm2008282edj.23.2023.02.21.00.40.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 00:40:50 -0800 (PST)
Message-ID: <0e2b5e9d-d68f-59dd-6e9c-b5cdabc086c2@redhat.com>
Date:   Tue, 21 Feb 2023 09:40:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] Fix strange behavior of touchpad on Clevo NS70PU
To:     Werner Sembach <wse@tuxedocomputers.com>,
        dmitry.torokhov@gmail.com, mkorpershoek@baylibre.com,
        chenhuacai@kernel.org, tiwai@suse.de,
        wsa+renesas@sang-engineering.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230220183014.238432-1-wse@tuxedocomputers.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230220183014.238432-1-wse@tuxedocomputers.com>
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

On 2/20/23 19:30, Werner Sembach wrote:
> When closing the laptop lid with an external screen connected, the mouse
> pointer has a constant movement to the lower right corner. Opening the
> lid again stops this movement, but after that the touchpad does no longer
> register clicks.
> 
> The touchpad is connected both via i2c-hid and PS/2, the predecessor of
> this device (NS70MU) has the same layout in this regard and also strange
> behaviour caused by the psmouse and the i2c-hid driver fighting over
> touchpad control. This fix is reusing the same workaround by just
> disabling the PS/2 aux port, that is only used by the touchpad, to give the
> i2c-hid driver the lone control over the touchpad.
> 
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Cc: stable@vger.kernel.org

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/input/serio/i8042-acpipnpio.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/input/serio/i8042-acpipnpio.h b/drivers/input/serio/i8042-acpipnpio.h
> index efc61736099b9..3a6640a11dd99 100644
> --- a/drivers/input/serio/i8042-acpipnpio.h
> +++ b/drivers/input/serio/i8042-acpipnpio.h
> @@ -1156,6 +1156,12 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
>  					SERIO_QUIRK_RESET_ALWAYS | SERIO_QUIRK_NOLOOP |
>  					SERIO_QUIRK_NOPNP)
>  	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "NS5x_7xPU"),
> +		},
> +		.driver_data = (void *)(SERIO_QUIRK_NOAUX)
> +	},
>  	{
>  		.matches = {
>  			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),

