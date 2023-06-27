Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975BA740243
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 19:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjF0RfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 13:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjF0RfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 13:35:18 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA2C26BC;
        Tue, 27 Jun 2023 10:35:17 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b8063aa2e1so15197085ad.1;
        Tue, 27 Jun 2023 10:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687887316; x=1690479316;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DErWY5bdlKQCL//WmeXr10V4jZWPluRiVB2lnX+rujc=;
        b=mZMNmRiDHPzwczy14YHFEWN/K65Z5d0lqh1AJtn6QPvZk6mWJRaZAopuVyoDuwBRsd
         S6rwWpbGLn34fUZcXTKjVl0VYBPyqrkdaME7LiX5Oys51enRGnZME6FZvD6E5+5MWCIE
         Jrx29LLOd0CeMa5ZVzctI9+ZiaPFyT5nvNiKws/fCF14jpazezTEoor8olhvKCSeY2LF
         wpvNhvzNIe/ntytLxE1bOtlEws/Ol7waUrEgX1LP6G503hPuJA++RWmmPQ9VvxN6THKj
         fHBZEBaiKq9bK4GpflfgCXlWsBtW7QRrN+X5qDM4wCyIwy5B6OohZ1eoLpWoeCQFijv/
         qeGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687887316; x=1690479316;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DErWY5bdlKQCL//WmeXr10V4jZWPluRiVB2lnX+rujc=;
        b=RE2SkGG30+psH6QwqIKmRnZVrRZvap0bZxYqNMgaCBkIH2Foz37Dac4oJM6OHLFO7D
         +d6K6liCyPmyUvlR5a8ETlF7GceX49rcG9/099WGsTFIQ/ax/cDEA2y/PAQ1+ukfVo6K
         lwBGlFmHlUfemF8q0O6+Gs82ha43MlFbYbc8PSnfN+qSoew6URHE8lE3bc5+eQDDohj9
         fawSTMGLjh2FRjWVgriEoNK3bpykpHUm7BNTDHXiMeKnz6ZDYb9Qbxdo2DTGHKRmkKIH
         yDIrGmlb3JIU4cXxqrLZXBn9QcPx+879wU9PPyFTvWOhzdDYYUf7qXTzkS1zTAmomOmr
         yC9w==
X-Gm-Message-State: AC+VfDwgCafwHGItsqKlebUgfQzz5EBTQbPz59WDuvdwclWsfcowvoDX
        sJj3XetJYX6ySz4tbp/LQT4=
X-Google-Smtp-Source: ACHHUZ7Q8KTIOWBGjpxVDyMWBixDhFwzMIxmuxtA5JDDKNNBqtiGeXHJkc/I08VEiBA48unVy6V7Fw==
X-Received: by 2002:a17:902:bc44:b0:1b8:25b:4efb with SMTP id t4-20020a170902bc4400b001b8025b4efbmr4712441plz.62.1687887316531;
        Tue, 27 Jun 2023 10:35:16 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:eb71:7977:cb6e:6d32])
        by smtp.gmail.com with ESMTPSA id b17-20020a170903229100b001b675b24438sm5637836plh.284.2023.06.27.10.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 10:35:15 -0700 (PDT)
Date:   Tue, 27 Jun 2023 10:35:13 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Eray =?iso-8859-1?Q?Or=E7unus?= <erayorcunus@gmail.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, ike.pan@canonical.com,
        jikos@kernel.org, benjamin.tissoires@redhat.com,
        hdegoede@redhat.com, mgross@linux.intel.com, pobrn@protonmail.com,
        Eray =?iso-8859-1?Q?Or=E7unus?= <erayorcunus@gmail.com>
Subject: Re: [PATCH v2 2/7] HID: add mapping for camera access keys
Message-ID: <CAKdAkRQwGOf5Of7wfOHYr7D3Y0GEWtL0+0keGFXfrOic3ZiJgA@mail.gmail.com>
References: <20221029120311.11152-1-erayorcunus@gmail.com>
 <20221029120311.11152-3-erayorcunus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221029120311.11152-3-erayorcunus@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eray,

On Sat, Oct 29, 2022 at 5:04 AM Eray Orçunus <erayorcunus@gmail.com> wrote:
>
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
>         [KEY_ASSISTANT] = "Assistant",
>         [KEY_KBD_LAYOUT_NEXT] = "KbdLayoutNext",
>         [KEY_EMOJI_PICKER] = "EmojiPicker",
> +       [KEY_CAMERA_ACCESS_ENABLE] = "CameraAccessEnable",
> +       [KEY_CAMERA_ACCESS_DISABLE] = "CameraAccessDisable",
> +       [KEY_CAMERA_ACCESS_TOGGLE] = "CameraAccessToggle",
>         [KEY_DICTATE] = "Dictate",
>         [KEY_BRIGHTNESS_MIN] = "BrightnessMin",
>         [KEY_BRIGHTNESS_MAX] = "BrightnessMax",
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index f197aed6444a..f8e6513e77b8 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -995,6 +995,9 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
>                 case 0x0cd: map_key_clear(KEY_PLAYPAUSE);       break;
>                 case 0x0cf: map_key_clear(KEY_VOICECOMMAND);    break;
>
> +               case 0x0d5: map_key_clear(KEY_CAMERA_ACCESS_ENABLE);            break;
> +               case 0x0d6: map_key_clear(KEY_CAMERA_ACCESS_DISABLE);           break;
> +               case 0x0d7: map_key_clear(KEY_CAMERA_ACCESS_TOGGLE);            break;

I was looking at the HID Usages table spec and it came to my attention
that HUTRR72 actually established 0x76, 0x77 and 0x78 as the usages for
then new camera access controls:

https://www.usb.org/sites/default/files/hutrr72_-_usages_to_control_camera_access_0.pdf

Where did 0xd5, 0xd6 and 0xd7 came from?

It looks like we need to update the hid-input mappings as the are
clashing with game recording controls from HUTRR64:

https://www.usb.org/sites/default/files/hutrr64b_-_game_recording_controllers_0.pdf

Thanks.

-- 
Dmitry
