Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD921652403
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 16:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbiLTP5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 10:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233010AbiLTP5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 10:57:08 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0847C9FE4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 07:57:06 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E37F11BF211;
        Tue, 20 Dec 2022 15:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1671551825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mCQUAf7Zkzk+AreJl3bcOvu94fhcF4svN/mdiLj7C9w=;
        b=OztXlCctGdAbEdWDLpXDhXcXHIgBH0P8WrhuLRsL7HG9u9o1s2YTc8beVMWVGR1qUFsW5O
        oMyJY0SfsZ/t838/P34fHh2F0od/HtNk75nmQ/dSj0O/GGYzD3/SsdxNkGT6FVi8ZnfuYV
        HiwvQGxdNdrZ2zJQ9AJDwOE4fGF4u0b8HkbNdDayvWDn/YucqpWlaYDZ+TnfMQZAkevEqW
        lF36ERmd1aHWlZEY6WUdwB8078PG5q7/J1qGFyRBHQKjViemIq8l4tdKmDqgv5RXyY6jRM
        2E0jz5QC56ljpSmdOG6ghSMf7gzLntjFJvyBNqm2OYQoqV+ICFBLvm+nxMImzg==
Date:   Tue, 20 Dec 2022 16:57:01 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Walle <michael@walle.cc>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Mauro Lima <mauro.lima@eclypsium.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] mtd: cfi: allow building spi-intel standalone
Message-ID: <20221220165701.5696df1a@xps-13>
In-Reply-To: <cae6328b-5204-a1ab-810d-8fb64e466453@linaro.org>
References: <20221220141352.1486360-1-arnd@kernel.org>
        <cae6328b-5204-a1ab-810d-8fb64e466453@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
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

Hi Tudor,

tudor.ambarus@linaro.org wrote on Tue, 20 Dec 2022 17:44:49 +0200:

> Hi, Arnd,
>=20
> On 20.12.2022 16:13, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >=20
> > When MTD or MTD_CFI_GEOMETRY is disabled, the spi-intel driver
> > fails to build, as it includes the shared CFI header:
> >=20
> > include/linux/mtd/cfi.h:62:2: error: #warning No CONFIG_MTD_CFI_Ix sele=
cted. No NOR chip support can work. [-Werror=3Dcpp]
> >     62 | #warning No CONFIG_MTD_CFI_Ix selected. No NOR chip support ca=
n work.
> >=20
> > linux/mtd/spi-nor.h does not actually need to include cfi.h, so
> > remove the inclusion here to fix the warning. This uncovers a
> > missing #include in spi-nor/core.c so add that there to
> > prevent a different build issue.
> >=20
> > Fixes: e23e5a05d1fd ("mtd: spi-nor: intel-spi: Convert to SPI MEM")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de> =20
>=20
> Looks good to me. I'll let the linux-0day bot run over it and apply it
> once -rc1 is out.

The issue sometimes produces build errors, shall I send it through a
fixes PR instead?

Thanks,
Miqu=C3=A8l
