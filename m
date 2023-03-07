Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069456AF936
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 23:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjCGWrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 17:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjCGWrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 17:47:00 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3EB4993C8;
        Tue,  7 Mar 2023 14:46:49 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id E06927A02E3;
        Tue,  7 Mar 2023 23:46:47 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/32] pata_parport-bpck6: remove useless defines
Date:   Tue,  7 Mar 2023 23:45:56 +0100
Message-Id: <20230307224627.28011-2-linux@zary.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230307224627.28011-1-linux@zary.sk>
References: <20230307224627.28011-1-linux@zary.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Almost all the ATAPI_ defines are unused. Remove them and use
ATA_REG_DATA instead of ATAPI_DATA.

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/bpck6.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/ata/pata_parport/bpck6.c b/drivers/ata/pata_parport/bpck6.c
index 964bc688e280..842e8116b649 100644
--- a/drivers/ata/pata_parport/bpck6.c
+++ b/drivers/ata/pata_parport/bpck6.c
@@ -23,23 +23,6 @@
 
 #define PPCSTRUCT(pi) ((Interface *)(pi->private))
 
-/****************************************************************/
-/*
- ATAPI CDROM DRIVE REGISTERS
-*/
-#define ATAPI_DATA       0      /* data port                  */
-#define ATAPI_ERROR      1      /* error register (read)      */
-#define ATAPI_FEATURES   1      /* feature register (write)   */
-#define ATAPI_INT_REASON 2      /* interrupt reason register  */
-#define ATAPI_COUNT_LOW  4      /* byte count register (low)  */
-#define ATAPI_COUNT_HIGH 5      /* byte count register (high) */
-#define ATAPI_DRIVE_SEL  6      /* drive select register      */
-#define ATAPI_STATUS     7      /* status port (read)         */
-#define ATAPI_COMMAND    7      /* command port (write)       */
-#define ATAPI_ALT_STATUS 0x0e /* alternate status reg (read) */
-#define ATAPI_DEVICE_CONTROL 0x0e /* device control (write)   */
-/****************************************************************/
-
 static int bpck6_read_regr(struct pi_adapter *pi, int cont, int reg)
 {
 	unsigned int out;
@@ -64,12 +47,12 @@ static void bpck6_write_regr(struct pi_adapter *pi, int cont, int reg, int val)
 
 static void bpck6_write_block(struct pi_adapter *pi, char *buf, int len)
 {
-	ppc6_wr_port16_blk(PPCSTRUCT(pi),ATAPI_DATA,buf,(u32)len>>1); 
+	ppc6_wr_port16_blk(PPCSTRUCT(pi), ATA_REG_DATA, buf, (u32)len>>1);
 }
 
 static void bpck6_read_block(struct pi_adapter *pi, char *buf, int len)
 {
-	ppc6_rd_port16_blk(PPCSTRUCT(pi),ATAPI_DATA,buf,(u32)len>>1);
+	ppc6_rd_port16_blk(PPCSTRUCT(pi), ATA_REG_DATA, buf, (u32)len>>1);
 }
 
 static void bpck6_connect(struct pi_adapter *pi)
-- 
Ondrej Zary

