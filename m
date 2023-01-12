Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC88666B7B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 08:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236560AbjALHQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 02:16:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236553AbjALHPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 02:15:53 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB954C714;
        Wed, 11 Jan 2023 23:15:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EEV2RbdHidELsDmp9mEEeZAB+4id2Ch/kZNSYz1SgdDMgFg0icGEloRQUODYahFsMc7j5jRWF9hvNfA5Wy7IQqU2QGhPosjvCFlNihYEAcl6S9zHBlTkD4vTUSOvwqXACA9M3BkcOjskmLs8Bxx7ekiPH+F9Hd9Q91B7Oj1/sXw+jyZbZBhd8+IC9rcj8XofNpK11bb701dZPhxLc1kUl7l/XvofBxwBDJlnYGwlDlQX9XzO5yHe+Hv89NFSKh7GC0GFxyigsQ41uzdk3rPbXcx3S0s+1rLXcV4hDgJhuygPu6Dc7SD/xDjSZvkxn16bWvZxFxNbOnpGANoeS/qfwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0qXGrWfgIUpSg+rp2AMYXEFb2uGOOImgPieQPBLjMio=;
 b=HR0L1lU5NI9jiXP1v/3TAc2P//Yajcz/jBUp7GqFkM2C1O859Oqr/CQmBqFlNVnuG5x9o/0tCpMVndgV/5lNHhXBDJZQUknQhA5Td0et61vWXDCI6lTytkWULIz/zd++RaN3WIkoqav8vA0D4SqgxBFPIda3UKJ0U3HtY6OMNHIQnbBr+deVM72AkPHK7sKD4+gteJemzSja+k/kdoOolCo1nLJBviuaEPw4PZW80o1q99vTCChHOh6XbBeH37YgavKw5/G1W0iG2uFmNmuBSA8qipJEuNnAebtnGcYr1IOgi7Q6ypNPGp6U0vaIO380l7Sr01uwH0k4BvVmbXaviA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qXGrWfgIUpSg+rp2AMYXEFb2uGOOImgPieQPBLjMio=;
 b=BBrE9MGpGxNFXdq+EGkRRpHvCYYo2u9PyVUcTF/EMBF8S7jkFi+Hqg4U370gXQ0rDCUogEE1FSV7xwXGNJPBagsUSH5ckvgq9GXuwTqyO1Emr1Qxv2Xdcs5dGhg5qTFqYi9xt2mz/8Zq88TVU7g6Duzl13KmBgnJ81A4biJPz9U=
Received: from MW4PR04CA0312.namprd04.prod.outlook.com (2603:10b6:303:82::17)
 by CY8PR12MB7586.namprd12.prod.outlook.com (2603:10b6:930:99::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 12 Jan
 2023 07:15:49 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::e3) by MW4PR04CA0312.outlook.office365.com
 (2603:10b6:303:82::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13 via Frontend
 Transport; Thu, 12 Jan 2023 07:15:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Thu, 12 Jan 2023 07:15:48 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 12 Jan
 2023 01:15:47 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 12 Jan
 2023 01:15:47 -0600
Received: from xhdmubinusm40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 12 Jan 2023 01:15:43 -0600
From:   Mubin Sayyed <mubin.sayyed@amd.com>
To:     <robh+dt@kernel.org>, <treding@nvidia.com>,
        <u.kleine-koenig@pengutronix.de>, <linux-pwm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <git@amd.com>,
        <michal.simek@amd.com>, <siva.durga.prasad.paladugu@amd.com>,
        <mubin10@gmail.com>, Mubin Sayyed <mubin.sayyed@amd.com>
Subject: [LINUX PATCH 1/3] clocksource: timer-cadence-ttc: Do not probe TTC device configured as PWM
Date:   Thu, 12 Jan 2023 12:45:24 +0530
Message-ID: <20230112071526.3035949-2-mubin.sayyed@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230112071526.3035949-1-mubin.sayyed@amd.com>
References: <20230112071526.3035949-1-mubin.sayyed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT034:EE_|CY8PR12MB7586:EE_
X-MS-Office365-Filtering-Correlation-Id: e6d88814-02ec-4da6-dbbc-08daf46cd4e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tJXdz3OMk3SiI1AHcNUX83RQwaWlm/6kDLvIjhShbKmUKOEfE2/OV/oiFl9cp+YQBNKgOmcbXWGcY8qtVqtw6Tfc/HY2At7UoKNGQbJzBICowz045GEwdzx8jgkrKg9Alm+D68lzmOtO/Bw/srx42izGeDUUf9OKdg417Mhre74qwRI5u/4GT8JXIzZup1d1ysde4USkNmtfY9tvAdh7X70PmPMwFxqiThbWs+9QoMYm4D3d8EsaEBJliot57umGMYR+dOSxNPCtpE1S5NUnVC+BXNA4VZ8X8rP9FdGGT8ZP1AUcqTrRM2x1jHnCP0QenJgOw5F09QONZoBCsHewmIGmoGncStwI+jC1IgGzOoFCC/v8LVb14NuWArgXMUh8rHKNiNRY5cA3+fLrekkCMhTrJrb21O9NekFbEMZ2sVF4YaAjT+NdTiQumJ6gY6J720S/m1YGD9bIOSdcXi5RfdF8/ZJz6gkXir3exwHM3IP57zEE/9dW/wF6k8VzlPOz0anR/cNBaB8h6A5aiBD2+e/36a02E05mSCOBwG1h0Dc42UitTh07nsWYtStCT1HxnOQ9NAuD3yQo+LZbWU+Hmaz+GpxBg38RUpm1GB6ODTbmezEsvTBgVF5WNswUeYtaFctqcai0nkmW/a8FAKwAAvx6uJxCHRU59lriqGsfnmlAKI3HB4D0c1j7GEScZsuIPbQv3nxm6CwNEUWGH6g2+FJ/pZGLmKwZA127vXuflQg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(376002)(346002)(451199015)(46966006)(40470700004)(36840700001)(356005)(82740400003)(81166007)(8676002)(54906003)(36860700001)(86362001)(40460700003)(83380400001)(4326008)(110136005)(41300700001)(70206006)(70586007)(5660300002)(426003)(44832011)(316002)(8936002)(4744005)(2906002)(82310400005)(2616005)(40480700001)(336012)(1076003)(26005)(478600001)(186003)(6666004)(47076005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 07:15:48.9910
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6d88814-02ec-4da6-dbbc-08daf46cd4e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7586
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TTC device can act either as clocksource/clockevent or
PWM generator, it would be decided by pwm-cells property.
TTC PWM feature would be supported through separate driver
based on PWM framework.

If pwm-cells property is present in TTC node, it would be
treated as PWM device, and clocksource driver should just
skip it.

Signed-off-by: Mubin Sayyed <mubin.sayyed@amd.com>
---
 drivers/clocksource/timer-cadence-ttc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clocksource/timer-cadence-ttc.c b/drivers/clocksource/timer-cadence-ttc.c
index 4efd0cf3b602..ba46649148b1 100644
--- a/drivers/clocksource/timer-cadence-ttc.c
+++ b/drivers/clocksource/timer-cadence-ttc.c
@@ -476,6 +476,9 @@ static int __init ttc_timer_probe(struct platform_device *pdev)
 	u32 timer_width = 16;
 	struct device_node *timer = pdev->dev.of_node;
 
+	if (of_property_read_bool(timer, "#pwm-cells"))
+		return -ENODEV;
+
 	if (initialized)
 		return 0;
 
-- 
2.25.1

