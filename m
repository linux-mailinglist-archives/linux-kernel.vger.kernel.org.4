Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA37674E9C2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 11:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjGKJDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 05:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbjGKJDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 05:03:33 -0400
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B550E94
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 02:03:31 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id 898F7148CBE;
        Tue, 11 Jul 2023 11:03:28 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1689066208; bh=gsA9dp5k5kL6wVwYiuNLHaFWo2zidgNfMjsDqoPRfvA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lTBkHMaRlvYY4xPel/M5UCaSWW2SpSEVRze8dKTgfvPMmQjjKLQWBbnq/UQmT/PLp
         soZ+v+Dw+CTEepA07g799v8ScO+hduASLM0Yjiu3042TsoZyXTY5QAKlvZlOuFztnw
         18Zo87nEx5fPnDo9NL6xeVMqf9WgPD4fE43YjpSfOVyNAS7dp6Qfa1V35r7nY8Tfc7
         N38JwA/go6jlLM8Cre6j+8YtiQLsv+LbXML9iDs0vDTsx+R/J/ltuUGPmJ9E0MNdZN
         YTmb0OsxoWAFfBth1siEGkEJMU6UuUaTpcMFuxc+W5gqSoxM7jg3dQWoymWJyFkfX9
         Zy4tguasNPMiA==
Date:   Tue, 11 Jul 2023 11:03:25 +0200
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     Mike Lothian <mike@fireburn.co.uk>
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
        Petr Tesarik <petrtesarik@huaweicloud.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        open list <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 0/7] Allow dynamic allocation of software IO TLB
 bounce buffers
Message-ID: <20230711110325.2521472c@meshulam.tesarici.cz>
In-Reply-To: <CAHbf0-HY0-u4MwgU39b53hjOM+bWfGmOEYQuvHARjV+6j+O7Kg@mail.gmail.com>
References: <cover.1681898595.git.petr.tesarik.ext@huawei.com>
        <20230426141520.0caf4386@meshulam.tesarici.cz>
        <2023042617-wobble-enlighten-9361@gregkh>
        <20230426144439.5674f8bc@meshulam.tesarici.cz>
        <20230509091635.27450bd9@meshulam.tesarici.cz>
        <2023050949-grueling-verify-a43b@gregkh>
        <CAHbf0-HY0-u4MwgU39b53hjOM+bWfGmOEYQuvHARjV+6j+O7Kg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2023 23:23:45 +0100
Mike Lothian <mike@fireburn.co.uk> wrote:

> Hi
>=20
> I was hoping this might land for 6.5-rc1, is there a new version that
> might apply against 6.5?

Yes, there is a v3, which is a complete rewrite based on feedback from
various people on this mailing list:

https://lore.kernel.org/linux-iommu/cover.1687859323.git.petr.tesarik.ext@h=
uawei.com/T/

Petr T

> Cheers
>=20
> Mike
>=20
> On Tue, 9 May 2023 at 08:32, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, May 09, 2023 at 09:16:35AM +0200, Petr Tesa=C5=99=C3=ADk wrote:=
 =20
> > > On Wed, 26 Apr 2023 14:44:39 +0200
> > > Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> wrote:
> > > =20
> > > > Hi Greg,
> > > >
> > > > On Wed, 26 Apr 2023 14:26:36 +0200
> > > > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > > > =20
> > > > > On Wed, Apr 26, 2023 at 02:15:20PM +0200, Petr Tesa=C5=99=C3=ADk =
wrote: =20
> > > > > > Hi,
> > > > > >
> > > > > > On Wed, 19 Apr 2023 12:03:52 +0200
> > > > > > Petr Tesarik <petrtesarik@huaweicloud.com> wrote:
> > > > > > =20
> > > > > > > From: Petr Tesarik <petr.tesarik.ext@huawei.com>
> > > > > > >
> > > > > > > The goal of my work is to provide more flexibility in the siz=
ing of
> > > > > > > SWIOTLB.
> > > > > > >
> > > > > > > The software IO TLB was designed with these assumptions:
> > > > > > >
> > > > > > > 1. It would not be used much, especially on 64-bit systems.
> > > > > > > 2. A small fixed memory area (64 MiB by default) is sufficien=
t to
> > > > > > >    handle the few cases which require a bounce buffer.
> > > > > > > 3. 64 MiB is little enough that it has no impact on the rest =
of the
> > > > > > >    system.
> > > > > > >
> > > > > > > First, if SEV is active, all DMA must be done through shared
> > > > > > > unencrypted pages, and SWIOTLB is used to make this happen wi=
thout
> > > > > > > changing device drivers. The software IO TLB size is increase=
d to
> > > > > > > 6% of total memory in sev_setup_arch(), but that is more of an
> > > > > > > approximation. The actual requirements may vary depending on =
the
> > > > > > > amount of I/O and which drivers are used. These factors may n=
ot be
> > > > > > > know at boot time, i.e. when SWIOTLB is allocated.
> > > > > > >
> > > > > > > Second, other colleagues have noticed that they can reliably =
get
> > > > > > > rid of occasional OOM kills on an Arm embedded device by redu=
cing
> > > > > > > the SWIOTLB size. This can be achieved with a kernel paramete=
r, but
> > > > > > > determining the right value puts additional burden on pre-rel=
ease
> > > > > > > testing, which could be avoided if SWIOTLB is allocated small=
 and
> > > > > > > grows only when necessary. =20
> > > > > >
> > > > > > Now that merging into 6.4 has begun, what about this patch seri=
es? I'm
> > > > > > eager to get some feedback (positive or negative) and respin th=
e next
> > > > > > version. =20
> > > > >
> > > > > It's the merge window, we can't add new things that haven't been =
in
> > > > > linux-next already. =20
> > > >
> > > > This is understood. I'm not asking for immediate inclusion.
> > > > =20
> > > > >   Please resubmit it after -rc1 is out. =20
> > > >
> > > > If you can believe that rebasing to -rc1 will be enough, then I will
> > > > also try to believe I'm lucky. ;-)
> > > >
> > > > The kind of feedback I really want to get is e.g. about the extra
> > > > per-device DMA-specific fields. If they cannot be added to struct
> > > > device, then I'd rather start discussing an interim solution, becau=
se
> > > > getting all existing DMA fields out of that struct will take a lot =
of
> > > > time... =20
> > >
> > > All right, 6.4-rc1 is out now. The patch series still applies cleanly.
> > >
> > > Any comments what must be changed (if anything) to get it in? =20
>  [...] =20

