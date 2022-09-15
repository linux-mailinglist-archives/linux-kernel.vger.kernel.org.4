Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E8B5B9A67
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 14:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiIOMI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 08:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiIOMIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 08:08:15 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2058.outbound.protection.outlook.com [40.107.102.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819767C18D;
        Thu, 15 Sep 2022 05:08:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJRh0b1LYbXqASHwtjrfyj7nxGZQiXrWkZ29f6wm1gE4bVLKkV2xY1NxbYxGmu30/PFsB07SdwEi8gewGt2nsZNbl/MGGWbl6RSfEjNaMvaUsnUrXsEiXAjhMs+TkZ9GzGbKTiUwZ8j8+hFwZ9s7Hwiqkf0FtcQ/AM54UCKKZU++TUE4bZUKzuyeLuEXB0AWfbSJH7UdKsS1aNM+z7RvayQAsKbrCPJ6oSgUAfsDHh48CLGOO1sfxibGZgSn6QZOa2j84czp1Kf6xrzgEYeAsSEgyHXoK/LjNxDIKFYxJloK2nPQaXKIMGe5nVRcW4PwOTxEap31lDceQOduTYbpNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHGXdcCclwMxslvdOuebcpfo4WYKG30IOrI1Uia/yu4=;
 b=RYemKtPxdPxTQ4xW2mJJHkDdMS7nyxd1kwkbRthcfO0pYwOaCv+WakIJw/K4qhxjOFzAOIqhI+6a+2bupQux1k2sI8VbydHDjt83Q1Yah4OQ9GOmugqVRzvbAZE9vm/UYnjOHP4pezE5bZ6/TLA7ealt9PWVndkJHl1ibM7QcENYq8TKQxR3IICkWweY4EayQSU2aEaOizk9gnDMNQUruyNZxD1WDoafh0E5X/o5rrfNS302LiYEFZsQEHkco/ey2mJpXnBJpXShbne2CymwXmNY70VpSBBa0ibYqhVYWZY8Y77BNPjFml49T5NlmxDKmtC51OsLtdbbk3T8ZPG5lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHGXdcCclwMxslvdOuebcpfo4WYKG30IOrI1Uia/yu4=;
 b=RREaE1i2qk8mjTTpWQuJ7XqYwiUCLmhXHwbTyyC5EFVB9cNNxoDhFVir5d0SUUuJmdvwg06yCyqKI9VQwk4Nx/02X1xv0s6Q7MBaypFqe+9G+A/w2cis6h6manNWeGiCoYtrP3u8GhHv4e828cLocB7l2yExG+u236Red6kxt1k=
Received: from DS7PR03CA0214.namprd03.prod.outlook.com (2603:10b6:5:3ba::9) by
 IA1PR02MB9134.namprd02.prod.outlook.com (2603:10b6:208:42e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 12:08:10 +0000
Received: from DM3NAM02FT015.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:3ba::4) by DS7PR03CA0214.outlook.office365.com
 (2603:10b6:5:3ba::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15 via Frontend
 Transport; Thu, 15 Sep 2022 12:08:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT015.mail.protection.outlook.com (10.13.5.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Thu, 15 Sep 2022 12:08:09 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Thu, 15 Sep 2022 05:07:59 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2507.9 via Frontend Transport; Thu, 15 Sep 2022 05:07:59 -0700
Envelope-to: broonie@kernel.org,
 robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 git@amd.com,
 michal.simek@amd.com,
 linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 akumarma@amd.com
Received: from [10.140.6.39] (port=33420 helo=xhdsgoud40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1oYnex-000Fci-3g; Thu, 15 Sep 2022 05:07:59 -0700
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <git@amd.com>, <michal.simek@amd.com>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <akumarma@amd.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Subject: [PATCH v2 1/7] spi: spi-zynqmp-gqspi: Fix kernel-doc warnings
Date:   Thu, 15 Sep 2022 17:37:44 +0530
Message-ID: <20220915120750.1424984-2-amit.kumar-mahapatra@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220915120750.1424984-1-amit.kumar-mahapatra@xilinx.com>
References: <20220915120750.1424984-1-amit.kumar-mahapatra@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3NAM02FT015:EE_|IA1PR02MB9134:EE_
X-MS-Office365-Filtering-Correlation-Id: 472d968d-ef10-439d-4069-08da9712f4e5
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: axkwMYVnmeJPLKeDqwE+2mU+tvA3J2KUZpOnqfVGyuHy7iNsjfNNhJ2EIFK+tVaVTumo/R6rf29wstNmisUukqWQ8anevdJvUz8D9dg4p2InY+tOjXrHYuWO+wCfqRPqgmwTZPbmktKcupMtb3pl0KeL2HRo+3VClEjdw3or2dXpaVqcaA+6UQxe9jtDqlzXD3f1nTwTbiVLVvDrHaZi32wOeepogLuN7+T6mG9zkP2pXwX1OYOm8LSDkHBrXrm/XS85lrOuPnTuqFSpZVdWVZRX6hRCTHkdK3nHl7paXalOauv0K9+S5NZm0HTLHoFhxnRuJLFLi6R3EISQQhryXI7d8RFGlflgCzUOhRV+/2G2whfcEOVgZUyJm9qehuug6xZcEKQeKPflLOeY7LVXXlgMEXzCy6ZBadZ/G5dGZVlo4QcDPU0IH4WK2fR3UBMZESAYjs3dFrymVRmRlICWvSm8qJ9pC56vMd6ov/dXC45CEatey/FjmEJXog9xeYM1l5fJAzotKTb4ddnffXub9/bmi7CMFnyN2iP32eLJ1b6q4f0mt7OK2C/XptoeDj5tdP+Urg6PDeBEu3f4un69T33bREY+ZpjBI+ee5tZBYnEXSiTK7SDeK3qJu1GaEl+xiFd1RJPeb0/gWePjnt4MdTrZSDVZrppJZmllqmkqO8lTGkju9I2AATVfdSFT6dmWt7YHtvtDIcMk7CDGr0b005nn4YJTOMwjv6Jg9AgygTgryN1K0ZXdPjzKasBLBQ4SrPEN1QiChJceZK5woFeGkiEfWjgwKJ509ZW30qEQ05o=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199015)(36840700001)(46966006)(40470700004)(36756003)(47076005)(36860700001)(2906002)(40480700001)(54906003)(426003)(336012)(186003)(9786002)(83380400001)(1076003)(26005)(7696005)(356005)(5660300002)(70206006)(8936002)(316002)(82310400005)(8676002)(70586007)(7416002)(82740400003)(2616005)(478600001)(40460700003)(41300700001)(4326008)(6666004)(7636003)(110136005)(107886003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 12:08:09.9123
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 472d968d-ef10-439d-4069-08da9712f4e5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT015.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9134
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document zynqmp_qspi ctrl and op_lock member description. It also adds
return documentation for 'zynqmp_qspi_setuprxdma' and zynqmp_qspi_read_op.

Fixes below kernel-doc warnings-

spi-zynqmp-gqspi.c:178: warning: Function parameter or member 'ctlr' not
described in 'zynqmp_qspi'
spi-zynqmp-gqspi.c:178: warning: Function parameter or member 'op_lock'
not described in 'zynqmp_qspi'

spi-zynqmp-gqspi.c:737: warning: No description found for return value of
'zynqmp_qspi_setuprxdma'
spi-zynqmp-gqspi.c:822: warning: No description found for return value of
'zynqmp_qspi_read_op'

Signed-off-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 2b5afae8ff7f..b07bb97cf874 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -139,6 +139,7 @@ enum mode_type {GQSPI_MODE_IO, GQSPI_MODE_DMA};
 
 /**
  * struct zynqmp_qspi - Defines qspi driver instance
+ * @ctlr:		Pointer to the spi controller information
  * @regs:		Virtual address of the QSPI controller registers
  * @refclk:		Pointer to the peripheral clock
  * @pclk:		Pointer to the APB clock
@@ -155,6 +156,7 @@ enum mode_type {GQSPI_MODE_IO, GQSPI_MODE_DMA};
  * @genfifoentry:	Used for storing the genfifoentry instruction.
  * @mode:		Defines the mode in which QSPI is operating
  * @data_completion:	completion structure
+ * @op_lock:		Operational lock
  */
 struct zynqmp_qspi {
 	struct spi_controller *ctlr;
@@ -732,6 +734,8 @@ static irqreturn_t zynqmp_qspi_irq(int irq, void *dev_id)
 /**
  * zynqmp_qspi_setuprxdma - This function sets up the RX DMA operation
  * @xqspi:	xqspi is a pointer to the GQSPI instance.
+ *
+ * Return:	0 on success; error value otherwise.
  */
 static int zynqmp_qspi_setuprxdma(struct zynqmp_qspi *xqspi)
 {
@@ -816,6 +820,8 @@ static void zynqmp_qspi_write_op(struct zynqmp_qspi *xqspi, u8 tx_nbits,
  * @rx_nbits:	Receive buswidth.
  * @genfifoentry:	genfifoentry is pointer to the variable in which
  *			GENFIFO	mask is returned to calling function
+ *
+ * Return:	0 on success; error value otherwise.
  */
 static int zynqmp_qspi_read_op(struct zynqmp_qspi *xqspi, u8 rx_nbits,
 				u32 genfifoentry)
-- 
2.25.1

