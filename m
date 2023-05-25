Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D824A710207
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 02:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbjEYAcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 20:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjEYAcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 20:32:08 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848E3A7
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 17:32:06 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id D03252C02E0;
        Thu, 25 May 2023 12:31:57 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1684974717;
        bh=7T+puFU3hojItCezGhGdpSM/kFMnpHzOFNeluLJHh3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pdYh/THsedCo1aXPzD0qB0J0YhFhlHOo/+1qq/nRiA/HI9y5gcD/kYhTkecp/cTAO
         jUZ4vGkWoXHuLhOSwqdCgF0gO1wRyK5GEG0tIZ3tg/YJ2sd/8NTvY2dskh7h52YIXC
         eBCuHS2ki3F0c9SqHC6rO48ZYyeKIiV8PHcx8DDgwd7EuEJ8kkWINI2TA4mbW++cRi
         EXYcxV91huo4hRMgfzMwwG+py/ibGsWyr855RL+Dpq57BiV9y+/fPbcZHosj+zY2Wx
         3y4v80GbEGwYWWu8vgixta/XuUyMkTbavzIyNbUogp2RFLI8tHrq83vQubtGZNu3DX
         FXsoSZLgjtp0w==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B646eac7d0001>; Thu, 25 May 2023 12:31:57 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id 93CF613EE63;
        Thu, 25 May 2023 12:31:57 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 902C3281CC0; Thu, 25 May 2023 12:31:57 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        bbrezillon@kernel.org
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v3 2/2] mtd: rawnand: marvell: don't set the NAND frequency select
Date:   Thu, 25 May 2023 12:31:53 +1200
Message-Id: <20230525003154.2303012-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230525003154.2303012-1-chris.packham@alliedtelesis.co.nz>
References: <20230525003154.2303012-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=cLieTWWN c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=P0xRbXHiH_UA:10 a=RTQhOw_aHlkS9OJicTUA:9
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

marvell_nfc_setup_interface() uses the frequency retrieved from the
clock associated with the nand interface to determine the timings that
will be used. By changing the NAND frequency select without reflecting
this in the clock configuration this means that the timings calculated
don't correctly meet the requirements of the NAND chip. This hasn't been
an issue up to now because of a different bug that was stopping the
timings being updated after they were initially set.

Fixes: b25251414f6e ("mtd: rawnand: marvell: Stop implementing ->select_c=
hip()")
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    I've set the fixes tag to b25251414f6e. The problem probably existed
    prior to that but without the other fix in this series it wouldn't be
    noticeable.
   =20
    With the two fixes from this series in place I get a tWC of 32ns whic=
h
    seems just about ideal.
   =20
    Changes in v3:
    - new

 drivers/mtd/nand/raw/marvell_nand.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/m=
arvell_nand.c
index f1fcf136ad03..30c15e4e1cc0 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -2900,10 +2900,6 @@ static int marvell_nfc_init(struct marvell_nfc *nf=
c)
 		regmap_update_bits(sysctrl_base, GENCONF_CLK_GATING_CTRL,
 				   GENCONF_CLK_GATING_CTRL_ND_GATE,
 				   GENCONF_CLK_GATING_CTRL_ND_GATE);
-
-		regmap_update_bits(sysctrl_base, GENCONF_ND_CLK_CTRL,
-				   GENCONF_ND_CLK_CTRL_EN,
-				   GENCONF_ND_CLK_CTRL_EN);
 	}
=20
 	/* Configure the DMA if appropriate */
--=20
2.40.1

