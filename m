Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786B06ACB79
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 18:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjCFRym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 12:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjCFRyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 12:54:25 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5FF69460A0;
        Mon,  6 Mar 2023 09:53:57 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 020B47A0738;
        Mon,  6 Mar 2023 18:28:30 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 16/18] pata_parport: remove scratch parameter from test_proto()
Date:   Mon,  6 Mar 2023 18:27:50 +0100
Message-Id: <20230306172752.7727-17-linux@zary.sk>
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

Don't pass around a pointer to scratch buffer. Use local buffers in
protocols that need it.

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/bpck.c         |  2 +-
 drivers/ata/pata_parport/epat.c         |  3 ++-
 drivers/ata/pata_parport/epia.c         |  3 ++-
 drivers/ata/pata_parport/friq.c         |  3 ++-
 drivers/ata/pata_parport/frpw.c         |  3 ++-
 drivers/ata/pata_parport/pata_parport.c | 23 +++++++++++------------
 include/linux/pata_parport.h            |  2 +-
 7 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/ata/pata_parport/bpck.c b/drivers/ata/pata_parport/bpck.c
index 2072e291fd16..ecb98bf0e6de 100644
--- a/drivers/ata/pata_parport/bpck.c
+++ b/drivers/ata/pata_parport/bpck.c
@@ -274,7 +274,7 @@ static void bpck_force_spp(struct pi_adapter *pi)
 
 #define TEST_LEN  16
 
-static int bpck_test_proto(struct pi_adapter *pi, char *scratch)
+static int bpck_test_proto(struct pi_adapter *pi)
 
 {	int i, e, l, h, om;
 	char buf[TEST_LEN];
diff --git a/drivers/ata/pata_parport/epat.c b/drivers/ata/pata_parport/epat.c
index 4877b39ed04c..609614b2c69e 100644
--- a/drivers/ata/pata_parport/epat.c
+++ b/drivers/ata/pata_parport/epat.c
@@ -246,10 +246,11 @@ static void epat_disconnect(struct pi_adapter *pi)
 	w2(pi->saved_r2);
 }
 
-static int epat_test_proto(struct pi_adapter *pi, char *scratch)
+static int epat_test_proto(struct pi_adapter *pi)
 
 {       int     k, j, f, cc;
 	int	e[2] = {0,0};
+	char scratch[512];
 
         epat_connect(pi);
 	cc = RR(0xd);
diff --git a/drivers/ata/pata_parport/epia.c b/drivers/ata/pata_parport/epia.c
index e7401351463a..970532619aeb 100644
--- a/drivers/ata/pata_parport/epia.c
+++ b/drivers/ata/pata_parport/epia.c
@@ -232,10 +232,11 @@ static void epia_write_block(struct pi_adapter *pi, char *buf, int count)
 
 }
 
-static int epia_test_proto(struct pi_adapter *pi, char *scratch)
+static int epia_test_proto(struct pi_adapter *pi)
 
 {       int     j, k, f;
 	int	e[2] = {0,0};
+	char scratch[512];
 
         epia_connect(pi);
         for (j=0;j<2;j++) {
diff --git a/drivers/ata/pata_parport/friq.c b/drivers/ata/pata_parport/friq.c
index df15b210f355..1888e8bcb884 100644
--- a/drivers/ata/pata_parport/friq.c
+++ b/drivers/ata/pata_parport/friq.c
@@ -178,10 +178,11 @@ static void friq_disconnect(struct pi_adapter *pi)
         w2(pi->saved_r2);
 } 
 
-static int friq_test_proto(struct pi_adapter *pi, char *scratch)
+static int friq_test_proto(struct pi_adapter *pi)
 
 {       int     j, k, r;
 	int	e[2] = {0,0};
+	char scratch[512];
 
 	pi->saved_r0 = r0();	
 	w0(0xff); udelay(20); CMD(0x3d); /* turn the power on */
diff --git a/drivers/ata/pata_parport/frpw.c b/drivers/ata/pata_parport/frpw.c
index 0d4e84806350..484b5b9d31eb 100644
--- a/drivers/ata/pata_parport/frpw.c
+++ b/drivers/ata/pata_parport/frpw.c
@@ -219,10 +219,11 @@ static int frpw_test_pnp(struct pi_adapter *pi)
    a hack :-(
 */
 
-static int frpw_test_proto(struct pi_adapter *pi, char *scratch)
+static int frpw_test_proto(struct pi_adapter *pi)
 
 {       int     j, k, r;
 	int	e[2] = {0,0};
+	char scratch[512];
 
 	if ((pi->private>>1) != pi->port)
 	   pi->private = frpw_test_pnp(pi) + 2*pi->port;
diff --git a/drivers/ata/pata_parport/pata_parport.c b/drivers/ata/pata_parport/pata_parport.c
index 27aa2419af02..77a3e5a3f062 100644
--- a/drivers/ata/pata_parport/pata_parport.c
+++ b/drivers/ata/pata_parport/pata_parport.c
@@ -276,7 +276,7 @@ static void pi_release(struct pi_adapter *pi)
 	module_put(pi->proto->owner);
 }
 
-static int default_test_proto(struct pi_adapter *pi, char *scratch)
+static int default_test_proto(struct pi_adapter *pi)
 {
 	int j, k;
 	int e[2] = { 0, 0 };
@@ -300,21 +300,21 @@ static int default_test_proto(struct pi_adapter *pi, char *scratch)
 	return e[0] && e[1];	/* not here if both > 0 */
 }
 
-static int pi_test_proto(struct pi_adapter *pi, char *scratch)
+static int pi_test_proto(struct pi_adapter *pi)
 {
 	int res;
 
 	parport_claim_or_block(pi->pardev);
 	if (pi->proto->test_proto)
-		res = pi->proto->test_proto(pi, scratch);
+		res = pi->proto->test_proto(pi);
 	else
-		res = default_test_proto(pi, scratch);
+		res = default_test_proto(pi);
 	parport_release(pi->pardev);
 
 	return res;
 }
 
-static bool pi_probe_mode(struct pi_adapter *pi, int max, char *scratch)
+static bool pi_probe_mode(struct pi_adapter *pi, int max)
 {
 	int best, range;
 
@@ -326,7 +326,7 @@ static bool pi_probe_mode(struct pi_adapter *pi, int max, char *scratch)
 			range = 8;
 		if (range == 8 && pi->port % 8)
 			return false;
-		return !pi_test_proto(pi, scratch);
+		return !pi_test_proto(pi);
 	}
 	best = -1;
 	for (pi->mode = 0; pi->mode < max; pi->mode++) {
@@ -335,14 +335,14 @@ static bool pi_probe_mode(struct pi_adapter *pi, int max, char *scratch)
 			range = 8;
 		if (range == 8 && pi->port % 8)
 			break;
-		if (!pi_test_proto(pi, scratch))
+		if (!pi_test_proto(pi))
 			best = pi->mode;
 	}
 	pi->mode = best;
 	return best > -1;
 }
 
-static bool pi_probe_unit(struct pi_adapter *pi, int unit, char *scratch)
+static bool pi_probe_unit(struct pi_adapter *pi, int unit)
 {
 	int max, s, e;
 
@@ -367,14 +367,14 @@ static bool pi_probe_unit(struct pi_adapter *pi, int unit, char *scratch)
 		for (pi->unit = s; pi->unit < e; pi->unit++) {
 			if (pi->proto->probe_unit(pi)) {
 				parport_release(pi->pardev);
-				return pi_probe_mode(pi, max, scratch);
+				return pi_probe_mode(pi, max);
 			}
 		}
 		parport_release(pi->pardev);
 		return false;
 	}
 
-	return pi_probe_mode(pi, max, scratch);
+	return pi_probe_mode(pi, max);
 }
 
 static void pata_parport_dev_release(struct device *dev)
@@ -419,7 +419,6 @@ static struct pi_adapter *pi_init_one(struct parport *parport,
 			struct pi_protocol *pr, int mode, int unit, int delay)
 {
 	struct pardev_cb par_cb = { };
-	char scratch[512];
 	const struct ata_port_info *ppi[] = { &pata_parport_port_info };
 	struct ata_host *host;
 	struct pi_adapter *pi;
@@ -469,7 +468,7 @@ static struct pi_adapter *pi_init_one(struct parport *parport,
 	if (!pi->pardev)
 		goto out_module_put;
 
-	if (!pi_probe_unit(pi, unit, scratch)) {
+	if (!pi_probe_unit(pi, unit)) {
 		dev_info(&pi->dev, "Adapter not found\n");
 		goto out_unreg_parport;
 	}
diff --git a/include/linux/pata_parport.h b/include/linux/pata_parport.h
index e45bb1896003..bbfa4e63ee85 100644
--- a/include/linux/pata_parport.h
+++ b/include/linux/pata_parport.h
@@ -67,7 +67,7 @@ struct pi_protocol {
 
 	int (*test_port)(struct pi_adapter *pi);
 	int (*probe_unit)(struct pi_adapter *pi);
-	int (*test_proto)(struct pi_adapter *pi, char *scratch);
+	int (*test_proto)(struct pi_adapter *pi);
 	void (*log_adapter)(struct pi_adapter *pi);
 
 	int (*init_proto)(struct pi_adapter *pi);
-- 
Ondrej Zary

