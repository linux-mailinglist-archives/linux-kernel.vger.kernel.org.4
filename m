Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C60B62A315
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 21:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiKOUhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 15:37:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbiKOUhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 15:37:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0051529815
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 12:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668544433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VVhrvYGZTZ9CuRZyU7m2CWqpbNzAXMXlYEZ9jNaCYQQ=;
        b=gtrDOw5obo6hRELqOadyYoh9zPAies91O2xsxjetyffGPSeLiMhqLDo4B8nWFYt2gDZM5S
        9yW5uDJU2TxKXoDmcLgHpWuw9gC07lGIVWwMgzEuUeDvUDkOSdRF2fjJg+qL+PiBIBzlqX
        jJP6sUU1X3twbgQx93KXMgBRbibboNk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-493-2heebNqUNbSec913sRAbNQ-1; Tue, 15 Nov 2022 15:33:51 -0500
X-MC-Unique: 2heebNqUNbSec913sRAbNQ-1
Received: by mail-ej1-f72.google.com with SMTP id sc40-20020a1709078a2800b007ae024e5e82so8134089ejc.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 12:33:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VVhrvYGZTZ9CuRZyU7m2CWqpbNzAXMXlYEZ9jNaCYQQ=;
        b=zYFJUPD0My4WMAMRxvy/ki8a8TBfoYRb8YYEDjvdXwZmnkwWOdELCTM79wOTZVCCZ6
         N/s5jHIBd1CSZynEB+ulbTw8+DA473G+i2fjXmOOxeIm24rPkLrGnXcYHc/5aJc7ghef
         idceWdMpDkA0umfhxhaZYwry1SZWbsAWBDA/xEWcfwv2lI405B2iwANxkD8M9TzENVns
         ymBAUVZbE1wR06dxvYolgS90Xpg7rMToNxa+5UmMhZMzavAJswTgcTqrCWaGazdPfDIe
         dQjrfas11LSdzxKpO0FSUOJnOQRkVQLMbdBPNyhWUmEJ4CqCu5/tbPc/YuKtVaiUbFir
         yWKQ==
X-Gm-Message-State: ANoB5pn8FIkDehU/910MopU79fv6UCf30cWJkngp1l3yzxKa2rflytuQ
        Xf9+KHLy+GWm81NFPzjdJ83/qRdgfiS0M1xHlGLFwKWvcW5o4ytroxP8Cs9TQOb5Qmy5bkW91EN
        J2Ygl1bqBBLjZ9Ihlfon9lDBG
X-Received: by 2002:a17:907:80c5:b0:7ad:f43a:cb07 with SMTP id io5-20020a17090780c500b007adf43acb07mr14926776ejc.562.1668544430560;
        Tue, 15 Nov 2022 12:33:50 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4S4colGM0tju7JziGafsLeOa86LQ77NWGN8k/GwvIPubzSP+mStQZmQY2YAMgEPilGOieF/A==
X-Received: by 2002:a17:907:80c5:b0:7ad:f43a:cb07 with SMTP id io5-20020a17090780c500b007adf43acb07mr14926761ejc.562.1668544430383;
        Tue, 15 Nov 2022 12:33:50 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id z4-20020a1709063ac400b007acd04fcedcsm5968943ejd.46.2022.11.15.12.33.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 12:33:49 -0800 (PST)
Message-ID: <4f6e561b-12d7-0163-5f26-05d47a72d6cb@redhat.com>
Date:   Tue, 15 Nov 2022 21:33:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 2/7] HID: add mapping for camera access keys
Content-Language: en-US, nl
To:     =?UTF-8?Q?Eray_Or=c3=a7unus?= <erayorcunus@gmail.com>,
        platform-driver-x86@vger.kernel.org, dmitry.torokhov@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        ike.pan@canonical.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, mgross@linux.intel.com,
        pobrn@protonmail.com
References: <20221029120311.11152-1-erayorcunus@gmail.com>
 <20221029120311.11152-3-erayorcunus@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221029120311.11152-3-erayorcunus@gmail.com>
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

Hi Dmitry,

On 10/29/22 14:03, Eray Orçunus wrote:
> HUTRR72 added 3 new usage codes for keys that are supposed to enable,
> disable and toggle camera access. These are useful, considering many
> laptops today have key(s) for toggling access to camera.
> 
> This patch adds new key definitions for KEY_CAMERA_ACCESS_ENABLE,
> KEY_CAMERA_ACCESS_DISABLE and KEY_CAMERA_ACCESS_TOGGLE. Additionally
> hid-debug is adjusted to recognize this new usage codes as well.
> 
> Signed-off-by: Eray Orçunus <erayorcunus@gmail.com>
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

I have rejected the drivers/platform/x86 patch which depends
on this, because it changes current behavior, potentially
breaking userspace.

Since this means I won't be taking any patches depending on
this I believe it is best if this is merged through the input tree.

Note this also has a:

Acked-by: Jiri Kosina <jkosina@suse.cz>

tag given in this email thread.

Regards,

Hans





> ---
>  drivers/hid/hid-debug.c                | 3 +++
>  drivers/hid/hid-input.c                | 3 +++
>  include/uapi/linux/input-event-codes.h | 3 +++
>  3 files changed, 9 insertions(+)
> 
> diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
> index f48d3534e020..991f880fdbd4 100644
> --- a/drivers/hid/hid-debug.c
> +++ b/drivers/hid/hid-debug.c
> @@ -936,6 +936,9 @@ static const char *keys[KEY_MAX + 1] = {
>  	[KEY_ASSISTANT] = "Assistant",
>  	[KEY_KBD_LAYOUT_NEXT] = "KbdLayoutNext",
>  	[KEY_EMOJI_PICKER] = "EmojiPicker",
> +	[KEY_CAMERA_ACCESS_ENABLE] = "CameraAccessEnable",
> +	[KEY_CAMERA_ACCESS_DISABLE] = "CameraAccessDisable",
> +	[KEY_CAMERA_ACCESS_TOGGLE] = "CameraAccessToggle",
>  	[KEY_DICTATE] = "Dictate",
>  	[KEY_BRIGHTNESS_MIN] = "BrightnessMin",
>  	[KEY_BRIGHTNESS_MAX] = "BrightnessMax",
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index f197aed6444a..f8e6513e77b8 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -995,6 +995,9 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
>  		case 0x0cd: map_key_clear(KEY_PLAYPAUSE);	break;
>  		case 0x0cf: map_key_clear(KEY_VOICECOMMAND);	break;
>  
> +		case 0x0d5: map_key_clear(KEY_CAMERA_ACCESS_ENABLE);		break;
> +		case 0x0d6: map_key_clear(KEY_CAMERA_ACCESS_DISABLE);		break;
> +		case 0x0d7: map_key_clear(KEY_CAMERA_ACCESS_TOGGLE);		break;
>  		case 0x0d8: map_key_clear(KEY_DICTATE);		break;
>  		case 0x0d9: map_key_clear(KEY_EMOJI_PICKER);	break;
>  
> diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
> index 7989d9483ea7..ef392d0f943f 100644
> --- a/include/uapi/linux/input-event-codes.h
> +++ b/include/uapi/linux/input-event-codes.h
> @@ -614,6 +614,9 @@
>  #define KEY_KBD_LAYOUT_NEXT	0x248	/* AC Next Keyboard Layout Select */
>  #define KEY_EMOJI_PICKER	0x249	/* Show/hide emoji picker (HUTRR101) */
>  #define KEY_DICTATE		0x24a	/* Start or Stop Voice Dictation Session (HUTRR99) */
> +#define KEY_CAMERA_ACCESS_ENABLE	0x24b	/* Enables programmatic access to camera devices. (HUTRR72) */
> +#define KEY_CAMERA_ACCESS_DISABLE	0x24c	/* Disables programmatic access to camera devices. (HUTRR72) */
> +#define KEY_CAMERA_ACCESS_TOGGLE	0x24d	/* Toggles the current state of the camera access control. (HUTRR72) */
>  
>  #define KEY_BRIGHTNESS_MIN		0x250	/* Set Brightness to Minimum */
>  #define KEY_BRIGHTNESS_MAX		0x251	/* Set Brightness to Maximum */

