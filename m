Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33586337F5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 10:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbiKVJHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 04:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233174AbiKVJHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 04:07:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C502B1659B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 01:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669107975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wXCLVuWe4heHUFwjtIeuGbx591KChmJODX4iIb4c9Gw=;
        b=TshBEE3bagV1ObKt0m1zjuLeoFfIaCBwZDCazoHeoDUi39VADNbztE0CN/1rVjBoXBWVJD
        ZD3OeytY1gvIKkAGEGNJOIld6kYS57ogTbLminoUP3Mts6pvSrAQyd9t5DwKJlmfadX+3M
        575QZL+Gignw0lQFD284KFmTstrXDE8=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-583-oi0-7pQJNS6_GWozuQz5FQ-1; Tue, 22 Nov 2022 04:06:13 -0500
X-MC-Unique: oi0-7pQJNS6_GWozuQz5FQ-1
Received: by mail-il1-f197.google.com with SMTP id y12-20020a056e021bec00b00302a7d5bc83so8347306ilv.16
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 01:06:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wXCLVuWe4heHUFwjtIeuGbx591KChmJODX4iIb4c9Gw=;
        b=4Jc829I5g0zA1HEkiRP/ZUcCYziKBnpz253vKTGxmkfH+eryTEPeGeusJlRKNHLTKf
         mRS64rumRbOBk6gcI8t5+0e9tOwT0rsuJZgE5y/NgvApW80bJgh2BPYxkO/k6NkfRgUv
         d8HG/mW1BXNApTqbejMGm5H/tCcW7OpkmBZHUV8qtM+GgAp6aqSHE+zk6tl+iAbPOUlM
         T6Li+enHbeVcmV0TfWivTQVWi183cQzeyLjWExZgT52xL4OquYeaG2tNrbu9b9FNzBeJ
         e3kuXZQFIJNsMpS4JGsitKF86NSZ85B+NXKdqRNjj4v321SsL9UAIKg+KBB0ph28jc3F
         mn9w==
X-Gm-Message-State: ANoB5plKfTDZ/zgaudq4xLzS9+f2uuMbKDvsqjqWv3fqzqgl7ILBfwVj
        H7l35nPX4L5MqBwyEYiOnwimIUIg95HS5tQI2uYH/SR9xtuoxoEWRCnU2YDWmdnh/vLk7WhtchU
        bWTkid9SnmA2IqgtTfV/vWIRM/zBpkUVK08t1DbX0
X-Received: by 2002:a02:a089:0:b0:375:2a78:73fd with SMTP id g9-20020a02a089000000b003752a7873fdmr9902542jah.217.1669107973168;
        Tue, 22 Nov 2022 01:06:13 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5XLS+3PYA1IYMmdQ1qcqimc0kUtHimM+dxwtQiTWi3mGlBhbBtZRrTK8mQms5cphCXnrDZPZ6Sm1TrCQKNxxk=
X-Received: by 2002:a02:a089:0:b0:375:2a78:73fd with SMTP id
 g9-20020a02a089000000b003752a7873fdmr9902539jah.217.1669107972919; Tue, 22
 Nov 2022 01:06:12 -0800 (PST)
MIME-Version: 1.0
References: <20221122034246.24408-1-yuehaibing@huawei.com> <29fb52c0-155b-470e-10d5-5e3b2451272d@molgen.mpg.de>
In-Reply-To: <29fb52c0-155b-470e-10d5-5e3b2451272d@molgen.mpg.de>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 22 Nov 2022 10:06:01 +0100
Message-ID: <CAO-hwJKraiox13k=ukXOhSNt9sTc6Q0KpGR5=AHDknZeR6omwA@mail.gmail.com>
Subject: Re: [PATCH -next] Bluetooth: Fix Kconfig warning for BT_HIDP
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     YueHaibing <yuehaibing@huawei.com>, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        jkosina@suse.cz, gregkh@linuxfoundation.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Hi,

On Tue, Nov 22, 2022 at 9:37 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear YueHaibing,
>
>
> Thank you for your patch.
>
>
> Am 22.11.22 um 04:42 schrieb YueHaibing:
>
> Maybe use the more specific summary below:
>
> Bluetooth: Add HID_SUPPORT dependency for BT_HIDP
>
> > commit 25621bcc8976 add HID_SUPPORT, and HID depends on it now.
>
> add*s*
>
> or
>
> Commit 25621bcc8976 ("HID: Kconfig: split HID support and hid-core
> compilation") introduces the new Kconfig symbol HID_SUPPORT =E2=80=A6
>
>
> Kind regards,
>
> Paul
>
>
> > Add HID_SUPPORT dependency for BT_HIDP to fix the warning:
> >
> > WARNING: unmet direct dependencies detected for HID
> >    Depends on [n]: HID_SUPPORT [=3Dn]
> >    Selected by [m]:
> >    - BT_HIDP [=3Dm] && NET [=3Dy] && BT_BREDR [=3Dy] && INPUT [=3Dm]
> >
> > Fixes: 25621bcc8976 ("HID: Kconfig: split HID support and hid-core comp=
ilation")
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > ---


FWIW, a fix is already in -next:
https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git/commit/?h=3Dfor=
-6.2/hid-bpf&id=3D6cc90ccd4f6cfed98e2a3a378debc69f28d57473

 But thanks for the patch nonetheless!

Cheers,
Benjamin

>
> >   net/bluetooth/hidp/Kconfig | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/bluetooth/hidp/Kconfig b/net/bluetooth/hidp/Kconfig
> > index 14100f341f33..6746be07e222 100644
> > --- a/net/bluetooth/hidp/Kconfig
> > +++ b/net/bluetooth/hidp/Kconfig
> > @@ -1,7 +1,7 @@
> >   # SPDX-License-Identifier: GPL-2.0-only
> >   config BT_HIDP
> >       tristate "HIDP protocol support"
> > -     depends on BT_BREDR && INPUT
> > +     depends on BT_BREDR && INPUT && HID_SUPPORT
> >       select HID
> >       help
> >         HIDP (Human Interface Device Protocol) is a transport layer
>

