Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CF95F7E07
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 21:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiJGTeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 15:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJGTeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 15:34:01 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133D4BC60E;
        Fri,  7 Oct 2022 12:34:00 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id bn8so6835873ljb.6;
        Fri, 07 Oct 2022 12:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QtS1o7ZM2YgF2GXs993wWNlA4xjsIHvbfmEx/5K+0ys=;
        b=oLTsLLIRHa469/sp9g8M1izhVH+XprkuZfwEtpM/f9oh1eYN2SwLDcg6eMofGrXOD0
         VLT2WBQTfMTyxOgADXIUAMSl/3qFuO/s7LVI8HhBNn98euIVTHg6fDISKWI8It2aDpSo
         idm4S4jLWnAsC3EvbIbFYhAJ7pZEGdR6KXZTS/+MuvbqR9KDDPFL1DkBgltwCQxVd/A0
         NTohnClC2E2TVqREVhAVZKvW/ij/XOq4Ig/eN2yXr3K8rljOQ9STQ+fhIAdnLHqrm4D1
         kQpE8nCkFctC3k5YMvkIFJb7nIPu7kPhsSudRWHP24/s6EtDlaCGhNETDVgC6CWCA1vt
         OjRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QtS1o7ZM2YgF2GXs993wWNlA4xjsIHvbfmEx/5K+0ys=;
        b=XeKJplLH41IP+DhwNTM+AyjgmZi4ONMPFDlyRXdcsOXEATSUnGxIET2M4I3fPMhIDo
         0lY8RPjttivgg84k7gUmtBoaR3Z06GN0Ncf//chWHgb/yv5ykCldPYyFLffkUzyEMH3u
         AxHLb3m7grZd19Qn2gVmPIaQpx7gwXSBem7pVPNIJVs2t7pRYiFOezekwml5hXHqUe9e
         y9AzFY8ev82nrFX2GXmjcS08OIThsP88H2+OkSkAHxhvWbmrbsMQuV7wn4RD2zhsXaXU
         hpXDufYKkGZTevF+ZfsuNhU9acSnPPTWf2FPtNyEJR4NrvDu3vKkkP5Xdz6/SCnwxldS
         kTCA==
X-Gm-Message-State: ACrzQf3BoqqdPt/wc5hyUREtV0dKTxf2e8pL8WsR2PtIjM5D9+TAbcJd
        ejmZib6hNNbrKRc7qrZBNemEGqWUipiF5asS8fY=
X-Google-Smtp-Source: AMsMyM5Y8hz2zCDNOF7AQDInxjpA7Mjg4A4qiKR79VFmU44L6j9VrLmUPF9kKQRokpDMciv1XCfLdhs1mHDCpUiaJ8I=
X-Received: by 2002:a2e:b74f:0:b0:26c:426c:60fc with SMTP id
 k15-20020a2eb74f000000b0026c426c60fcmr2353785ljo.432.1665171238234; Fri, 07
 Oct 2022 12:33:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220807221152.38948-1-Igor.Skalkin@opensynergy.com>
 <20220807185846-mutt-send-email-mst@kernel.org> <02222fcb-eaba-617a-c51c-f939678e3d74@opensynergy.com>
 <20221007090223-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221007090223-mutt-send-email-mst@kernel.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 7 Oct 2022 12:33:46 -0700
Message-ID: <CABBYNZKfLOxrTAVLRSH+hOwaB5RYkGdjbtfabufUcgR3oy897A@mail.gmail.com>
Subject: Re: [PATCH] virtio_bt: Fix alignment in configuration struct
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Igor Skalkin <igor.skalkin@opensynergy.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, mgo@opensynergy.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Fri, Oct 7, 2022 at 6:03 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Aug 08, 2022 at 02:04:43PM +0200, Igor Skalkin wrote:
> > On 8/8/22 01:00, Michael S. Tsirkin wrote:
> >
> >     On Mon, Aug 08, 2022 at 12:11:52AM +0200, Igor Skalkin wrote:
> >
> >         According to specification [1], "For the device-specific config=
uration
> >         space, the driver MUST use 8 bit wide accesses for 8 bit wide f=
ields,
> >         16 bit wide and aligned accesses for 16 bit wide fields and 32 =
bit wide
> >         and aligned accesses for 32 and 64 bit wide fields.".
> >
> >         Current version of the configuration structure:
> >
> >             struct virtio_bt_config {
> >                 __u8  type;
> >                 __u16 vendor;
> >                 __u16 msft_opcode;
> >             } __attribute__((packed));
> >
> >         has both 16bit fields non-aligned.
> >
> >         This commit fixes it.
> >
> >         [1] https://ddec1-0-en-ctp.trendmicro.com:443/wis/clicktime/v1/=
query?url=3Dhttps%3a%2f%2fdocs.oasis%2dopen.org%2fvirtio%2fvirtio%2fv1.1%2f=
virtio%2dv1.1.pdf&umid=3Dd1786ace-e8ea-40e8-9665-96c0949174e5&auth=3D53c7c7=
de28b92dfd96e93d9dd61a23e634d2fbec-39b15885ceebe9fda9357320aec1ccbac416a470
> >
> >         Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
> >
> >     This is all true enough, but the problem is
> >     1. changing uapi like this can't be done, will break userspace
> >     2. the driver has more issues and no one seems to want to
> >        maintain it.
> >     I posted a patch "Bluetooth: virtio_bt: mark broken" and intend
> >     to merge it for this release.
> >
> > This is very sad. We already use this driver in our projects.
>
> Ping. If we still have no maintainer I'm marking it broken, users
> should at least be warned.

Please resend.

>
> > Our virtio bluetooth device has two backends - HCI_USER socket backend =
for one
> > platform and uart backend for the other, and works well (after applying=
 your
> > "[PATCH] Bluetooth: virtio_bt: fix device remove") patch, so this "devi=
ce
> > removal" problem can probably be considered solved .
> > We could help with the rest of the problems you listed that can be solv=
ed
> > (specification, QEMU support).
> > And the only problem that is difficult to solve (because of the need to=
 change
> > UAPI header files) is just this one with unaligned configuration fields=
.
> > At the moment, it does not reproduce, because without VIRTIO_BT_F_VND_H=
CI
> > (Indicates vendor command support) feature negotiated, the driver does =
not
> > read the non-aligned configuration fields.
> >
> > So, what would you advise us to do? Continuing to use the "marked broke=
n"
> > driver, start writing a specification for a new from scratch, better on=
e?
> > Or is there any way to bring this one back to life?
> >
> >
> >
> >         ---
> >          include/uapi/linux/virtio_bt.h | 2 +-
> >          1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >         diff --git a/include/uapi/linux/virtio_bt.h b/include/uapi/linu=
x/virtio_bt.h
> >         index a7bd48daa9a9..adc03709cc4f 100644
> >         --- a/include/uapi/linux/virtio_bt.h
> >         +++ b/include/uapi/linux/virtio_bt.h
> >         @@ -23,9 +23,9 @@ enum virtio_bt_config_vendor {
> >          };
> >
> >          struct virtio_bt_config {
> >         -       __u8  type;
> >                 __u16 vendor;
> >                 __u16 msft_opcode;
> >         +       __u8  type;
> >          } __attribute__((packed));
> >
> >          #endif /* _UAPI_LINUX_VIRTIO_BT_H */
> >         --
> >         2.34.1
> >
> > --
> >
> > Best regards,
> >
> > Igor Skalkin
> > Software Engineer
> >
> > OpenSynergy GmbH
> > Rotherstr. 20, 10245 Berlin
> >
> > igor.skalkin@opensynergy.com
> > www.opensynergy.com
> >
> > registered: Amtsgericht Charlottenburg, HRB 108616B
> > General Management: Rolf Morich, Stefaan Sonck Thiebaut
> >
> >
> > Please mind our privacy notice pursuant to Art. 13 GDPR. // Unsere Hinw=
eise zum
> > Datenschutz gem. Art. 13 DSGVO finden Sie hier.
>


--=20
Luiz Augusto von Dentz
