Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8616022A8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbiJRD3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbiJRD2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:28:47 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763B3A027B;
        Mon, 17 Oct 2022 20:21:46 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 16AB1341BAB;
        Tue, 18 Oct 2022 03:21:23 +0000 (UTC)
Received: from pdx1-sub0-mail-a201 (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 81484341AE1;
        Tue, 18 Oct 2022 03:21:22 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1666063282; a=rsa-sha256;
        cv=none;
        b=z8Zh9yi+NbXnemOtcmJJuwW+oj7d5+3fUXFAzsU9zpwdsbQ7x8H29Iqh2HCeA/ILJYaxaL
        LCTeO4u7UBNP5audik4dZXWjZm2zb8+SXbebm2dqCnD9B9EXf2aT4hJdHYI4bn53mk5rB/
        a6Lkz9GI2ha6lmLcTBIGO7nNN+fl7VV+bvdU+qHAy2XxX+HB7YB7y7dUJeU9WmQDFDxoy7
        e80pjRngZ9NE5kqUzSzMPgdLSl4mphaocslL3h7/MAKGNGiXNsNWlZKDfyv8mITq9TpATX
        uzGAR//He5zNlxiJ4rW2u+rBSpu+G0YEvLCPXi8lbyaFfzhVEJ/QIeT71rxWcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1666063282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=+F77OywPESqqbC+/oPvGc0AQuP7cONHmICZM40h0KBY=;
        b=XSJpp8oNvxpfQl2o2RG413EojHNYKOir3pBDuZ/ZIAG9+M8qr6uYprG/wNKRf20i4QmqE2
        fgo576To4iBkDI8mLWPKz7xxvmBWJKq1atzqmmazEn1YABF5njJ9tyggot2bzYIHafSjnb
        gBQGee0VBhMvOhepzlQ2FNL1oYlrNOXzXQjoyd+yZmWRnEFZMwDWZg4D4N3Pbbt3l0A97b
        XJMG475t8gm1zXViySuFTHCKSKx2iDLxekcuvonEpTf2HbLd/arwmeqbWQ/qZ5b60SM9kN
        bfmpeXGDu2L6EPYzmJNUjsFhvoJg35wHI2D529imn+Cd5xNdbvnEZ190cGHmeA==
ARC-Authentication-Results: i=1;
        rspamd-7fb88f4dd5-7vxgv;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Snatch-Cure: 60cdaa360af8dbc2_1666063282857_1569416159
X-MC-Loop-Signature: 1666063282857:1041835057
X-MC-Ingress-Time: 1666063282857
Received: from pdx1-sub0-mail-a201 (pop.dreamhost.com [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.122.146.22 (trex/6.7.1);
        Tue, 18 Oct 2022 03:21:22 +0000
Received: from localhost.localdomain (unknown [104.36.31.104])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a201 (Postfix) with ESMTPSA id 4MrzfT4PJMz4r;
        Mon, 17 Oct 2022 20:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1666063282;
        bh=+F77OywPESqqbC+/oPvGc0AQuP7cONHmICZM40h0KBY=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=AU8abd9B2gT8pXCbb1HVa2wtEwJD7UPCT98DA++jcGBufcCBd3vRzosXU5rhtQPkZ
         ANNbuIDk82wJiei8hR++2OkTJaRk3bbr865B8SqGeL4cey05gK0f7zSkSOgi2UggS9
         DJu7I8rFna9uAh5I/Nbp6VQzlVn2uP1aw1+e8tThOqOUyRUwEvJg9nfohu2UAavXhL
         oH3ybDdo4PwtW9icrLt/av6h09Kj78bvAzRFRxgQQxyTaUtbT+KkqFjEfC/QAjZHYE
         Iy5Q6jYp4IJvE0iHnfeQlX6YYEK8vMFm/MjX+7HWUw/D91iyQw2RWtc4MQowF6IkNU
         XxHvVCQ2QTRVg==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     ira.weiny@intel.com, Jonathan.Cameron@huawei.com,
        dave.jiang@intel.com, alison.schofield@intel.com,
        bwidawsk@kernel.org, vishal.l.verma@intel.com,
        a.manzanares@samsung.com, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, dave@stgolabs.net
Subject: [PATCH 2/2] cxl/mbox: Wire up irq support
Date:   Mon, 17 Oct 2022 20:00:10 -0700
Message-Id: <20221018030010.20913-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221018030010.20913-1-dave@stgolabs.net>
References: <20221018030010.20913-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With enough vectors properly allocated, this adds support for
(the primary) mailbox interrupt, which is needed for background
completion handling, beyond polling.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/cxl.h |  1 +
 drivers/cxl/pci.c | 29 ++++++++++++++++++++++++++++-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f680450f0b16..13a9743b0012 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -135,6 +135,7 @@ static inline int ways_to_cxl(unsigned int ways, u8 *iw)
 /* CXL 2.0 8.2.8.4 Mailbox Registers */
 #define CXLDEV_MBOX_CAPS_OFFSET 0x00
 #define   CXLDEV_MBOX_CAP_PAYLOAD_SIZE_MASK GENMASK(4, 0)
+#define   CXLDEV_MBOX_CAP_IRQ_MSGNUM_MASK GENMASK(10, 7)
 #define CXLDEV_MBOX_CTRL_OFFSET 0x04
 #define   CXLDEV_MBOX_CTRL_DOORBELL BIT(0)
 #define CXLDEV_MBOX_CMD_OFFSET 0x08
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 9c3e95ebaa26..c3f3ee307d7a 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -274,6 +274,32 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
 	return 0;
 }
 
+static int cxl_pci_mbox_get_max_msgnum(struct cxl_dev_state *cxlds)
+{
+	int cap;
+
+	cap = readl(cxlds->regs.mbox + CXLDEV_MBOX_CAPS_OFFSET);
+	return FIELD_GET(CXLDEV_MBOX_CAP_IRQ_MSGNUM_MASK, cap);
+}
+
+static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
+{
+	/* TODO: handle completion of background commands */
+	return IRQ_HANDLED;
+}
+
+static void cxl_pci_mbox_irqsetup(struct cxl_dev_state *cxlds)
+{
+	struct device *dev = cxlds->dev;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	int irq;
+
+	irq = cxl_pci_mbox_get_max_msgnum(cxlds);
+	if (!pci_request_irq(pdev, irq, cxl_pci_mbox_irq, NULL,
+			     cxlds, "%s-mailbox", dev_name(dev)))
+		dev_dbg(dev, "Mailbox irq (%d) supported", irq);
+}
+
 static int cxl_map_regblock(struct pci_dev *pdev, struct cxl_register_map *map)
 {
 	void __iomem *addr;
@@ -442,7 +468,7 @@ struct cxl_irq_cap {
 };
 
 static const struct cxl_irq_cap cxl_irq_cap_table[] = {
-	NULL
+	{ "mailbox", cxl_pci_mbox_get_max_msgnum },
 };
 
 static void cxl_pci_free_irq_vectors(void *data)
@@ -562,6 +588,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return rc;
 
 	if (!cxl_pci_alloc_irq_vectors(cxlds)) {
+		cxl_pci_mbox_irqsetup(cxlds);
 		cxlds->has_irq = true;
 	} else
 		cxlds->has_irq = false;
-- 
2.38.0

