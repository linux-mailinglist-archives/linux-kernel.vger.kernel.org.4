Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05576655643
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 00:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbiLWXu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 18:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbiLWXuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 18:50:23 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09754120BB;
        Fri, 23 Dec 2022 15:50:22 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5F9BE4DD;
        Sat, 24 Dec 2022 00:50:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1671839420;
        bh=6ImSr7rlBEjCoRKJeakfOzt5VfKkrZOSbEQ1vcPpdmQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S41nSowMD/xkek3LxCDRoHM74JOa/hTt/1cm5WPsVwv2SAbfRSrLxd0PcZEoQn8g/
         qSDLWflV0nc2iKplqstJ2c3B2iwsM4msVCD1pQPgZqqZOfB4pTHA6721CSjqQRuvBO
         +URKfEKxhobgkGq/2D6JQgc66AOTsr8Q7TntD594=
Date:   Sat, 24 Dec 2022 01:50:15 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Roderick Colenbrander <thunderbird2k@gmail.com>
Cc:     Ivan Mironov <mironov.ivan@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] HID: sony: Support for DS4 clones that do not implement
 feature report 0x81
Message-ID: <Y6Y+t0hw1ynJQKXd@pendragon.ideasonboard.com>
References: <20210113173402.17030-1-mironov.ivan@gmail.com>
 <8a2463a97af411e4167f3c4abc2d4be6447e51ac.camel@gmail.com>
 <Y6TaqXproHyRSThH@pendragon.ideasonboard.com>
 <CAEc3jaCTu+WYP6zikKXX2igTvq5GUKX2Y1fpF0q5ZBaNMytgSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEc3jaCTu+WYP6zikKXX2igTvq5GUKX2Y1fpF0q5ZBaNMytgSA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roderick,

On Fri, Dec 23, 2022 at 03:41:09PM -0800, Roderick Colenbrander wrote:
> Try the new hid-playstation driver for Linux 6.2 (download from git or wait
> until rc1). We added ds4 support to it and the Mac address handling code is
> different. It may work for your device. I intend to remove ds4 from
> hid-sony later.

I'll give that a try, but it will take a while. I don't have access to
the hardware at the moment, I was testing this at a friend's place,
after their son was disappointed that the game controller he had just
bought didn't work with RetroPie. When the boy will be a bit older I'll
have to teach him to compile his own kernel ;-)

> On Thu, Dec 22, 2022, 2:43 PM Laurent Pinchart wrote:
> > On Sat, Feb 13, 2021 at 09:02:45AM +0500, Ivan Mironov wrote:
> > > Ignore this patch, I am working on a better one.
> >
> > Have you managed to write a better patch ? I've successfuly tested this
> > one with a PS4 controller clone.
> >
> > > On Wed, 2021-01-13 at 22:34 +0500, Ivan Mironov wrote:
> > > > There are clones of DualShock 4 that are very similar to the originals,
> > > > except of 1) they do not support HID feature report 0x81 and 2) they do
> > > > not have any USB Audio interfaces despite they physically have audio
> > > > jack.
> > > >
> > > > Such controllers are working fine with Linux when connected via
> > > > Bluetooth, but not when connected via USB. Here is how failed USB
> > > > connection attempt looks in log:
> > > >
> > > >     usb 1-5: New USB device found, idVendor=054c, idProduct=05c4, bcdDevice= 1.00
> > > >     usb 1-5: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> > > >     usb 1-5: Product: Wireless Controller
> > > >     usb 1-5: Manufacturer: Sony Computer Entertainment
> > > >     sony 0003:054C:05C4.0007: failed to retrieve feature report 0x81 with the DualShock 4 MAC address
> > > >     sony 0003:054C:05C4.0007: hidraw6: USB HID v81.11 Gamepad [Sony Computer Entertainment Wireless Controller] on usb-0000:00:14.0-5/input0
> > > >     sony 0003:054C:05C4.0007: failed to claim input
> > > >
> > > > This patch adds support of using feature report 0x12 as a fallback for
> > > > Bluetooth MAC address retrieval. Feature report 0x12 also seems to be
> > > > used by DS4Windows[1] for all DS4 controllers.
> > > >
> > > > [1] https://github.com/Ryochan7/DS4Windows/blob/1b74a4440089f38a24ee2c2483c1d733a0692b8f/DS4Windows/HidLibrary/HidDevice.cs#L479
> > > >
> > > > Signed-off-by: Ivan Mironov <mironov.ivan@gmail.com>
> > > > ---
> > > >  drivers/hid/hid-sony.c | 72 ++++++++++++++++++++++++++++++------------
> > > >  1 file changed, 52 insertions(+), 20 deletions(-)
> > > >
> > > > diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> > > > index e3a557dc9ffd..97df12180e45 100644
> > > > --- a/drivers/hid/hid-sony.c
> > > > +++ b/drivers/hid/hid-sony.c
> > > > @@ -491,6 +491,7 @@ struct motion_output_report_02 {
> > > >
> > > >
> > > >  #define DS4_FEATURE_REPORT_0x02_SIZE 37
> > > >  #define DS4_FEATURE_REPORT_0x05_SIZE 41
> > > > +#define DS4_FEATURE_REPORT_0x12_SIZE 16
> > > >  #define DS4_FEATURE_REPORT_0x81_SIZE 7
> > > >  #define DS4_FEATURE_REPORT_0xA3_SIZE 49
> > > >  #define DS4_INPUT_REPORT_0x11_SIZE 78
> > > > @@ -2593,6 +2594,53 @@ static int sony_get_bt_devaddr(struct sony_sc *sc)
> > > >     return 0;
> > > >  }
> > > >
> > > >
> > > > +static int sony_get_usb_ds4_devaddr(struct sony_sc *sc)
> > > > +{
> > > > +   u8 *buf = NULL;
> > > > +   int ret;
> > > > +
> > > > +   buf = kmalloc(max(DS4_FEATURE_REPORT_0x12_SIZE, DS4_FEATURE_REPORT_0x81_SIZE), GFP_KERNEL);
> > > > +   if (!buf)
> > > > +           return -ENOMEM;
> > > > +
> > > > +   /*
> > > > +    * The MAC address of a DS4 controller connected via USB can be
> > > > +    * retrieved with feature report 0x81. The address begins at
> > > > +    * offset 1.
> > > > +    */
> > > > +   ret = hid_hw_raw_request(sc->hdev, 0x81, buf,
> > > > +                   DS4_FEATURE_REPORT_0x81_SIZE, HID_FEATURE_REPORT,
> > > > +                   HID_REQ_GET_REPORT);
> > > > +   if (ret == DS4_FEATURE_REPORT_0x81_SIZE) {
> > > > +           memcpy(sc->mac_address, &buf[1], sizeof(sc->mac_address));
> > > > +           goto out_free;
> > > > +   }
> > > > +   dbg_hid("%s: hid_hw_raw_request(..., 0x81, ...) returned %d\n", __func__, ret);
> > > > +
> > > > +   /*
> > > > +    * Some variants do not implement feature report 0x81 at all.
> > > > +    * Fortunately, feature report 0x12 also contains the MAC address of
> > > > +    * a controller.
> > > > +    */
> > > > +   ret = hid_hw_raw_request(sc->hdev, 0x12, buf,
> > > > +                   DS4_FEATURE_REPORT_0x12_SIZE, HID_FEATURE_REPORT,
> > > > +                   HID_REQ_GET_REPORT);
> > > > +   if (ret == DS4_FEATURE_REPORT_0x12_SIZE) {
> > > > +           memcpy(sc->mac_address, &buf[1], sizeof(sc->mac_address));
> > > > +           goto out_free;
> > > > +   }
> > > > +   dbg_hid("%s: hid_hw_raw_request(..., 0x12, ...) returned %d\n", __func__, ret);
> > > > +
> > > > +   hid_err(sc->hdev, "failed to retrieve feature reports 0x81 and 0x12 with the DualShock 4 MAC address\n");
> > > > +   ret = ret < 0 ? ret : -EINVAL;
> > > > +
> > > > +out_free:
> > > > +
> > > > +   kfree(buf);
> > > > +
> > > > +   return ret;
> > > > +}
> > > > +
> > > >  static int sony_check_add(struct sony_sc *sc)
> > > >  {
> > > >     u8 *buf = NULL;
> > > > @@ -2613,26 +2661,9 @@ static int sony_check_add(struct sony_sc *sc)
> > > >                     return 0;
> > > >             }
> > > >     } else if (sc->quirks & (DUALSHOCK4_CONTROLLER_USB | DUALSHOCK4_DONGLE)) {
> > > > -           buf = kmalloc(DS4_FEATURE_REPORT_0x81_SIZE, GFP_KERNEL);
> > > > -           if (!buf)
> > > > -                   return -ENOMEM;
> > > > -
> > > > -           /*
> > > > -            * The MAC address of a DS4 controller connected via USB can be
> > > > -            * retrieved with feature report 0x81. The address begins
> > at
> > > > -            * offset 1.
> > > > -            */
> > > > -           ret = hid_hw_raw_request(sc->hdev, 0x81, buf,
> > > > -                           DS4_FEATURE_REPORT_0x81_SIZE, HID_FEATURE_REPORT,
> > > > -                           HID_REQ_GET_REPORT);
> > > > -
> > > > -           if (ret != DS4_FEATURE_REPORT_0x81_SIZE) {
> > > > -                   hid_err(sc->hdev, "failed to retrieve feature report 0x81 with the DualShock 4 MAC address\n");
> > > > -                   ret = ret < 0 ? ret : -EINVAL;
> > > > -                   goto out_free;
> > > > -           }
> > > > -
> > > > -           memcpy(sc->mac_address, &buf[1], sizeof(sc->mac_address));
> > > > +           ret = sony_get_usb_ds4_devaddr(sc);
> > > > +           if (ret < 0)
> > > > +                   return ret;
> > > >
> > > >
> > > >             snprintf(sc->hdev->uniq, sizeof(sc->hdev->uniq),
> > > >                      "%pMR", sc->mac_address);
> > > > @@ -2670,6 +2701,7 @@ static int sony_check_add(struct sony_sc *sc)
> > > >             return 0;
> > > >     }
> > > >
> > > >
> > > > +   dbg_hid("%s: retrieved MAC address: %s\n", __func__, sc->hdev->uniq);
> > > >     ret = sony_check_add_dev_list(sc);
> > > >
> > > >
> > > >  out_free:

-- 
Regards,

Laurent Pinchart
