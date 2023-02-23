Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21B56A066F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 11:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbjBWKjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 05:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbjBWKjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 05:39:17 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABE61BDC;
        Thu, 23 Feb 2023 02:38:41 -0800 (PST)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A5FF1C0013;
        Thu, 23 Feb 2023 10:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1677148720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/rB3kVT/sYirOvv4MNQgAyUEPq/gTVMO3250D5hg4W0=;
        b=WCDlwiLV/su0a96s/qyddZnpAIyCrc0q1AFHjP88p24o7t5mg2K2enoE1TYN0zlDE5VmRs
        Bzzs2AWnCPDZNd9R1GShzrUlXGO+mtvRDkP23pUAvyBAf+FqQt7qCrJ0HB3e9p873n4EYN
        4A4Vexf2CQAtbirYPRqdI0tgB/25094n+0jrYy6j+BaZhn5zekn741Bv9lYXAi7+MrHLvZ
        l8LzhgCdYdGXYWu+ose2NkucLH58XztTsEujBCuhUBaR9n4MmcxNqwXGFBh2pGB9fov0HT
        XAuXBV1W3WFidxVJPf6f56vp5Wz87r+nEvlditXGdnYBipobudW33n0olgt7qQ==
Date:   Thu, 23 Feb 2023 11:41:13 +0100
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lizhi Hou <lizhi.hou@xilinx.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 0/2] of: populate of_root_node if not set (alternate)
Message-ID: <20230223114113.7865938b@fixe.home>
In-Reply-To: <20230222221051.809091-1-frowand.list@gmail.com>
References: <20230222221051.809091-1-frowand.list@gmail.com>
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

Le Wed, 22 Feb 2023 16:10:49 -0600,
Frank Rowand <frowand.list@gmail.com> a =C3=A9crit :

> This series is a different implementation to achieve the goals of
> https://lore.kernel.org/r/20220623105044.152832-1-clement.leger@bootlin.c=
om
>=20
> In order to apply overlays or create new nodes under the root node, the
> kernel expects of_root to be set. On some system where a device-tree was
> not provided by firmware (x86 for instance) if CONFIG_OF is enabled,
> then we will end up with a null of_root. This series adds support to
> create this root node using a builtin dtb and removes the manual
> creation of the root node done in unittests.c.

Hi Frank, I'm currently testing your series and I encountered some
crashes at boot. Looks like it comes from the
early_init_dt_alloc_memory_arch() that calls panic. Maybe the memblock
allocator is not ready yet. Please note that I'm testing it on a x86
kernel. I'll investigate that.

Regarding the series itself it seems ok to me.

Thanks,

Cl=C3=A9ment

>=20
> Changes since version 1: (patch 1/2)
>   - refresh for 6.2-rc1
>   - update Signed-off-by
>   - fix typo in of_fdt.h: s/of_setup/setup_of
>   - unflatten_device_tree(): validate size in header field dtb_empty_root
>     that will be used to copy dtb_empty_root
>   - add Kconfig option to manually select CONFIG_OF_EARLY_FLATTREE
>=20
> Changes since version 1: (patch 2/2)
>   - refresh for 6.2-rc1
>   - update Signed-off-by
>   - fix formatting error (leading space) in patch comment
>=20
> Frank Rowand (2):
>   of: create of_root if no dtb provided
>   of: unittest: treat missing of_root as error instead of fixing up
>=20
>  drivers/of/Kconfig        |  7 ++++++-
>  drivers/of/Makefile       |  2 +-
>  drivers/of/empty_root.dts |  6 ++++++
>  drivers/of/fdt.c          | 27 ++++++++++++++++++++++++++-
>  drivers/of/unittest.c     | 16 ++++++----------
>  include/linux/of_fdt.h    |  2 ++
>  init/main.c               |  2 ++
>  7 files changed, 49 insertions(+), 13 deletions(-)
>  create mode 100644 drivers/of/empty_root.dts
>=20



--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
