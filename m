Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3766DBB67
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 16:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjDHODF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 10:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjDHOCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 10:02:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC27FF0F
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 07:02:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92E78615AD
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 14:02:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE934C4339B;
        Sat,  8 Apr 2023 14:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680962551;
        bh=UnGtV5BVxvXKqPWOEAt96UXn/bp5B5sv9wg2mMjagoY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m7/ul2RkVvHroOCKT+cSaOvKQnqE0kB+oOFBocBOs9GYpcWqlqkMWOpO54XsRwxi/
         ADrOV+yqOFSq0OAjaWA/W1etZwvDqvrau2Ve/EvPK0iEsTpo/xWb9vr2Krkv0oLGH3
         3Xn2MCJAhWe4VE8Yci2N2o+CYuoqa4+48uk1jxG7sC+L2IOz0b39D+ohY+TmrYQ0fW
         cwTZrM/HlIV+OnbmJ8QUacIP2sPug7i9og5z7KfYsUMq5RUx3QGja9wkfX8ZbqiOdc
         cH2AeCxwdhJwm4q46TTrJD91Ye1kTgFcv/WtDJQE4d7wLeaQmgoC+bV0TkKTJynoMl
         sy3lg8Iii/qRA==
Received: by pali.im (Postfix)
        id 8492839D1; Sat,  8 Apr 2023 16:02:27 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 12/13] powerpc/85xx: p2020: Enable boards by new config option CONFIG_PPC_P2020
Date:   Sat,  8 Apr 2023 16:01:21 +0200
Message-Id: <20230408140122.25293-13-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230408140122.25293-1-pali@kernel.org>
References: <20230408140122.25293-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generic unified P2020 machine description which supports all P2020-based
boards is now in separate file p2020.c. So create a separate config option
CONFIG_PPC_P2020 for it.

Previously machine descriptions for P2020 boards were enabled by
CONFIG_MPC85xx_DS or CONFIG_MPC85xx_RDB option. So set CONFIG_PPC_P2020 to
be enabled by default when one of those option is enabled.

This allows to compile support for P2020 boards without need to have
enabled support for older mpc85xx boards. And to compile kernel for old
mpc85xx boards without having enabled support for new P2020 boards.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/platforms/85xx/Kconfig  | 22 ++++++++++++++++++----
 arch/powerpc/platforms/85xx/Makefile |  5 +++--
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index a8ce6616fd0a..9315a3b69d6d 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -78,23 +78,37 @@ config MPC8536_DS
 	  This option enables support for the MPC8536 DS board
 
 config MPC85xx_DS
-	bool "Freescale MPC8544 DS / MPC8572 DS / P2020 DS"
+	bool "Freescale MPC8544 DS / MPC8572 DS"
 	select PPC_I8259
 	select DEFAULT_UIMAGE
 	select FSL_ULI1575 if PCI
 	select SWIOTLB
 	help
-	  This option enables support for the MPC8544 DS, MPC8572 DS and P2020 DS boards
+	  This option enables support for the MPC8544 DS and MPC8572 DS boards
 
 config MPC85xx_RDB
-	bool "Freescale P102x MBG/UTM/RDB and P2020 RDB"
+	bool "Freescale P102x MBG/UTM/RDB"
 	select PPC_I8259
 	select DEFAULT_UIMAGE
 	select SWIOTLB
 	help
 	  This option enables support for the P1020 MBG PC, P1020 UTM PC,
 	  P1020 RDB PC, P1020 RDB PD, P1020 RDB, P1021 RDB PC, P1024 RDB,
-	  P1025 RDB, P2020 RDB and P2020 RDB PC boards
+	  and P1025 RDB boards
+
+config PPC_P2020
+	bool "Freescale P2020"
+	default y if MPC85xx_DS || MPC85xx_RDB
+	select DEFAULT_UIMAGE
+	select SWIOTLB
+	imply PPC_I8259
+	imply FSL_ULI1575 if PCI
+	help
+	  This option enables generic unified support for any board with the
+	  Freescale P2020 processor.
+
+	  For example: P2020 DS board, P2020 RDB board, P2020 RDB PC board or
+	  CZ.NIC Turris 1.x boards.
 
 config P1010_RDB
 	bool "Freescale P1010 RDB"
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index 0a0011e8c63c..e3d977624e33 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -17,13 +17,14 @@ obj-$(CONFIG_MPC8560_ADS) += mpc85xx_ads.o
 obj-$(CONFIG_MPC85xx_CDS) += mpc85xx_cds.o
 obj-$(CONFIG_MPC8536_DS)  += mpc8536_ds.o
 obj8259-$(CONFIG_PPC_I8259)   += mpc85xx_8259.o
-obj-$(CONFIG_MPC85xx_DS)  += mpc85xx_ds.o p2020.o $(obj8259-y)
+obj-$(CONFIG_MPC85xx_DS)  += mpc85xx_ds.o $(obj8259-y)
 obj-$(CONFIG_MPC85xx_MDS) += mpc85xx_mds.o
-obj-$(CONFIG_MPC85xx_RDB) += mpc85xx_rdb.o p2020.o
+obj-$(CONFIG_MPC85xx_RDB) += mpc85xx_rdb.o
 obj-$(CONFIG_P1010_RDB)   += p1010rdb.o
 obj-$(CONFIG_P1022_DS)    += p1022_ds.o
 obj-$(CONFIG_P1022_RDK)   += p1022_rdk.o
 obj-$(CONFIG_P1023_RDB)   += p1023_rdb.o
+obj-$(CONFIG_PPC_P2020)   += p2020.o $(obj8259-y)
 obj-$(CONFIG_TWR_P102x)   += twr_p102x.o
 obj-$(CONFIG_CORENET_GENERIC)   += corenet_generic.o
 obj-$(CONFIG_FB_FSL_DIU)	+= t1042rdb_diu.o
-- 
2.20.1

