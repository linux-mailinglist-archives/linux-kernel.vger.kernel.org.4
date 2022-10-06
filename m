Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEC35F633A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 11:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbiJFJEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 05:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbiJFJEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 05:04:31 -0400
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7641297ECE
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 02:04:29 -0700 (PDT)
Received: from ([60.208.111.195])
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id BLL00125;
        Thu, 06 Oct 2022 17:04:25 +0800
Received: from localhost.localdomain (10.200.104.82) by
 jtjnmail201603.home.langchao.com (10.100.2.3) with Microsoft SMTP Server id
 15.1.2507.12; Thu, 6 Oct 2022 17:04:25 +0800
From:   Deming Wang <wangdeming@inspur.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Deming Wang <wangdeming@inspur.com>
Subject: [PATCH] mtd: Delete commented printk and add some space for required
Date:   Thu, 6 Oct 2022 05:04:19 -0400
Message-ID: <20221006090419.1635-1-wangdeming@inspur.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.200.104.82]
tUid:   202210061704258abef967f8c5459d926e3c657d2d60e7
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete commented printk for NFTL_findwriteunit and

NFTL_makefreeblock. Add required space for the variable blockofs

Signed-off-by: Deming Wang <wangdeming@inspur.com>
---
 drivers/mtd/nftlcore.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/mtd/nftlcore.c b/drivers/mtd/nftlcore.c
index 64d319e959b2..e3c17ed4c219 100644
--- a/drivers/mtd/nftlcore.c
+++ b/drivers/mtd/nftlcore.c
@@ -486,7 +486,6 @@ static u16 NFTL_makefreeblock( struct NFTLrecord *nftl , unsigned pendingblock)
 
 		while (EUN <= nftl->lastEUN) {
 			thislen++;
-			//printk("VUC %d reaches len %d with EUN %d\n", chain, thislen, EUN);
 			EUN = nftl->ReplUnitTable[EUN] & 0x7fff;
 			if (thislen > 0xff00) {
 				printk("Endless loop in Virtual Chain %d: Unit %x\n",
@@ -501,7 +500,6 @@ static u16 NFTL_makefreeblock( struct NFTLrecord *nftl , unsigned pendingblock)
 		}
 
 		if (thislen > ChainLength) {
-			//printk("New longest chain is %d with length %d\n", chain, thislen);
 			ChainLength = thislen;
 			LongestChain = chain;
 		}
@@ -525,7 +523,7 @@ static inline u16 NFTL_findwriteunit(struct NFTLrecord *nftl, unsigned block)
 	u16 thisVUC = block / (nftl->EraseSize / 512);
 	struct mtd_info *mtd = nftl->mbd.mtd;
 	unsigned int writeEUN;
-	unsigned long blockofs = (block * 512) & (nftl->EraseSize -1);
+	unsigned long blockofs = (block * 512) & (nftl->EraseSize - 1);
 	size_t retlen;
 	int silly, silly2 = 3;
 	struct nftl_oob oob;
@@ -592,10 +590,6 @@ static inline u16 NFTL_findwriteunit(struct NFTLrecord *nftl, unsigned block)
 			   a chain to make room.
 			*/
 
-			/* First remember the start of this chain */
-			//u16 startEUN = nftl->EUNtable[thisVUC];
-
-			//printk("Write to VirtualUnitChain %d, calling makefreeblock()\n", thisVUC);
 			writeEUN = NFTL_makefreeblock(nftl, BLOCK_NIL);
 
 			if (writeEUN == BLOCK_NIL) {
@@ -618,7 +612,6 @@ static inline u16 NFTL_findwriteunit(struct NFTLrecord *nftl, unsigned block)
 				printk(KERN_WARNING "Cannot make free space.\n");
 				return BLOCK_NIL;
 			}
-			//printk("Restarting scan\n");
 			continue;
 		}
 
-- 
2.27.0

