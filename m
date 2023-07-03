Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90D174544E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 05:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjGCDvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 23:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjGCDvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 23:51:04 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B9F1B5
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 20:51:02 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id DD9612C0191;
        Mon,  3 Jul 2023 15:50:48 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1688356248;
        bh=1xCbsbTLGy9beD3/PSY5qz1J2AtdPls2UXJzcoYemB4=;
        h=From:To:Cc:Subject:Date:From;
        b=EFuAuww7qGf0rBKw/+pQPO+G/t7UYsttAjWwVjrdvH08k2w++XMWDb4bJ/tv0PLkp
         wNJL1hzzxFAdUkiUx4VkVpPa2f0xs6eF3KIUkaqlEa6Xl2VG7GyYmTIPACK4ZpjyHa
         RSyknsVjn2SzqtNAO8EEiFUuwm74+xFcs9GCrpxWR0KRbpVR1vCvy2pz6xcjz2Qsaw
         mjNl3ypqb9JGlmA7luBOFzw6BF+eHo4Ye/IXEHH3AtFsYIzMF5+S7RB3wRN5BTpaHI
         avvxKppg/osijkO6j7qXtSKIWGyLVbwTDRW+Uc/Osb6cFXJdfUik4x9amy5HHG5opL
         uONCeERF42bZQ==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B64a245980000>; Mon, 03 Jul 2023 15:50:48 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id A0A1E13EE32;
        Mon,  3 Jul 2023 15:50:48 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 9E7C4283AFC; Mon,  3 Jul 2023 15:50:48 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, gregory.clement@bootlin.com
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v3 0/3] mtd: rawnand: marvell: add support for AC5 SoC
Date:   Mon,  3 Jul 2023 15:50:41 +1200
Message-ID: <20230703035044.2063303-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=NPqrBHyg c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=ws7JD89P4LkA:10 a=PnpXwi1vBEG2Y57vC9MA:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the NAND Flash Controller on the AC5/AC5X SO=
C. Its
dependent series are all in mainline now so this should apply cleanly on =
top of
that.

I've tried to stick to the minimal changes required to get the NFC workin=
g on
the board I have (AC5X + S34ML02G2). Marvell's SDK has hard coded tables =
of
ndtr values for the different timing modes but so far that seems unnecess=
ary.

Chris Packham (3):
  dt-bindings: mtd: Add AC5 specific binding
  arm64: dts: marvell: Add NAND flash controller to AC5
  mtd: rawnand: marvell: add support for AC5 SoC

 .../bindings/mtd/marvell,nand-controller.yaml    |  1 +
 arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi    | 16 ++++++++++++++++
 drivers/mtd/nand/raw/Kconfig                     |  2 +-
 drivers/mtd/nand/raw/marvell_nand.c              | 16 ++++++++++++++++
 4 files changed, 34 insertions(+), 1 deletion(-)

--=20
2.41.0

