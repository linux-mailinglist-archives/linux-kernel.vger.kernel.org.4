Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F395F4FDB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 08:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiJEGoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 02:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiJEGoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 02:44:05 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43459647D5
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 23:44:04 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id e20so9318687qts.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 23:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=gY5AbX7M1j37Hq5yd7r3xMcaFoABrkHiHudnF2ZVA9g=;
        b=Ot0HusIhlbu/R0cyE0zYoUJOHdl4uPBd89Eeeha2fz8nbt0ivP+7WZWih5tGSLWpBi
         vP8XUJEqmuXC0wfB+ZUKzpDAAB4iDHpwRmVa1XJv2XdktllTDH+0RkLfRpl24Df8lo0L
         2iRFWPfo26MXWs5k52UDJzRNOobaI91y8yeppJoQi4hHaOTT6Ja/rl0kERA9HSvqu65D
         RSKwffM18bxRFuhLhY2EewGHzf+v2MR6KLpFb3I9B5B1M2dYaCRr4hNfC68QwkPZ14Bu
         13Ifm5ycCzUYQ5ey/ZEWyF5qZH4d/39Chv37EosODK4Ebgtvt40jtIWdHmHmewOzDi6L
         /2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=gY5AbX7M1j37Hq5yd7r3xMcaFoABrkHiHudnF2ZVA9g=;
        b=QnxaqRLo2Nu8bEM3XKaYoXG06bswOn/xwsBgpubm41OmH3SOCOU4+Go7SFUy4+nnPa
         ZuuhUjsBfWifspBE9O7Dy/0AQIZUNNHQf5/J6WkdkZH+47L2YfAX02LD+ml26VGiM7XL
         gh9HcRecpgiYL3qhqlMEKj9hzbmOhrXdf2Hcf9tIZsS/whDF2FdCq8N1JNeeA52POs4m
         bl6MzQI/i4mTiVMNhxS0S27dGB/gdfEemcQxRv3v5AeXrw/onSoQ8P8G4AuIVCYWAJgA
         4WuIBkyG9zIEwEYZePaIaVsqljQO5QwFv99zLUM74yKE7ypNwb0eDl3siDmzy/RWqFy3
         vxRQ==
X-Gm-Message-State: ACrzQf3+hSniZpiJtYWOk25SPv/SHYmzBWfwPpU+1Reu4+x4I+oU75mL
        RGwuTE20j6mZwu4J5/vF0PT+35/YKtjwSLOzWtqAXA==
X-Google-Smtp-Source: AMsMyM7+GfuU/rU6V/eza86++pTvyFdHgcHHBJYc3OaM2SElYiMFMyR4/dnQUNQWbxzM6MzY1uJDNmd7ABEhOY646Mw=
X-Received: by 2002:ac8:588c:0:b0:35b:b351:f470 with SMTP id
 t12-20020ac8588c000000b0035bb351f470mr22778816qta.42.1664952243143; Tue, 04
 Oct 2022 23:44:03 -0700 (PDT)
MIME-Version: 1.0
References: <20221004163224.1.I46e98b47be875d0b9abff2d19417c612077d1909@changeid>
 <CABBYNZ+M5KqVvzOT4LjVR2ZzF1cxCxYtJnMLS89ke48FyErjzg@mail.gmail.com>
In-Reply-To: <CABBYNZ+M5KqVvzOT4LjVR2ZzF1cxCxYtJnMLS89ke48FyErjzg@mail.gmail.com>
From:   Archie Pusaka <apusaka@google.com>
Date:   Wed, 5 Oct 2022 14:43:51 +0800
Message-ID: <CAJQfnxF9iMeO+CR3p5hbVP=2wDMzp-6DgOCzyMNXPYH_8gYXuw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Introduce generic USB reset
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@google.com>,
        Ying Hsu <yinghsu@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Luiz,

On Wed, 5 Oct 2022 at 04:53, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Archie,
>
> On Tue, Oct 4, 2022 at 1:33 AM Archie Pusaka <apusaka@google.com> wrote:
> >
> > From: Archie Pusaka <apusaka@chromium.org>
> >
> > On cmd_timeout and there is no reset_gpio, reset the USB port as a
> > last resort.
> >
> > Signed-off-by: Archie Pusaka <apusaka@chromium.org>
> > Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@google.com>
> > Reviewed-by: Ying Hsu <yinghsu@chromium.org>
> >
> > ---
> >
> >  drivers/bluetooth/btusb.c | 26 ++++++++++++++++----------
> >  1 file changed, 16 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index 271963805a38..11040124ef79 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -696,6 +696,19 @@ struct btusb_data {
> >         unsigned cmd_timeout_cnt;
> >  };
> >
> > +static void generic_usb_reset(struct hci_dev *hdev, struct btusb_data *data)
> > +{
> > +       int err;
> > +
> > +       bt_dev_err(hdev, "Resetting usb device.");
> > +       /* This is not an unbalanced PM reference since the device will reset */
> > +       err = usb_autopm_get_interface(data->intf);
> > +       if (!err)
> > +               usb_queue_reset_device(data->intf);
> > +       else
> > +               bt_dev_err(hdev, "Failed usb_autopm_get_interface: %d", err);
>
> Lets just have one line printed if it fails:
>
> err = usb_autopm_get_interface(data->intf);
> if (err) {
>         bt_dev_err(hdev, "Failed usb_autopm_get_interface: %d", err);
>         return;
> }
>
> bt_dev_err(hdev, "Resetting usb device.");
> usb_queue_reset_device(data->intf);
>
OK, will update

> > +}
> > +
> >  static void btusb_intel_cmd_timeout(struct hci_dev *hdev)
> >  {
> >         struct btusb_data *data = hci_get_drvdata(hdev);
> > @@ -705,7 +718,7 @@ static void btusb_intel_cmd_timeout(struct hci_dev *hdev)
> >                 return;
> >
> >         if (!reset_gpio) {
> > -               bt_dev_err(hdev, "No way to reset. Ignoring and continuing");
> > +               generic_usb_reset(hdev, data);
>
> Lets call it btusb_reset since this is specific for the data->intf,
> btw is this safe, or perhaps we want to refactor this to have it
> callback based so each vendor can add it own specific hdev->reset
> callback hardware reset with btusb_reset serving as default callback?

OK. I think this is safe at least for now, since resetting btusb is
probably better than just giving up doing nothing.
But I can add hdev->reset if that is desirable.

> Also the logic of btusb_intel_cmd_timeout should probably be put
> inside btintel.c and I don't think we need the gpio_desc reference to
> be inside the btusb_data since we can call gpiod_get_optional during
> the reset phase and immediately do gpiod_put after done using it.
>
I am not familiar with this part.
Perhaps it's better for this to be managed by another patch, since it
is not the focus of this patch?

> >                 return;
> >         }
> >
> > @@ -736,7 +749,7 @@ static void btusb_rtl_cmd_timeout(struct hci_dev *hdev)
> >                 return;
> >
> >         if (!reset_gpio) {
> > -               bt_dev_err(hdev, "No gpio to reset Realtek device, ignoring");
> > +               generic_usb_reset(hdev, data);
> >                 return;
> >         }
> >
> > @@ -761,7 +774,6 @@ static void btusb_qca_cmd_timeout(struct hci_dev *hdev)
> >  {
> >         struct btusb_data *data = hci_get_drvdata(hdev);
> >         struct gpio_desc *reset_gpio = data->reset_gpio;
> > -       int err;
> >
> >         if (++data->cmd_timeout_cnt < 5)
> >                 return;
> > @@ -787,13 +799,7 @@ static void btusb_qca_cmd_timeout(struct hci_dev *hdev)
> >                 return;
> >         }
> >
> > -       bt_dev_err(hdev, "Multiple cmd timeouts seen. Resetting usb device.");
> > -       /* This is not an unbalanced PM reference since the device will reset */
> > -       err = usb_autopm_get_interface(data->intf);
> > -       if (!err)
> > -               usb_queue_reset_device(data->intf);
> > -       else
> > -               bt_dev_err(hdev, "Failed usb_autopm_get_interface with %d", err);
> > +       generic_usb_reset(hdev, data);
> >  }
> >
> >  static inline void btusb_free_frags(struct btusb_data *data)
> > --
> > 2.38.0.rc1.362.ged0d419d3c-goog
> >
>
>
> --
> Luiz Augusto von Dentz

Cheers,
Archie
