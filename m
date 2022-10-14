Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32D75FF43D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 21:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbiJNTui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 15:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbiJNTuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 15:50:35 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E548C026;
        Fri, 14 Oct 2022 12:50:31 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 17A7014167E;
        Fri, 14 Oct 2022 19:50:18 +0000 (UTC)
Received: from pdx1-sub0-mail-a219.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 5E9CE1414BE;
        Fri, 14 Oct 2022 19:50:17 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1665777017; a=rsa-sha256;
        cv=none;
        b=OknIobnNwbXerNu7HApdSiBuNkKHkue4exW7DUJB04etTnpPBprN1wgDVDZGpa48VecPBK
        UUVdiryevbTUnwb+90Ukhw8ii1O0tyzh8wX+mnSBVKHkKdZCZxjJIuQwFpEYUslyCuAmx3
        R03JwmvgvYF9c6rgJAZJWoCNWRdipRYJsyXC/9EJpXMTwZaSCxNtrJV3rtm4YMmEknNz5n
        saHoRltbuO+fSGe6PYxB4/jumhU5/oPjJAzH1a/k/4+epLWQ38kwob9gzlt26RH4pNyjkS
        ndIBnMZtmBB8LmryeuAQ2PIpm6HYjYUh06TpbNAX1Oce9JH1dty1r33Bue3MHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1665777017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=4McCZ56zCh20Vp80Kwo95PLFd0Mi47/KFhOpUHARCVY=;
        b=ty2Ga96fOUXFea57d7iTJSqCBowIFxytGFsVJ02u5nY8VeqBNkTE5WTGF6kBjlfLkum5P1
        SCiQgfs838M0JXXmPoCxsmuKbPZYRad7HNpX82IMf49g/iU+LE7OUjFrFmaGT/E12Ve7uu
        CVIyAf5UK6wUGFgCiBVgai5Iluci0sZW69WCqSopnKubhDUlE6ukfC3A/WzTVwwIwb3ZUC
        28pbB4bHqBtgAchADVLVpaHsAVsKORXu/IZApCxK2LvUuLcb2tpCweY44QQ26aUvF3oKmK
        qLH2UNVB3n33kTuN1wNBNiSQ5VVMWrXeBuR/7NmQyd1zxt4qCvPdc/Nydd5Gsg==
ARC-Authentication-Results: i=1;
        rspamd-5798657bcf-rqdj4;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Bottle-Imminent: 1761f7291737c9b3_1665777017763_295819113
X-MC-Loop-Signature: 1665777017763:3860012546
X-MC-Ingress-Time: 1665777017762
Received: from pdx1-sub0-mail-a219.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.106.246.144 (trex/6.7.1);
        Fri, 14 Oct 2022 19:50:17 +0000
Received: from offworld.. (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a219.dreamhost.com (Postfix) with ESMTPSA id 4MpxnN2X3zz4s;
        Fri, 14 Oct 2022 12:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1665777017;
        bh=4McCZ56zCh20Vp80Kwo95PLFd0Mi47/KFhOpUHARCVY=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=cUfSgyHcaW+V/7/sMFTBQFNCgQha8e7XSX3MO7xtHfDI/jNKNkhMjoutp+hb0Aidp
         f1t9JxxsaKdksa1WfTGPgIzf5qKC/cNoFn1WfsX1FPiUTb0+h3Rc1YNa1iyCUA2uoe
         73ivN3VRTm9+AkPP5fGfVcthaUuJzzNqv9FNGM0q63/InalDExvRBg9OybbHk8s8Fx
         uEnMs0oX0tUeOA2j7NZvOqnSakSUxlYMm5Ujd1Sr6cK5PifPW18SedEr5wlfsEcKPi
         kljT5F80uVJUvWm1OyYJRPwoETWP7YjGcDXBtS54K26/I7WyRMQ9EXOtuvGJyZOpMu
         YRSJ6vBuvOpSQ==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     ira.weiny@intel.com, Jonathan.Cameron@huawei.com,
        dave.jiang@intel.com, alison.schofield@intel.com,
        vishal.l.verma@intel.com, bwidawsk@kernel.org,
        a.manzanares@samsung.com, linux-kernel@vger.kernel.org,
        linux-cxl@vger.kernel.org, dave@stgolabs.net
Subject: [PATCH 1/2] cxl/pci: Add generic MSI/MSI-X interrupt support
Date:   Fri, 14 Oct 2022 12:49:29 -0700
Message-Id: <20221014194930.2630416-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221014194930.2630416-1-dave@stgolabs.net>
References: <20221014194930.2630416-1-dave@stgolabs.net>
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

Introduce a generic irq table for CXL components that can have
standard irq support - DOE requires dynamic vector sizing and is
as such is not considered here.

Create an infrastructure to query the max vectors required for the CXL
device. Users can check the irq_type in the device state to figure
if they want to attempt to register a handler for it's specific irq
and deal with it accordingly.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/cxl.h    |  5 ++++
 drivers/cxl/cxlmem.h |  2 ++
 drivers/cxl/pci.c    | 66 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f680450f0b16..879661702054 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -119,6 +119,11 @@ static inline int ways_to_cxl(unsigned int ways, u8 *iw)
 	return 0;
 }
 
+enum {
+	CXL_IRQ_NONE,
+	CXL_IRQ_MSI,
+};
+
 /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
 #define CXLDEV_CAP_ARRAY_OFFSET 0x0
 #define   CXLDEV_CAP_ARRAY_CAP_ID 0
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 88e3a8e54b6a..ca020767f7fc 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -247,6 +247,8 @@ struct cxl_dev_state {
 
 	struct xarray doe_mbs;
 
+	int irq_type;
+
 	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
 };
 
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index faeb5d9d7a7a..942c4449d30f 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -428,6 +428,67 @@ static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
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
+static const struct cxl_irq_cap cxl_irq_cap_table[] = { NULL };
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
+		dev_err(dev, "Not enough interrupts; use polling instead.\n");
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
@@ -478,6 +539,11 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	devm_cxl_pci_create_doe(cxlds);
 
+	if (!cxl_pci_alloc_irq_vectors(cxlds))
+		cxlds->irq_type = CXL_IRQ_MSI;
+	else
+		cxlds->irq_type = CXL_IRQ_NONE;
+
 	rc = cxl_pci_setup_mailbox(cxlds);
 	if (rc)
 		return rc;
-- 
2.37.3

