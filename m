Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1EC6AF989
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 23:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbjCGWtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 17:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbjCGWrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 17:47:45 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E7188C502;
        Tue,  7 Mar 2023 14:47:09 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id E31577A0779;
        Tue,  7 Mar 2023 23:46:50 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 30/32] pata_parport-bpck6: move defines and mode_map to bpck6.c
Date:   Tue,  7 Mar 2023 23:46:25 +0100
Message-Id: <20230307224627.28011-31-linux@zary.sk>
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

Move all register definitions and mode_map to bpck6.c

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/bpck6.c   | 44 ++++++++++++++++++++++++
 drivers/ata/pata_parport/ppc6lnx.c | 54 ------------------------------
 2 files changed, 44 insertions(+), 54 deletions(-)

diff --git a/drivers/ata/pata_parport/bpck6.c b/drivers/ata/pata_parport/bpck6.c
index f6d0916577b3..0ed6a97ab04f 100644
--- a/drivers/ata/pata_parport/bpck6.c
+++ b/drivers/ata/pata_parport/bpck6.c
@@ -19,6 +19,50 @@
 #include "pata_parport.h"
 #include "ppc6lnx.c"
 
+/* 60772 Commands */
+#define ACCESS_REG		0x00
+#define ACCESS_PORT		0x40
+
+#define ACCESS_READ		0x00
+#define ACCESS_WRITE		0x20
+
+/* 60772 Command Prefix */
+#define CMD_PREFIX_SET		0xe0	// Special command that modifies next command's operation
+#define CMD_PREFIX_RESET	0xc0	// Resets current cmd modifier reg bits
+ #define PREFIX_IO16		0x01	// perform 16-bit wide I/O
+ #define PREFIX_FASTWR		0x04	// enable PPC mode fast-write
+ #define PREFIX_BLK		0x08	// enable block transfer mode
+
+/* 60772 Registers */
+#define REG_STATUS		0x00	// status register
+ #define STATUS_IRQA		0x01	// Peripheral IRQA line
+ #define STATUS_EEPROM_DO	0x40	// Serial EEPROM data bit
+#define REG_VERSION		0x01	// PPC version register (read)
+#define REG_HWCFG		0x02	// Hardware Config register
+#define REG_RAMSIZE		0x03	// Size of RAM Buffer
+ #define RAMSIZE_128K		0x02
+#define REG_EEPROM		0x06	// EEPROM control register
+ #define EEPROM_SK		0x01	// eeprom SK bit
+ #define EEPROM_DI		0x02	// eeprom DI bit
+ #define EEPROM_CS		0x04	// eeprom CS bit
+ #define EEPROM_EN		0x08	// eeprom output enable
+#define REG_BLKSIZE		0x08	// Block transfer len (24 bit)
+
+/* flags */
+#define fifo_wait		0x10
+
+/* DONT CHANGE THESE LEST YOU BREAK EVERYTHING - BIT FIELD DEPENDENCIES */
+#define PPCMODE_UNI_SW		0
+#define PPCMODE_UNI_FW		1
+#define PPCMODE_BI_SW		2
+#define PPCMODE_BI_FW		3
+#define PPCMODE_EPP_BYTE	4
+#define PPCMODE_EPP_WORD	5
+#define PPCMODE_EPP_DWORD	6
+
+int mode_map[] = { PPCMODE_UNI_FW, PPCMODE_BI_FW, PPCMODE_EPP_BYTE,
+		   PPCMODE_EPP_WORD, PPCMODE_EPP_DWORD };
+
 static void bpck6_send_cmd(struct pi_adapter *pi, u8 cmd)
 {
 	switch (mode_map[pi->mode]) {
diff --git a/drivers/ata/pata_parport/ppc6lnx.c b/drivers/ata/pata_parport/ppc6lnx.c
index 9a763cbda130..e72b1842adda 100644
--- a/drivers/ata/pata_parport/ppc6lnx.c
+++ b/drivers/ata/pata_parport/ppc6lnx.c
@@ -15,57 +15,3 @@
 
 //***************************************************************************
 
-//  60772 Commands
-
-#define ACCESS_REG				0x00
-#define ACCESS_PORT				0x40
-
-#define ACCESS_READ				0x00
-#define ACCESS_WRITE			0x20
-
-//  60772 Command Prefix
-
-#define CMD_PREFIX_SET		0xe0		// Special command that modifies the next command's operation
-#define CMD_PREFIX_RESET	0xc0		// Resets current cmd modifier reg bits
- #define PREFIX_IO16			0x01		// perform 16-bit wide I/O
- #define PREFIX_FASTWR		0x04		// enable PPC mode fast-write
- #define PREFIX_BLK				0x08		// enable block transfer mode
-
-// 60772 Registers
-
-#define REG_STATUS				0x00		// status register
- #define STATUS_IRQA			0x01		// Peripheral IRQA line
- #define STATUS_EEPROM_DO	0x40		// Serial EEPROM data bit
-#define REG_VERSION				0x01		// PPC version register (read)
-#define REG_HWCFG					0x02		// Hardware Config register
-#define REG_RAMSIZE				0x03		// Size of RAM Buffer
- #define RAMSIZE_128K			0x02
-#define REG_EEPROM				0x06		// EEPROM control register
- #define EEPROM_SK				0x01		// eeprom SK bit
- #define EEPROM_DI				0x02		// eeprom DI bit
- #define EEPROM_CS				0x04		// eeprom CS bit
- #define EEPROM_EN				0x08		// eeprom output enable
-#define REG_BLKSIZE				0x08		// Block transfer len (24 bit)
-
-//***************************************************************************
-
-// ppc_flags
-
-#define fifo_wait					0x10
-
-//***************************************************************************
-
-// DONT CHANGE THESE LEST YOU BREAK EVERYTHING - BIT FIELD DEPENDENCIES
-
-#define PPCMODE_UNI_SW		0
-#define PPCMODE_UNI_FW		1
-#define PPCMODE_BI_SW			2
-#define PPCMODE_BI_FW			3
-#define PPCMODE_EPP_BYTE	4
-#define PPCMODE_EPP_WORD	5
-#define PPCMODE_EPP_DWORD	6
-
-//***************************************************************************
-
-int mode_map[] = { PPCMODE_UNI_FW, PPCMODE_BI_FW, PPCMODE_EPP_BYTE,
-		   PPCMODE_EPP_WORD, PPCMODE_EPP_DWORD };
-- 
Ondrej Zary

