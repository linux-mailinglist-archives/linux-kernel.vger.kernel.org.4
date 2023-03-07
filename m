Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202536AF954
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 23:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjCGWrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 17:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjCGWrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 17:47:05 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4DB1459D9;
        Tue,  7 Mar 2023 14:47:01 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id ADFE17A06EC;
        Tue,  7 Mar 2023 23:46:48 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/32] pata_parport-bpck6: remove mode from struct ppc_storage
Date:   Tue,  7 Mar 2023 23:46:03 +0100
Message-Id: <20230307224627.28011-9-linux@zary.sk>
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

introduce mode_map[] that maps bpck6 modes to ppc6 modes and use it to
replace mode in ppc_storage

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/bpck6.c   | 22 +++++-----------------
 drivers/ata/pata_parport/ppc6lnx.c | 27 +++++++++++----------------
 2 files changed, 16 insertions(+), 33 deletions(-)

diff --git a/drivers/ata/pata_parport/bpck6.c b/drivers/ata/pata_parport/bpck6.c
index 176bf456c698..fe97d1dee51c 100644
--- a/drivers/ata/pata_parport/bpck6.c
+++ b/drivers/ata/pata_parport/bpck6.c
@@ -43,22 +43,8 @@ static void bpck6_read_block(struct pi_adapter *pi, char *buf, int len)
 
 static void bpck6_connect(struct pi_adapter *pi)
 {
-	struct ppc_storage *ppc = (void *)(pi->private);
 	dev_dbg(&pi->dev, "connect\n");
 
-	if(pi->mode >=2)
-  	{
-		ppc->mode = 4+pi->mode-2;
-	}
-	else if(pi->mode==1)
-	{
-		ppc->mode = 3;
-	}
-	else
-	{
-		ppc->mode = 1;
-	}
-
 	ppc6_open(pi);
 	ppc6_wr_extout(pi, 0x3);
 }
@@ -85,13 +71,13 @@ static int bpck6_test_port(struct pi_adapter *pi)   /* check for 8-bit port */
 
 static int bpck6_probe_unit(struct pi_adapter *pi)
 {
-	struct ppc_storage *ppc = (void *)(pi->private);
-	int out;
+	int out, saved_mode;
 
 	dev_dbg(&pi->dev, "PROBE UNIT %x on port:%x\n", pi->unit, pi->port);
 
+	saved_mode = pi->mode;
 	/*LOWER DOWN TO UNIDIRECTIONAL*/
-	ppc->mode = 1;
+	pi->mode = 0;
 
 	out = ppc6_open(pi);
 
@@ -101,11 +87,13 @@ static int bpck6_probe_unit(struct pi_adapter *pi)
  	{
 		ppc6_close(pi);
 		dev_dbg(&pi->dev, "leaving probe\n");
+		pi->mode = saved_mode;
                return(1);
 	}
   	else
   	{
 		dev_dbg(&pi->dev, "Failed open\n");
+		pi->mode = saved_mode;
     		return(0);
   	}
 }
diff --git a/drivers/ata/pata_parport/ppc6lnx.c b/drivers/ata/pata_parport/ppc6lnx.c
index 7ea8e8a31aeb..75f9748d8de5 100644
--- a/drivers/ata/pata_parport/ppc6lnx.c
+++ b/drivers/ata/pata_parport/ppc6lnx.c
@@ -65,14 +65,6 @@
 //***************************************************************************
 
 struct ppc_storage {
-	u8	mode;						// operating mode
-					// 0 = PPC Uni SW
-					// 1 = PPC Uni FW
-					// 2 = PPC Bi SW
-					// 3 = PPC Bi FW
-					// 4 = EPP Byte
-					// 5 = EPP Word
-					// 6 = EPP Dword
 	u8	ppc_flags;
 	u8	cur_ctrl;				// current control port contents
 };
@@ -115,6 +107,9 @@ static void ppc6_close(struct pi_adapter *pi);
 
 //***************************************************************************
 
+int mode_map[] = { PPCMODE_UNI_FW, PPCMODE_BI_FW, PPCMODE_EPP_BYTE,
+		   PPCMODE_EPP_WORD, PPCMODE_EPP_DWORD };
+
 static int ppc6_select(struct pi_adapter *pi)
 {
 	struct ppc_storage *ppc = (void *)(pi->private);
@@ -151,10 +146,10 @@ static int ppc6_select(struct pi_adapter *pi)
 
 	outb(ppc->cur_ctrl, pi->port + 2);
 
-	i = ppc->mode & 0x0C;
+	i = mode_map[pi->mode] & 0x0C;
 
 	if (i == 0)
-		i = (ppc->mode & 2) | 1;
+		i = (mode_map[pi->mode] & 2) | 1;
 
 	outb(i, pi->port);
 
@@ -205,7 +200,7 @@ static int ppc6_select(struct pi_adapter *pi)
 static void ppc6_deselect(struct pi_adapter *pi)
 {
 	struct ppc_storage *ppc = (void *)(pi->private);
-	if (ppc->mode & 4)	// EPP
+	if (mode_map[pi->mode] & 4)	// EPP
 		ppc->cur_ctrl |= port_init;
 	else								// PPC/ECP
 		ppc->cur_ctrl |= port_sel;
@@ -224,7 +219,7 @@ static void ppc6_deselect(struct pi_adapter *pi)
 static void ppc6_send_cmd(struct pi_adapter *pi, u8 cmd)
 {
 	struct ppc_storage *ppc = (void *)(pi->private);
-	switch(ppc->mode)
+	switch (mode_map[pi->mode])
 	{
 		case PPCMODE_UNI_SW :
 		case PPCMODE_UNI_FW :
@@ -256,7 +251,7 @@ static void ppc6_send_cmd(struct pi_adapter *pi, u8 cmd)
 static void ppc6_wr_data_byte(struct pi_adapter *pi, u8 data)
 {
 	struct ppc_storage *ppc = (void *)(pi->private);
-	switch(ppc->mode)
+	switch (mode_map[pi->mode])
 	{
 		case PPCMODE_UNI_SW :
 		case PPCMODE_UNI_FW :
@@ -290,7 +285,7 @@ static u8 ppc6_rd_data_byte(struct pi_adapter *pi)
 	struct ppc_storage *ppc = (void *)(pi->private);
 	u8 data = 0;
 
-	switch(ppc->mode)
+	switch (mode_map[pi->mode])
 	{
 		case PPCMODE_UNI_SW :
 		case PPCMODE_UNI_FW :
@@ -380,7 +375,7 @@ static void ppc6_wr_port(struct pi_adapter *pi, u8 port, u8 data)
 static void ppc6_rd_data_blk(struct pi_adapter *pi, u8 *data, long count)
 {
 	struct ppc_storage *ppc = (void *)(pi->private);
-	switch(ppc->mode)
+	switch (mode_map[pi->mode])
 	{
 		case PPCMODE_UNI_SW :
 		case PPCMODE_UNI_FW :
@@ -531,7 +526,7 @@ static void ppc6_wait_for_fifo(struct pi_adapter *pi)
 static void ppc6_wr_data_blk(struct pi_adapter *pi, u8 *data, long count)
 {
 	struct ppc_storage *ppc = (void *)(pi->private);
-	switch(ppc->mode)
+	switch (mode_map[pi->mode])
 	{
 		case PPCMODE_UNI_SW :
 		case PPCMODE_BI_SW :
-- 
Ondrej Zary

