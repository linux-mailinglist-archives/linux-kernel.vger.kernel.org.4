Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD3D6C0E18
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjCTKEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjCTKEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:04:24 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BE624487;
        Mon, 20 Mar 2023 03:03:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bg7s6ipm3IubWkD5opr+nmcIurdzFByJDOWcjw01E9CsIDN3vTG2k1VBf4P0c/Hu1QNnfMjV4hGSLjLTL0qGab0oVWMPk5dSTt2/CzsklLZIYssBlahTJo/slyCqIu0X/jOBHJz2cem9piXeF8wHv1DW44Ka/sEZUEybbDH5K1QLG9yXo7raOzM8e8GSV0i4UPq+7cQRQg+oSQdlPFW374WWQJ766x09QrCtflTBcvNiUgAiQm4v1h2OImWlBiktKbSV6QaezbgqZrJfB7KhFx7dgasI2hYUoOUCB0QzpGQK1N5UrUoWuk/tc5fE2NhPNrDAazBBmDMoTPLoE+xzhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTWxlqoMJ70ifXeAo5k+ECxwHWq38BbP7mSS2eLRrJI=;
 b=bYQb0kFpuhmhKrHy2JoL+uIZAcpzadRcuUFzCE29lp9LlnCrxHSsT5/YKiJjOmqdIWxsgucGOvN0EcJxBAisOujujhwTyjAc6opb2ALDhxpMay1vpanS+h+S6ExYyUyPv5Q6erw696d6rScZgxCldhnTh2havRjTuVU1tj7k3CuuKLkCBQV/SRi0Qi/EVVsBUdwe+pOM4+84vEsyBBOrzTTCNEbR//SU8Xvhskhif3/9W57j9hm3oQYxg43wsK+2a+EnE3UXmqs7z8DcMCcpAbW48ALkO0Zic9rTpELWK8y5dCClsg0ORkE8J8CBnF+kSRfCocClOck4Z1MJw7eClw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTWxlqoMJ70ifXeAo5k+ECxwHWq38BbP7mSS2eLRrJI=;
 b=IcI0Q/Q1K7L3dBOn94qMOWCSerh1AZvOSGG/bdStjlMIhBgHybdb3xpbZsoth8oCjrypnsekquY+Xc+/6ByuBT6r1yFIBvqaDDuus9XvYDxiPOZjG5y+TnR5sMk1gg0dpxDH3yBKLNVNsaD8crPjb1bONflaGA3OQZg4tLEl/ks=
Received: from MW4PR03CA0210.namprd03.prod.outlook.com (2603:10b6:303:b8::35)
 by PH7PR12MB6465.namprd12.prod.outlook.com (2603:10b6:510:1f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.25; Mon, 20 Mar
 2023 10:03:29 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::dc) by MW4PR03CA0210.outlook.office365.com
 (2603:10b6:303:b8::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Mon, 20 Mar 2023 10:03:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.15 via Frontend Transport; Mon, 20 Mar 2023 10:03:28 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 20 Mar
 2023 05:03:24 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 20 Mar
 2023 05:03:09 -0500
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 20 Mar 2023 05:03:07 -0500
From:   Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>, <saikrishna12468@gmail.com>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Subject: [PATCH 1/2] spi: cadence-quadspi: Update the read timeout based on the length
Date:   Mon, 20 Mar 2023 15:29:30 +0530
Message-ID: <20230320095931.2651714-2-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230320095931.2651714-1-sai.krishna.potthuri@amd.com>
References: <20230320095931.2651714-1-sai.krishna.potthuri@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT056:EE_|PH7PR12MB6465:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e81110b-f3b0-4bca-f6ea-08db292a5aa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 27hyF+Dwq2ElV7AvQe0Oj2jxXC7VwgpPTuzELYv7D8iP8iaiK2rzm8WB3/zrhXhXMRo2N+mMGBr3J7bZcR5KPWSo8gosyUhGcjvZAjfHsX26Z85KhAlw/PYXtG+NabcHZLh/nJ1GS/eDTH0fkp4LPEMSRixhP7dXAbdKjhzEirkQ8P35K2S2//95E+/8inXJYni6/7f0XcRHzIBrzRB042CtQVpps3+c8pXzO5yc4KPyzY2UPwq1iVy4nhZZuNtUw8uRZjSkJnsQYgBtmftNk/mMBgiZ1/mQHWwM2pS4n9m5sWZ0QrXTmvniYW6zeBl+Qlfq65uH25s5ACRrYsbXzljflfo6gFxXp7s9GsH4+jiJTPUtRjNwCUhYyTm6NpJVAG+JM0+yqfYnwWoJfxsRMNcKdbCYN+M6LglJ9iLR0SQIA276haXrZgchQw0e73+hT8GEXwssgQsh1Ipvq1hUvNRGe/8mUlbdMZ6o8oRw03L5IvgkTR4RJ4qLmbwBPvtETWtPN7s1DxQAKldnhl2hJoZTr5mUXl1aFZuVSNv/+YM1LcfUy0wRPgrYWRBeC8Xhtvgo4VCZMSgfCxbM+ZPRMTy1LlRKGMfztEOOJlieE4H1+dCvOzBdC1BiTB/K8F+AUY4hYWQCiwp+lCenzpUwTXI5uFsTV7PKtfXpj9cbEzO90NeC2tkHnS5wpbzGcVoS0j/HKpunkfLCsKM0tdyc2BeONyZPHfmyeKTPLXFedyo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199018)(46966006)(40470700004)(36840700001)(103116003)(40460700003)(6666004)(83380400001)(5660300002)(36756003)(41300700001)(186003)(8936002)(36860700001)(478600001)(2616005)(47076005)(1076003)(82310400005)(70206006)(86362001)(4326008)(54906003)(26005)(336012)(8676002)(40480700001)(356005)(426003)(82740400003)(70586007)(6916009)(2906002)(316002)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 10:03:28.7514
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e81110b-f3b0-4bca-f6ea-08db292a5aa0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6465
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When performing indirect read via external DMA the timeout for
completion is set equal to the read length instead of fixed timeout value.
For reads larger than 500 bytes, the timeout will continue to be
equal to the read length whereas for a small read like the Read Status
Register command, the timeout would be 1 or 2 milliseconds. This is not
enough to cover the overhead needed in setting up DMA, in that case make
sure the timeout is at least 500ms to allow DMA to finish. This solution
is inline with the timeout used for Direct read via DMA.

Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
---
 drivers/spi/spi-cadence-quadspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 79ab7e309644..e281732aba91 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -863,7 +863,7 @@ static int cqspi_versal_indirect_read_dma(struct cqspi_flash_pdata *f_pdata,
 	reinit_completion(&cqspi->transfer_complete);
 
 	if (!wait_for_completion_timeout(&cqspi->transfer_complete,
-					 msecs_to_jiffies(CQSPI_READ_TIMEOUT_MS))) {
+					 msecs_to_jiffies(max_t(size_t, bytes_to_dma, 500)))) {
 		ret = -ETIMEDOUT;
 		goto failrd;
 	}
-- 
2.25.1

