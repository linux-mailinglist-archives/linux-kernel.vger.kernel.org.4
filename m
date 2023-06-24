Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D8B73CC6A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 20:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbjFXSle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 14:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233219AbjFXSlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 14:41:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CAFE6E
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 11:41:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE61060A37
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 18:41:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65CDC433CA;
        Sat, 24 Jun 2023 18:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687632080;
        bh=TIrTAbQw5qVoi7yCqWLabUyB2cPq3CNQClG9OoonF70=;
        h=From:To:Cc:Subject:Date:From;
        b=FVSoaXo6YXAIXzpuS2AZeaOu2GwEWF3wUea4EP2IUdkuc03affQmNt9y8x9WOl3OV
         DcuAL3Ctl0DJt9Kyk8lrdjd9PeImhwkTHXIght14dgbuoAcgGDm5juSqubqqUsHOEG
         qUAu7kJxu6dXcRxrwpoBLSZiBpOb9VZDwTE7WAWYvKv8+2IadBqADSqkx5EGD7VMid
         MK/UPGABL+2dP4UtOC3a4MvY1EbfGzffJTuI+9zTasP5OJTcyUwite0JwHyUmWVMJv
         udQfHCXpnw9BXmSUXoZAWfyKRXPJrP01a9xHIFhYRqQW1CK0vDbXYMa5pT87/ZeUM+
         +pIex/t3JyjwA==
From:   Roger Quadros <rogerq@kernel.org>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     krzk@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] mtd: rawnand: omap_elm: Fix incorrect type in assignment
Date:   Sun, 25 Jun 2023 00:10:21 +0530
Message-Id: <20230624184021.7740-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once the ECC word endianness is converted to BE32, we force cast it
to u32 so we can use elm_write_reg() which in turn uses writel().

Fixes below sparse warnings:

   drivers/mtd/nand/raw/omap_elm.c:180:37: sparse:     expected unsigned int [usertype] val
   drivers/mtd/nand/raw/omap_elm.c:180:37: sparse:     got restricted __be32 [usertype]
   drivers/mtd/nand/raw/omap_elm.c:185:37: sparse:     expected unsigned int [usertype] val
   drivers/mtd/nand/raw/omap_elm.c:185:37: sparse:     got restricted __be32 [usertype]
   drivers/mtd/nand/raw/omap_elm.c:190:37: sparse:     expected unsigned int [usertype] val
   drivers/mtd/nand/raw/omap_elm.c:190:37: sparse:     got restricted __be32 [usertype]
>> drivers/mtd/nand/raw/omap_elm.c:200:40: sparse: sparse: restricted __be32 degrades to integer
   drivers/mtd/nand/raw/omap_elm.c:206:39: sparse: sparse: restricted __be32 degrades to integer
   drivers/mtd/nand/raw/omap_elm.c:210:37: sparse:     expected unsigned int [assigned] [usertype] val
   drivers/mtd/nand/raw/omap_elm.c:210:37: sparse:     got restricted __be32 [usertype]
   drivers/mtd/nand/raw/omap_elm.c:213:37: sparse:     expected unsigned int [assigned] [usertype] val
   drivers/mtd/nand/raw/omap_elm.c:213:37: sparse:     got restricted __be32 [usertype]
   drivers/mtd/nand/raw/omap_elm.c:216:37: sparse:     expected unsigned int [assigned] [usertype] val
   drivers/mtd/nand/raw/omap_elm.c:216:37: sparse:     got restricted __be32 [usertype]
   drivers/mtd/nand/raw/omap_elm.c:219:37: sparse:     expected unsigned int [assigned] [usertype] val
   drivers/mtd/nand/raw/omap_elm.c:219:37: sparse:     got restricted __be32 [usertype]
   drivers/mtd/nand/raw/omap_elm.c:222:37: sparse:     expected unsigned int [assigned] [usertype] val
   drivers/mtd/nand/raw/omap_elm.c:222:37: sparse:     got restricted __be32 [usertype]
   drivers/mtd/nand/raw/omap_elm.c:225:37: sparse:     expected unsigned int [assigned] [usertype] val
   drivers/mtd/nand/raw/omap_elm.c:225:37: sparse:     got restricted __be32 [usertype]
   drivers/mtd/nand/raw/omap_elm.c:228:39: sparse: sparse: restricted __be32 degrades to integer

Fixes: bf22433575ef ("mtd: devices: elm: Add support for ELM error correction")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202306212211.WDXokuWh-lkp@intel.com/
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/mtd/nand/raw/omap_elm.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/nand/raw/omap_elm.c b/drivers/mtd/nand/raw/omap_elm.c
index 6e1eac6644a6..4a97d4a76454 100644
--- a/drivers/mtd/nand/raw/omap_elm.c
+++ b/drivers/mtd/nand/raw/omap_elm.c
@@ -177,17 +177,17 @@ static void elm_load_syndrome(struct elm_info *info,
 			switch (info->bch_type) {
 			case BCH8_ECC:
 				/* syndrome fragment 0 = ecc[9-12B] */
-				val = cpu_to_be32(*(u32 *) &ecc[9]);
+				val = (__force u32)cpu_to_be32(*(u32 *)&ecc[9]);
 				elm_write_reg(info, offset, val);
 
 				/* syndrome fragment 1 = ecc[5-8B] */
 				offset += 4;
-				val = cpu_to_be32(*(u32 *) &ecc[5]);
+				val = (__force u32)cpu_to_be32(*(u32 *)&ecc[5]);
 				elm_write_reg(info, offset, val);
 
 				/* syndrome fragment 2 = ecc[1-4B] */
 				offset += 4;
-				val = cpu_to_be32(*(u32 *) &ecc[1]);
+				val = (__force u32)cpu_to_be32(*(u32 *)&ecc[1]);
 				elm_write_reg(info, offset, val);
 
 				/* syndrome fragment 3 = ecc[0B] */
@@ -197,35 +197,35 @@ static void elm_load_syndrome(struct elm_info *info,
 				break;
 			case BCH4_ECC:
 				/* syndrome fragment 0 = ecc[20-52b] bits */
-				val = (cpu_to_be32(*(u32 *) &ecc[3]) >> 4) |
+				val = ((__force u32)cpu_to_be32(*(u32 *)&ecc[3]) >> 4) |
 					((ecc[2] & 0xf) << 28);
 				elm_write_reg(info, offset, val);
 
 				/* syndrome fragment 1 = ecc[0-20b] bits */
 				offset += 4;
-				val = cpu_to_be32(*(u32 *) &ecc[0]) >> 12;
+				val = (__force u32)cpu_to_be32(*(u32 *)&ecc[0]) >> 12;
 				elm_write_reg(info, offset, val);
 				break;
 			case BCH16_ECC:
-				val = cpu_to_be32(*(u32 *) &ecc[22]);
+				val = (__force u32)cpu_to_be32(*(u32 *)&ecc[22]);
 				elm_write_reg(info, offset, val);
 				offset += 4;
-				val = cpu_to_be32(*(u32 *) &ecc[18]);
+				val = (__force u32)cpu_to_be32(*(u32 *)&ecc[18]);
 				elm_write_reg(info, offset, val);
 				offset += 4;
-				val = cpu_to_be32(*(u32 *) &ecc[14]);
+				val = (__force u32)cpu_to_be32(*(u32 *)&ecc[14]);
 				elm_write_reg(info, offset, val);
 				offset += 4;
-				val = cpu_to_be32(*(u32 *) &ecc[10]);
+				val = (__force u32)cpu_to_be32(*(u32 *)&ecc[10]);
 				elm_write_reg(info, offset, val);
 				offset += 4;
-				val = cpu_to_be32(*(u32 *) &ecc[6]);
+				val = (__force u32)cpu_to_be32(*(u32 *)&ecc[6]);
 				elm_write_reg(info, offset, val);
 				offset += 4;
-				val = cpu_to_be32(*(u32 *) &ecc[2]);
+				val = (__force u32)cpu_to_be32(*(u32 *)&ecc[2]);
 				elm_write_reg(info, offset, val);
 				offset += 4;
-				val = cpu_to_be32(*(u32 *) &ecc[0]) >> 16;
+				val = (__force u32)cpu_to_be32(*(u32 *)&ecc[0]) >> 16;
 				elm_write_reg(info, offset, val);
 				break;
 			default:
-- 
2.34.1

