Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688446E66EE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 16:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbjDROSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 10:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjDROSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 10:18:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A27DE7F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 07:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681827431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D7E0f97enKWeGm4kBxYLE/5HBvfl7WhJLhN+ZbF/ZnM=;
        b=hRwVDqXzsolzQzY+lgB/Jj7Cq062GtWQ4EPytYOFQZuBiDChvrwqtF6/n2GNCazwcoUr4j
        Vsm35pR4Mf1DSyBYL8RKUkGk0ZOcD+47D88vpyOja6Qn5tcskDGCVp3HYQR+VGrA/mgNkr
        eJzO9qqm80MWnKaAR4g7pRFhN5VfShQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-NoKdoI54MnGf7pitTLMQvw-1; Tue, 18 Apr 2023 10:17:10 -0400
X-MC-Unique: NoKdoI54MnGf7pitTLMQvw-1
Received: by mail-wm1-f71.google.com with SMTP id ay37-20020a05600c1e2500b003f16b58cf01so4060877wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 07:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681827423; x=1684419423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D7E0f97enKWeGm4kBxYLE/5HBvfl7WhJLhN+ZbF/ZnM=;
        b=VrXzhVe6VDqWi91/SMlR8nm+lSdbu61vqm7z1LyPq0j0GR4ceE+6Nh/w1O7XSj+t2e
         WxcBQ0gYTepRb8i6BiUKigSqLGKBJd54k76a0WbfcjNjEMvGo/sI8qnz9lIdjGCtUkhS
         eZvA8/Fs3ubu/aV7gX2hDeYKGHpnQGzOC8WJzL0hw73uiAiU7HQlzic8uwQSK+js6qin
         9VzF1yqvGR0BJONK1ng404AXTfXiarlDcpcmoE/ku0btb/wD7BR4bRTG51oks0ZowbaZ
         JaDfvUXXt3OQye+7SVMigxu0ng3Mf0s0NkWg/G0F73RbR3BWlqZViQoSW9jXizZVgC9+
         AGtA==
X-Gm-Message-State: AAQBX9d+PvmBrh81yj9MDTGnnUPXN9OSBVVnDLa6jrLTp+rL85Su7mHH
        KBWhE+YLeZNaSjvAWJ6rSBWoOMeh2ho2csmb3ittde5JWgDOTy09AVnbiZubMh9RYxt7fHsvgqN
        Ds1buoqHkw+C5iksioV2rnqM+
X-Received: by 2002:a05:600c:24e:b0:3ef:71d5:41d8 with SMTP id 14-20020a05600c024e00b003ef71d541d8mr14882513wmj.32.1681827423682;
        Tue, 18 Apr 2023 07:17:03 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z4k5mZUQ0YlvrUPDg3GmVXRk4kB6wqO8dr86TybU23pVcwkwl7iUHnmRW6t9oXDtel+NfwTA==
X-Received: by 2002:a05:600c:24e:b0:3ef:71d5:41d8 with SMTP id 14-20020a05600c024e00b003ef71d541d8mr14882495wmj.32.1681827423366;
        Tue, 18 Apr 2023 07:17:03 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id k21-20020a05600c1c9500b003ee74c25f12sm18904809wms.35.2023.04.18.07.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 07:17:02 -0700 (PDT)
Date:   Tue, 18 Apr 2023 16:17:02 +0200
From:   Igor Mammedov <imammedo@redhat.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, mst@redhat.com, lenb@kernel.org,
        bhelgaas@google.com, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci: acpiphp: try to reassign resources on bridge if
 necessary
Message-ID: <20230418161702.0945fc67@imammedo.users.ipa.redhat.com>
In-Reply-To: <CAJZ5v0geYujyXKv9mG_i+2rjcdrMVh+jmE1ffJ79_oFr8GNoMg@mail.gmail.com>
References: <20230418085030.2154918-1-imammedo@redhat.com>
        <CAJZ5v0geYujyXKv9mG_i+2rjcdrMVh+jmE1ffJ79_oFr8GNoMg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Apr 2023 14:55:29 +0200
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Tue, Apr 18, 2023 at 10:50=E2=80=AFAM Igor Mammedov <imammedo@redhat.c=
om> wrote:
> >
> > When using ACPI PCI hotplug, hotplugging a device with
> > large BARs may fail if bridge windows programmed by
> > firmware are not large enough.
> >
> > Reproducer:
> >   $ qemu-kvm -monitor stdio -M q35  -m 4G \
> >       -global ICH9-LPC.acpi-pci-hotplug-with-bridge-support=3Don \
> >       -device id=3Drp1,pcie-root-port,bus=3Dpcie.0,chassis=3D4 \
> >       disk_image
> >
> >  wait till linux guest boots, then hotplug device
> >    (qemu) device_add qxl,bus=3Drp1
> >
> >  hotplug on guest side fails with:
> >    pci 0000:01:00.0: [1b36:0100] type 00 class 0x038000
> >    pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x03ffffff]
> >    pci 0000:01:00.0: reg 0x14: [mem 0x00000000-0x03ffffff]
> >    pci 0000:01:00.0: reg 0x18: [mem 0x00000000-0x00001fff]
> >    pci 0000:01:00.0: reg 0x1c: [io  0x0000-0x001f]
> >    pci 0000:01:00.0: BAR 0: no space for [mem size 0x04000000]
> >    pci 0000:01:00.0: BAR 0: failed to assign [mem size 0x04000000]
> >    pci 0000:01:00.0: BAR 1: no space for [mem size 0x04000000]
> >    pci 0000:01:00.0: BAR 1: failed to assign [mem size 0x04000000]
> >    pci 0000:01:00.0: BAR 2: assigned [mem 0xfe800000-0xfe801fff]
> >    pci 0000:01:00.0: BAR 3: assigned [io  0x1000-0x101f]
> >    qxl 0000:01:00.0: enabling device (0000 -> 0003)
> >    Unable to create vram_mapping
> >    qxl: probe of 0000:01:00.0 failed with error -12
> >
> > However when using native PCIe hotplug
> >   '-global ICH9-LPC.acpi-pci-hotplug-with-bridge-support=3Doff'
> > it works fine, since kernel attempts to reassign unused resources.
> > Use the same machinery as native PCIe hotplug to (re)assign resources.
> >
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com> =20
>=20
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> or please let me know if you want me to pick this up.

It would be nice if you could pick it up.
Thanks!

>=20
> > ---
> > tested in QEMU with Q35 machine on PCIE root port and also
> > with nested conventional bridge attached to root port.
> > ---
> >  drivers/pci/hotplug/acpiphp_glue.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/a=
cpiphp_glue.c
> > index 5b1f271c6034..9aebde28a92f 100644
> > --- a/drivers/pci/hotplug/acpiphp_glue.c
> > +++ b/drivers/pci/hotplug/acpiphp_glue.c
> > @@ -517,7 +517,7 @@ static void enable_slot(struct acpiphp_slot *slot, =
bool bridge)
> >                                 }
> >                         }
> >                 }
> > -               __pci_bus_assign_resources(bus, &add_list, NULL);
> > +               pci_assign_unassigned_bridge_resources(bus->self);
> >         }
> >
> >         acpiphp_sanitize_bus(bus);
> > --
> > 2.39.1
> > =20
>=20

