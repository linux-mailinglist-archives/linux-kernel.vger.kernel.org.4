Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186FE6ACC74
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 19:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjCFSY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 13:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjCFSYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 13:24:17 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 96A0E497DA;
        Mon,  6 Mar 2023 10:23:59 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 8840E7A0708;
        Mon,  6 Mar 2023 18:28:29 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/18] pata_parport: use print_hex_*
Date:   Mon,  6 Mar 2023 18:27:46 +0100
Message-Id: <20230306172752.7727-13-linux@zary.sk>
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

Use print_hex_* for debug dumps.

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/bpck.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

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
-- 
Ondrej Zary

