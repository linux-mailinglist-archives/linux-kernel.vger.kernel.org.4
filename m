Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D378365EA05
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 12:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbjAELfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 06:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbjAELfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 06:35:43 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B304C713;
        Thu,  5 Jan 2023 03:35:40 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D884FE0002;
        Thu,  5 Jan 2023 11:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1672918539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P3hfoi/7J5CIyjBCsT+TUV6DEwamqcoR9VCTKwBJrmg=;
        b=hsppRdJjuG5g9j+sYuy6WsOGIwlIs+4HO4DWCdjJXncW83/1btIOw+qUW73uWhLgjAOPGW
        eb3q/nFosbt3NHTYnkXaup63uNmMPycnb/UaDgkvte60YOgpaYwfp2dARiTniY28MUG5Ba
        rxAMj8jKtnG4PQz+z5T4bk2myQWwJ4/OJQcK9PW+XLtr25QmYKyQBLhQ2TlbnUCewG1tau
        4ADrH4lvlATEjRdPDqRRjN/vamUugdk3UxOzp6wAIMpR/P02DCnUwA8l6rSq4/X3krSCxg
        xStHQmidHMlF6PyorE+5NziSlASS6eC927LDkSJoUf+cHwZxuKUC6RydjbRoxQ==
Date:   Thu, 5 Jan 2023 12:35:34 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Michael Walle <michael@walle.cc>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH v5 00/21] nvmem: core: introduce NVMEM layouts
Message-ID: <20230105123534.38a70640@xps-13>
In-Reply-To: <2143916.GUh0CODmnK@steina-w>
References: <20221206200740.3567551-1-michael@walle.cc>
        <20230103163902.218cb5c7@xps-13>
        <cf00e248-1f2c-d4ce-868d-9f77b2c9b76f@linaro.org>
        <2143916.GUh0CODmnK@steina-w>
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

alexander.stein@ew.tq-group.com wrote on Thu, 05 Jan 2023 12:04:52
+0100:

> Am Dienstag, 3. Januar 2023, 16:51:31 CET schrieb Srinivas Kandagatla:
> > Hi Miquel,
> >=20
> > On 03/01/2023 15:39, Miquel Raynal wrote: =20
> > > Hi Srinivas,
> > >=20
> > > michael@walle.cc wrote on Tue,  6 Dec 2022 21:07:19 +0100: =20
> > >> This is now the third attempt to fetch the MAC addresses from the VPD
> > >> for the Kontron sl28 boards. Previous discussions can be found here:
> > >> https://lore.kernel.org/lkml/20211228142549.1275412-1-michael@walle.=
cc/
> > >>=20
> > >>=20
> > >> NVMEM cells are typically added by board code or by the devicetree. =
But
> > >> as the cells get more complex, there is (valid) push back from the
> > >> devicetree maintainers to not put that handling in the devicetree.
> > >>=20
> > >> Therefore, introduce NVMEM layouts. They operate on the NVMEM device=
 and
> > >> can add cells during runtime. That way it is possible to add more co=
mplex
> > >> cells than it is possible right now with the offset/length/bits
> > >> description in the device tree. For example, you can have post proce=
ssing
> > >> for individual cells (think of endian swapping, or ethernet offset
> > >> handling).
> > >>=20
> > >> The imx-ocotp driver is the only user of the global post processing =
hook,
> > >> convert it to nvmem layouts and drop the global post pocessing hook.
> > >>=20
> > >> For now, the layouts are selected by the device tree. But the idea is
> > >> that also board files or other drivers could set a layout. Although =
no
> > >> code for that exists yet.
> > >>=20
> > >> Thanks to Miquel, the device tree bindings are already approved and
> > >> merged.
> > >>=20
> > >> NVMEM layouts as modules?
> > >> While possible in principle, it doesn't make any sense because the N=
VMEM
> > >> core can't be compiled as a module. The layouts needs to be availabl=
e at
> > >> probe time. (That is also the reason why they get registered with
> > >> subsys_initcall().) So if the NVMEM core would be a module, the layo=
uts
> > >> could be modules, too. =20
> > >=20
> > > I believe this series still applies even though -rc1 (and -rc2) are o=
ut
> > > now, may we know if you consider merging it anytime soon or if there
> > > are still discrepancies in the implementation you would like to
> > > discuss? Otherwise I would really like to see this laying in -next a
> > > few weeks before being sent out to Linus, just in case. =20
> >=20
> > Thanks for the work!
> >=20
> > Lets get some testing in -next. =20
>=20
> This causes the following errors on existing boards (imx8mq-tqma8mq-
> mba8mx.dtb):
> root@tqma8-common:~# uname -r
> 6.2.0-rc2-next-20230105
>=20
> > OF: /soc@0: could not get #nvmem-cell-cells for /soc@0/bus@30000000/ =20
> efuse@30350000/soc-uid@4
> > OF: /soc@0/bus@30800000/ethernet@30be0000: could not get #nvmem-cell-ce=
lls  =20
> for /soc@0/bus@30000000/efuse@30350000/mac-address@90
>=20
> These are caused because '#nvmem-cell-cells =3D <0>;' is not explicitly s=
et in=20
> DT.
>=20
> > TI DP83867 30be0000.ethernet-1:0e: error -EINVAL: failed to get nvmem c=
ell  =20
> io_impedance_ctrl
> > TI DP83867: probe of 30be0000.ethernet-1:0e failed with error -22 =20
>=20
> These are caused because of_nvmem_cell_get() now returns -EINVAL instead =
of -
> ENODEV if the requested nvmem cell is not available.

Should we just assume #nvmem-cell-cells =3D <0> by default? I guess it's
a safe assumption.

Thanks,
Miqu=C3=A8l
