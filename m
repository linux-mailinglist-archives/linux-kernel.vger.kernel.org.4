Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD31E72A236
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 20:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjFISaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 14:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjFISao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 14:30:44 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA91735B8
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 11:30:43 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-33b1e83e204so8792625ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 11:30:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686335443; x=1688927443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UQ2Jqgv8w/RCc71k1A2f5S/TBpvSA5M0P4GcW4ni11M=;
        b=S4qtv4/1IUNY0EXz3uY9vPJhLs0BT+NkakmNRoAUQmldRpIHt+y6KRFBxkvN8FGBfZ
         g1ihAhPdTXHxbaK10sUAH9lbywKc51QHIoqUCcsRcljLrYGlmJl8gAVhZifMKs/49pig
         pAwRwqYM5MnJOLFDqQo0gQxf0K/o6JaRGBTxer2Zc1vcOWFtEveJ6xMvikVvoejgMHi4
         OpvPh3XS94UjZFo6OYPlj3X2Vp15f0V2C1Q5k7rjLOCBjWWSbbuo0E4zPWDIzn0RNdcL
         CoHTUpDOxU8rIWfalLCSTo4ibxNMvM5KVFv4Wt9M4UdQV1m8K1PZAT//nb8S1hwXcnPM
         6OEA==
X-Gm-Message-State: AC+VfDyrRmVPHWxR/svxbi3YQCD9q4Oifuj9K5GjIADl/GREGu6QJhDF
        VlXj+ZOhIVUxuMbsC0av8rxJ9twogw==
X-Google-Smtp-Source: ACHHUZ5roDs4+ptpSzNcbF5YA4f3450UuSKLGoLhoYWwoVmK9xKlyZ1RmmQCc/8f7eJATFTdgQSxIg==
X-Received: by 2002:a92:c989:0:b0:33e:6aa1:29cf with SMTP id y9-20020a92c989000000b0033e6aa129cfmr1946355iln.32.1686335442998;
        Fri, 09 Jun 2023 11:30:42 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id l5-20020a92d8c5000000b00338a1272ce1sm1243481ilo.52.2023.06.09.11.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 11:30:42 -0700 (PDT)
Received: (nullmailer pid 1764888 invoked by uid 1000);
        Fri, 09 Jun 2023 18:30:41 -0000
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] macintosh: Use of_property_read_reg() to parse "reg"
Date:   Fri,  9 Jun 2023 12:29:25 -0600
Message-Id: <20230609182926.1763589-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the recently added of_property_read_reg() helper to get the
untranslated "reg" address value.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/macintosh/smu.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/macintosh/smu.c b/drivers/macintosh/smu.c
index b495bfa77896..5183a00529f5 100644
--- a/drivers/macintosh/smu.c
+++ b/drivers/macintosh/smu.c
@@ -33,7 +33,8 @@
 #include <linux/delay.h>
 #include <linux/poll.h>
 #include <linux/mutex.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/slab.h>
@@ -470,7 +471,7 @@ EXPORT_SYMBOL(smu_present);
 int __init smu_init (void)
 {
 	struct device_node *np;
-	const u32 *data;
+	u64 data;
 	int ret = 0;
 
         np = of_find_node_by_type(NULL, "smu");
@@ -514,8 +515,7 @@ int __init smu_init (void)
 		ret = -ENXIO;
 		goto fail_bootmem;
 	}
-	data = of_get_property(smu->db_node, "reg", NULL);
-	if (data == NULL) {
+	if (of_property_read_reg(smu->db_node, 0, &data, NULL)) {
 		printk(KERN_ERR "SMU: Can't find doorbell GPIO address !\n");
 		ret = -ENXIO;
 		goto fail_db_node;
@@ -525,7 +525,7 @@ int __init smu_init (void)
 	 * and ack. GPIOs are at 0x50, best would be to find that out
 	 * in the device-tree though.
 	 */
-	smu->doorbell = *data;
+	smu->doorbell = data;
 	if (smu->doorbell < 0x50)
 		smu->doorbell += 0x50;
 
@@ -534,13 +534,12 @@ int __init smu_init (void)
 		smu->msg_node = of_find_node_by_name(NULL, "smu-interrupt");
 		if (smu->msg_node == NULL)
 			break;
-		data = of_get_property(smu->msg_node, "reg", NULL);
-		if (data == NULL) {
+		if (of_property_read_reg(smu->msg_node, 0, &data, NULL)) {
 			of_node_put(smu->msg_node);
 			smu->msg_node = NULL;
 			break;
 		}
-		smu->msg = *data;
+		smu->msg = data;
 		if (smu->msg < 0x50)
 			smu->msg += 0x50;
 	} while(0);
-- 
2.39.2

