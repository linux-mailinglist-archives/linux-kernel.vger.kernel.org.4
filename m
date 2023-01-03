Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDF265C322
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 16:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjACPjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 10:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbjACPjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 10:39:11 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E868411C0E;
        Tue,  3 Jan 2023 07:39:08 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 2699FFF817;
        Tue,  3 Jan 2023 15:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1672760346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2L+bmmDM9ro1mRFPeFaf7i57I/YynxK9X8KdSETgfrY=;
        b=PoDfyemwnltiOnVsaV2CPslGfqPYBBt9PRlRQ76lJEosH//uKHo2X9z5nabXK50loQu7dm
        9tgOo5XZu1gF3Pn5gKV82UHaO7XI0mUgq3Q4crPxNvvY1T5UqL9/hh5nNsTDymognQI6PM
        fw8UVg71ALpiXdBw+kXoBPPOnl/kKjn6b9fCqitrtWvBWBI2n1CknbkU1S1t5rm7V8AbZK
        9UfVy1UYt7xbehEJcxOHAydf17PX9tfI7jX2hGUXg+oQ9tT2lVCkL/dh6ZLnf0eejkF22l
        3gaaPYyMPQOx8EeKacDo5kSfJyGgN+uDxYQpJjgYpHgQcUe9LfgMYhDNPgC46g==
Date:   Tue, 3 Jan 2023 16:39:02 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Michael Walle <michael@walle.cc>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH v5 00/21] nvmem: core: introduce NVMEM layouts
Message-ID: <20230103163902.218cb5c7@xps-13>
In-Reply-To: <20221206200740.3567551-1-michael@walle.cc>
References: <20221206200740.3567551-1-michael@walle.cc>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

michael@walle.cc wrote on Tue,  6 Dec 2022 21:07:19 +0100:

> This is now the third attempt to fetch the MAC addresses from the VPD
> for the Kontron sl28 boards. Previous discussions can be found here:
> https://lore.kernel.org/lkml/20211228142549.1275412-1-michael@walle.cc/
>=20
>=20
> NVMEM cells are typically added by board code or by the devicetree. But
> as the cells get more complex, there is (valid) push back from the
> devicetree maintainers to not put that handling in the devicetree.
>=20
> Therefore, introduce NVMEM layouts. They operate on the NVMEM device and
> can add cells during runtime. That way it is possible to add more complex
> cells than it is possible right now with the offset/length/bits
> description in the device tree. For example, you can have post processing
> for individual cells (think of endian swapping, or ethernet offset
> handling).
>=20
> The imx-ocotp driver is the only user of the global post processing hook,
> convert it to nvmem layouts and drop the global post pocessing hook.
>=20
> For now, the layouts are selected by the device tree. But the idea is
> that also board files or other drivers could set a layout. Although no
> code for that exists yet.
>=20
> Thanks to Miquel, the device tree bindings are already approved and merge=
d.
>=20
> NVMEM layouts as modules?
> While possible in principle, it doesn't make any sense because the NVMEM
> core can't be compiled as a module. The layouts needs to be available at
> probe time. (That is also the reason why they get registered with
> subsys_initcall().) So if the NVMEM core would be a module, the layouts
> could be modules, too.

I believe this series still applies even though -rc1 (and -rc2) are out
now, may we know if you consider merging it anytime soon or if there
are still discrepancies in the implementation you would like to
discuss? Otherwise I would really like to see this laying in -next a
few weeks before being sent out to Linus, just in case.

Thanks,
Miqu=C3=A8l
