Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84887294AF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239902AbjFIJUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240104AbjFIJTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:19:35 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F70C527B;
        Fri,  9 Jun 2023 02:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1686302066; x=1717838066;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M0Vg0+c5NCYDzMzfqguWF8jTHv2kAMm/VATkAKR/L4c=;
  b=Gv291v7SDpEZUJznxcVEaD1jQbG1dX/PTFRw3CoCfWzezt+XAYj0jvr6
   sIPtCaiFIpjgGCrQgPndzBWsll20/9ijvGfJT+6S/mVQqwXBgHr47D4al
   8mXxd0731cx/sKIFKsmAg27L10iFeM/0EOFyYhBpaFPR/PFP9c5XtT4KJ
   mfZMUMjVnuuuPuWOJDGEsN6XeyItTiLnDVQkx5nnTUsOlwsHxbKx6VrSV
   orUe+8Ts6UtQww2jVu+mm10g7aA25v869+vT5Lxq/39rYEHGwNxl+TFqg
   TGIVwCz6V5zj8opiBmQ6HEKR9HwkIdEzYoyXOMiU1EwS43CrtIz8Cf2ky
   A==;
X-IronPort-AV: E=Sophos;i="6.00,228,1681164000"; 
   d="scan'208";a="31361175"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 09 Jun 2023 11:13:39 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 09 Jun 2023 11:13:39 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 09 Jun 2023 11:13:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1686302019; x=1717838019;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M0Vg0+c5NCYDzMzfqguWF8jTHv2kAMm/VATkAKR/L4c=;
  b=KwglHQfwQw9R14jQqFuQ8UtL28WTqEyuvRvtVm0Nkr2psy8SDnKndoz9
   BvBOS3AOiAZ/f/QIlChszpZLVBtml1b/I8zR71PI2okTP20nW7XnBEYN7
   wRYQT5xbg+rEo5oh0fvmd/b7DpbwudwAdWy4Pqx8s+OixF7xoWJ9XrwA+
   kyZWZSGOV5/LNi+YRvRlN53ArmFzIIb2pZQcak/X+78+MPPFYuQJ01x4J
   cSC5yqZRQ6ZhY+707TXGj/9XRuXkET8PapSfa43wJiZog59JzV2MKL73T
   a9wiaduRUD8zTKNk/kSTtgDuuo+A8P+Gyr5cCXaRfduJAR+JBJM1vt6mC
   A==;
X-IronPort-AV: E=Sophos;i="6.00,228,1681164000"; 
   d="scan'208";a="31361174"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 09 Jun 2023 11:13:39 +0200
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 4D1D2280087;
        Fri,  9 Jun 2023 11:13:39 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@ew.tq-group.com
Subject: Re: [PATCH 1/2] spi: dt-bindings: introduce linux,use-rt-queue flag
Date:   Fri, 09 Jun 2023 11:13:39 +0200
Message-ID: <4784636.LvFx2qVVIh@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <CACRpkda2yQefuUMn6Ot8Ns6nNgfC25i9nwmzwxOy5fUg=A44hQ@mail.gmail.com>
References: <20230602115201.415718-1-matthias.schiffer@ew.tq-group.com> <3241150.44csPzL39Z@steina-w> <CACRpkda2yQefuUMn6Ot8Ns6nNgfC25i9nwmzwxOy5fUg=A44hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 9. Juni 2023, 10:42:04 CEST schrieb Linus Walleij:
> On Fri, Jun 9, 2023 at 10:15=E2=80=AFAM Alexander Stein
>=20
> <alexander.stein@ew.tq-group.com> wrote:
> > > A agree with Mark that a command line option isn't that bad. It's
> > > something
> > > that pertains to just the Linux kernel after all? And you can put that
> > > command line option in the default device tree, in chosen, if you wan=
t.
> >=20
> > I don't like the idea of a command line enabling realtime scheduling for
> > all instances of the SPI controller driver or even all SPI controllers.
> > Actually this might be worse if a non-rt SPI bus is considered for RT
> > scheduling. IMHO this should be configurable per SPI controller,
>=20
> OK that's a fair point.
>=20
> I don't think command line arguments are necessarily global by
> nature, AFAIK it's fine to invent something like pl022.4.rt_sched=3D1
> where 4 is the instance number. Parsing it is just code.

Now we are touching the topic of non-deterministic device names/numbers. Th=
is=20
gets worse if your SPI controller is attached to some other device, althoug=
h=20
RT capabilities are rather limited in that case anyway.

> > e.g. a sysfs attribute.
>=20
> But it needs to be set before userspace is up :/

Does it? IMHO a realtime system is allowed to use blocking mechanism (e.g.=
=20
dynamic memory allocatin and so on) during startup/configuration phase,=20
ignoring any deadlines.
Once it starts operating this is a no-go.
This seems rather similar to configure scheduling priority for IRQ threads =
on=20
RT preempt systems. IIRC according to RT folks, this is considered an=20
administration task, thus the responsibility of userspace.

> I fully sympathize with this problem, because I have faced
> similar problems myself.

You mean RT-scheduling before userspace is up? Can you elaborate the issues=
=20
you see?

> My fallback solution for this driver would be to keep using the
> old DT property (which was merged when reviewing was
> not as strict) if that works, or use undocumented DT properties,
> it's not the end of the world but does leave the bad taste of
> a work not finished.

I was surprised to see the driver specific property for configuring RT sche=
d=20
as well. I assume the intention of this series is to support this feature f=
or=20
other SPI controller drivers as well. So some kind of feature has to be add=
ed=20
anyway.

Best regards,
Alexander

> Yours,
> Linus Walleij


=2D-=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
http://www.tq-group.com/


