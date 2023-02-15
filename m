Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E232F6984C1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 20:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjBOTqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 14:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjBOTqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 14:46:19 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C98F4109F;
        Wed, 15 Feb 2023 11:46:11 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 9F2357A0708;
        Wed, 15 Feb 2023 20:46:05 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/18] pata_parport: use print_hex_*
Date:   Wed, 15 Feb 2023 20:45:48 +0100
Message-Id: <20230215194554.25632-13-linux@zary.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230215194554.25632-1-linux@zary.sk>
References: <20230215194554.25632-1-linux@zary.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use print_hex_* for debug dumps.

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/bpck.c | 22 ++++------------------
 drivers/ata/pata_parport/epat.c |  2 +-
 drivers/ata/pata_parport/epia.c |  2 +-
 drivers/ata/pata_parport/friq.c |  2 +-
 drivers/ata/pata_parport/frpw.c |  2 +-
 5 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/ata/pata_parport/bpck.c b/drivers/ata/pata_parport/bpck.c
index 1cba098b4b82..dec24983d140 100644
--- a/drivers/ata/pata_parport/bpck.c
+++ b/drivers/ata/pata_parport/bpck.c
@@ -334,12 +334,9 @@ static int bpck_test_proto(struct pi_adapter *pi, char *scratch, int verbose)
 
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
@@ -421,20 +418,9 @@ static void bpck_log_adapter(struct pi_adapter *pi)
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
+	print_hex_dump_bytes("bpck EEPROM: ", DUMP_PREFIX_NONE, scratch, 128);
 	dev_info(&pi->dev, "bpck %s, backpack %8.8s unit %d",
 		BPCK_VERSION, &scratch[110], pi->unit);
 	dev_info(&pi->dev, " at 0x%x, mode %d (%s), delay %d\n", pi->port,
diff --git a/drivers/ata/pata_parport/epat.c b/drivers/ata/pata_parport/epat.c
index 389faa6ae49d..b08ed2f86668 100644
--- a/drivers/ata/pata_parport/epat.c
+++ b/drivers/ata/pata_parport/epat.c
@@ -280,7 +280,7 @@ static int epat_test_proto(struct pi_adapter *pi, char *scratch, int verbose)
         epat_disconnect(pi);
 
 	dev_dbg(&pi->dev, "epat: port 0x%x, mode %d, ccr %x, test=(%d,%d,%d)\n",
-	       pi->port, pi->mode, cc, e[0], e[1], f);
+		pi->port, pi->mode, cc, e[0], e[1], f);
 	
         return (e[0] && e[1]) || f;
 }
diff --git a/drivers/ata/pata_parport/epia.c b/drivers/ata/pata_parport/epia.c
index 48d12f56c501..32bec3449338 100644
--- a/drivers/ata/pata_parport/epia.c
+++ b/drivers/ata/pata_parport/epia.c
@@ -263,7 +263,7 @@ static int epia_test_proto(struct pi_adapter *pi, char *scratch, int verbose)
         epia_disconnect(pi);
 
 	dev_dbg(&pi->dev, "epia: port 0x%x, mode %d, test=(%d,%d,%d)\n",
-	       pi->port, pi->mode, e[0], e[1], f);
+		pi->port, pi->mode, e[0], e[1], f);
         
         return (e[0] && e[1]) || f;
 
diff --git a/drivers/ata/pata_parport/friq.c b/drivers/ata/pata_parport/friq.c
index ec564e7cb930..9e3ec64896f2 100644
--- a/drivers/ata/pata_parport/friq.c
+++ b/drivers/ata/pata_parport/friq.c
@@ -208,7 +208,7 @@ static int friq_test_proto(struct pi_adapter *pi, char *scratch, int verbose)
 	friq_disconnect(pi);
 
 	dev_dbg(&pi->dev, "friq: port 0x%x, mode %d, test=(%d,%d,%d)\n",
-	       pi->port, pi->mode, e[0], e[1], r);
+		pi->port, pi->mode, e[0], e[1], r);
 
         return (r || (e[0] && e[1]));
 }
diff --git a/drivers/ata/pata_parport/frpw.c b/drivers/ata/pata_parport/frpw.c
index 5ea16a247257..c12c8aa9707c 100644
--- a/drivers/ata/pata_parport/frpw.c
+++ b/drivers/ata/pata_parport/frpw.c
@@ -257,7 +257,7 @@ static int frpw_test_proto(struct pi_adapter *pi, char *scratch, int verbose)
 	frpw_disconnect(pi);
 
 	dev_dbg(&pi->dev, "frpw: port 0x%x, chip %ld, mode %d, test=(%d,%d,%d)\n",
-	       pi->port, (pi->private%2), pi->mode, e[0], e[1], r);
+		pi->port, (pi->private%2), pi->mode, e[0], e[1], r);
 
         return (r || (e[0] && e[1]));
 }
-- 
Ondrej Zary

