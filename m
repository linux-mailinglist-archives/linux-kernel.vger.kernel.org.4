Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B4B6547AC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 22:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiLVVNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 16:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiLVVNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 16:13:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611BC17432
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 13:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671743533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xm3zfx2w0Rv/QhCPp43l1d4YnOjZ2jCv9sko5e0//UM=;
        b=bJTB9IW8hNutoGNtr/2pee1KRhBaoev/XnnBdCxq4tpfeCPm1tK3M8GBGVkfX7QVCmwXo5
        4lnn67IhKK9IiOiXWhvh18GGVSQzvJjaTpzd7nkWBFqikU3piDm1AqlgTU54j51vK49xbQ
        c4zGVuvBguVBo5RHVXmS1ADbVteE1w8=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-539--7g-564UPmCdiJ5DEETQMQ-1; Thu, 22 Dec 2022 16:12:12 -0500
X-MC-Unique: -7g-564UPmCdiJ5DEETQMQ-1
Received: by mail-io1-f69.google.com with SMTP id w18-20020a5d9cd2000000b006e32359d7fcso1183857iow.15
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 13:12:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xm3zfx2w0Rv/QhCPp43l1d4YnOjZ2jCv9sko5e0//UM=;
        b=tpFpHFTAXa+JrKip958YPySGoSCEwN8s66rhBySIaUgluOveCVhlWEjtC9mg0VuvzN
         TkHmztA8dKR2dl6VJQVllZYKFS1ag65/Q9QDokkEXIcgF5rOGDwRc9wzmpMzUVY518IK
         0xH+RAYVHIbMLurhjJKkPXVD4eMYnOl+PED5tlt9Pno6EFjX2hr1NRKpAm2OHO+tFf8K
         Gw5h5EnyIqxlIUlho8XoMbeZdDhXpgXiUKgbYid7fgHy9FpWJthMjQUxyydFA2xou4nl
         8WiiOZNruh+ehpWZblYMaLiTTTC/twSLLLZhU8OsEpYgwXmWcuDUnjAWXqVNf9K+QXYR
         F9JA==
X-Gm-Message-State: AFqh2kqQAecpqFbafAKWOa969IOko7WuZBCu58DJHDnBRUT2utCI3Bhc
        HjHnXVxQjD9nLwB2JLGK4JWYavpi62kQyZ0jOyREClzy+vt3nOXsM/BsMWg2EW8bNF4ZN0mjLzh
        xw6paeslXHER3wytiCLaJsmom9NekQtgM2OYnB9QM
X-Received: by 2002:a02:cbb4:0:b0:39d:2ab3:d819 with SMTP id v20-20020a02cbb4000000b0039d2ab3d819mr548723jap.221.1671743531394;
        Thu, 22 Dec 2022 13:12:11 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvZEz2ocbnnyvLr+TW4iQ7/91FUvUfuHg4WGWFgzaujg/CI4SQoqrB0K05HszUkil3yhVFotx6AXjwacX9EPiU=
X-Received: by 2002:a02:cbb4:0:b0:39d:2ab3:d819 with SMTP id
 v20-20020a02cbb4000000b0039d2ab3d819mr548714jap.221.1671743531178; Thu, 22
 Dec 2022 13:12:11 -0800 (PST)
MIME-Version: 1.0
References: <20221222-hid-v1-0-f4a6c35487a5@weissschuh.net> <20221222-hid-v1-2-f4a6c35487a5@weissschuh.net>
In-Reply-To: <20221222-hid-v1-2-f4a6c35487a5@weissschuh.net>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 22 Dec 2022 22:12:00 +0100
Message-ID: <CAO-hwJL+zenkC+qPuPWLO-dFkg_pWoGTQYXR5mzSqUrnX6MObA@mail.gmail.com>
Subject: Re: [PATCH 2/8] HID: usbhid: Make hid_is_usb() non-inline
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        David Rheinsberg <david.rheinsberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 6:16 AM Thomas Wei=C3=9Fschuh <linux@weissschuh.net=
> wrote:
>
> By making hid_is_usb() a non-inline function the lowlevel usbhid driver
> does not have to be exported anymore.
>
> Also mark the argument as const as it is not modified.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---
>  drivers/hid/usbhid/hid-core.c | 6 ++++++
>  include/linux/hid.h           | 5 +----
>  2 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.=
c
> index be4c731aaa65..54b0280d0073 100644
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -1334,6 +1334,12 @@ struct hid_ll_driver usb_hid_driver =3D {
>  };
>  EXPORT_SYMBOL_GPL(usb_hid_driver);
>
> +bool hid_is_usb(const struct hid_device *hdev)
> +{
> +       return hdev->ll_driver =3D=3D &usb_hid_driver;
> +}
> +EXPORT_SYMBOL_GPL(hid_is_usb);
> +
>  static int usbhid_probe(struct usb_interface *intf, const struct usb_dev=
ice_id *id)
>  {
>         struct usb_host_interface *interface =3D intf->cur_altsetting;
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index 8677ae38599e..e8400aa78522 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -864,10 +864,7 @@ static inline bool hid_is_using_ll_driver(struct hid=
_device *hdev,
>         return hdev->ll_driver =3D=3D driver;
>  }
>
> -static inline bool hid_is_usb(struct hid_device *hdev)
> -{
> -       return hid_is_using_ll_driver(hdev, &usb_hid_driver);
> -}
> +extern bool hid_is_usb(const struct hid_device *hdev);

The problem here is that CONFIG_USB_HID can be set to either m or n.
In the n case, you'll end up with an undefined symbol, in the m case,
it won't link too if CONFIG_HID is set to Y (and it'll be quite a mess
to call it if the module is not loaded yet).

Cheers,
Benjamin


>
>
>  #define        PM_HINT_FULLON  1<<5
>  #define PM_HINT_NORMAL 1<<1
>
> --
> 2.39.0
>

