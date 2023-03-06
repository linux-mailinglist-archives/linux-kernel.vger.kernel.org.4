Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8ED6ACB87
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 18:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjCFRz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 12:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjCFRye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 12:54:34 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E54D26512E;
        Mon,  6 Mar 2023 09:54:01 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 621C87A06FE;
        Mon,  6 Mar 2023 18:28:29 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/18] pata_parport: use dev_* instead of printk
Date:   Mon,  6 Mar 2023 18:27:45 +0100
Message-Id: <20230306172752.7727-12-linux@zary.sk>
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

Use dev_info/dev_err/dev_dbg instead of printk.

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/aten.c  |  4 +--
 drivers/ata/pata_parport/bpck.c  |  4 +--
 drivers/ata/pata_parport/bpck6.c | 45 +++++++++-----------------------
 drivers/ata/pata_parport/comm.c  |  4 +--
 drivers/ata/pata_parport/dstr.c  |  4 +--
 drivers/ata/pata_parport/epat.c  | 10 +++----
 drivers/ata/pata_parport/epia.c  | 10 +++----
 drivers/ata/pata_parport/fit2.c  |  2 +-
 drivers/ata/pata_parport/fit3.c  |  2 +-
 drivers/ata/pata_parport/friq.c  | 10 +++----
 drivers/ata/pata_parport/frpw.c  | 16 +++++-------
 drivers/ata/pata_parport/kbic.c  |  4 +--
 drivers/ata/pata_parport/ktti.c  |  2 +-
 drivers/ata/pata_parport/on20.c  |  4 +--
 drivers/ata/pata_parport/on26.c  |  6 ++---
 15 files changed, 48 insertions(+), 79 deletions(-)

diff --git a/drivers/ata/pata_parport/aten.c b/drivers/ata/pata_parport/aten.c
index 3f5c50c2c43a..ccbba14ccab1 100644
--- a/drivers/ata/pata_parport/aten.c
+++ b/drivers/ata/pata_parport/aten.c
@@ -124,8 +124,8 @@ static void aten_log_adapter(struct pi_adapter *pi)
 
 {       char    *mode_string[2] = {"4-bit","8-bit"};
 
-	printk("aten %s, ATEN EH-100 at 0x%x, ", ATEN_VERSION, pi->port);
-        printk("mode %d (%s), delay %d\n",pi->mode,
+	dev_info(&pi->dev, "aten %s, ATEN EH-100 at 0x%x, ", ATEN_VERSION, pi->port);
+	dev_info(&pi->dev, "mode %d (%s), delay %d\n", pi->mode,
 		mode_string[pi->mode],pi->delay);
 
 }
diff --git a/drivers/ata/pata_parport/bpck.c b/drivers/ata/pata_parport/bpck.c
index f475a25769f0..1cba098b4b82 100644
--- a/drivers/ata/pata_parport/bpck.c
+++ b/drivers/ata/pata_parport/bpck.c
@@ -435,9 +435,9 @@ static void bpck_log_adapter(struct pi_adapter *pi)
 	   printk("             %64.64s\n", &scratch[64]);
 #endif
 
-	printk("bpck %s, backpack %8.8s unit %d",
+	dev_info(&pi->dev, "bpck %s, backpack %8.8s unit %d",
 		BPCK_VERSION, &scratch[110], pi->unit);
-	printk(" at 0x%x, mode %d (%s), delay %d\n",pi->port,
+	dev_info(&pi->dev, " at 0x%x, mode %d (%s), delay %d\n", pi->port,
 		pi->mode,mode_string[pi->mode],pi->delay);
 }
 
diff --git a/drivers/ata/pata_parport/bpck6.c b/drivers/ata/pata_parport/bpck6.c
index 41395a97d77c..4770e29bfdeb 100644
--- a/drivers/ata/pata_parport/bpck6.c
+++ b/drivers/ata/pata_parport/bpck6.c
@@ -90,10 +90,7 @@ static void bpck6_read_block(struct pi_adapter *pi, char *buf, int len)
 
 static void bpck6_connect(struct pi_adapter *pi)
 {
-	if(verbose)
-	{
-		printk(KERN_DEBUG "connect\n");
-	}
+	dev_dbg(&pi->dev, "connect\n");
 
 	if(pi->mode >=2)
   	{
@@ -114,22 +111,16 @@ static void bpck6_connect(struct pi_adapter *pi)
 
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
@@ -158,10 +149,7 @@ static int bpck6_probe_unit(struct pi_adapter *pi)
 {
 	int out;
 
-	if(verbose)
-	{
-		printk(KERN_DEBUG "PROBE UNIT %x on port:%x\n",pi->unit,pi->port);
-	}
+	dev_dbg(&pi->dev, "PROBE UNIT %x on port:%x\n", pi->unit, pi->port);
 
 	/*SET PPC UNIT NUMBER*/
 	PPCSTRUCT(pi)->ppc_id=pi->unit;
@@ -171,26 +159,17 @@ static int bpck6_probe_unit(struct pi_adapter *pi)
 
 	out=ppc6_open(PPCSTRUCT(pi));
 
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
@@ -200,9 +179,9 @@ static void bpck6_log_adapter(struct pi_adapter *pi)
 	char *mode_string[5]=
 		{"4-bit","8-bit","EPP-8","EPP-16","EPP-32"};
 
-	printk("BACKPACK %s, Micro Solutions BACKPACK Drive at 0x%x\n",
+	dev_info(&pi->dev, "BACKPACK %s, Micro Solutions BACKPACK Drive at 0x%x\n",
 		BACKPACK_VERSION, pi->port);
-	printk("Unit: %d Mode:%d (%s) Delay %d\n",
+	dev_info(&pi->dev, "Unit: %d Mode:%d (%s) Delay %d\n",
 		pi->unit,pi->mode,mode_string[pi->mode],pi->delay);
 }
 
@@ -215,7 +194,7 @@ static int bpck6_init_proto(struct pi_adapter *pi)
 		return 0;
 	}
 
-	printk(KERN_ERR "ERROR COULDN'T ALLOCATE MEMORY\n");
+	dev_err(&pi->dev, "ERROR COULDN'T ALLOCATE MEMORY\n");
 	return -1;
 }
 
diff --git a/drivers/ata/pata_parport/comm.c b/drivers/ata/pata_parport/comm.c
index 88476072b708..7b59eca52185 100644
--- a/drivers/ata/pata_parport/comm.c
+++ b/drivers/ata/pata_parport/comm.c
@@ -183,8 +183,8 @@ static void comm_log_adapter(struct pi_adapter *pi)
 
 {       char    *mode_string[5] = {"4-bit","8-bit","EPP-8","EPP-16","EPP-32"};
 
-	printk("comm %s, DataStor Commuter at 0x%x, ", COMM_VERSION, pi->port);
-        printk("mode %d (%s), delay %d\n",pi->mode,
+	dev_info(&pi->dev, "comm %s, DataStor Commuter at 0x%x, ", COMM_VERSION, pi->port);
+	dev_info(&pi->dev, "mode %d (%s), delay %d\n", pi->mode,
 		mode_string[pi->mode],pi->delay);
 
 }
diff --git a/drivers/ata/pata_parport/dstr.c b/drivers/ata/pata_parport/dstr.c
index a8b238828061..eb6ddceaeb83 100644
--- a/drivers/ata/pata_parport/dstr.c
+++ b/drivers/ata/pata_parport/dstr.c
@@ -195,8 +195,8 @@ static void dstr_log_adapter(struct pi_adapter *pi)
 {       char    *mode_string[5] = {"4-bit","8-bit","EPP-8",
 				   "EPP-16","EPP-32"};
 
-	printk("dstr %s, DataStor EP2000 at 0x%x, ", DSTR_VERSION, pi->port);
-        printk("mode %d (%s), delay %d\n",pi->mode,
+	dev_info(&pi->dev, "dstr %s, DataStor EP2000 at 0x%x, ", DSTR_VERSION, pi->port);
+	dev_info(&pi->dev, "mode %d (%s), delay %d\n", pi->mode,
 		mode_string[pi->mode],pi->delay);
 
 }
diff --git a/drivers/ata/pata_parport/epat.c b/drivers/ata/pata_parport/epat.c
index a30313a2c3d7..389faa6ae49d 100644
--- a/drivers/ata/pata_parport/epat.c
+++ b/drivers/ata/pata_parport/epat.c
@@ -279,10 +279,8 @@ static int epat_test_proto(struct pi_adapter *pi, char *scratch, int verbose)
         }
         epat_disconnect(pi);
 
-        if (verbose)  {
-		printk("epat: port 0x%x, mode %d, ccr %x, test=(%d,%d,%d)\n",
-		       pi->port, pi->mode, cc, e[0], e[1], f);
-	}
+	dev_dbg(&pi->dev, "epat: port 0x%x, mode %d, ccr %x, test=(%d,%d,%d)\n",
+	       pi->port, pi->mode, cc, e[0], e[1], f);
 	
         return (e[0] && e[1]) || f;
 }
@@ -298,9 +296,9 @@ static void epat_log_adapter(struct pi_adapter *pi)
         ver = RR(0xb);
         epat_disconnect(pi);
 
-	printk("epat %s, Shuttle EPAT chip %x at 0x%x, ",
+	dev_info(&pi->dev, "epat %s, Shuttle EPAT chip %x at 0x%x, ",
 		EPAT_VERSION, ver, pi->port);
-	printk("mode %d (%s), delay %d\n",pi->mode,
+	dev_info(&pi->dev, "mode %d (%s), delay %d\n", pi->mode,
 		mode_string[pi->mode],pi->delay);
 
 }
diff --git a/drivers/ata/pata_parport/epia.c b/drivers/ata/pata_parport/epia.c
index ece7862dc058..48d12f56c501 100644
--- a/drivers/ata/pata_parport/epia.c
+++ b/drivers/ata/pata_parport/epia.c
@@ -262,10 +262,8 @@ static int epia_test_proto(struct pi_adapter *pi, char *scratch, int verbose)
         WR(0x84,0);
         epia_disconnect(pi);
 
-        if (verbose)  {
-		printk("epia: port 0x%x, mode %d, test=(%d,%d,%d)\n",
-		       pi->port, pi->mode, e[0], e[1], f);
-        }
+	dev_dbg(&pi->dev, "epia: port 0x%x, mode %d, test=(%d,%d,%d)\n",
+	       pi->port, pi->mode, e[0], e[1], f);
         
         return (e[0] && e[1]) || f;
 
@@ -277,8 +275,8 @@ static void epia_log_adapter(struct pi_adapter *pi)
 {       char    *mode_string[6] = {"4-bit","5/3","8-bit",
 				   "EPP-8","EPP-16","EPP-32"};
 
-	printk("epia %s, Shuttle EPIA at 0x%x, ", EPIA_VERSION, pi->port);
-        printk("mode %d (%s), delay %d\n",pi->mode,
+	dev_info(&pi->dev, "epia %s, Shuttle EPIA at 0x%x, ", EPIA_VERSION, pi->port);
+	dev_info(&pi->dev, "mode %d (%s), delay %d\n", pi->mode,
 		mode_string[pi->mode],pi->delay);
 
 }
diff --git a/drivers/ata/pata_parport/fit2.c b/drivers/ata/pata_parport/fit2.c
index 056e92d8e015..d0a781f04411 100644
--- a/drivers/ata/pata_parport/fit2.c
+++ b/drivers/ata/pata_parport/fit2.c
@@ -116,7 +116,7 @@ static void fit2_disconnect(struct pi_adapter *pi)
 static void fit2_log_adapter(struct pi_adapter *pi)
 
 {
-	printk("fit2 %s, FIT 2000 adapter at 0x%x, delay %d\n",
+	dev_info(&pi->dev, "fit2 %s, FIT 2000 adapter at 0x%x, delay %d\n",
 		FIT2_VERSION, pi->port, pi->delay);
 
 }
diff --git a/drivers/ata/pata_parport/fit3.c b/drivers/ata/pata_parport/fit3.c
index fa37f7f17fb2..f86da2d478cb 100644
--- a/drivers/ata/pata_parport/fit3.c
+++ b/drivers/ata/pata_parport/fit3.c
@@ -173,7 +173,7 @@ static void fit3_log_adapter(struct pi_adapter *pi)
 
 {       char    *mode_string[3] = {"4-bit","8-bit","EPP"};
 
-	printk("fit3 %s, FIT 3000 adapter at 0x%x, "
+	dev_info(&pi->dev, "fit3 %s, FIT 3000 adapter at 0x%x, "
 	       "mode %d (%s), delay %d\n",
 		FIT3_VERSION, pi->port,
 		pi->mode,mode_string[pi->mode],pi->delay);
diff --git a/drivers/ata/pata_parport/friq.c b/drivers/ata/pata_parport/friq.c
index bf597ee520b7..ec564e7cb930 100644
--- a/drivers/ata/pata_parport/friq.c
+++ b/drivers/ata/pata_parport/friq.c
@@ -207,10 +207,8 @@ static int friq_test_proto(struct pi_adapter *pi, char *scratch, int verbose)
         for (k=0;k<128;k++) if (scratch[k] != k) r++;
 	friq_disconnect(pi);
 
-        if (verbose)  {
-		printk("friq: port 0x%x, mode %d, test=(%d,%d,%d)\n",
-		       pi->port, pi->mode, e[0], e[1], r);
-        }
+	dev_dbg(&pi->dev, "friq: port 0x%x, mode %d, test=(%d,%d,%d)\n",
+	       pi->port, pi->mode, e[0], e[1], r);
 
         return (r || (e[0] && e[1]));
 }
@@ -221,9 +219,9 @@ static void friq_log_adapter(struct pi_adapter *pi)
 {       char    *mode_string[6] = {"4-bit","8-bit",
 				   "EPP-8","EPP-16","EPP-32"};
 
-	printk("friq %s, Freecom IQ ASIC-2 adapter at 0x%x, ",
+	dev_info(&pi->dev, "friq %s, Freecom IQ ASIC-2 adapter at 0x%x, ",
 		FRIQ_VERSION,pi->port);
-        printk("mode %d (%s), delay %d\n",pi->mode,
+	dev_info(&pi->dev, "mode %d (%s), delay %d\n", pi->mode,
 		mode_string[pi->mode],pi->delay);
 
 	pi->private = 1;
diff --git a/drivers/ata/pata_parport/frpw.c b/drivers/ata/pata_parport/frpw.c
index 9b8db1122154..5ea16a247257 100644
--- a/drivers/ata/pata_parport/frpw.c
+++ b/drivers/ata/pata_parport/frpw.c
@@ -230,14 +230,12 @@ static int frpw_test_proto(struct pi_adapter *pi, char *scratch, int verbose)
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
 
@@ -258,10 +256,8 @@ static int frpw_test_proto(struct pi_adapter *pi, char *scratch, int verbose)
         for (k=0;k<128;k++) if (scratch[k] != k) r++;
 	frpw_disconnect(pi);
 
-        if (verbose)  {
-		printk("frpw: port 0x%x, chip %ld, mode %d, test=(%d,%d,%d)\n",
-		       pi->port, (pi->private%2), pi->mode, e[0], e[1], r);
-        }
+	dev_dbg(&pi->dev, "frpw: port 0x%x, chip %ld, mode %d, test=(%d,%d,%d)\n",
+	       pi->port, (pi->private%2), pi->mode, e[0], e[1], r);
 
         return (r || (e[0] && e[1]));
 }
@@ -272,9 +268,9 @@ static void frpw_log_adapter(struct pi_adapter *pi)
 {       char    *mode_string[6] = {"4-bit","8-bit","EPP",
 				   "EPP-8","EPP-16","EPP-32"};
 
-	printk("frpw %s, Freecom (%s) adapter at 0x%x, ",
+	dev_info(&pi->dev, "frpw %s, Freecom (%s) adapter at 0x%x, ",
 		FRPW_VERSION,((pi->private%2) == 0)?"Xilinx":"ASIC",pi->port);
-        printk("mode %d (%s), delay %d\n",pi->mode,
+	dev_info(&pi->dev, "mode %d (%s), delay %d\n", pi->mode,
 		mode_string[pi->mode],pi->delay);
 
 }
diff --git a/drivers/ata/pata_parport/kbic.c b/drivers/ata/pata_parport/kbic.c
index b23632c1da39..ea1b931ce20d 100644
--- a/drivers/ata/pata_parport/kbic.c
+++ b/drivers/ata/pata_parport/kbic.c
@@ -234,8 +234,8 @@ static void kbic_log_adapter(struct pi_adapter *pi, char *chip)
 {       char    *mode_string[6] = {"4-bit","5/3","8-bit",
 				   "EPP-8","EPP_16","EPP-32"};
 
-	printk("kbic %s, KingByte %s at 0x%x, ", KBIC_VERSION, chip, pi->port);
-        printk("mode %d (%s), delay %d\n",pi->mode,
+	dev_info(&pi->dev, "kbic %s, KingByte %s at 0x%x, ", KBIC_VERSION, chip, pi->port);
+	dev_info(&pi->dev, "mode %d (%s), delay %d\n", pi->mode,
 		mode_string[pi->mode],pi->delay);
 
 }
diff --git a/drivers/ata/pata_parport/ktti.c b/drivers/ata/pata_parport/ktti.c
index 62b0692d1b94..b22c283709de 100644
--- a/drivers/ata/pata_parport/ktti.c
+++ b/drivers/ata/pata_parport/ktti.c
@@ -93,7 +93,7 @@ static void ktti_disconnect(struct pi_adapter *pi)
 static void ktti_log_adapter(struct pi_adapter *pi)
 
 {
-	printk("ktti %s, KT adapter at 0x%x, delay %d\n",
+	dev_info(&pi->dev, "ktti %s, KT adapter at 0x%x, delay %d\n",
 		KTTI_VERSION, pi->port, pi->delay);
 
 }
diff --git a/drivers/ata/pata_parport/on20.c b/drivers/ata/pata_parport/on20.c
index a3b0708aed71..c76d4fb84c61 100644
--- a/drivers/ata/pata_parport/on20.c
+++ b/drivers/ata/pata_parport/on20.c
@@ -115,8 +115,8 @@ static void on20_log_adapter(struct pi_adapter *pi)
 
 {       char    *mode_string[2] = {"4-bit","8-bit"};
 
-	printk("on20 %s, OnSpec 90c20 at 0x%x, ", ON20_VERSION, pi->port);
-        printk("mode %d (%s), delay %d\n",pi->mode,
+	dev_info(&pi->dev, "on20 %s, OnSpec 90c20 at 0x%x, ", ON20_VERSION, pi->port);
+	dev_info(&pi->dev, "mode %d (%s), delay %d\n", pi->mode,
 		mode_string[pi->mode],pi->delay);
 
 }
diff --git a/drivers/ata/pata_parport/on26.c b/drivers/ata/pata_parport/on26.c
index 8dc8296d50e6..5406e76ea727 100644
--- a/drivers/ata/pata_parport/on26.c
+++ b/drivers/ata/pata_parport/on26.c
@@ -167,7 +167,7 @@ static int on26_test_port(struct pi_adapter *pi)  /* hard reset */
             }
 
 	    if (i == RESET_WAIT) 
-		printk("on26: Device reset failed (%x,%x)\n",x,y);
+		dev_err(&pi->dev, "on26: Device reset failed (%x,%x)\n", x, y);
 
             w0(4); P1; w0(4); P1;
         }
@@ -280,8 +280,8 @@ static void on26_log_adapter(struct pi_adapter *pi)
 {       char    *mode_string[5] = {"4-bit","8-bit","EPP-8",
 				   "EPP-16","EPP-32"};
 
-	printk("on26 %s, OnSpec 90c26 at 0x%x, ", ON26_VERSION, pi->port);
-        printk("mode %d (%s), delay %d\n",pi->mode,
+	dev_info(&pi->dev, "on26 %s, OnSpec 90c26 at 0x%x, ", ON26_VERSION, pi->port);
+	dev_info(&pi->dev, "mode %d (%s), delay %d\n", pi->mode,
 		mode_string[pi->mode],pi->delay);
 
 }
-- 
Ondrej Zary

