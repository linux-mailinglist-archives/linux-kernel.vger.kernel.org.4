Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3C8710206
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 02:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234962AbjEYAcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 20:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjEYAcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 20:32:08 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84967AA
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 17:32:06 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id C401C2C0288;
        Thu, 25 May 2023 12:31:57 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1684974717;
        bh=Lvr1PvxyEMKfKUGJolqQlJ6+ld4nzaPBzJ+1S/SPA/0=;
        h=From:To:Cc:Subject:Date:From;
        b=sNaiXdW98mQypYzw+clMx7vlTcQeyVcQVkVPHoLe6qmSidvGHc7/1NtlxJHC/hOf+
         /rrhkl+DZC3Z5MhS2nnmwAOyUHRSyjLzIcIcdSV2Yu00qOVzTH6sB0X2p55Rc+IkHq
         Xr5ZbVi2pUxq5P2vFv9VGxvmGDwEeyehXJlsQntfP1aMoF9NGiVomTcek93lEv05Qf
         uAQGiYsKDn6D04RifJP6y9SLSNlLCSBuZrvnKgdBX9bJE15tDWuw8IsoWBNWwH5sD0
         yb8KlJtlFYak7j7MtQAsTiw5LGJjOop0cfi/DnFzEefGfrlxh3y37Bxt7MW/ijq9PC
         cJE0lS3at4wOg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B646eac7d0000>; Thu, 25 May 2023 12:31:57 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id 929A913EDE9;
        Thu, 25 May 2023 12:31:57 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 8E441281CC2; Thu, 25 May 2023 12:31:57 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        bbrezillon@kernel.org
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v3 1/2] mtd: rawnand: marvell: ensure timing values are written
Date:   Thu, 25 May 2023 12:31:52 +1200
Message-Id: <20230525003154.2303012-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=cLieTWWN c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=P0xRbXHiH_UA:10 a=P-IC7800AAAA:8 a=txcOHvV6KX-ElXq2eNMA:9 a=d3PnA9EDa4IxuAV0gXij:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When new timing values are calculated in marvell_nfc_setup_interface()
ensure that they will be applied in marvell_nfc_select_target() by
clearing the selected_chip pointer.

Fixes: b25251414f6e ("mtd: rawnand: marvell: Stop implementing ->select_c=
hip()")
Suggested-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    This at least gets me to a point where I can illustrated the problem
    reported to me. It appears that despite the chip correctly reporting
    support for SDR timing modes up to 4 the observed tWC is 20ns. I've n=
ot
    seen any actual problem running in this state the only complaint is t=
hat
    the datasheet says the minimum tWC is 25ns.
   =20
    If I make a change to my bootloader such that the NAND Clock Frequenc=
y
    Select bit (0xF2440700:0) to 1 before booting the kernel _and_ I remo=
ve
    the extra factor of 2 from the period_ns calculation I observe tWC of
    about 60ns. If I don't remove the factor of 2 the NAND interface does=
n't
    work (can't write BBT).
   =20
    Changes in v3:
    - none
    Changes in v2:
    - reword comment per suggestion from Miquel, add fixes tag

 drivers/mtd/nand/raw/marvell_nand.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/m=
arvell_nand.c
index afb424579f0b..f1fcf136ad03 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -2457,6 +2457,12 @@ static int marvell_nfc_setup_interface(struct nand=
_chip *chip, int chipnr,
 			NDTR1_WAIT_MODE;
 	}
=20
+	/*
+	 * Reset nfc->selected_chip so the next command will cause the timing
+	 * registers to be updated in marvell_nfc_select_target().
+	 */
+	nfc->selected_chip =3D NULL;
+
 	return 0;
 }
=20
--=20
2.40.1

