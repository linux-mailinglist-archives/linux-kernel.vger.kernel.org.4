Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E485FCA3A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 20:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiJLSFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 14:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJLSFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 14:05:01 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3623DBC8;
        Wed, 12 Oct 2022 11:04:58 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 99DD054142A;
        Wed, 12 Oct 2022 18:04:57 +0000 (UTC)
Received: from pdx1-sub0-mail-a274.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id CA372541420;
        Wed, 12 Oct 2022 18:04:56 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1665597896; a=rsa-sha256;
        cv=none;
        b=rEzWkxqg4G0ykI6YYlDyLa/ZRfm8EZlptpAgcxyU86WltJ0GpYzcAMLAABywPxiDDUVwZc
        Z7nIxbbeQ79HBv6vTCCzHQpVVL7AgYeumgGxCMU1HY4jSG/wD6ew8YvJNgUKbbyhe4lkDt
        p+58LV4Tf8Vqj4IffFp7DM63W9k6bMc25U1gdXPL2IQNaJsQqIyyrR83x+78YjjinNN49w
        nMenGWxRrei2Y41OlCOVLRgPDVQ1HuC15lXrp4AqAx2wz0dVwK6o0RA8z77qRe0CLkmfsP
        0MuD4jMr4Do74TCgMB3Ii39qrq2wkk72AIKKcI6faizdSPe23daKLfKzkdcWGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1665597896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=C8JJSk0EYyAqSc9YYXpRIUYnFlP9fh0LNbC+8dBPaMg=;
        b=6jsr+GpC3JeV/QHO8dXiKgGx1Ez0p77BQQ5h6uaGEEwNXdiKGAXuEkSDP6enqvjTiElLLz
        YAHtHamdXm9t0yPEDKXThIAhD5ZZAKXBmP7U60zHLrdURFhSuAOCQZT2LUqp1gq4fzEPTv
        aoyiEOZCv98SOwqg7tdig8EDrl1xGsDCojvhMmX1Dnhwgf+uqpr2ZhEtV3+Qkje/GR35cX
        BvC0dsZ29ZENaovpcxPexDyflvmCx/FCe78GHEgEinM3WbKiwrPGt49t2FiCxM84BDyhpl
        2BYcch5/Tqlcgdpvy8+cenVPEKZ9mm6mUPa53NWZm1JQwfmc0M4i5IIHEloYKQ==
ARC-Authentication-Results: i=1;
        rspamd-5798657bcf-ds2m7;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Illustrious-Glossy: 0b827d7b6549e4d9_1665597897136_4150339404
X-MC-Loop-Signature: 1665597897136:3182075601
X-MC-Ingress-Time: 1665597897136
Received: from pdx1-sub0-mail-a274.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.122.72.77 (trex/6.7.1);
        Wed, 12 Oct 2022 18:04:57 +0000
Received: from offworld.. (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a274.dreamhost.com (Postfix) with ESMTPSA id 4MngXm06Zrz2l;
        Wed, 12 Oct 2022 11:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1665597896;
        bh=C8JJSk0EYyAqSc9YYXpRIUYnFlP9fh0LNbC+8dBPaMg=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=NofUNgMRIca5zhIqiUF0L/TQjaQUVA4kPjpM+zTLq3aS7huyU/FNxIzYCe/qpAqdU
         +qBRkGTp3hwR2yEAuvu5AuuHzGGA36aoLclK3bn91I83L6xdzrr0UbsKrHQgGPg/6I
         nG1oVgtXsN6HLW+/R5d5vjdDBFJ+4eYmVwCvh3pUfyX7AirdHvolu+5JVkhZQQbaQL
         G+KGRdqmYrTFUtXn26eWXCHED5Jw3zgL8Wn882ukvSeh3nRWdSLwtw+8YoaSWBXxcq
         8YKMjzNcwdfgGJu/H+sMOD6duw2w8rb49vd1v4HPux8KI/TEBb92tkc1vD7ByJ3aI0
         sV8ECAfMmRiiA==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     ira.weiny@intel.com, Jonathan.Cameron@huawei.com,
        alison.schofield@intel.com, vishal.l.verma@intel.com,
        bwidawsk@kernel.org, a.manzanares@samsung.com,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        dave@stgolabs.net
Subject: [PATCH] cxl: Add generic MSI/MSI-X interrupt support
Date:   Wed, 12 Oct 2022 11:04:32 -0700
Message-Id: <20221012180432.473373-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.37.3
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
considered here.

Create an infrastructure to query the max vectors required for the CXL
device.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/pci.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index faeb5d9d7a7a..467f2d568e3e 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -428,6 +428,66 @@ static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
 	}
 }
 
+/**
+ * struct cxl_irq_cap - CXL feature that is capable of receiving MSI/MSI-X irqs.
+ *
+ * @name: Name of the device generating this interrupt.
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
+	{ "isolation", NULL },
+	{ "pmu_overflow", NULL },
+	{ "mailbox", NULL },
+	{ "event", NULL },
+};
+
+static void cxl_pci_free_irq_vectors(void *data)
+{
+	pci_free_irq_vectors(data);
+}
+
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
+	if (vectors == -1)
+		return -EINVAL; /* no irq support whatsoever */
+
+	vectors++;
+	rc = pci_alloc_irq_vectors(pdev, vectors, vectors,
+				   PCI_IRQ_MSIX | PCI_IRQ_MSI);
+	if (rc < 0)
+		return rc;
+
+	if (rc != vectors) {
+		dev_err(dev, "Not enough interrupts; use polling where supported\n");
+		/* Some got allocated; clean them up */
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
@@ -498,6 +558,9 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
 
+	/* TODO: When there are users, this return value must be checked */
+	cxl_pci_alloc_irq_vectors(cxlds);
+
 	if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM))
 		rc = devm_cxl_add_nvdimm(&pdev->dev, cxlmd);
 
-- 
2.37.3

