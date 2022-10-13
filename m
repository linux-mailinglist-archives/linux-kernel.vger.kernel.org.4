Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2EC25FD39A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 05:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiJMDm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 23:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJMDmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 23:42:23 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C7510327C;
        Wed, 12 Oct 2022 20:42:22 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 63so674669ybq.4;
        Wed, 12 Oct 2022 20:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kUREQjpPEdgvuhuExp0E4HTAn8hHXIucVYJF+DvY/28=;
        b=eQOynbmSukIacmiuHcsQ8uQsjRJUucO7eWLcfNxjTgfxBoqOGZ85uZbkE3sJfVyU5w
         5zh6itPOSB4Kus8MC49yM/7q5oI4NoPKi1tviRI4a6QxIlVlSNWUea9wn8g6aaKg+97R
         ZnSBSmq3d2/KtzT4i/rAMuqeZCUCpGd3GXpLgBYlvEOavW15FjqtYe4a4zhHQ+7+C7UJ
         ug3Co1RWOfUq1fSC71Of/yBtIGxp5ogIZv88bgkQ19BdU3juEMYq+Icu+BtDiChp1orU
         v302gJ0DMt6NeQ9a9cHE+TSlUofac0Yowx2vYJJntXSrf5HOkFgM7QyxRjzf9fiV9dVS
         lRtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kUREQjpPEdgvuhuExp0E4HTAn8hHXIucVYJF+DvY/28=;
        b=fCIfcpEKbrj1XI/BW3lI/xXXU4OmZfJy7MaPH6uk8KI68WpBdXgH6OZ90GFOAY146O
         9gmMU1h9p92XEshUEPHPynlPEhmuoQ398ILHuP374x9CYQDodKzAj+7z3XKyyTFIQ9gX
         MkkrnHudvBaoEP4EePJaFYhmXV8P9NnXe4G0pMBSYIy6LFBhsj5dM0SlXY38DFHNG2+Q
         JV6enRKtUP37DDaWRO2C66W10hGnmV27F9r9LNv02p6DTLu85S7n2DIYhEeR81Ix2ZJi
         d/x75RxR7Db5LkocMzuIC9hHvBS3h89R9aKVGCAnPea529ltQ1zRxsFNTxI/RDE/cMm4
         yzIA==
X-Gm-Message-State: ACrzQf0ajTxQKK4K77youABtrCgGyXH9nQts4eGiiNwu8CzoTl/gsxb/
        FGUuWaSezxn8Mvrj1kEvTzZ4Q0xceRH9eMXIIo0tPaUJdmOP0Si6bfM=
X-Google-Smtp-Source: AMsMyM7L7EnGLuoSGlaJtuZDv16rftyUMFwJrojwzpDqiToyn1fFFzBB0zTfOsbrWGhKQKUZSHwcnMBN1AEto2QW4B4=
X-Received: by 2002:a25:6611:0:b0:6bd:2d:6992 with SMTP id a17-20020a256611000000b006bd002d6992mr31663237ybc.173.1665632542212;
 Wed, 12 Oct 2022 20:42:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAAboHLVgQKzNVU6XDWGZmnxGK0DGvtgyzMsY9V+UiOJVq1JyTg@mail.gmail.com>
 <085e90e5-d21e-9068-a2e1-6f7e07fa64df@roeck-us.net>
In-Reply-To: <085e90e5-d21e-9068-a2e1-6f7e07fa64df@roeck-us.net>
From:   karthik gengan <gengankarthik@gmail.com>
Date:   Thu, 13 Oct 2022 09:12:09 +0530
Message-ID: <CAAboHLU8a9vztdM2b8+Y2ZUAs0+fD4HgwV2X_ASRa=SnWJXTwQ@mail.gmail.com>
Subject: Re: [PATCH] [v1 1/1]hwmon:(pmbus) Validate the data for chip
 supporting vout_mode (PMBUS_HAVE_VOUT) in the linear config.
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

Thanks for your response but I need some more valuable suggestions...

        In the pmbus_data structure, we are updating the vout_out mode
value based on the config ( linear, vid .direct) and this structure is declared
in pmbus_core.c .so the low-level driver could not able to access this
structure.

Guidance required,
     1. Move the pumbus_data structure declaration to pmbus.h, so that low-level
          the driver can check and update the vout_mode if the value
is not proper.   (or)
     2.  if the vout_mode attribute value is exposed in the sysfs, the
user-level application
          can modify the value. ( if the value is not proper).
                               (or)
      3. if an ioctl call is exposed for the vout_mode then the
user-level application can
           able to update the value. ( if the value is not proper).

(or)  guide me to a better approach to handle this issue.

For reference,
          UCD90xx vendor claims that vout_mode value should be present
if the chip
supports PMBUS_VOUT_MODE command. Hence the patch validated the vout_mode
value for PMBUS_VOUT_MODE supported chip.

Thanks & Regards,
Karthik.G

On Wed, Oct 12, 2022 at 7:05 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 10/11/22 16:59, karthik gengan wrote:
> > Linear mode config calculation is based on the exponent value
> > derived from vout_mode. So vout_mode value should be valid
> > for PMBUS_VOUT_MODE command-supported chips.
> >
>
> We can not do this. The operational word is "should". See comment
> below "Not all chips support the VOUT_MODE command". It is what it is.
> We can not just refuse to support such chips because they don't
> support what we expect them to support.
>
> Sure, those chips will (likely) report wrong values since the
> exponent will default to 0. That can be adjusted in user space,
> or whoever finds such a chip can provide a back-end driver
> with the appropriate values configured (for example by providing
> a dummy VOUT_MODE command response). That is better than just
> rejecting the chip entirely.
>
>  From a practical perspective, if you know about an affected chip
> one that would refuse to instantiate after your patch is applied,
> I would suggest to submit (or improve) a back-end driver with
> an explanation instead.
>
> Thanks,
> Guenter
>
> > Signed-off-by: karthik.gengan <gengankarthik@gmail.com <mailto:gengankarthik@gmail.com>>
> > ---
> >   drivers/hwmon/pmbus/pmbus_core.c | 10 +++++++++-
> >   1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> > index 7ec04934747e..5f80c3b8f245 100644
> > --- a/drivers/hwmon/pmbus/pmbus_core.c
> > +++ b/drivers/hwmon/pmbus/pmbus_core.c
> > @@ -2507,9 +2507,17 @@ static int pmbus_identify_common(struct i2c_client *client,
> >   {
> >      int vout_mode = -1;
> >
> > -   if (pmbus_check_byte_register(client, page, PMBUS_VOUT_MODE))
> > +   if (pmbus_check_byte_register(client, page, PMBUS_VOUT_MODE)) {
> >          vout_mode = _pmbus_read_byte_data(client, page,
> >                            PMBUS_VOUT_MODE);
> > +       /*
> > +        * If the client page supports PMBUS_VOUT_MODE,
> > +        * then the output of the VOUT_MODE command should
> > +        * be a valid value for linear mode calculation.
> > +        */
> > +       if ((data->info->format[PSC_VOLTAGE_OUT] == linear) && (vout_mode < 0))
> > +           return -ENODEV;
> > +   }
> >      if (vout_mode >= 0 && vout_mode != 0xff) {
> >          /*
> >           * Not all chips support the VOUT_MODE command,
> > --
> > 2.25.1
> >
>
>
