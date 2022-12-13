Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00FC764B23F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 10:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbiLMJVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 04:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234764AbiLMJUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 04:20:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E9523C
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 01:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670923154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Aeq323qfS8Bn2ZyewA1Gt180pHSM6rovNGR+/lMKQfQ=;
        b=GtfXAlzAj+oUg1+wORCm/8OBhEeztzrwd8INXqN0EhsPHABqgRTFNqw1SWTlTs5zr3ot+u
        Q5feeM91YzyFXOrvDWmT9bovC/ngOPvGYi9jOwaT6FpgI271rfn8+0Em3L7VES/2DC7Knj
        6zEhQKckf9AtcEE4IPDg38iZkyFX1Aw=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-620-0UQU4PmGOrKsTrH9VkytkA-1; Tue, 13 Dec 2022 04:19:12 -0500
X-MC-Unique: 0UQU4PmGOrKsTrH9VkytkA-1
Received: by mail-io1-f72.google.com with SMTP id f23-20020a5d8157000000b006dfb209094fso1519232ioo.18
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 01:19:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Aeq323qfS8Bn2ZyewA1Gt180pHSM6rovNGR+/lMKQfQ=;
        b=dxDWTeDl9nwGjyQBFzm3F8vEbn/SeGwnkXyvocBG+EG44070nxt+pbtbjmf7q0Shbf
         3mRQ9P0PzCFK6skFg4+q3pslfFYTv/moIaGrad2eBV+5nAzfM0rHJXUbFoGwb8qRbpg/
         flW0AIRl+ZHBio9dcMxHigCZpSIdGFCXfX5XLbcjQhKUiAKb1ndoXm9s1OHsOKZ4ZElQ
         9UQmgy6LqINLICqTKBi769NMfEwe8XNhuP2/G0p5je+87JrchcQIiQZRdBlJC6Q7VZtZ
         BHbVEAn0Z+smwLWl8rDggADnHAHJ23bT89XCIHO5OSi85vSbRgx2c5bFJFUjLvEZTrqO
         JJYQ==
X-Gm-Message-State: ANoB5plb2/2HM5nxlJd6LHFkx4tfb05rtYKWNAT0TsU60Ju9yC2/ndXw
        RdG92b5/l8HeBw8y1SDwrgz8tQ6qdFAmBDtixaint/QWji0Gw2SZVZmh5yvgTLJDF/MCoHvq0NA
        RfgY7qYdP7K1ZJBjqlgNs2SApL2pfHPCSLAcymin9
X-Received: by 2002:a92:db42:0:b0:303:26c0:e1fe with SMTP id w2-20020a92db42000000b0030326c0e1femr19765491ilq.102.1670923151816;
        Tue, 13 Dec 2022 01:19:11 -0800 (PST)
X-Google-Smtp-Source: AA0mqf69D4fGPduF0vuiMIoH7Lc/5GI3I9pzG527KNnDiwQUGMbgwMqSVFJaOVNehI4DqgsLZxw3D1vROI8zYgQFPHs=
X-Received: by 2002:a92:db42:0:b0:303:26c0:e1fe with SMTP id
 w2-20020a92db42000000b0030326c0e1femr19765485ilq.102.1670923151515; Tue, 13
 Dec 2022 01:19:11 -0800 (PST)
MIME-Version: 1.0
References: <Y5d29JwIxku9ubVb@google.com> <20221213010112.3394537-1-ballway@chromium.org>
In-Reply-To: <20221213010112.3394537-1-ballway@chromium.org>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 13 Dec 2022 10:19:00 +0100
Message-ID: <CAO-hwJ+2-BgppwAyD2mXbkZjZcFv3TnnGLT+3kLCDxX0SUr9Pw@mail.gmail.com>
Subject: Re: [PATCH v3] HID: multitouch: Add quirks for flipped axes
To:     Allen Ballway <ballway@chromium.org>
Cc:     dmitry.torokhov@gmail.com, dtor@chromium.org, jikos@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        rydberg@bitmath.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 2:01 AM Allen Ballway <ballway@chromium.org> wrote:
>
> Certain touchscreen devices, such as the ELAN9034, are oriented
> incorrectly and report touches on opposite points on the X and Y axes.
> For example, a 100x200 screen touched at (10,20) would report (90, 180)
> and vice versa.
>
> This changed fixes the issue by adding device quirks to transform
> the touch points into the correct spaces, from X -> MAX(X) - X,
> and Y -> MAX(Y) - Y. These quirks are added in hid-quirks checking
> both DMI information and device vendor and product IDs. The quirk
> is handled in hid-multitouch to do the actual transformation.
>
> Signed-off-by: Allen Ballway <ballway@chromium.org>
> ---
> V2 -> V3: Use existing HID_QUIRK_*_INVERT and match the quirk in
> hid-quirk, passing down to hid-multitouch through the hid device.
>
> V1 -> V2: Address review comments, change to use DMI match. Confirmed
> MT_TOOL_X/Y require transformation and update orientation based on
> flipped axes.
>
>
>  drivers/hid/hid-multitouch.c | 43 ++++++++++++++++++++++++++++++++----
>  drivers/hid/hid-quirks.c     | 33 +++++++++++++++++++++++++++
>  2 files changed, 72 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 91a4d3fc30e08..1f4c2aa511359 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -71,6 +71,8 @@ MODULE_LICENSE("GPL");
>  #define MT_QUIRK_SEPARATE_APP_REPORT   BIT(19)
>  #define MT_QUIRK_FORCE_MULTI_INPUT     BIT(20)
>  #define MT_QUIRK_DISABLE_WAKEUP                BIT(21)
> +#define MT_QUIRK_X_INVERT              BIT(22)
> +#define MT_QUIRK_Y_INVERT              BIT(23)

Why duplicate the already available quirks in struct hid_device?

>
>  #define MT_INPUTMODE_TOUCHSCREEN       0x02
>  #define MT_INPUTMODE_TOUCHPAD          0x03
> @@ -1086,6 +1088,10 @@ static int mt_process_slot(struct mt_device *td, struct input_dev *input,
>                 int orientation = wide;
>                 int max_azimuth;
>                 int azimuth;
> +               int x;
> +               int y;
> +               int cx;
> +               int cy;
>
>                 if (slot->a != DEFAULT_ZERO) {
>                         /*
> @@ -1104,6 +1110,16 @@ static int mt_process_slot(struct mt_device *td, struct input_dev *input,
>                         if (azimuth > max_azimuth * 2)
>                                 azimuth -= max_azimuth * 4;
>                         orientation = -azimuth;
> +
> +                       /* Orientation is inverted if the X or Y axes are
> +                        * flipped, but normalized if both are inverted.
> +                        */
> +                       if (quirks & (MT_QUIRK_X_INVERT | MT_QUIRK_Y_INVERT) &&
> +                           !((quirks & MT_QUIRK_X_INVERT)
> +                             && (quirks & MT_QUIRK_Y_INVERT))) {

This is done in every finger slot in every report. We should probably
cache that information somewhere.

> +                               orientation = -orientation;
> +                       }
> +
>                 }
>
>                 if (quirks & MT_QUIRK_TOUCH_SIZE_SCALING) {
> @@ -1115,10 +1131,23 @@ static int mt_process_slot(struct mt_device *td, struct input_dev *input,
>                         minor = minor >> 1;
>                 }
>
> -               input_event(input, EV_ABS, ABS_MT_POSITION_X, *slot->x);
> -               input_event(input, EV_ABS, ABS_MT_POSITION_Y, *slot->y);
> -               input_event(input, EV_ABS, ABS_MT_TOOL_X, *slot->cx);
> -               input_event(input, EV_ABS, ABS_MT_TOOL_Y, *slot->cy);
> +               x = quirks & MT_QUIRK_X_INVERT ?
> +                       input_abs_get_max(input, ABS_MT_POSITION_X) - *slot->x :
> +                       *slot->x;
> +               y = quirks & MT_QUIRK_Y_INVERT ?
> +                       input_abs_get_max(input, ABS_MT_POSITION_Y) - *slot->y :
> +                       *slot->y;
> +               cx = quirks & MT_QUIRK_X_INVERT ?
> +                       input_abs_get_max(input, ABS_MT_POSITION_X) - *slot->cx :
> +                       *slot->cx;
> +               cy = quirks & MT_QUIRK_Y_INVERT ?
> +                       input_abs_get_max(input, ABS_MT_POSITION_Y) - *slot->cy :
> +                       *slot->cy;

I can't help but think that there must be a better way of doing that.
If I didn't postpone HID-BPF to 6.3 I would have asked you to do this
as a BPF program.

Still, the whole point of the slot pointers was to remove the data
copy everywhere, and you are adding it back.  Not to mention that the
same tests and accesses to variables are called multiple times.

> +
> +               input_event(input, EV_ABS, ABS_MT_POSITION_X, x);
> +               input_event(input, EV_ABS, ABS_MT_POSITION_Y, y);
> +               input_event(input, EV_ABS, ABS_MT_TOOL_X, cx);
> +               input_event(input, EV_ABS, ABS_MT_TOOL_Y, cy);
>                 input_event(input, EV_ABS, ABS_MT_DISTANCE, !*slot->tip_state);
>                 input_event(input, EV_ABS, ABS_MT_ORIENTATION, orientation);
>                 input_event(input, EV_ABS, ABS_MT_PRESSURE, *slot->p);
> @@ -1735,6 +1764,12 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
>         if (id->vendor == HID_ANY_ID && id->product == HID_ANY_ID)
>                 td->serial_maybe = true;
>
> +       if (hdev->quirks & HID_QUIRK_X_INVERT)
> +               td->mtclass.quirks |= MT_QUIRK_X_INVERT;
> +
> +       if (hdev->quirks & HID_QUIRK_Y_INVERT)
> +               td->mtclass.quirks |= MT_QUIRK_Y_INVERT;

As mentioned above, I don't see the point in doing that duplication of quirks.

> +
>         /* This allows the driver to correctly support devices
>          * that emit events over several HID messages.
>          */
> diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c

AFAICT, Dmitry told you twice to use i2c-hid, not hid-quirks.c.

We already have i2c-hid-dmi-quirks.c that you could extend. The
rationale is that this way, the dmi check will be done only for
internal peripherals, leaving aside the USB ones.

Cheers,
Benjamin

> index 0e9702c7f7d6c..47c6cd62f019a 100644
> --- a/drivers/hid/hid-quirks.c
> +++ b/drivers/hid/hid-quirks.c
> @@ -16,6 +16,7 @@
>  #include <linux/export.h>
>  #include <linux/slab.h>
>  #include <linux/mutex.h>
> +#include <linux/dmi.h>
>  #include <linux/input/elan-i2c-ids.h>
>
>  #include "hid-ids.h"
> @@ -957,6 +958,29 @@ static const struct hid_device_id hid_mouse_ignore_list[] = {
>         { }
>  };
>
> +static const struct hid_device_id elan_flipped_quirks[] = {
> +       { HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8, USB_VENDOR_ID_ELAN, 0x2dcd),
> +               HID_QUIRK_X_INVERT | HID_QUIRK_Y_INVERT },
> +       { }
> +};
> +
> +/*
> + * This list contains devices which have specific issues based on the system
> + * they're on and not just the device itself. The driver_data will have a
> + * specific hid device to match against.
> + */
> +static const struct dmi_system_id dmi_override_table[] = {
> +       {
> +               .ident = "DynaBook K50/FR",
> +               .matches = {
> +                       DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Dynabook Inc."),
> +                       DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "dynabook K50/FR"),
> +               },
> +               .driver_data = (void *)elan_flipped_quirks,
> +       },
> +       { }     /* Terminate list */
> +};
> +
>  bool hid_ignore(struct hid_device *hdev)
>  {
>         int i;
> @@ -1238,6 +1262,7 @@ static unsigned long hid_gets_squirk(const struct hid_device *hdev)
>  {
>         const struct hid_device_id *bl_entry;
>         unsigned long quirks = 0;
> +       const struct dmi_system_id *system_id;
>
>         if (hid_match_id(hdev, hid_ignore_list))
>                 quirks |= HID_QUIRK_IGNORE;
> @@ -1249,6 +1274,14 @@ static unsigned long hid_gets_squirk(const struct hid_device *hdev)
>         if (bl_entry != NULL)
>                 quirks |= bl_entry->driver_data;
>
> +       system_id = dmi_first_match(dmi_override_table);
> +       if (system_id != NULL) {
> +               bl_entry = hid_match_id(hdev, system_id->driver_data);
> +               if (bl_entry != NULL)
> +                       quirks |= bl_entry->driver_data;
> +       }
> +
> +
>         if (quirks)
>                 dbg_hid("Found squirk 0x%lx for HID device 0x%04x:0x%04x\n",
>                         quirks, hdev->vendor, hdev->product);
> --
> 2.39.0.rc1.256.g54fd8350bd-goog
>

