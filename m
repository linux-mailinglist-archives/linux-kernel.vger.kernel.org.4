Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A22A6ACC75
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 19:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjCFSYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 13:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjCFSYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 13:24:18 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E3593B84B;
        Mon,  6 Mar 2023 10:23:59 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id DA4027A05DC;
        Mon,  6 Mar 2023 18:28:28 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/18] pata_parport: remove device from struct pi_adapter
Date:   Mon,  6 Mar 2023 18:27:41 +0100
Message-Id: <20230306172752.7727-8-linux@zary.sk>
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

device is never set in pata_parport, remove it.

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/aten.c  |  3 +--
 drivers/ata/pata_parport/bpck.c  | 12 ++++++------
 drivers/ata/pata_parport/bpck6.c | 10 ++++------
 drivers/ata/pata_parport/comm.c  |  3 +--
 drivers/ata/pata_parport/dstr.c  |  3 +--
 drivers/ata/pata_parport/epat.c  |  8 ++++----
 drivers/ata/pata_parport/epia.c  |  7 +++----
 drivers/ata/pata_parport/fit2.c  |  5 +++--
 drivers/ata/pata_parport/fit3.c  |  4 ++--
 drivers/ata/pata_parport/friq.c  |  6 +++---
 drivers/ata/pata_parport/frpw.c  | 12 +++++-------
 drivers/ata/pata_parport/kbic.c  |  3 +--
 drivers/ata/pata_parport/ktti.c  |  5 +++--
 drivers/ata/pata_parport/on20.c  |  3 +--
 drivers/ata/pata_parport/on26.c  |  3 +--
 include/linux/pata_parport.h     |  1 -
 16 files changed, 39 insertions(+), 49 deletions(-)

diff --git a/drivers/ata/pata_parport/aten.c b/drivers/ata/pata_parport/aten.c
index 9e6098f90162..bf83e4188c23 100644
--- a/drivers/ata/pata_parport/aten.c
+++ b/drivers/ata/pata_parport/aten.c
@@ -124,8 +124,7 @@ static void aten_log_adapter( PIA *pi, char * scratch, int verbose )
 
 {       char    *mode_string[2] = {"4-bit","8-bit"};
 
-        printk("%s: aten %s, ATEN EH-100 at 0x%x, ",
-                pi->device,ATEN_VERSION,pi->port);
+	printk("aten %s, ATEN EH-100 at 0x%x, ", ATEN_VERSION, pi->port);
         printk("mode %d (%s), delay %d\n",pi->mode,
 		mode_string[pi->mode],pi->delay);
 
diff --git a/drivers/ata/pata_parport/bpck.c b/drivers/ata/pata_parport/bpck.c
index 96386a10c22f..c33ca1cb72ac 100644
--- a/drivers/ata/pata_parport/bpck.c
+++ b/drivers/ata/pata_parport/bpck.c
@@ -335,8 +335,8 @@ static int bpck_test_proto( PIA *pi, char * scratch, int verbose )
 	}
 
 	if (verbose) {
-	    printk("%s: bpck: 0x%x unit %d mode %d: ",
-		   pi->device,pi->port,pi->unit,pi->mode);
+		printk("bpck: 0x%x unit %d mode %d: ",
+		       pi->port, pi->unit, pi->mode);
 	    for (i=0;i<TEST_LEN;i++) printk("%3d",buf[i]);
 	    printk("\n");
 	}
@@ -432,13 +432,13 @@ static void bpck_log_adapter( PIA *pi, char * scratch, int verbose )
 	   for(i=0;i<128;i++)
 		if ((scratch[i] < ' ') || (scratch[i] > '~'))
 		    scratch[i] = '.';
-	   printk("%s: bpck EEPROM: %64.64s\n",pi->device,scratch);
-	   printk("%s:              %64.64s\n",pi->device,&scratch[64]);
+	   printk("bpck EEPROM: %64.64s\n", scratch);
+	   printk("             %64.64s\n", &scratch[64]);
 	}
 #endif
 
-	printk("%s: bpck %s, backpack %8.8s unit %d",
-		pi->device,BPCK_VERSION,&scratch[110],pi->unit);
+	printk("bpck %s, backpack %8.8s unit %d",
+		BPCK_VERSION, &scratch[110], pi->unit);
 	printk(" at 0x%x, mode %d (%s), delay %d\n",pi->port,
 		pi->mode,mode_string[pi->mode],pi->delay);
 }
diff --git a/drivers/ata/pata_parport/bpck6.c b/drivers/ata/pata_parport/bpck6.c
index 3c358e66db25..13bfd60655dd 100644
--- a/drivers/ata/pata_parport/bpck6.c
+++ b/drivers/ata/pata_parport/bpck6.c
@@ -200,11 +200,9 @@ static void bpck6_log_adapter( PIA *pi, char * scratch, int verbose )
 	char *mode_string[5]=
 		{"4-bit","8-bit","EPP-8","EPP-16","EPP-32"};
 
-	printk("%s: BACKPACK Protocol Driver V"BACKPACK_VERSION"\n",pi->device);
-	printk("%s: Copyright 2001 by Micro Solutions, Inc., DeKalb IL.\n",pi->device);
-	printk("%s: BACKPACK %s, Micro Solutions BACKPACK Drive at 0x%x\n",
-		pi->device,BACKPACK_VERSION,pi->port);
-	printk("%s: Unit: %d Mode:%d (%s) Delay %d\n",pi->device,
+	printk("BACKPACK %s, Micro Solutions BACKPACK Drive at 0x%x\n",
+		BACKPACK_VERSION, pi->port);
+	printk("Unit: %d Mode:%d (%s) Delay %d\n",
 		pi->unit,pi->mode,mode_string[pi->mode],pi->delay);
 }
 
@@ -217,7 +215,7 @@ static int bpck6_init_proto(PIA *pi)
 		return 0;
 	}
 
-	printk(KERN_ERR "%s: ERROR COULDN'T ALLOCATE MEMORY\n", pi->device); 
+	printk(KERN_ERR "ERROR COULDN'T ALLOCATE MEMORY\n");
 	return -1;
 }
 
diff --git a/drivers/ata/pata_parport/comm.c b/drivers/ata/pata_parport/comm.c
index 47f0fbccc3aa..908f6c44548b 100644
--- a/drivers/ata/pata_parport/comm.c
+++ b/drivers/ata/pata_parport/comm.c
@@ -183,8 +183,7 @@ static void comm_log_adapter( PIA *pi, char * scratch, int verbose )
 
 {       char    *mode_string[5] = {"4-bit","8-bit","EPP-8","EPP-16","EPP-32"};
 
-        printk("%s: comm %s, DataStor Commuter at 0x%x, ",
-                pi->device,COMM_VERSION,pi->port);
+	printk("comm %s, DataStor Commuter at 0x%x, ", COMM_VERSION, pi->port);
         printk("mode %d (%s), delay %d\n",pi->mode,
 		mode_string[pi->mode],pi->delay);
 
diff --git a/drivers/ata/pata_parport/dstr.c b/drivers/ata/pata_parport/dstr.c
index e733a2512e17..3732e9b79429 100644
--- a/drivers/ata/pata_parport/dstr.c
+++ b/drivers/ata/pata_parport/dstr.c
@@ -195,8 +195,7 @@ static void dstr_log_adapter( PIA *pi, char * scratch, int verbose )
 {       char    *mode_string[5] = {"4-bit","8-bit","EPP-8",
 				   "EPP-16","EPP-32"};
 
-        printk("%s: dstr %s, DataStor EP2000 at 0x%x, ",
-                pi->device,DSTR_VERSION,pi->port);
+	printk("dstr %s, DataStor EP2000 at 0x%x, ", DSTR_VERSION, pi->port);
         printk("mode %d (%s), delay %d\n",pi->mode,
 		mode_string[pi->mode],pi->delay);
 
diff --git a/drivers/ata/pata_parport/epat.c b/drivers/ata/pata_parport/epat.c
index 7583d07083a8..59720daa9c19 100644
--- a/drivers/ata/pata_parport/epat.c
+++ b/drivers/ata/pata_parport/epat.c
@@ -280,8 +280,8 @@ static int epat_test_proto( PIA *pi, char * scratch, int verbose )
         epat_disconnect(pi);
 
         if (verbose)  {
-            printk("%s: epat: port 0x%x, mode %d, ccr %x, test=(%d,%d,%d)\n",
-		   pi->device,pi->port,pi->mode,cc,e[0],e[1],f);
+		printk("epat: port 0x%x, mode %d, ccr %x, test=(%d,%d,%d)\n",
+		       pi->port, pi->mode, cc, e[0], e[1], f);
 	}
 	
         return (e[0] && e[1]) || f;
@@ -298,8 +298,8 @@ static void epat_log_adapter( PIA *pi, char * scratch, int verbose )
         ver = RR(0xb);
         epat_disconnect(pi);
 
-	printk("%s: epat %s, Shuttle EPAT chip %x at 0x%x, ",
-		pi->device,EPAT_VERSION,ver,pi->port);
+	printk("epat %s, Shuttle EPAT chip %x at 0x%x, ",
+		EPAT_VERSION, ver, pi->port);
 	printk("mode %d (%s), delay %d\n",pi->mode,
 		mode_string[pi->mode],pi->delay);
 
diff --git a/drivers/ata/pata_parport/epia.c b/drivers/ata/pata_parport/epia.c
index 2bcb18a6845a..610269083441 100644
--- a/drivers/ata/pata_parport/epia.c
+++ b/drivers/ata/pata_parport/epia.c
@@ -263,8 +263,8 @@ static int epia_test_proto( PIA *pi, char * scratch, int verbose )
         epia_disconnect(pi);
 
         if (verbose)  {
-            printk("%s: epia: port 0x%x, mode %d, test=(%d,%d,%d)\n",
-                   pi->device,pi->port,pi->mode,e[0],e[1],f);
+		printk("epia: port 0x%x, mode %d, test=(%d,%d,%d)\n",
+		       pi->port, pi->mode, e[0], e[1], f);
         }
         
         return (e[0] && e[1]) || f;
@@ -277,8 +277,7 @@ static void epia_log_adapter( PIA *pi, char * scratch, int verbose )
 {       char    *mode_string[6] = {"4-bit","5/3","8-bit",
 				   "EPP-8","EPP-16","EPP-32"};
 
-        printk("%s: epia %s, Shuttle EPIA at 0x%x, ",
-                pi->device,EPIA_VERSION,pi->port);
+	printk("epia %s, Shuttle EPIA at 0x%x, ", EPIA_VERSION, pi->port);
         printk("mode %d (%s), delay %d\n",pi->mode,
 		mode_string[pi->mode],pi->delay);
 
diff --git a/drivers/ata/pata_parport/fit2.c b/drivers/ata/pata_parport/fit2.c
index c63f0cd2ea52..28de8e4e41c3 100644
--- a/drivers/ata/pata_parport/fit2.c
+++ b/drivers/ata/pata_parport/fit2.c
@@ -115,8 +115,9 @@ static void fit2_disconnect ( PIA *pi )
 
 static void fit2_log_adapter( PIA *pi, char * scratch, int verbose )
 
-{       printk("%s: fit2 %s, FIT 2000 adapter at 0x%x, delay %d\n",
-                pi->device,FIT2_VERSION,pi->port,pi->delay);
+{
+	printk("fit2 %s, FIT 2000 adapter at 0x%x, delay %d\n",
+		FIT2_VERSION, pi->port, pi->delay);
 
 }
 
diff --git a/drivers/ata/pata_parport/fit3.c b/drivers/ata/pata_parport/fit3.c
index adbef142c88f..0366f3123508 100644
--- a/drivers/ata/pata_parport/fit3.c
+++ b/drivers/ata/pata_parport/fit3.c
@@ -173,9 +173,9 @@ static void fit3_log_adapter( PIA *pi, char * scratch, int verbose )
 
 {       char    *mode_string[3] = {"4-bit","8-bit","EPP"};
 
-	printk("%s: fit3 %s, FIT 3000 adapter at 0x%x, "
+	printk("fit3 %s, FIT 3000 adapter at 0x%x, "
 	       "mode %d (%s), delay %d\n",
-                pi->device,FIT3_VERSION,pi->port,
+		FIT3_VERSION, pi->port,
 		pi->mode,mode_string[pi->mode],pi->delay);
 
 }
diff --git a/drivers/ata/pata_parport/friq.c b/drivers/ata/pata_parport/friq.c
index e740fe933e20..9306a2c78d90 100644
--- a/drivers/ata/pata_parport/friq.c
+++ b/drivers/ata/pata_parport/friq.c
@@ -208,8 +208,8 @@ static int friq_test_proto( PIA *pi, char * scratch, int verbose )
 	friq_disconnect(pi);
 
         if (verbose)  {
-            printk("%s: friq: port 0x%x, mode %d, test=(%d,%d,%d)\n",
-                   pi->device,pi->port,pi->mode,e[0],e[1],r);
+		printk("friq: port 0x%x, mode %d, test=(%d,%d,%d)\n",
+		       pi->port, pi->mode, e[0], e[1], r);
         }
 
         return (r || (e[0] && e[1]));
@@ -221,7 +221,7 @@ static void friq_log_adapter( PIA *pi, char * scratch, int verbose )
 {       char    *mode_string[6] = {"4-bit","8-bit",
 				   "EPP-8","EPP-16","EPP-32"};
 
-        printk("%s: friq %s, Freecom IQ ASIC-2 adapter at 0x%x, ", pi->device,
+	printk("friq %s, Freecom IQ ASIC-2 adapter at 0x%x, ",
 		FRIQ_VERSION,pi->port);
         printk("mode %d (%s), delay %d\n",pi->mode,
 		mode_string[pi->mode],pi->delay);
diff --git a/drivers/ata/pata_parport/frpw.c b/drivers/ata/pata_parport/frpw.c
index 8c8681812bed..63f2165fec63 100644
--- a/drivers/ata/pata_parport/frpw.c
+++ b/drivers/ata/pata_parport/frpw.c
@@ -231,15 +231,13 @@ static int frpw_test_proto( PIA *pi, char * scratch, int verbose )
 
 	if (((pi->private%2) == 0) && (pi->mode > 2)) {
 	   if (verbose) 
-		printk("%s: frpw: Xilinx does not support mode %d\n",
-			pi->device, pi->mode);
+		printk("frpw: Xilinx does not support mode %d\n", pi->mode);
 	   return 1;
 	}
 
 	if (((pi->private%2) == 1) && (pi->mode == 2)) {
 	   if (verbose)
-		printk("%s: frpw: ASIC does not support mode 2\n",
-			pi->device);
+		printk("frpw: ASIC does not support mode 2\n");
 	   return 1;
 	}
 
@@ -261,8 +259,8 @@ static int frpw_test_proto( PIA *pi, char * scratch, int verbose )
 	frpw_disconnect(pi);
 
         if (verbose)  {
-            printk("%s: frpw: port 0x%x, chip %ld, mode %d, test=(%d,%d,%d)\n",
-                   pi->device,pi->port,(pi->private%2),pi->mode,e[0],e[1],r);
+		printk("frpw: port 0x%x, chip %ld, mode %d, test=(%d,%d,%d)\n",
+		       pi->port, (pi->private%2), pi->mode, e[0], e[1], r);
         }
 
         return (r || (e[0] && e[1]));
@@ -274,7 +272,7 @@ static void frpw_log_adapter( PIA *pi, char * scratch, int verbose )
 {       char    *mode_string[6] = {"4-bit","8-bit","EPP",
 				   "EPP-8","EPP-16","EPP-32"};
 
-        printk("%s: frpw %s, Freecom (%s) adapter at 0x%x, ", pi->device,
+	printk("frpw %s, Freecom (%s) adapter at 0x%x, ",
 		FRPW_VERSION,((pi->private%2) == 0)?"Xilinx":"ASIC",pi->port);
         printk("mode %d (%s), delay %d\n",pi->mode,
 		mode_string[pi->mode],pi->delay);
diff --git a/drivers/ata/pata_parport/kbic.c b/drivers/ata/pata_parport/kbic.c
index b120597043cc..9a99b9e35d41 100644
--- a/drivers/ata/pata_parport/kbic.c
+++ b/drivers/ata/pata_parport/kbic.c
@@ -235,8 +235,7 @@ static void kbic_log_adapter( PIA *pi, char * scratch,
 {       char    *mode_string[6] = {"4-bit","5/3","8-bit",
 				   "EPP-8","EPP_16","EPP-32"};
 
-        printk("%s: kbic %s, KingByte %s at 0x%x, ",
-                pi->device,KBIC_VERSION,chip,pi->port);
+	printk("kbic %s, KingByte %s at 0x%x, ", KBIC_VERSION, chip, pi->port);
         printk("mode %d (%s), delay %d\n",pi->mode,
 		mode_string[pi->mode],pi->delay);
 
diff --git a/drivers/ata/pata_parport/ktti.c b/drivers/ata/pata_parport/ktti.c
index 15463cd18968..d87eb3c139bc 100644
--- a/drivers/ata/pata_parport/ktti.c
+++ b/drivers/ata/pata_parport/ktti.c
@@ -92,8 +92,9 @@ static void ktti_disconnect ( PIA *pi )
 
 static void ktti_log_adapter( PIA *pi, char * scratch, int verbose )
 
-{       printk("%s: ktti %s, KT adapter at 0x%x, delay %d\n",
-                pi->device,KTTI_VERSION,pi->port,pi->delay);
+{
+	printk("ktti %s, KT adapter at 0x%x, delay %d\n",
+		KTTI_VERSION, pi->port, pi->delay);
 
 }
 
diff --git a/drivers/ata/pata_parport/on20.c b/drivers/ata/pata_parport/on20.c
index f2a601e77842..0a1e60e20656 100644
--- a/drivers/ata/pata_parport/on20.c
+++ b/drivers/ata/pata_parport/on20.c
@@ -115,8 +115,7 @@ static void on20_log_adapter( PIA *pi, char * scratch, int verbose )
 
 {       char    *mode_string[2] = {"4-bit","8-bit"};
 
-        printk("%s: on20 %s, OnSpec 90c20 at 0x%x, ",
-                pi->device,ON20_VERSION,pi->port);
+	printk("on20 %s, OnSpec 90c20 at 0x%x, ", ON20_VERSION, pi->port);
         printk("mode %d (%s), delay %d\n",pi->mode,
 		mode_string[pi->mode],pi->delay);
 
diff --git a/drivers/ata/pata_parport/on26.c b/drivers/ata/pata_parport/on26.c
index 66f04015f19a..ceb5018caeec 100644
--- a/drivers/ata/pata_parport/on26.c
+++ b/drivers/ata/pata_parport/on26.c
@@ -280,8 +280,7 @@ static void on26_log_adapter( PIA *pi, char * scratch, int verbose )
 {       char    *mode_string[5] = {"4-bit","8-bit","EPP-8",
 				   "EPP-16","EPP-32"};
 
-        printk("%s: on26 %s, OnSpec 90c26 at 0x%x, ",
-                pi->device,ON26_VERSION,pi->port);
+	printk("on26 %s, OnSpec 90c26 at 0x%x, ", ON26_VERSION, pi->port);
         printk("mode %d (%s), delay %d\n",pi->mode,
 		mode_string[pi->mode],pi->delay);
 
diff --git a/include/linux/pata_parport.h b/include/linux/pata_parport.h
index 3fc6b002c7c8..dcab769aa639 100644
--- a/include/linux/pata_parport.h
+++ b/include/linux/pata_parport.h
@@ -17,7 +17,6 @@ struct pi_adapter {
 	int port;			/* base address of parallel port */
 	int mode;			/* transfer mode in use */
 	int delay;			/* adapter delay setting */
-	char *device;			/* dummy for paride protocol modules */
 	int unit;			/* unit number for chained adapters */
 	int saved_r0;			/* saved port state */
 	int saved_r2;			/* saved port state */
-- 
Ondrej Zary

