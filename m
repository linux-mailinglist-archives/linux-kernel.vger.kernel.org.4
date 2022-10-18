Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEA56022A6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiJRD3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbiJRD2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:28:47 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F41A4BB7;
        Mon, 17 Oct 2022 20:21:45 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 38F24880B92;
        Tue, 18 Oct 2022 03:21:22 +0000 (UTC)
Received: from pdx1-sub0-mail-a201 (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 9B368880B4D;
        Tue, 18 Oct 2022 03:21:21 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1666063281; a=rsa-sha256;
        cv=none;
        b=8zxPPS0uS1t+YDChnynjIpzPQsSC8VIH38cIxINiskvkSybdEpUW7QAY0Z0EI55KySY6sf
        lcj+WMUtvooV17q4RgagE1HcxuoRQLtewPuYl3eKwPu4Qo7g4pZMBRNCN5m/SpvSGnfWei
        6ecEskLwdkoNR7D6UhtFj8HIdP6J9DWjpdyJZKksUzIf0SnJlIpg+fUCLoP5UEPlSxhl5W
        w+fl5qf6cO69wBmffNlRingtbCYXNYPWexrG9u3hrNQtTVbsnNF2Kv6xrAj3xSUNZNMEda
        9+3GeTj4Pn6FWpbOS11OYtU35ovxVstK2aKo4m/uvjnn1JsoQsEPlOKFmb1BhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1666063281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=5rez8qYjf0NKGjU9X2fo6bHVw919Ec9FBSH61oJQCaA=;
        b=8uPSPU8vpeuvsFS2H4z9ybpNlnT5Zsljb3m6VgrDTNmzqrHhczCG2k5r98SCwin+PAz+an
        P5BYQpNoypxB+NMQ9OGFwiWhTDorxAFQsg73Y4qeNE5gN1l//HpgxbtEQ/NDzADESUODe5
        s00oFbo5JJm0vYeUEfDIXHnwLKbKAKjwwVYJcptW4BzJf6TUSN2+IDp5XGtIBKz8TUXfMm
        BOs7Rjt/WcDuvC8Y0VU5LA+1LSxQO1tyuRVVbUP+OsgCaKmc9dA4G0DLdWqLHw6H9Y0ro+
        4JMwHDFu5UOkSvf1D/umrTTiwXhbmXzYkrJ4ci8ZSLOR+323jZuaCgaUJgzOxA==
ARC-Authentication-Results: i=1;
        rspamd-7fb88f4dd5-zsbr9;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Occur-Lettuce: 2a53bb1249e09068_1666063281979_801838855
X-MC-Loop-Signature: 1666063281979:1386239554
X-MC-Ingress-Time: 1666063281979
Received: from pdx1-sub0-mail-a201 (pop.dreamhost.com [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.122.72.98 (trex/6.7.1);
        Tue, 18 Oct 2022 03:21:21 +0000
Received: from localhost.localdomain (unknown [104.36.31.104])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a201 (Postfix) with ESMTPSA id 4MrzfS4Q3pz54;
        Mon, 17 Oct 2022 20:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1666063281;
        bh=5rez8qYjf0NKGjU9X2fo6bHVw919Ec9FBSH61oJQCaA=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=nuHpR0uUQbAZRV03IPprYEp3zjTQD4IUrrcgHsLGCEvDm1A0TcD5d1BxAlnC5T8Yo
         stmucL3WEA6POSQailbbpJfCwnZyrbJCZpwiXcMkpui1DfJMgfexm7FnyWuLkAaBW+
         3XKUGfXEs3JD6TzMSsW7Rin+egEjN0u9Loqp11FCGUOUO9Xql00pF/LxU65XOWkLQG
         gh8PE9UDQtObQEHy6aWAxzuX3eoy9CYSQ1Yw9cWfwil6+9DV2EJ+EE2NZPLhAzhFK3
         dUzZwxT9q7gPWeOMxVxtoh3J4ErXzy9Qb/o8nUUk79f0DRTvZO2qS1ip7UzCdgmNeT
         C/TuY22P4184Q==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     ira.weiny@intel.com, Jonathan.Cameron@huawei.com,
        dave.jiang@intel.com, alison.schofield@intel.com,
        bwidawsk@kernel.org, vishal.l.verma@intel.com,
        a.manzanares@samsung.com, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, dave@stgolabs.net
Subject: [PATCH 1/2] cxl/pci: Add generic MSI-X/MSI irq support
Date:   Mon, 17 Oct 2022 20:00:09 -0700
Message-Id: <20221018030010.20913-2-dave@stgolabs.net>
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

Introduce a generic irq table for CXL components/features that can have
standard irq support - DOE requires dynamic vector sizing and is not
considered here. For now the table is empty.

Create an infrastructure to query the max vectors required for the CXL
device. Upon successful allocation, users can plug in their respective isr
at any point thereafter, which is supported by a new cxlds->has_irq flag,
for example, if the irq setup is not done in the PCI driver, such as
the case of the CXL-PMU.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/cxlmem.h |  3 ++
 drivers/cxl/pci.c    | 72 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 88e3a8e54b6a..72b69b003302 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -211,6 +211,7 @@ struct cxl_endpoint_dvsec_info {
  * @info: Cached DVSEC information about the device.
  * @serial: PCIe Device Serial Number
  * @doe_mbs: PCI DOE mailbox array
+ * @has_irq: PCIe MSI-X/MSI support
  * @mbox_send: @dev specific transport for transmitting mailbox commands
  *
  * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
@@ -247,6 +248,8 @@ struct cxl_dev_state {
 
 	struct xarray doe_mbs;
 
+	bool has_irq;
+
 	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
 };
 
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index faeb5d9d7a7a..9c3e95ebaa26 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -428,6 +428,73 @@ static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
 	}
 }
 
+/**
+ * struct cxl_irq_cap - CXL feature that is capable of receiving MSI-X/MSI irqs.
+ *
+ * @name: Name of the device/component generating this interrupt.
+ * @get_max_msgnum: Get the feature's largest interrupt message number.  If the
+ *		    feature does not have the Interrupt Supported bit set, then
+ *		    return -1.
+ */
+struct cxl_irq_cap {
+	const char *name;
+	int (*get_max_msgnum)(struct cxl_dev_state *cxlds);
+};
+
+static const struct cxl_irq_cap cxl_irq_cap_table[] = {
+	NULL
+};
+
+static void cxl_pci_free_irq_vectors(void *data)
+{
+	pci_free_irq_vectors(data);
+}
+
+/*
+ * Attempt to allocate the largest amount of necessary vectors.
+ *
+ * Returns 0 upon a successful allocation of *all* vectors, or a
+ * negative value otherwise.
+ */
+static int cxl_pci_alloc_irq_vectors(struct cxl_dev_state *cxlds)
+{
+	struct device *dev = cxlds->dev;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	int rc, i, vectors = -1;
+
+	for (i = 0; i < ARRAY_SIZE(cxl_irq_cap_table); i++) {
+		int irq;
+
+		if (!cxl_irq_cap_table[i].get_max_msgnum)
+			continue;
+
+		irq = cxl_irq_cap_table[i].get_max_msgnum(cxlds);
+		vectors = max_t(int, irq, vectors);
+	}
+
+	/*
+	 * Semantically lack of irq support is not an error, but we
+	 * still fail to allocate, so return negative.
+	 */
+	if (vectors == -1)
+		return -1;
+
+	vectors++;
+	rc = pci_alloc_irq_vectors(pdev, vectors, vectors,
+				   PCI_IRQ_MSIX | PCI_IRQ_MSI);
+	if (rc < 0)
+		return rc;
+
+	if (rc != vectors) {
+		dev_dbg(dev, "Not enough interrupts; use polling instead.\n");
+		/* some got allocated, clean them up */
+		cxl_pci_free_irq_vectors(pdev);
+		return -ENOSPC;
+	}
+
+	return devm_add_action_or_reset(dev, cxl_pci_free_irq_vectors, pdev);
+}
+
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct cxl_register_map map;
@@ -494,6 +561,11 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
+	if (!cxl_pci_alloc_irq_vectors(cxlds)) {
+		cxlds->has_irq = true;
+	} else
+		cxlds->has_irq = false;
+
 	cxlmd = devm_cxl_add_memdev(cxlds);
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
-- 
2.38.0

