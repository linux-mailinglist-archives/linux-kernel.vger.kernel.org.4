Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129DA68B90C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 10:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjBFJwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 04:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjBFJw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 04:52:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1771C7F7
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 01:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675677104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NQrPbrrg0HMuuU4l4kqFsu7hPxwOPV5DmnGXSTCB7ms=;
        b=JEB8oh7GbVfQiW/KLtxbce59zyg2uCs17gdieCNOOvZLpyMfboKXr1hlMle9c5pTju6uEE
        XlwZWEIg9eATPXLNKlOMHPW74IiFYANAAU8lN31xhS1/m7tNgZE//KkJzvqL8+yo+LgI0O
        wiLjv6/Ub0VIvooP93VvEIzdmXL55xg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-142-WIYJca-eNSuWidNIwPzL5A-1; Mon, 06 Feb 2023 04:51:43 -0500
X-MC-Unique: WIYJca-eNSuWidNIwPzL5A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C72C418A6462;
        Mon,  6 Feb 2023 09:51:42 +0000 (UTC)
Received: from mail.corp.redhat.com (ovpn-192-160.brq.redhat.com [10.40.192.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B90D440C83B6;
        Mon,  6 Feb 2023 09:51:41 +0000 (UTC)
Date:   Mon, 6 Feb 2023 10:51:39 +0100
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Walt Holman <waltholman09@gmail.com>
Cc:     linux-input <linux-input@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: Re: [PATCH] HID: quirks: Add quirk for Logitech G923 Xbox steering
 wheel
Message-ID: <20230206095139.xj6ye7iuwnjo2bvj@mail.corp.redhat.com>
References: <823df262-aa1d-4340-666f-07b991fce64b@gmail.com>
 <4fc782ec-e1f7-3b89-5be9-d5b7bab5c4d3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4fc782ec-e1f7-3b89-5be9-d5b7bab5c4d3@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Walt,

On Jan 27 2023, Walt Holman wrote:
> On 1/27/23 16:03, Walt Holman wrote:
> > Hello,
> > 
> > This patch adds support for the Logitech G923 Xbox edition steering
> > wheel.
> > 
> > -Walt
> > 
> > diff -uprN linux-master-source/drivers/hid/hid-ids.h linux-master-target/drivers/hid/hid-ids.h
> > --- linux-master-source/drivers/hid/hid-ids.h    2023-01-27 15:18:14.000000000 -0600
> > +++ linux-master-target/drivers/hid/hid-ids.h    2023-01-27 15:50:24.077639994 -0600
> > @@ -819,6 +819,7 @@
> >   #define USB_DEVICE_ID_LOGITECH_G510_USB_AUDIO    0xc22e
> >   #define USB_DEVICE_ID_LOGITECH_G29_WHEEL    0xc24f
> >   #define USB_DEVICE_ID_LOGITECH_G920_WHEEL    0xc262
> > +#define USB_DEVICE_ID_LOGITECH_G923_XBOX_WHEEL    0xc26e
> >   #define USB_DEVICE_ID_LOGITECH_WINGMAN_F3D    0xc283
> >   #define USB_DEVICE_ID_LOGITECH_FORCE3D_PRO    0xc286
> >   #define USB_DEVICE_ID_LOGITECH_FLIGHT_SYSTEM_G940    0xc287
> > diff -uprN linux-master-source/drivers/hid/hid-logitech-hidpp.c linux-master-target/drivers/hid/hid-logitech-hidpp.c
> > --- linux-master-source/drivers/hid/hid-logitech-hidpp.c    2023-01-27 15:18:14.000000000 -0600
> > +++ linux-master-target/drivers/hid/hid-logitech-hidpp.c    2023-01-27 15:50:24.077639994 -0600
> > @@ -4347,6 +4347,9 @@ static const struct hid_device_id hidpp_
> >       { /* Logitech G920 Wheel over USB */
> >         HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G920_WHEEL),
> >           .driver_data = HIDPP_QUIRK_CLASS_G920 | HIDPP_QUIRK_FORCE_OUTPUT_REPORTS},
> > +    { /* Logitech G923 Wheel (Xbox version) over USB */
> > +      HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G923_XBOX_WHEEL),
> > +        .driver_data = HIDPP_QUIRK_CLASS_G920 | HIDPP_QUIRK_FORCE_OUTPUT_REPORTS },
> >       { /* Logitech G Pro Gaming Mouse over USB */
> >         HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC088) },
> > 
> Signed off by: Walt Holman (waltholman09@gmail.com)
> 

Thanks a lot for your submission. I wanted to quickly include it in the
kernel, but it seems that the patch is not following the standards:
- "git am" on your patch refuses to take it, saying it is corrupted
  (please use "git format-patch" to generate the proper patch format)
- your patch doesn't have a proper commit description:
  please add a description like "adds support for the Logitech G923 Xbox
  edition steering wheel in hid-logitech-hidpp. We get the same level
  of features than the regular G920". Or anything else as long as we get
  a sensible commit description.

As a general rule of thumb, please follow the doc at [1] to submit your
patches.

Cheers,
Benjamin

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst

