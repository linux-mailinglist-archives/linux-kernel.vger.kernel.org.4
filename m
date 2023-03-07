Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E6F6AF962
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 23:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjCGWsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 17:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjCGWrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 17:47:10 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8CA5A838AD;
        Tue,  7 Mar 2023 14:47:04 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 834BD7A0728;
        Tue,  7 Mar 2023 23:46:49 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 16/32] pata_parport-bpck6: merge ppc6_rd_port into bpck6_read_regr
Date:   Tue,  7 Mar 2023 23:46:11 +0100
Message-Id: <20230307224627.28011-17-linux@zary.sk>
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

ppc6_rd_port is only called by bpck6_read_regr. Merge ppc6_rd_port
into bpck6_read_regr.

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/bpck6.c   |  5 ++++-
 drivers/ata/pata_parport/ppc6lnx.c | 10 ----------
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/ata/pata_parport/bpck6.c b/drivers/ata/pata_parport/bpck6.c
index b8135a6eed16..2918fc9e9def 100644
--- a/drivers/ata/pata_parport/bpck6.c
+++ b/drivers/ata/pata_parport/bpck6.c
@@ -21,7 +21,10 @@
 
 static int bpck6_read_regr(struct pi_adapter *pi, int cont, int reg)
 {
-	return ppc6_rd_port(pi, cont?reg|8:reg);
+	u8 port = cont ? reg | 8 : reg;
+
+	ppc6_send_cmd(pi, port | ACCESS_PORT | ACCESS_READ);
+	return ppc6_rd_data_byte(pi);
 }
 
 static void bpck6_write_regr(struct pi_adapter *pi, int cont, int reg, int val)
diff --git a/drivers/ata/pata_parport/ppc6lnx.c b/drivers/ata/pata_parport/ppc6lnx.c
index 5b7796083e7e..23dce177b722 100644
--- a/drivers/ata/pata_parport/ppc6lnx.c
+++ b/drivers/ata/pata_parport/ppc6lnx.c
@@ -72,7 +72,6 @@ static void ppc6_deselect(struct pi_adapter *pi);
 static void ppc6_send_cmd(struct pi_adapter *pi, u8 cmd);
 static void ppc6_wr_data_byte(struct pi_adapter *pi, u8 data);
 static u8 ppc6_rd_data_byte(struct pi_adapter *pi);
-static u8 ppc6_rd_port(struct pi_adapter *pi, u8 port);
 static void ppc6_wr_port(struct pi_adapter *pi, u8 port, u8 data);
 static void ppc6_rd_data_blk(struct pi_adapter *pi, u8 *data, long count);
 static void ppc6_wait_for_fifo(struct pi_adapter *pi);
@@ -288,15 +287,6 @@ static u8 ppc6_rd_data_byte(struct pi_adapter *pi)
 
 //***************************************************************************
 
-static u8 ppc6_rd_port(struct pi_adapter *pi, u8 port)
-{
-	ppc6_send_cmd(pi, port | ACCESS_PORT | ACCESS_READ);
-
-	return ppc6_rd_data_byte(pi);
-}
-
-//***************************************************************************
-
 static void ppc6_wr_port(struct pi_adapter *pi, u8 port, u8 data)
 {
 	ppc6_send_cmd(pi, port | ACCESS_PORT | ACCESS_WRITE);
-- 
Ondrej Zary

