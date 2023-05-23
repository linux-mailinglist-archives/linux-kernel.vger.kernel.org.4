Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD39E70D24A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 05:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbjEWDVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 23:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjEWDVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 23:21:18 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A02991
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 20:21:14 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 163F22C04A5;
        Tue, 23 May 2023 15:21:05 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1684812065;
        bh=PvacrSuZu2RET2CmOngVt/QPNG7tALbTJoLo7+/4eIc=;
        h=From:To:Cc:Subject:Date:From;
        b=BFamZ64ekRb3dM58kiAyPEuxOGFjByrYaY+BRpA/lKLvTa3YzaeFZebzy0p6JHDc0
         DogCmal9IN40R2E0RHbaUk+GjrTkx6Z/2jWhjnKRvciiX+rtxWbulbXbTi8DIe3ZRf
         vEQ/gF/7QFCXNnh0gqn2dPHOq/9jB+FBjqRb06ojzM3rgnYEn4dE5FIJrB4YeJ3Pkk
         UZWuE/vRSiprfK6nAEyGRyowPGjNHMBDfRfRKs2AmjKJjQ2E19cipc/woc9WnEsRt9
         rllrn+x9F4Spoy6oGYTjL6D0RscBvmSZRwIofnNYn467x2T3uCTJfHca//EFZx5hfi
         JWbEtOHGCJEow==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B646c31200000>; Tue, 23 May 2023 15:21:04 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id D64A113EDE9;
        Tue, 23 May 2023 15:21:04 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id D219C283910; Tue, 23 May 2023 15:21:04 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] mtd: rawnand: marvell: ensure timing values are written
Date:   Tue, 23 May 2023 15:21:03 +1200
Message-Id: <20230523032103.208213-1-chris.packham@alliedtelesis.co.nz>
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

 drivers/mtd/nand/raw/marvell_nand.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/m=
arvell_nand.c
index afb424579f0b..3b5e4d5d220f 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -2457,6 +2457,12 @@ static int marvell_nfc_setup_interface(struct nand=
_chip *chip, int chipnr,
 			NDTR1_WAIT_MODE;
 	}
=20
+	/*
+	 * Reset nfc->selected_chip so the next command will cause the timing
+	 * registers to be restored in marvell_nfc_select_target().
+	 */
+	nfc->selected_chip =3D NULL;
+
 	return 0;
 }
=20
--=20
2.40.1

