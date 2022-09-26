Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305605E9990
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 08:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiIZGem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 02:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233584AbiIZGe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 02:34:27 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CA032D82;
        Sun, 25 Sep 2022 23:34:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAoZDk93e4f+dy5KzIZ7DlPlATNBLIdxT04ZfjmOzokvaxqg2WIySfmn1gn8SUoXj+0zObPE/h7MQxHTAoq5SWXh/S2/Oa9HC7d7H9VMzOxzZDbuE8m1lHSdOMIl7C0cqdjhvVkoNwA29CU1n7+V+cxpG9gpdiDvNBPum47O/FLjeQzNeIyvxSEqvMv5EpBw8ecwdBbIocycOTg1ut+ADdXqLxiG63JojpAFBx5/AAgVwKH2CVINNphmvK71wIxDYX/Y5mRNb+T6UJt94Ly6uuN1gdu+x7Sci3K2XCwDSB05xc00fp4TXVPEwG3tFlCGAu72jotrBqmH/iqE5Qu8CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tTVvvZzu8JCMGsL/wzE9d/zHikByTOy/N+nAeETMTpU=;
 b=lI7K9bqW3SHQzW5Df17vuiKpFkPy4T1zv5obuPUddf24khkmeG+RUNbW8X8dxhnnkxyBzRvfIi7x2C94PXB1RGYys2NOGrfbv722XQsugP///0F7jOO1ChiDqxeKcWylwRfngnLACS9l94O8JenvOEk2jfsCeU3HP/4GAdSkSXaApakd49uVNMoftBV6bjagOal4YcD6MWIkKph8YPtmeWXvnmMxAUcd9bVK0oDME6GILxHjP0QY5Kwe2BjrVYAEAqyOWwcJOj8OMeu3m54eYWx9uJGAY+wj8yQY28yrrcz5M8eEgL5B3g1AlvBtJOMhtR+ath8A1XoBv3sEIXlSTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTVvvZzu8JCMGsL/wzE9d/zHikByTOy/N+nAeETMTpU=;
 b=jZ+6mGPKqrygj26D56AKO3jig3x+PbbF9g3AzxWUgz0U788TE88S2BSGR/Zzd2aHS70Kik/urjF9zUusO2KYZrvU5rjOQiG4mC6MrE89e3EBb683zvw1zl0U6Ek01NA/DYpEDBuLbhhFrlPCUclZ5pBpKD5x8pPgyMEuQ4mczd0=
Received: from SN7P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::21)
 by SJ0PR02MB8609.namprd02.prod.outlook.com (2603:10b6:a03:3e4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.19; Mon, 26 Sep
 2022 06:34:04 +0000
Received: from SN1NAM02FT0023.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:124:cafe::2f) by SN7P222CA0003.outlook.office365.com
 (2603:10b6:806:124::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17 via Frontend
 Transport; Mon, 26 Sep 2022 06:34:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0023.mail.protection.outlook.com (10.97.4.236) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 06:34:04 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Sun, 25 Sep 2022 23:33:36 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2507.9 via Frontend Transport; Sun, 25 Sep 2022 23:33:36 -0700
Envelope-to: broonie@kernel.org,
 robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 akumarma@amd.com,
 git@amd.com,
 linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 amit.kumar-mahapatra@amd.com,
 michal.simek@amd.com
Received: from [10.140.6.18] (port=46254 helo=xhdlakshmis40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1ochgO-000GAg-5p; Sun, 25 Sep 2022 23:33:36 -0700
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <akumarma@amd.com>, <git@amd.com>, <michal.simek@xilinx.com>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <amit.kumar-mahapatra@amd.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Michal Simek <michal.simek@amd.com>
Subject: [RESEND PATCH v3 1/7] spi: spi-zynqmp-gqspi: Fix kernel-doc warnings
Date:   Mon, 26 Sep 2022 12:03:21 +0530
Message-ID: <20220926063327.20753-2-amit.kumar-mahapatra@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220926063327.20753-1-amit.kumar-mahapatra@xilinx.com>
References: <20220926063327.20753-1-amit.kumar-mahapatra@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1NAM02FT0023:EE_|SJ0PR02MB8609:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fe9c12b-6810-4a0a-561c-08da9f891b51
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3kJcs2PjxtxNOAECylCIk3xALlTeCO4+q44b8pJ1zcj0GfXZTTgmZxX2r3oGuFGULMP+09zho6hE1FMU2BE7a/m/eUdhua9YgPRJB6OTI7CJH+xwG7beNQsKPFd2lmPqKtTXH6yagiGot3PLzkvtjrJpq+DK7K5Cv34/enjWZw6A/lIOnvwsAqdbxKfDJCirVvlqj0E8ZcdOlwvojKuYjap/uOZlIl/+a9f+FXRyKx3ZCVV1gOE4btAnNVBy0cGEj5kmvt6IACk9GdL5K2Kjl2wTXSAId5enjVpWLgkaEACfMXox6/P16kwL89caeMwdcuxU3WfkvHOUqHm77HHRtl1xoTUihZY3YVUFtOgPAHe6/Wumox5unXyck3UghO8MZYdEmBVf3Wy8xVaebWqyfy/2WgiqUrOrpgocBn/Ngu3G/cjmbLRZ0h4BB+T86N9LDXnLKwps8+Q8rhZLZgsGNfPN4JswUUuXt5DWWXI52Ntuy9FlbWHaWzGaaEH61lFk+48h1e6b+ESB+25Vll6qXbQLwqlm589O9iJAcgW78sjMA8HNRrvlUd9SK6Xl16r0CwL3MKpL7J7I3FBRUpNTqCHUj778I1/7cqyD17TtccanMiZ9eX0gSKusrqfbjjoxgb6Sa/SXHmQjmsPw4T7rYY/FGASVVp89DlzLrd6fmatuSg9bqE5HTuH6IcgAaufFHGD3H5MJvjat+ZT4n+3aS1kimXUGt+wa71gIPPRD9EUi02dLJQWWgNW6/QpGsTDnqfBHA5rJgiXSN2OzqtNi0JczpFfapAP8clYM8tYe6sI=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(346002)(396003)(451199015)(40470700004)(36840700001)(46966006)(82740400003)(316002)(2906002)(7416002)(36756003)(41300700001)(70586007)(9786002)(2616005)(26005)(7696005)(1076003)(6666004)(83380400001)(478600001)(40460700003)(40480700001)(426003)(336012)(5660300002)(82310400005)(70206006)(4326008)(186003)(8676002)(356005)(7636003)(47076005)(110136005)(36860700001)(8936002)(54906003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 06:34:04.3060
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fe9c12b-6810-4a0a-561c-08da9f891b51
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0023.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8609
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
index c760aac070e5..973008a30a09 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -141,6 +141,7 @@ enum mode_type {GQSPI_MODE_IO, GQSPI_MODE_DMA};
 
 /**
  * struct zynqmp_qspi - Defines qspi driver instance
+ * @ctlr:		Pointer to the spi controller information
  * @regs:		Virtual address of the QSPI controller registers
  * @refclk:		Pointer to the peripheral clock
  * @pclk:		Pointer to the APB clock
@@ -157,6 +158,7 @@ enum mode_type {GQSPI_MODE_IO, GQSPI_MODE_DMA};
  * @genfifoentry:	Used for storing the genfifoentry instruction.
  * @mode:		Defines the mode in which QSPI is operating
  * @data_completion:	completion structure
+ * @op_lock:		Operational lock
  */
 struct zynqmp_qspi {
 	struct spi_controller *ctlr;
@@ -739,6 +741,8 @@ static irqreturn_t zynqmp_qspi_irq(int irq, void *dev_id)
 /**
  * zynqmp_qspi_setuprxdma - This function sets up the RX DMA operation
  * @xqspi:	xqspi is a pointer to the GQSPI instance.
+ *
+ * Return:	0 on success; error value otherwise.
  */
 static int zynqmp_qspi_setuprxdma(struct zynqmp_qspi *xqspi)
 {
@@ -823,6 +827,8 @@ static void zynqmp_qspi_write_op(struct zynqmp_qspi *xqspi, u8 tx_nbits,
  * @rx_nbits:	Receive buswidth.
  * @genfifoentry:	genfifoentry is pointer to the variable in which
  *			GENFIFO	mask is returned to calling function
+ *
+ * Return:	0 on success; error value otherwise.
  */
 static int zynqmp_qspi_read_op(struct zynqmp_qspi *xqspi, u8 rx_nbits,
 				u32 genfifoentry)
-- 
2.17.1

