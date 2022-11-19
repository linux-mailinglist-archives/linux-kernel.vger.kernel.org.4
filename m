Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764CC630F2C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 15:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbiKSOhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 09:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbiKSOhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 09:37:10 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9408A174
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 06:37:08 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id n20so19614013ejh.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 06:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MHOa+D8mpRhpdgnZXN5k9URMGupIKtlcB4yfQ7rRjso=;
        b=YpkFXoMqkgDKSItLrDTJw6yO2The++PAUc34DHgUev0QspSdPd+pa/bAtNixW376AD
         ZyvNOq5ojGPlthrP8SKjYt5Yq6D38pirzObDG7BXRxoYTEEp4AD8Anxv7CAMAEHRr1lz
         AAnkDsEwYodQTWOfGa91DxWw1dfnRDFOiu+NxTC83u5sut1L/X8MlmywQR8xbwm/4NmF
         keEHp4Gq6D76r8mAebQAU/cqDallo76a9I/tSEf6XHSyoOzLCw1i+XngGKcVC+6teT9c
         1QlBbqlCtulxKavNIG8bJIcBBZDH4D8Eb3//Sa5p2CIYrNadZCB53B4w1BPwIWIIAKWu
         7lbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MHOa+D8mpRhpdgnZXN5k9URMGupIKtlcB4yfQ7rRjso=;
        b=Zq99ipdMq/c663UAS2M1WRsskxqkG0yU/qclbPscXvhFCsvanzIwg7eLgBvNXd6x91
         PQunRCuTpmLV5bg4tY+VpFQdZA67TeF3PgNC+8FeuQKfQwYgJJLiWFVUDvoJ1ZXjDliz
         C5az/Aq3xzkA9OfP57925JcP8nevukdwE07Z8/RyDBA8HY9dRe8ZqCOL8q0laqmI0B7l
         Z2SX2IqpJ+ZFHLeHvScE4UlW8tlm3PQm57uEZd2ryF7DXPj3w0b3ICQH3P9lULI2ow92
         rFwaMqtHiz0ArS+b8J45+XYpjKGvBhM+WqRHtgey7W6BJireyvIej+xfWFl1QrprUQe5
         g5MA==
X-Gm-Message-State: ANoB5pkp93SNq4uvSVowXRdTQDgPXfiCGj4Ef3c89RB4nY14vk+Q+kyQ
        QXOslx4H1AyAH5GXtXeDwZTTAoeYW/n+Y6oUdxDrZ95v
X-Google-Smtp-Source: AA0mqf4MO12erJ/AziUOpMWmAip6juEbRm46sbjaHB2toJ1l3Odf8nhwsShVU984UjItUKU8PAzbmjNjdUIomTFyPBo=
X-Received: by 2002:a17:906:65c4:b0:7ad:d250:b907 with SMTP id
 z4-20020a17090665c400b007add250b907mr9399864ejn.737.1668868627066; Sat, 19
 Nov 2022 06:37:07 -0800 (PST)
MIME-Version: 1.0
References: <20221118154931.1928298-1-marmarek@invisiblethingslab.com>
 <CAKf6xpuCxftyQ+PKN_ffJ0onsSxcT8kVSwkM7Z10pfjqf0XFgA@mail.gmail.com> <Y3f9O0S8kVXZ+py+@mail-itl>
In-Reply-To: <Y3f9O0S8kVXZ+py+@mail-itl>
From:   Jason Andryuk <jandryuk@gmail.com>
Date:   Sat, 19 Nov 2022 09:36:54 -0500
Message-ID: <CAKf6xpvUcR=rta6SD7mw_pvgQJTxKjN5VHpC6x-zCAiaJ=pKfg@mail.gmail.com>
Subject: Re: [PATCH v3] xen-pciback: Consider INTx disabled when MSI/MSI-X is enabled
To:     =?UTF-8?Q?Marek_Marczykowski=2DG=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
Cc:     linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Jan Beulich <jbeulich@suse.com>,
        "moderated list:XEN HYPERVISOR INTERFACE" 
        <xen-devel@lists.xenproject.org>
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

Hi, Marek,

On Fri, Nov 18, 2022 at 4:46 PM Marek Marczykowski-G=C3=B3recki
<marmarek@invisiblethingslab.com> wrote:
>
> On Fri, Nov 18, 2022 at 03:46:47PM -0500, Jason Andryuk wrote:
> > On Fri, Nov 18, 2022 at 10:50 AM Marek Marczykowski-G=C3=B3recki
> > <marmarek@invisiblethingslab.com> wrote:
> > >
> > > Linux enables MSI-X before disabling INTx, but keeps MSI-X masked unt=
il
> > > the table is filled. Then it disables INTx just before clearing MASKA=
LL
> > > bit. Currently this approach is rejected by xen-pciback.
> > > According to the PCIe spec, device cannot use INTx when MSI/MSI-X is
> > > enabled (in other words: enabling MSI/MSI-X implicitly disables INTx)=
.
> > >
> > > Change the logic to consider INTx disabled if MSI/MSI-X is enabled. T=
his
> > > applies to three places:
> > >  - checking currently enabled interrupts type,
> > >  - transition to MSI/MSI-X - where INTx would be implicitly disabled,
> > >  - clearing INTx disable bit - which can be allowed even if MSI/MSI-X=
 is
> > >    enabled, as device should consider INTx disabled anyway in that ca=
se
> > >
> > > Fixes: 5e29500eba2a ("xen-pciback: Allow setting PCI_MSIX_FLAGS_MASKA=
LL too")
> > > Signed-off-by: Marek Marczykowski-G=C3=B3recki <marmarek@invisiblethi=
ngslab.com>
> > > ---
> > > Changes in v3:
> > >  - allow clearing INTx regardless of MSI/MSI-X state, to be consisten=
t
> > >    with enabling MSI/MSI-X
> > > Changes in v2:
> > >  - restructure the patch to consider not only MASKALL bit, but enabli=
ng
> > >    MSI/MSI-X generally, without explicitly disabling INTx first
> > > ---
> >
> > I was trying to test your xen-pciback v3 patch, and I am having
> > assignment fail consistently now.  It is actually failing to
> > quarantine to domIO in the first place, which matches the failure from
> > the other day (when I more carefully read through the logs).  It now
> > consistently fails to quarantine on every boot unlike the other day
> > where it happened once.
>
> Does this include the very first assignment too, or only after domain
> reboot? If the latter, maybe some cleanup missed clearing MASKALL?

It's the quarantine during dom0 boot that fails.  Later assignment
during VM boot fails.  I tried warm reboots and cold boots and it
happened both times.

I also modified my initrd to halt in there and checked the config
space.  MASKALL wasn't set at that time.  I need to double check -
MASKALL may have been unset after dom0 booted in that case.

I'll test more to figure when and how MASKALL is getting set.

> FWIW, the patch applied to Qubes
> (https://github.com/QubesOS/qubes-linux-kernel/pull/680) seems to work
> fine (the full test run is still in progress, but I see some green marks
> already).

Does Qubes quarantine devices explicitly, or are they in dom0 and
libvirt/libxl just assigns them when a domain boots?

> > I added some printks and it 's getting -EBUSY from pdev_msix_assign()
> > which means pci_reset_msix_state() is failing:
> >     if ( pci_conf_read16(pdev->sbdf, msix_control_reg(pos)) &
> >          PCI_MSIX_FLAGS_MASKALL )
> >         return -EBUSY;
> >
> > # lspci -vv -s 14.3
> > ...
> >     Capabilities: [80] MSI-X: Enable- Count=3D16 Masked+
> >         Vector table: BAR=3D0 offset=3D00002000
> >         PBA: BAR=3D0 offset=3D00003000
> >
> > So it looks like MASKALL is set and prevents assignment.
> >
> > setpci -s 00:14.3 82.W=3Df
> > cleared that out for me and I could assign the device.
> >
> > My dom0 boots, it runs flask-label-pci for a set of PCI devices
> > (including iwlwifi), then xl pci-assignable-add for all PCI devices
> > which will be passed through, then a little later it boots the
> > associated domains.  Dom0 does not have a driver for iwlwifi.
> >
> > I'll have to investigate more to see how MASKALL is getting set.  This
> > had not been an issue before your recent patches.
>
> I guess before the patches nothing set anything in MSI-X capability,
> because it was hidden...

Well, stubdom hasn't even booted when, so it would be the Xen or
pciback change to modify MASKALL?

> Anyway, to support my cleanup hypothesis, I tried to destroy a
> PCI-having domain, and it left MSI-X enabled (at least according to the
> config space). MASKALL was _not_ set, but I haven't checked masking of
> individual vectors. TBH, I'm not sure what should be responsible for the
> MSI-X cleanup after guest destroy. Should it be Xen? Qemu? Pciback?
> Pciback calls PHYSDEVOP_{prepare,release}_msix only when
> binding/unbinding from the device (so - xl pci-assignable-{add,remove}),
> so this isn't the right place.

I need to review all this code to give a meaningful response.  Would
xen-pciback set MASKALL when it binds a device?  That happens before
xl pci-assignable-add tries to quarantine (assign to to domIO).

> Should that be in Xen, in deassign_device() (part of
> DOMCTL_deassign_device)?

It seems to me that Xen needs to ultimately disable the device.

Thanks,
Jason
