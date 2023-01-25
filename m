Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2D167AF80
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 11:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235023AbjAYKTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 05:19:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbjAYKTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 05:19:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D582B37543
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 02:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674641907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TlcjdODWqojRJNrRfpiByy7Z0dDf4IDNUwL8/r9qais=;
        b=Bn7KC/pAmgVmr3416DApxUHV2cEsA0WTj076P855U0ibx+Nfabo4dyCqvqHaiW7xNeYYnP
        AhOCNOszOLFLT/UeItQfUbAJR3ptgkwe76HXZgF1HtodwMGVudiY20p+HDu7JVZnMbJq/k
        +VXzgta3Nxt3+avY+TfRsKtCbhDvhW0=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-167-KLUSCK8ON7ikr0ZZRIA2qg-1; Wed, 25 Jan 2023 05:18:18 -0500
X-MC-Unique: KLUSCK8ON7ikr0ZZRIA2qg-1
Received: by mail-yb1-f198.google.com with SMTP id 2-20020a250b02000000b0080b9a77383fso1928218ybl.22
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 02:18:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TlcjdODWqojRJNrRfpiByy7Z0dDf4IDNUwL8/r9qais=;
        b=Tg++2RoPOhZz1e08S2WcL2/8+W8hGa/trp+02chzQKw5LWu2uqY48TKmqK2iZiTrJq
         TrXdCXr1kk+3uTWBnZqc154nKG/6Ks1yY7LPNdmUYEAlDj94ZxXyphFAcSwGiMVHlqlW
         9Fb0YBQVAebFDBlqMBXXhgg8y8UB7IOGfW/v2nS9bBO983H3bjl79OqMyDOLcfF3YuDx
         2NS1bmaZOMAUwtRTm0p57zHm3FhV/RDyHnOGIvSavPQ/K2JugtFPVRjKXgOLEIPnKbLM
         bc/bxo1SfsI5ynlOY3S1g7FU27t7M5WC4HMmxwhsQiF/xF1YQZROmgGa9mragT+oQJXm
         qplw==
X-Gm-Message-State: AFqh2kqOY0HLIN2iHIPOGNixvYH3IAylPYuKKgLlBrNwTKi/JsEOiZ2h
        WBG20UoImMXRwWYudUz4DtfMjI7/9Hdbklz0TKREHTBFR5fcgD37EmgFeBfjMuZ5ELNHmGpJf4j
        orMOl7OoTwygzGMN683AkbXEveDxU+pi1zrd05QTe
X-Received: by 2002:a25:b94d:0:b0:801:e503:dd0c with SMTP id s13-20020a25b94d000000b00801e503dd0cmr1633455ybm.384.1674641897000;
        Wed, 25 Jan 2023 02:18:17 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvfnJiCb9f0wuIflc1pIHfh46sevA0ev0xwdmK+b5QMrMqam704CgWlQm/C+Aao1/PX9VMQgFqBHlFUTsiUTpE=
X-Received: by 2002:a25:b94d:0:b0:801:e503:dd0c with SMTP id
 s13-20020a25b94d000000b00801e503dd0cmr1633454ybm.384.1674641896780; Wed, 25
 Jan 2023 02:18:16 -0800 (PST)
MIME-Version: 1.0
References: <20221220092207.428640-1-hadess@hadess.net> <20221220092207.428640-2-hadess@hadess.net>
 <a75e34efce22ab1de8f0a2e247294a441e710193.camel@hadess.net>
In-Reply-To: <a75e34efce22ab1de8f0a2e247294a441e710193.camel@hadess.net>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 25 Jan 2023 11:18:05 +0100
Message-ID: <CAO-hwJJb+hkCpqbiF0Zw8Ot4aCJDpgvMXpVS6rCoMe7QWkhiCg@mail.gmail.com>
Subject: Re: [PATCH 2/3] HID: logitech-hidpp: Don't restart communication if
 not necessary
To:     Bastien Nocera <hadess@hadess.net>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Kosina <jikos@kernel.org>,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 6:20 PM Bastien Nocera <hadess@hadess.net> wrote:
>
> On Tue, 2022-12-20 at 10:22 +0100, Bastien Nocera wrote:
> > Don't stop and restart communication with the device unless we need
> > to
> > modify the connect flags used because of a device quirk.
>
> FIWW, Andreas Bergmeier told me off-list that this fixed their problem
> with the Litra Glow not connecting properly.
>
> Would be great to have reviews on this and my other HID++ patches.

Sigh. I reviewed the patches just now (well, v2 at least), and thought
I better give a shot at it before merging, and it turns out that this
patch breaks the Unifying receivers.

Without it, each device presented to the user space has a proper name:

logitech-hidpp-device 0003:046D:4041.001C: input,hidraw15: USB HID
v1.11 Keyboard [Logitech MX Master] on usb-0000:01:00.0-4/input2:5

But with it, I get:

logitech-hidpp-device 0003:046D:4041.0024: input,hidraw8: USB HID
v1.11 Keyboard [Logitech Wireless Device PID:4041] on
usb-0000:00:14.0-8.2.4/input2:5

This is because we present the device to the userspace before being
able to fetch the name from the receiver.

I think we should make that connect/disconnect a special case of the
receivers too. Or maybe if the bus is not Bluetooth or USB, do the
disconnect/reconnect.

Cheers,
Benjamin

>
> Cheers
>
> > ---
> >  drivers/hid/hid-logitech-hidpp.c | 31 +++++++++++++++++++-----------
> > -
> >  1 file changed, 19 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-
> > logitech-hidpp.c
> > index 7f9187201913..b4e4a8c79c75 100644
> > --- a/drivers/hid/hid-logitech-hidpp.c
> > +++ b/drivers/hid/hid-logitech-hidpp.c
> > @@ -4310,6 +4310,7 @@ static int hidpp_probe(struct hid_device *hdev,
> > const struct hid_device_id *id)
> >         bool connected;
> >         unsigned int connect_mask = HID_CONNECT_DEFAULT;
> >         struct hidpp_ff_private_data data;
> > +       bool will_restart = false;
> >
> >         /* report_fixup needs drvdata to be set before we call
> > hid_parse */
> >         hidpp = devm_kzalloc(&hdev->dev, sizeof(*hidpp), GFP_KERNEL);
> > @@ -4360,6 +4361,9 @@ static int hidpp_probe(struct hid_device *hdev,
> > const struct hid_device_id *id)
> >                         return ret;
> >         }
> >
> > +       if (hidpp->quirks & HIDPP_QUIRK_DELAYED_INIT)
> > +               will_restart = true;
> > +
> >         INIT_WORK(&hidpp->work, delayed_work_cb);
> >         mutex_init(&hidpp->send_mutex);
> >         init_waitqueue_head(&hidpp->wait);
> > @@ -4374,7 +4378,7 @@ static int hidpp_probe(struct hid_device *hdev,
> > const struct hid_device_id *id)
> >          * Plain USB connections need to actually call start and open
> >          * on the transport driver to allow incoming data.
> >          */
> > -       ret = hid_hw_start(hdev, 0);
> > +       ret = hid_hw_start(hdev, will_restart ? 0 : connect_mask);
> >         if (ret) {
> >                 hid_err(hdev, "hw start failed\n");
> >                 goto hid_hw_start_fail;
> > @@ -4411,6 +4415,7 @@ static int hidpp_probe(struct hid_device *hdev,
> > const struct hid_device_id *id)
> >                         hidpp->wireless_feature_index = 0;
> >                 else if (ret)
> >                         goto hid_hw_init_fail;
> > +               ret = 0;
> >         }
> >
> >         if (connected && (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP)) {
> > @@ -4425,19 +4430,21 @@ static int hidpp_probe(struct hid_device
> > *hdev, const struct hid_device_id *id)
> >
> >         hidpp_connect_event(hidpp);
> >
> > -       /* Reset the HID node state */
> > -       hid_device_io_stop(hdev);
> > -       hid_hw_close(hdev);
> > -       hid_hw_stop(hdev);
> > +       if (will_restart) {
> > +               /* Reset the HID node state */
> > +               hid_device_io_stop(hdev);
> > +               hid_hw_close(hdev);
> > +               hid_hw_stop(hdev);
> >
> > -       if (hidpp->quirks & HIDPP_QUIRK_NO_HIDINPUT)
> > -               connect_mask &= ~HID_CONNECT_HIDINPUT;
> > +               if (hidpp->quirks & HIDPP_QUIRK_NO_HIDINPUT)
> > +                       connect_mask &= ~HID_CONNECT_HIDINPUT;
> >
> > -       /* Now export the actual inputs and hidraw nodes to the world
> > */
> > -       ret = hid_hw_start(hdev, connect_mask);
> > -       if (ret) {
> > -               hid_err(hdev, "%s:hid_hw_start returned error\n",
> > __func__);
> > -               goto hid_hw_start_fail;
> > +               /* Now export the actual inputs and hidraw nodes to
> > the world */
> > +               ret = hid_hw_start(hdev, connect_mask);
> > +               if (ret) {
> > +                       hid_err(hdev, "%s:hid_hw_start returned
> > error\n", __func__);
> > +                       goto hid_hw_start_fail;
> > +               }
> >         }
> >
> >         if (hidpp->quirks & HIDPP_QUIRK_CLASS_G920) {
>

