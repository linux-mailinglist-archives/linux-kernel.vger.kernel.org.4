Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC8765C372
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 16:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238094AbjACP6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 10:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238087AbjACP6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 10:58:50 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266B012080;
        Tue,  3 Jan 2023 07:58:48 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7BBE6E0004;
        Tue,  3 Jan 2023 15:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1672761527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1PDiBU/GoIjoQMxtR9ofH4gDtLhcbGK+av0qJpmmRtU=;
        b=gTYXjbLwQaFvz/pw/mVQUDUO3klTeU+FeYUnQeYPhNQuIZPFJoI6HJoWWmt6+U469Af/pF
        37qKV++t0/4lnz6RieVmejbkBg4EZ+n/TP69VIUGFFvaktT91ueSF8QQEbo2u02Sb3Udhx
        0AO9e6KUlzXudWYK9yjKSp7vWzzVN+O0R/eJAygzrwVt0V/yWWAt+vJwBAzMv0tQpxypNh
        o3sbTwHcQUh5nfdRPpSE0csEjIlj+6xQkVmItq+GLf1DO8knrTJaY/Y+/axoaOhciZutaJ
        nrk5LvLK3fWgKiIuWQR/zqORiwqwedREHoRhjFCix5R036aGBEkuns1egglDqg==
Date:   Tue, 3 Jan 2023 16:58:42 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Michael Walle <michael@walle.cc>, Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH v5 00/21] nvmem: core: introduce NVMEM layouts
Message-ID: <20230103165842.2f693bfa@xps-13>
In-Reply-To: <cf00e248-1f2c-d4ce-868d-9f77b2c9b76f@linaro.org>
References: <20221206200740.3567551-1-michael@walle.cc>
        <20230103163902.218cb5c7@xps-13>
        <cf00e248-1f2c-d4ce-868d-9f77b2c9b76f@linaro.org>
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

Hi Srinivas,

srinivas.kandagatla@linaro.org wrote on Tue, 3 Jan 2023 15:51:31 +0000:

> Hi Miquel,
>=20
> On 03/01/2023 15:39, Miquel Raynal wrote:
> > Hi Srinivas,
> >=20
> > michael@walle.cc wrote on Tue,  6 Dec 2022 21:07:19 +0100:
> >  =20
> >> This is now the third attempt to fetch the MAC addresses from the VPD
> >> for the Kontron sl28 boards. Previous discussions can be found here:
> >> https://lore.kernel.org/lkml/20211228142549.1275412-1-michael@walle.cc/
> >>
> >>
> >> NVMEM cells are typically added by board code or by the devicetree. But
> >> as the cells get more complex, there is (valid) push back from the
> >> devicetree maintainers to not put that handling in the devicetree.
> >>
> >> Therefore, introduce NVMEM layouts. They operate on the NVMEM device a=
nd
> >> can add cells during runtime. That way it is possible to add more comp=
lex
> >> cells than it is possible right now with the offset/length/bits
> >> description in the device tree. For example, you can have post process=
ing
> >> for individual cells (think of endian swapping, or ethernet offset
> >> handling).
> >>
> >> The imx-ocotp driver is the only user of the global post processing ho=
ok,
> >> convert it to nvmem layouts and drop the global post pocessing hook.
> >>
> >> For now, the layouts are selected by the device tree. But the idea is
> >> that also board files or other drivers could set a layout. Although no
> >> code for that exists yet.
> >>
> >> Thanks to Miquel, the device tree bindings are already approved and me=
rged.
> >>
> >> NVMEM layouts as modules?
> >> While possible in principle, it doesn't make any sense because the NVM=
EM
> >> core can't be compiled as a module. The layouts needs to be available =
at
> >> probe time. (That is also the reason why they get registered with
> >> subsys_initcall().) So if the NVMEM core would be a module, the layouts
> >> could be modules, too. =20
> >=20
> > I believe this series still applies even though -rc1 (and -rc2) are out
> > now, may we know if you consider merging it anytime soon or if there
> > are still discrepancies in the implementation you would like to
> > discuss? Otherwise I would really like to see this laying in -next a
> > few weeks before being sent out to Linus, just in case. =20
>=20
> Thanks for the work!
>=20
> Lets get some testing in -next.
>=20
>=20
> Applied now,

Excellent! Thanks a lot for the quick answer and thanks for applying,
let's see how it behaves.

Thanks,
Miqu=C3=A8l
