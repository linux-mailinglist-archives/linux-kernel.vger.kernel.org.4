Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE566CF630
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 00:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjC2WIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 18:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjC2WIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 18:08:23 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061c.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::61c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A9B59EA;
        Wed, 29 Mar 2023 15:08:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H95SScFr43YwYz0z75iWO/WwpsxufzjXHxWC1VWCb58ZPt7qgtyY+8OwThQSa9gBXZXWwvhV++F3pDXVGFk0X14coxX51N3yEMtJjPw0ZqofC5yP0XtyN46nqqwp7y+FmORuf5SdWQoc+Bz+Ymzkahe+1ZOrTqsI1VVwZifRyKJZUsoKPwRIErJifF9Y5k4eiTtd0gIPtzMQPTpKnp4CJeZPPS+nPPuhQ5u9ArR2suzCOka4ZVIzOkpidSRi02HqPHVPCldMOhxxK3YRhGLuT25xH2XmWq+QGUpqDCC5dM21OMPwz3mqIWYg2bHNsRxCyFyJwfFVybMxNLFgaSqDDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+HdtTlqcWh7FIQLWrBY2CuhY6pHNZaIQyhdrTIReRU=;
 b=VdK5n2qdjWqsNCgmcMDv2z59vVpPuQnGtMc2GGpyNweNQapy3NEx8TEL3lywNp86QtGFnS7tX4G0OPhxt3AcU2/cOZ54jrJ6E25JhOe2GRsRW8o748UYgD8krxZ9ZV4RPRyKgrAOy/IPIPHrT8vaTioFl0OXE9WCwEbzTIhFKM3kctaio/cKiQGKzNgk4ZKWxUG4IXYiIIgwwm57Fwa1ANI3Rx/H4qiD8aFmGZwSnJTSHiPndYTJtVR+fOOuAuqe4VZkn+jK8HF9QgE6QTWHhAhaYw3YBowei9Y21BGSWgpWFhegdbknDdvSE8K1CxlfLKDLeIpJA/LLm1gd/xLfKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=semihalf.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+HdtTlqcWh7FIQLWrBY2CuhY6pHNZaIQyhdrTIReRU=;
 b=uYC+eIg2l/pDmeFeen04LMNQsrda21OjqI/FG3PNvRNc5a91VzlUz7TGITQ78Gzhho2PXpLKhPh4UojiA0mWBsk2f5nc9ZyVx7HKzraTF2Zz+QMHhiShRmiyL0plyW/t2Zkp/b+s/tsCNE1S8d/Dt3ZAVu+ugsXYBqUAoj8puDQ=
Received: from BLAPR03CA0047.namprd03.prod.outlook.com (2603:10b6:208:32d::22)
 by PH8PR12MB7327.namprd12.prod.outlook.com (2603:10b6:510:215::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 22:08:14 +0000
Received: from BL02EPF000145BB.namprd05.prod.outlook.com
 (2603:10b6:208:32d:cafe::82) by BLAPR03CA0047.outlook.office365.com
 (2603:10b6:208:32d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Wed, 29 Mar 2023 22:08:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000145BB.mail.protection.outlook.com (10.167.241.211) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.35 via Frontend Transport; Wed, 29 Mar 2023 22:08:13 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 17:08:12 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     =?UTF-8?q?Jan=20D=C4=85bro=C5=9B?= <jsd@semihalf.com>,
        Grzegorz Bernacki <gjb@semihalf.com>,
        Mark Hasemeyer <markhas@chromium.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>
CC:     Felix Held <Felix.Held@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 4/6] crypto: ccp: Use lower 8 bytes to communicate with doorbell command register
Date:   Wed, 29 Mar 2023 17:07:50 -0500
Message-ID: <20230329220753.7741-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230329220753.7741-1-mario.limonciello@amd.com>
References: <20230329220753.7741-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145BB:EE_|PH8PR12MB7327:EE_
X-MS-Office365-Filtering-Correlation-Id: a3cb9ffd-f4c7-413f-386c-08db30a21746
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aB41bz+VDeZk6ixZA0ON8AQHvZAkKOqwBeF4UB6I8kTJ9cIdP+AhTKK95UmPNw3S8T8KiJeTW/nMTS7KuT4ZyQtPQAhqXIM62bnK7z/f6bitzIRSn0G/2LC7PQDRgEeuSuNgAEGz0MEJJGifdQ4iYqo9KjBHeRPJPadFcCxJZ4OnBnPb+aT0Pk2TsuNJ2I463SHX5YeWM44w1GRtHZV8lPM/2qkikUWa1b8Jl+E9bS6aPCsX/PcraDy/TH12f9ejDl9tQH9w0/TTcutlqTQiljMVEhxqdKqDccYxIt4JoTLdqz4/vM8bNl1nPRMRrMNsecEojyyI304McATzIO8ZbmNQRLUnwDuKCPYTqC7xwky5ALSAPpOj2LMqtdWb2oAX3iLkt9ZaPeMvDHkcxZe3bLepEqWoMqJCz+Dzz5rNsOdyz2MWFL1n00wLasvS1RT0lVAYbivT7Op8i3b29laJ8yGyBrYJN9NtLKn6xkzOhN7MMJEVx24TSmqKTOtDUzZi58MLCr5ektEGPDAofbHUYZS3HApJdyHHp4oKwHZOjUjtCjv6ZVah4Mn07cqzkRexW0yj3Tw4Mehhu1YL0FAyOxQN8A1lVo5C+hh7zdwr+K9AJTU70WdwqEgaZ344g4pGgB3Dy6wHihqj/4wskKl9fwXETBKL9i+UhMw++WEPx/KZFfx6iHBhGnI7dbVmihE2YeCd6FCIKOWW8xw8PcyLmUOUk8IQg7bv0Np0MGDcbGk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199021)(46966006)(36840700001)(40470700004)(6666004)(7696005)(26005)(1076003)(478600001)(110136005)(316002)(54906003)(6636002)(186003)(16526019)(36860700001)(47076005)(70586007)(336012)(70206006)(83380400001)(8676002)(2616005)(4326008)(41300700001)(8936002)(81166007)(426003)(356005)(5660300002)(2906002)(44832011)(40460700003)(82740400003)(86362001)(40480700001)(82310400005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 22:08:13.5901
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3cb9ffd-f4c7-413f-386c-08db30a21746
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145BB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7327
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike other command registers used by the PSP, only the lower 8 bytes are
used for communication for both command and status of the command.

Suggested-by: Mark Hasemeyer <markhas@chromium.org>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v6->v7:
 * New patch
---
 drivers/crypto/ccp/platform-access.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/ccp/platform-access.c b/drivers/crypto/ccp/platform-access.c
index 48f59ae91692..939c924fc383 100644
--- a/drivers/crypto/ccp/platform-access.c
+++ b/drivers/crypto/ccp/platform-access.c
@@ -19,6 +19,7 @@
 #include "platform-access.h"
 
 #define PSP_CMD_TIMEOUT_US	(500 * USEC_PER_MSEC)
+#define DOORBELL_CMDRESP_STS	GENMASK(7, 0)
 
 /* Recovery field should be equal 0 to start sending commands */
 static int check_recovery(u32 __iomem *cmd)
@@ -154,7 +155,7 @@ int psp_ring_platform_doorbell(int msg, u32 *result)
 		goto unlock;
 	}
 
-	iowrite32(FIELD_PREP(PSP_DRBL_MSG, msg), cmd);
+	iowrite32(FIELD_PREP(DOORBELL_CMDRESP_STS, msg), cmd);
 	iowrite32(PSP_DRBL_RING, button);
 
 	if (wait_cmd(cmd)) {
@@ -162,7 +163,7 @@ int psp_ring_platform_doorbell(int msg, u32 *result)
 		goto unlock;
 	}
 
-	val = FIELD_GET(PSP_CMDRESP_STS, ioread32(cmd));
+	val = FIELD_GET(DOORBELL_CMDRESP_STS, ioread32(cmd));
 	if (val) {
 		if (result)
 			*result = val;
-- 
2.34.1

