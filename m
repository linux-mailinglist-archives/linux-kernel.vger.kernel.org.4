Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B5164BA19
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 17:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236141AbiLMQqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 11:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236221AbiLMQqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 11:46:05 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E349F23397
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 08:45:15 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id h33so209309pgm.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 08:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cTNMCnwzXvfTpL9VWI8eGlKy5v64IQi2LdiM+QSYYOw=;
        b=mv20EOIo+84b/J94/vNzZ5abwgu9Vx4iR1etUrKN2QvBYZdPBz19UPvvOC3ueJVnle
         S5TsHPAGLKCWGYbyPUWsIB063XA5nwx8t/MjqYRKOXaOUtaIDmEZDpVWSBVHfUGLbJBG
         hMwWxL13hDrbg2o7Fmin3q/Y7cwoopiHgOVOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cTNMCnwzXvfTpL9VWI8eGlKy5v64IQi2LdiM+QSYYOw=;
        b=AMni6uk9+LlBMnY4WVYmPSUnQCnUaQC6dVV//rmJl00BM83gfEavVoTrNLgNBo+cTJ
         r8CxyAyy4KhTwEPfho0NyBa3DIDtXyKmh++mOwam4afHGgDzvEbKuXhLxWo3v7Bq59Fc
         vSmF0AUDL+WejNtvm8Qsl2f155mrZqbw2oJ1yTVxZDE356I6hnf9JUd4hRMiQAK0Uh8o
         NOTtK93UmAGJfgJi4VT1VSzwG7VKmPNFEoxZpiJIW/HBFSKtg63ek+N88Cfg8foXXQpN
         IJ3wIGBe1Hliqr/iYdXPFrxL33Z/D8yOlNsla+shEWSfioTO7gft2kD/QTqPrw/CXucu
         BzbQ==
X-Gm-Message-State: ANoB5pkQt/C5Zd9+my3awLUFOp7i3h968pXY8UuSGWtVSwZysidRjFEW
        stcB9sdxR9Z64JfUYsDxKUrQ6GNOPubj8tFcpilFcw==
X-Google-Smtp-Source: AA0mqf6lHzrlNkuDCNzng1MEePc6zbmLa87gHIO6GbVaAQCejqRZggM5Dbn/wf1w5wNy3XPP5fPfrIz4civCTCNug8E=
X-Received: by 2002:a63:ce09:0:b0:478:ff8a:1258 with SMTP id
 y9-20020a63ce09000000b00478ff8a1258mr4774983pgf.148.1670949915308; Tue, 13
 Dec 2022 08:45:15 -0800 (PST)
MIME-Version: 1.0
References: <Y5d29JwIxku9ubVb@google.com> <20221213010112.3394537-1-ballway@chromium.org>
 <CAO-hwJ+2-BgppwAyD2mXbkZjZcFv3TnnGLT+3kLCDxX0SUr9Pw@mail.gmail.com>
In-Reply-To: <CAO-hwJ+2-BgppwAyD2mXbkZjZcFv3TnnGLT+3kLCDxX0SUr9Pw@mail.gmail.com>
From:   Allen Ballway <ballway@chromium.org>
Date:   Tue, 13 Dec 2022 08:45:04 -0800
Message-ID: <CAEs41JB0gn97eusPCnuZ4tBpQz=bezd=sF2ObqGtVxBvJ=96Vg@mail.gmail.com>
Subject: Re: [PATCH v3] HID: multitouch: Add quirks for flipped axes
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     dmitry.torokhov@gmail.com, dtor@chromium.org, jikos@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        rydberg@bitmath.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 1:19 AM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> On Tue, Dec 13, 2022 at 2:01 AM Allen Ballway <ballway@chromium.org> wrote:
> >
> > Certain touchscreen devices, such as the ELAN9034, are oriented
> > incorrectly and report touches on opposite points on the X and Y axes.
> > For example, a 100x200 screen touched at (10,20) would report (90, 180)
> > and vice versa.
> >
> > This changed fixes the issue by adding device quirks to transform
> > the touch points into the correct spaces, from X -> MAX(X) - X,
> > and Y -> MAX(Y) - Y. These quirks are added in hid-quirks checking
> > both DMI information and device vendor and product IDs. The quirk
> > is handled in hid-multitouch to do the actual transformation.
> >
> > Signed-off-by: Allen Ballway <ballway@chromium.org>
> > ---
> > V2 -> V3: Use existing HID_QUIRK_*_INVERT and match the quirk in
> > hid-quirk, passing down to hid-multitouch through the hid device.
> >
> > V1 -> V2: Address review comments, change to use DMI match. Confirmed
> > MT_TOOL_X/Y require transformation and update orientation based on
> > flipped axes.
> >
> >
> >  drivers/hid/hid-multitouch.c | 43 ++++++++++++++++++++++++++++++++----
> >  drivers/hid/hid-quirks.c     | 33 +++++++++++++++++++++++++++
> >  2 files changed, 72 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> > index 91a4d3fc30e08..1f4c2aa511359 100644
> > --- a/drivers/hid/hid-multitouch.c
> > +++ b/drivers/hid/hid-multitouch.c
> > @@ -71,6 +71,8 @@ MODULE_LICENSE("GPL");
> >  #define MT_QUIRK_SEPARATE_APP_REPORT   BIT(19)
> >  #define MT_QUIRK_FORCE_MULTI_INPUT     BIT(20)
> >  #define MT_QUIRK_DISABLE_WAKEUP                BIT(21)
> > +#define MT_QUIRK_X_INVERT              BIT(22)
> > +#define MT_QUIRK_Y_INVERT              BIT(23)
>
> Why duplicate the already available quirks in struct hid_device?

This no longer seems necessary, and will be removed.

>
> >
> >  #define MT_INPUTMODE_TOUCHSCREEN       0x02
> >  #define MT_INPUTMODE_TOUCHPAD          0x03
> > @@ -1086,6 +1088,10 @@ static int mt_process_slot(struct mt_device *td, struct input_dev *input,
> >                 int orientation = wide;
> >                 int max_azimuth;
> >                 int azimuth;
> > +               int x;
> > +               int y;
> > +               int cx;
> > +               int cy;
> >
> >                 if (slot->a != DEFAULT_ZERO) {
> >                         /*
> > @@ -1104,6 +1110,16 @@ static int mt_process_slot(struct mt_device *td, struct input_dev *input,
> >                         if (azimuth > max_azimuth * 2)
> >                                 azimuth -= max_azimuth * 4;
> >                         orientation = -azimuth;
> > +
> > +                       /* Orientation is inverted if the X or Y axes are
> > +                        * flipped, but normalized if both are inverted.
> > +                        */
> > +                       if (quirks & (MT_QUIRK_X_INVERT | MT_QUIRK_Y_INVERT) &&
> > +                           !((quirks & MT_QUIRK_X_INVERT)
> > +                             && (quirks & MT_QUIRK_Y_INVERT))) {
>
> This is done in every finger slot in every report. We should probably
> cache that information somewhere.

I can do this once in mt_probe and keep it saved as its own quirk.

>
> > +                               orientation = -orientation;
> > +                       }
> > +
> >                 }
> >
> >                 if (quirks & MT_QUIRK_TOUCH_SIZE_SCALING) {
> > @@ -1115,10 +1131,23 @@ static int mt_process_slot(struct mt_device *td, struct input_dev *input,
> >                         minor = minor >> 1;
> >                 }
> >
> > -               input_event(input, EV_ABS, ABS_MT_POSITION_X, *slot->x);
> > -               input_event(input, EV_ABS, ABS_MT_POSITION_Y, *slot->y);
> > -               input_event(input, EV_ABS, ABS_MT_TOOL_X, *slot->cx);
> > -               input_event(input, EV_ABS, ABS_MT_TOOL_Y, *slot->cy);
> > +               x = quirks & MT_QUIRK_X_INVERT ?
> > +                       input_abs_get_max(input, ABS_MT_POSITION_X) - *slot->x :
> > +                       *slot->x;
> > +               y = quirks & MT_QUIRK_Y_INVERT ?
> > +                       input_abs_get_max(input, ABS_MT_POSITION_Y) - *slot->y :
> > +                       *slot->y;
> > +               cx = quirks & MT_QUIRK_X_INVERT ?
> > +                       input_abs_get_max(input, ABS_MT_POSITION_X) - *slot->cx :
> > +                       *slot->cx;
> > +               cy = quirks & MT_QUIRK_Y_INVERT ?
> > +                       input_abs_get_max(input, ABS_MT_POSITION_Y) - *slot->cy :
> > +                       *slot->cy;
>
> I can't help but think that there must be a better way of doing that.
> If I didn't postpone HID-BPF to 6.3 I would have asked you to do this
> as a BPF program.
>
> Still, the whole point of the slot pointers was to remove the data
> copy everywhere, and you are adding it back.  Not to mention that the
> same tests and accesses to variables are called multiple times.

I can move the transformation to mt_touch_input_mapping which has easier access
to the quirks coming from hid_device rather than using duplicated quirks for
mt_application/class.

>
> > +
> > +               input_event(input, EV_ABS, ABS_MT_POSITION_X, x);
> > +               input_event(input, EV_ABS, ABS_MT_POSITION_Y, y);
> > +               input_event(input, EV_ABS, ABS_MT_TOOL_X, cx);
> > +               input_event(input, EV_ABS, ABS_MT_TOOL_Y, cy);
> >                 input_event(input, EV_ABS, ABS_MT_DISTANCE, !*slot->tip_state);
> >                 input_event(input, EV_ABS, ABS_MT_ORIENTATION, orientation);
> >                 input_event(input, EV_ABS, ABS_MT_PRESSURE, *slot->p);
> > @@ -1735,6 +1764,12 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
> >         if (id->vendor == HID_ANY_ID && id->product == HID_ANY_ID)
> >                 td->serial_maybe = true;
> >
> > +       if (hdev->quirks & HID_QUIRK_X_INVERT)
> > +               td->mtclass.quirks |= MT_QUIRK_X_INVERT;
> > +
> > +       if (hdev->quirks & HID_QUIRK_Y_INVERT)
> > +               td->mtclass.quirks |= MT_QUIRK_Y_INVERT;
>
> As mentioned above, I don't see the point in doing that duplication of quirks.

Will remove

>
> > +
> >         /* This allows the driver to correctly support devices
> >          * that emit events over several HID messages.
> >          */
> > diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
>
> AFAICT, Dmitry told you twice to use i2c-hid, not hid-quirks.c.
>
> We already have i2c-hid-dmi-quirks.c that you could extend. The
> rationale is that this way, the dmi check will be done only for
> internal peripherals, leaving aside the USB ones.

I had added the quirks to hid_device to i2c-hid-dmi-quirks before
trying this but they were getting stomped by the quirks coming from
hid-quirks. I will move these back to i2c-hid-dmi-quirks and change
hid-device to add them to whatever quirks come from hid-quirks.

>
> Cheers,
> Benjamin
>
> > index 0e9702c7f7d6c..47c6cd62f019a 100644
> > --- a/drivers/hid/hid-quirks.c
> > +++ b/drivers/hid/hid-quirks.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/export.h>
> >  #include <linux/slab.h>
> >  #include <linux/mutex.h>
> > +#include <linux/dmi.h>
> >  #include <linux/input/elan-i2c-ids.h>
> >
> >  #include "hid-ids.h"
> > @@ -957,6 +958,29 @@ static const struct hid_device_id hid_mouse_ignore_list[] = {
> >         { }
> >  };
> >
> > +static const struct hid_device_id elan_flipped_quirks[] = {
> > +       { HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8, USB_VENDOR_ID_ELAN, 0x2dcd),
> > +               HID_QUIRK_X_INVERT | HID_QUIRK_Y_INVERT },
> > +       { }
> > +};
> > +
> > +/*
> > + * This list contains devices which have specific issues based on the system
> > + * they're on and not just the device itself. The driver_data will have a
> > + * specific hid device to match against.
> > + */
> > +static const struct dmi_system_id dmi_override_table[] = {
> > +       {
> > +               .ident = "DynaBook K50/FR",
> > +               .matches = {
> > +                       DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Dynabook Inc."),
> > +                       DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "dynabook K50/FR"),
> > +               },
> > +               .driver_data = (void *)elan_flipped_quirks,
> > +       },
> > +       { }     /* Terminate list */
> > +};
> > +
> >  bool hid_ignore(struct hid_device *hdev)
> >  {
> >         int i;
> > @@ -1238,6 +1262,7 @@ static unsigned long hid_gets_squirk(const struct hid_device *hdev)
> >  {
> >         const struct hid_device_id *bl_entry;
> >         unsigned long quirks = 0;
> > +       const struct dmi_system_id *system_id;
> >
> >         if (hid_match_id(hdev, hid_ignore_list))
> >                 quirks |= HID_QUIRK_IGNORE;
> > @@ -1249,6 +1274,14 @@ static unsigned long hid_gets_squirk(const struct hid_device *hdev)
> >         if (bl_entry != NULL)
> >                 quirks |= bl_entry->driver_data;
> >
> > +       system_id = dmi_first_match(dmi_override_table);
> > +       if (system_id != NULL) {
> > +               bl_entry = hid_match_id(hdev, system_id->driver_data);
> > +               if (bl_entry != NULL)
> > +                       quirks |= bl_entry->driver_data;
> > +       }
> > +
> > +
> >         if (quirks)
> >                 dbg_hid("Found squirk 0x%lx for HID device 0x%04x:0x%04x\n",
> >                         quirks, hdev->vendor, hdev->product);
> > --
> > 2.39.0.rc1.256.g54fd8350bd-goog
> >
>

Thanks for the comments,
Allen
