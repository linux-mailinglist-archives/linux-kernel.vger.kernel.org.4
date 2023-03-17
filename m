Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5357B6BE82F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 12:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjCQLdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 07:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjCQLdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 07:33:38 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E6AA21A0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 04:33:08 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso7910872pjc.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 04:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112; t=1679052787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ob+dv03gMiw66cBwoU+hYD2Vt8Qv5SEsoU9zMOVBkuQ=;
        b=v0OVgL+DK0/1OLwNt1hvzurF9AgD0O2q65xQcB7iRde3gkzixBT/sZf5kAoAc6NM8n
         jNrxQKU2uVJ95IlWvsLGe9xQq/YJ3Pp0UGKMKFxzddpvDy9xSC15QsTeUNKJ5QbiQqa9
         PSMNxlmk0HnYn6fAMswlbTqW/4ewcMn1GF8BwZN/bKF8nF0PO+5JkIc4JZb9tKsdgrd9
         KdpZqxj4joy6mL0urr8Zyswjk0VO9NzvZmf41sEfhphLTVwt4AyyedBJjwzbR+TN0EmJ
         3wBTUjByYqhE3ty4Mfe/Yk7LCEb/MYdZj3no50Ru+nhtOpUnQLJkkpVy+IsCD1I7t8sc
         l/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679052787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ob+dv03gMiw66cBwoU+hYD2Vt8Qv5SEsoU9zMOVBkuQ=;
        b=Iod22CWEbWvW6MCdc0w1Ofazfvz9YysZxsKXJg3ew3egEHt2VhYjDR9PFVhij3Hmpj
         doMgEMpxLgNs5+01kFsJGGYJ6LLo51NsgicNztPpebhh28DTtR9bHHU+UPNP4xRt+NoM
         RQ+L/Wsyk5Xg6tlPOzo8lBuic2KkcsM4oCrLjoqjV4PDuhsO5LaQTqYDJeLJX1f3XE5H
         AMBsC54Je1H7Q/nIiDSPfKbBY4KxO2BhfvIEqvkjgdjLlx5d8iQfbWnztHtiYzdu5DwR
         mPctAPLA5ilj7toARj9oYpe8+impk+lONyiUWBsFaPMtDcvAiGns/9k8yUixj9b3q0Ar
         /UCQ==
X-Gm-Message-State: AO0yUKUmDYUdl3U/SgSsc808rsfbtYqgDu+UJMNmit5AqMWHohc2JeOe
        LTRdDT+eomOmJc7EvFNvWWZipQ==
X-Google-Smtp-Source: AK7set/4cQfdbVb01q3i9EBygum5/NcOwZKrEbddz29AigoY+K4DZYp+9xpVs6i+I7fm8qg6riVLPw==
X-Received: by 2002:a17:90b:3881:b0:23f:618a:6bed with SMTP id mu1-20020a17090b388100b0023f618a6bedmr1406906pjb.47.1679052787033;
        Fri, 17 Mar 2023 04:33:07 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id e3-20020a17090a818300b00233aacab89esm1182904pjn.48.2023.03.17.04.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 04:33:06 -0700 (PDT)
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
Subject: [RFC PATCH 06/11] misc: pci_endpoint_test: Use a common header file between endpoint driver
Date:   Fri, 17 Mar 2023 20:32:33 +0900
Message-Id: <20230317113238.142970-7-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230317113238.142970-1-mie@igel.co.jp>
References: <20230317113238.142970-1-mie@igel.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Duplicated definitions between pci-epf-test and pci_endpoint_test are
already moved to a header file. Remove the common definitions and include
the header file. In addition, the separate register address writes were
combined into a single write.

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
 drivers/misc/pci_endpoint_test.c | 42 +-------------------------------
 1 file changed, 1 insertion(+), 41 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 55733dee95ad..d4a42e9ab86a 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -22,52 +22,12 @@
 #include <linux/pci_ids.h>
 
 #include <linux/pci_regs.h>
+#include <linux/pci-epf-test.h>
 
 #include <uapi/linux/pcitest.h>
 
 #define DRV_MODULE_NAME				"pci-endpoint-test"
 
-#define IRQ_TYPE_UNDEFINED			-1
-#define IRQ_TYPE_LEGACY				0
-#define IRQ_TYPE_MSI				1
-#define IRQ_TYPE_MSIX				2
-
-#define PCI_ENDPOINT_TEST_MAGIC			0x0
-
-#define PCI_ENDPOINT_TEST_COMMAND		0x4
-#define COMMAND_RAISE_LEGACY_IRQ		BIT(0)
-#define COMMAND_RAISE_MSI_IRQ			BIT(1)
-#define COMMAND_RAISE_MSIX_IRQ			BIT(2)
-#define COMMAND_READ				BIT(3)
-#define COMMAND_WRITE				BIT(4)
-#define COMMAND_COPY				BIT(5)
-
-#define PCI_ENDPOINT_TEST_STATUS		0x8
-#define STATUS_READ_SUCCESS			BIT(0)
-#define STATUS_READ_FAIL			BIT(1)
-#define STATUS_WRITE_SUCCESS			BIT(2)
-#define STATUS_WRITE_FAIL			BIT(3)
-#define STATUS_COPY_SUCCESS			BIT(4)
-#define STATUS_COPY_FAIL			BIT(5)
-#define STATUS_IRQ_RAISED			BIT(6)
-#define STATUS_SRC_ADDR_INVALID			BIT(7)
-#define STATUS_DST_ADDR_INVALID			BIT(8)
-
-#define PCI_ENDPOINT_TEST_LOWER_SRC_ADDR	0x0c
-#define PCI_ENDPOINT_TEST_UPPER_SRC_ADDR	0x10
-
-#define PCI_ENDPOINT_TEST_LOWER_DST_ADDR	0x14
-#define PCI_ENDPOINT_TEST_UPPER_DST_ADDR	0x18
-
-#define PCI_ENDPOINT_TEST_SIZE			0x1c
-#define PCI_ENDPOINT_TEST_CHECKSUM		0x20
-
-#define PCI_ENDPOINT_TEST_IRQ_TYPE		0x24
-#define PCI_ENDPOINT_TEST_IRQ_NUMBER		0x28
-
-#define PCI_ENDPOINT_TEST_FLAGS			0x2c
-#define FLAG_USE_DMA				BIT(0)
-
 #define PCI_DEVICE_ID_TI_AM654			0xb00c
 #define PCI_DEVICE_ID_TI_J7200			0xb00f
 #define PCI_DEVICE_ID_TI_AM64			0xb010
-- 
2.25.1

