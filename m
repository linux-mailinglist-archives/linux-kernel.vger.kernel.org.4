Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79C4675781
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 15:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjATOkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 09:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjATOkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 09:40:05 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0CECFD3B
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 06:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1674225569; x=1705761569;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wIqkIRLk97mVy76bXMdNE/RNNtTIHIYTZDRNoDes7MQ=;
  b=mJ6asm7QUVN8JOmvf0nBU881UxE7iAHCYB09wNGwNsl8KZlHpibe1Kp4
   lCnAUfvr9DPt3PtPdbs2w8k8Ff3yOjNSrWkIWgGedutF82Qr6VttMJE7F
   x1np+cqtWvVRrX488fQxiZ8Z8jNK6uLmz0/Z3CjKyQsemX812bJ2AMdCJ
   pKdObYaO4u9MWPH6ioqu1fLruS0qyyxh1t7nDA1UaQBD1JKdYLyjctjOI
   jTHccNNYKbGw1h7aTyzD8iIdB9Nq+WdGO5JmKP4K4eUYZ1yv3EIbg3Xs2
   fhDhhJIfdkyw5C82dgptRXRFDZggkg27PtN+uJvvUZHW/gDubRJHy2exI
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,232,1669100400"; 
   d="scan'208";a="197471514"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jan 2023 07:38:14 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 20 Jan 2023 07:38:11 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.16 via Frontend
 Transport; Fri, 20 Jan 2023 07:38:10 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
CC:     Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/7] mailbox: mpfs: fix an incorrect mask width
Date:   Fri, 20 Jan 2023 14:37:29 +0000
Message-ID: <20230120143734.3438755-2-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230120143734.3438755-1-conor.dooley@microchip.com>
References: <20230120143734.3438755-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The system controller registers on PolarFire SoC are 32 bits wide, so
16 + 16 as the first input to GENMASK_ULL() gives a 33 bit wide mask.
It probably should have been immediately obvious when it was pointed
out during review that the width required using GENMASK_ULL() - but I
scarcely knew what I was doing at the time and missed it.
The mistake ends up being moot as it is a mask after all, but it is
incorrect and should be fixed.

No functional change intended.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/mailbox/mailbox-mpfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/mailbox-mpfs.c b/drivers/mailbox/mailbox-mpfs.c
index 853901acaeec..d37560e91116 100644
--- a/drivers/mailbox/mailbox-mpfs.c
+++ b/drivers/mailbox/mailbox-mpfs.c
@@ -39,7 +39,7 @@
 #define SCB_CTRL_NOTIFY_MASK BIT(SCB_CTRL_NOTIFY)
 
 #define SCB_CTRL_POS (16)
-#define SCB_CTRL_MASK GENMASK_ULL(SCB_CTRL_POS + SCB_MASK_WIDTH, SCB_CTRL_POS)
+#define SCB_CTRL_MASK GENMASK(SCB_CTRL_POS + SCB_MASK_WIDTH - 1, SCB_CTRL_POS)
 
 /* SCBCTRL service status register */
 
@@ -118,6 +118,7 @@ static int mpfs_mbox_send_data(struct mbox_chan *chan, void *data)
 	}
 
 	opt_sel = ((msg->mbox_offset << 7u) | (msg->cmd_opcode & 0x7fu));
+
 	tx_trigger = (opt_sel << SCB_CTRL_POS) & SCB_CTRL_MASK;
 	tx_trigger |= SCB_CTRL_REQ_MASK | SCB_STATUS_NOTIFY_MASK;
 	writel_relaxed(tx_trigger, mbox->ctrl_base + SERVICES_CR_OFFSET);
-- 
2.39.0

