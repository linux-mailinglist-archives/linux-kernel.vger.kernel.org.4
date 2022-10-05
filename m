Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D195F5AF0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 22:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbiJEUYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 16:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiJEUXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 16:23:49 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7582A61709;
        Wed,  5 Oct 2022 13:23:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OljuwGzO7cgFCJs/y/NL6/idm1Y90DgGGerpENgMgkXJQ9+7fV2OCFsAfHm8GGlZFOL52MunkqvthXQ0lAR2Uqb3XsX/rfuFQZjrECfzLq4SlAA5jLuHiAQF5DGXhSklpHJSBsmqBpK4+0uUwn/jml6HkMIOguQVlVHtCbhHZi8RZx4cWjw+11Pi2/py+AohRqzI+dGefAYlQ94m0yfrEFonHY5QFrHbHOwfsL65yOUWbKvYQgegNKOUdLP1i+SQB0wFKTAzwh9hZxpobvZQVqabE0d47dhhr6CrAV1v98Ue3ChaHhEt51jducKimgQ89WxIM5cXm7hhJRwscFCw/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96SyMYaEhp/G8c/UdkpIFtlYp8Cj0A/zeQm8eFABo0A=;
 b=j16fUVBCw1gTXZzN3DJoYwp3Pdt4CVlitOxuY8glWQQc5fIn1Jb7tNsCPbu40x318iiGhZPPjJ09plp1IfmK608PVMcP02LIOFi1djE7WRUSmveWPnJm9Ri/saMmACxVZ0c1CdEjsTrS0ZWj6w/DfXHJoNeEcBFxJKZPNDyWRfY55P+E78gltumKK25y/ysY/w3HK4w1ed6ECAcDLC6lCEIb2d34mYjy/cn9a/Fq4wLXWun1k9wNZh8MsszQDUXweCKQL+42KBkFnXWsZENIdRNU5cE5GBAoNqTe5CSOs+Lxd2ak8BnMwHb0C978hrxtmWctT5p5yihL0lRgWR+piA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96SyMYaEhp/G8c/UdkpIFtlYp8Cj0A/zeQm8eFABo0A=;
 b=LGJX7GJ9+ms5qqSiggwOq8WTpGn8c16bfDV/N3KY51EHEg6jdNU9twRMX4V4EsDim/CsDPi2+3ZlEeFWZoLFRbQmXGh62ExyUa8ElU4M+p+W5nF4lVYoxR4LztbEKRDmyCZLHkNkGbjGnz1AUk1jia00S2Y1Nq4csvwD9iQuWpc=
Received: from DS7PR03CA0328.namprd03.prod.outlook.com (2603:10b6:8:2b::30) by
 PH7PR12MB6881.namprd12.prod.outlook.com (2603:10b6:510:1b7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 5 Oct
 2022 20:23:46 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::ad) by DS7PR03CA0328.outlook.office365.com
 (2603:10b6:8:2b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23 via Frontend
 Transport; Wed, 5 Oct 2022 20:23:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 20:23:45 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 5 Oct
 2022 15:23:44 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mathias.nyman@intel.com>, <mika.westerberg@linux.intel.com>
CC:     <Sanju.Mehta@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/4] xhci-pci: Allow host runtime PM as default for AMD Pink Sardine
Date:   Wed, 5 Oct 2022 15:23:52 -0500
Message-ID: <20221005202353.1269-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221005202353.1269-1-mario.limonciello@amd.com>
References: <20221005202353.1269-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT021:EE_|PH7PR12MB6881:EE_
X-MS-Office365-Filtering-Correlation-Id: 57d57eff-c9b3-44e1-a7cb-08daa70f811f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: beOE195AXSZMiLWfMn+VzFOhQoBU26Wb2+bC2iO4Xk+NdxA765iGwoUujhaOAxvdskL3eenFwi/0KhstuhGk6ghJPQVUV2Uqh2vyNV3pTPtT6cE6JEJBMfB5BQ4CnA1ecBKdyeZUNlZF0r1iQ9+8Qrjd9UGfCu0XCmcR6OPqasfHvEbiLNQTubhy6UOluW+pqorOuCHTmv5SkfYVqOWQK1F9ze8lFK9MYsg/CJwghpfZyc/ehXt/NLLtcClhYYMdGSgszD14Oee9kcu14vssyvw6uAymckjEv13uuc7HWXeXXpV0LgarsnRgZM3dRXWxClOThIhLj+N6KInY0v+4f3Fr0f0MVNgGUXH6TLTBPs0JGkL5UG7Uk64k8qZR4VJE2gc+K0ePAIJzbustDuPUc0CJ3ULJqiPJX80yeJ8Qdgve3vk0Q7Ws5JqFrQzYwgCHk9bzRWjo32K87sGEB5Jxve5iQU2zRFH3ZJBEU1APnFHjPPNMlhrmzldKziBVO4Ei8t1KB4ypD6BYu8IkhmPNCqSdLquLy3IwQGzABYZjMkcwdT4hfllMuyAwDJQ8zqGLQX76QjGA9mIultXzszI9W1EkzJFntDZJCK/WduowBpTQyBJud0mNKdQw0VQl6ONebiY5gLwK+ddq0y1+aqj3jXGhWBR9Nn2VGgb+gWPVSMwcvUSXHdQWZ7DmviRKJpuMAyqkSNAcaGjiGX3F7Uhw1OCLh7kkvjGskpewC1W15k4xKnZnc2B/cJ/AMhpc4iXAFapROufsKjiIZcDKh/ZBukRK2SMpJeyZsOZINSSFicsgNwPcqyzceTEcJ/Efh3rd
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199015)(36840700001)(46966006)(40470700004)(6666004)(186003)(26005)(336012)(40460700003)(16526019)(7696005)(426003)(47076005)(2906002)(1076003)(2616005)(316002)(41300700001)(5660300002)(36756003)(4326008)(44832011)(8676002)(8936002)(82310400005)(40480700001)(478600001)(70206006)(54906003)(110136005)(86362001)(36860700001)(356005)(81166007)(83380400001)(70586007)(82740400003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 20:23:45.7936
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57d57eff-c9b3-44e1-a7cb-08daa70f811f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6881
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The XHCI controllers not connected to the USB4 controller via a device
link can support D3. For optimal runtime power consumption on AMD Pink
Sardine, all XHCI controllers must support runtime suspend.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
RFC v1->PATCH v1
 * Rebase on moving IDs into a table
---
 drivers/usb/host/xhci-pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index c17f748b05929..8e7ed038880b5 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -71,6 +71,8 @@
 #define PCI_DEVICE_ID_AMD_REMBRANDT_XHCI_4		0x161e
 #define PCI_DEVICE_ID_AMD_REMBRANDT_XHCI_5		0x161c
 #define PCI_DEVICE_ID_AMD_REMBRANDT_XHCI_6		0x161f
+#define PCI_DEVICE_ID_AMD_PINK_SARDINE_XHCI_1		0x15b9
+#define PCI_DEVICE_ID_AMD_PINK_SARDINE_XHCI_2		0x15ba
 
 #define PCI_DEVICE_ID_ASMEDIA_1042_XHCI			0x1042
 #define PCI_DEVICE_ID_ASMEDIA_1042A_XHCI		0x1142
@@ -100,6 +102,8 @@ static const struct pci_device_id runtime_allow_pci_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_REMBRANDT_XHCI_4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_REMBRANDT_XHCI_5) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_REMBRANDT_XHCI_6) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_PINK_SARDINE_XHCI_1) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_PINK_SARDINE_XHCI_2) },
 	{ 0 }
 };
 
-- 
2.34.1

