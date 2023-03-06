Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5C06ACBA1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 18:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjCFR4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 12:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjCFRzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 12:55:48 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 268503B208;
        Mon,  6 Mar 2023 09:55:20 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 969477A0709;
        Mon,  6 Mar 2023 18:28:29 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/18] pata_parport: simplify log_adapter prints, remove VERSION defines
Date:   Mon,  6 Mar 2023 18:27:47 +0100
Message-Id: <20230306172752.7727-14-linux@zary.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230306172752.7727-1-linux@zary.sk>
References: <20230306172752.7727-1-linux@zary.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merge log_adapter prints to single one, remove version print and
meaningless VERSION defines.

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/aten.c  |  8 ++------
 drivers/ata/pata_parport/bpck.c  |  9 +++------
 drivers/ata/pata_parport/bpck6.c |  9 ++-------
 drivers/ata/pata_parport/comm.c  |  8 ++------
 drivers/ata/pata_parport/dstr.c  |  8 ++------
 drivers/ata/pata_parport/epat.c  |  9 ++-------
 drivers/ata/pata_parport/epia.c  |  8 ++------
 drivers/ata/pata_parport/fit2.c  |  6 ++----
 drivers/ata/pata_parport/fit3.c  |  9 ++-------
 drivers/ata/pata_parport/friq.c  |  8 ++------
 drivers/ata/pata_parport/frpw.c  | 10 +++-------
 drivers/ata/pata_parport/kbic.c  |  8 ++------
 drivers/ata/pata_parport/ktti.c  |  7 ++-----
 drivers/ata/pata_parport/on20.c  |  8 ++------
 drivers/ata/pata_parport/on26.c  |  8 ++------
 15 files changed, 32 insertions(+), 91 deletions(-)

diff --git a/drivers/ata/pata_parport/aten.c b/drivers/ata/pata_parport/aten.c
index ccbba14ccab1..8995a4a08b76 100644
--- a/drivers/ata/pata_parport/aten.c
+++ b/drivers/ata/pata_parport/aten.c
@@ -15,8 +15,6 @@
 
 */
 
-#define ATEN_VERSION      "1.01"
-
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/delay.h>
@@ -124,10 +122,8 @@ static void aten_log_adapter(struct pi_adapter *pi)
 
 {       char    *mode_string[2] = {"4-bit","8-bit"};
 
-	dev_info(&pi->dev, "aten %s, ATEN EH-100 at 0x%x, ", ATEN_VERSION, pi->port);
-	dev_info(&pi->dev, "mode %d (%s), delay %d\n", pi->mode,
-		mode_string[pi->mode],pi->delay);
-
+	dev_info(&pi->dev, "ATEN EH-100 at 0x%x, mode %d (%s), delay %d\n",
+		pi->port, pi->mode, mode_string[pi->mode], pi->delay);
 }
 
 static struct pi_protocol aten = {
diff --git a/drivers/ata/pata_parport/bpck.c b/drivers/ata/pata_parport/bpck.c
index dec24983d140..793ef2c7849e 100644
--- a/drivers/ata/pata_parport/bpck.c
+++ b/drivers/ata/pata_parport/bpck.c
@@ -14,8 +14,6 @@
 
 */
 
-#define	BPCK_VERSION	"1.02" 
-
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/delay.h>
@@ -421,10 +419,9 @@ static void bpck_log_adapter(struct pi_adapter *pi)
 
 	bpck_read_eeprom(pi,scratch);
 	print_hex_dump_bytes("bpck EEPROM: ", DUMP_PREFIX_NONE, scratch, 128);
-	dev_info(&pi->dev, "bpck %s, backpack %8.8s unit %d",
-		BPCK_VERSION, &scratch[110], pi->unit);
-	dev_info(&pi->dev, " at 0x%x, mode %d (%s), delay %d\n", pi->port,
-		pi->mode,mode_string[pi->mode],pi->delay);
+	dev_info(&pi->dev, "backpack %8.8s unit %d at 0x%x, mode %d (%s), delay %d\n",
+		 &scratch[110], pi->unit, pi->port, pi->mode,
+		 mode_string[pi->mode], pi->delay);
 }
 
 static struct pi_protocol bpck = {
diff --git a/drivers/ata/pata_parport/bpck6.c b/drivers/ata/pata_parport/bpck6.c
index 4770e29bfdeb..f144e1b3cacb 100644
--- a/drivers/ata/pata_parport/bpck6.c
+++ b/drivers/ata/pata_parport/bpck6.c
@@ -19,9 +19,6 @@
    Version 2.0.2 - fixed version string usage, and made ppc functions static 
 */
 
-
-#define BACKPACK_VERSION "2.0.2"
-
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -179,10 +176,8 @@ static void bpck6_log_adapter(struct pi_adapter *pi)
 	char *mode_string[5]=
 		{"4-bit","8-bit","EPP-8","EPP-16","EPP-32"};
 
-	dev_info(&pi->dev, "BACKPACK %s, Micro Solutions BACKPACK Drive at 0x%x\n",
-		BACKPACK_VERSION, pi->port);
-	dev_info(&pi->dev, "Unit: %d Mode:%d (%s) Delay %d\n",
-		pi->unit,pi->mode,mode_string[pi->mode],pi->delay);
+	dev_info(&pi->dev, "Micro Solutions BACKPACK Drive unit %d at 0x%x, mode:%d (%s), delay %d\n",
+		pi->unit, pi->port, pi->mode, mode_string[pi->mode], pi->delay);
 }
 
 static int bpck6_init_proto(struct pi_adapter *pi)
diff --git a/drivers/ata/pata_parport/comm.c b/drivers/ata/pata_parport/comm.c
index 7b59eca52185..6e05b50c322c 100644
--- a/drivers/ata/pata_parport/comm.c
+++ b/drivers/ata/pata_parport/comm.c
@@ -14,8 +14,6 @@
 
 */
 
-#define COMM_VERSION      "1.01"
-
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/delay.h>
@@ -183,10 +181,8 @@ static void comm_log_adapter(struct pi_adapter *pi)
 
 {       char    *mode_string[5] = {"4-bit","8-bit","EPP-8","EPP-16","EPP-32"};
 
-	dev_info(&pi->dev, "comm %s, DataStor Commuter at 0x%x, ", COMM_VERSION, pi->port);
-	dev_info(&pi->dev, "mode %d (%s), delay %d\n", pi->mode,
-		mode_string[pi->mode],pi->delay);
-
+	dev_info(&pi->dev, "DataStor Commuter at 0x%x, mode %d (%s), delay %d\n",
+		pi->port, pi->mode, mode_string[pi->mode], pi->delay);
 }
 
 static struct pi_protocol comm = {
diff --git a/drivers/ata/pata_parport/dstr.c b/drivers/ata/pata_parport/dstr.c
index eb6ddceaeb83..64e45eed9588 100644
--- a/drivers/ata/pata_parport/dstr.c
+++ b/drivers/ata/pata_parport/dstr.c
@@ -13,8 +13,6 @@
 
 */
 
-#define DSTR_VERSION      "1.01"
-
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/delay.h>
@@ -195,10 +193,8 @@ static void dstr_log_adapter(struct pi_adapter *pi)
 {       char    *mode_string[5] = {"4-bit","8-bit","EPP-8",
 				   "EPP-16","EPP-32"};
 
-	dev_info(&pi->dev, "dstr %s, DataStor EP2000 at 0x%x, ", DSTR_VERSION, pi->port);
-	dev_info(&pi->dev, "mode %d (%s), delay %d\n", pi->mode,
-		mode_string[pi->mode],pi->delay);
-
+	dev_info(&pi->dev, "DataStor EP2000 at 0x%x, mode %d (%s), delay %d\n",
+		pi->port, pi->mode, mode_string[pi->mode], pi->delay);
 }
 
 static struct pi_protocol dstr = {
diff --git a/drivers/ata/pata_parport/epat.c b/drivers/ata/pata_parport/epat.c
index 389faa6ae49d..12dd53a06dd0 100644
--- a/drivers/ata/pata_parport/epat.c
+++ b/drivers/ata/pata_parport/epat.c
@@ -16,8 +16,6 @@
 
 */
 
-#define EPAT_VERSION      "1.02"
-
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/delay.h>
@@ -296,11 +294,8 @@ static void epat_log_adapter(struct pi_adapter *pi)
         ver = RR(0xb);
         epat_disconnect(pi);
 
-	dev_info(&pi->dev, "epat %s, Shuttle EPAT chip %x at 0x%x, ",
-		EPAT_VERSION, ver, pi->port);
-	dev_info(&pi->dev, "mode %d (%s), delay %d\n", pi->mode,
-		mode_string[pi->mode],pi->delay);
-
+	dev_info(&pi->dev, "Shuttle EPAT chip %x at 0x%x, mode %d (%s), delay %d\n",
+		 ver, pi->port, pi->mode, mode_string[pi->mode], pi->delay);
 }
 
 static struct pi_protocol epat = {
diff --git a/drivers/ata/pata_parport/epia.c b/drivers/ata/pata_parport/epia.c
index 48d12f56c501..1216763d0c6d 100644
--- a/drivers/ata/pata_parport/epia.c
+++ b/drivers/ata/pata_parport/epia.c
@@ -17,8 +17,6 @@
 
 */
 
-#define EPIA_VERSION      "1.02"
-
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/delay.h>
@@ -275,10 +273,8 @@ static void epia_log_adapter(struct pi_adapter *pi)
 {       char    *mode_string[6] = {"4-bit","5/3","8-bit",
 				   "EPP-8","EPP-16","EPP-32"};
 
-	dev_info(&pi->dev, "epia %s, Shuttle EPIA at 0x%x, ", EPIA_VERSION, pi->port);
-	dev_info(&pi->dev, "mode %d (%s), delay %d\n", pi->mode,
-		mode_string[pi->mode],pi->delay);
-
+	dev_info(&pi->dev, "Shuttle EPIA at 0x%x, mode %d (%s), delay %d\n",
+		pi->port, pi->mode, mode_string[pi->mode], pi->delay);
 }
 
 static struct pi_protocol epia = {
diff --git a/drivers/ata/pata_parport/fit2.c b/drivers/ata/pata_parport/fit2.c
index d0a781f04411..3536d8c07955 100644
--- a/drivers/ata/pata_parport/fit2.c
+++ b/drivers/ata/pata_parport/fit2.c
@@ -13,8 +13,6 @@
 
 */
 
-#define FIT2_VERSION      "1.0"
-
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/delay.h>
@@ -116,8 +114,8 @@ static void fit2_disconnect(struct pi_adapter *pi)
 static void fit2_log_adapter(struct pi_adapter *pi)
 
 {
-	dev_info(&pi->dev, "fit2 %s, FIT 2000 adapter at 0x%x, delay %d\n",
-		FIT2_VERSION, pi->port, pi->delay);
+	dev_info(&pi->dev, "FIT 2000 adapter at 0x%x, delay %d\n",
+		pi->port, pi->delay);
 
 }
 
diff --git a/drivers/ata/pata_parport/fit3.c b/drivers/ata/pata_parport/fit3.c
index f86da2d478cb..9f5320c750e2 100644
--- a/drivers/ata/pata_parport/fit3.c
+++ b/drivers/ata/pata_parport/fit3.c
@@ -17,8 +17,6 @@
 
 */
 
-#define FIT3_VERSION      "1.0"
-
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/delay.h>
@@ -173,11 +171,8 @@ static void fit3_log_adapter(struct pi_adapter *pi)
 
 {       char    *mode_string[3] = {"4-bit","8-bit","EPP"};
 
-	dev_info(&pi->dev, "fit3 %s, FIT 3000 adapter at 0x%x, "
-	       "mode %d (%s), delay %d\n",
-		FIT3_VERSION, pi->port,
-		pi->mode,mode_string[pi->mode],pi->delay);
-
+	dev_info(&pi->dev, "FIT 3000 adapter at 0x%x, mode %d (%s), delay %d\n",
+		pi->port, pi->mode, mode_string[pi->mode], pi->delay);
 }
 
 static struct pi_protocol fit3 = {
diff --git a/drivers/ata/pata_parport/friq.c b/drivers/ata/pata_parport/friq.c
index ec564e7cb930..ed05e6503147 100644
--- a/drivers/ata/pata_parport/friq.c
+++ b/drivers/ata/pata_parport/friq.c
@@ -25,8 +25,6 @@
 	1.01	GRG 1998.12.20	 Added support for soft power switch
 */
 
-#define	FRIQ_VERSION	"1.01" 
-
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/delay.h>
@@ -219,10 +217,8 @@ static void friq_log_adapter(struct pi_adapter *pi)
 {       char    *mode_string[6] = {"4-bit","8-bit",
 				   "EPP-8","EPP-16","EPP-32"};
 
-	dev_info(&pi->dev, "friq %s, Freecom IQ ASIC-2 adapter at 0x%x, ",
-		FRIQ_VERSION,pi->port);
-	dev_info(&pi->dev, "mode %d (%s), delay %d\n", pi->mode,
-		mode_string[pi->mode],pi->delay);
+	dev_info(&pi->dev, "Freecom IQ ASIC-2 adapter at 0x%x, mode %d (%s), delay %d\n",
+		pi->port, pi->mode, mode_string[pi->mode], pi->delay);
 
 	pi->private = 1;
 	friq_connect(pi);
diff --git a/drivers/ata/pata_parport/frpw.c b/drivers/ata/pata_parport/frpw.c
index 5ea16a247257..c0d50e2ed57d 100644
--- a/drivers/ata/pata_parport/frpw.c
+++ b/drivers/ata/pata_parport/frpw.c
@@ -23,8 +23,6 @@
 
 */
 
-#define	FRPW_VERSION	"1.03" 
-
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/delay.h>
@@ -268,11 +266,9 @@ static void frpw_log_adapter(struct pi_adapter *pi)
 {       char    *mode_string[6] = {"4-bit","8-bit","EPP",
 				   "EPP-8","EPP-16","EPP-32"};
 
-	dev_info(&pi->dev, "frpw %s, Freecom (%s) adapter at 0x%x, ",
-		FRPW_VERSION,((pi->private%2) == 0)?"Xilinx":"ASIC",pi->port);
-	dev_info(&pi->dev, "mode %d (%s), delay %d\n", pi->mode,
-		mode_string[pi->mode],pi->delay);
-
+	dev_info(&pi->dev, "Freecom (%s) adapter at 0x%x, mode %d (%s), delay %d\n",
+		((pi->private % 2) == 0) ? "Xilinx" : "ASIC",
+		pi->port, pi->mode, mode_string[pi->mode], pi->delay);
 }
 
 static struct pi_protocol frpw = {
diff --git a/drivers/ata/pata_parport/kbic.c b/drivers/ata/pata_parport/kbic.c
index ea1b931ce20d..3fab7a896e79 100644
--- a/drivers/ata/pata_parport/kbic.c
+++ b/drivers/ata/pata_parport/kbic.c
@@ -18,8 +18,6 @@
 
 */
 
-#define KBIC_VERSION      "1.01"
-
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/delay.h>
@@ -234,10 +232,8 @@ static void kbic_log_adapter(struct pi_adapter *pi, char *chip)
 {       char    *mode_string[6] = {"4-bit","5/3","8-bit",
 				   "EPP-8","EPP_16","EPP-32"};
 
-	dev_info(&pi->dev, "kbic %s, KingByte %s at 0x%x, ", KBIC_VERSION, chip, pi->port);
-	dev_info(&pi->dev, "mode %d (%s), delay %d\n", pi->mode,
-		mode_string[pi->mode],pi->delay);
-
+	dev_info(&pi->dev, "KingByte %s at 0x%x, mode %d (%s), delay %d\n",
+		 chip, pi->port, pi->mode, mode_string[pi->mode], pi->delay);
 }
 
 static void k951_log_adapter(struct pi_adapter *pi)
diff --git a/drivers/ata/pata_parport/ktti.c b/drivers/ata/pata_parport/ktti.c
index b22c283709de..742051f6ea10 100644
--- a/drivers/ata/pata_parport/ktti.c
+++ b/drivers/ata/pata_parport/ktti.c
@@ -9,8 +9,6 @@
 
 */
 
-#define KTTI_VERSION      "1.0"
-
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/delay.h>
@@ -93,9 +91,8 @@ static void ktti_disconnect(struct pi_adapter *pi)
 static void ktti_log_adapter(struct pi_adapter *pi)
 
 {
-	dev_info(&pi->dev, "ktti %s, KT adapter at 0x%x, delay %d\n",
-		KTTI_VERSION, pi->port, pi->delay);
-
+	dev_info(&pi->dev, "KT adapter at 0x%x, delay %d\n",
+		pi->port, pi->delay);
 }
 
 static struct pi_protocol ktti = {
diff --git a/drivers/ata/pata_parport/on20.c b/drivers/ata/pata_parport/on20.c
index c76d4fb84c61..9cc8be9fa562 100644
--- a/drivers/ata/pata_parport/on20.c
+++ b/drivers/ata/pata_parport/on20.c
@@ -12,8 +12,6 @@
 
 */
 
-#define	ON20_VERSION	"1.01"
-
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/delay.h>
@@ -115,10 +113,8 @@ static void on20_log_adapter(struct pi_adapter *pi)
 
 {       char    *mode_string[2] = {"4-bit","8-bit"};
 
-	dev_info(&pi->dev, "on20 %s, OnSpec 90c20 at 0x%x, ", ON20_VERSION, pi->port);
-	dev_info(&pi->dev, "mode %d (%s), delay %d\n", pi->mode,
-		mode_string[pi->mode],pi->delay);
-
+	dev_info(&pi->dev, "OnSpec 90c20 at 0x%x, mode %d (%s), delay %d\n",
+		pi->port, pi->mode, mode_string[pi->mode], pi->delay);
 }
 
 static struct pi_protocol on20 = {
diff --git a/drivers/ata/pata_parport/on26.c b/drivers/ata/pata_parport/on26.c
index 5406e76ea727..e37f69db5f76 100644
--- a/drivers/ata/pata_parport/on26.c
+++ b/drivers/ata/pata_parport/on26.c
@@ -16,8 +16,6 @@
 
 */
 
-#define ON26_VERSION      "1.04"
-
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/delay.h>
@@ -280,10 +278,8 @@ static void on26_log_adapter(struct pi_adapter *pi)
 {       char    *mode_string[5] = {"4-bit","8-bit","EPP-8",
 				   "EPP-16","EPP-32"};
 
-	dev_info(&pi->dev, "on26 %s, OnSpec 90c26 at 0x%x, ", ON26_VERSION, pi->port);
-	dev_info(&pi->dev, "mode %d (%s), delay %d\n", pi->mode,
-		mode_string[pi->mode],pi->delay);
-
+	dev_info(&pi->dev, "OnSpec 90c26 at 0x%x, mode %d (%s), delay %d\n",
+		pi->port, pi->mode, mode_string[pi->mode], pi->delay);
 }
 
 static struct pi_protocol on26 = {
-- 
Ondrej Zary

