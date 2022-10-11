Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E905FAC95
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 08:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiJKGVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 02:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiJKGUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 02:20:55 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2061.outbound.protection.outlook.com [40.107.212.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349B92739;
        Mon, 10 Oct 2022 23:20:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LfPk4UEwIfwdS83VFfdLlScfJrK88E7ma1w0pkk/r7fh+3Bpl+JAWfiXdf3rfbc6Y2BL7IOClExUc4TVp6CDRI805MGLdnlegeeQxQk75iUOghOS84m8qjpLZ68eUZ3U8HEH7U62Uxx5snkpt9cRi9hD9NPSY5tsPVEH4dT3naOJknPNJN8z4xu4eEPy3b2QYyvbpEtRVX8NaS+NFfL3s9sdzQI5BizDP7sCDzOe1vqF3JkWakcblI+GRghsKnTWjaOLWv+/1GCQ/pdgFm1/AkoFfEQq9+SRgaT2068stObEXqIlFWR/8i8XeEjlbd76WTdcUnEHnXsHQSWjgWkVDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mf5wEFOE7qzYDkEKwvAk9W63YNBva6HHOCS7K+MHbws=;
 b=cO8+ru4eH68x+CYL96VcMv2myNZEkQWwjvdeTCxLBQ3XjxGu0TzhlI3Qyfoe4v3v4k/3RJXuRRQsijaTuLw5HSXnBPw7GYiBBu8mg8jGkSShJAbnfUn1oeD9DrxtyUmsq0lL1Uk+7HfDHLtUg6gYlHrV1JeTblekE8BcK7BJ85l2Ag9jX7TEwEKnhGqboWlsO8OxGLAw2GQV8RezO4Q9bULHZ6lmFD7Um1iIM08Gw2H9IdCwVD7An77C1yH5Wgerwauyws6Gn2TLC6IMl35VsTL5BVNW2uYLSQ/vIoWkmeeZCwuhHspSoliIw8nyl+vlRhinxLDWhWVQS4ZdxN8L2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mf5wEFOE7qzYDkEKwvAk9W63YNBva6HHOCS7K+MHbws=;
 b=FzMBP0fWCFIQHpbQlsWhbk9rVaiQWqVPpits1qionC8R8NjxJLPdUGVnLeb4SzZlH8dwfuTCD9CAqL3TKBgtpqVNcMEXXnh7Uz11rcabwJu1xlHXj3+XOx5+GGY7bkIAz1luqP8AhhE8ZwTNqiUwvVr0vRpKdmEX6sTjprJULu0=
Received: from BN9PR03CA0415.namprd03.prod.outlook.com (2603:10b6:408:111::30)
 by SA0PR12MB7074.namprd12.prod.outlook.com (2603:10b6:806:2d5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.32; Tue, 11 Oct
 2022 06:20:49 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::95) by BN9PR03CA0415.outlook.office365.com
 (2603:10b6:408:111::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21 via Frontend
 Transport; Tue, 11 Oct 2022 06:20:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Tue, 11 Oct 2022 06:20:49 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 11 Oct
 2022 01:20:48 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 11 Oct
 2022 01:20:48 -0500
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 11 Oct 2022 01:20:45 -0500
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <git@amd.com>, <michal.simek@amd.com>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Subject: [PATCH v4 1/7] spi: spi-zynqmp-gqspi: Fix kernel-doc warnings
Date:   Tue, 11 Oct 2022 11:50:34 +0530
Message-ID: <20221011062040.12116-2-amit.kumar-mahapatra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221011062040.12116-1-amit.kumar-mahapatra@amd.com>
References: <20221011062040.12116-1-amit.kumar-mahapatra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT004:EE_|SA0PR12MB7074:EE_
X-MS-Office365-Filtering-Correlation-Id: 158eb622-e594-4893-f498-08daab50bd7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FQiXm+D0HVkb5EGktw88DwOl74Z53WVOgNaLIUcec+6MsPX2cNn8JCNF/Jwe18SXBD0dz2hwFpFBMjA6eqdLc1jdrBgiJ4RvxPgTfe6mtdS6DaT0KEVspQZRnfhljXfil1rcBDACIot8IMsCnYGA1Q3qped+KsReJnl0j0uwEqitCP8BbmaiGj/z2184/NxlzNk1tvMPBddvjImo5H2E1SPuMG0JA7RZJGxPsnXV41KSRdhMtR3a8YKeyvQVqdAT/IHAlrYaDYr/0MFnBq2W5ocgOqRE0iZQc68bptJnaT4HAXUsc43RSaFlajQM2Buz+K3DaELlnxHVuc4WQNyB/89umjFQoq7KfTI2qsUi9y63kYa9zt8RieUl4vfY0xAoP8Vj4WMENvoOkTRTKgaWZWIFQuWfloIMMPZLVjQMv2CJmlsJuD4YsNH4P+/MlL2Qs70NYntrCEjYLwaK9Xvxwxmv1rvcMtMzjXSJDmewvmvobO0URikiNFDuuYR7SRSafhg1Pfet3xKsMs16Y+IiPoLHkE8cYSvejmYpoO+Lpt5lg4P/ue5ARAKEWKHMdKVeefwi+Vz7DRYoZ0/yUXdlTAPKqbJE8r9R6p7D3ut5d6bUwa4Hb/3lqyO6xcRjvcNoQMurzMeC6Wjm5fku4IDY5IUiwE/y/0epgPyVuJz2O50QhdHaLuFKdfraAa7j2sqgkGyTtKoyWVHaTNPP74nKSD27caGkrAkmRFIgVqV6KdfLP3lDN9vvHEEcG0Cthv7QjYzvuFUjA2vhLedgirkbY6M9lAAA8Qnliy4PKVsiT+MjWcHuQCtLAhbGyCDnPP3V
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(2906002)(70206006)(316002)(36756003)(5660300002)(41300700001)(4326008)(70586007)(8936002)(86362001)(8676002)(54906003)(82310400005)(110136005)(36860700001)(478600001)(83380400001)(82740400003)(47076005)(1076003)(426003)(81166007)(336012)(6666004)(2616005)(40480700001)(186003)(356005)(40460700003)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 06:20:49.0694
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 158eb622-e594-4893-f498-08daab50bd7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7074
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
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

