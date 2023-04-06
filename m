Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD8A6DA660
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 01:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbjDFX5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 19:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbjDFX52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 19:57:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20D26589
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 16:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680825404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kApPyxvI4xk0XbG1RtkVOfKgI24cMwY9IN3a/JudirY=;
        b=GsVRtKbUfJPhfBVDIBrA7BYkRxfiIXOvlR2zpsj7RqPrznKBvdBpJZT2czndwjXr+zoTFq
        aQoZKyyAiuHtbps0ETXntWREVIZ1x44IJBGxQOEBXUX0xft8YoMwHOWeg9gWap4r4r+OiT
        hwHfjnhUxBgOKRdyfqi+10Ls8zYQ1Hw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-64dAkDh1NkuF58FWvV_8vw-1; Thu, 06 Apr 2023 19:56:43 -0400
X-MC-Unique: 64dAkDh1NkuF58FWvV_8vw-1
Received: by mail-qt1-f199.google.com with SMTP id w13-20020ac857cd000000b003e37d3e6de2so27846032qta.16
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 16:56:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680825402;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kApPyxvI4xk0XbG1RtkVOfKgI24cMwY9IN3a/JudirY=;
        b=oOMK4GGnMD/pnbfx1ErP+NB12XiFN+FtTKLB0WHp1gRFHLJ+j++QMC2/klOsl1LCdK
         zCXpk/4ZCYF9EEJCNFPOhn7cxY2lxf5dwmoUpBNZDU5kyaocmCVddlt8FgHHBhtH77Y/
         YsQEhtrYldvj0YD/Nn+IJBQ7Hiu5zRoEVDnQUaaupDm8pekJ6XPXeZzweTIx0f7u0GSq
         NULPbj7Qcr8heoYEdlxz16eAZ9SQo5Ac+skRkhZt77bUw/3oBOyZcj2NOFHqnUX7cpdF
         OnOoZeVjkSL2My+h+svsfSETYRLQFrv7wFQQfymvEhkxI5FQnmewPXioQxgnnIcHCRUB
         yBdQ==
X-Gm-Message-State: AAQBX9dzrpWCrUNryg9lwluGNQhYdUw3tdduInV5W9duPTSErhhq17tt
        cmLShbFKBorkqNb719iHde1L4r5kCnSLvSOScaOpTh3hYmKg3WQ1mrI/XVqOiLHsPAyooo0btHO
        0nke3lfpvLRyygVuZ61yTS7fM
X-Received: by 2002:ad4:5baa:0:b0:570:5389:2216 with SMTP id 10-20020ad45baa000000b0057053892216mr6279530qvq.22.1680825402490;
        Thu, 06 Apr 2023 16:56:42 -0700 (PDT)
X-Google-Smtp-Source: AKy350bJ9qiIsdQDWf0Z+kaocq9MDH1utL2bYpabO8VJXDbg9k6hKv0JSjOeYt25BGz7vv+cncAP9w==
X-Received: by 2002:ad4:5baa:0:b0:570:5389:2216 with SMTP id 10-20020ad45baa000000b0057053892216mr6279518qvq.22.1680825402210;
        Thu, 06 Apr 2023 16:56:42 -0700 (PDT)
Received: from thinkpad-p1.localdomain (cpe00fc8d79db03-cm00fc8d79db00.cpe.net.fido.ca. [72.137.118.218])
        by smtp.gmail.com with ESMTPSA id k22-20020ac84756000000b003e4d43038e2sm787877qtp.5.2023.04.06.16.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 16:56:41 -0700 (PDT)
Message-ID: <d1166229fdead30fcbf3c2bd88ca1bd4ebffbce9.camel@redhat.com>
Subject: Re: irqdomain API: how to set affinity of parent irq of chained
 irqs?
From:   Radu Rendec <rrendec@redhat.com>
To:     Marc Zyngier <maz@kernel.org>,
        Marek =?ISO-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        pali@kernel.org, Brian Masney <bmasney@redhat.com>
Date:   Thu, 06 Apr 2023 19:56:40 -0400
In-Reply-To: <87fslr7ygl.wl-maz@kernel.org>
References: <20220502102137.764606ee@thinkpad>
         <87mtg0i8m8.wl-maz@kernel.org> <20220502174559.78f5cbc0@dellmb>
         <87fslr7ygl.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marc, Marek,

On Tue, 2022-05-03 at 10:32 +0100, Marc Zyngier wrote:
> On Mon, 02 May 2022 16:45:59 +0100,
> Marek Beh=C3=BAn <kabel@kernel.org> wrote:
> >=20
> > On Mon, 02 May 2022 10:31:11 +0100
> > Marc Zyngier <maz@kernel.org> wrote:
> >=20
> > > On Mon, 02 May 2022 09:21:37 +0100,
> > > Marek Beh=C3=BAn <kabel@kernel.org> wrote:
> > > >=20
> > > > Dear Marc, Thomas,
> > > >=20
> > > > we have encountered the following problem that can hopefully be put
> > > > some light onto: What is the intended way to set affinity (and poss=
ibly
> > > > other irq attributes) of parent IRQ of chained IRQs, when using the
> > > > irqdomain API?=C2=A0=20
> > >=20
> > > Simples: you can't. What sense does it make to change the affinity of
> > > the parent interrupt, given that its fate is tied to *all* of the
> > > other interrupts that are muxed to it?
> >=20
> > Dear Marc,
> >=20
> > thank you for your answer. Still:
> >=20
> > What about when we want to set the same affinity for all the chained
> > interrupts?
> >=20
> > Example: on Armada 385 there are 4 PCIe controllers. Each controller
> > has one interrupt from which we trigger chained interrupts. We would
> > like to configure each controller to trigger interrupt (and thus all
> > chained interrupts in the domain) on different CPU core.
> >=20
> > Moreover we would really like to do this in runtime, through sysfs,
> > depending on for example whether there are cards plugged in the PCIe
> > ports.
> >=20
> > Maybe there should be some mechanism to allow to change affinity for
> > whole irqdomain, or something?
>=20
> Should? Maybe. But not for an irqdomain (which really doesn't have
> anything to do with interrupt affinity).
>=20
> What you may want is a new sysfs interface that would allow a parent
> interrupt affinity being changed, but also exposing to userspace all
> the interrupts this affects *at the same time*. something like:
>=20
> /sys/kernel/irq/42/smp_affinity_list
> /sys/kernel/irq/42/muxed_irqs/
> /sys/kernel/irq/42/muxed_irqs/56 -> ../../56
> /sys/kernel/irq/42/muxed_irqs/57 -> ../../57
>=20
> The main issues are that:
>=20
> - we don't really track the muxing information in any of the data
> =C2=A0 structures, so you can't just walk a short list and generate this
> =C2=A0 information. You'd need to build the topology information at
> =C2=A0 allocation time (or fish it out at runtime, but that's likely a
> =C2=A0 pain).
>=20
> - sysfs doesn't deal with affinities at all. procfs does, but adding
> =C2=A0 more crap there is frowned upon.
>=20
> - it *must* be a new interface. You can't repurpose the existing one,
> =C2=A0 as something like irqbalance would be otherwise be massively
> =C2=A0 confused by seeing interrupts moving around behind its back.
>=20
> - conversely, you'll need to teach irqbalance how to deal with this
> =C2=A0 new interface.
>=20
> - this needs to be safe against CPU hotplug. It probably already is,
> =C2=A0 but nobody ever tested it, given that userspace can't interact wit=
h
> =C2=A0 these interrupts at the moment.

Are you aware of any work being done (or having been done) in this
area? Thanks in advance!

My colleagues and I are looking into picking this up and implementing
the new sysfs interface and the related irqbalance changes, and we are
currently evaluating the level of effort. Obviously, we would like to
avoid any effort duplication.

Best regards,
Radu

