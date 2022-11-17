Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546B862E8F7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 23:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240680AbiKQW6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 17:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234959AbiKQW6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 17:58:47 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73444E09A;
        Thu, 17 Nov 2022 14:58:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ik5V3btbzYIMxNYi9/Q+pnWIhAJa+UusVPLKHv3bnL+DY7QBEsMbd55ywcuFsOxxEBgplXpixqg0aAs6NP00W0CRbm0mGySkP7twsKz67b2yipc+LcTpatFTnRS0BXMAaDdgedzhYd5hVRRo70XlJgOBP3qhgaOlZ7krr1X4n24UaLaV5Ge1bx6yfHigVZuFle3Hw0BK01xSJSTcliGfyVm1fH406jeU+Ucw5Zz1c2qXePpMDbJUmTiXfKlWTB+f5f2IeIe9biHiq807VKvdABK3DM6eQnbElzd4Nq59I7T5WqJV0pXFAcP2vGgMyVIhc33Lahr+exuMrRl0FV9q1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Cn+SZ0pQkRRHNig5rZRmIcZCeUdeodXgn9qZED4OZs=;
 b=ifVMq2JRSfdGObWS5D8wKkT7lWg+TeH8vV79uPwd2b99ORwQYMuIrFp0JbFSkre4xEQCVdCu74BbjzjN1ojRMTTRlQvWE0ike1amRrL1FmDD+EGrBOdun15fvsOncBRj/U5N1EBoZxbeI4oo/LGDeohM+MPCpFQgKpKKFvOg4ER5HNXqSydmy40uFZPRZwE2COu5ZxQnn5OOKFqJK8GZEIOzyRW+UF+O41xepUQRWFw1QSfWVRm4B6VweW7tpFSR8HzLrSN4bLSRK6/KbbHVb5fN51id4WZAz6W2XhAp5W+93BFcVy7yyBhrWhoWoUKSgoBtDgYaSDH51t25zV3Rlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Cn+SZ0pQkRRHNig5rZRmIcZCeUdeodXgn9qZED4OZs=;
 b=sNQ7cLkfJOGHVLlxjj3h5BQAz8wX+MgU2FfyZQGqKhK7SKrPN4HCHEc1mzW+rVVyIeK0bai8Se32OPFw0kZbzbLCtZxwa9exmt4jv/0/YfeCpZzdPvHH77iON6sC2LU8kQhZ8XW1Qs+UOT71LkjE0ja4fN6H2W5K+wreDd5YXhs=
Received: from MW4PR04CA0080.namprd04.prod.outlook.com (2603:10b6:303:6b::25)
 by PH7PR12MB5687.namprd12.prod.outlook.com (2603:10b6:510:13e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Thu, 17 Nov
 2022 22:58:27 +0000
Received: from CO1NAM11FT083.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::dc) by MW4PR04CA0080.outlook.office365.com
 (2603:10b6:303:6b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20 via Frontend
 Transport; Thu, 17 Nov 2022 22:58:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT083.mail.protection.outlook.com (10.13.174.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Thu, 17 Nov 2022 22:58:27 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 17 Nov
 2022 16:58:25 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
CC:     Sven van Ashbrook <svenva@chromium.org>,
        Raul Rangel <rrangel@chromium.org>, <linux-pm@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        Rajat Jain <rajatja@google.com>,
        David E Box <david.e.box@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Mark Gross <markgross@kernel.org>
Subject: [RFC v4 2/5] platform/x86/amd: pmc: Report duration of time in deepest hw state
Date:   Thu, 17 Nov 2022 16:58:18 -0600
Message-ID: <20221117225822.16154-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221117225822.16154-1-mario.limonciello@amd.com>
References: <20221117225822.16154-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT083:EE_|PH7PR12MB5687:EE_
X-MS-Office365-Filtering-Correlation-Id: b25f84a3-17b0-48d2-81e8-08dac8ef3d1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IuDltS+EzcYsEvzJ8c1ERWk6y8Rs3mJTjf24IqgG1AW3oFtJW3mrLbsgr7MXd/E93cEPC4DAOhFCRuEIsu/WwtbYSihjQCpS8szzMDSZJtUfEThqztJk0k8GMJRHyWLo+9er64Jc6ImUWGB3hGpImWoRFgR+ZgyDRLA31ekM40tHuENHN2JE1JgxkX4ycL/uDMvW0Uo+CX4o6PaB9zP4GggIVYPNAAGzzDICuJ0WIepWBfFvnb9CQCh+x0YDqlKzJIwCWvR+w4u3uxBzyzdx6rhczOmsKhhvHNkH6irR1/68ZB1PAfaZq4hnT3KYwMFyR1kYBWAm7y0w7BfwPCiEoG8fFix23tya42UBCW30DmpEQkVgk8L/s3WlORpp4+pD0LToJzDXAat8bG5AsVSByxb077PQKMOBYvh67bjd3/QzjPoTEGkwC8Di2P9VM5sw52YTqhwNBa2/4u50+vhibDfAcU0cUGyKIbeVQjXI4rWyrJYDnVrrn2c02qip9RRjuzwqijzan169d99qoWwZ67jxPCAkDnXLFVGy2p1lIyE7C1e/638p8bGrLEcoxzLFXtfObW4FVbKt+bRqRl15SeIN36kCz6nc7LQ9vL+KCNWsTtiy7dJSPY+YIFfSTh10gOysvERFHlGxi6ltWWsEYSDtvjBaLPbiTExtO1D21Qet5Ky44BBmYJrZVO7vCR9I7Ao54yr85TJ92GmTNmkmCwcVHqNzOvmjMM+WbzYy/Wo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199015)(46966006)(40470700004)(36840700001)(47076005)(336012)(426003)(1076003)(16526019)(186003)(2616005)(36756003)(86362001)(6636002)(110136005)(40460700003)(316002)(54906003)(356005)(478600001)(82740400003)(81166007)(40480700001)(82310400005)(36860700001)(7416002)(6666004)(26005)(83380400001)(7696005)(41300700001)(8936002)(5660300002)(70586007)(44832011)(8676002)(70206006)(4326008)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 22:58:27.2867
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b25f84a3-17b0-48d2-81e8-08dac8ef3d1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT083.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5687
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

amd_pmc displays a warning when a suspend didn't get to the deepest
state and a dynamic debugging message with the duration if it did.

Rather than logging to dynamic debugging the duration spent in the
deepest state, report this to the kernel for usage in displaying
to an end user.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
RFC v4:
 * Report time to kernel again, letting kernel calculate percentage
---
 drivers/platform/x86/amd/pmc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/amd/pmc.c b/drivers/platform/x86/amd/pmc.c
index 96e790e639a2..2e3d8ff5659e 100644
--- a/drivers/platform/x86/amd/pmc.c
+++ b/drivers/platform/x86/amd/pmc.c
@@ -363,9 +363,8 @@ static void amd_pmc_validate_deepest(struct amd_pmc_dev *pdev)
 
 	if (!table.s0i3_last_entry_status)
 		dev_warn(pdev->dev, "Last suspend didn't reach deepest state\n");
-	else
-		dev_dbg(pdev->dev, "Last suspend in deepest state for %lluus\n",
-			 table.timein_s0i3_lastcapture);
+	pm_set_hw_sleep_time(table.s0i3_last_entry_status ?
+			     table.timein_s0i3_lastcapture : 0);
 }
 #endif
 
-- 
2.34.1

