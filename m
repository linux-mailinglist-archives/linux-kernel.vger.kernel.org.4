Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDC46B48C3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 16:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbjCJPGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 10:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbjCJPGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 10:06:23 -0500
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E32AEF88;
        Fri, 10 Mar 2023 06:59:20 -0800 (PST)
Received: by mail-ot1-f44.google.com with SMTP id o4-20020a9d6d04000000b00694127788f4so3056580otp.6;
        Fri, 10 Mar 2023 06:59:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678460293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cjdq0nPulDtTn2r2+CkXPhEVFqi5tFBPZFinOPJBBmg=;
        b=vNEo8Pi5YNuzQIbfWNnzsKbyJPv3+KRkh4ucca9DioImGyNpK2h8yNozpz+6IjsE/o
         3lt4kdJvLmIV3jq4v6+IjNbmkyp1Sj1Fe10bv1qzn4zPlemhlPr3I2C9UkUeyTLsumdr
         U5nPref33ZDTs5yvaveIjwABDh0aHXohOj+GijnNC14GS9zB8Cgr9ClNtGHQVdyFROQx
         J/Xb2vWL3FlqMCCNqSKhJLc0t2BIqNkeuScY0Ee2dvyp/3TkH8knBQSifP8MWisksLhY
         V9BdBRUaLEekPZm/V+RJ/Q0LFEK/KuO0ZAR2aLaNZ8fBQncwCsuiDXQK9jF/dR3GP1BM
         Zebg==
X-Gm-Message-State: AO0yUKX/gKtrIl49MFAsy77mjRVl0hroKPusG1860wpMq2GmgM/WWWfy
        rdHQ5uS4P/uVoYk8SwgelYamEvXloQ==
X-Google-Smtp-Source: AK7set8ltvyu3+jLMDx6a9XG8pIfL2E/PPds+mYFCbTHt4tf5d9+0DrcZoRlEwkbXlTF32HYRbgyeQ==
X-Received: by 2002:a05:6870:ac1e:b0:172:a40f:5ff7 with SMTP id kw30-20020a056870ac1e00b00172a40f5ff7mr16149827oab.15.1678459719769;
        Fri, 10 Mar 2023 06:48:39 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z21-20020a056870515500b001728d38a41asm71961oak.55.2023.03.10.06.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:48:39 -0800 (PST)
Received: (nullmailer pid 1545026 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:23 -0000
From:   Rob Herring <robh@kernel.org>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     devicetree@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: Use of_property_read_bool() for boolean properties
Date:   Fri, 10 Mar 2023 08:47:23 -0600
Message-Id: <20230310144723.1544999-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is preferred to use typed property access functions (i.e.
of_property_read_<type> functions) rather than low-level
of_get_property/of_find_property functions for reading properties.
Convert reading boolean properties to to of_property_read_bool().

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/scsi/qlogicpti.c | 11 +++++------
 drivers/scsi/sun_esp.c   |  2 +-
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/qlogicpti.c b/drivers/scsi/qlogicpti.c
index 8c961ff03fcd..bf08c7cd10ef 100644
--- a/drivers/scsi/qlogicpti.c
+++ b/drivers/scsi/qlogicpti.c
@@ -513,7 +513,7 @@ static int qlogicpti_load_firmware(struct qlogicpti *qpti)
 		       qpti->qpti_id);
 		err = 1;
 		goto out;
-	}		
+	}
 	sbus_writew(SBUS_CTRL_RESET, qpti->qregs + SBUS_CTRL);
 	sbus_writew((DMA_CTRL_CCLEAR | DMA_CTRL_CIRQ), qpti->qregs + CMD_DMA_CTRL);
 	sbus_writew((DMA_CTRL_CCLEAR | DMA_CTRL_CIRQ), qpti->qregs + DATA_DMA_CTRL);
@@ -563,7 +563,7 @@ static int qlogicpti_load_firmware(struct qlogicpti *qpti)
 		       qpti->qpti_id);
 		err = 1;
 		goto out;
-	}		
+	}
 
 	/* Load it up.. */
 	for (i = 0; i < risc_code_length; i++) {
@@ -1136,7 +1136,7 @@ static struct scsi_cmnd *qlogicpti_intr_handler(struct qlogicpti *qpti)
 
 	if (!(sbus_readw(qpti->qregs + SBUS_STAT) & SBUS_STAT_RINT))
 		return NULL;
-		
+
 	in_ptr = sbus_readw(qpti->qregs + MBOX5);
 	sbus_writew(HCCTRL_CRIRQ, qpti->qregs + HCCTRL);
 	if (sbus_readw(qpti->qregs + SBUS_SEMAPHORE) & SBUS_SEMAPHORE_LCK) {
@@ -1362,9 +1362,8 @@ static int qpti_sbus_probe(struct platform_device *op)
 	fcode = of_get_property(dp, "isp-fcode", NULL);
 	if (fcode && fcode[0])
 		printk("(FCode %s)", fcode);
-	if (of_find_property(dp, "differential", NULL) != NULL)
-		qpti->differential = 1;
-			
+	qpti->differential = of_property_read_bool(dp, "differential");
+
 	printk("\nqlogicpti%d: [%s Wide, using %s interface]\n",
 		qpti->qpti_id,
 		(qpti->ultra ? "Ultra" : "Fast"),
diff --git a/drivers/scsi/sun_esp.c b/drivers/scsi/sun_esp.c
index 5dc38d35745b..58bdd71fef06 100644
--- a/drivers/scsi/sun_esp.c
+++ b/drivers/scsi/sun_esp.c
@@ -146,7 +146,7 @@ static void esp_get_differential(struct esp *esp)
 	struct device_node *dp;
 
 	dp = op->dev.of_node;
-	if (of_find_property(dp, "differential", NULL))
+	if (of_property_read_bool(dp, "differential"))
 		esp->flags |= ESP_FLAG_DIFFERENTIAL;
 	else
 		esp->flags &= ~ESP_FLAG_DIFFERENTIAL;
-- 
2.39.2

