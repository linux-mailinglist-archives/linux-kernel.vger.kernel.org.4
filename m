Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7623A69C835
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 11:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjBTKDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 05:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjBTKDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 05:03:32 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20603.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::603])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B2C35A2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 02:02:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMLArPKiZadFjNsviLJtiiP4LUIqDWRfIOrwa55aa3zMZQt2wymygb/m4AF/wuvfkvAuMdhjFA26sw6GzsDYWrQeDTKjoM+tehrm6HWmzFHKCS5v5awSnxy+Cl70y6kVNplgzwBMRfQ6z+Djkp766muD/uLdiIKPeyoWlAhYI59g37JXvv/ExMJsMcm+TZdX1l7cjBDAFAQCU3c9d7cHrVplJo4dJVW+FYg4/ZyhL5CB94lGtnQ9PHijFnkQ1BVsksIYFpI6XFmNOMz1G7nicEvFB0n5v70zj+g5fOrVvw7sJf7oTxjF7QwGMUiMTcD06R0K/PlrLOy51QLIGJ5lsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSrYtKknnHEWvkJ6C5XH8IukUTDxJWprm59FHimSPVw=;
 b=aUuRGERuqA4SzWW5HDRP0hEFBrPR6ZjP7B2l31hEOhJY6I4EPP1tvEfe44N/4YSrZZVx9YUSiH3t7/e96Z39dhix0Ku33IObju3A+qk1T935F6XYUwNY386U/elMgu4fi9BAbsl6SMCDpSfV5wbDHmm7X1aqWyC1302NlB8HwG3uAh8clD3XVr207uU7ZzW2CxPbe8EYlZT29evqMeaPfngYZoZcricYirMuhv1wsvugKBRin3a/lmLxmp0vRmC7Fi9fWM89VldZQneHsuTA05UAQZ44/AyKVAWWBzqEOusO4vrk7qSL0xSvmbzuBv74FNOt6WXlwf1imf3L4NXM4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSrYtKknnHEWvkJ6C5XH8IukUTDxJWprm59FHimSPVw=;
 b=kYlic+b+qQeWAeMB+jwxk8dGk3dHeQQ6edb3Nl7H17HHcvHLoqBBm+PdjdWwvZxfQvz2KpPoJduVBdj2v5ZNLYoTRPBM9XqamXYBbgwiioZyN7Z57nBmQTh067ucHHfl3IR89bzwdvztMIiFULULVHHQejboQLJrU0BGY20Czcs=
Received: from DM6PR01CA0027.prod.exchangelabs.com (2603:10b6:5:296::32) by
 IA1PR12MB8587.namprd12.prod.outlook.com (2603:10b6:208:450::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.22; Mon, 20 Feb
 2023 10:02:33 +0000
Received: from DS1PEPF0000E654.namprd02.prod.outlook.com
 (2603:10b6:5:296:cafe::62) by DM6PR01CA0027.outlook.office365.com
 (2603:10b6:5:296::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20 via Frontend
 Transport; Mon, 20 Feb 2023 10:02:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E654.mail.protection.outlook.com (10.167.18.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.14 via Frontend Transport; Mon, 20 Feb 2023 10:02:33 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 20 Feb
 2023 04:02:29 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 20 Feb
 2023 04:01:58 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Mon, 20 Feb 2023 04:01:55 -0600
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <vkoul@kernel.org>
CC:     <pierre-louis.bossart@linux.intel.com>,
        <alsa-devel@alsa-project.org>,
        <amadeuszx.slawinski@linux.intel.com>, <Mario.Limonciello@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Mastan.Katragadda@amd.com>, <Arungopal.kondaveeti@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH V3 7/8] soundwire: amd: handle SoundWire wake enable interrupt
Date:   Mon, 20 Feb 2023 15:34:17 +0530
Message-ID: <20230220100418.76754-8-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230220100418.76754-1-Vijendar.Mukunda@amd.com>
References: <20230220100418.76754-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E654:EE_|IA1PR12MB8587:EE_
X-MS-Office365-Filtering-Correlation-Id: d1e3855e-1271-4ab1-57fe-08db13299644
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SkXQbOC36EGyh8XPMa5yF+c5nUQ/Fj2x9wMXrTvWJ6FLFEvoXwCdvW902M7UbOvBQWtXSLKazwgSodXM1h3/exNjepJhatcDvojHZZsXiOkSBKnz6mHONYkl/pl7K7r0pRWW2zKoW5YDVj1QiAqm6aqDlfADDtLLQEgzG0bvnbktsz2KmPozciqu5OCrT6/9+M7kJ7fy4uvaJjc66VPYXhDiFVOIDcVP74yZ+BtBReFl1nmYH9STht/Rd/DCwFvUAnuPk67piV5BBb5VUTthEWGqMl4hxtLeXRg2a2FSmT3k4gbmJyeJ0qypaTeqKFwpvCZZ1q5CwoJq8MSTnV/9wW1pwkENA96NtV6yLZBlsz+jKzsTG3CUSlReadU4Z4r9L8cT4Hx626hDwOfI4x5fyYN6oKzEPPVx7DdSs8RGS8qcP1lZllEuYdY5Vx/c/VjlpwRLknDd43qbCnWX0XoPkXkJcGsdYyKyGyY0JV9F2WAw/en0GbJD1eWx91s+p7KYNHAtTijb85dpRbXuuYEPyuSiiyRzLsSLmjNZ2nSNOm8/A//O+qNesTxcs5i0P0Lczml1PC+guRQNT+qOdKNHfAVPDI26ew8BlBsC49U2ZbqGb95NEkC5Mrz2b9SpLy/17zFqRe3Dmoa5XMMUYQA0LjuarGZR/26ogsWi+J/pqdpQQvvhPOCMOrYrYNRn+z5jbWNlXv9Q1tbWkw0jQ8fX70dMPW5UP2MN2TUvWxDaJGs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(346002)(396003)(376002)(451199018)(36840700001)(46966006)(40470700004)(70206006)(47076005)(81166007)(4326008)(6666004)(82310400005)(40460700003)(26005)(1076003)(36756003)(186003)(8676002)(316002)(83380400001)(336012)(6916009)(70586007)(426003)(40480700001)(82740400003)(356005)(54906003)(36860700001)(7696005)(5660300002)(478600001)(2906002)(41300700001)(86362001)(8936002)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2023 10:02:33.7611
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e3855e-1271-4ab1-57fe-08db13299644
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E654.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8587
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
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
index 3322adeca0d8..a7182aa78652 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -932,6 +932,13 @@ static void amd_sdw_update_slave_status(u32 status_change_0to7, u32 status_chang
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
@@ -943,6 +950,9 @@ static void amd_sdw_irq_thread(struct work_struct *work)
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
index 6ec37612ae4e..86bc6d4f48bf 100644
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

