Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC12710578
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 07:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbjEYFuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 01:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235439AbjEYFu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 01:50:27 -0400
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74DAE7;
        Wed, 24 May 2023 22:50:21 -0700 (PDT)
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34P4q86u015975;
        Wed, 24 May 2023 22:49:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=proofpoint;
 bh=ORBbS4dG2UZ9jCimxOUvwmwP5/hHFB+CeoRM33HwFE4=;
 b=q6yNzolPf612rI1F+I5dsgvAaRP6fG0YSm++TEgM0qbYL95pd6b//uHA724LJjFdtf1r
 oePLu95+zaDZI5A0zI8EfuXfJ+v/BJvqgwW4CnzeQffylkvGMu+BxVflt8k0tADsXQ3v
 5sBArUJ7akMwjuM1wGzOa+lUXPKAtEJtE4a9mJE4t8rOjpFfg1/jT+YaTsarOriNgi5C
 8GVwWjFne2oLU1S+q2ofQZIKst3FMjqpCOll1ai9aAQnClA5r4LPrF/A35w6+VAw/K5e
 REIi3MVD6bIskn4AEakoMPkme9kjbD8DgoVOmaBLETeGIAeE0dE7eQtLecYm04qcN5ko qw== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3qsvdvrxkc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 22:49:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Czu32WMszaJMi4pCYZz16qJ+A7Dlmza9OcYAK1J/FVq55bjA8HD25n3APewVmPNLdw+p6s4Z5rP6QG/t+d0L0h4LTjGy8HKiYaDFZ74qAMx4arHP98G8CB/pTpi12VmgqwqALY2f6hCBygH4kArMSvDy/U6ky5JmPsWn20SYLIocxFa1/GmWcsC0dughTJSCRRnS6vEZtpO/KMIfenvIvci/bVE8kQ7Pf2NGc7g3F2RwQet5ecgr52VU76kXqL+8wx9JXrrVfC68KHdYoX1M7lvnLnuIwj0wnAi236GVfbXRFv1xx+fNOJOimZF+2b9hPqClVOaJjm6U2nJmOAXGTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ORBbS4dG2UZ9jCimxOUvwmwP5/hHFB+CeoRM33HwFE4=;
 b=Xk5bbEYmnItKvapGggjqigurJacGYpHLu+wzJH/nWPGZFfdmVDOcIULT7oGDf9Bqf7eUiL+LPJzPfS9/0LieTHgA5o/qlok7O2w54Le/o7GaUgi8YhsZNOhoaCbWfn2vlCqqtsL3RmwEobPdXjoUYy1Lxu0aWyrIPwg0Jfik46iT5jNfaaFuwl7jlnWFZKBXGal0+wRZl/qLRPv1L2iqOg5Ltb4d1uaqbqUSFYTOWUe4XQr3FQBOwiVbAhmwAQTdj2ciHad4FzOYS+33v+qxYyd+x6mtA/dsZxnZ6kQLxAwWRishqqTvfSoN1Nhy6jB0XobB1Id/+8SVwvVc3zFySw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=bootlin.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORBbS4dG2UZ9jCimxOUvwmwP5/hHFB+CeoRM33HwFE4=;
 b=FKkEaeqmxcSSmJUgb+3PwfXcURLzOu8arw6ESZtlUmeSIgKRVFWFrRdsTX4CHI0wWrO1+jIHLzVOuIR3UFQI4b+bR7EirhK/1os9ahfuk/HI7Y0WqlrnBWXw6drnBnpu2zuZdOGwTcIIjvSKBkjF5Q5k/vc+4SRN9jB6hKvkMdc=
Received: from BN9PR03CA0272.namprd03.prod.outlook.com (2603:10b6:408:f5::7)
 by DM6PR07MB8096.namprd07.prod.outlook.com (2603:10b6:5:20a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.17; Thu, 25 May
 2023 05:49:48 +0000
Received: from BN8NAM12FT039.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::30) by BN9PR03CA0272.outlook.office365.com
 (2603:10b6:408:f5::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15 via Frontend
 Transport; Thu, 25 May 2023 05:49:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com; pr=C
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 BN8NAM12FT039.mail.protection.outlook.com (10.13.182.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.17 via Frontend Transport; Thu, 25 May 2023 05:49:48 +0000
Received: from maileu4.global.cadence.com (eudvw-maileu4.cadence.com [10.160.110.201])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 34P5nikF014335
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 May 2023 22:49:45 -0700
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 25 May 2023 07:49:43 +0200
Received: from eu-cn02.cadence.com (10.160.89.185) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7
 via Frontend Transport; Thu, 25 May 2023 07:49:43 +0200
Received: from eu-cn02.cadence.com (localhost.localdomain [127.0.0.1])
        by eu-cn02.cadence.com (8.14.7/8.14.7) with ESMTP id 34P5nhQG243899;
        Thu, 25 May 2023 01:49:43 -0400
Received: (from pawell@localhost)
        by eu-cn02.cadence.com (8.14.7/8.14.7/Submit) id 34P5nhmi243898;
        Thu, 25 May 2023 01:49:43 -0400
From:   Pawel Laszczak <pawell@cadence.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <Daisy.Barrera@siriusxm.com>, <Cliff.Holden@siriusxm.com>,
        <tony@atomide.com>, <jdelvare@suse.de>, <neal_liu@aspeedtech.com>,
        <linus.walleij@linaro.org>, <egtvedt@samfundet.no>,
        <biju.das.jz@bp.renesas.com>, <herve.codina@bootlin.com>,
        Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v3 2/4] usb: cdns2: Add main part of Cadence USBHS driver
Date:   Thu, 25 May 2023 01:49:14 -0400
Message-ID: <20230525054916.243330-3-pawell@cadence.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230525054916.243330-1-pawell@cadence.com>
References: <20230525054916.243330-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-CrossPremisesHeadersFilteredBySendConnector: maileu4.global.cadence.com
X-OrganizationHeadersPreserved: maileu4.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM12FT039:EE_|DM6PR07MB8096:EE_
X-MS-Office365-Filtering-Correlation-Id: 78c7513d-a3a9-4af9-7491-08db5ce3d9bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WKaByKSVJG7wLRwubb2zn2GUfnxn16y716tvpiIeCBDroS7eEOUFx45j85bXw50vCq0NJMhCsrqDQgkBL8rITU6tcGPJ6mA4t43nVYIH/sPrKIFspLAkFfID5zt1rH72OIypPQhxwHK98G9x0uWmcIIiddKDFbupR2aX8q/KvVKTi54SFDd2DoVoRbZpLMCg9UbJtb0+3Id5RH60n0d2elT/V1xXuRe0ezjKEYTIbZpqJ6mkxWW+viT5D/e8aOYlW5lzWbUBZwbX15kiIWGt2Ie2hM2jqLX/AZtY6WJjeFt+PdsLJK4zF786ZBH3LFVTNDfYHh341+hcB9ZwzibWPzn/RgTvHMP8WtU4BFVK4/1wLK2Fkr+BRAv7/NTiVOKG6HrECfIP/1BW3hQQT6ecSyc3ZadI46H6GmHVqx3TB8z5ullwZNd5yYjPJLuUqA8xMTPQOtSlQPsHuoSmlk03N+JAMFEEUO/fHWxIl3n8tSDngFgVkF6XFJgpOs6iiVs4XIndomLKz9QBti0uU5tlbaXiP0zYUYjKzaBtyWAaFeVqd9l+7TrP7KsZLaTrFYe3ztpLNtoHpbgqzAJdMeDwsMwfLm07n6I7i2EqLj6KZPw9kNMYBTEicHpi4nW8IbC/w27xIwuCRMgfLfKuqdmLpN3+GpzvzkYaFliJWLlRvMuYzYwdSaCDPl6iB1J5bnEdRxeszxO4xvB5ypVisBCLxiJWW6QNtIqkB8L4Dn6HqXdKjwG3QMO1ie50LSdW3z278a0lc93f/wpCxnzMaixO3dXv+kXnzvbsyZqPiLwsJvql3YNZuKv6/lq5cgo/RIj7jqT+ETbGmiXVX5ZUcYyzRA==
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(376002)(396003)(36092001)(451199021)(36840700001)(46966006)(40470700004)(6666004)(40460700003)(41300700001)(107886003)(7416002)(26005)(1076003)(8936002)(8676002)(36756003)(5660300002)(36860700001)(2616005)(82310400005)(83380400001)(47076005)(426003)(336012)(2906002)(30864003)(186003)(86362001)(356005)(7636003)(40480700001)(82740400003)(6916009)(4326008)(70586007)(70206006)(54906003)(42186006)(478600001)(316002)(559001)(579004)(309714004)(473944003)(414714003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 05:49:48.1742
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78c7513d-a3a9-4af9-7491-08db5ce3d9bd
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT039.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB8096
X-Proofpoint-GUID: 4HBFEkPz0F0AI8t6DD4irBltq6t6od_c
X-Proofpoint-ORIG-GUID: 4HBFEkPz0F0AI8t6DD4irBltq6t6od_c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_02,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 clxscore=1015
 phishscore=0 mlxscore=0 impostorscore=0 adultscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305250045
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces the main part of Cadence USBHS driver
to Linux kernel.
To reduce the patch size a little bit, the header file gadget.h was
intentionally added as separate patch.

The Cadence USB 2.0 Controller is a highly configurable IP Core which
supports both full and high speed data transfer.

The current driver has been validated with FPGA platform. We have
support for PCIe bus, which is used on FPGA prototyping.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/gadget/udc/Kconfig              |    2 +
 drivers/usb/gadget/udc/Makefile             |    1 +
 drivers/usb/gadget/udc/cdns2/Kconfig        |   11 +
 drivers/usb/gadget/udc/cdns2/Makefile       |    5 +
 drivers/usb/gadget/udc/cdns2/cdns2-ep0.c    |  638 +++++
 drivers/usb/gadget/udc/cdns2/cdns2-gadget.c | 2426 +++++++++++++++++++
 drivers/usb/gadget/udc/cdns2/cdns2-pci.c    |  149 ++
 7 files changed, 3232 insertions(+)
 create mode 100644 drivers/usb/gadget/udc/cdns2/Kconfig
 create mode 100644 drivers/usb/gadget/udc/cdns2/Makefile
 create mode 100644 drivers/usb/gadget/udc/cdns2/cdns2-ep0.c
 create mode 100644 drivers/usb/gadget/udc/cdns2/cdns2-gadget.c
 create mode 100644 drivers/usb/gadget/udc/cdns2/cdns2-pci.c

diff --git a/drivers/usb/gadget/udc/Kconfig b/drivers/usb/gadget/udc/Kconfig
index 83cae6bb12eb..aae1787320d4 100644
--- a/drivers/usb/gadget/udc/Kconfig
+++ b/drivers/usb/gadget/udc/Kconfig
@@ -463,6 +463,8 @@ config USB_ASPEED_UDC
 
 source "drivers/usb/gadget/udc/aspeed-vhub/Kconfig"
 
+source "drivers/usb/gadget/udc/cdns2/Kconfig"
+
 #
 # LAST -- dummy/emulated controller
 #
diff --git a/drivers/usb/gadget/udc/Makefile b/drivers/usb/gadget/udc/Makefile
index ee569f63c74a..b52f93e9c61d 100644
--- a/drivers/usb/gadget/udc/Makefile
+++ b/drivers/usb/gadget/udc/Makefile
@@ -42,3 +42,4 @@ obj-$(CONFIG_USB_ASPEED_VHUB)	+= aspeed-vhub/
 obj-$(CONFIG_USB_ASPEED_UDC)	+= aspeed_udc.o
 obj-$(CONFIG_USB_BDC_UDC)	+= bdc/
 obj-$(CONFIG_USB_MAX3420_UDC)	+= max3420_udc.o
+obj-$(CONFIG_USB_CDNS2_UDC)	+= cdns2/
diff --git a/drivers/usb/gadget/udc/cdns2/Kconfig b/drivers/usb/gadget/udc/cdns2/Kconfig
new file mode 100644
index 000000000000..310db4788353
--- /dev/null
+++ b/drivers/usb/gadget/udc/cdns2/Kconfig
@@ -0,0 +1,11 @@
+config USB_CDNS2_UDC
+	tristate "Cadence USBHS Device Controller"
+	depends on USB_PCI && ACPI && HAS_DMA
+	help
+	  Cadence USBHS Device controller is a PCI based USB peripheral
+	  controller which supports both full and high speed USB 2.0
+	  data transfers.
+
+	  Say "y" to link the driver statically, or "m" to build a
+	  dynamically linked module called "cdns2-pci.ko" and to
+	  force all gadget drivers to also be dynamically linked.
diff --git a/drivers/usb/gadget/udc/cdns2/Makefile b/drivers/usb/gadget/udc/cdns2/Makefile
new file mode 100644
index 000000000000..7c746e6d53c2
--- /dev/null
+++ b/drivers/usb/gadget/udc/cdns2/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+# define_trace.h needs to know how to find our header
+
+obj-$(CONFIG_USB_CDNS2_UDC)		+= cdns2-udc-pci.o
+cdns2-udc-pci-$(CONFIG_USB_CDNS2_UDC)	+= cdns2-pci.o cdns2-gadget.o cdns2-ep0.o
diff --git a/drivers/usb/gadget/udc/cdns2/cdns2-ep0.c b/drivers/usb/gadget/udc/cdns2/cdns2-ep0.c
new file mode 100644
index 000000000000..5516304dd483
--- /dev/null
+++ b/drivers/usb/gadget/udc/cdns2/cdns2-ep0.c
@@ -0,0 +1,638 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Cadence USBHS-DEV driver.
+ *
+ * Copyright (C) 2023 Cadence Design Systems.
+ *
+ * Authors: Pawel Laszczak <pawell@cadence.com>
+ */
+
+#include <linux/usb/composite.h>
+#include <asm/unaligned.h>
+
+#include "cdns2-gadget.h"
+
+static struct usb_endpoint_descriptor cdns2_gadget_ep0_desc = {
+	.bLength = USB_DT_ENDPOINT_SIZE,
+	.bDescriptorType = USB_DT_ENDPOINT,
+	.bmAttributes =	 USB_ENDPOINT_XFER_CONTROL,
+	.wMaxPacketSize = cpu_to_le16(64)
+};
+
+static int cdns2_w_index_to_ep_index(u16 wIndex)
+{
+	if (!(wIndex & USB_ENDPOINT_NUMBER_MASK))
+		return 0;
+
+	return ((wIndex & USB_ENDPOINT_NUMBER_MASK) * 2) +
+		(wIndex & USB_ENDPOINT_DIR_MASK ? 1 : 0) - 1;
+}
+
+static bool cdns2_check_new_setup(struct cdns2_device *pdev)
+{
+	u8 reg;
+
+	reg = readb(&pdev->ep0_regs->cs);
+
+	return !!(reg & EP0CS_CHGSET);
+}
+
+static void cdns2_ep0_enqueue(struct cdns2_device *pdev, dma_addr_t dma_addr,
+			      unsigned int length, int zlp)
+{
+	struct cdns2_adma_regs __iomem *regs = pdev->adma_regs;
+	struct cdns2_endpoint *pep = &pdev->eps[0];
+	struct cdns2_ring *ring = &pep->ring;
+
+	ring->trbs[0].buffer = cpu_to_le32(TRB_BUFFER(dma_addr));
+	ring->trbs[0].length = cpu_to_le32(TRB_LEN(length));
+
+	if (zlp) {
+		ring->trbs[0].control = cpu_to_le32(TRB_CYCLE |
+						    TRB_TYPE(TRB_NORMAL));
+		ring->trbs[1].buffer = cpu_to_le32(TRB_BUFFER(dma_addr));
+		ring->trbs[1].length = cpu_to_le32(TRB_LEN(0));
+		ring->trbs[1].control = cpu_to_le32(TRB_CYCLE | TRB_IOC |
+					TRB_TYPE(TRB_NORMAL));
+	} else {
+		ring->trbs[0].control = cpu_to_le32(TRB_CYCLE | TRB_IOC |
+					TRB_TYPE(TRB_NORMAL));
+		ring->trbs[1].control = 0;
+	}
+
+	if (!pep->dir)
+		writel(0, &pdev->ep0_regs->rxbc);
+
+	cdns2_select_ep(pdev, pep->dir);
+
+	writel(DMA_EP_STS_TRBERR, &regs->ep_sts);
+	writel(pep->ring.dma, &regs->ep_traddr);
+
+	writel(DMA_EP_CMD_DRDY, &regs->ep_cmd);
+}
+
+static int cdns2_ep0_delegate_req(struct cdns2_device *pdev)
+{
+	int ret;
+
+	spin_unlock(&pdev->lock);
+	ret = pdev->gadget_driver->setup(&pdev->gadget, &pdev->setup);
+	spin_lock(&pdev->lock);
+
+	return ret;
+}
+
+static void cdns2_ep0_stall(struct cdns2_device *pdev)
+{
+	struct cdns2_endpoint *pep = &pdev->eps[0];
+	struct cdns2_request *preq;
+
+	preq = cdns2_next_preq(&pep->pending_list);
+	set_reg_bit_8(&pdev->ep0_regs->cs, EP0CS_DSTALL);
+
+	if (pdev->ep0_stage == CDNS2_DATA_STAGE && preq)
+		cdns2_gadget_giveback(pep, preq, -ECONNRESET);
+	else if (preq)
+		list_del_init(&preq->list);
+
+	pdev->ep0_stage = CDNS2_SETUP_STAGE;
+	pep->ep_state |= EP_STALLED;
+}
+
+static void cdns2_status_stage(struct cdns2_device *pdev)
+{
+	struct cdns2_endpoint *pep = &pdev->eps[0];
+	struct cdns2_request *preq;
+
+	preq = cdns2_next_preq(&pep->pending_list);
+	if (preq)
+		list_del_init(&preq->list);
+
+	pdev->ep0_stage = CDNS2_SETUP_STAGE;
+	writeb(EP0CS_HSNAK, &pdev->ep0_regs->cs);
+}
+
+static int cdns2_req_ep0_set_configuration(struct cdns2_device *pdev,
+					   struct usb_ctrlrequest *ctrl_req)
+{
+	enum usb_device_state state = pdev->gadget.state;
+	u32 config = le16_to_cpu(ctrl_req->wValue);
+	int ret;
+
+	if (state < USB_STATE_ADDRESS) {
+		dev_err(pdev->dev, "Set Configuration - bad device state\n");
+		return -EINVAL;
+	}
+
+	ret = cdns2_ep0_delegate_req(pdev);
+	if (ret)
+		return ret;
+
+	if (!config)
+		usb_gadget_set_state(&pdev->gadget, USB_STATE_ADDRESS);
+
+	return 0;
+}
+
+static int cdns2_req_ep0_set_address(struct cdns2_device *pdev, u32 addr)
+{
+	enum usb_device_state device_state = pdev->gadget.state;
+	u8 reg;
+
+	if (addr > USB_DEVICE_MAX_ADDRESS) {
+		dev_err(pdev->dev,
+			"Device address (%d) cannot be greater than %d\n",
+			addr, USB_DEVICE_MAX_ADDRESS);
+		return -EINVAL;
+	}
+
+	if (device_state == USB_STATE_CONFIGURED) {
+		dev_err(pdev->dev,
+			"can't set_address from configured state\n");
+		return -EINVAL;
+	}
+
+	reg = readb(&pdev->usb_regs->fnaddr);
+	pdev->dev_address = reg;
+
+	usb_gadget_set_state(&pdev->gadget,
+			     (addr ? USB_STATE_ADDRESS : USB_STATE_DEFAULT));
+
+	return 0;
+}
+
+static int cdns2_req_ep0_handle_status(struct cdns2_device *pdev,
+				       struct usb_ctrlrequest *ctrl)
+{
+	struct cdns2_endpoint *pep;
+	__le16 *response_pkt;
+	u16 status = 0;
+	int ep_sts;
+	u32 recip;
+
+	recip = ctrl->bRequestType & USB_RECIP_MASK;
+
+	switch (recip) {
+	case USB_RECIP_DEVICE:
+		status = pdev->gadget.is_selfpowered;
+		status |= pdev->may_wakeup << USB_DEVICE_REMOTE_WAKEUP;
+		break;
+	case USB_RECIP_INTERFACE:
+		return cdns2_ep0_delegate_req(pdev);
+	case USB_RECIP_ENDPOINT:
+		ep_sts = cdns2_w_index_to_ep_index(le16_to_cpu(ctrl->wIndex));
+		pep = &pdev->eps[ep_sts];
+
+		if (pep->ep_state & EP_STALLED)
+			status =  BIT(USB_ENDPOINT_HALT);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	put_unaligned_le16(status, (__le16 *)pdev->ep0_preq.request.buf);
+
+	cdns2_ep0_enqueue(pdev, pdev->ep0_preq.request.dma,
+			  sizeof(*response_pkt), 0);
+
+	return 0;
+}
+
+static int cdns2_ep0_handle_feature_device(struct cdns2_device *pdev,
+					   struct usb_ctrlrequest *ctrl,
+					   int set)
+{
+	enum usb_device_state state;
+	enum usb_device_speed speed;
+	int ret = 0;
+	u32 wValue;
+	u16 tmode;
+
+	wValue = le16_to_cpu(ctrl->wValue);
+	state = pdev->gadget.state;
+	speed = pdev->gadget.speed;
+
+	switch (wValue) {
+	case USB_DEVICE_REMOTE_WAKEUP:
+		pdev->may_wakeup = !!set;
+		break;
+	case USB_DEVICE_TEST_MODE:
+		if (state != USB_STATE_CONFIGURED || speed > USB_SPEED_HIGH)
+			return -EINVAL;
+
+		tmode = le16_to_cpu(ctrl->wIndex);
+
+		if (!set || (tmode & 0xff) != 0)
+			return -EINVAL;
+
+		tmode >>= 8;
+		switch (tmode) {
+		case USB_TEST_J:
+		case USB_TEST_K:
+		case USB_TEST_SE0_NAK:
+		case USB_TEST_PACKET:
+			/*
+			 * The USBHS controller automatically handles the
+			 * Set_Feature(testmode) request. Standard test modes
+			 * that use values of test mode selector from
+			 * 01h to 04h (Test_J, Test_K, Test_SE0_NAK,
+			 * Test_Packet) are supported by the
+			 * controller(HS - ack, FS - stall).
+			 */
+			break;
+		default:
+			ret = -EINVAL;
+		}
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int cdns2_ep0_handle_feature_intf(struct cdns2_device *pdev,
+					 struct usb_ctrlrequest *ctrl,
+					 int set)
+{
+	int ret = 0;
+	u32 wValue;
+
+	wValue = le16_to_cpu(ctrl->wValue);
+
+	switch (wValue) {
+	case USB_INTRF_FUNC_SUSPEND:
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int cdns2_ep0_handle_feature_endpoint(struct cdns2_device *pdev,
+					     struct usb_ctrlrequest *ctrl,
+					     int set)
+{
+	struct cdns2_endpoint *pep;
+	int ret = 0;
+	u8 wValue;
+
+	wValue = le16_to_cpu(ctrl->wValue);
+	pep = &pdev->eps[cdns2_w_index_to_ep_index(le16_to_cpu(ctrl->wIndex))];
+
+	if (wValue != USB_ENDPOINT_HALT)
+		return -EINVAL;
+
+	if (!(le16_to_cpu(ctrl->wIndex) & ~USB_DIR_IN))
+		return 0;
+
+	switch (wValue) {
+	case USB_ENDPOINT_HALT:
+		if (set || !(pep->ep_state & EP_WEDGE))
+			return cdns2_halt_endpoint(pdev, pep, set);
+		break;
+	default:
+		dev_warn(pdev->dev, "WARN Incorrect wValue %04x\n", wValue);
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int cdns2_req_ep0_handle_feature(struct cdns2_device *pdev,
+					struct usb_ctrlrequest *ctrl,
+					int set)
+{
+	switch (ctrl->bRequestType & USB_RECIP_MASK) {
+	case USB_RECIP_DEVICE:
+		return cdns2_ep0_handle_feature_device(pdev, ctrl, set);
+	case USB_RECIP_INTERFACE:
+		return cdns2_ep0_handle_feature_intf(pdev, ctrl, set);
+	case USB_RECIP_ENDPOINT:
+		return cdns2_ep0_handle_feature_endpoint(pdev, ctrl, set);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int cdns2_ep0_std_request(struct cdns2_device *pdev)
+{
+	struct usb_ctrlrequest *ctrl = &pdev->setup;
+	int ret;
+
+	switch (ctrl->bRequest) {
+	case USB_REQ_SET_ADDRESS:
+		ret = cdns2_req_ep0_set_address(pdev,
+						le16_to_cpu(ctrl->wValue));
+		break;
+	case USB_REQ_SET_CONFIGURATION:
+		ret = cdns2_req_ep0_set_configuration(pdev, ctrl);
+		break;
+	case USB_REQ_GET_STATUS:
+		ret = cdns2_req_ep0_handle_status(pdev, ctrl);
+		break;
+	case USB_REQ_CLEAR_FEATURE:
+		ret = cdns2_req_ep0_handle_feature(pdev, ctrl, 0);
+		break;
+	case USB_REQ_SET_FEATURE:
+		ret = cdns2_req_ep0_handle_feature(pdev, ctrl, 1);
+		break;
+	default:
+		ret = cdns2_ep0_delegate_req(pdev);
+		break;
+	}
+
+	return ret;
+}
+
+static void __pending_setup_status_handler(struct cdns2_device *pdev)
+{
+	struct usb_request *request = pdev->pending_status_request;
+
+	if (pdev->status_completion_no_call && request && request->complete) {
+		request->complete(&pdev->eps[0].endpoint, request);
+		pdev->status_completion_no_call = 0;
+	}
+}
+
+void cdns2_pending_setup_status_handler(struct work_struct *work)
+{
+	struct cdns2_device *pdev = container_of(work, struct cdns2_device,
+						 pending_status_wq);
+	unsigned long flags;
+
+	spin_lock_irqsave(&pdev->lock, flags);
+	__pending_setup_status_handler(pdev);
+	spin_unlock_irqrestore(&pdev->lock, flags);
+}
+
+void cdns2_handle_setup_packet(struct cdns2_device *pdev)
+{
+	struct usb_ctrlrequest *ctrl = &pdev->setup;
+	struct cdns2_endpoint *pep = &pdev->eps[0];
+	struct cdns2_request *preq;
+	int ret = 0;
+	u16 len;
+	u8 reg;
+	int i;
+
+	writeb(EP0CS_CHGSET, &pdev->ep0_regs->cs);
+
+	for (i = 0; i < 8; i++)
+		((u8 *)&pdev->setup)[i] = readb(&pdev->ep0_regs->setupdat[i]);
+
+	/*
+	 * If SETUP packet was modified while reading just simple ignore it.
+	 * The new one will be handled latter.
+	 */
+	if (cdns2_check_new_setup(pdev))
+		return;
+
+	if (!pdev->gadget_driver)
+		goto out;
+
+	if (pdev->gadget.state == USB_STATE_NOTATTACHED) {
+		dev_err(pdev->dev, "ERR: Setup detected in unattached state\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	pep = &pdev->eps[0];
+
+	/* Halt for Ep0 is cleared automatically when SETUP packet arrives. */
+	pep->ep_state &= ~EP_STALLED;
+
+	if (!list_empty(&pep->pending_list)) {
+		preq = cdns2_next_preq(&pep->pending_list);
+		cdns2_gadget_giveback(pep, preq, -ECONNRESET);
+	}
+
+	len = le16_to_cpu(ctrl->wLength);
+	if (len)
+		pdev->ep0_stage = CDNS2_DATA_STAGE;
+	else
+		pdev->ep0_stage = CDNS2_STATUS_STAGE;
+
+	pep->dir = ctrl->bRequestType & USB_DIR_IN;
+
+	/*
+	 * SET_ADDRESS request is acknowledged automatically by controller and
+	 * in the worse case driver may not notice this request. To check
+	 * whether this request has been processed driver can use
+	 * fnaddr register.
+	 */
+	reg = readb(&pdev->usb_regs->fnaddr);
+	if (pdev->setup.bRequest != USB_REQ_SET_ADDRESS &&
+	    pdev->dev_address != reg)
+		cdns2_req_ep0_set_address(pdev, reg);
+
+	if ((ctrl->bRequestType & USB_TYPE_MASK) == USB_TYPE_STANDARD)
+		ret = cdns2_ep0_std_request(pdev);
+	else
+		ret = cdns2_ep0_delegate_req(pdev);
+
+	if (ret == USB_GADGET_DELAYED_STATUS)
+		return;
+
+out:
+	if (ret < 0)
+		cdns2_ep0_stall(pdev);
+	else if (pdev->ep0_stage == CDNS2_STATUS_STAGE)
+		cdns2_status_stage(pdev);
+}
+
+static void cdns2_transfer_completed(struct cdns2_device *pdev)
+{
+	struct cdns2_endpoint *pep = &pdev->eps[0];
+
+	if (!list_empty(&pep->pending_list)) {
+		struct cdns2_request *preq;
+
+		preq = cdns2_next_preq(&pep->pending_list);
+
+		preq->request.actual =
+			TRB_LEN(le32_to_cpu(pep->ring.trbs->length));
+		cdns2_gadget_giveback(pep, preq, 0);
+	}
+
+	cdns2_status_stage(pdev);
+}
+
+void cdns2_handle_ep0_interrupt(struct cdns2_device *pdev, int dir)
+{
+	u32 ep_sts_reg;
+
+	cdns2_select_ep(pdev, dir);
+
+	ep_sts_reg = readl(&pdev->adma_regs->ep_sts);
+	writel(ep_sts_reg, &pdev->adma_regs->ep_sts);
+
+	__pending_setup_status_handler(pdev);
+
+	if ((ep_sts_reg & DMA_EP_STS_IOC) || (ep_sts_reg & DMA_EP_STS_ISP)) {
+		pdev->eps[0].dir = dir;
+		cdns2_transfer_completed(pdev);
+	}
+}
+
+/*
+ * Function shouldn't be called by gadget driver,
+ * endpoint 0 is allways active.
+ */
+static int cdns2_gadget_ep0_enable(struct usb_ep *ep,
+				   const struct usb_endpoint_descriptor *desc)
+{
+	return -EINVAL;
+}
+
+/*
+ * Function shouldn't be called by gadget driver,
+ * endpoint 0 is allways active.
+ */
+static int cdns2_gadget_ep0_disable(struct usb_ep *ep)
+{
+	return -EINVAL;
+}
+
+static int cdns2_gadget_ep0_set_halt(struct usb_ep *ep, int value)
+{
+	struct cdns2_endpoint *pep = ep_to_cdns2_ep(ep);
+	struct cdns2_device *pdev = pep->pdev;
+	unsigned long flags;
+
+	if (!value)
+		return 0;
+
+	spin_lock_irqsave(&pdev->lock, flags);
+	cdns2_ep0_stall(pdev);
+	spin_unlock_irqrestore(&pdev->lock, flags);
+
+	return 0;
+}
+
+static int cdns2_gadget_ep0_set_wedge(struct usb_ep *ep)
+{
+	return cdns2_gadget_ep0_set_halt(ep, 1);
+}
+
+static int cdns2_gadget_ep0_queue(struct usb_ep *ep,
+				  struct usb_request *request,
+				  gfp_t gfp_flags)
+{
+	struct cdns2_endpoint *pep = ep_to_cdns2_ep(ep);
+	struct cdns2_device *pdev = pep->pdev;
+	struct cdns2_request *preq;
+	unsigned long flags;
+	int ret = 0;
+	u8 zlp = 0;
+
+	spin_lock_irqsave(&pdev->lock, flags);
+
+	preq = to_cdns2_request(request);
+
+	/* Cancel the request if controller receive new SETUP packet. */
+	if (cdns2_check_new_setup(pdev)) {
+		spin_unlock_irqrestore(&pdev->lock, flags);
+		return -ECONNRESET;
+	}
+
+	/* Send STATUS stage. Should be called only for SET_CONFIGURATION. */
+	if (pdev->ep0_stage == CDNS2_STATUS_STAGE) {
+		cdns2_status_stage(pdev);
+
+		request->actual = 0;
+		pdev->status_completion_no_call = true;
+		pdev->pending_status_request = request;
+		usb_gadget_set_state(&pdev->gadget, USB_STATE_CONFIGURED);
+		spin_unlock_irqrestore(&pdev->lock, flags);
+
+		/*
+		 * Since there is no completion interrupt for status stage,
+		 * it needs to call ->completion in software after
+		 * cdns2_gadget_ep0_queue is back.
+		 */
+		queue_work(system_freezable_wq, &pdev->pending_status_wq);
+		return ret;
+	}
+
+	if (!list_empty(&pep->pending_list)) {
+		dev_err(pdev->dev,
+			"can't handle multiple requests for ep0\n");
+		spin_unlock_irqrestore(&pdev->lock, flags);
+		return -EBUSY;
+	}
+
+	ret = usb_gadget_map_request_by_dev(pdev->dev, request, pep->dir);
+	if (ret) {
+		spin_unlock_irqrestore(&pdev->lock, flags);
+		dev_err(pdev->dev, "failed to map request\n");
+		return -EINVAL;
+	}
+
+	request->status = -EINPROGRESS;
+	list_add_tail(&preq->list, &pep->pending_list);
+
+	if (request->zero && request->length &&
+	    (request->length % ep->maxpacket == 0))
+		zlp = 1;
+
+	cdns2_ep0_enqueue(pdev, request->dma, request->length, zlp);
+
+	spin_unlock_irqrestore(&pdev->lock, flags);
+
+	return ret;
+}
+
+static const struct usb_ep_ops cdns2_gadget_ep0_ops = {
+	.enable = cdns2_gadget_ep0_enable,
+	.disable = cdns2_gadget_ep0_disable,
+	.alloc_request = cdns2_gadget_ep_alloc_request,
+	.free_request = cdns2_gadget_ep_free_request,
+	.queue = cdns2_gadget_ep0_queue,
+	.dequeue = cdns2_gadget_ep_dequeue,
+	.set_halt = cdns2_gadget_ep0_set_halt,
+	.set_wedge = cdns2_gadget_ep0_set_wedge,
+};
+
+void cdns2_ep0_config(struct cdns2_device *pdev)
+{
+	struct cdns2_endpoint *pep;
+
+	pep = &pdev->eps[0];
+
+	if (!list_empty(&pep->pending_list)) {
+		struct cdns2_request *preq;
+
+		preq = cdns2_next_preq(&pep->pending_list);
+		list_del_init(&preq->list);
+	}
+
+	writeb(EP0_FIFO_AUTO, &pdev->ep0_regs->fifo);
+	cdns2_select_ep(pdev, USB_DIR_OUT);
+	writel(DMA_EP_CFG_ENABLE, &pdev->adma_regs->ep_cfg);
+
+	writeb(EP0_FIFO_IO_TX | EP0_FIFO_AUTO, &pdev->ep0_regs->fifo);
+	cdns2_select_ep(pdev, USB_DIR_IN);
+	writel(DMA_EP_CFG_ENABLE, &pdev->adma_regs->ep_cfg);
+
+	writeb(pdev->gadget.ep0->maxpacket, &pdev->ep0_regs->maxpack);
+	writel(DMA_EP_IEN_EP_OUT0 | DMA_EP_IEN_EP_IN0,
+	       &pdev->adma_regs->ep_ien);
+}
+
+void cdns2_init_ep0(struct cdns2_device *pdev,
+		    struct cdns2_endpoint *pep)
+{
+	u16 maxpacket = le16_to_cpu(cdns2_gadget_ep0_desc.wMaxPacketSize);
+
+	usb_ep_set_maxpacket_limit(&pep->endpoint, maxpacket);
+
+	pep->endpoint.ops = &cdns2_gadget_ep0_ops;
+	pep->endpoint.desc = &cdns2_gadget_ep0_desc;
+	pep->endpoint.caps.type_control = true;
+	pep->endpoint.caps.dir_in = true;
+	pep->endpoint.caps.dir_out = true;
+
+	pdev->gadget.ep0 = &pep->endpoint;
+}
diff --git a/drivers/usb/gadget/udc/cdns2/cdns2-gadget.c b/drivers/usb/gadget/udc/cdns2/cdns2-gadget.c
new file mode 100644
index 000000000000..f030c0d1de89
--- /dev/null
+++ b/drivers/usb/gadget/udc/cdns2/cdns2-gadget.c
@@ -0,0 +1,2426 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Cadence USBHS-DEV Driver - gadget side.
+ *
+ * Copyright (C) 2023 Cadence Design Systems.
+ *
+ * Authors: Pawel Laszczak <pawell@cadence.com>
+ */
+
+/*
+ * Work around 1:
+ * At some situations, the controller may get stale data address in TRB
+ * at below sequences:
+ * 1. Controller read TRB includes data address
+ * 2. Software updates TRBs includes data address and Cycle bit
+ * 3. Controller read TRB which includes Cycle bit
+ * 4. DMA run with stale data address
+ *
+ * To fix this problem, driver needs to make the first TRB in TD as invalid.
+ * After preparing all TRBs driver needs to check the position of DMA and
+ * if the DMA point to the first just added TRB and doorbell is 1,
+ * then driver must defer making this TRB as valid. This TRB will be make
+ * as valid during adding next TRB only if DMA is stopped or at TRBERR
+ * interrupt.
+ *
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/pm_runtime.h>
+#include <linux/interrupt.h>
+#include <linux/property.h>
+#include <linux/dmapool.h>
+#include <linux/iopoll.h>
+
+#include "cdns2-gadget.h"
+
+/**
+ * set_reg_bit_32 - set bit in given 32 bits register.
+ * @ptr: register address.
+ * @mask: bits to set.
+ */
+static void set_reg_bit_32(void __iomem *ptr, u32 mask)
+{
+	mask = readl(ptr) | mask;
+	writel(mask, ptr);
+}
+
+/*
+ * clear_reg_bit_32 - clear bit in given 32 bits register.
+ * @ptr: register address.
+ * @mask: bits to clear.
+ */
+static void clear_reg_bit_32(void __iomem *ptr, u32 mask)
+{
+	mask = readl(ptr) & ~mask;
+	writel(mask, ptr);
+}
+
+/* Clear bit in given 8 bits register. */
+static void clear_reg_bit_8(void __iomem *ptr, u8 mask)
+{
+	mask = readb(ptr) & ~mask;
+	writeb(mask, ptr);
+}
+
+/* Set bit in given 16 bits register. */
+void set_reg_bit_8(void __iomem *ptr, u8 mask)
+{
+	mask = readb(ptr) | mask;
+	writeb(mask, ptr);
+}
+
+static int cdns2_get_dma_pos(struct cdns2_device *pdev,
+			     struct cdns2_endpoint *pep)
+{
+	int dma_index;
+
+	dma_index = readl(&pdev->adma_regs->ep_traddr) - pep->ring.dma;
+
+	return dma_index / TRB_SIZE;
+}
+
+/* Get next private request from list. */
+struct cdns2_request *cdns2_next_preq(struct list_head *list)
+{
+	return list_first_entry_or_null(list, struct cdns2_request, list);
+}
+
+void cdns2_select_ep(struct cdns2_device *pdev, u32 ep)
+{
+	if (pdev->selected_ep == ep)
+		return;
+
+	pdev->selected_ep = ep;
+	writel(ep, &pdev->adma_regs->ep_sel);
+}
+
+dma_addr_t cdns2_trb_virt_to_dma(struct cdns2_endpoint *pep,
+				 struct cdns2_trb *trb)
+{
+	u32 offset = (char *)trb - (char *)pep->ring.trbs;
+
+	return pep->ring.dma + offset;
+}
+
+static void cdns2_free_tr_segment(struct cdns2_endpoint *pep)
+{
+	struct cdns2_device *pdev = pep->pdev;
+	struct cdns2_ring *ring = &pep->ring;
+
+	if (pep->ring.trbs) {
+		dma_pool_free(pdev->eps_dma_pool, ring->trbs, ring->dma);
+		memset(ring, 0, sizeof(*ring));
+	}
+}
+
+/* Allocates Transfer Ring segment. */
+static int cdns2_alloc_tr_segment(struct cdns2_endpoint *pep)
+{
+	struct cdns2_device *pdev = pep->pdev;
+	struct cdns2_trb *link_trb;
+	struct cdns2_ring *ring;
+
+	ring = &pep->ring;
+
+	if (!ring->trbs) {
+		ring->trbs = dma_pool_alloc(pdev->eps_dma_pool,
+					    GFP_DMA32 | GFP_ATOMIC,
+					    &ring->dma);
+		if (!ring->trbs)
+			return -ENOMEM;
+	}
+
+	memset(ring->trbs, 0, TR_SEG_SIZE);
+
+	if (!pep->num)
+		return 0;
+
+	/* Initialize the last TRB as Link TRB */
+	link_trb = (ring->trbs + (TRBS_PER_SEGMENT - 1));
+	link_trb->buffer = cpu_to_le32(TRB_BUFFER(ring->dma));
+	link_trb->control = cpu_to_le32(TRB_CYCLE | TRB_TYPE(TRB_LINK) |
+					TRB_TOGGLE);
+
+	return 0;
+}
+
+/*
+ * Stalls and flushes selected endpoint.
+ * Endpoint must be selected before invoking this function.
+ */
+static void cdns2_ep_stall_flush(struct cdns2_endpoint *pep)
+{
+	struct cdns2_device *pdev = pep->pdev;
+	int val;
+
+	writel(DMA_EP_CMD_DFLUSH, &pdev->adma_regs->ep_cmd);
+
+	/* Wait for DFLUSH cleared. */
+	readl_poll_timeout_atomic(&pdev->adma_regs->ep_cmd, val,
+				  !(val & DMA_EP_CMD_DFLUSH), 1, 1000);
+	pep->ep_state |= EP_STALLED;
+	pep->ep_state &= ~EP_STALL_PENDING;
+}
+
+/*
+ * Increment a trb index.
+ *
+ * The index should never point to the last link TRB in TR. After incrementing,
+ * if it point to the link TRB, wrap around to the beginning and revert
+ * cycle state bit. The link TRB is always at the last TRB entry.
+ */
+static void cdns2_ep_inc_trb(int *index, u8 *cs, int trb_in_seg)
+{
+	(*index)++;
+	if (*index == (trb_in_seg - 1)) {
+		*index = 0;
+		*cs ^=  1;
+	}
+}
+
+static void cdns2_ep_inc_enq(struct cdns2_ring *ring)
+{
+	ring->free_trbs--;
+	cdns2_ep_inc_trb(&ring->enqueue, &ring->pcs, TRBS_PER_SEGMENT);
+}
+
+static void cdns2_ep_inc_deq(struct cdns2_ring *ring)
+{
+	ring->free_trbs++;
+	cdns2_ep_inc_trb(&ring->dequeue, &ring->ccs, TRBS_PER_SEGMENT);
+}
+
+/*
+ * Enable/disable LPM.
+ *
+ * If bit USBCS_LPMNYET is not set and device receive Extended Token packet,
+ * then controller answer with ACK handshake.
+ * If bit USBCS_LPMNYET is set and device receive Extended Token packet,
+ * then controller answer with NYET handshake.
+ */
+static void cdns2_enable_l1(struct cdns2_device *pdev, int enable)
+{
+	if (enable) {
+		clear_reg_bit_8(&pdev->usb_regs->usbcs, USBCS_LPMNYET);
+		writeb(LPMCLOCK_SLEEP_ENTRY, &pdev->usb_regs->lpmclock);
+	} else {
+		set_reg_bit_8(&pdev->usb_regs->usbcs, USBCS_LPMNYET);
+	}
+}
+
+static enum usb_device_speed cdns2_get_speed(struct cdns2_device *pdev)
+{
+	u8 speed = readb(&pdev->usb_regs->speedctrl);
+
+	if (speed & SPEEDCTRL_HS)
+		return USB_SPEED_HIGH;
+	else if (speed & SPEEDCTRL_FS)
+		return USB_SPEED_FULL;
+
+	return USB_SPEED_UNKNOWN;
+}
+
+static struct cdns2_trb *cdns2_next_trb(struct cdns2_endpoint *pep,
+					struct cdns2_trb *trb)
+{
+	if (trb == (pep->ring.trbs + (TRBS_PER_SEGMENT - 1)))
+		return pep->ring.trbs;
+	else
+		return ++trb;
+}
+
+void cdns2_gadget_giveback(struct cdns2_endpoint *pep,
+			   struct cdns2_request *preq,
+			   int status)
+{
+	struct usb_request *request = &preq->request;
+	struct cdns2_device *pdev = pep->pdev;
+
+	list_del_init(&preq->list);
+
+	if (request->status == -EINPROGRESS)
+		request->status = status;
+
+	usb_gadget_unmap_request_by_dev(pdev->dev, request, pep->dir);
+
+	/* All TRBs have finished, clear the counter. */
+	preq->finished_trb = 0;
+
+	if (request->complete) {
+		spin_unlock(&pdev->lock);
+		usb_gadget_giveback_request(&pep->endpoint, request);
+		spin_lock(&pdev->lock);
+	}
+
+	if (request->buf == pdev->zlp_buf)
+		cdns2_gadget_ep_free_request(&pep->endpoint, request);
+}
+
+static void cdns2_wa1_restore_cycle_bit(struct cdns2_endpoint *pep)
+{
+	/* Work around for stale data address in TRB. */
+	if (pep->wa1_set) {
+		pep->wa1_set = 0;
+		pep->wa1_trb_index = 0xFFFF;
+		if (pep->wa1_cycle_bit)
+			pep->wa1_trb->control |= cpu_to_le32(0x1);
+		else
+			pep->wa1_trb->control &= cpu_to_le32(~0x1);
+	}
+}
+
+static int cdns2_wa1_update_guard(struct cdns2_endpoint *pep,
+				  struct cdns2_trb *trb)
+{
+	struct cdns2_device *pdev = pep->pdev;
+
+	if (!pep->wa1_set) {
+		u32 doorbell;
+
+		doorbell = !!(readl(&pdev->adma_regs->ep_cmd) & DMA_EP_CMD_DRDY);
+
+		if (doorbell) {
+			pep->wa1_cycle_bit = pep->ring.pcs ? TRB_CYCLE : 0;
+			pep->wa1_set = 1;
+			pep->wa1_trb = trb;
+			pep->wa1_trb_index = pep->ring.enqueue;
+			return 0;
+		}
+	}
+	return 1;
+}
+
+static void cdns2_wa1_tray_restore_cycle_bit(struct cdns2_device *pdev,
+					     struct cdns2_endpoint *pep)
+{
+	int dma_index;
+	u32 doorbell;
+
+	doorbell = !!(readl(&pdev->adma_regs->ep_cmd) & DMA_EP_CMD_DRDY);
+	dma_index = cdns2_get_dma_pos(pdev, pep);
+
+	if (!doorbell || dma_index != pep->wa1_trb_index)
+		cdns2_wa1_restore_cycle_bit(pep);
+}
+
+static int cdns2_prepare_ring(struct cdns2_device *pdev,
+			      struct cdns2_endpoint *pep,
+			      int num_trbs)
+{
+	struct cdns2_trb *link_trb = NULL;
+	int doorbell, dma_index;
+	struct cdns2_ring *ring;
+	u32 ch_bit = 0;
+
+	ring = &pep->ring;
+
+	if (num_trbs > ring->free_trbs) {
+		pep->ep_state |= EP_RING_FULL;
+		return -ENOBUFS;
+	}
+
+	if ((ring->enqueue + num_trbs)  >= (TRBS_PER_SEGMENT - 1)) {
+		doorbell = !!(readl(&pdev->adma_regs->ep_cmd) & DMA_EP_CMD_DRDY);
+		dma_index = cdns2_get_dma_pos(pdev, pep);
+
+		/* Driver can't update LINK TRB if it is current processed. */
+		if (doorbell && dma_index == TRBS_PER_SEGMENT - 1) {
+			pep->ep_state |= EP_DEFERRED_DRDY;
+			return -ENOBUFS;
+		}
+
+		/* Update C bt in Link TRB before starting DMA. */
+		link_trb = ring->trbs + (TRBS_PER_SEGMENT - 1);
+
+		/*
+		 * For TRs size equal 2 enabling TRB_CHAIN for epXin causes
+		 * that DMA stuck at the LINK TRB.
+		 * On the other hand, removing TRB_CHAIN for longer TRs for
+		 * epXout cause that DMA stuck after handling LINK TRB.
+		 * To eliminate this strange behavioral driver set TRB_CHAIN
+		 * bit only for TR size > 2.
+		 */
+		if (pep->type == USB_ENDPOINT_XFER_ISOC || TRBS_PER_SEGMENT > 2)
+			ch_bit = TRB_CHAIN;
+
+		link_trb->control = cpu_to_le32(((ring->pcs) ? TRB_CYCLE : 0) |
+				    TRB_TYPE(TRB_LINK) | TRB_TOGGLE | ch_bit);
+	}
+
+	return 0;
+}
+
+static void cdns2_dbg_request_trbs(struct cdns2_endpoint *pep,
+				   struct cdns2_request *preq)
+{
+	struct cdns2_trb *link_trb = pep->ring.trbs + (TRBS_PER_SEGMENT - 1);
+	struct cdns2_trb *trb = preq->trb;
+	int num_trbs = preq->num_of_trb;
+	int i = 0;
+
+	while (i < num_trbs) {
+		if (trb + i == link_trb) {
+			trb = pep->ring.trbs;
+			num_trbs = num_trbs - i;
+			i = 0;
+		} else {
+			i++;
+		}
+	}
+}
+
+static unsigned int cdns2_count_trbs(struct cdns2_endpoint *pep,
+				     u64 addr, u64 len)
+{
+	unsigned int num_trbs = 1;
+
+	if (pep->type == USB_ENDPOINT_XFER_ISOC) {
+		/*
+		 * To speed up DMA performance address should not exceed 4KB.
+		 * for high bandwidth transfer and driver will split
+		 * such buffer into two TRBs.
+		 */
+		num_trbs = DIV_ROUND_UP(len +
+					(addr & (TRB_MAX_ISO_BUFF_SIZE - 1)),
+					TRB_MAX_ISO_BUFF_SIZE);
+
+		if (pep->interval > 1)
+			num_trbs = pep->dir ? num_trbs * pep->interval : 1;
+	} else if (pep->dir) {
+		/*
+		 * One extra link trb for IN direction.
+		 * Sometimes DMA doesn't want advance to next TD and transfer
+		 * hangs. This extra Link TRB force DMA to advance to next TD.
+		 */
+		num_trbs++;
+	}
+
+	return num_trbs;
+}
+
+static unsigned int cdns2_count_sg_trbs(struct cdns2_endpoint *pep,
+					struct usb_request *req)
+{
+	unsigned int i, len, full_len, num_trbs = 0;
+	struct scatterlist *sg;
+	int trb_len = 0;
+
+	full_len = req->length;
+
+	for_each_sg(req->sg, sg, req->num_sgs, i) {
+		len = sg_dma_len(sg);
+		num_trbs += cdns2_count_trbs(pep, sg_dma_address(sg), len);
+		len = min(len, full_len);
+
+		/*
+		 * For HS ISO transfer TRBs should not exceed max packet size.
+		 * When DMA is working, and data exceed max packet size then
+		 * some data will be read in single mode instead burst mode.
+		 * This behavior will drastically reduce the copying speed.
+		 * To avoid this we need one or two extra TRBs.
+		 * This issue occurs for UVC class with sg_supported = 1
+		 * because buffers addresses are not aligned to 1024.
+		 */
+		if (pep->type == USB_ENDPOINT_XFER_ISOC) {
+			u8 temp;
+
+			trb_len += len;
+			temp = trb_len >> 10;
+
+			if (temp) {
+				if (trb_len % 1024)
+					num_trbs = num_trbs + temp;
+				else
+					num_trbs = num_trbs + temp - 1;
+
+				trb_len = trb_len - (temp << 10);
+			}
+		}
+
+		full_len -= len;
+		if (full_len == 0)
+			break;
+	}
+
+	return num_trbs;
+}
+
+/*
+ * Function prepares the array with optimized AXI burst value for different
+ * transfer lengths. Controller handles the final data which are less
+ * then AXI burst size as single byte transactions.
+ * e.g.:
+ * Let's assume that driver prepares trb with trb->length 700 and burst size
+ * will be set to 128. In this case the controller will handle a first 512 as
+ * single AXI transaction but the next 188 bytes will be handled
+ * as 47 separate AXI transaction.
+ * The better solution is to use the burst size equal 16 and then we will
+ * have only 25 AXI transaction (10 * 64 + 15 *4).
+ */
+static void cdsn2_isoc_burst_opt(struct cdns2_device *pdev)
+{
+	int axi_burst_option[]  =  {1, 2, 4, 8, 16, 32, 64, 128};
+	int best_burst;
+	int array_size;
+	int opt_burst;
+	int trb_size;
+	int i, j;
+
+	array_size = ARRAY_SIZE(axi_burst_option);
+
+	for (i = 0; i <= MAX_ISO_SIZE; i++) {
+		trb_size = i / 4;
+		best_burst = trb_size ? trb_size : 1;
+
+		for (j = 0; j < array_size; j++) {
+			opt_burst = trb_size / axi_burst_option[j];
+			opt_burst += trb_size % axi_burst_option[j];
+
+			if (opt_burst < best_burst) {
+				best_burst = opt_burst;
+				pdev->burst_opt[i] = axi_burst_option[j];
+			}
+		}
+	}
+}
+
+static void cdns2_ep_tx_isoc(struct cdns2_endpoint *pep,
+			     struct cdns2_request *preq,
+			     int num_trbs)
+{
+	struct scatterlist *sg = NULL;
+	u32 remaining_packet_size = 0;
+	struct cdns2_trb *trb;
+	bool first_trb = true;
+	dma_addr_t trb_dma;
+	u32 trb_buff_len;
+	u32 block_length;
+	int sg_iter = 0;
+	int sent_len;
+	int td_idx = 0;
+	int split_size;
+	u32 control;
+	int num_tds;
+	u32 length;
+	u32 full_len;
+	int enqd_len;
+
+	/*
+	 * For OUT direction 1 TD per interval is enough
+	 * because TRBs are not dumped by controller.
+	 */
+	num_tds = pep->dir ? pep->interval : 1;
+	split_size = preq->request.num_sgs ? 1024 : 3072;
+
+	for (td_idx = 0; td_idx < num_tds; td_idx++) {
+		if (preq->request.num_sgs) {
+			sg = preq->request.sg;
+			trb_dma = sg_dma_address(sg);
+			block_length = sg_dma_len(sg);
+		} else {
+			trb_dma = preq->request.dma;
+			block_length = preq->request.length;
+		}
+
+		full_len = preq->request.length;
+		sg_iter = preq->request.num_sgs ? preq->request.num_sgs : 1;
+		remaining_packet_size = split_size;
+
+		for (enqd_len = 0;  enqd_len < full_len;
+		     enqd_len += trb_buff_len) {
+			if (remaining_packet_size == 0)
+				remaining_packet_size = split_size;
+
+			/*
+			 * Calculate TRB length.- buffer can't across 4KB
+			 * and max packet size.
+			 */
+			trb_buff_len = TRB_BUFF_LEN_UP_TO_BOUNDARY(trb_dma);
+			trb_buff_len = min(trb_buff_len, remaining_packet_size);
+			trb_buff_len = min(trb_buff_len, block_length);
+
+			if (trb_buff_len > full_len - enqd_len)
+				trb_buff_len = full_len - enqd_len;
+
+			control = TRB_TYPE(TRB_NORMAL);
+
+			/*
+			 * For IN direction driver has to set the IOC for
+			 * last TRB in last TD.
+			 * For OUT direction driver must set IOC and ISP
+			 * only for last TRB in each TDs.
+			 */
+			if (enqd_len + trb_buff_len >= full_len || !pep->dir)
+				control |= TRB_IOC | TRB_ISP;
+
+			/*
+			 * Don't give the first TRB to the hardware (by toggling
+			 * the cycle bit) until we've finished creating all the
+			 * other TRBs.
+			 */
+			if (first_trb) {
+				first_trb = false;
+				if (pep->ring.pcs == 0)
+					control |= TRB_CYCLE;
+			} else {
+				control |= pep->ring.pcs;
+			}
+
+			if (enqd_len + trb_buff_len < full_len)
+				control |= TRB_CHAIN;
+
+			length = TRB_LEN(trb_buff_len) |
+				 TRB_BURST(pep->pdev->burst_opt[trb_buff_len]);
+
+			trb = pep->ring.trbs + pep->ring.enqueue;
+			trb->buffer = cpu_to_le32(TRB_BUFFER(trb_dma));
+			trb->length = cpu_to_le32(length);
+			trb->control = cpu_to_le32(control);
+
+			trb_dma += trb_buff_len;
+			sent_len = trb_buff_len;
+
+			if (sg && sent_len >= block_length) {
+				/* New sg entry */
+				--sg_iter;
+				sent_len -= block_length;
+				if (sg_iter != 0) {
+					sg = sg_next(sg);
+					trb_dma = sg_dma_address(sg);
+					block_length = sg_dma_len(sg);
+				}
+			}
+
+			remaining_packet_size -= trb_buff_len;
+			block_length -= sent_len;
+			preq->end_trb = pep->ring.enqueue;
+
+			cdns2_ep_inc_enq(&pep->ring);
+		}
+	}
+}
+
+static void cdns2_ep_tx_bulk(struct cdns2_endpoint *pep,
+			     struct cdns2_request *preq,
+			     int trbs_per_td)
+{
+	struct scatterlist *sg = NULL;
+	struct cdns2_ring *ring;
+	struct cdns2_trb *trb;
+	dma_addr_t trb_dma;
+	int sg_iter = 0;
+	u32 control;
+	u32 length;
+
+	if (preq->request.num_sgs) {
+		sg = preq->request.sg;
+		trb_dma = sg_dma_address(sg);
+		length = sg_dma_len(sg);
+	} else {
+		trb_dma = preq->request.dma;
+		length = preq->request.length;
+	}
+
+	ring = &pep->ring;
+
+	for (sg_iter = 0; sg_iter < trbs_per_td; sg_iter++) {
+		control = TRB_TYPE(TRB_NORMAL) | ring->pcs | TRB_ISP;
+		trb = pep->ring.trbs + ring->enqueue;
+
+		if (pep->dir && sg_iter == trbs_per_td - 1) {
+			preq->end_trb = ring->enqueue;
+			control = ring->pcs | TRB_TYPE(TRB_LINK) | TRB_CHAIN
+				  | TRB_IOC;
+			cdns2_ep_inc_enq(&pep->ring);
+
+			if (ring->enqueue == 0)
+				control |= TRB_TOGGLE;
+
+			/* Point to next bad TRB. */
+			trb->buffer = cpu_to_le32(pep->ring.dma +
+						  (ring->enqueue * TRB_SIZE));
+			trb->length = 0;
+			trb->control = cpu_to_le32(control);
+			break;
+		}
+
+		/*
+		 * Don't give the first TRB to the hardware (by toggling
+		 * the cycle bit) until we've finished creating all the
+		 * other TRBs.
+		 */
+		if (sg_iter == 0)
+			control = control ^ TRB_CYCLE;
+
+		/* For last TRB in TD. */
+		if (sg_iter == (trbs_per_td - (pep->dir ? 2 : 1)))
+			control |= TRB_IOC;
+		else
+			control |= TRB_CHAIN;
+
+		trb->buffer = cpu_to_le32(trb_dma);
+		trb->length = cpu_to_le32(TRB_BURST(pep->trb_burst_size) |
+					   TRB_LEN(length));
+		trb->control = cpu_to_le32(control);
+
+		if (sg && sg_iter < (trbs_per_td - 1)) {
+			sg = sg_next(sg);
+			trb_dma = sg_dma_address(sg);
+			length = sg_dma_len(sg);
+		}
+
+		preq->end_trb = ring->enqueue;
+		cdns2_ep_inc_enq(&pep->ring);
+	}
+}
+
+static void cdns2_set_drdy(struct cdns2_device *pdev,
+			   struct cdns2_endpoint *pep)
+{
+	/*
+	 * Memory barrier - Cycle Bit must be set before doorbell.
+	 */
+	dma_wmb();
+
+	/* Clearing TRBERR and DESCMIS before setting DRDY. */
+	writel(DMA_EP_STS_TRBERR | DMA_EP_STS_DESCMIS,
+	       &pdev->adma_regs->ep_sts);
+	writel(DMA_EP_CMD_DRDY, &pdev->adma_regs->ep_cmd);
+
+	if (readl(&pdev->adma_regs->ep_sts) & DMA_EP_STS_TRBERR) {
+		writel(DMA_EP_STS_TRBERR, &pdev->adma_regs->ep_sts);
+		writel(DMA_EP_CMD_DRDY, &pdev->adma_regs->ep_cmd);
+	}
+}
+
+static int cdns2_prepare_first_isoc_transfer(struct cdns2_device *pdev,
+					     struct cdns2_endpoint *pep)
+{
+	struct cdns2_trb *trb;
+	u32 buffer;
+	u8 hw_ccs;
+
+	if ((readl(&pdev->adma_regs->ep_cmd) & DMA_EP_CMD_DRDY))
+		return -EBUSY;
+
+	if (!pep->dir) {
+		set_reg_bit_32(&pdev->adma_regs->ep_cfg, DMA_EP_CFG_ENABLE);
+		writel(pep->ring.dma + pep->ring.dequeue,
+		       &pdev->adma_regs->ep_traddr);
+		return 0;
+	}
+
+	/*
+	 * The first packet after doorbell can be corrupted so,
+	 * driver prepares 0 length packet as first packet.
+	 */
+	buffer = pep->ring.dma + pep->ring.dequeue * TRB_SIZE;
+	hw_ccs = !!DMA_EP_STS_CCS(readl(&pdev->adma_regs->ep_sts));
+
+	trb = &pep->ring.trbs[TRBS_PER_SEGMENT];
+	trb->length = 0;
+	trb->buffer = cpu_to_le32(TRB_BUFFER(buffer));
+	trb->control = cpu_to_le32((hw_ccs ? TRB_CYCLE : 0) | TRB_TYPE(TRB_NORMAL));
+
+	/*
+	 * LINK TRB is used to force updating cycle bit in controller and
+	 * move to correct place in transfer ring.
+	 */
+	trb++;
+	trb->length = 0;
+	trb->buffer = cpu_to_le32(TRB_BUFFER(buffer));
+	trb->control = cpu_to_le32((hw_ccs ? TRB_CYCLE : 0) |
+				    TRB_TYPE(TRB_LINK) | TRB_CHAIN);
+
+	if (hw_ccs !=  pep->ring.ccs)
+		trb->control |= cpu_to_le32(TRB_TOGGLE);
+
+	set_reg_bit_32(&pdev->adma_regs->ep_cfg, DMA_EP_CFG_ENABLE);
+	writel(pep->ring.dma + (TRBS_PER_SEGMENT * TRB_SIZE),
+	       &pdev->adma_regs->ep_traddr);
+
+	return 0;
+}
+
+/* Prepare and start transfer on no-default endpoint. */
+static int cdns2_ep_run_transfer(struct cdns2_endpoint *pep,
+				 struct cdns2_request *preq)
+{
+	struct cdns2_device *pdev = pep->pdev;
+	struct cdns2_ring *ring;
+	u32 togle_pcs = 1;
+	int num_trbs;
+	int ret;
+
+	cdns2_select_ep(pdev, pep->endpoint.address);
+
+	if (preq->request.sg)
+		num_trbs = cdns2_count_sg_trbs(pep, &preq->request);
+	else
+		num_trbs = cdns2_count_trbs(pep, preq->request.dma,
+					    preq->request.length);
+
+	ret = cdns2_prepare_ring(pdev, pep, num_trbs);
+	if (ret)
+		return ret;
+
+	ring = &pep->ring;
+	preq->start_trb = ring->enqueue;
+	preq->trb = ring->trbs + ring->enqueue;
+
+	if (usb_endpoint_xfer_isoc(pep->endpoint.desc)) {
+		cdns2_ep_tx_isoc(pep, preq, num_trbs);
+	} else {
+		togle_pcs = cdns2_wa1_update_guard(pep, ring->trbs + ring->enqueue);
+		cdns2_ep_tx_bulk(pep, preq, num_trbs);
+	}
+
+	preq->num_of_trb = num_trbs;
+
+	/*
+	 * Memory barrier - cycle bit must be set as the last operation.
+	 */
+	dma_wmb();
+
+	/* Give the TD to the consumer. */
+	if (togle_pcs)
+		preq->trb->control = preq->trb->control ^ cpu_to_le32(1);
+
+	cdns2_wa1_tray_restore_cycle_bit(pdev, pep);
+	cdns2_dbg_request_trbs(pep, preq);
+
+	if (!pep->wa1_set && !(pep->ep_state & EP_STALLED) && !pep->skip) {
+		if (pep->type == USB_ENDPOINT_XFER_ISOC) {
+			ret = cdns2_prepare_first_isoc_transfer(pdev, pep);
+			if (ret)
+				return 0;
+		}
+
+		cdns2_set_drdy(pdev, pep);
+	}
+
+	return 0;
+}
+
+/* Prepare and start transfer for all not started requests. */
+static int cdns2_start_all_request(struct cdns2_device *pdev,
+				   struct cdns2_endpoint *pep)
+{
+	struct cdns2_request *preq;
+	int ret = 0;
+
+	while (!list_empty(&pep->deferred_list)) {
+		preq = cdns2_next_preq(&pep->deferred_list);
+
+		ret = cdns2_ep_run_transfer(pep, preq);
+		if (ret)
+			return ret;
+
+		list_move_tail(&preq->list, &pep->pending_list);
+	}
+
+	pep->ep_state &= ~EP_RING_FULL;
+
+	return ret;
+}
+
+/*
+ * Check whether trb has been handled by DMA.
+ *
+ * Endpoint must be selected before invoking this function.
+ *
+ * Returns false if request has not been handled by DMA, else returns true.
+ *
+ * SR - start ring
+ * ER - end ring
+ * DQ = ring->dequeue - dequeue position
+ * EQ = ring->enqueue - enqueue position
+ * ST = preq->start_trb - index of first TRB in transfer ring
+ * ET = preq->end_trb - index of last TRB in transfer ring
+ * CI = current_index - index of processed TRB by DMA.
+ *
+ * As first step, we check if the TRB between the ST and ET.
+ * Then, we check if cycle bit for index pep->dequeue
+ * is correct.
+ *
+ * some rules:
+ * 1. ring->dequeue never equals to current_index.
+ * 2  ring->enqueue never exceed ring->dequeue
+ * 3. exception: ring->enqueue == ring->dequeue
+ *    and ring->free_trbs is zero.
+ *    This case indicate that TR is full.
+ *
+ * At below two cases, the request have been handled.
+ * Case 1 - ring->dequeue < current_index
+ *      SR ... EQ ... DQ ... CI ... ER
+ *      SR ... DQ ... CI ... EQ ... ER
+ *
+ * Case 2 - ring->dequeue > current_index
+ * This situation takes place when CI go through the LINK TRB at the end of
+ * transfer ring.
+ *      SR ... CI ... EQ ... DQ ... ER
+ */
+static bool cdns2_trb_handled(struct cdns2_endpoint *pep,
+			      struct cdns2_request *preq)
+{
+	struct cdns2_device *pdev = pep->pdev;
+	struct cdns2_ring *ring;
+	struct cdns2_trb *trb;
+	int current_index = 0;
+	int handled = 0;
+	int doorbell;
+
+	ring = &pep->ring;
+	current_index = cdns2_get_dma_pos(pdev, pep);
+	doorbell = !!(readl(&pdev->adma_regs->ep_cmd) & DMA_EP_CMD_DRDY);
+
+	/*
+	 * Only ISO transfer can use 2 entries outside the standard
+	 * Transfer Ring. First of them is used as zero length packet and the
+	 * second as LINK TRB.
+	 */
+	if (current_index >= TRBS_PER_SEGMENT)
+		goto finish;
+
+	/* Current trb doesn't belong to this request. */
+	if (preq->start_trb < preq->end_trb) {
+		if (ring->dequeue > preq->end_trb)
+			goto finish;
+
+		if (ring->dequeue < preq->start_trb)
+			goto finish;
+	}
+
+	if (preq->start_trb > preq->end_trb && ring->dequeue > preq->end_trb &&
+	    ring->dequeue < preq->start_trb)
+		goto finish;
+
+	if (preq->start_trb == preq->end_trb && ring->dequeue != preq->end_trb)
+		goto finish;
+
+	trb = &ring->trbs[ring->dequeue];
+
+	if ((le32_to_cpu(trb->control) & TRB_CYCLE) != ring->ccs)
+		goto finish;
+
+	if (doorbell == 1 && current_index == ring->dequeue)
+		goto finish;
+
+	/* The corner case for TRBS_PER_SEGMENT equal 2). */
+	if (TRBS_PER_SEGMENT == 2 && pep->type != USB_ENDPOINT_XFER_ISOC) {
+		handled = 1;
+		goto finish;
+	}
+
+	if (ring->enqueue == ring->dequeue &&
+	    ring->free_trbs == 0) {
+		handled = 1;
+	} else if (ring->dequeue < current_index) {
+		if ((current_index == (TRBS_PER_SEGMENT - 1)) &&
+		    !ring->dequeue)
+			goto finish;
+
+		handled = 1;
+	} else if (ring->dequeue  > current_index) {
+		handled = 1;
+	}
+
+finish:
+
+	return handled;
+}
+
+static void cdns2_skip_isoc_td(struct cdns2_device *pdev,
+			       struct cdns2_endpoint *pep,
+			       struct cdns2_request *preq)
+{
+	struct cdns2_trb *trb;
+	int i;
+
+	trb = pep->ring.trbs + pep->ring.dequeue;
+
+	for (i = preq->finished_trb ; i < preq->num_of_trb; i++) {
+		preq->finished_trb++;
+		cdns2_ep_inc_deq(&pep->ring);
+		trb = cdns2_next_trb(pep, trb);
+	}
+
+	cdns2_gadget_giveback(pep, preq, 0);
+	cdns2_prepare_first_isoc_transfer(pdev, pep);
+	pep->skip = false;
+	cdns2_set_drdy(pdev, pep);
+}
+
+static void cdns2_transfer_completed(struct cdns2_device *pdev,
+				     struct cdns2_endpoint *pep)
+{
+	struct cdns2_request *preq = NULL;
+	bool request_handled = false;
+	struct cdns2_trb *trb;
+
+	while (!list_empty(&pep->pending_list)) {
+		preq = cdns2_next_preq(&pep->pending_list);
+		trb = pep->ring.trbs + pep->ring.dequeue;
+
+		/*
+		 * The TRB was changed as link TRB, and the request
+		 * was handled at ep_dequeue.
+		 */
+		while (TRB_FIELD_TO_TYPE(le32_to_cpu(trb->control)) == TRB_LINK &&
+		       le32_to_cpu(trb->length)) {
+			cdns2_ep_inc_deq(&pep->ring);
+			trb = pep->ring.trbs + pep->ring.dequeue;
+		}
+
+		/*
+		 * Re-select endpoint. It could be changed by other CPU
+		 * during handling usb_gadget_giveback_request.
+		 */
+		cdns2_select_ep(pdev, pep->endpoint.address);
+
+		while (cdns2_trb_handled(pep, preq)) {
+			preq->finished_trb++;
+
+			if (preq->finished_trb >= preq->num_of_trb)
+				request_handled = true;
+
+			trb = pep->ring.trbs + pep->ring.dequeue;
+
+			if (pep->dir && pep->type == USB_ENDPOINT_XFER_ISOC)
+				/*
+				 * For ISOC IN controller doens't update the
+				 * trb->length.
+				 */
+				preq->request.actual = preq->request.length;
+			else
+				preq->request.actual +=
+					TRB_LEN(le32_to_cpu(trb->length));
+
+			cdns2_ep_inc_deq(&pep->ring);
+		}
+
+		if (request_handled) {
+			cdns2_gadget_giveback(pep, preq, 0);
+			request_handled = false;
+		} else {
+			goto prepare_next_td;
+		}
+
+		if (pep->type != USB_ENDPOINT_XFER_ISOC &&
+		    TRBS_PER_SEGMENT == 2)
+			break;
+	}
+
+prepare_next_td:
+	if (pep->skip && preq)
+		cdns2_skip_isoc_td(pdev, pep, preq);
+
+	if (!(pep->ep_state & EP_STALLED) &&
+	    !(pep->ep_state & EP_STALL_PENDING))
+		cdns2_start_all_request(pdev, pep);
+}
+
+static void cdns2_wakeup(struct cdns2_device *pdev)
+{
+	if (!pdev->may_wakeup)
+		return;
+
+	/* Start driving resume signaling to indicate remote wakeup. */
+	set_reg_bit_8(&pdev->usb_regs->usbcs, USBCS_SIGRSUME);
+}
+
+static void cdns2_rearm_transfer(struct cdns2_endpoint *pep, u8 rearm)
+{
+	struct cdns2_device *pdev = pep->pdev;
+
+	cdns2_wa1_restore_cycle_bit(pep);
+
+	if (rearm) {
+		/* Cycle Bit must be updated before arming DMA. */
+		dma_wmb();
+
+		writel(DMA_EP_CMD_DRDY, &pdev->adma_regs->ep_cmd);
+
+		cdns2_wakeup(pdev);
+	}
+}
+
+static void cdns2_handle_epx_interrupt(struct cdns2_endpoint *pep)
+{
+	struct cdns2_device *pdev = pep->pdev;
+	u8 isoerror = 0;
+	u32 ep_sts_reg;
+	u32 val;
+
+	cdns2_select_ep(pdev, pep->endpoint.address);
+
+	ep_sts_reg = readl(&pdev->adma_regs->ep_sts);
+	writel(ep_sts_reg, &pdev->adma_regs->ep_sts);
+
+	if (pep->type == USB_ENDPOINT_XFER_ISOC) {
+		u8 mult;
+		u8 cs;
+
+		mult = USB_EP_MAXP_MULT(pep->endpoint.desc->wMaxPacketSize);
+		cs = pep->dir ? readb(&pdev->epx_regs->ep[pep->num - 1].txcs) :
+				readb(&pdev->epx_regs->ep[pep->num - 1].rxcs);
+		if (mult > 0)
+			isoerror = EPX_CS_ERR(cs);
+	}
+
+	/*
+	 * Sometimes ISO Error for mult=1 or mult=2 is not propagated on time
+	 * from USB module to DMA module. To protect against this driver
+	 * checks also the txcs/rxcs registers.
+	 */
+	if ((ep_sts_reg & DMA_EP_STS_ISOERR) || isoerror) {
+		clear_reg_bit_32(&pdev->adma_regs->ep_cfg, DMA_EP_CFG_ENABLE);
+
+		/* Wait for DBUSY cleared. */
+		readl_poll_timeout_atomic(&pdev->adma_regs->ep_sts, val,
+					  !(val & DMA_EP_STS_DBUSY), 1, 125);
+
+		writel(DMA_EP_CMD_DFLUSH, &pep->pdev->adma_regs->ep_cmd);
+
+		/* Wait for DFLUSH cleared. */
+		readl_poll_timeout_atomic(&pep->pdev->adma_regs->ep_cmd, val,
+					  !(val & DMA_EP_CMD_DFLUSH), 1, 10);
+
+		pep->skip = true;
+	}
+
+	if (ep_sts_reg & DMA_EP_STS_TRBERR || pep->skip) {
+		if (pep->ep_state & EP_STALL_PENDING &&
+		    !(ep_sts_reg & DMA_EP_STS_DESCMIS))
+			cdns2_ep_stall_flush(pep);
+
+		/*
+		 * For isochronous transfer driver completes request on
+		 * IOC or on TRBERR. IOC appears only when device receive
+		 * OUT data packet. If host disable stream or lost some packet
+		 * then the only way to finish all queued transfer is to do it
+		 * on TRBERR event.
+		 */
+		if (pep->type == USB_ENDPOINT_XFER_ISOC && !pep->wa1_set) {
+			if (!pep->dir)
+				clear_reg_bit_32(&pdev->adma_regs->ep_cfg,
+						 DMA_EP_CFG_ENABLE);
+
+			cdns2_transfer_completed(pdev, pep);
+			if (pep->ep_state & EP_DEFERRED_DRDY) {
+				pep->ep_state &= ~EP_DEFERRED_DRDY;
+				cdns2_set_drdy(pdev, pep);
+			}
+
+			return;
+		}
+
+		cdns2_transfer_completed(pdev, pep);
+
+		if (!(pep->ep_state & EP_STALLED) &&
+		    !(pep->ep_state & EP_STALL_PENDING)) {
+			if (pep->ep_state & EP_DEFERRED_DRDY) {
+				pep->ep_state &= ~EP_DEFERRED_DRDY;
+				cdns2_start_all_request(pdev, pep);
+			} else {
+				cdns2_rearm_transfer(pep, pep->wa1_set);
+			}
+		}
+
+		return;
+	}
+
+	if ((ep_sts_reg & DMA_EP_STS_IOC) || (ep_sts_reg & DMA_EP_STS_ISP))
+		cdns2_transfer_completed(pdev, pep);
+}
+
+static void cdns2_disconnect_gadget(struct cdns2_device *pdev)
+{
+	if (pdev->gadget_driver && pdev->gadget_driver->disconnect)
+		pdev->gadget_driver->disconnect(&pdev->gadget);
+}
+
+static irqreturn_t cdns2_usb_irq_handler(int irq, void *data)
+{
+	struct cdns2_device *pdev = data;
+	irqreturn_t ret = IRQ_NONE;
+	unsigned long reg_ep_ists;
+	u8 reg_usb_irq_m;
+	u8 reg_ext_irq_m;
+	u8 reg_usb_irq;
+	u8 reg_ext_irq;
+
+	if (pdev->in_lpm)
+		return IRQ_NONE;
+
+	reg_usb_irq_m = readb(&pdev->interrupt_regs->usbien);
+	reg_ext_irq_m = readb(&pdev->interrupt_regs->extien);
+
+	/* Mask all sources of interrupt. */
+	writeb(0, &pdev->interrupt_regs->usbien);
+	writeb(0, &pdev->interrupt_regs->extien);
+	writel(0, &pdev->adma_regs->ep_ien);
+
+	/* Clear interrupt sources. */
+	writel(0, &pdev->adma_regs->ep_sts);
+	writeb(0, &pdev->interrupt_regs->usbirq);
+	writeb(0, &pdev->interrupt_regs->extirq);
+
+	reg_ep_ists = readl(&pdev->adma_regs->ep_ists);
+	reg_usb_irq = readb(&pdev->interrupt_regs->usbirq);
+	reg_ext_irq = readb(&pdev->interrupt_regs->extirq);
+
+	if (reg_ep_ists || (reg_usb_irq & reg_usb_irq_m) ||
+	    (reg_ext_irq & reg_ext_irq_m))
+		return IRQ_WAKE_THREAD;
+
+	writeb(USB_IEN_INIT, &pdev->interrupt_regs->usbien);
+	writeb(EXTIRQ_WAKEUP, &pdev->interrupt_regs->extien);
+	writel(~0, &pdev->adma_regs->ep_ien);
+
+	return ret;
+}
+
+static irqreturn_t cdns2_thread_usb_irq_handler(struct cdns2_device *pdev)
+{
+	u8 usb_irq, ext_irq;
+	int speed;
+	int i;
+
+	ext_irq = readb(&pdev->interrupt_regs->extirq) & EXTIRQ_WAKEUP;
+	writeb(ext_irq, &pdev->interrupt_regs->extirq);
+
+	usb_irq = readb(&pdev->interrupt_regs->usbirq) & USB_IEN_INIT;
+	writeb(usb_irq, &pdev->interrupt_regs->usbirq);
+
+	if (!ext_irq && !usb_irq)
+		return IRQ_NONE;
+
+	if (ext_irq & EXTIRQ_WAKEUP) {
+		if (pdev->gadget_driver && pdev->gadget_driver->resume) {
+			spin_unlock(&pdev->lock);
+			pdev->gadget_driver->resume(&pdev->gadget);
+			spin_lock(&pdev->lock);
+		}
+	}
+
+	if (usb_irq & USBIRQ_LPM) {
+		u8 reg = readb(&pdev->usb_regs->lpmctrl);
+
+		/* LPM1 enter */
+		if (!(reg & LPMCTRLLH_LPMNYET))
+			writeb(0, &pdev->usb_regs->sleep_clkgate);
+	}
+
+	if (usb_irq & USBIRQ_SUSPEND) {
+		if (pdev->gadget_driver && pdev->gadget_driver->suspend) {
+			spin_unlock(&pdev->lock);
+			pdev->gadget_driver->suspend(&pdev->gadget);
+			spin_lock(&pdev->lock);
+		}
+	}
+
+	if (usb_irq & USBIRQ_URESET) {
+		if (pdev->gadget_driver) {
+			pdev->dev_address = 0;
+
+			spin_unlock(&pdev->lock);
+			usb_gadget_udc_reset(&pdev->gadget,
+					     pdev->gadget_driver);
+			spin_lock(&pdev->lock);
+
+			/*
+			 * The USBIRQ_URESET is reported at the beginning of
+			 * reset signal. 100ms is enough time to finish reset
+			 * process. For high-speed reset procedure is completed
+			 * when controller detect HS mode.
+			 */
+			for (i = 0; i < 100; i++) {
+				mdelay(1);
+				speed = cdns2_get_speed(pdev);
+				if (speed == USB_SPEED_HIGH)
+					break;
+			}
+
+			pdev->gadget.speed = speed;
+			cdns2_enable_l1(pdev, 0);
+			cdns2_ep0_config(pdev);
+			pdev->may_wakeup = 0;
+		}
+	}
+
+	if (usb_irq & USBIRQ_SUDAV) {
+		pdev->ep0_stage = CDNS2_SETUP_STAGE;
+		cdns2_handle_setup_packet(pdev);
+	}
+
+	return IRQ_HANDLED;
+}
+
+/* Deferred USB interrupt handler. */
+static irqreturn_t cdns2_thread_irq_handler(int irq, void *data)
+{
+	struct cdns2_device *pdev = data;
+	unsigned long  dma_ep_ists;
+	unsigned long flags;
+	unsigned int bit;
+
+	local_bh_disable();
+	spin_lock_irqsave(&pdev->lock, flags);
+
+	cdns2_thread_usb_irq_handler(pdev);
+
+	dma_ep_ists = readl(&pdev->adma_regs->ep_ists);
+	if (!dma_ep_ists)
+		goto unlock;
+
+	/* Handle default endpoint OUT. */
+	if (dma_ep_ists & DMA_EP_ISTS_EP_OUT0)
+		cdns2_handle_ep0_interrupt(pdev, USB_DIR_OUT);
+
+	/* Handle default endpoint IN. */
+	if (dma_ep_ists & DMA_EP_ISTS_EP_IN0)
+		cdns2_handle_ep0_interrupt(pdev, USB_DIR_IN);
+
+	dma_ep_ists &= ~(DMA_EP_ISTS_EP_OUT0 | DMA_EP_ISTS_EP_IN0);
+
+	for_each_set_bit(bit, &dma_ep_ists, sizeof(u32) * BITS_PER_BYTE) {
+		u8 ep_idx = bit > 16 ? (bit - 16) * 2 : (bit * 2) - 1;
+
+		/*
+		 * Endpoints in pdev->eps[] are held in order:
+		 * ep0, ep1out, ep1in, ep2out, ep2in... ep15out, ep15in.
+		 * but in dma_ep_ists in order:
+		 * ep0 ep1out ep2out ... ep15out ep0in ep1in .. ep15in
+		 */
+		cdns2_handle_epx_interrupt(&pdev->eps[ep_idx]);
+	}
+
+unlock:
+	writel(~0, &pdev->adma_regs->ep_ien);
+	writeb(USB_IEN_INIT, &pdev->interrupt_regs->usbien);
+	writeb(EXTIRQ_WAKEUP, &pdev->interrupt_regs->extien);
+
+	spin_unlock_irqrestore(&pdev->lock, flags);
+	local_bh_enable();
+
+	return IRQ_HANDLED;
+}
+
+/* Calculates and assigns onchip memory for endpoints. */
+static void cdns2_eps_onchip_buffer_init(struct cdns2_device *pdev)
+{
+	struct cdns2_endpoint *pep;
+	int min_buf_tx = 0;
+	int min_buf_rx = 0;
+	u16 tx_offset = 0;
+	u16 rx_offset = 0;
+	int free;
+	int i;
+
+	for (i = 0; i < CDNS2_ENDPOINTS_NUM; i++) {
+		pep = &pdev->eps[i];
+
+		if (!(pep->ep_state & EP_CLAIMED))
+			continue;
+
+		if (pep->dir)
+			min_buf_tx += pep->buffering;
+		else
+			min_buf_rx += pep->buffering;
+	}
+
+	for (i = 0; i < CDNS2_ENDPOINTS_NUM; i++) {
+		pep = &pdev->eps[i];
+
+		if (!(pep->ep_state & EP_CLAIMED))
+			continue;
+
+		if (pep->dir) {
+			free = pdev->onchip_tx_buf - min_buf_tx;
+
+			if (free + pep->buffering >= 4)
+				free = 4;
+			else
+				free = free + pep->buffering;
+
+			min_buf_tx = min_buf_tx - pep->buffering + free;
+
+			pep->buffering = free;
+
+			writel(tx_offset,
+			       &pdev->epx_regs->txstaddr[pep->num - 1]);
+			pdev->epx_regs->txstaddr[pep->num - 1] = tx_offset;
+
+			dev_dbg(pdev->dev, "%s onchip address %04x, buffering: %d\n",
+				pep->name, tx_offset, pep->buffering);
+
+			tx_offset += pep->buffering * 1024;
+		} else {
+			free = pdev->onchip_rx_buf - min_buf_rx;
+
+			if (free + pep->buffering >= 4)
+				free = 4;
+			else
+				free = free + pep->buffering;
+
+			min_buf_rx = min_buf_rx - pep->buffering + free;
+
+			pep->buffering = free;
+			writel(rx_offset,
+			       &pdev->epx_regs->rxstaddr[pep->num - 1]);
+
+			dev_dbg(pdev->dev, "%s onchip address %04x, buffering: %d\n",
+				pep->name, rx_offset, pep->buffering);
+
+			rx_offset += pep->buffering * 1024;
+		}
+	}
+}
+
+/* Configure hardware endpoint. */
+static int cdns2_ep_config(struct cdns2_endpoint *pep, bool enable)
+{
+	bool is_iso_ep = (pep->type == USB_ENDPOINT_XFER_ISOC);
+	struct cdns2_device *pdev = pep->pdev;
+	u32 max_packet_size;
+	u8 dir = 0;
+	u8 ep_cfg;
+	u8 mult;
+	u32 val;
+	int ret;
+
+	switch (pep->type) {
+	case USB_ENDPOINT_XFER_INT:
+		ep_cfg = EPX_CON_TYPE_INT;
+		break;
+	case USB_ENDPOINT_XFER_BULK:
+		ep_cfg = EPX_CON_TYPE_BULK;
+		break;
+	default:
+		mult = USB_EP_MAXP_MULT(pep->endpoint.desc->wMaxPacketSize);
+		ep_cfg = mult << EPX_CON_ISOD_SHIFT;
+		ep_cfg |= EPX_CON_TYPE_ISOC;
+
+		if (pep->dir) {
+			set_reg_bit_8(&pdev->epx_regs->isoautoarm, BIT(pep->num));
+			set_reg_bit_8(&pdev->epx_regs->isoautodump, BIT(pep->num));
+			set_reg_bit_8(&pdev->epx_regs->isodctrl, BIT(pep->num));
+		}
+	}
+
+	switch (pdev->gadget.speed) {
+	case USB_SPEED_FULL:
+		max_packet_size = is_iso_ep ? 1023 : 64;
+		break;
+	case USB_SPEED_HIGH:
+		max_packet_size = is_iso_ep ? 1024 : 512;
+		break;
+	default:
+		/* All other speed are not supported. */
+		return -EINVAL;
+	}
+
+	ep_cfg |= (EPX_CON_VAL | (pep->buffering - 1));
+
+	if (pep->dir) {
+		dir = FIFOCTRL_IO_TX;
+		writew(max_packet_size, &pdev->epx_regs->txmaxpack[pep->num - 1]);
+		writeb(ep_cfg, &pdev->epx_regs->ep[pep->num - 1].txcon);
+	} else {
+		writew(max_packet_size, &pdev->epx_regs->rxmaxpack[pep->num - 1]);
+		writeb(ep_cfg, &pdev->epx_regs->ep[pep->num - 1].rxcon);
+	}
+
+	writeb(pep->num | dir | FIFOCTRL_FIFOAUTO,
+	       &pdev->usb_regs->fifoctrl);
+	writeb(pep->num | dir, &pdev->epx_regs->endprst);
+	writeb(pep->num | ENDPRST_FIFORST | ENDPRST_TOGRST | dir,
+	       &pdev->epx_regs->endprst);
+
+	if (max_packet_size == 1024)
+		pep->trb_burst_size = 128;
+	else if (max_packet_size >= 512)
+		pep->trb_burst_size = 64;
+	else
+		pep->trb_burst_size = 16;
+
+	cdns2_select_ep(pdev, pep->num | pep->dir);
+	writel(DMA_EP_CMD_EPRST | DMA_EP_CMD_DFLUSH, &pdev->adma_regs->ep_cmd);
+
+	ret = readl_poll_timeout_atomic(&pdev->adma_regs->ep_cmd, val,
+					!(val & (DMA_EP_CMD_DFLUSH |
+					DMA_EP_CMD_EPRST)),
+					1, 1000);
+
+	if (ret)
+		return ret;
+
+	writel(DMA_EP_STS_TRBERR | DMA_EP_STS_ISOERR, &pdev->adma_regs->ep_sts_en);
+
+	if (enable)
+		writel(DMA_EP_CFG_ENABLE, &pdev->adma_regs->ep_cfg);
+
+	dev_dbg(pdev->dev, "Configure %s: with MPS: %08x, ep con: %02x\n",
+		pep->name, max_packet_size, ep_cfg);
+
+	return 0;
+}
+
+struct usb_request *cdns2_gadget_ep_alloc_request(struct usb_ep *ep,
+						  gfp_t gfp_flags)
+{
+	struct cdns2_endpoint *pep = ep_to_cdns2_ep(ep);
+	struct cdns2_request *preq;
+
+	preq = kzalloc(sizeof(*preq), gfp_flags);
+	if (!preq)
+		return NULL;
+
+	preq->pep = pep;
+
+	return &preq->request;
+}
+
+void cdns2_gadget_ep_free_request(struct usb_ep *ep,
+				  struct usb_request *request)
+{
+	struct cdns2_request *preq = to_cdns2_request(request);
+
+	kfree(preq);
+}
+
+static int cdns2_gadget_ep_enable(struct usb_ep *ep,
+				  const struct usb_endpoint_descriptor *desc)
+{
+	u32 reg = DMA_EP_STS_EN_TRBERREN;
+	struct cdns2_endpoint *pep;
+	struct cdns2_device *pdev;
+	unsigned long flags;
+	int enable = 1;
+	int ret = 0;
+
+	if (!ep || !desc || desc->bDescriptorType != USB_DT_ENDPOINT ||
+	    !desc->wMaxPacketSize) {
+		return -EINVAL;
+	}
+
+	pep = ep_to_cdns2_ep(ep);
+	pdev = pep->pdev;
+
+	if (dev_WARN_ONCE(pdev->dev, pep->ep_state & EP_ENABLED,
+			  "%s is already enabled\n", pep->name))
+		return 0;
+
+	spin_lock_irqsave(&pdev->lock, flags);
+
+	pep->type = usb_endpoint_type(desc);
+	pep->interval = desc->bInterval ? BIT(desc->bInterval - 1) : 0;
+
+	if (pdev->gadget.speed == USB_SPEED_FULL)
+		if (pep->type == USB_ENDPOINT_XFER_INT)
+			pep->interval = desc->bInterval;
+
+	if (pep->interval > ISO_MAX_INTERVAL &&
+	    pep->type == USB_ENDPOINT_XFER_ISOC) {
+		dev_err(pdev->dev, "ISO period is limited to %d (current: %d)\n",
+			ISO_MAX_INTERVAL, pep->interval);
+
+		ret =  -EINVAL;
+		goto exit;
+	}
+
+	/*
+	 * During ISO OUT traffic DMA reads Transfer Ring for the EP which has
+	 * never got doorbell.
+	 * This issue was detected only on simulation, but to avoid this issue
+	 * driver add protection against it. To fix it driver enable ISO OUT
+	 * endpoint before setting DRBL. This special treatment of ISO OUT
+	 * endpoints are recommended by controller specification.
+	 */
+	if (pep->type == USB_ENDPOINT_XFER_ISOC  && !pep->dir)
+		enable = 0;
+
+	ret = cdns2_alloc_tr_segment(pep);
+	if (ret)
+		goto exit;
+
+	ret = cdns2_ep_config(pep, enable);
+	if (ret) {
+		cdns2_free_tr_segment(pep);
+		ret =  -EINVAL;
+		goto exit;
+	}
+
+	pep->ep_state &= ~(EP_STALLED | EP_STALL_PENDING);
+	pep->ep_state |= EP_ENABLED;
+	pep->wa1_set = 0;
+	pep->ring.enqueue = 0;
+	pep->ring.dequeue = 0;
+	reg = readl(&pdev->adma_regs->ep_sts);
+	pep->ring.pcs = !!DMA_EP_STS_CCS(reg);
+	pep->ring.ccs = !!DMA_EP_STS_CCS(reg);
+
+	writel(pep->ring.dma, &pdev->adma_regs->ep_traddr);
+
+	/* one TRB is reserved for link TRB used in DMULT mode*/
+	pep->ring.free_trbs = TRBS_PER_SEGMENT - 1;
+
+exit:
+	spin_unlock_irqrestore(&pdev->lock, flags);
+
+	return ret;
+}
+
+static int cdns2_gadget_ep_disable(struct usb_ep *ep)
+{
+	struct cdns2_endpoint *pep;
+	struct cdns2_request *preq;
+	struct cdns2_device *pdev;
+	unsigned long flags;
+	int val;
+
+	if (!ep)
+		return -EINVAL;
+
+	pep = ep_to_cdns2_ep(ep);
+	pdev = pep->pdev;
+
+	if (dev_WARN_ONCE(pdev->dev, !(pep->ep_state & EP_ENABLED),
+			  "%s is already disabled\n", pep->name))
+		return 0;
+
+	spin_lock_irqsave(&pdev->lock, flags);
+
+	cdns2_select_ep(pdev, ep->desc->bEndpointAddress);
+
+	clear_reg_bit_32(&pdev->adma_regs->ep_cfg, DMA_EP_CFG_ENABLE);
+
+	/*
+	 * Driver needs some time before resetting endpoint.
+	 * It need waits for clearing DBUSY bit or for timeout expired.
+	 * 10us is enough time for controller to stop transfer.
+	 */
+	readl_poll_timeout_atomic(&pdev->adma_regs->ep_sts, val,
+				  !(val & DMA_EP_STS_DBUSY), 1, 10);
+	writel(DMA_EP_CMD_EPRST, &pdev->adma_regs->ep_cmd);
+
+	readl_poll_timeout_atomic(&pdev->adma_regs->ep_cmd, val,
+				  !(val & (DMA_EP_CMD_DFLUSH | DMA_EP_CMD_EPRST)),
+				  1, 1000);
+
+	while (!list_empty(&pep->pending_list)) {
+		preq = cdns2_next_preq(&pep->pending_list);
+		cdns2_gadget_giveback(pep, preq, -ESHUTDOWN);
+	}
+
+	while (!list_empty(&pep->deferred_list)) {
+		preq = cdns2_next_preq(&pep->deferred_list);
+		cdns2_gadget_giveback(pep, preq, -ESHUTDOWN);
+	}
+
+	ep->desc = NULL;
+	pep->ep_state &= ~EP_ENABLED;
+
+	spin_unlock_irqrestore(&pdev->lock, flags);
+
+	return 0;
+}
+
+static int cdns2_ep_enqueue(struct cdns2_endpoint *pep,
+			    struct cdns2_request *preq,
+			    gfp_t gfp_flags)
+{
+	struct cdns2_device *pdev = pep->pdev;
+	struct usb_request *request;
+	int ret = 0;
+
+	request = &preq->request;
+	request->actual = 0;
+	request->status = -EINPROGRESS;
+
+	ret = usb_gadget_map_request_by_dev(pdev->dev, request, pep->dir);
+	if (ret)
+		return ret;
+
+	list_add_tail(&preq->list, &pep->deferred_list);
+
+	if (!(pep->ep_state & EP_STALLED) && !(pep->ep_state & EP_STALL_PENDING))
+		cdns2_start_all_request(pdev, pep);
+
+	return 0;
+}
+
+static int cdns2_gadget_ep_queue(struct usb_ep *ep, struct usb_request *request,
+				 gfp_t gfp_flags)
+{
+	struct usb_request *zlp_request;
+	struct cdns2_request *preq;
+	struct cdns2_endpoint *pep;
+	struct cdns2_device *pdev;
+	unsigned long flags;
+	int ret;
+
+	if (!request || !ep)
+		return -EINVAL;
+
+	pep = ep_to_cdns2_ep(ep);
+	pdev = pep->pdev;
+
+	if (!(pep->ep_state & EP_ENABLED)) {
+		dev_err(pdev->dev, "%s: can't queue to disabled endpoint\n",
+			pep->name);
+		return -EINVAL;
+	}
+
+	spin_lock_irqsave(&pdev->lock, flags);
+
+	preq =  to_cdns2_request(request);
+	ret = cdns2_ep_enqueue(pep, preq, gfp_flags);
+
+	if (ret == 0 && request->zero && request->length &&
+	    (request->length % ep->maxpacket == 0)) {
+		struct cdns2_request *preq;
+
+		zlp_request = cdns2_gadget_ep_alloc_request(ep, GFP_ATOMIC);
+		zlp_request->buf = pdev->zlp_buf;
+		zlp_request->length = 0;
+
+		preq = to_cdns2_request(zlp_request);
+		ret = cdns2_ep_enqueue(pep, preq, gfp_flags);
+	}
+
+	spin_unlock_irqrestore(&pdev->lock, flags);
+	return ret;
+}
+
+int cdns2_gadget_ep_dequeue(struct usb_ep *ep,
+			    struct usb_request *request)
+{
+	struct cdns2_request *preq, *preq_temp, *cur_preq;
+	struct cdns2_endpoint *pep;
+	struct cdns2_trb *link_trb;
+	u8 req_on_hw_ring = 0;
+	unsigned long flags;
+	u32 buffer;
+	int ret = 0;
+	int val, i;
+
+	if (!ep || !request || !ep->desc)
+		return -EINVAL;
+
+	pep = ep_to_cdns2_ep(ep);
+	if (!pep->endpoint.desc) {
+		dev_err(pep->pdev->dev, "%s: can't dequeue to disabled endpoint\n",
+			pep->name);
+		return -ESHUTDOWN;
+	}
+
+	/* Requests has been dequeued during disabling endpoint. */
+	if (!(pep->ep_state & EP_ENABLED))
+		return 0;
+
+	spin_lock_irqsave(&pep->pdev->lock, flags);
+
+	cur_preq = to_cdns2_request(request);
+
+	list_for_each_entry_safe(preq, preq_temp, &pep->pending_list, list) {
+		if (cur_preq == preq) {
+			req_on_hw_ring = 1;
+			goto found;
+		}
+	}
+
+	list_for_each_entry_safe(preq, preq_temp, &pep->deferred_list, list) {
+		if (cur_preq == preq)
+			goto found;
+	}
+
+	goto not_found;
+
+found:
+	link_trb = preq->trb;
+
+	/* Update ring only if removed request is on pending_req_list list. */
+	if (req_on_hw_ring && link_trb) {
+		/* Stop DMA */
+		writel(DMA_EP_CMD_DFLUSH, &pep->pdev->adma_regs->ep_cmd);
+
+		/* Wait for DFLUSH cleared. */
+		readl_poll_timeout_atomic(&pep->pdev->adma_regs->ep_cmd, val,
+					  !(val & DMA_EP_CMD_DFLUSH), 1, 1000);
+
+		buffer = cpu_to_le32(TRB_BUFFER(pep->ring.dma +
+				    ((preq->end_trb + 1) * TRB_SIZE)));
+
+		for (i = 0; i < preq->num_of_trb; i++) {
+			link_trb->buffer = buffer;
+			link_trb->control = cpu_to_le32((le32_to_cpu(link_trb->control)
+					    & TRB_CYCLE) | TRB_CHAIN |
+					    TRB_TYPE(TRB_LINK));
+
+			link_trb = cdns2_next_trb(pep, link_trb);
+		}
+
+		if (pep->wa1_trb == preq->trb)
+			cdns2_wa1_restore_cycle_bit(pep);
+	}
+
+	cdns2_gadget_giveback(pep, cur_preq, -ECONNRESET);
+
+	preq = cdns2_next_preq(&pep->pending_list);
+	if (preq)
+		cdns2_rearm_transfer(pep, 1);
+
+not_found:
+	spin_unlock_irqrestore(&pep->pdev->lock, flags);
+	return ret;
+}
+
+int cdns2_halt_endpoint(struct cdns2_device *pdev,
+			struct cdns2_endpoint *pep,
+			int value)
+{
+	u8 __iomem *conf;
+	int dir = 0;
+
+	if (!(pep->ep_state & EP_ENABLED))
+		return -EPERM;
+
+	if (pep->dir) {
+		dir = ENDPRST_IO_TX;
+		conf = &pdev->epx_regs->ep[pep->num - 1].txcon;
+	} else {
+		conf = &pdev->epx_regs->ep[pep->num - 1].rxcon;
+	}
+
+	if (!value) {
+		struct cdns2_trb *trb = NULL;
+		struct cdns2_request *preq;
+		struct cdns2_trb trb_tmp;
+
+		preq = cdns2_next_preq(&pep->pending_list);
+		if (preq) {
+			trb = preq->trb;
+			if (trb) {
+				trb_tmp = *trb;
+				trb->control = trb->control ^ cpu_to_le32(TRB_CYCLE);
+			}
+		}
+
+		/* Resets Sequence Number */
+		writeb(dir | pep->num, &pdev->epx_regs->endprst);
+		writeb(dir | ENDPRST_TOGRST | pep->num,
+		       &pdev->epx_regs->endprst);
+
+		clear_reg_bit_8(conf, EPX_CON_STALL);
+
+		pep->ep_state &= ~(EP_STALLED | EP_STALL_PENDING);
+
+		if (preq) {
+			if (trb)
+				*trb = trb_tmp;
+
+			cdns2_rearm_transfer(pep, 1);
+		}
+
+		cdns2_start_all_request(pdev, pep);
+	} else {
+		set_reg_bit_8(conf, EPX_CON_STALL);
+		writeb(dir | pep->num, &pdev->epx_regs->endprst);
+		writeb(dir | ENDPRST_FIFORST | pep->num,
+		       &pdev->epx_regs->endprst);
+		pep->ep_state |= EP_STALLED;
+	}
+
+	return 0;
+}
+
+/* Sets/clears stall on selected endpoint. */
+static int cdns2_gadget_ep_set_halt(struct usb_ep *ep, int value)
+{
+	struct cdns2_endpoint *pep = ep_to_cdns2_ep(ep);
+	struct cdns2_device *pdev = pep->pdev;
+	struct cdns2_request *preq;
+	unsigned long flags = 0;
+	int ret;
+
+	spin_lock_irqsave(&pdev->lock, flags);
+
+	preq = cdns2_next_preq(&pep->pending_list);
+	if (value && preq) {
+		ret = -EAGAIN;
+		goto done;
+	}
+
+	if (!value)
+		pep->ep_state &= ~EP_WEDGE;
+
+	ret = cdns2_halt_endpoint(pdev, pep, value);
+
+done:
+	spin_unlock_irqrestore(&pdev->lock, flags);
+	return ret;
+}
+
+static int cdns2_gadget_ep_set_wedge(struct usb_ep *ep)
+{
+	struct cdns2_endpoint *pep = ep_to_cdns2_ep(ep);
+
+	cdns2_gadget_ep_set_halt(ep, 1);
+	pep->ep_state |= EP_WEDGE;
+
+	return 0;
+}
+
+static struct
+cdns2_endpoint *cdns2_find_available_ep(struct cdns2_device *pdev,
+					struct usb_endpoint_descriptor *desc)
+{
+	struct cdns2_endpoint *pep;
+	struct usb_ep *ep;
+	int ep_correct;
+
+	list_for_each_entry(ep, &pdev->gadget.ep_list, ep_list) {
+		unsigned long num;
+		int ret;
+		/* ep name pattern likes epXin or epXout. */
+		char c[2] = {ep->name[2], '\0'};
+
+		ret = kstrtoul(c, 10, &num);
+		if (ret)
+			return ERR_PTR(ret);
+		pep = ep_to_cdns2_ep(ep);
+
+		if (pep->num != num)
+			continue;
+
+		ep_correct = (pep->endpoint.caps.dir_in &&
+			      usb_endpoint_dir_in(desc)) ||
+			     (pep->endpoint.caps.dir_out &&
+			      usb_endpoint_dir_out(desc));
+
+		if (ep_correct && !(pep->ep_state & EP_CLAIMED))
+			return pep;
+	}
+
+	return ERR_PTR(-ENOENT);
+}
+
+/*
+ * Function used to recognize which endpoints will be used to optimize
+ * on-chip memory usage.
+ */
+static struct
+usb_ep *cdns2_gadget_match_ep(struct usb_gadget *gadget,
+			      struct usb_endpoint_descriptor *desc,
+			      struct usb_ss_ep_comp_descriptor *comp_desc)
+{
+	struct cdns2_device *pdev = gadget_to_cdns2_device(gadget);
+	struct cdns2_endpoint *pep;
+	unsigned long flags;
+
+	pep = cdns2_find_available_ep(pdev, desc);
+	if (IS_ERR(pep)) {
+		dev_err(pdev->dev, "no available ep\n");
+		return NULL;
+	}
+
+	spin_lock_irqsave(&pdev->lock, flags);
+
+	if (usb_endpoint_type(desc) == USB_ENDPOINT_XFER_ISOC)
+		pep->buffering = 4;
+	else
+		pep->buffering = 1;
+
+	pep->ep_state |= EP_CLAIMED;
+	spin_unlock_irqrestore(&pdev->lock, flags);
+
+	return &pep->endpoint;
+}
+
+static const struct usb_ep_ops cdns2_gadget_ep_ops = {
+	.enable = cdns2_gadget_ep_enable,
+	.disable = cdns2_gadget_ep_disable,
+	.alloc_request = cdns2_gadget_ep_alloc_request,
+	.free_request = cdns2_gadget_ep_free_request,
+	.queue = cdns2_gadget_ep_queue,
+	.dequeue = cdns2_gadget_ep_dequeue,
+	.set_halt = cdns2_gadget_ep_set_halt,
+	.set_wedge = cdns2_gadget_ep_set_wedge,
+};
+
+static int cdns2_gadget_get_frame(struct usb_gadget *gadget)
+{
+	struct cdns2_device *pdev = gadget_to_cdns2_device(gadget);
+
+	return readw(&pdev->usb_regs->frmnr);
+}
+
+static int cdns2_gadget_wakeup(struct usb_gadget *gadget)
+{
+	struct cdns2_device *pdev = gadget_to_cdns2_device(gadget);
+	unsigned long flags;
+
+	spin_lock_irqsave(&pdev->lock, flags);
+	cdns2_wakeup(pdev);
+	spin_unlock_irqrestore(&pdev->lock, flags);
+
+	return 0;
+}
+
+static int cdns2_gadget_set_selfpowered(struct usb_gadget *gadget,
+					int is_selfpowered)
+{
+	struct cdns2_device *pdev = gadget_to_cdns2_device(gadget);
+	unsigned long flags;
+
+	spin_lock_irqsave(&pdev->lock, flags);
+	pdev->is_selfpowered = !!is_selfpowered;
+	spin_unlock_irqrestore(&pdev->lock, flags);
+	return 0;
+}
+
+/*  Disable interrupts and begin the controller halting process. */
+static void cdns2_quiesce(struct cdns2_device *pdev)
+{
+	set_reg_bit_8(&pdev->usb_regs->usbcs, USBCS_DISCON);
+
+	/* Disable interrupt. */
+	writeb(0, &pdev->interrupt_regs->extien),
+	writeb(0, &pdev->interrupt_regs->usbien),
+	writew(0, &pdev->adma_regs->ep_ien);
+
+	/* Clear interrupt line. */
+	writeb(0x0, &pdev->interrupt_regs->usbirq);
+}
+
+static void cdns2_gadget_config(struct cdns2_device *pdev)
+{
+	cdns2_ep0_config(pdev);
+
+	/* Enable DMA interrupts for all endpoints. */
+	writel(~0x0, &pdev->adma_regs->ep_ien);
+	cdns2_enable_l1(pdev, 0);
+	writeb(USB_IEN_INIT, &pdev->interrupt_regs->usbien);
+	writeb(EXTIRQ_WAKEUP, &pdev->interrupt_regs->extien);
+	writel(DMA_CONF_DMULT, &pdev->adma_regs->conf);
+}
+
+static int cdns2_gadget_pullup(struct usb_gadget *gadget, int is_on)
+{
+	struct cdns2_device *pdev = gadget_to_cdns2_device(gadget);
+	unsigned long flags;
+
+	/*
+	 * Disable events handling while controller is being
+	 * enabled/disabled.
+	 */
+	disable_irq(pdev->irq);
+	spin_lock_irqsave(&pdev->lock, flags);
+
+	if (is_on) {
+		cdns2_gadget_config(pdev);
+		clear_reg_bit_8(&pdev->usb_regs->usbcs, USBCS_DISCON);
+	} else {
+		cdns2_quiesce(pdev);
+	}
+
+	spin_unlock_irqrestore(&pdev->lock, flags);
+	enable_irq(pdev->irq);
+
+	return 0;
+}
+
+static int cdns2_gadget_udc_start(struct usb_gadget *gadget,
+				  struct usb_gadget_driver *driver)
+{
+	struct cdns2_device *pdev = gadget_to_cdns2_device(gadget);
+	enum usb_device_speed max_speed = driver->max_speed;
+	unsigned long flags;
+
+	spin_lock_irqsave(&pdev->lock, flags);
+	pdev->gadget_driver = driver;
+
+	/* Limit speed if necessary. */
+	max_speed = min(driver->max_speed, gadget->max_speed);
+
+	switch (max_speed) {
+	case USB_SPEED_FULL:
+		writeb(SPEEDCTRL_HSDISABLE, &pdev->usb_regs->speedctrl);
+		break;
+	case USB_SPEED_HIGH:
+		writeb(0, &pdev->usb_regs->speedctrl);
+		break;
+	default:
+		dev_err(pdev->dev, "invalid maximum_speed parameter %d\n",
+			max_speed);
+		fallthrough;
+	case USB_SPEED_UNKNOWN:
+		/* Default to highspeed. */
+		max_speed = USB_SPEED_HIGH;
+		break;
+	}
+
+	/* Reset all USB endpoints. */
+	writeb(ENDPRST_IO_TX, &pdev->usb_regs->endprst);
+	writeb(ENDPRST_FIFORST | ENDPRST_TOGRST | ENDPRST_IO_TX,
+	       &pdev->usb_regs->endprst);
+	writeb(ENDPRST_FIFORST | ENDPRST_TOGRST, &pdev->usb_regs->endprst);
+
+	cdns2_eps_onchip_buffer_init(pdev);
+
+	cdns2_gadget_config(pdev);
+	spin_unlock_irqrestore(&pdev->lock, flags);
+
+	return 0;
+}
+
+static int cdns2_gadget_udc_stop(struct usb_gadget *gadget)
+{
+	struct cdns2_device *pdev = gadget_to_cdns2_device(gadget);
+	struct cdns2_endpoint *pep;
+	u32 bEndpointAddress;
+	struct usb_ep *ep;
+	int val;
+
+	pdev->gadget_driver = NULL;
+	pdev->gadget.speed = USB_SPEED_UNKNOWN;
+
+	list_for_each_entry(ep, &pdev->gadget.ep_list, ep_list) {
+		pep = ep_to_cdns2_ep(ep);
+		bEndpointAddress = pep->num | pep->dir;
+		cdns2_select_ep(pdev, bEndpointAddress);
+		writel(DMA_EP_CMD_EPRST, &pdev->adma_regs->ep_cmd);
+		readl_poll_timeout_atomic(&pdev->adma_regs->ep_cmd, val,
+					  !(val & DMA_EP_CMD_EPRST), 1, 100);
+	}
+
+	cdns2_quiesce(pdev);
+
+	writeb(ENDPRST_IO_TX, &pdev->usb_regs->endprst);
+	writeb(ENDPRST_FIFORST | ENDPRST_TOGRST | ENDPRST_IO_TX,
+	       &pdev->epx_regs->endprst);
+	writeb(ENDPRST_FIFORST | ENDPRST_TOGRST, &pdev->epx_regs->endprst);
+
+	return 0;
+}
+
+static const struct usb_gadget_ops cdns2_gadget_ops = {
+	.get_frame = cdns2_gadget_get_frame,
+	.wakeup = cdns2_gadget_wakeup,
+	.set_selfpowered = cdns2_gadget_set_selfpowered,
+	.pullup = cdns2_gadget_pullup,
+	.udc_start = cdns2_gadget_udc_start,
+	.udc_stop = cdns2_gadget_udc_stop,
+	.match_ep = cdns2_gadget_match_ep,
+};
+
+static void cdns2_free_all_eps(struct cdns2_device *pdev)
+{
+	int i;
+
+	for (i = 0; i < CDNS2_ENDPOINTS_NUM; i++)
+		cdns2_free_tr_segment(&pdev->eps[i]);
+}
+
+/* Initializes software endpoints of gadget. */
+static int cdns2_init_eps(struct cdns2_device *pdev)
+{
+	struct cdns2_endpoint *pep;
+	int i;
+
+	for (i = 0; i < CDNS2_ENDPOINTS_NUM; i++) {
+		bool direction = !(i & 1); /* Start from OUT endpoint. */
+		u8 epnum = ((i + 1) >> 1);
+
+		/*
+		 * Endpoints are being held in pdev->eps[] in form:
+		 * ep0, ep1out, ep1in ... ep15out, ep15in.
+		 */
+		if (!CDNS2_IF_EP_EXIST(pdev, epnum, direction))
+			continue;
+
+		pep = &pdev->eps[i];
+		pep->pdev = pdev;
+		pep->num = epnum;
+		/* 0 for OUT, 1 for IN. */
+		pep->dir = direction ? USB_DIR_IN : USB_DIR_OUT;
+		pep->idx = i;
+
+		/* Ep0in and ep0out are represented by pdev->eps[0]. */
+		if (!epnum) {
+			int ret;
+
+			snprintf(pep->name, sizeof(pep->name), "ep%d%s",
+				 epnum, "BiDir");
+
+			cdns2_init_ep0(pdev, pep);
+
+			ret = cdns2_alloc_tr_segment(pep);
+			if (ret) {
+				dev_err(pdev->dev, "Failed to init ep0\n");
+				return ret;
+			}
+		} else {
+			snprintf(pep->name, sizeof(pep->name), "ep%d%s",
+				 epnum, !!direction ? "in" : "out");
+			pep->endpoint.name = pep->name;
+
+			usb_ep_set_maxpacket_limit(&pep->endpoint, 1024);
+			pep->endpoint.ops = &cdns2_gadget_ep_ops;
+			list_add_tail(&pep->endpoint.ep_list, &pdev->gadget.ep_list);
+
+			pep->endpoint.caps.dir_in = direction;
+			pep->endpoint.caps.dir_out = !direction;
+
+			pep->endpoint.caps.type_iso = 1;
+			pep->endpoint.caps.type_bulk = 1;
+			pep->endpoint.caps.type_int = 1;
+		}
+
+		pep->endpoint.name = pep->name;
+		pep->ep_state = 0;
+
+		dev_dbg(pdev->dev, "Init %s, SupType: CTRL: %s, INT: %s, "
+			"BULK: %s, ISOC %s, SupDir IN: %s, OUT: %s\n",
+			pep->name,
+			(pep->endpoint.caps.type_control) ? "yes" : "no",
+			(pep->endpoint.caps.type_int) ? "yes" : "no",
+			(pep->endpoint.caps.type_bulk) ? "yes" : "no",
+			(pep->endpoint.caps.type_iso) ? "yes" : "no",
+			(pep->endpoint.caps.dir_in) ? "yes" : "no",
+			(pep->endpoint.caps.dir_out) ? "yes" : "no");
+
+		INIT_LIST_HEAD(&pep->pending_list);
+		INIT_LIST_HEAD(&pep->deferred_list);
+	}
+
+	return 0;
+}
+
+static int cdns2_gadget_start(struct cdns2_device *pdev)
+{
+	u32 max_speed;
+	void *buf;
+	int val;
+	int ret;
+
+	pdev->usb_regs = pdev->regs;
+	pdev->ep0_regs = pdev->regs;
+	pdev->epx_regs = pdev->regs;
+	pdev->interrupt_regs = pdev->regs;
+	pdev->adma_regs = pdev->regs + CDNS2_ADMA_REGS_OFFSET;
+
+	/* Reset controller. */
+	set_reg_bit_8(&pdev->usb_regs->cpuctrl, CPUCTRL_SW_RST);
+
+	ret = readl_poll_timeout_atomic(&pdev->usb_regs->cpuctrl, val,
+					!(val & CPUCTRL_SW_RST), 1, 10000);
+	if (ret) {
+		dev_err(pdev->dev, "Error: reset controller timeout\n");
+		return -EINVAL;
+	}
+
+	usb_initialize_gadget(pdev->dev, &pdev->gadget, NULL);
+
+	device_property_read_u16(pdev->dev, "cdns,on-chip-tx-buff-size",
+				 &pdev->onchip_tx_buf);
+	device_property_read_u16(pdev->dev, "cdns,on-chip-rx-buff-size",
+				 &pdev->onchip_rx_buf);
+	device_property_read_u32(pdev->dev, "cdns,avail-endpoints",
+				 &pdev->eps_supported);
+
+	/*
+	 * Driver assumes that each USBHS controller has at least
+	 * one IN and one OUT non control endpoint.
+	 */
+	if (!pdev->onchip_tx_buf && !pdev->onchip_rx_buf) {
+		ret = -EINVAL;
+		dev_err(pdev->dev, "Invalid on-chip memory configuration\n");
+		goto put_gadget;
+	}
+
+	if (!(pdev->eps_supported & ~0x00010001)) {
+		ret = -EINVAL;
+		dev_err(pdev->dev, "No hardware endpoints available\n");
+		goto put_gadget;
+	}
+
+	max_speed = usb_get_maximum_speed(pdev->dev);
+
+	switch (max_speed) {
+	case USB_SPEED_FULL:
+	case USB_SPEED_HIGH:
+		break;
+	default:
+		dev_err(pdev->dev, "invalid maximum_speed parameter %d\n",
+			max_speed);
+		fallthrough;
+	case USB_SPEED_UNKNOWN:
+		max_speed = USB_SPEED_HIGH;
+		break;
+	}
+
+	pdev->gadget.max_speed = max_speed;
+	pdev->gadget.speed = USB_SPEED_UNKNOWN;
+	pdev->gadget.ops = &cdns2_gadget_ops;
+	pdev->gadget.name = "usbhs-gadget";
+	pdev->gadget.quirk_avoids_skb_reserve = 1;
+	pdev->gadget.irq = pdev->irq;
+
+	spin_lock_init(&pdev->lock);
+	INIT_WORK(&pdev->pending_status_wq, cdns2_pending_setup_status_handler);
+
+	/* Initialize endpoint container. */
+	INIT_LIST_HEAD(&pdev->gadget.ep_list);
+	pdev->eps_dma_pool = dma_pool_create("cdns2_eps_dma_pool", pdev->dev,
+					     TR_SEG_SIZE, 8, 0);
+	if (!pdev->eps_dma_pool) {
+		dev_err(pdev->dev, "Failed to create TRB dma pool\n");
+		ret = -ENOMEM;
+		goto put_gadget;
+	}
+
+	ret = cdns2_init_eps(pdev);
+	if (ret) {
+		dev_err(pdev->dev, "Failed to create endpoints\n");
+		goto destroy_dma_pool;
+	}
+
+	pdev->gadget.sg_supported = 1;
+
+	pdev->zlp_buf = kzalloc(CDNS2_EP_ZLP_BUF_SIZE, GFP_KERNEL);
+	if (!pdev->zlp_buf) {
+		ret = -ENOMEM;
+		goto destroy_dma_pool;
+	}
+
+	/* Allocate memory for setup packet buffer. */
+	buf = dma_alloc_coherent(pdev->dev, 8, &pdev->ep0_preq.request.dma,
+				 GFP_DMA);
+	pdev->ep0_preq.request.buf = buf;
+
+	if (!pdev->ep0_preq.request.buf) {
+		ret = -ENOMEM;
+		goto free_zlp_buf;
+	}
+
+	/* Add USB gadget device. */
+	ret = usb_add_gadget(&pdev->gadget);
+	if (ret < 0) {
+		dev_err(pdev->dev, "Failed to add gadget\n");
+		goto free_ep0_buf;
+	}
+
+	return 0;
+
+free_ep0_buf:
+	dma_free_coherent(pdev->dev, 8, pdev->ep0_preq.request.buf,
+			  pdev->ep0_preq.request.dma);
+free_zlp_buf:
+	kfree(pdev->zlp_buf);
+destroy_dma_pool:
+	dma_pool_destroy(pdev->eps_dma_pool);
+put_gadget:
+	usb_put_gadget(&pdev->gadget);
+
+	return ret;
+}
+
+int cdns2_gadget_suspend(struct cdns2_device *pdev)
+{
+	unsigned long flags;
+
+	cdns2_disconnect_gadget(pdev);
+
+	spin_lock_irqsave(&pdev->lock, flags);
+	pdev->gadget.speed = USB_SPEED_UNKNOWN;
+
+	usb_gadget_set_state(&pdev->gadget, USB_STATE_NOTATTACHED);
+	cdns2_enable_l1(pdev, 0);
+
+	/* Disable interrupt for device. */
+	writeb(0, &pdev->interrupt_regs->usbien);
+	writel(0, &pdev->adma_regs->ep_ien);
+	spin_unlock_irqrestore(&pdev->lock, flags);
+
+	return 0;
+}
+
+int cdns2_gadget_resume(struct cdns2_device *pdev, bool hibernated)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&pdev->lock, flags);
+
+	if (!pdev->gadget_driver) {
+		spin_unlock_irqrestore(&pdev->lock, flags);
+		return 0;
+	}
+
+	cdns2_gadget_config(pdev);
+
+	if (hibernated)
+		clear_reg_bit_8(&pdev->usb_regs->usbcs, USBCS_DISCON);
+
+	spin_unlock_irqrestore(&pdev->lock, flags);
+
+	return 0;
+}
+
+void cdns2_gadget_remove(struct cdns2_device *pdev)
+{
+	pm_runtime_mark_last_busy(pdev->dev);
+	pm_runtime_put_autosuspend(pdev->dev);
+
+	usb_del_gadget(&pdev->gadget);
+	cdns2_free_all_eps(pdev);
+
+	dma_pool_destroy(pdev->eps_dma_pool);
+	kfree(pdev->zlp_buf);
+	usb_put_gadget(&pdev->gadget);
+}
+
+int cdns2_gadget_init(struct cdns2_device *pdev)
+{
+	int ret;
+
+	/* Ensure 32-bit DMA Mask. */
+	ret = dma_set_mask_and_coherent(pdev->dev, DMA_BIT_MASK(32));
+	if (ret) {
+		dev_err(pdev->dev, "Failed to set dma mask: %d\n", ret);
+		return ret;
+	}
+
+	pm_runtime_get_sync(pdev->dev);
+
+	cdsn2_isoc_burst_opt(pdev);
+
+	ret = cdns2_gadget_start(pdev);
+	if (ret) {
+		pm_runtime_put_sync(pdev->dev);
+		return ret;
+	}
+
+	/*
+	 * Because interrupt line can be shared with other components in
+	 * driver it can't use IRQF_ONESHOT flag here.
+	 */
+	ret = devm_request_threaded_irq(pdev->dev, pdev->irq,
+					cdns2_usb_irq_handler,
+					cdns2_thread_irq_handler,
+					IRQF_SHARED,
+					dev_name(pdev->dev),
+					pdev);
+	if (ret)
+		goto err0;
+
+	return 0;
+
+err0:
+	cdns2_gadget_remove(pdev);
+
+	return ret;
+}
diff --git a/drivers/usb/gadget/udc/cdns2/cdns2-pci.c b/drivers/usb/gadget/udc/cdns2/cdns2-pci.c
new file mode 100644
index 000000000000..ab2891c79b5c
--- /dev/null
+++ b/drivers/usb/gadget/udc/cdns2/cdns2-pci.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Cadence USBHS-DEV controller - PCI Glue driver.
+ *
+ * Copyright (C) 2023 Cadence.
+ *
+ * Author: Pawel Laszczak <pawell@cadence.com>
+ *
+ */
+
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+#include <linux/pci.h>
+
+#include "cdns2-gadget.h"
+
+#define PCI_DRIVER_NAME		"cdns-pci-usbhs"
+#define CDNS_VENDOR_ID		0x17cd
+#define CDNS_DEVICE_ID		0x0120
+#define PCI_BAR_DEV		0
+#define PCI_DEV_FN_DEVICE	0
+
+static int cdns2_pci_probe(struct pci_dev *pdev,
+			   const struct pci_device_id *id)
+{
+	resource_size_t rsrc_start, rsrc_len;
+	struct device *dev = &pdev->dev;
+	struct cdns2_device *priv_dev;
+	struct resource *res;
+	int ret;
+
+	/* For GADGET PCI (devfn) function number is 0. */
+	if (!id || pdev->devfn != PCI_DEV_FN_DEVICE ||
+	    pdev->class != PCI_CLASS_SERIAL_USB_DEVICE)
+		return -EINVAL;
+
+	ret = pcim_enable_device(pdev);
+	if (ret)
+		dev_err(&pdev->dev, "Enabling PCI device has failed %d\n", ret);
+
+	pci_set_master(pdev);
+
+	priv_dev = kzalloc(sizeof(*priv_dev), GFP_KERNEL);
+	if (!priv_dev) {
+		ret = -ENOMEM;
+		goto disable_pci;
+	}
+
+	dev_dbg(dev, "Initialize resources\n");
+	rsrc_start = pci_resource_start(pdev, PCI_BAR_DEV);
+	rsrc_len = pci_resource_len(pdev, PCI_BAR_DEV);
+
+	res = devm_request_mem_region(dev, rsrc_start, rsrc_len, "dev");
+	if (!res) {
+		dev_dbg(dev, "controller already in use\n");
+		ret = -EBUSY;
+		goto free_priv_dev;
+	}
+
+	priv_dev->regs = devm_ioremap(dev, rsrc_start, rsrc_len);
+	if (!priv_dev->regs) {
+		dev_dbg(dev, "error mapping memory\n");
+		ret = -EFAULT;
+		goto free_priv_dev;
+	}
+
+	priv_dev->irq = pdev->irq;
+	dev_dbg(dev, "USBSS-DEV physical base addr: %pa\n",
+		&rsrc_start);
+
+	priv_dev->dev = dev;
+
+	priv_dev->eps_supported = 0x000f000f;
+	priv_dev->onchip_tx_buf = 16;
+	priv_dev->onchip_rx_buf = 16;
+
+	ret = cdns2_gadget_init(priv_dev);
+	if (ret)
+		goto free_priv_dev;
+
+	pci_set_drvdata(pdev, priv_dev);
+
+	device_wakeup_enable(&pdev->dev);
+	if (pci_dev_run_wake(pdev))
+		pm_runtime_put_noidle(&pdev->dev);
+
+	return 0;
+
+free_priv_dev:
+	kfree(priv_dev);
+
+disable_pci:
+	pci_disable_device(pdev);
+
+	return ret;
+}
+
+static void cdns2_pci_remove(struct pci_dev *pdev)
+{
+	struct cdns2_device *priv_dev = pci_get_drvdata(pdev);
+
+	if (pci_dev_run_wake(pdev))
+		pm_runtime_get_noresume(&pdev->dev);
+
+	cdns2_gadget_remove(priv_dev);
+	kfree(priv_dev);
+}
+
+static int cdns2_pci_suspend(struct device *dev)
+{
+	struct cdns2_device *priv_dev = dev_get_drvdata(dev);
+
+	return cdns2_gadget_suspend(priv_dev);
+}
+
+static int cdns2_pci_resume(struct device *dev)
+{
+	struct cdns2_device *priv_dev = dev_get_drvdata(dev);
+
+	return cdns2_gadget_resume(priv_dev, 1);
+}
+
+static const struct dev_pm_ops cdns2_pci_pm_ops = {
+	SYSTEM_SLEEP_PM_OPS(cdns2_pci_suspend, cdns2_pci_resume)
+};
+
+static const struct pci_device_id cdns2_pci_ids[] = {
+	{ PCI_VENDOR_ID_CDNS, CDNS_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,
+	  PCI_CLASS_SERIAL_USB_DEVICE, PCI_ANY_ID },
+	{ 0, }
+};
+
+static struct pci_driver cdns2_pci_driver = {
+	.name = "cdns2-pci",
+	.id_table = &cdns2_pci_ids[0],
+	.probe = cdns2_pci_probe,
+	.remove = cdns2_pci_remove,
+	.driver = {
+		.pm = pm_ptr(&cdns2_pci_pm_ops),
+	}
+};
+
+module_pci_driver(cdns2_pci_driver);
+MODULE_DEVICE_TABLE(pci, cdns2_pci_ids);
+
+MODULE_ALIAS("pci:cdns2");
+MODULE_AUTHOR("Pawel Laszczak <pawell@cadence.com>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Cadence CDNS2 PCI driver");
-- 
2.34.1

