Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47377691B2E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 10:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbjBJJWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 04:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbjBJJW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 04:22:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6425AB15
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 01:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676020902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ksse+DurRPopGoZ4FZY/DGLgBAd9I0EYmRAOwxIALMM=;
        b=ZvTnTrG9InnuXqIyA7RLY215vckMlZMF44WxcdNssqdgmInyl3rswmXMH0x427tM7luJ2J
        8tFPOpWfkTswdS7Zh/g7oPecl2C2wkmQgX7xm+AGDaZXNrfB1CKuZUEiT1HwwQLh67iwzL
        fZc8tG0MYagTGWFiVg5w8wMmnWLAeuM=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-492-YSoQ-LHFNmKkQJOIG-qYpQ-1; Fri, 10 Feb 2023 04:21:41 -0500
X-MC-Unique: YSoQ-LHFNmKkQJOIG-qYpQ-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-52ec696664fso24106077b3.17
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 01:21:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ksse+DurRPopGoZ4FZY/DGLgBAd9I0EYmRAOwxIALMM=;
        b=2Vvu4KXRuUmpwhO6a7sDz4cDoSFcz7JAiWWoMXh5jHgKIlOPa5dHlORWMlJMb64c3b
         peLxf2EpCeKg2te2GR3ZKaDlHE9PsiUYyWxehtRlhRIEyFrqCIJfM7k3MmlrVh+SwKeh
         isKymSwOOILfK5p1fMl4Jwy3qiSnbbWdoBDMWj4IsS8H4dwvWyVWxKmn5CR3VyrCp/dz
         R1ugbOlabmnJ4QEvDFGs75AXdcPs25513Tbfm06SeoaCY1mXWZeKtHJd+h09G6UB6IrB
         BEGOgsavl6rN0h7pavJ0q/EWCgf+Lla7a2kJ9gbspp3gn+oTxPNydtp+LuKP/gych4Qq
         r1Yg==
X-Gm-Message-State: AO0yUKX6wwi4AhTGHcSjHdC4GwHrjo5MFwiBbf0rps/EKG4sv5PDcCZL
        lpaagDFloGibfVwWxBxUMiWRzcxm/3T93uFDYmX9X+fsX4kg/6NGAI4bfbiks3as949hNuu0WPx
        96v80b/bQm3gt2bwMWmwW+TrG6mYTyxea0z1mPGNn
X-Received: by 2002:a81:71c5:0:b0:527:3e8:5a94 with SMTP id m188-20020a8171c5000000b0052703e85a94mr1410856ywc.68.1676020900419;
        Fri, 10 Feb 2023 01:21:40 -0800 (PST)
X-Google-Smtp-Source: AK7set+wN2V5jirysw/3f/ou8nn77wySaS8VWCuwZokIVm0wbfW9gDbTXwm+uRk/CJH2CXUpMMRuwA6XgGJhticwm2A=
X-Received: by 2002:a81:71c5:0:b0:527:3e8:5a94 with SMTP id
 m188-20020a8171c5000000b0052703e85a94mr1410845ywc.68.1676020900147; Fri, 10
 Feb 2023 01:21:40 -0800 (PST)
MIME-Version: 1.0
References: <E5D8BEBA-3C5B-460F-BD2C-39470A793CC3@live.com>
 <40274C3D-4F4F-479C-944C-EEBDC78F959C@live.com> <20230210045624.cjxroikmmvm3liij@t-8ch.de>
 <AC5AB6F5-4D65-4362-A8B8-A694D1371188@live.com> <CAO-hwJK=-9n885crMM8sHFGdNCZfjhqwuQXb2OtgMQiqaoZ66g@mail.gmail.com>
 <B472CABB-5D94-4E15-AE6D-EF8B8BF4CBF3@live.com>
In-Reply-To: <B472CABB-5D94-4E15-AE6D-EF8B8BF4CBF3@live.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 10 Feb 2023 10:21:29 +0100
Message-ID: <CAO-hwJJmVA7fcPBUpVZqKQmaJfk1AMqdh2-ZWXBVWtG2KgHyDw@mail.gmail.com>
Subject: Re: [PATCH 1/3] HID: apple-ibridge: Add Apple iBridge HID driver for
 T1 chip.
To:     Aditya Garg <gargaditya08@live.com>
Cc:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
        Jiri Kosina <jikos@kernel.org>,
        "jkosina@suse.cz" <jkosina@suse.cz>,
        Andy Shevchenko <andy@infradead.org>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "ronald@innovation.ch" <ronald@innovation.ch>,
        "kekrby@gmail.com" <kekrby@gmail.com>,
        Orlando Chamberlain <orlandoch.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 9:54 AM Aditya Garg <gargaditya08@live.com> wrote:
>
>
>
> > On 10-Feb-2023, at 2:09 PM, Benjamin Tissoires <benjamin.tissoires@redh=
at.com> wrote:
> >
> > On Fri, Feb 10, 2023 at 9:30 AM Aditya Garg <gargaditya08@live.com> wro=
te:
> >>
> >>
> >>
> >>> On 10-Feb-2023, at 10:26 AM, Thomas Wei=C3=9Fschuh <thomas@t-8ch.de> =
wrote:
> >>>
> >>> Hi,
> >>>
> >>> some comments inline.
> >>>
> >>> On Fri, Feb 10, 2023 at 03:43:24AM +0000, Aditya Garg wrote:
> >>>> From: Ronald Tschal=C3=A4r <ronald@innovation.ch>
> >>>>
> >>>> The iBridge device provides access to several devices, including:
> >>>> - the Touch Bar
> >>>> - the iSight webcam
> >>>> - the light sensor
> >>>> - the fingerprint sensor
> >>>>
> >>>> This driver provides the core support for managing the iBridge devic=
e
> >>>> and the access to the underlying devices. In particular, the
> >>>> functionality for the touch bar and light sensor is exposed via USB =
HID
> >>>> interfaces, and on devices with the T1 chip one of the HID devices i=
s
> >>>> used for both functions. So this driver creates virtual HID devices,=
 one
> >>>> per top-level report collection on each HID device (for a total of 3
> >>>> virtual HID devices). The sub-drivers then bind to these virtual HID
> >>>> devices.
> >>>>
> >>>> This way the Touch Bar and ALS drivers can be kept in their own modu=
les,
> >>>> while at the same time making them look very much like as if they we=
re
> >>>> connected to the real HID devices. And those drivers then work (most=
ly)
> >>>> without further changes on MacBooks with the T2 chip that don't need
> >>>> this driver.
> >>>>
> >>>> Signed-off-by: Ronald Tschal=C3=A4r <ronald@innovation.ch>
> >>>> [Kerem Karabay: convert to a platform driver]
> >>>> [Kerem Karabay: fix appleib_forward_int_op]
> >>>> [Kerem Karabay: rely on HID core's parsing in appleib_add_device]
> >>>> Signed-off-by: Kerem Karabay <kekrby@gmail.com>
> >>>> Signed-off-by: Aditya Garg <gargaditya08@live.com>
> >>>> ---
> >>>> drivers/hid/Kconfig         |  15 +
> >>>> drivers/hid/Makefile        |   1 +
> >>>> drivers/hid/apple-ibridge.c | 610 ++++++++++++++++++++++++++++++++++=
++
> >>>> drivers/hid/apple-ibridge.h |  15 +
> >>>> drivers/hid/hid-ids.h       |   1 +
> >>>> drivers/hid/hid-quirks.c    |   3 +
> >>>> 6 files changed, 645 insertions(+)
> >>>> create mode 100644 drivers/hid/apple-ibridge.c
> >>>> create mode 100644 drivers/hid/apple-ibridge.h
> >>>>
> >>>
> >>>>
> >>>> +}
> >>>> +
> >>>> +static int appleib_ll_raw_request(struct hid_device *hdev,
> >>>> +   unsigned char reportnum, __u8 *buf,
> >>>> +   size_t len, unsigned char rtype, int reqtype)
> >>>> +{
> >>>> + struct appleib_hid_dev_info *hdev_info =3D hdev->driver_data;
> >>>> +
> >>>> + return hid_hw_raw_request(hdev_info->hdev, reportnum, buf, len, rt=
ype,
> >>>> +   reqtype);
> >>>> +}
> >>>> +
> >>>> +static int appleib_ll_output_report(struct hid_device *hdev, __u8 *=
buf,
> >>>> +     size_t len)
> >>>> +{
> >>>> + struct appleib_hid_dev_info *hdev_info =3D hdev->driver_data;
> >>>> +
> >>>> + return hid_hw_output_report(hdev_info->hdev, buf, len);
> >>>> +}
> >>>> +
> >>>> +static struct hid_ll_driver appleib_ll_driver =3D {
> >>>> + .start =3D appleib_ll_start,
> >>>> + .stop =3D appleib_ll_stop,
> >>>> + .open =3D appleib_ll_open,
> >>>> + .close =3D appleib_ll_close,
> >>>> + .power =3D appleib_ll_power,
> >>>> + .parse =3D appleib_ll_parse,
> >>>> + .request =3D appleib_ll_request,
> >>>> + .wait =3D appleib_ll_wait,
> >>>> + .raw_request =3D appleib_ll_raw_request,
> >>>> + .output_report =3D appleib_ll_output_report,
> >>>> +};
> >>>
> >>> const
> >>
> >> Are you sure about const here?
> >>
> >>>
> >>>> +
> >>>> + if (udev->actconfig->desc.bConfigurationValue !=3D APPLEIB_BASIC_C=
ONFIG) {
> >>>> + rc =3D usb_driver_set_configuration(udev, APPLEIB_BASIC_CONFIG);
> >>>> + return rc ? rc : -ENODEV;
> >>>> + }
> >>>> +
> >>>> + rc =3D hid_parse(hdev);
> >>>> + if (rc) {
> >>>> + hid_err(hdev, "ib: hid parse failed (%d)\n", rc);
> >>>> + goto error;
> >>>> + }
> >>>> +
> >>>> + rc =3D hid_hw_start(hdev, HID_CONNECT_DRIVER);
> >>>> + if (rc) {
> >>>> + hid_err(hdev, "ib: hw start failed (%d)\n", rc);
> >>>> + goto error;
> >>>> + }
> >>>> +
> >>>> + hdev_info =3D appleib_add_device(hdev);
> >>>> + if (IS_ERR(hdev_info)) {
> >>>> + rc =3D PTR_ERR(hdev_info);
> >>>> + goto stop_hw;
> >>>> + }
> >>>> +
> >>>> + hid_set_drvdata(hdev, hdev_info);
> >>>> +
> >>>> + rc =3D hid_hw_open(hdev);
> >>>> + if (rc) {
> >>>> + hid_err(hdev, "ib: failed to open hid: %d\n", rc);
> >>>> + goto remove_dev;
> >>>> + }
> >>>> +
> >>>> + return 0;
> >>>> +
> >>>> +remove_dev:
> >>>> + appleib_remove_device(hdev);
> >>>> +stop_hw:
> >>>> + hid_hw_stop(hdev);
> >>>> +error:
> >>>> + return rc;
> >>>> +}
> >>>> +
> >>>> +static void appleib_hid_remove(struct hid_device *hdev)
> >>>> +{
> >>>> + hid_hw_close(hdev);
> >>>> + appleib_remove_device(hdev);
> >>>> + hid_hw_stop(hdev);
> >>>> +}
> >>>> +
> >>>> +static const struct hid_device_id appleib_hid_ids[] =3D {
> >>>> + { HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_IBRIDGE)=
 },
> >>>> + { },
> >>>> +};
> >>>> +
> >>>> +static struct hid_driver appleib_hid_driver =3D {
> >>>> + .name =3D "apple-ibridge-hid",
> >>>> + .id_table =3D appleib_hid_ids,
> >>>> + .probe =3D appleib_hid_probe,
> >>>> + .remove =3D appleib_hid_remove,
> >>>> + .raw_event =3D appleib_hid_raw_event,
> >>>> + .report_fixup =3D appleib_report_fixup,
> >>>> +#ifdef CONFIG_PM
> >>>> + .suspend =3D appleib_hid_suspend,
> >>>> + .resume =3D appleib_hid_resume,
> >>>> + .reset_resume =3D appleib_hid_reset_resume,
> >>>> +#endif
> >>>> +};
> >>>
> >>> const
> >>
> >> Are you sure you want to do const here, cause other hid-drivers are NO=
T using const.
> >
> > It is scheduled for 6.3:
> > https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git/log/?h=3Dfo=
r-6.3/hid-core
> >
> > So yes, please make them const.
>
> Makes sense for `hid_ll_driver` as per the tree you send me, but I don=E2=
=80=99t see such a thing for
> `static struct hid_driver`. Is that scheduled as well?

Good point. I don't recall having seen such series now that you pinpoint th=
is.

Thomas, is this something you have planned to submit?

Cheers,
Benjamin

>
> >
> > Cheers,
> > Benjamin
> >
> >>
> >>>> +
> >>>> +static struct appleib_device *appleib_alloc_device(struct platform_=
device *pdev)
> >>>> +{
> >>>> + struct appleib_device *ib_dev;
> >>>> + acpi_status sts;
>
>

