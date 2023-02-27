Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C606A3E52
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 10:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjB0J2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 04:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjB0J2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 04:28:41 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC8583C5;
        Mon, 27 Feb 2023 01:28:38 -0800 (PST)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id EB35520002;
        Mon, 27 Feb 2023 09:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1677490116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZE5reitxUCyBN81BMuspQYpUlEWnwOCS93SMxWW2VGY=;
        b=C/0voqUiOGNCP5DEpBM5Mvz0D1VhzuXBjjfTIz1Yjmm3tJ1xMBMrglOqkTNKWbXFut2Nsx
        qWzJVvo9kQyUAnR55vLiT5yRhttL2NZc70Ya/12LQ+ctj0OoRmgit1zlFfQPoXQ5veLdSi
        OKCDF0/P1qPhwEFCiAe0C/ooAkLttYkqPkUOaAjdfJvs6tiVDGDAZPEo5zLUG5qI+QFylo
        AXYABLurR5xlkv6Nm2nC0jSZy1xeJ6smmsAy7CHVlg/wbS2BenfsqwVOVmkqmwoU67uhed
        aoZR5ENxYzX3cPEJCaawiWDFLjOzIdSIJwus5iBeBPz1MIBNKp++4nynbAfJ0w==
Date:   Mon, 27 Feb 2023 10:31:12 +0100
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lizhi Hou <lizhi.hou@xilinx.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 0/2] of: populate of_root_node if not set (alternate)
Message-ID: <20230227103112.47a5c0c3@fixe.home>
In-Reply-To: <12492b9f-1961-7d75-3197-41b4bce90b63@gmail.com>
References: <20230223213418.891942-1-frowand.list@gmail.com>
        <12492b9f-1961-7d75-3197-41b4bce90b63@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Thu, 23 Feb 2023 15:39:31 -0600,
Frank Rowand <frowand.list@gmail.com> a =C3=A9crit :

> Hi Cl=C3=A9ment,
>=20
> Can you please test this version of the patch series?

Hi Frank,

I can confirm it now works as expected, thanks for your patch !

Tested-by: Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com>

Cl=C3=A9ment

>=20
> Thanks!
>=20
> -Frank
>=20
> On 2/23/23 15:34, Frank Rowand wrote:
> > This series is a different implementation to achieve the goals of
> > https://lore.kernel.org/r/20220623105044.152832-1-clement.leger@bootlin=
.com
> >=20
> > In order to apply overlays or create new nodes under the root node, the
> > kernel expects of_root to be set. On some system where a device-tree was
> > not provided by firmware (x86 for instance) if CONFIG_OF is enabled,
> > then we will end up with a null of_root. This series adds support to
> > create this root node using a builtin dtb and removes the manual
> > creation of the root node done in unittests.c.
> >=20
> > Changes since version 2: (patch 1/2)
> >   - change of __dtb_empty_root_* from "void *" to "uint8_t []"
> >=20
> > Changes since version 1: (patch 1/2)
> >   - refresh for 6.2-rc1
> >   - update Signed-off-by
> >   - fix typo in of_fdt.h: s/of_setup/setup_of
> >   - unflatten_device_tree(): validate size in header field dtb_empty_ro=
ot
> >     that will be used to copy dtb_empty_root
> >   - add Kconfig option to manually select CONFIG_OF_EARLY_FLATTREE
> >=20
> > Changes since version 1: (patch 2/2)
> >   - refresh for 6.2-rc1
> >   - update Signed-off-by
> >   - fix formatting error (leading space) in patch comment
> >=20
> > Frank Rowand (2):
> >   of: create of_root if no dtb provided
> >   of: unittest: treat missing of_root as error instead of fixing up
> >=20
> >  drivers/of/Kconfig        |  7 ++++++-
> >  drivers/of/Makefile       |  2 +-
> >  drivers/of/empty_root.dts |  6 ++++++
> >  drivers/of/fdt.c          | 27 ++++++++++++++++++++++++++-
> >  drivers/of/unittest.c     | 16 ++++++----------
> >  include/linux/of_fdt.h    |  2 ++
> >  init/main.c               |  2 ++
> >  7 files changed, 49 insertions(+), 13 deletions(-)
> >  create mode 100644 drivers/of/empty_root.dts
> >  =20
>=20



--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
