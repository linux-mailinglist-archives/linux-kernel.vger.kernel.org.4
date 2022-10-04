Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139E45F4055
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiJDJvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiJDJvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:51:14 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAAD62CA
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 02:49:46 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1326637be6eso6199951fac.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 02:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=9xXwlJickjL5rEnB4sVoWH/A2L/KfsumqDvae/aJh1g=;
        b=VPZB9c1tP8hehChiMZ0JfBLF5K01puyWWC8UoaOqB4Q6KV30Wa3t3mh19hh1j2VtVj
         A844YrdyqofCY+JskIFbNTPiakr2BAF3qYVL9QFbhywGRlSi3HDn8chcoByWDK1RBhkd
         dSWsoBxC6l09xGZm9jncY8Lb4G9cukNUBxv2LLuGfiGOU/nrPDoR2GdVYNxtNufJTswS
         PdQtAlf5Lhu078N7rXez2fkPdKBa3Bvj/udsrOEIGfLzBrUX2Uma5e4GhTHtUa0c6oKd
         Hw7PpAA/TXrtPLCkR2qEdPpJal5CvTftW3T6pTX7vE0sdHlcOYkM6fRD8Zo8NGyxbAvr
         FgPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=9xXwlJickjL5rEnB4sVoWH/A2L/KfsumqDvae/aJh1g=;
        b=b7RSJ2VtecBbz7C/AbDE9DOITtA1y+Fhen4Pn8sFc4H11QoC4HYLOzzbPREKPRuMWG
         quOj8h2FFW1QcHtZ0A6XqK6L0ALdgtADREYbzi87j7vj4bnTDec9tNOzF1e3PnYvypaO
         AXD0TtbsdzF4w+Z/JubIYOqvondqZkxORUpDJkOlEMe9qdovwa6CyJpxQdGOT5s5sx4R
         oK6Nivn6LU9vFs3uTBl9pswFXVBkkzbH9dU/WrG4jgW6l1fTj/hzXRInARIqyoktPQRc
         BSECCWJhGYgqKMNJ++8wa47lWXdMSrFdsYebwrgEmgO9/X5HvwkfpRAIeKhYQQ3LuMqy
         apwg==
X-Gm-Message-State: ACrzQf1Z7lyaXnK6EhN6DlualF7CSjc83SOKV93R26Q7HxP/Ac5/Y0U5
        8O0xwJP/Agfh2u7vhIkFbPyb4Z/x97vcMUa8KcxkwA==
X-Google-Smtp-Source: AMsMyM4HzvW6Ewo5gBCLbXXkYl1uX8BiKdh83Xb9I2ffYm7gcwLAd/iLZxVLh8fWg8TKpRwSgPKp1jBgfWg6FWLIhw4=
X-Received: by 2002:a05:6870:160f:b0:131:e2c3:8fe3 with SMTP id
 b15-20020a056870160f00b00131e2c38fe3mr7529516oae.54.1664876985452; Tue, 04
 Oct 2022 02:49:45 -0700 (PDT)
MIME-Version: 1.0
References: <20221004163224.1.I46e98b47be875d0b9abff2d19417c612077d1909@changeid>
 <96d37e06-3bba-ee4a-d81d-f784aa7dbf03@molgen.mpg.de>
In-Reply-To: <96d37e06-3bba-ee4a-d81d-f784aa7dbf03@molgen.mpg.de>
From:   Archie Pusaka <apusaka@google.com>
Date:   Tue, 4 Oct 2022 17:49:34 +0800
Message-ID: <CAJQfnxFxfYjcCUhScFpeJH57izuNOKLV-Bu02gCa=yJt8hYTRg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Introduce generic USB reset
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-bluetooth@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        chromeos-bluetooth-upstreaming@chromium.org,
        Archie Pusaka <apusaka@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@google.com>,
        Ying Hsu <yinghsu@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Tue, 4 Oct 2022 at 17:18, Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Archie,
>
>
> Thank you for the patch.
>
> Am 04.10.22 um 10:32 schrieb Archie Pusaka:
> > From: Archie Pusaka <apusaka@chromium.org>
> >
> > On cmd_timeout and there is no reset_gpio, reset the USB port as a
>
> Maybe:
>
> s/there is no/with no/g
>
> > last resort.
>
> Can you please document your test setup, and also mention that you
> change the behavior of:
>
> 1.  btusb_intel_cmd_timeout
> 2.  btusb_rtl_cmd_timeout
>
> [=E2=80=A6]
>
>
> Kind regards,
>
> Paul

Thanks for the input!
All done, uploaded v2. PTAL, thanks!

>
>
> > Signed-off-by: Archie Pusaka <apusaka@chromium.org>
> > Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@google.com>
> > Reviewed-by: Ying Hsu <yinghsu@chromium.org>
> >
> > ---
> >
> >   drivers/bluetooth/btusb.c | 26 ++++++++++++++++----------
> >   1 file changed, 16 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index 271963805a38..11040124ef79 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -696,6 +696,19 @@ struct btusb_data {
> >       unsigned cmd_timeout_cnt;
> >   };
> >
> > +static void generic_usb_reset(struct hci_dev *hdev, struct btusb_data =
*data)
> > +{
> > +     int err;
> > +
> > +     bt_dev_err(hdev, "Resetting usb device.");
> > +     /* This is not an unbalanced PM reference since the device will r=
eset */
> > +     err =3D usb_autopm_get_interface(data->intf);
> > +     if (!err)
> > +             usb_queue_reset_device(data->intf);
> > +     else
> > +             bt_dev_err(hdev, "Failed usb_autopm_get_interface: %d", e=
rr);
> > +}
> > +
> >   static void btusb_intel_cmd_timeout(struct hci_dev *hdev)
> >   {
> >       struct btusb_data *data =3D hci_get_drvdata(hdev);
> > @@ -705,7 +718,7 @@ static void btusb_intel_cmd_timeout(struct hci_dev =
*hdev)
> >               return;
> >
> >       if (!reset_gpio) {
> > -             bt_dev_err(hdev, "No way to reset. Ignoring and continuin=
g");
> > +             generic_usb_reset(hdev, data);
> >               return;
> >       }
> >
> > @@ -736,7 +749,7 @@ static void btusb_rtl_cmd_timeout(struct hci_dev *h=
dev)
> >               return;
> >
> >       if (!reset_gpio) {
> > -             bt_dev_err(hdev, "No gpio to reset Realtek device, ignori=
ng");
> > +             generic_usb_reset(hdev, data);
> >               return;
> >       }
> >
> > @@ -761,7 +774,6 @@ static void btusb_qca_cmd_timeout(struct hci_dev *h=
dev)
> >   {
> >       struct btusb_data *data =3D hci_get_drvdata(hdev);
> >       struct gpio_desc *reset_gpio =3D data->reset_gpio;
> > -     int err;
> >
> >       if (++data->cmd_timeout_cnt < 5)
> >               return;
> > @@ -787,13 +799,7 @@ static void btusb_qca_cmd_timeout(struct hci_dev *=
hdev)
> >               return;
> >       }
> >
> > -     bt_dev_err(hdev, "Multiple cmd timeouts seen. Resetting usb devic=
e.");
> > -     /* This is not an unbalanced PM reference since the device will r=
eset */
> > -     err =3D usb_autopm_get_interface(data->intf);
> > -     if (!err)
> > -             usb_queue_reset_device(data->intf);
> > -     else
> > -             bt_dev_err(hdev, "Failed usb_autopm_get_interface with %d=
", err);
> > +     generic_usb_reset(hdev, data);
> >   }
> >
> >   static inline void btusb_free_frags(struct btusb_data *data)

Cheers,
Archie
