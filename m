Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB1273D62E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 05:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjFZDMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 23:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjFZDM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 23:12:27 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B74E53
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 20:12:24 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id CF3FC2C0547;
        Mon, 26 Jun 2023 15:12:20 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1687749140;
        bh=jaft/Wql30k5S8yiUIGneVwgwK9Vf12SNTJw/A9l/5c=;
        h=From:To:Cc:Subject:Date:From;
        b=ShCTtcPZUPzIvhJuok8iXidLPnKeiIp3gLaLTo4ajQf2ifq5Rf9/NRUBd1ey0mQj1
         kOFjhGDsmCp0ApouNO/sOnNCQcnFR+AW64uS6vMHN1Vx7fY8UltPBj27qAx98q7TLd
         dAZR0KUFhmcj1vDe7+XBefwLCWI9uQOHYZ4COpA8CEqXuJTgonUuuWPFFHsLoyo3WW
         jmPWSKSqjssG9Hf+ktH9wYz4gIpmAgerRNxm0J1YxxhA/wjitU8KtbvpT+Cq9O4HGi
         upzg7syaFrlFQhCQuCHkxugZ/keI9yVOOabvk9nWYNyupkm6mMJLPiV5/kK1occvwE
         8zkEMsglTyXKw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B649902140000>; Mon, 26 Jun 2023 15:12:20 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id 9F65413EE4B;
        Mon, 26 Jun 2023 15:12:20 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 9D858283B1A; Mon, 26 Jun 2023 15:12:20 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, gregory.clement@bootlin.com,
        pierre.gondois@arm.com, arnd@arndb.de, f.fainelli@gmail.com
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2 0/3] mtd: rawnand: marvell: add support for AC5 SoC
Date:   Mon, 26 Jun 2023 15:12:14 +1200
Message-ID: <20230626031217.870938-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=NPqrBHyg c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=of4jigFt-DYA:10 a=VwQbUJbxAAAA:8 a=BTILRwyEkoqLbeD1fBkA:9 a=AjGcO6oz07-iQ99wixmX:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the NAND Flash Controller on the AC5/AC5X SO=
C. It
needs to be applied on top of two other recent series [1] (applied to
mtd/fixes and mainline) [2] (applied to nand/next).

I've tried to stick to the minimal changes required to get the NFC workin=
g on
the board I have (AC5X + S34ML02G2). Marvell's SDK has hard coded tables =
of
ndtr values for the different timing modes but so far that seems unnecess=
ary.

[1] - https://lore.kernel.org/linux-mtd/20230525003154.2303012-1-chris.pa=
ckham@alliedtelesis.co.nz/raw
[2] - https://lore.kernel.org/linux-mtd/20230619040742.1108172-2-chris.pa=
ckham@alliedtelesis.co.nz/raw

Chris Packham (3):
  dt-bindings: mtd: Add AC5 specific binding
  arm64: dts: marvell: Add NAND flash controller to AC5
  mtd: rawnand: marvell: add support for AC5 SoC

 .../bindings/mtd/marvell,nand-controller.yaml    |  1 +
 arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi    | 10 ++++++++++
 drivers/mtd/nand/raw/Kconfig                     |  2 +-
 drivers/mtd/nand/raw/marvell_nand.c              | 16 ++++++++++++++++
 4 files changed, 28 insertions(+), 1 deletion(-)

--=20
2.41.0

