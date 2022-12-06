Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0BF644D18
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 21:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiLFUN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 15:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiLFUNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 15:13:40 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12BF3D923
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 12:11:35 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id p24so15045888plw.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 12:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rcUapuzIOLv1ChbTqErlZGz/ooTgkpZ+vmGq4+9eme0=;
        b=HS3nS3aG+T2LVV6nMWKra4RzUehyW4WbMsaEmuND/g1nKLScX0WYzpj/oOTCrA/Omv
         6LnaZ5B91HU+EXupBNvMD9jQKzcQA+Myerhx5M9gaJdTbK4w1GxjcL+3NLr1o9OR28rg
         5HIqoUyXJ1rS3fjcBK1mre3zmqdynG9egGzr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rcUapuzIOLv1ChbTqErlZGz/ooTgkpZ+vmGq4+9eme0=;
        b=LHNSehG2NGsQGxvh6fgXCiI7pKQArxMQ+emenR8N+0dlguw6PW7i+o33whA6qo6eIh
         zxoHAA1WNcxZL0On6cUaXGR7edxw2X1BsfNVg2++MqKdAzXYsq9X/JBtVmzTcHiTpD7O
         DFl5MCWzy8t+kBt5s0urSq1PwSsCN4ZHSKGC5ahQAKkPkSTUxKqMH99qr7optPhobslU
         oPSsOXRXgHPVj30eJDpeA4AdvlTmkndTpCbsmzB8BkgEB6DkXFdprOEProjCgvvNoTZe
         zm4d5UZ8VLqR++ZK/47+fvMoAcbkR+kEyPKYJYlhzY49w9shtAFKL2GzDknt9TcsvMsd
         oGDQ==
X-Gm-Message-State: ANoB5pncanGezW8YrhwPkN8EaxkEpi8QQRZA0EkUxAEStg+sfPi5Cnsk
        JGFmDmWXIdD1rC1hCRg6ovHO6yyL/XfDuyy2
X-Google-Smtp-Source: AA0mqf7B86YTM83iDnKi1WDihlp1QUCaJlGqInZKq8oskfeTvAtbecepL3AFKjbcZ9SuoCJ8UOig7Q==
X-Received: by 2002:a17:902:f792:b0:186:b32c:4cdc with SMTP id q18-20020a170902f79200b00186b32c4cdcmr71850387pln.166.1670357494929;
        Tue, 06 Dec 2022 12:11:34 -0800 (PST)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com. [209.85.215.181])
        by smtp.gmail.com with ESMTPSA id f17-20020a170902f39100b00178b9c997e5sm12991775ple.138.2022.12.06.12.11.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 12:11:34 -0800 (PST)
Received: by mail-pg1-f181.google.com with SMTP id 6so14354805pgm.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 12:11:33 -0800 (PST)
X-Received: by 2002:a63:1607:0:b0:457:a1d3:48c3 with SMTP id
 w7-20020a631607000000b00457a1d348c3mr60775778pgl.465.1670357493343; Tue, 06
 Dec 2022 12:11:33 -0800 (PST)
MIME-Version: 1.0
References: <20221206173819.1.I69657e84c0606b2e5ccfa9fedbf42b7676a1e129@changeid>
In-Reply-To: <20221206173819.1.I69657e84c0606b2e5ccfa9fedbf42b7676a1e129@changeid>
From:   Dmitry Torokhov <dtor@chromium.org>
Date:   Tue, 6 Dec 2022 12:11:17 -0800
X-Gmail-Original-Message-ID: <CAE_wzQ-WrjOgSADCn4v80ESwicOFif_Trn3Wrq=5toy2+y+q=g@mail.gmail.com>
Message-ID: <CAE_wzQ-WrjOgSADCn4v80ESwicOFif_Trn3Wrq=5toy2+y+q=g@mail.gmail.com>
Subject: Re: [PATCH] HID: multitouch: Add quirks for flipped axes
To:     Allen Ballway <ballway@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Allen,

On Tue, Dec 6, 2022 at 9:39 AM Allen Ballway <ballway@chromium.org> wrote:
>
> Certain touchscreen devices, such as the ELAN9034, are oriented
> incorrectly and report touches on opposite points on the X and Y axes.
> For example, a 100x200 screen touched at (10,20) would report (90, 180)
> and vice versa.
>
> This is fixed by adding device quirks to transform the touch points
> into the correct spaces, from X -> MAX(X) - X, and Y -> MAX(Y) - Y.
>
> Signed-off-by: Allen Ballway <ballway@chromium.org>
> ---
>
>  drivers/hid/hid-multitouch.c | 46 ++++++++++++++++++++++++++++++++----
>  1 file changed, 42 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 91a4d3fc30e08..5e14cc4b00f53 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -71,6 +71,8 @@ MODULE_LICENSE("GPL");
>  #define MT_QUIRK_SEPARATE_APP_REPORT   BIT(19)
>  #define MT_QUIRK_FORCE_MULTI_INPUT     BIT(20)
>  #define MT_QUIRK_DISABLE_WAKEUP                BIT(21)
> +#define MT_QUIRK_FLIP_X                        BIT(22)
> +#define MT_QUIRK_FLIP_Y                        BIT(23)
>
>  #define MT_INPUTMODE_TOUCHSCREEN       0x02
>  #define MT_INPUTMODE_TOUCHPAD          0x03
> @@ -212,6 +214,7 @@ static void mt_post_parse(struct mt_device *td, struct mt_application *app);
>  #define MT_CLS_GOOGLE                          0x0111
>  #define MT_CLS_RAZER_BLADE_STEALTH             0x0112
>  #define MT_CLS_SMART_TECH                      0x0113
> +#define MT_CLS_ELAN_FLIPPED                    0x0114
>
>  #define MT_DEFAULT_MAXCONTACT  10
>  #define MT_MAX_MAXCONTACT      250
> @@ -396,6 +399,17 @@ static const struct mt_class mt_classes[] = {
>                         MT_QUIRK_CONTACT_CNT_ACCURATE |
>                         MT_QUIRK_SEPARATE_APP_REPORT,
>         },input_abs_get_max(input, ABS_MT_POSITION_X) - *slot->x
> +       { .name = MT_CLS_ELAN_FLIPPED,
> +               .quirks = MT_QUIRK_ALWAYS_VALID |
> +                       MT_QUIRK_IGNORE_DUPLICATES |
> +                       MT_QUIRK_HOVERING |
> +                       MT_QUIRK_CONTACT_CNT_ACCURATE |
> +                       MT_QUIRK_STICKY_FINGERS |
> +                       MT_QUIRK_WIN8_PTP_BUTTONS |
> +                       MT_QUIRK_FLIP_X |
> +                       MT_QUIRK_FLIP_Y,
> +               .export_all_inputs = true },
> +
>         { }
>  };
>
> @@ -1115,10 +1129,30 @@ static int mt_process_slot(struct mt_device *td, struct input_dev *input,
>                         minor = minor >> 1;
>                 }
>
> -               input_event(input, EV_ABS, ABS_MT_POSITION_X, *slot->x);
> -               input_event(input, EV_ABS, ABS_MT_POSITION_Y, *slot->y);
> -               input_event(input, EV_ABS, ABS_MT_TOOL_X, *slot->cx);
> -               input_event(input, EV_ABS, ABS_MT_TOOL_Y, *slot->cy);
> +               if (quirks & MT_QUIRK_FLIP_X) {
> +                       /* Inputs with a flipped X axis need to report MAX - X */
> +                       int x = input_abs_get_max(input, ABS_MT_POSITION_X) - *slot->x;

Maybe

x = quirks & MT_QUIRK_FLIP_X ?
        input_abs_get_max(input, ABS_MT_POSITION_X) - *slot->x :
        *slot->x;

and then report it all together?

> +                       int cx = input_abs_get_max(input, ABS_MT_TOOL_X) - *slot->cx;

Would like to double-check that this conversion is actually needed.

> +
> +                       input_event(input, EV_ABS, ABS_MT_POSITION_X, x);
> +                       input_event(input, EV_ABS, ABS_MT_TOOL_X, cx);
> +               } else {
> +                       input_event(input, EV_ABS, ABS_MT_POSITION_X, *slot->x);
> +                       input_event(input, EV_ABS, ABS_MT_TOOL_X, *slot->cx);
> +               }
> +
> +               if (quirks & MT_QUIRK_FLIP_Y) {
> +                       /* Inputs with a flipped Y axis need to report MAX - Y */
> +                       int y = input_abs_get_max(input, ABS_MT_POSITION_Y) - *slot->y;
> +                       int cy = input_abs_get_max(input, ABS_MT_TOOL_Y) - *slot->cy;
> +
> +                       input_event(input, EV_ABS, ABS_MT_POSITION_Y, y);
> +                       input_event(input, EV_ABS, ABS_MT_TOOL_Y, cy);
> +               } else {
> +                       input_event(input, EV_ABS, ABS_MT_POSITION_Y, *slot->y);
> +                       input_event(input, EV_ABS, ABS_MT_TOOL_Y, *slot->cy);
> +               }
> +
>                 input_event(input, EV_ABS, ABS_MT_DISTANCE, !*slot->tip_state);
>                 input_event(input, EV_ABS, ABS_MT_ORIENTATION, orientation);

I think we might need to do something about this too as orientation will change.

>                 input_event(input, EV_ABS, ABS_MT_PRESSURE, *slot->p);
> @@ -1963,6 +1997,10 @@ static const struct hid_device_id mt_devices[] = {
>                         USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_C002) },
>
>         /* Elan devices */
> +       { .driver_data = MT_CLS_ELAN_FLIPPED,
> +               HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
> +                       USB_VENDOR_ID_ELAN, 0x2dcd) },
> +

I believe this needs to be plumbed through i2c-hid and involve DMI check as I am
concerned that product 0x2dcd might have been used in other devices where it was
mounted in a different way.

>         { .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT,
>                 HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
>                         USB_VENDOR_ID_ELAN, 0x313a) },
> --
> 2.39.0.rc0.267.gcb52ba06e7-goog
>

Thanks,
Dmitry
