Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51FF72926B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240049AbjFIIPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238963AbjFIIPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:15:42 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1681FDE;
        Fri,  9 Jun 2023 01:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1686298539; x=1717834539;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Mb1slm/8ZxVzVyUF3XdtLt7ptCWTNk/wjWJvkjEJas8=;
  b=LjoiXRrnaFPlyLY3sTSW1ycLJksoiJM8kAZ6whxDIYrOJ3GjZnisflb9
   7p+ud1ujGM3IajGr16/+1CxyZ0mKItjyFxtWhzqf3MGfVZ9ARZMYPit5r
   7ARdaqYnz7U7U3isucGsWTU46V/ShZ/aCtYFfzsf7oB/GZoY24abSFKXQ
   Eva5z3yJ4CAv/I8qwAADssqyCiaehrZMu5GvRXhq7U/gVu0/U6MEjtZfQ
   /A4S+0um3xB85j4RXGpupYs5B2XjyVUplEzjixeRJ7CHnShvvfAMxTzz5
   HKyQlyJi/r9XfmyAvBdw9opMoTbIfTkqgzwGInXa4gecCt1Joil87N60T
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,228,1681164000"; 
   d="scan'208";a="31359501"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 09 Jun 2023 10:15:37 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 09 Jun 2023 10:15:37 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 09 Jun 2023 10:15:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1686298537; x=1717834537;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Mb1slm/8ZxVzVyUF3XdtLt7ptCWTNk/wjWJvkjEJas8=;
  b=onh31Dumrcp7hd3ZCvtI/QxzmzVrYVi5X75LN/evvJSPHyAMFsR9QAFS
   2n/AvSCXYkWc88Sm4Nh4PST1Go/VT9StacaCDw6OnXiJlWd8u7k6l7L4C
   T0jNMIJ77QK0P1smIi5+qMrMBgMB6ydf8HtKEdcwS5XtViuBEy9QaJnmg
   dIpDMmhDsnEoxNDi9ZdlPIPwNdPKaPBF9m5LodOWpsiuLN9Weg6CWXL/p
   K7sH4jH+HMu4qK3yjaXEydlss4MSUB44sf3bVNKEVqPKkrMLDIXoe7y3r
   VJlbp6Q5ngC9vgFIcA+iriOGfImLUHwWsdOARrAWzzsXOQV35u8fxcKe0
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,228,1681164000"; 
   d="scan'208";a="31359500"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 09 Jun 2023 10:15:37 +0200
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 5E7DC280087;
        Fri,  9 Jun 2023 10:15:37 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux@ew.tq-group.com,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/2] spi: dt-bindings: introduce linux,use-rt-queue flag
Date:   Fri, 09 Jun 2023 10:15:37 +0200
Message-ID: <3241150.44csPzL39Z@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <CACRpkdb=2fogk3bEa4fkPVYQivnvLh1F1TnBj7og43ak+F8gPw@mail.gmail.com>
References: <20230602115201.415718-1-matthias.schiffer@ew.tq-group.com> <6a0abd6bba2f8f940e695dfa9fd0c5f8ee19064f.camel@ew.tq-group.com> <CACRpkdb=2fogk3bEa4fkPVYQivnvLh1F1TnBj7og43ak+F8gPw@mail.gmail.com>
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

Hi all,

Am Freitag, 9. Juni 2023, 09:41:14 CEST schrieb Linus Walleij:
> On Wed, Jun 7, 2023 at 2:55=E2=80=AFPM Matthias Schiffer
>=20
> <matthias.schiffer@ew.tq-group.com> wrote:
> > It is not clear to me what alternative options we currently have if we
> > want a setting to be effective from the very beginning, before
> > userspace is running. Of course adding a cmdline option would work, but
> > that seems worse than having it in the DT in every possible way.
>=20
> A agree with Mark that a command line option isn't that bad. It's somethi=
ng
> that pertains to just the Linux kernel after all? And you can put that
> command line option in the default device tree, in chosen, if you want.

I don't like the idea of a command line enabling realtime scheduling for al=
l=20
instances of the SPI controller driver or even all SPI controllers. Actuall=
y=20
this might be worse if a non-rt SPI bus is considered for RT scheduling.
IMHO this should be configurable per SPI controller, e.g. a sysfs attribute.

> No-one is going to
> complain about that.

IIRC someone (maybe Greg K-H) opposed pretty hard against (module) paramete=
rs=20
for (driver) configuration, but I can't find the post to back my statement.

Best regards,
Alexander

> Yours,
> Linus Walleij
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


=2D-=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
http://www.tq-group.com/


