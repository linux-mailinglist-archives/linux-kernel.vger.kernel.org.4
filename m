Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF417173FD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 04:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbjEaC7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 22:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233821AbjEaC7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 22:59:17 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A468A12A
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 19:59:13 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 97ECF2C0596;
        Wed, 31 May 2023 14:58:59 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1685501939;
        bh=OMlElmdtZdi259PjJVmy6JwGQG2VyhDI2nE8htIQ6Rk=;
        h=From:To:Cc:Subject:Date:From;
        b=vdY6KV83oo+1h8uD9l7V5YlhyVrD9ZtyKeL41WG5ZP/LfRTinVMZIsoDbWJ+G9t6T
         Zx8dvWLQhIPtFFxeeA/YCkt3rEzzQoVMp6esiT1KpzV+bfUmO1ivpmWRPhsJw58BoF
         s7o8tGUuyb8nygG+m9hDnsD02D90gM6/rOsYqNWYCWMNVOzXHFksCESwXnR74yfL3H
         avoEcQFXF4moOYFDrL8aauwhdqDBMbwk72BQZeK4HzImCOaiLdqu3ILsjqGiFL4MbM
         tqzlcLOFl+AMqEuAqxeqGTYJWA9OPU89cp6jOUYVlkPC0ACgy5xfEVcbH8m6S0hZ15
         dRpjOCloOgo1w==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B6476b7f30000>; Wed, 31 May 2023 14:58:59 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id 6949113EDD5;
        Wed, 31 May 2023 14:58:59 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 632ED280AFE; Wed, 31 May 2023 14:58:59 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, arnd@arndb.de, daniel.lezcano@linaro.org,
        neil.armstrong@linaro.org, f.fainelli@gmail.com,
        christophe.kerello@foss.st.com, liang.yang@amlogic.com,
        jdelvare@suse.de
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 0/2] mtd: rawnand: marvell: add support for AC5 SoC
Date:   Wed, 31 May 2023 14:58:45 +1200
Message-Id: <20230531025847.1284862-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=cLieTWWN c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=P0xRbXHiH_UA:10 a=VwQbUJbxAAAA:8 a=BTILRwyEkoqLbeD1fBkA:9 a=AjGcO6oz07-iQ99wixmX:22
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

This series adds support for the NAND Flash Controller on the AC5/AC5X SO=
C. It
needs to be applied on top of two other recent series [1] (applied to
mtd/fixes, not yet in mainline) [2] (v7 out for review).

I've tried to stick to the minimal changes required to get the NFC workin=
g on
the board I have (AC5X + S34ML02G2). Marvell's SDK has hard coded tables =
of
ndtr values for the different timing modes but so far that seems unnecess=
ary.

[1] - https://lore.kernel.org/linux-mtd/20230525003154.2303012-1-chris.pa=
ckham@alliedtelesis.co.nz/raw
[2] - https://lore.kernel.org/linux-mtd/20230530235456.1009082-1-chris.pa=
ckham@alliedtelesis.co.nz/raw

Chris Packham (2):
  dt-bindings: mtd: Add AC5 specific binding
  mtd: rawnand: marvell: add support for AC5 SoC

 .../bindings/mtd/marvell,nand-controller.yaml    |  1 +
 drivers/mtd/nand/raw/Kconfig                     |  2 +-
 drivers/mtd/nand/raw/marvell_nand.c              | 16 ++++++++++++++++
 3 files changed, 18 insertions(+), 1 deletion(-)

--=20
2.40.1

