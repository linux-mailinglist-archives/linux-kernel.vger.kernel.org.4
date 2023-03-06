Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5525C6ACB77
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 18:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjCFRyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 12:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjCFRyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 12:54:24 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5FCA43D93D;
        Mon,  6 Mar 2023 09:53:56 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 472487A06F8;
        Mon,  6 Mar 2023 18:28:29 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/18] pata_parport: remove scratch parameter from log_adapter()
Date:   Mon,  6 Mar 2023 18:27:44 +0100
Message-Id: <20230306172752.7727-11-linux@zary.sk>
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

scratch parameter of log_adapter() is only used by bpck driver.
Remove it.

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/aten.c         |  2 +-
 drivers/ata/pata_parport/bpck.c         |  4 ++--
 drivers/ata/pata_parport/bpck6.c        |  2 +-
 drivers/ata/pata_parport/comm.c         |  2 +-
 drivers/ata/pata_parport/dstr.c         |  2 +-
 drivers/ata/pata_parport/epat.c         |  2 +-
 drivers/ata/pata_parport/epia.c         |  2 +-
 drivers/ata/pata_parport/fit2.c         |  2 +-
 drivers/ata/pata_parport/fit3.c         |  2 +-
 drivers/ata/pata_parport/friq.c         |  2 +-
 drivers/ata/pata_parport/frpw.c         |  2 +-
 drivers/ata/pata_parport/kbic.c         | 10 +++++-----
 drivers/ata/pata_parport/ktti.c         |  2 +-
 drivers/ata/pata_parport/on20.c         |  2 +-
 drivers/ata/pata_parport/on26.c         |  2 +-
 drivers/ata/pata_parport/pata_parport.c |  2 +-
 include/linux/pata_parport.h            |  2 +-
 17 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/ata/pata_parport/aten.c b/drivers/ata/pata_parport/aten.c
index 0a98954f380f..3f5c50c2c43a 100644
--- a/drivers/ata/pata_parport/aten.c
+++ b/drivers/ata/pata_parport/aten.c
@@ -120,7 +120,7 @@ static void aten_disconnect(struct pi_adapter *pi)
         w2(pi->saved_r2);
 } 
 
-static void aten_log_adapter(struct pi_adapter *pi, char *scratch)
+static void aten_log_adapter(struct pi_adapter *pi)
 
 {       char    *mode_string[2] = {"4-bit","8-bit"};
 
diff --git a/drivers/ata/pata_parport/bpck.c b/drivers/ata/pata_parport/bpck.c
index 1a3e3d5b1b25..f475a25769f0 100644
--- a/drivers/ata/pata_parport/bpck.c
+++ b/drivers/ata/pata_parport/bpck.c
@@ -416,11 +416,11 @@ static int bpck_test_port(struct pi_adapter *pi)	/* check for 8-bit port */
 	return 5;
 }
 
-static void bpck_log_adapter(struct pi_adapter *pi, char *scratch)
+static void bpck_log_adapter(struct pi_adapter *pi)
 
 {	char	*mode_string[5] = { "4-bit","8-bit","EPP-8",
 				    "EPP-16","EPP-32" };
-
+	char scratch[128];
 #ifdef DUMP_EEPROM
 	int i;
 #endif
diff --git a/drivers/ata/pata_parport/bpck6.c b/drivers/ata/pata_parport/bpck6.c
index 68f7fdcab9be..41395a97d77c 100644
--- a/drivers/ata/pata_parport/bpck6.c
+++ b/drivers/ata/pata_parport/bpck6.c
@@ -195,7 +195,7 @@ static int bpck6_probe_unit(struct pi_adapter *pi)
   	}
 }
 
-static void bpck6_log_adapter(struct pi_adapter *pi, char *scratch)
+static void bpck6_log_adapter(struct pi_adapter *pi)
 {
 	char *mode_string[5]=
 		{"4-bit","8-bit","EPP-8","EPP-16","EPP-32"};
diff --git a/drivers/ata/pata_parport/comm.c b/drivers/ata/pata_parport/comm.c
index 69a66658aa29..88476072b708 100644
--- a/drivers/ata/pata_parport/comm.c
+++ b/drivers/ata/pata_parport/comm.c
@@ -179,7 +179,7 @@ static void comm_write_block(struct pi_adapter *pi, char *buf, int count)
         }
 }
 
-static void comm_log_adapter(struct pi_adapter *pi, char *scratch)
+static void comm_log_adapter(struct pi_adapter *pi)
 
 {       char    *mode_string[5] = {"4-bit","8-bit","EPP-8","EPP-16","EPP-32"};
 
diff --git a/drivers/ata/pata_parport/dstr.c b/drivers/ata/pata_parport/dstr.c
index 17b1a7cb0a15..a8b238828061 100644
--- a/drivers/ata/pata_parport/dstr.c
+++ b/drivers/ata/pata_parport/dstr.c
@@ -190,7 +190,7 @@ static void dstr_write_block(struct pi_adapter *pi, char *buf, int count)
 }
 
 
-static void dstr_log_adapter(struct pi_adapter *pi, char *scratch)
+static void dstr_log_adapter(struct pi_adapter *pi)
 
 {       char    *mode_string[5] = {"4-bit","8-bit","EPP-8",
 				   "EPP-16","EPP-32"};
diff --git a/drivers/ata/pata_parport/epat.c b/drivers/ata/pata_parport/epat.c
index b125df16f160..a30313a2c3d7 100644
--- a/drivers/ata/pata_parport/epat.c
+++ b/drivers/ata/pata_parport/epat.c
@@ -287,7 +287,7 @@ static int epat_test_proto(struct pi_adapter *pi, char *scratch, int verbose)
         return (e[0] && e[1]) || f;
 }
 
-static void epat_log_adapter(struct pi_adapter *pi, char *scratch)
+static void epat_log_adapter(struct pi_adapter *pi)
 
 {	int	ver;
         char    *mode_string[6] = 
diff --git a/drivers/ata/pata_parport/epia.c b/drivers/ata/pata_parport/epia.c
index 452d3a8e17af..ece7862dc058 100644
--- a/drivers/ata/pata_parport/epia.c
+++ b/drivers/ata/pata_parport/epia.c
@@ -272,7 +272,7 @@ static int epia_test_proto(struct pi_adapter *pi, char *scratch, int verbose)
 }
 
 
-static void epia_log_adapter(struct pi_adapter *pi, char *scratch)
+static void epia_log_adapter(struct pi_adapter *pi)
 
 {       char    *mode_string[6] = {"4-bit","5/3","8-bit",
 				   "EPP-8","EPP-16","EPP-32"};
diff --git a/drivers/ata/pata_parport/fit2.c b/drivers/ata/pata_parport/fit2.c
index 632c51af84d7..056e92d8e015 100644
--- a/drivers/ata/pata_parport/fit2.c
+++ b/drivers/ata/pata_parport/fit2.c
@@ -113,7 +113,7 @@ static void fit2_disconnect(struct pi_adapter *pi)
         w2(pi->saved_r2);
 } 
 
-static void fit2_log_adapter(struct pi_adapter *pi, char *scratch)
+static void fit2_log_adapter(struct pi_adapter *pi)
 
 {
 	printk("fit2 %s, FIT 2000 adapter at 0x%x, delay %d\n",
diff --git a/drivers/ata/pata_parport/fit3.c b/drivers/ata/pata_parport/fit3.c
index bdf90cb536c2..fa37f7f17fb2 100644
--- a/drivers/ata/pata_parport/fit3.c
+++ b/drivers/ata/pata_parport/fit3.c
@@ -169,7 +169,7 @@ static void fit3_disconnect(struct pi_adapter *pi)
         w2(pi->saved_r2);
 } 
 
-static void fit3_log_adapter(struct pi_adapter *pi, char *scratch)
+static void fit3_log_adapter(struct pi_adapter *pi)
 
 {       char    *mode_string[3] = {"4-bit","8-bit","EPP"};
 
diff --git a/drivers/ata/pata_parport/friq.c b/drivers/ata/pata_parport/friq.c
index ee922b40bc95..bf597ee520b7 100644
--- a/drivers/ata/pata_parport/friq.c
+++ b/drivers/ata/pata_parport/friq.c
@@ -216,7 +216,7 @@ static int friq_test_proto(struct pi_adapter *pi, char *scratch, int verbose)
 }
 
 
-static void friq_log_adapter(struct pi_adapter *pi, char *scratch)
+static void friq_log_adapter(struct pi_adapter *pi)
 
 {       char    *mode_string[6] = {"4-bit","8-bit",
 				   "EPP-8","EPP-16","EPP-32"};
diff --git a/drivers/ata/pata_parport/frpw.c b/drivers/ata/pata_parport/frpw.c
index f17e0a4f66c2..9b8db1122154 100644
--- a/drivers/ata/pata_parport/frpw.c
+++ b/drivers/ata/pata_parport/frpw.c
@@ -267,7 +267,7 @@ static int frpw_test_proto(struct pi_adapter *pi, char *scratch, int verbose)
 }
 
 
-static void frpw_log_adapter(struct pi_adapter *pi, char *scratch)
+static void frpw_log_adapter(struct pi_adapter *pi)
 
 {       char    *mode_string[6] = {"4-bit","8-bit","EPP",
 				   "EPP-8","EPP-16","EPP-32"};
diff --git a/drivers/ata/pata_parport/kbic.c b/drivers/ata/pata_parport/kbic.c
index 3718441f60aa..b23632c1da39 100644
--- a/drivers/ata/pata_parport/kbic.c
+++ b/drivers/ata/pata_parport/kbic.c
@@ -229,7 +229,7 @@ static void kbic_write_block(struct pi_adapter *pi, char *buf, int count)
 
 }
 
-static void kbic_log_adapter(struct pi_adapter *pi, char *scratch, char *chip)
+static void kbic_log_adapter(struct pi_adapter *pi, char *chip)
 
 {       char    *mode_string[6] = {"4-bit","5/3","8-bit",
 				   "EPP-8","EPP_16","EPP-32"};
@@ -240,14 +240,14 @@ static void kbic_log_adapter(struct pi_adapter *pi, char *scratch, char *chip)
 
 }
 
-static void k951_log_adapter(struct pi_adapter *pi, char *scratch)
+static void k951_log_adapter(struct pi_adapter *pi)
 {
-	kbic_log_adapter(pi, scratch, "KBIC-951A");
+	kbic_log_adapter(pi, "KBIC-951A");
 }
 
-static void k971_log_adapter(struct pi_adapter *pi, char *scratch)
+static void k971_log_adapter(struct pi_adapter *pi)
 {
-	kbic_log_adapter(pi, scratch, "KBIC-971A");
+	kbic_log_adapter(pi, "KBIC-971A");
 }
 
 static struct pi_protocol k951 = {
diff --git a/drivers/ata/pata_parport/ktti.c b/drivers/ata/pata_parport/ktti.c
index ad7f0314f962..62b0692d1b94 100644
--- a/drivers/ata/pata_parport/ktti.c
+++ b/drivers/ata/pata_parport/ktti.c
@@ -90,7 +90,7 @@ static void ktti_disconnect(struct pi_adapter *pi)
         w2(pi->saved_r2);
 } 
 
-static void ktti_log_adapter(struct pi_adapter *pi, char *scratch)
+static void ktti_log_adapter(struct pi_adapter *pi)
 
 {
 	printk("ktti %s, KT adapter at 0x%x, delay %d\n",
diff --git a/drivers/ata/pata_parport/on20.c b/drivers/ata/pata_parport/on20.c
index 12a423f61996..a3b0708aed71 100644
--- a/drivers/ata/pata_parport/on20.c
+++ b/drivers/ata/pata_parport/on20.c
@@ -111,7 +111,7 @@ static void on20_write_block(struct pi_adapter *pi, char *buf, int count)
 	w2(4);
 }
 
-static void on20_log_adapter(struct pi_adapter *pi, char *scratch)
+static void on20_log_adapter(struct pi_adapter *pi)
 
 {       char    *mode_string[2] = {"4-bit","8-bit"};
 
diff --git a/drivers/ata/pata_parport/on26.c b/drivers/ata/pata_parport/on26.c
index ee5a0cc74900..8dc8296d50e6 100644
--- a/drivers/ata/pata_parport/on26.c
+++ b/drivers/ata/pata_parport/on26.c
@@ -275,7 +275,7 @@ static void on26_write_block(struct pi_adapter *pi, char *buf, int count)
 
 }
 
-static void on26_log_adapter(struct pi_adapter *pi, char *scratch)
+static void on26_log_adapter(struct pi_adapter *pi)
 
 {       char    *mode_string[5] = {"4-bit","8-bit","EPP-8",
 				   "EPP-16","EPP-32"};
diff --git a/drivers/ata/pata_parport/pata_parport.c b/drivers/ata/pata_parport/pata_parport.c
index 5aa0f05590fb..f42a2cafc382 100644
--- a/drivers/ata/pata_parport/pata_parport.c
+++ b/drivers/ata/pata_parport/pata_parport.c
@@ -474,7 +474,7 @@ static struct pi_adapter *pi_init_one(struct parport *parport,
 		goto out_unreg_parport;
 	}
 
-	pi->proto->log_adapter(pi, scratch);
+	pi->proto->log_adapter(pi);
 
 	host = ata_host_alloc_pinfo(&pi->pardev->dev, ppi, 1);
 	if (!host)
diff --git a/include/linux/pata_parport.h b/include/linux/pata_parport.h
index 033cabede51c..c44d30b3e886 100644
--- a/include/linux/pata_parport.h
+++ b/include/linux/pata_parport.h
@@ -68,7 +68,7 @@ struct pi_protocol {
 	int (*test_port)(struct pi_adapter *pi);
 	int (*probe_unit)(struct pi_adapter *pi);
 	int (*test_proto)(struct pi_adapter *pi, char *scratch, int verbose);
-	void (*log_adapter)(struct pi_adapter *pi, char *scratch);
+	void (*log_adapter)(struct pi_adapter *pi);
 
 	int (*init_proto)(struct pi_adapter *pi);
 	void (*release_proto)(struct pi_adapter *pi);
-- 
Ondrej Zary

