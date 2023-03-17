Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF9D6BE823
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 12:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjCQLdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 07:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjCQLdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 07:33:08 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34341A8C55
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 04:33:00 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id ix20so4987477plb.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 04:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112; t=1679052780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02xUqfEugvmsV40WG30Qa2tXUYlhWNLWy8/nr55CGig=;
        b=4P4Ag5T9O6UF2JNgzQOd/XqYteXdWN+gFSUKQfREV6+na/dzjZVvbtd7t75wSjkLRz
         sfU1y6//aC0sRcbKwiErqhP47Kmig9CO7GRffsItnE6N8g2uSH85vX0htlJYkWwRhqiV
         750xt0J/CkT6CpRIR9AsM9BxJ5aemjO/m6GuwYGupnSG509fpD4R7n9wdJJ/YElw20I6
         c66wi5hzNT0t0/Jb/ATPCTm9XBpQwqOlli87yEKbNyOcJeoDECZg0D3GY2CS8SJciqIQ
         eb4JnVfDE/pvvt8VRz6KvGDn5NYE3kjgCubYAMslqcvqzt2LM8gM8MUZNe9I2F0ohubi
         08DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679052780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=02xUqfEugvmsV40WG30Qa2tXUYlhWNLWy8/nr55CGig=;
        b=oIfx1d60i6oPK3NOuk9EFLmjoEErxk6H4Sic1j9DReiVuA6LhcWkUx30TnXCo/phb2
         lwz4ZyGuAW/mHm+/0eNsbz51+DlaoSyK/+t/NFp4MgWFFoR3cDCcioR6G85ZM0uzdC3k
         tjvcqeSx028EPOnvis30IZG7wW3oR5mmtidilnCiFBQUNPAFHLkuinyuini5g9aGl1UO
         mCVwRQZVpTwT95Kzsastw/55CtWFv8JZhu0yYSeqpPuCBmOOHAoPF+ju+lVViGBjTGzA
         twwGvZGAunPFqv+svd1BZAUODQlcZ6wzozKnicGCMKrnLvTrMX5bIEuUhEXR4ZPUkLkX
         BUpg==
X-Gm-Message-State: AO0yUKWtfDUDrreXtYmzPZ1ygFIuygTxhkL8w+DFbvo59xRvKVVD1djb
        yFnYQmhLc8Ruy6D32Kp/MKI2lg==
X-Google-Smtp-Source: AK7set8YHzFZhlF4nGvlioh0immV7c7RJw5smiE65VQhF7yAnNjifH85xfnz7kikkGdWtEdESDV8iQ==
X-Received: by 2002:a17:903:110d:b0:1a1:93d0:e807 with SMTP id n13-20020a170903110d00b001a193d0e807mr7608803plh.36.1679052779764;
        Fri, 17 Mar 2023 04:32:59 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id e3-20020a17090a818300b00233aacab89esm1182904pjn.48.2023.03.17.04.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 04:32:59 -0700 (PDT)
From:   Shunsuke Mie <mie@igel.co.jp>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shunsuke Mie <mie@igel.co.jp>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [RFC PATCH 04/11] PCI: endpoint: functions/pci-epf-test: Move common difinitions to header file
Date:   Fri, 17 Mar 2023 20:32:31 +0900
Message-Id: <20230317113238.142970-5-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230317113238.142970-1-mie@igel.co.jp>
References: <20230317113238.142970-1-mie@igel.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pci-epf-test and pci_endpoint_test drivers communicate by registers on
PCIe BAR. The register details are duplicated in their code respectively.
Move a common part to an introduced header file from pci-epf-test.

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 37 +---------
 include/linux/pci-epf-test.h                  | 67 +++++++++++++++++++
 2 files changed, 68 insertions(+), 36 deletions(-)
 create mode 100644 include/linux/pci-epf-test.h

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 6955a3d2eb7e..99d8a05b8507 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -17,31 +17,9 @@
 
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
+#include <linux/pci-epf-test.h>
 #include <linux/pci_regs.h>
 
-#define IRQ_TYPE_LEGACY			0
-#define IRQ_TYPE_MSI			1
-#define IRQ_TYPE_MSIX			2
-
-#define COMMAND_RAISE_LEGACY_IRQ	BIT(0)
-#define COMMAND_RAISE_MSI_IRQ		BIT(1)
-#define COMMAND_RAISE_MSIX_IRQ		BIT(2)
-#define COMMAND_READ			BIT(3)
-#define COMMAND_WRITE			BIT(4)
-#define COMMAND_COPY			BIT(5)
-
-#define STATUS_READ_SUCCESS		BIT(0)
-#define STATUS_READ_FAIL		BIT(1)
-#define STATUS_WRITE_SUCCESS		BIT(2)
-#define STATUS_WRITE_FAIL		BIT(3)
-#define STATUS_COPY_SUCCESS		BIT(4)
-#define STATUS_COPY_FAIL		BIT(5)
-#define STATUS_IRQ_RAISED		BIT(6)
-#define STATUS_SRC_ADDR_INVALID		BIT(7)
-#define STATUS_DST_ADDR_INVALID		BIT(8)
-
-#define FLAG_USE_DMA			BIT(0)
-
 #define TIMER_RESOLUTION		1
 
 static struct workqueue_struct *kpcitest_workqueue;
@@ -60,19 +38,6 @@ struct pci_epf_test {
 	const struct pci_epc_features *epc_features;
 };
 
-struct pci_epf_test_reg {
-	u32	magic;
-	u32	command;
-	u32	status;
-	u64	src_addr;
-	u64	dst_addr;
-	u32	size;
-	u32	checksum;
-	u32	irq_type;
-	u32	irq_number;
-	u32	flags;
-} __packed;
-
 static struct pci_epf_header test_header = {
 	.vendorid	= PCI_ANY_ID,
 	.deviceid	= PCI_ANY_ID,
diff --git a/include/linux/pci-epf-test.h b/include/linux/pci-epf-test.h
new file mode 100644
index 000000000000..636057c3377f
--- /dev/null
+++ b/include/linux/pci-epf-test.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __PCI_EPF_TEST_H
+#define __PCI_EPF_TEST_H
+
+struct pci_epf_test_reg {
+#define PCI_ENDPOINT_TEST_MAGIC offsetof(struct pci_epf_test_reg, magic)
+	u32	magic;
+#define PCI_ENDPOINT_TEST_COMMAND offsetof(struct pci_epf_test_reg, command)
+#define COMMAND_RAISE_LEGACY_IRQ		BIT(0)
+#define COMMAND_RAISE_MSI_IRQ			BIT(1)
+#define COMMAND_RAISE_MSIX_IRQ			BIT(2)
+#define COMMAND_READ				BIT(3)
+#define COMMAND_WRITE				BIT(4)
+#define COMMAND_COPY				BIT(5)
+	u32	command;
+#define STATUS_READ_SUCCESS			BIT(0)
+#define STATUS_READ_FAIL			BIT(1)
+#define STATUS_WRITE_SUCCESS			BIT(2)
+#define STATUS_WRITE_FAIL			BIT(3)
+#define STATUS_COPY_SUCCESS			BIT(4)
+#define STATUS_COPY_FAIL			BIT(5)
+#define STATUS_IRQ_RAISED			BIT(6)
+#define STATUS_SRC_ADDR_INVALID			BIT(7)
+#define STATUS_DST_ADDR_INVALID			BIT(8)
+#define PCI_ENDPOINT_TEST_STATUS offsetof(struct pci_epf_test_reg, status)
+	u32	status;
+	union {
+#define PCI_ENDPOINT_TEST_SRC_ADDR offsetof(struct pci_epf_test_reg, src_addr)
+		u64	src_addr;
+		struct {
+#define PCI_ENDPOINT_TEST_LOWER_SRC_ADDR offsetof(struct pci_epf_test_reg, src_low)
+			u32 src_low;
+#define PCI_ENDPOINT_TEST_UPPER_SRC_ADDR offsetof(struct pci_epf_test_reg, src_high)
+			u32 src_high;
+		} __packed;
+	};
+	union {
+#define PCI_ENDPOINT_TEST_DST_ADDR offsetof(struct pci_epf_test_reg, dst_addr)
+		u64	dst_addr;
+		struct {
+#define PCI_ENDPOINT_TEST_LOWER_DST_ADDR offsetof(struct pci_epf_test_reg, dst_low)
+			u32 dst_low;
+#define PCI_ENDPOINT_TEST_UPPER_DST_ADDR offsetof(struct pci_epf_test_reg, dst_high)
+			u32 dst_high;
+		} __packed;
+	};
+#define PCI_ENDPOINT_TEST_SIZE offsetof(struct pci_epf_test_reg, size)
+	u32	size;
+#define PCI_ENDPOINT_TEST_COUNT offsetof(struct pci_epf_test_reg, count)
+	u32 count;
+#define PCI_ENDPOINT_TEST_CHECKSUM offsetof(struct pci_epf_test_reg, checksum)
+	u32	checksum;
+#define PCI_ENDPOINT_TEST_IRQ_TYPE offsetof(struct pci_epf_test_reg, irq_type)
+#define IRQ_TYPE_UNDEFINED			-1
+#define IRQ_TYPE_LEGACY				0
+#define IRQ_TYPE_MSI				1
+#define IRQ_TYPE_MSIX				2
+	u32	irq_type;
+#define PCI_ENDPOINT_TEST_IRQ_NUMBER offsetof(struct pci_epf_test_reg, irq_number)
+	u32	irq_number;
+#define PCI_ENDPOINT_TEST_FLAGS offsetof(struct pci_epf_test_reg, flags)
+#define FLAG_USE_DMA				BIT(0)
+	u32	flags;
+} __packed;
+
+#endif /* __PCI_EPF_TEST_H */
-- 
2.25.1

