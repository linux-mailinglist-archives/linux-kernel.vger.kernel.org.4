Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8946377B7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiKXLbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbiKXLb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:31:28 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8981716E2;
        Thu, 24 Nov 2022 03:31:26 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id ECE6F40003;
        Thu, 24 Nov 2022 11:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1669289485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BsRWm2PqElccv4JyIrk7v8YmrEOrU1kVFUncQALxtJk=;
        b=Q5vljS1tiD68Q5JGexllJhX6PTGykOr04mP2RM6iXS+5VXGtFiJP2DhoscGFgCtyg4WMjY
        SCD+/FMk1qnW9JmITmWTGMxHfdXnsmBrNS79Cb8YMXH91DIGNh3zzfVpQTvVm+U0PwUXrK
        P2SsbMIq8L3daxQVRRhx7EImfUzw8iPb8jOE5RfXpg/a5Q4zHYE6Zw83uCVV+qGk1RHNNp
        KTqxOL9daDhjs4ZgPO+LXK3RyJqzHeIAdFEpPMSKdiQE8nwyG+XZrebEl33OFx1ZZX5LpA
        Fz8Sv6vNzmpDhtQkHg+5QZj8A/4Jz+GrA854E9HEp7IFoU7XHeODpVn6jNhGkA==
Date:   Thu, 24 Nov 2022 12:31:24 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Alexander Lobakin <alobakin@pm.me>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/18] mtd: tests: fix object shared between several
 modules
Message-ID: <20221124123124.2e46ed23@xps-13>
In-Reply-To: <20221123175900.4e05a0f2@xps-13>
References: <20221119225650.1044591-1-alobakin@pm.me>
        <20221119225650.1044591-13-alobakin@pm.me>
        <CAK7LNASni5uNFOtR-6VykBHX1Wgg-rOt=q0Lk+H2Vbn7pCsBDQ@mail.gmail.com>
        <20221123175900.4e05a0f2@xps-13>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Reducing the Cc list.

miquel.raynal@bootlin.com wrote on Wed, 23 Nov 2022 17:59:00 +0100:

> Hi,
>=20
> masahiroy@kernel.org wrote on Wed, 23 Nov 2022 22:11:49 +0900:
>=20
> > On Sun, Nov 20, 2022 at 8:08 AM Alexander Lobakin <alobakin@pm.me> wrot=
e: =20
> > >
> > > mtd_test.o is linked to 8(!) different test modules:
> > >   =20
> > > > scripts/Makefile.build:252: ./drivers/mtd/tests/Makefile: mtd_test.o
> > > > is added to multiple modules: mtd_nandbiterrs mtd_oobtest mtd_paget=
est
> > > > mtd_readtest mtd_speedtest mtd_stresstest mtd_subpagetest mtd_tortu=
retest   =20
> > >
> > > Although all of them share one Kconfig option
> > > (CONFIG_MTD_TESTS), it's better to not link one object file into
> > > several modules (and/or vmlinux).
> > > Under certain circumstances, such can lead to the situation fixed by
> > > commit 637a642f5ca5 ("zstd: Fixing mixed module-builtin objects").
> > > In this particular case, there's also no need to duplicate the very
> > > same object code 8 times.
> > >
> > > Convert mtd_test.o to a standalone module which will export its
> > > functions to the rest.
> > >
> > > Fixes: a995c792280d ("mtd: tests: rename sources in order to link a h=
elper object")
> > > Suggested-by: Masahiro Yamada <masahiroy@kernel.org>   =20
> >=20
> > IMHO, Reported-by might be a better fit.
> >=20
> >=20
> > I think they can become static inline functions in mtd_test.h
> > (at least, mtdtest_relax() is a static inline there), but I am not sure.
> >=20
> > Please send this to the MTD list, and consult the maintainer(s). =20
>=20
> TBH I don't really mind. These are test modules that you insert to
> harden and profile the stack, so whatever makes the robots happy is
> fine. Anyway, they are being slowly replaced by userspace tools so we
> might eventually get rid of them.

Once you feel ready, if you want this to be merged through the mtd
tree, you can resend with the linux-mtd ML in Cc, otherwise if falls out
of the scope of the tools and it's a pain to collect.

Thanks,
Miqu=C3=A8l
