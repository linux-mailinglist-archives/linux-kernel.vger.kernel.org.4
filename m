Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A355FF43E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 21:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbiJNTut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 15:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbiJNTuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 15:50:46 -0400
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC73A8CE2;
        Fri, 14 Oct 2022 12:50:34 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 89FDE6C2207;
        Fri, 14 Oct 2022 19:50:20 +0000 (UTC)
Received: from pdx1-sub0-mail-a219.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id A13EB6C21FA;
        Fri, 14 Oct 2022 19:50:19 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1665777019; a=rsa-sha256;
        cv=none;
        b=bCRoiEOR2noCWwHM4YQ9ty2djvpvNZ/PUmmkLfGcDoRXixygs4WX7W3mBSwj1DifEgSNul
        0W2PyMU85luQKuVIpZh3o9/LPVZ/9mKEfSujoo62jgPS6ESIVdU9I6/kEoA4hcQeOws5dx
        TrYPZbawr5f0Bxg79wyDNTuquhbWtN7tRzOjVdKFj36TH6oVFRJAOBnDiLyPZ/wl8OnFbL
        /dMoeX3FjhGujch2wnC00BN4zQT4KeR3LEeCFybVUvYfRiR26Mm2NHPd9kth309g5Amb2X
        eunYaA/s4Zh8vv9LCLV7jnX2wY9k3R/u3Fw8DfY2UQHwRLVU8nmUEMj3j3B+NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1665777019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=hfzbsr9FI/rzLOLEFBaAvUZAbZ6DVfHSQA0uzUjx5qs=;
        b=HFVwuu2aewx890rozxPt5Fa3tJjbVFk3Syd2hXKUDpCsmcJAkw3oCPSrJOjtwlYMI8nNjS
        dZNn1xqcJES5PuIQ0u8sgOZZ17TqH1/3LUsgt3bFLFybgbKMruVn8CIAp+T9W6gfCJ0uyH
        1ffUYs7tD8nUV7DZFYwpwo+Q4m50bH58g1UC+LYthMj6DafBZJQDGX8bYMKAcOMuvtKXsl
        PJWC2TzXgsVMfvjW8j28N2t3eJuXsDaU3bcL97klFvSx4wuqd8YKhzly7vJ/KpTwqC+93r
        3PIz70t+/DDHQpf9ZBqYXD7XfFxo7o2mvUL5xhu79l4/3vwGY5CBNAZzey81jg==
ARC-Authentication-Results: i=1;
        rspamd-5798657bcf-8zx8p;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Spicy-Occur: 419aa3984982d9c9_1665777020009_1395546131
X-MC-Loop-Signature: 1665777020009:465102095
X-MC-Ingress-Time: 1665777020009
Received: from pdx1-sub0-mail-a219.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.122.146.22 (trex/6.7.1);
        Fri, 14 Oct 2022 19:50:20 +0000
Received: from offworld.. (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a219.dreamhost.com (Postfix) with ESMTPSA id 4MpxnP22gyz3p;
        Fri, 14 Oct 2022 12:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1665777017;
        bh=hfzbsr9FI/rzLOLEFBaAvUZAbZ6DVfHSQA0uzUjx5qs=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=LBXQNzKkFNGvlcw2g1l6ZBy61RbR2Sq48CUW7lnbxvi9mkhq80iMvQvEM9Gr3dUz6
         uNfxvIjmhPJsuSiwTXEQXnzCGhkhypi0F33WrZmWd+uySBsGU0RAFVRJgoKdBKJt+C
         uDMhD7FO2meN8emPwIgofxkGpVfBIJaWk8HHwtqEv3MHSx0InXLR8LPalJLOSJa9cS
         gHKDxNmkr8xDjfNzIj9Ze4fJNYC6FoMartV1ZNy2dp/gf7JLX3YYWHBSgOyfUb4hLZ
         s5ZgOQT+d86QLIjrIx743vhEYF0IEncUcxn1lPjHszSRuiLuEMWmnotLQkyexUJq4/
         FJDxMxYJylw3Q==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     ira.weiny@intel.com, Jonathan.Cameron@huawei.com,
        dave.jiang@intel.com, alison.schofield@intel.com,
        vishal.l.verma@intel.com, bwidawsk@kernel.org,
        a.manzanares@samsung.com, linux-kernel@vger.kernel.org,
        linux-cxl@vger.kernel.org, dave@stgolabs.net
Subject: [PATCH 2/2] cxl/mbox: Wire up basic irq support
Date:   Fri, 14 Oct 2022 12:49:30 -0700
Message-Id: <20221014194930.2630416-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221014194930.2630416-1-dave@stgolabs.net>
References: <20221014194930.2630416-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for mailbox interrupts, which are needed, for
example, for background completion handling.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
Note: We could also handle doorbell irq, but not sure this is
actually needed.

 drivers/cxl/cxl.h |  1 +
 drivers/cxl/pci.c | 27 ++++++++++++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 879661702054..d15a743bfc9e 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -140,6 +140,7 @@ enum {
 /* CXL 2.0 8.2.8.4 Mailbox Registers */
 #define CXLDEV_MBOX_CAPS_OFFSET 0x00
 #define   CXLDEV_MBOX_CAP_PAYLOAD_SIZE_MASK GENMASK(4, 0)
+#define   CXLDEV_MBOX_CAP_IRQ_MSGNUM_MASK GENMASK(10, 7)
 #define CXLDEV_MBOX_CTRL_OFFSET 0x04
 #define   CXLDEV_MBOX_CTRL_DOORBELL BIT(0)
 #define CXLDEV_MBOX_CMD_OFFSET 0x08
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 942c4449d30f..6e18ca3e551f 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -51,6 +51,20 @@ static unsigned short mbox_ready_timeout = 60;
 module_param(mbox_ready_timeout, ushort, 0644);
 MODULE_PARM_DESC(mbox_ready_timeout, "seconds to wait for mailbox ready");
 
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
 static int cxl_pci_mbox_wait_for_doorbell(struct cxl_dev_state *cxlds)
 {
 	const unsigned long start = jiffies;
@@ -271,6 +285,15 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
 	dev_dbg(cxlds->dev, "Mailbox payload sized %zu",
 		cxlds->payload_size);
 
+	if (cxlds->irq_type == CXL_IRQ_MSI) {
+		struct device *dev = cxlds->dev;
+		int irq = cxl_pci_mbox_get_max_msgnum(cxlds);
+
+		if (devm_request_irq(dev, irq, cxl_pci_mbox_irq,
+				     IRQF_SHARED, "mailbox", cxlds))
+			dev_dbg(dev, "Mailbox irq (%d) supported", irq);
+	}
+
 	return 0;
 }
 
@@ -441,7 +464,9 @@ struct cxl_irq_cap {
 	int (*get_max_msgnum)(struct cxl_dev_state *cxlds);
 };
 
-static const struct cxl_irq_cap cxl_irq_cap_table[] = { NULL };
+static const struct cxl_irq_cap cxl_irq_cap_table[] = {
+	{ "mailbox", cxl_pci_mbox_get_max_msgnum }
+};
 
 static void cxl_pci_free_irq_vectors(void *data)
 {
-- 
2.37.3

