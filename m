Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41EC66A4653
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 16:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjB0PpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 10:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjB0Po5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 10:44:57 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2064.outbound.protection.outlook.com [40.107.100.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE33234FC
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 07:44:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RfiWYLj+Ju3YfA6623gouFujbqk3O4B/Hlbj7NCuQfACy8wMm6rnhODAqHqWy4CeFnAQ1k02EooY/NJTWwN6dq7PxuMHTzLPGlIgLhmgOt20m0E+nl0KLq45SrE/+aPm/KvweDkCWjtHstHt0uAG2P4BSa4abWjv3ZFcmsHkhc2GD4Pu0X5pNhVdQQQ1u2qGDFgLIWUih2uXavyTlDrzCwtjUUehUi6DHQS0hxO2JLg73ngDEF2B3XeVG2efK5fT8IsoVR1zPSZ0Tbbv9fE59Bs1cwzXi4J+9zfixyi+OFRDZ7dND+IZv/D9fCSNbHSCPXQMBln0OgNxo1EX+NbHEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JOwMxJx2pGwRgIeP2+OUjMNk5QXsQIrMlvdrqCdCREc=;
 b=G0sIWiCEnBlR+XWM7fLI4WnnXnE7JUscwI0Mzfri6hcUtx+pt7HzVf9F4Ny/ztkuqKp1hkjrSd6NxoZ6RLwQGtaAa/K1p/q1oz1wpXhgRzdx5AjO840eGV+nT4ysREtywsjpY4zBx1gElmQgYHgTcLMqi5gLn6qDisG74ZfhiZq2SxwwkFI4xqchAuWc+5L9yt/bV4Y4MePJz8DeGvvyl7M8JS1v7Xge3MbhuZv1w7FzKvtEoWV/nCdTKx6qAKNLMLOGbNrskSJUFOC5NH+uvHfor5aleSCB79MtchcW2VolYBARHKNIqiUXM8XilYEs4QCbLbduttf6r5+ABxChXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOwMxJx2pGwRgIeP2+OUjMNk5QXsQIrMlvdrqCdCREc=;
 b=j5mwdRrZZSxN0lHsqZRI8BsjCcyJ5DBCD6OpEc0jDhYD0VXlAogZPPjH9JA/rb6dUKeyx6FFU2Oi7Qrkcemn4aIO09AG+qRvO0iV3YobmfQPByNGSPdnGkcvXTx3yod4SETtMiY8wliBHypkdi+9+ySmGBHu9uMX+K04n7+Qx58=
Received: from MW4PR03CA0202.namprd03.prod.outlook.com (2603:10b6:303:b8::27)
 by CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.26; Mon, 27 Feb
 2023 15:44:33 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::72) by MW4PR03CA0202.outlook.office365.com
 (2603:10b6:303:b8::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29 via Frontend
 Transport; Mon, 27 Feb 2023 15:44:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.16 via Frontend Transport; Mon, 27 Feb 2023 15:44:32 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Feb
 2023 09:44:29 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Feb
 2023 07:44:29 -0800
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Mon, 27 Feb 2023 09:44:25 -0600
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <vkoul@kernel.org>
CC:     <alsa-devel@alsa-project.org>,
        <pierre-louis.bossart@linux.intel.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <Mario.Limonciello@amd.com>, <amadeuszx.slawinski@linux.intel.com>,
        <Mastan.Katragadda@amd.com>, <Arungopal.kondaveeti@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH V4 7/8] soundwire: amd: handle SoundWire wake enable interrupt
Date:   Mon, 27 Feb 2023 21:18:00 +0530
Message-ID: <20230227154801.50319-8-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230227154801.50319-1-Vijendar.Mukunda@amd.com>
References: <20230227154801.50319-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT033:EE_|CH3PR12MB8074:EE_
X-MS-Office365-Filtering-Correlation-Id: 8054ab01-670e-4a6a-b6f0-08db18d98592
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oux5EHUqt1eRSw4shYnvFvGpXabYQBzb1KLboFawk4orp/lpQUxmkaOZS3GaFM7w2fUAusilePOURaZ1ehH2MIQN+HuJ8AmZbRy6u0YLQWXLZ5Z2c8vb2guOrbIOW5jW1+kQOa7y8j/b/bYmjCPhmiO4aHINGpcN1hOnrRGQm8YagzxLem+ozc/S1IQJY+s9rhRTbaFPNcnNcG2wwnqf5YEpDbe8Tq8hCETAsffNz2H2OifBOvaR5AVzHhTkcPb447muclJh4XmBDeohaXFqN378ct9vRMs4kl9msEAjJg3pX3Y0Vh4dxXNBEyo2TQtqKujqWzCvDybFbnmKfIuusWVjFq9eN0FqEjOCjFGiwhSUgmymACbkJNjxt9BGFKbAHHi4XBa0Sj+g2tK7znOOsLUJhctg0a7GsX1yQE4DkeE/b0SSGgUokJMAxv4xwoOkORTDMucSXgWad6IP5nDumnG4bjR63i+aZ+YUcgZAfPBPU8ls2bZmnPwnm8HzjPv9li4yO0z1FqW9jB8VipXbMKkCcyPkC3oHunHpeq+EF/W+mcG7em2PT5KYcbl/SvURjDU6aVKaFnHNWUUVNFjZTtHQ+PRR5ifqs5KZmm6cR64RbxQxHjdZi+5VNwOROO08XV2ZkkldNQqgkkZcc8FzmgIj3WhPY9YyJuWCJzxUf1dJ8uRJiS68H7Taxj8YzkXop0KsLJBxlWIA7PNBcbL7DxXmhu/p7KxC5mw1iy1sTvo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199018)(46966006)(40470700004)(36840700001)(26005)(36756003)(41300700001)(54906003)(316002)(81166007)(40480700001)(83380400001)(82310400005)(86362001)(5660300002)(8936002)(2906002)(70586007)(4326008)(70206006)(6916009)(8676002)(478600001)(356005)(186003)(7696005)(1076003)(6666004)(40460700003)(82740400003)(47076005)(336012)(2616005)(426003)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 15:44:32.9605
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8054ab01-670e-4a6a-b6f0-08db18d98592
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8074
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add wake enable interrupt support for both the SoundWire manager
instances.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Signed-off-by: Mastan Katragadda <Mastan.Katragadda@amd.com>
---
 drivers/soundwire/amd_manager.c | 10 ++++++++++
 drivers/soundwire/amd_manager.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index 12345077c395..88f0ad7ea7ec 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -922,6 +922,13 @@ static void amd_sdw_update_slave_status(u32 status_change_0to7, u32 status_chang
 	}
 }
 
+static void amd_sdw_process_wake_event(struct amd_sdw_manager *amd_manager)
+{
+	pm_request_resume(amd_manager->dev);
+	acp_reg_writel(0x00, amd_manager->acp_mmio + ACP_SW_WAKE_EN(amd_manager->instance));
+	acp_reg_writel(0x00, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_8TO11);
+}
+
 static void amd_sdw_irq_thread(struct work_struct *work)
 {
 	struct amd_sdw_manager *amd_manager =
@@ -933,6 +940,9 @@ static void amd_sdw_irq_thread(struct work_struct *work)
 	status_change_0to7 = acp_reg_readl(amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_0TO7);
 	dev_dbg(amd_manager->dev, "[SDW%d] SDW INT: 0to7=0x%x, 8to11=0x%x\n",
 		amd_manager->instance, status_change_0to7, status_change_8to11);
+	if (status_change_8to11 & AMD_SDW_WAKE_STAT_MASK)
+		return amd_sdw_process_wake_event(amd_manager);
+
 	if (status_change_8to11 & AMD_SDW_PREQ_INTR_STAT) {
 		amd_sdw_read_and_process_ping_status(amd_manager);
 	} else {
diff --git a/drivers/soundwire/amd_manager.h b/drivers/soundwire/amd_manager.h
index 93022a325598..2e9032784f34 100644
--- a/drivers/soundwire/amd_manager.h
+++ b/drivers/soundwire/amd_manager.h
@@ -190,6 +190,7 @@
 #define AMD_SDW_CLK_STOP_DONE				1
 #define AMD_SDW_CLK_RESUME_REQ				2
 #define AMD_SDW_CLK_RESUME_DONE				3
+#define AMD_SDW_WAKE_STAT_MASK				BIT(16)
 
 enum amd_sdw_cmd_type {
 	AMD_SDW_CMD_PING = 0,
-- 
2.34.1

