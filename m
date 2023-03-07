Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5336AF96A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 23:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjCGWsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 17:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjCGWrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 17:47:21 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E73FC9DE1A;
        Tue,  7 Mar 2023 14:47:07 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id E109A7A0741;
        Tue,  7 Mar 2023 23:46:49 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 19/32] pata_parport-bpck6: merge ppc6_wr_port16_blk into bpck6_write_block
Date:   Tue,  7 Mar 2023 23:46:14 +0100
Message-Id: <20230307224627.28011-20-linux@zary.sk>
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

ppc6_wr_port16_blk is only called by bpck6_write_block. Merge
ppc6_wr_port16_blk into bpck6_write_block.

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/bpck6.c   | 10 +++++++++-
 drivers/ata/pata_parport/ppc6lnx.c | 21 ---------------------
 2 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/drivers/ata/pata_parport/bpck6.c b/drivers/ata/pata_parport/bpck6.c
index aaf6737891a5..1c04fcaba74a 100644
--- a/drivers/ata/pata_parport/bpck6.c
+++ b/drivers/ata/pata_parport/bpck6.c
@@ -37,7 +37,15 @@ static void bpck6_write_regr(struct pi_adapter *pi, int cont, int reg, int val)
 
 static void bpck6_write_block(struct pi_adapter *pi, char *buf, int len)
 {
-	ppc6_wr_port16_blk(pi, ATA_REG_DATA, buf, (u32)len>>1);
+	ppc6_send_cmd(pi, REG_BLKSIZE | ACCESS_REG | ACCESS_WRITE);
+	ppc6_wr_data_byte(pi, (u8)len);
+	ppc6_wr_data_byte(pi, (u8)(len >> 8));
+	ppc6_wr_data_byte(pi, 0);
+
+	ppc6_send_cmd(pi, CMD_PREFIX_SET | PREFIX_IO16 | PREFIX_BLK);
+	ppc6_send_cmd(pi, ATA_REG_DATA | ACCESS_PORT | ACCESS_WRITE);
+	ppc6_wr_data_blk(pi, buf, len);
+	ppc6_send_cmd(pi, CMD_PREFIX_RESET | PREFIX_IO16 | PREFIX_BLK);
 }
 
 static void bpck6_read_block(struct pi_adapter *pi, char *buf, int len)
diff --git a/drivers/ata/pata_parport/ppc6lnx.c b/drivers/ata/pata_parport/ppc6lnx.c
index ac336ce1695b..d275de3f1ead 100644
--- a/drivers/ata/pata_parport/ppc6lnx.c
+++ b/drivers/ata/pata_parport/ppc6lnx.c
@@ -75,7 +75,6 @@ static u8 ppc6_rd_data_byte(struct pi_adapter *pi);
 static void ppc6_rd_data_blk(struct pi_adapter *pi, u8 *data, long count);
 static void ppc6_wait_for_fifo(struct pi_adapter *pi);
 static void ppc6_wr_data_blk(struct pi_adapter *pi, u8 *data, long count);
-static void ppc6_wr_port16_blk(struct pi_adapter *pi, u8 port, u8 *data, long length);
 static void ppc6_wr_extout(struct pi_adapter *pi, u8 regdata);
 static int ppc6_open(struct pi_adapter *pi);
 
@@ -478,26 +477,6 @@ static void ppc6_wr_data_blk(struct pi_adapter *pi, u8 *data, long count)
 
 //***************************************************************************
 
-static void ppc6_wr_port16_blk(struct pi_adapter *pi, u8 port, u8 *data, long length)
-{
-	length = length << 1;
-
-	ppc6_send_cmd(pi, REG_BLKSIZE | ACCESS_REG | ACCESS_WRITE);
-	ppc6_wr_data_byte(pi, (u8)length);
-	ppc6_wr_data_byte(pi, (u8)(length >> 8));
-	ppc6_wr_data_byte(pi, 0);
-
-	ppc6_send_cmd(pi, CMD_PREFIX_SET | PREFIX_IO16 | PREFIX_BLK);
-
-	ppc6_send_cmd(pi, port | ACCESS_PORT | ACCESS_WRITE);
-
-	ppc6_wr_data_blk(pi, data, length);
-
-	ppc6_send_cmd(pi, CMD_PREFIX_RESET | PREFIX_IO16 | PREFIX_BLK);
-}
-
-//***************************************************************************
-
 static void ppc6_wr_extout(struct pi_adapter *pi, u8 regdata)
 {
 	ppc6_send_cmd(pi, REG_VERSION | ACCESS_REG | ACCESS_WRITE);
-- 
Ondrej Zary

