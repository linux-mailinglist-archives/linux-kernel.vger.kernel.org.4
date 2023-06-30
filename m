Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AED27432ED
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 05:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjF3DF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 23:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjF3DFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 23:05:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (unknown [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EDC30F6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 20:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688094294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ar/iWdDUvg1A4Jd6Ig7scV83xsEguMT36A9gLYAvj1k=;
        b=bl+5956p4VDfsQ0pl5I08c0f1wNvxWfeyiURbxL8xrqZxwz+dYEsWjFdEkrum1mbwWMB1p
        1h/6U5llq66HqQPkDFtAfaxMWIzmXEvvxpoIIBGwmdBxwtSBDeeqLsBOBKNtRL/A27zRFo
        L522KW8LFv1ev9Zfma32xkgQ8vjWawU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-6C29g_rZPIqZRHEoE1TG_g-1; Thu, 29 Jun 2023 23:04:53 -0400
X-MC-Unique: 6C29g_rZPIqZRHEoE1TG_g-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-635a3b9d24eso12145726d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 20:04:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688094293; x=1690686293;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ar/iWdDUvg1A4Jd6Ig7scV83xsEguMT36A9gLYAvj1k=;
        b=JfP/+tEofMBgMoo0xYmXYRAtrIv767egBKYZpTp6i4fuKk29cxbIycRSsn8zwoq3VY
         g+7dfBnaAL2AGkOeMG2rcPp/Jb7IwO5JWFFme2RXdBZp73xCRYVVeXQOfFE2ZvmSj1b4
         geu/Ykp9m5V4AAcUg7SovAcjU/aOGlX0M6/Waf1icyFM9UIH1zMupqhsZnN1GSg/Fkrr
         Lc+uLQQLylAdlFTyazhhddHQU0pgG02lMvjAhGu4XasVY/MB25/dIKp7kAhl7i+vLiV6
         uD2yHmnNvwsYYpKn1s9e27LsipUby6piYlbPdIETA3hf9QyKdi07IAqZUCwbV5RvQ1XX
         2pVw==
X-Gm-Message-State: ABy/qLaqGtbk5EXadsC7BGtebCE3X51+Qot2Ohd5HzpXTzooEsbSpjbV
        vmmKtCHOfmyxO8kSC+xOJq0ZZrP/STvQXm8/YAfKAwwPh8C9g6kLCQ5O1G3jMvD6LR4EM2CNNJW
        MMHS1U0O3+N3Onw/UOcIFo8w4
X-Received: by 2002:a05:6214:e4a:b0:635:df71:1fd9 with SMTP id o10-20020a0562140e4a00b00635df711fd9mr1912714qvc.7.1688094292809;
        Thu, 29 Jun 2023 20:04:52 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGk+/owvuY0I2STh/0UPHm5mr7KE38cNIaeZmPpj7RMi72ZCoQY20PUyzTwKTvg/k2zGt/LYA==
X-Received: by 2002:a05:6214:e4a:b0:635:df71:1fd9 with SMTP id o10-20020a0562140e4a00b00635df711fd9mr1912691qvc.7.1688094292552;
        Thu, 29 Jun 2023 20:04:52 -0700 (PDT)
Received: from thinkpad-p1.localdomain (cpe00fc8d79db03-cm00fc8d79db00.cpe.net.fido.ca. [72.137.118.218])
        by smtp.gmail.com with ESMTPSA id u18-20020a0cf892000000b0063660329d57sm65130qvn.67.2023.06.29.20.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 20:04:52 -0700 (PDT)
Message-ID: <8715f2b298c04422db311666eb2409464c29458b.camel@redhat.com>
Subject: Re: [PATCH 1/1] PCI: dwc: Use regular interrupt instead of chained
From:   Radu Rendec <rrendec@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pali =?ISO-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Date:   Thu, 29 Jun 2023 23:04:50 -0400
In-Reply-To: <20230629221103.GA449329@bhelgaas>
References: <20230629221103.GA449329@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-06-29 at 17:11 -0500, Bjorn Helgaas wrote:
> [+cc Pali]
>=20
> On Thu, Jun 29, 2023 at 05:27:54PM -0400, Radu Rendec wrote:
> > On Thu, 2023-06-29 at 15:58 -0500, Bjorn Helgaas wrote:
> > > On Thu, Jun 29, 2023 at 04:42:07PM -0400, Radu Rendec wrote:
> > > > On Thu, 2023-06-29 at 14:57 -0500, Bjorn Helgaas wrote:
> > > > > On Thu, Jun 29, 2023 at 02:30:19PM -0400, Radu Rendec wrote:
> > > > > > The DesignWare PCIe host driver uses a chained interrupt to dem=
ultiplex
> > > > > > the downstream MSI interrupts. On Qualcomm SA8540P Ride, enabli=
ng both
> > > > > > pcie2a and pcie3a at the same time can create an interrupt stor=
m where
> > > > > > the parent interrupt fires continuously, even though reading th=
e PCIe
> > > > > > host registers doesn't identify any child MSI interrupt source.=
 This
> > > > > > effectively locks up CPU0, which spends all the time servicing =
these
> > > > > > interrupts.
> > > > > >=20
> > > > > > This is a clear example of how bypassing the interrupt core by =
using
> > > > > > chained interrupts can be very dangerous if the hardware misbeh=
aves.
> > > > > >=20
> > > > > > Convert the driver to use a regular interrupt for the demultipl=
ex
> > > > > > handler. This allows the interrupt storm detector to detect the=
 faulty
> > > > > > interrupt and disable it, allowing the system to run normally.
>=20
> > ...
> > > But you do imply that there's some DesignWare hardware issue involved=
,
> > > too, so I guess it's possible the other drivers don't have an issue
> > > and/or actually require the chained IRQs.=C2=A0 That's why I asked ho=
w we
> > > should decide.
> >=20
> > That makes sense. I don't know if it's a DesignWare hardware issue or
> > something else down the PCIe bus. Other folks in my team are
> > investigating the root cause. This thread has the details:
> > https://lore.kernel.org/all/pmodcoakbs25z2a7mlo5gpuz63zluh35vbgb5itn6k5=
aqhjnny@jvphbpvahtse/
> >=20
> > I want to point out that this patch doesn't *fix* the root problem (the
> > interrupt storm). It just makes the kernel handle it (much) better if
> > it occurs.
> >=20
> > I can't see why any driver would _require_ chained IRQs. As I see it,
> > chained interrupts are just a "shortcut" that circumvents the IRQ core
> > for (debatable) performance reasons. Other than that, they should work
> > the same as regular interrupts.
> >=20
> > There are other benefits associated with using regular interrupts. One
> > of them is the ability to control the SMP affinity of the parent
> > interrupt. But that's a different topic.
>=20
> Thanks for mentioning IRQ affinity because that reminds me of a
> long-standing related issue.=C2=A0 Pali posted a similar patch for mvebu
> [1], but it's been stalled for a long time because apparently there's
> some potential breakage of the userspace ABI [2].

I'm really glad you brought this up. Ironically, that's exactly where I
started.

> Unfortunately I'm not an IRQ expert and haven't followed all the
> arguments there.=C2=A0 BUT it does seem like Marc's objection to Pali's
> patch would also apply to your patch, so maybe this is an opportune
> time to re-evaluate the situation.

I'm no IRQ expert either, but I've been looking into it quite a lot
lately. For the record, there's an even older thread [3] where Marc
explains the userspace ABI breakage you mentioned and he proposes a new
sysfs based interface to address that problem.

I tried to follow Marc's suggestions and sent an RFC patch series [4]
that attempts to implement the new interface and also some form of
parent-child interrupt tracking. That would be a way of addressing the
affinity issue without having to convert all the drivers. But on the
other hand, it doesn't solve the IRQ storm detection problem.

Anyway, Thomas replied [5] and explained why chained interrupts are a
bad idea altogether. When we (my team and I ) came across the IRQ storm
issue, we experienced first hand the scenario that Thomas describes.

> If converting from chained to normal handlers can be done safely, I
> would definitely be in favor if doing it across all of drivers/pci/ at
> once so they're all consistent.=C2=A0 Otherwise that code just gets copie=
d
> to new drivers, so the issue persists and spreads.

I think the conversion can be done safely, meaning that it won't break
the drivers. And by the way, there are other IRQ drivers (outside the
PCI space) that use chained interrupts.

Unfortunately, it seems we are going in circles. Chained interrupts are
bad because they let IRQ storms go unnoticed and lock up the system,
but converting them to regular interrupts is also bad because it breaks
the userspace ABI.

I am willing to help clean up this mess, but I think first we need to
come up with a solution that's acceptable for everybody. I was hoping
Marc and Thomas would chime in, but unfortunately that hasn't happened
yet - other than each of them pointing out (separately) what is wrong
with each approach.

Radu

> [1] https://lore.kernel.org/r/20220524122817.7199-1-pali@kernel.org
> [2] https://lore.kernel.org/r/874k0bf7f7.wl-maz@kernel.org
[3] https://lore.kernel.org/all/87fslr7ygl.wl-maz@kernel.org/
[4] https://lore.kernel.org/all/20230530214550.864894-1-rrendec@redhat.com/
[5] https://lore.kernel.org/all/877csohcll.ffs@tglx/

