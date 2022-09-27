Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92235EB7E3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 04:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbiI0Cs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 22:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbiI0Crv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 22:47:51 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B930F61DAF
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 19:47:49 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 743802C0274;
        Tue, 27 Sep 2022 02:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1664246866;
        bh=rKulz42nZwV2iWZGSRczYGFQgXLRYskFDwJgUbHm7gs=;
        h=From:To:Cc:Subject:Date:From;
        b=r8zHnsA2Xef4GkU1VR1rpxWSgUTc2hhSKGvRCZgKV9pVmPkcjgaMC+gapmCqFnMHM
         jvL55jbqxJQNrnIhIUD+Q0KPn5K8DgsEflEbzT4vSOImVYWozOoDZsbXJlXpjan5xB
         x2jw1xuO6cMJMk/ywph09Lwg6LEM+Rf3UyptxvMC/7VNhY+mwH8wcC6Wap1i63Cw6K
         0eJ3X01lfHULrHh4wisrSfTbx3zDHIvtjCGORpDXO5BAp6+pDSki0Vqd8TjHQwwTNr
         cad5tlb4r5Cyg0oS1T/y6ijjQTJoK4y5OQAMOkbkuCLkZcCCkNmQYReOTjeem/lH30
         cRvzJ3Uah9RvA==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B633264520000>; Tue, 27 Sep 2022 15:47:46 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id 48B9D13EDD7;
        Tue, 27 Sep 2022 15:47:46 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 44CE62A00A4; Tue, 27 Sep 2022 15:47:46 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        bbrezillon@kernel.org
Cc:     Tony O'Brien <tony.obrien@alliedtelesis.co.nz>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] mtd: rawnand: marvell: Use correct logic for nand-keep-config
Date:   Tue, 27 Sep 2022 15:47:28 +1300
Message-Id: <20220927024728.28447-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=UoQdyN4B c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=xOM3xZuef0cA:10 a=JPI76n4z2mF8gNG91igA:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony O'Brien <tony.obrien@alliedtelesis.co.nz>

Originally the absence of the marvell,nand-keep-config property caused
the setup_data_interface function to be provided. However when
setup_data_interface was moved into nand_controller_ops the logic was
unintentionally inverted. Update the logic so that only if the
marvell,nand-keep-config property is present the bootloader NAND config
kept.

Fixes: 7a08dbaedd36 ("mtd: rawnand: Move ->setup_data_interface() to nand=
_controller_ops")
Signed-off-by: Tony O'Brien <tony.obrien@alliedtelesis.co.nz>
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    I think this is a bug that's been lurking for 4 years or so. I'm not
    sure that's particularly long in the life of an embedded device but i=
t
    does make me wonder if there have been other bug reports about it.
   =20
    We noticed this because we had a bootloader that used maxed out NAND
    timings which made the time it took the kernel to do anything on the
    file system longer than we expected.

 drivers/mtd/nand/raw/marvell_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/m=
arvell_nand.c
index 2455a581fd70..b248c5f657d5 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -2672,7 +2672,7 @@ static int marvell_nand_chip_init(struct device *de=
v, struct marvell_nfc *nfc,
 	chip->controller =3D &nfc->controller;
 	nand_set_flash_node(chip, np);
=20
-	if (!of_property_read_bool(np, "marvell,nand-keep-config"))
+	if (of_property_read_bool(np, "marvell,nand-keep-config"))
 		chip->options |=3D NAND_KEEP_TIMINGS;
=20
 	mtd =3D nand_to_mtd(chip);
--=20
2.37.3

