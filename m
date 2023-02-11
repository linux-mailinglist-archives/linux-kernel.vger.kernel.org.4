Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8536931BC
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 15:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjBKOnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 09:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjBKOm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 09:42:59 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 647912A9AF;
        Sat, 11 Feb 2023 06:42:53 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id E4C077A06EC;
        Sat, 11 Feb 2023 15:42:49 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/12] pata_parport: use dev_* and print_hex_* instead of printk
Date:   Sat, 11 Feb 2023 15:42:28 +0100
Message-Id: <20230211144232.15138-9-linux@zary.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230211144232.15138-1-linux@zary.sk>
References: <20230211144232.15138-1-linux@zary.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dev_info/dev_err/dev_dbg/print_hex_* instead of printk.
Remove version print from log_adapter and meaningless VERSION defines.
Remove now useless verbose parameter of bpck6 module.

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/aten.c  |  8 ++---
 drivers/ata/pata_parport/bpck.c  | 31 ++++--------------
 drivers/ata/pata_parport/bpck6.c | 56 +++++++-------------------------
 drivers/ata/pata_parport/comm.c  |  8 ++---
 drivers/ata/pata_parport/dstr.c  |  8 ++---
 drivers/ata/pata_parport/epat.c  | 15 +++------
 drivers/ata/pata_parport/epia.c  | 14 +++-----
 drivers/ata/pata_parport/fit2.c  |  6 ++--
 drivers/ata/pata_parport/fit3.c  |  9 ++---
 drivers/ata/pata_parport/friq.c  | 14 +++-----
 drivers/ata/pata_parport/frpw.c  | 22 ++++---------
 drivers/ata/pata_parport/kbic.c  |  8 ++---
 drivers/ata/pata_parport/ktti.c  |  7 ++--
 drivers/ata/pata_parport/on20.c  |  8 ++---
 drivers/ata/pata_parport/on26.c  | 10 ++----
 15 files changed, 57 insertions(+), 167 deletions(-)

diff --git a/drivers/ata/pata_parport/aten.c b/drivers/ata/pata_parport/aten.c
index 3f5c50c2c43a..dbdd89d091df 100644
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
 
-	printk("aten %s, ATEN EH-100 at 0x%x, ", ATEN_VERSION, pi->port);
-        printk("mode %d (%s), delay %d\n",pi->mode,
-		mode_string[pi->mode],pi->delay);
-
+	dev_info(&pi->dev, "ATEN EH-100 at 0x%x, mode %d (%s), delay %d\n",
+		 pi->port, pi->mode, mode_string[pi->mode], pi->delay);
 }
 
 static struct pi_protocol aten = {
diff --git a/drivers/ata/pata_parport/bpck.c b/drivers/ata/pata_parport/bpck.c
index 89160a94b30e..d5bc419b2ab3 100644
--- a/drivers/ata/pata_parport/bpck.c
+++ b/drivers/ata/pata_parport/bpck.c
@@ -14,8 +14,6 @@
 
 */
 
-#define	BPCK_VERSION	"1.02" 
-
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/delay.h>
@@ -334,12 +332,9 @@ static int bpck_test_proto(struct pi_adapter *pi, char *scratch, int verbose)
 
 	}
 
-	if (verbose) {
-		printk("bpck: 0x%x unit %d mode %d: ",
-		       pi->port, pi->unit, pi->mode);
-	    for (i=0;i<TEST_LEN;i++) printk("%3d",buf[i]);
-	    printk("\n");
-	}
+	dev_dbg(&pi->dev, "bpck: 0x%x unit %d mode %d: ",
+		pi->port, pi->unit, pi->mode);
+	print_hex_dump_debug("bpck: ", DUMP_PREFIX_NONE, TEST_LEN, 1, buf, TEST_LEN, false);
 
 	e = 0;
 	for (i=0;i<TEST_LEN;i++) if (buf[i] != (i+1)) e++;
@@ -421,24 +416,12 @@ static void bpck_log_adapter(struct pi_adapter *pi)
 {	char	*mode_string[5] = { "4-bit","8-bit","EPP-8",
 				    "EPP-16","EPP-32" };
 	char scratch[128];
-#ifdef DUMP_EEPROM
-	int i;
-#endif
 
 	bpck_read_eeprom(pi,scratch);
-
-#ifdef DUMP_EEPROM
-	   for(i=0;i<128;i++)
-		if ((scratch[i] < ' ') || (scratch[i] > '~'))
-		    scratch[i] = '.';
-	   printk("bpck EEPROM: %64.64s\n", scratch);
-	   printk("             %64.64s\n", &scratch[64]);
-#endif
-
-	printk("bpck %s, backpack %8.8s unit %d",
-		BPCK_VERSION, &scratch[110], pi->unit);
-	printk(" at 0x%x, mode %d (%s), delay %d\n",pi->port,
-		pi->mode,mode_string[pi->mode],pi->delay);
+	print_hex_dump_bytes("bpck EEPROM: ", DUMP_PREFIX_NONE, scratch, 128);
+	dev_info(&pi->dev, "backpack %8.8s unit %d at 0x%x, mode %d (%s), delay %d\n",
+		 &scratch[110], pi->unit, pi->port, pi->mode,
+		 mode_string[pi->mode], pi->delay);
 }
 
 static struct pi_protocol bpck = {
diff --git a/drivers/ata/pata_parport/bpck6.c b/drivers/ata/pata_parport/bpck6.c
index 41395a97d77c..08dbc1bca4b9 100644
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
@@ -33,10 +30,6 @@
 #include "ppc6lnx.c"
 #include <linux/pata_parport.h>
 
-/* PARAMETERS */
-static bool verbose; /* set this to 1 to see debugging messages and whatnot */
- 
-
 #define PPCSTRUCT(pi) ((Interface *)(pi->private))
 
 /****************************************************************/
@@ -90,10 +83,7 @@ static void bpck6_read_block(struct pi_adapter *pi, char *buf, int len)
 
 static void bpck6_connect(struct pi_adapter *pi)
 {
-	if(verbose)
-	{
-		printk(KERN_DEBUG "connect\n");
-	}
+	dev_dbg(&pi->dev, "connect\n");
 
 	if(pi->mode >=2)
   	{
@@ -114,22 +104,16 @@ static void bpck6_connect(struct pi_adapter *pi)
 
 static void bpck6_disconnect(struct pi_adapter *pi)
 {
-	if(verbose)
-	{
-		printk("disconnect\n");
-	}
+	dev_dbg(&pi->dev, "disconnect\n");
 	ppc6_wr_extout(PPCSTRUCT(pi),0x0);
 	ppc6_close(PPCSTRUCT(pi));
 }
 
 static int bpck6_test_port(struct pi_adapter *pi)   /* check for 8-bit port */
 {
-	if(verbose)
-	{
-		printk(KERN_DEBUG "PARPORT indicates modes=%x for lp=0x%lx\n",
-               		((struct pardevice*)(pi->pardev))->port->modes,
-			((struct pardevice *)(pi->pardev))->port->base); 
-	}
+	dev_dbg(&pi->dev, "PARPORT indicates modes=%x for lp=0x%lx\n",
+		((struct pardevice *)(pi->pardev))->port->modes,
+		((struct pardevice *)(pi->pardev))->port->base);
 
 	/*copy over duplicate stuff.. initialize state info*/
 	PPCSTRUCT(pi)->ppc_id=pi->unit;
@@ -158,10 +142,7 @@ static int bpck6_probe_unit(struct pi_adapter *pi)
 {
 	int out;
 
-	if(verbose)
-	{
-		printk(KERN_DEBUG "PROBE UNIT %x on port:%x\n",pi->unit,pi->port);
-	}
+	dev_dbg(&pi->dev, "PROBE UNIT %x on port:%x\n", pi->unit, pi->port);
 
 	/*SET PPC UNIT NUMBER*/
 	PPCSTRUCT(pi)->ppc_id=pi->unit;
@@ -170,27 +151,17 @@ static int bpck6_probe_unit(struct pi_adapter *pi)
 	PPCSTRUCT(pi)->mode=1;		
 
 	out=ppc6_open(PPCSTRUCT(pi));
-
-	if(verbose)
-	{
-		printk(KERN_DEBUG "ppc_open returned %2x\n",out);
-	}
+	dev_dbg(&pi->dev, "ppc_open returned %2x\n", out);
 
   	if(out)
  	{
 		ppc6_close(PPCSTRUCT(pi));
-		if(verbose)
-		{
-			printk(KERN_DEBUG "leaving probe\n");
-		}
+		dev_dbg(&pi->dev, "leaving probe\n");
                return(1);
 	}
   	else
   	{
-		if(verbose)
-		{
-			printk(KERN_DEBUG "Failed open\n");
-		}
+		dev_dbg(&pi->dev, "Failed open\n");
     		return(0);
   	}
 }
@@ -200,10 +171,8 @@ static void bpck6_log_adapter(struct pi_adapter *pi)
 	char *mode_string[5]=
 		{"4-bit","8-bit","EPP-8","EPP-16","EPP-32"};
 
-	printk("BACKPACK %s, Micro Solutions BACKPACK Drive at 0x%x\n",
-		BACKPACK_VERSION, pi->port);
-	printk("Unit: %d Mode:%d (%s) Delay %d\n",
-		pi->unit,pi->mode,mode_string[pi->mode],pi->delay);
+	dev_info(&pi->dev, "Micro Solutions BACKPACK Drive unit %d at 0x%x, mode:%d (%s), delay %d\n",
+		 pi->unit, pi->port, pi->mode, mode_string[pi->mode], pi->delay);
 }
 
 static int bpck6_init_proto(struct pi_adapter *pi)
@@ -215,7 +184,7 @@ static int bpck6_init_proto(struct pi_adapter *pi)
 		return 0;
 	}
 
-	printk(KERN_ERR "ERROR COULDN'T ALLOCATE MEMORY\n");
+	dev_err(&pi->dev, "ERROR COULDN'T ALLOCATE MEMORY\n");
 	return -1;
 }
 
@@ -246,5 +215,4 @@ static struct pi_protocol bpck6 = {
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Micro Solutions Inc.");
 MODULE_DESCRIPTION("BACKPACK Protocol module, compatible with PARIDE");
-module_param(verbose, bool, 0644);
 module_pata_parport_driver(bpck6);
diff --git a/drivers/ata/pata_parport/comm.c b/drivers/ata/pata_parport/comm.c
index 88476072b708..8f0b55c1493a 100644
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
 
-	printk("comm %s, DataStor Commuter at 0x%x, ", COMM_VERSION, pi->port);
-        printk("mode %d (%s), delay %d\n",pi->mode,
-		mode_string[pi->mode],pi->delay);
-
+	dev_info(&pi->dev, "DataStor Commuter at 0x%x, mode %d (%s), delay %d\n",
+		 pi->port, pi->mode, mode_string[pi->mode], pi->delay);
 }
 
 static struct pi_protocol comm = {
diff --git a/drivers/ata/pata_parport/dstr.c b/drivers/ata/pata_parport/dstr.c
index a8b238828061..c0e44f33ae37 100644
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
 
-	printk("dstr %s, DataStor EP2000 at 0x%x, ", DSTR_VERSION, pi->port);
-        printk("mode %d (%s), delay %d\n",pi->mode,
-		mode_string[pi->mode],pi->delay);
-
+	dev_info(&pi->dev, "DataStor EP2000 at 0x%x, mode %d (%s), delay %d\n",
+		 pi->port, pi->mode, mode_string[pi->mode], pi->delay);
 }
 
 static struct pi_protocol dstr = {
diff --git a/drivers/ata/pata_parport/epat.c b/drivers/ata/pata_parport/epat.c
index 54b81f785fce..ceeaf36d912d 100644
--- a/drivers/ata/pata_parport/epat.c
+++ b/drivers/ata/pata_parport/epat.c
@@ -16,8 +16,6 @@
 
 */
 
-#define EPAT_VERSION      "1.02"
-
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/delay.h>
@@ -279,10 +277,8 @@ static int epat_test_proto(struct pi_adapter *pi, char *scratch, int verbose)
         }
         epat_disconnect(pi);
 
-        if (verbose)  {
-		printk("epat: port 0x%x, mode %d, ccr %x, test=(%d,%d,%d)\n",
-		       pi->port, pi->mode, cc, e[0], e[1], f);
-	}
+	dev_dbg(&pi->dev, "epat: port 0x%x, mode %d, ccr %x, test=(%d,%d,%d)\n",
+		pi->port, pi->mode, cc, e[0], e[1], f);
 	
         return (e[0] && e[1]) || f;
 }
@@ -298,11 +294,8 @@ static void epat_log_adapter(struct pi_adapter *pi)
         ver = RR(0xb);
         epat_disconnect(pi);
 
-	printk("epat %s, Shuttle EPAT chip %x at 0x%x, ",
-		EPAT_VERSION, ver, pi->port);
-	printk("mode %d (%s), delay %d\n",pi->mode,
-		mode_string[pi->mode],pi->delay);
-
+	dev_info(&pi->dev, "Shuttle EPAT chip %x at 0x%x, mode %d (%s), delay %d\n",
+		 ver, pi->port, pi->mode, mode_string[pi->mode], pi->delay);
 }
 
 static struct pi_protocol epat = {
diff --git a/drivers/ata/pata_parport/epia.c b/drivers/ata/pata_parport/epia.c
index ece7862dc058..8bbe3b2c7634 100644
--- a/drivers/ata/pata_parport/epia.c
+++ b/drivers/ata/pata_parport/epia.c
@@ -17,8 +17,6 @@
 
 */
 
-#define EPIA_VERSION      "1.02"
-
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/delay.h>
@@ -262,10 +260,8 @@ static int epia_test_proto(struct pi_adapter *pi, char *scratch, int verbose)
         WR(0x84,0);
         epia_disconnect(pi);
 
-        if (verbose)  {
-		printk("epia: port 0x%x, mode %d, test=(%d,%d,%d)\n",
-		       pi->port, pi->mode, e[0], e[1], f);
-        }
+	dev_dbg(&pi->dev, "epia: port 0x%x, mode %d, test=(%d,%d,%d)\n",
+		pi->port, pi->mode, e[0], e[1], f);
         
         return (e[0] && e[1]) || f;
 
@@ -277,10 +273,8 @@ static void epia_log_adapter(struct pi_adapter *pi)
 {       char    *mode_string[6] = {"4-bit","5/3","8-bit",
 				   "EPP-8","EPP-16","EPP-32"};
 
-	printk("epia %s, Shuttle EPIA at 0x%x, ", EPIA_VERSION, pi->port);
-        printk("mode %d (%s), delay %d\n",pi->mode,
-		mode_string[pi->mode],pi->delay);
-
+	dev_info(&pi->dev, "Shuttle EPIA at 0x%x, mode %d (%s), delay %d\n",
+		 pi->port, pi->mode, mode_string[pi->mode], pi->delay);
 }
 
 static struct pi_protocol epia = {
diff --git a/drivers/ata/pata_parport/fit2.c b/drivers/ata/pata_parport/fit2.c
index 33cdc9bbfff4..a32250c9d042 100644
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
-	printk("fit2 %s, FIT 2000 adapter at 0x%x, delay %d\n",
-		FIT2_VERSION, pi->port, pi->delay);
+	dev_info(&pi->dev, "FIT 2000 adapter at 0x%x, delay %d\n",
+		 pi->port, pi->delay);
 
 }
 
diff --git a/drivers/ata/pata_parport/fit3.c b/drivers/ata/pata_parport/fit3.c
index d5056b0157ab..cb2771de7c32 100644
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
 
-	printk("fit3 %s, FIT 3000 adapter at 0x%x, "
-	       "mode %d (%s), delay %d\n",
-		FIT3_VERSION, pi->port,
-		pi->mode,mode_string[pi->mode],pi->delay);
-
+	dev_info(&pi->dev, "FIT 3000 adapter at 0x%x, mode %d (%s), delay %d\n",
+		 pi->port, pi->mode, mode_string[pi->mode], pi->delay);
 }
 
 static struct pi_protocol fit3 = {
diff --git a/drivers/ata/pata_parport/friq.c b/drivers/ata/pata_parport/friq.c
index bf597ee520b7..dae26a97ad4f 100644
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
@@ -207,10 +205,8 @@ static int friq_test_proto(struct pi_adapter *pi, char *scratch, int verbose)
         for (k=0;k<128;k++) if (scratch[k] != k) r++;
 	friq_disconnect(pi);
 
-        if (verbose)  {
-		printk("friq: port 0x%x, mode %d, test=(%d,%d,%d)\n",
-		       pi->port, pi->mode, e[0], e[1], r);
-        }
+	dev_dbg(&pi->dev, "friq: port 0x%x, mode %d, test=(%d,%d,%d)\n",
+		pi->port, pi->mode, e[0], e[1], r);
 
         return (r || (e[0] && e[1]));
 }
@@ -221,10 +217,8 @@ static void friq_log_adapter(struct pi_adapter *pi)
 {       char    *mode_string[6] = {"4-bit","8-bit",
 				   "EPP-8","EPP-16","EPP-32"};
 
-	printk("friq %s, Freecom IQ ASIC-2 adapter at 0x%x, ",
-		FRIQ_VERSION,pi->port);
-        printk("mode %d (%s), delay %d\n",pi->mode,
-		mode_string[pi->mode],pi->delay);
+	dev_info(&pi->dev, "Freecom IQ ASIC-2 adapter at 0x%x, mode %d (%s), delay %d\n",
+		 pi->port, pi->mode, mode_string[pi->mode], pi->delay);
 
 	pi->private = 1;
 	friq_connect(pi);
diff --git a/drivers/ata/pata_parport/frpw.c b/drivers/ata/pata_parport/frpw.c
index 9b8db1122154..92b359460e34 100644
--- a/drivers/ata/pata_parport/frpw.c
+++ b/drivers/ata/pata_parport/frpw.c
@@ -23,8 +23,6 @@
 
 */
 
-#define	FRPW_VERSION	"1.03" 
-
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/delay.h>
@@ -230,14 +228,12 @@ static int frpw_test_proto(struct pi_adapter *pi, char *scratch, int verbose)
 	   pi->private = frpw_test_pnp(pi) + 2*pi->port;
 
 	if (((pi->private%2) == 0) && (pi->mode > 2)) {
-	   if (verbose) 
-		printk("frpw: Xilinx does not support mode %d\n", pi->mode);
+		dev_dbg(&pi->dev, "frpw: Xilinx does not support mode %d\n", pi->mode);
 	   return 1;
 	}
 
 	if (((pi->private%2) == 1) && (pi->mode == 2)) {
-	   if (verbose)
-		printk("frpw: ASIC does not support mode 2\n");
+		dev_dbg(&pi->dev, "frpw: ASIC does not support mode 2\n");
 	   return 1;
 	}
 
@@ -258,10 +254,8 @@ static int frpw_test_proto(struct pi_adapter *pi, char *scratch, int verbose)
         for (k=0;k<128;k++) if (scratch[k] != k) r++;
 	frpw_disconnect(pi);
 
-        if (verbose)  {
-		printk("frpw: port 0x%x, chip %ld, mode %d, test=(%d,%d,%d)\n",
-		       pi->port, (pi->private%2), pi->mode, e[0], e[1], r);
-        }
+	dev_dbg(&pi->dev, "frpw: port 0x%x, chip %ld, mode %d, test=(%d,%d,%d)\n",
+		pi->port, (pi->private%2), pi->mode, e[0], e[1], r);
 
         return (r || (e[0] && e[1]));
 }
@@ -272,11 +266,9 @@ static void frpw_log_adapter(struct pi_adapter *pi)
 {       char    *mode_string[6] = {"4-bit","8-bit","EPP",
 				   "EPP-8","EPP-16","EPP-32"};
 
-	printk("frpw %s, Freecom (%s) adapter at 0x%x, ",
-		FRPW_VERSION,((pi->private%2) == 0)?"Xilinx":"ASIC",pi->port);
-        printk("mode %d (%s), delay %d\n",pi->mode,
-		mode_string[pi->mode],pi->delay);
-
+	dev_info(&pi->dev, "Freecom (%s) adapter at 0x%x, mode %d (%s), delay %d\n",
+		 ((pi->private % 2) == 0) ? "Xilinx":"ASIC",
+		 pi->port, pi->mode, mode_string[pi->mode], pi->delay);
 }
 
 static struct pi_protocol frpw = {
diff --git a/drivers/ata/pata_parport/kbic.c b/drivers/ata/pata_parport/kbic.c
index db5e2081ed9c..94a3af034cae 100644
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
 
-	printk("kbic %s, KingByte %s at 0x%x, ", KBIC_VERSION, chip, pi->port);
-        printk("mode %d (%s), delay %d\n",pi->mode,
-		mode_string[pi->mode],pi->delay);
-
+	dev_info(&pi->dev, "KingByte %s at 0x%x, mode %d (%s), delay %d\n",
+		 chip, pi->port, pi->mode, mode_string[pi->mode], pi->delay);
 }
 
 static void k951_log_adapter(struct pi_adapter *pi)
diff --git a/drivers/ata/pata_parport/ktti.c b/drivers/ata/pata_parport/ktti.c
index 980da296cac4..5fd4d797720c 100644
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
-	printk("ktti %s, KT adapter at 0x%x, delay %d\n",
-		KTTI_VERSION, pi->port, pi->delay);
-
+	dev_info(&pi->dev, "KT adapter at 0x%x, delay %d\n",
+		 pi->port, pi->delay);
 }
 
 static struct pi_protocol ktti = {
diff --git a/drivers/ata/pata_parport/on20.c b/drivers/ata/pata_parport/on20.c
index a3b0708aed71..540b6f842484 100644
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
 
-	printk("on20 %s, OnSpec 90c20 at 0x%x, ", ON20_VERSION, pi->port);
-        printk("mode %d (%s), delay %d\n",pi->mode,
-		mode_string[pi->mode],pi->delay);
-
+	dev_info(&pi->dev, "OnSpec 90c20 at 0x%x, mode %d (%s), delay %d\n",
+		 pi->port, pi->mode, mode_string[pi->mode], pi->delay);
 }
 
 static struct pi_protocol on20 = {
diff --git a/drivers/ata/pata_parport/on26.c b/drivers/ata/pata_parport/on26.c
index 8dc8296d50e6..4ec1091ae6a7 100644
--- a/drivers/ata/pata_parport/on26.c
+++ b/drivers/ata/pata_parport/on26.c
@@ -16,8 +16,6 @@
 
 */
 
-#define ON26_VERSION      "1.04"
-
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/delay.h>
@@ -167,7 +165,7 @@ static int on26_test_port(struct pi_adapter *pi)  /* hard reset */
             }
 
 	    if (i == RESET_WAIT) 
-		printk("on26: Device reset failed (%x,%x)\n",x,y);
+		dev_err(&pi->dev, "on26: Device reset failed (%x,%x)\n", x, y);
 
             w0(4); P1; w0(4); P1;
         }
@@ -280,10 +278,8 @@ static void on26_log_adapter(struct pi_adapter *pi)
 {       char    *mode_string[5] = {"4-bit","8-bit","EPP-8",
 				   "EPP-16","EPP-32"};
 
-	printk("on26 %s, OnSpec 90c26 at 0x%x, ", ON26_VERSION, pi->port);
-        printk("mode %d (%s), delay %d\n",pi->mode,
-		mode_string[pi->mode],pi->delay);
-
+	dev_info(&pi->dev, "OnSpec 90c26 at 0x%x, mode %d (%s), delay %d\n",
+		 pi->port, pi->mode, mode_string[pi->mode], pi->delay);
 }
 
 static struct pi_protocol on26 = {
-- 
Ondrej Zary

