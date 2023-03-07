Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C2D6AF995
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 23:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbjCGWt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 17:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbjCGWrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 17:47:33 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E6393867D3;
        Tue,  7 Mar 2023 14:47:08 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 425DB7A0750;
        Tue,  7 Mar 2023 23:46:50 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 23/32] pata_parport-bpck6: move ppc6_wr_extout to bpck6.c and rename
Date:   Tue,  7 Mar 2023 23:46:18 +0100
Message-Id: <20230307224627.28011-24-linux@zary.sk>
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

Move ppc6_wr_extout to bpck6.c and rename it to bpck6_wr_extout

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/bpck6.c   | 10 ++++++++--
 drivers/ata/pata_parport/ppc6lnx.c | 10 ----------
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/ata/pata_parport/bpck6.c b/drivers/ata/pata_parport/bpck6.c
index 1f976ee04ef2..968c9f3297e3 100644
--- a/drivers/ata/pata_parport/bpck6.c
+++ b/drivers/ata/pata_parport/bpck6.c
@@ -174,18 +174,24 @@ static void bpck6_read_block(struct pi_adapter *pi, char *buf, int len)
 	ppc6_send_cmd(pi, CMD_PREFIX_RESET | PREFIX_IO16 | PREFIX_BLK);
 }
 
+static void bpck6_wr_extout(struct pi_adapter *pi, u8 regdata)
+{
+	ppc6_send_cmd(pi, REG_VERSION | ACCESS_REG | ACCESS_WRITE);
+	ppc6_wr_data_byte(pi, (u8)((regdata & 0x03) << 6));
+}
+
 static void bpck6_connect(struct pi_adapter *pi)
 {
 	dev_dbg(&pi->dev, "connect\n");
 
 	ppc6_open(pi);
-	ppc6_wr_extout(pi, 0x3);
+	bpck6_wr_extout(pi, 0x3);
 }
 
 static void bpck6_disconnect(struct pi_adapter *pi)
 {
 	dev_dbg(&pi->dev, "disconnect\n");
-	ppc6_wr_extout(pi, 0x0);
+	bpck6_wr_extout(pi, 0x0);
 	ppc6_deselect(pi);
 }
 
diff --git a/drivers/ata/pata_parport/ppc6lnx.c b/drivers/ata/pata_parport/ppc6lnx.c
index cd4fa31a5ff8..931bf67fabb9 100644
--- a/drivers/ata/pata_parport/ppc6lnx.c
+++ b/drivers/ata/pata_parport/ppc6lnx.c
@@ -72,7 +72,6 @@ static void ppc6_deselect(struct pi_adapter *pi);
 static void ppc6_send_cmd(struct pi_adapter *pi, u8 cmd);
 static void ppc6_wr_data_byte(struct pi_adapter *pi, u8 data);
 static u8 ppc6_rd_data_byte(struct pi_adapter *pi);
-static void ppc6_wr_extout(struct pi_adapter *pi, u8 regdata);
 static int ppc6_open(struct pi_adapter *pi);
 
 //***************************************************************************
@@ -281,15 +280,6 @@ static u8 ppc6_rd_data_byte(struct pi_adapter *pi)
 
 //***************************************************************************
 
-static void ppc6_wr_extout(struct pi_adapter *pi, u8 regdata)
-{
-	ppc6_send_cmd(pi, REG_VERSION | ACCESS_REG | ACCESS_WRITE);
-
-	ppc6_wr_data_byte(pi, (u8)((regdata & 0x03) << 6));
-}
-
-//***************************************************************************
-
 static int ppc6_open(struct pi_adapter *pi)
 {
 	int ret;
-- 
Ondrej Zary

