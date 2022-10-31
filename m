Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F71613F2C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 21:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiJaUnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 16:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiJaUnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 16:43:39 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B272213CFA;
        Mon, 31 Oct 2022 13:43:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TIvat2APr8i17l5KMr/KsLwZqbWoteXztSa19pLkAmqE6g50+1Lf/Hqd47iw1mv13Ig4JTqbSZBBvEmge/mBbpm5eCB8QS3lzWVPxxjtWijcrs5aTBHOEX3N+WMMxm+hd1/tPUV+TdJkRgQkgv1mJOgfpRfhavFWJq8NgyYhnxhbX+NgRXffluLJfTJDvhCh+x/SekDcKixcYI3hQvnXCP9l1nho86SwALYcHB2O9NUsZ/LLsTkookdvEU7+kjnA2AaPBbb9ke1cVW6yAoVBV02nAhvrTw944fDJeSYWGr8u4qW+ufApYCUUU5SKU4zWQh09Mo1tZJciJ9ptpkA0TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8/CVtqFX12Xvux/sBSLE+MDq3anM+uG3XD6fHopQIg=;
 b=Z/M5c5x4Jn9++hJraL/wxrKFiJvGE1+1+EFUYmu4KHKs+Yd5agFhYtdlHaX7Ix0Ieg0/LQjHyHiqEf6IER+SvdLoFy4XcgQ7e1AhnErHmZmvFVmjc/TFAK6wY+ZMi9Cw9TMFdjAsf8tAAKszFS5inLbfZss/jOCXe77p61AQwYF/4vz4hk6E0mTufLeXsKnPgRyTzms8SqW6NB/qEJe+7PeS49eju+s+SbtCoJn7dSoyWo9XsHW3vTU0dFiwWTW7N2FGXqy0edjV4srvmfYowujMuME94MIvukJR0F9LmNHOxd5ckMXVs1s1rb65jmonH+t7xUbxixhPh6ZoaaXUSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=chromium.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8/CVtqFX12Xvux/sBSLE+MDq3anM+uG3XD6fHopQIg=;
 b=IKfUasDHHQaj3SjPgn0TEtRq7uO0PaUkcxv8Y4uDronrOoSlu2ZqcGtEMkQwxHgmnjuQDN+ivDKLpXm2TBvWlEd4pTsTE9Z2xwK8/fonn9l2puaYlmfLqaVXxmk5LkeqFDyBUp83tzKZYCGvVKiyS03VaMHizLry2bPmXttT4rY=
Received: from MW4PR04CA0188.namprd04.prod.outlook.com (2603:10b6:303:86::13)
 by PH8PR12MB7350.namprd12.prod.outlook.com (2603:10b6:510:216::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Mon, 31 Oct
 2022 20:43:36 +0000
Received: from CO1NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::c7) by MW4PR04CA0188.outlook.office365.com
 (2603:10b6:303:86::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19 via Frontend
 Transport; Mon, 31 Oct 2022 20:43:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT097.mail.protection.outlook.com (10.13.175.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.14 via Frontend Transport; Mon, 31 Oct 2022 20:43:36 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 31 Oct
 2022 15:43:35 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Sven van Ashbrook <svenva@chromium.org>,
        Rafael J Wysocki <rafael@kernel.org>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        "David E Box" <david.e.box@intel.com>
CC:     S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        <rrangel@chromium.org>, <platform-driver-x86@vger.kernel.org>,
        Rajat Jain <rajatja@google.com>,
        "Hans de Goede" <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Mark Gross <markgross@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC 3/3] platform/x86/intel/pmc: core: Report duration of time in deepest HW state
Date:   Mon, 31 Oct 2022 15:43:19 -0500
Message-ID: <20221031204320.22464-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221031204320.22464-1-mario.limonciello@amd.com>
References: <20221031204320.22464-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT097:EE_|PH8PR12MB7350:EE_
X-MS-Office365-Filtering-Correlation-Id: 73edcbcd-38a3-4a0c-61a1-08dabb809588
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 58D0co4Mua9/Nh5rhr6k/gYz5FFDGRrHi7mkwsBHbpZCRO7dwbtUJZ+ZF4fZseARM7NOnFIAaaervW2NFiAkFBALND16r+jWKz5qhoF50Yczryb7Pm7Mr+XXaJB8ODpXBB2u0Ss8n8YJ+cRlZAlANu8UNIUfdRgl7rLe/1khz/0yk00M2xlJoiIvwwQ/hMCyju15J6Lud8ZC7AyMHagExFk7oZR8/ojrCwMCPosbApzPoDqnZEhHt4oBYO0bda94cqQsH56x599GN19gSgQ4T1Fz2xaLSuoltHMLQGKcqvQbBGpTCWAeR7mEUS3ri7Ru4ILirq18ExgiaKOesycOxBKgUjB5fOc7fFQ1CrwYo6MLquRHlOJ59ErAVcmH8/mGFJNyGteAw/DBjr6eRsdEcmRiqtpBVp32N/oYta3CS/Afnyc13kGoLNkA8wlfZIHZ+H+FuUPX4yPdtW7ByBY2fl5222tmtgymMepD8Cw+Jq9LyVsrzjTvH1msW2mQrEsiZq/RbrYP8NfJ/urIBkY7cVob/qU/YRG0B4cBqvUBCQiq8tZy45Dgcs/NokJAdVRlglc1aIt6e6VluTQ6Ok9GTryAZvwGg3sof1c9Osiz2y/OpVjrTdb8KwQKObiTJMWW7Uax7hNvtSnktKqhnwD3Q1lVuRjG1itvRSdCE9uyi8sVsLN41fnTloYw0+NVNUHPhDtrsvQoMv+sYslBvajE6eQglKA5lcc74jL31nP7aL+hcKOZ67RbpaJY9+XZ8MGB+DTNDgNS2wVWOop9CXAiqtfikp+tsqcNdvO5m2NN+m9649sm52nrh0e5S6obTx3x
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199015)(36840700001)(46966006)(40470700004)(82310400005)(478600001)(82740400003)(110136005)(86362001)(54906003)(44832011)(5660300002)(7416002)(70586007)(4326008)(8676002)(83380400001)(40460700003)(6666004)(36860700001)(70206006)(186003)(426003)(8936002)(4744005)(1076003)(36756003)(316002)(16526019)(2616005)(47076005)(81166007)(2906002)(40480700001)(356005)(41300700001)(7696005)(26005)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 20:43:36.3891
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73edcbcd-38a3-4a0c-61a1-08dabb809588
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7350
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

intel_pmc_core displays a warning when a suspend didn't get to the deepest
state.

This information is generally useful to userspace as well which may use
it to collect further debugging data. Report this to the standard kernel
reporting infrastructure that can be accessed from sysfs.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/intel/pmc/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 17ec5825d13d7..9e58228b01f91 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -2116,6 +2116,8 @@ static __maybe_unused int pmc_core_resume(struct device *dev)
 	if (!pmcdev->check_counters)
 		return 0;
 
+	pm_set_hw_deepest_state(pmcdev->s0ix_counter);
+
 	if (!pmc_core_is_s0ix_failed(pmcdev))
 		return 0;
 
-- 
2.34.1

