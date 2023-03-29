Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432C46CF62B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 00:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjC2WIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 18:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjC2WIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 18:08:15 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768E35261;
        Wed, 29 Mar 2023 15:08:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KkuBJ4a8doPMnN9eowtGUeGNEDv5el/994JnKzM2dl7+9kYN9M02PRerlc/yxHSB2dCzpPbEwywujDg5wx1hiq9SxZ29ofXFIUOlFPT0Kj/nvlQPuAAMg+Nni9R45LaHnkN7A/ZeHo7qOK++vfXUs3EwgIQEkT5ANQ9WK+VhnTQCtwlhXpfC3arOZchJTj+CU9ZhID2nblsWpXh6Dx+KLABCo7LniboKb1FG4wsZm1I5r4iwjN+xK6wUxbmJBv3k4+na3z4WwalKiLvJVHZM+BIkdMc9kx1y/a1CzO3HYIO6j5tcxBivGvwuHJv8BLZymhKECkLT24bIjtaQhMISAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79c986qYawMONEy/n+79MJWvRvPZsX/YX6MoywBH1Nw=;
 b=bMpvnhWW5W3a9t+7fy9UVwkqRofIOlLhZRKNVpx8MDMC2a9VLOBFn8uLtsK/vhpumvnxSYBU1C3ufhbejMgfHK9QJ8yG9lgp4Nvs5mwLBZRubd8h5msjGdYhxMZFNFKFGh6vubiPx3DImla7IUP0JzHIMIFRgsrYemrVzhuGcXWSay4nVYv651bAus0sAYzteaaftvxWNi83aYY84b+lTVib0xX7fmiLlW82rRC8qlEDnFtl7BO5ev0y+WTAGmc7jMWit8ClhBQLMoNmkjmE3AAu2+RSP0ow5MOWmxOfNOoTN+n6/gu1zRKD/bDUgvUPsc6TleU6057oMEQHWv/g3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=semihalf.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79c986qYawMONEy/n+79MJWvRvPZsX/YX6MoywBH1Nw=;
 b=ICaJFK0ZOALVWfYtpLBjBYmK8/IUSU8ufBsbJ4MtBQFjbpLD87JV8aEpGQkEQSbTC/KK4gjWXggVY/lSAh+aOTfqS48KRovEfuZGMxPLc3Rp/51tAzFTszz00J3rOhaRqYHq0ir9DhZyHWb/JcJaoaIIPXTCpK/H9ON5+hyLaxI=
Received: from BL0PR05CA0029.namprd05.prod.outlook.com (2603:10b6:208:91::39)
 by MW6PR12MB8957.namprd12.prod.outlook.com (2603:10b6:303:23a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Wed, 29 Mar
 2023 22:08:10 +0000
Received: from BL02EPF000145B8.namprd05.prod.outlook.com
 (2603:10b6:208:91:cafe::88) by BL0PR05CA0029.outlook.office365.com
 (2603:10b6:208:91::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 22:08:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000145B8.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.35 via Frontend Transport; Wed, 29 Mar 2023 22:08:10 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 17:08:08 -0500
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
Subject: [PATCH v7 2/6] crypto: ccp: Bump up doorbell debug message to error
Date:   Wed, 29 Mar 2023 17:07:48 -0500
Message-ID: <20230329220753.7741-3-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF000145B8:EE_|MW6PR12MB8957:EE_
X-MS-Office365-Filtering-Correlation-Id: 56ede810-57d7-47c4-579f-08db30a2154a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gsgqF/6JzC0u05+eDDpZTBbjKZYHhuDBGo5iXZQtksL5m4CAixltT8WW6ZBL/2A6JmtjUtEFliqToYrUwsVK14nK4nI8W9hh7XaI9nVF2dYhuUd73e5rl2u5rqIMyw0r7SiD+pAXvqWu80uZ0CO8rlG9SSnziBcdG0cT1xeELTVn/khlny+XWzBAY4RnLaUN8pO8FdTCpFb1m+9eduDvV8CXedTyROw5m8LLBmY0KVbAGu6BD/aOlSY8C7bH44pPSbeFKpcImVhZVIWvjik8ajDU3MjBJZ6xfc10Nb79r3+myWUSKyyI5ZZYsbcVaivAYcsrGQb/ua+OU7P9fPW2XY4OpRXqLz4W6jVjzzAD5yqlvWhn/GwnJkdAhRQvnOqKpVCJHZSVmeBPOmZ2/8XFtmECXX4+lkf0IFVPAydfKe4TOm/eOmhbKfTkmQfRds4xKwHz71OtISRmgdV/2S+foBeOJjA7pxi2m/T6MU5xjUHGpfBmC+DBkhWdPlfJcpEo1ue5aEj3lzeq+DSoxZf/UUf+H5suslItYKeBsO73IaBNen9Nk06A5XgwTTarHAROHO2+Fd47W+HgNQUUekXuwmzwRMmHnxT/Af2SBP6E+qLb8ruWIH27jB+3MvddgntKWK3omuE7yn+XQKaeM8LSSHQuDzWsohgdbk/RyGmdbhh1xwc+0Irn3vYEeiiZOSuZJAGy5MTuleQQ3crgISaRt9sXWFlUGeKU5f6pCdsix40=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199021)(36840700001)(46966006)(40470700004)(83380400001)(81166007)(6666004)(26005)(356005)(1076003)(478600001)(7696005)(54906003)(316002)(110136005)(6636002)(8676002)(70206006)(70586007)(82740400003)(4326008)(36756003)(40480700001)(41300700001)(86362001)(82310400005)(36860700001)(4744005)(2616005)(5660300002)(47076005)(336012)(2906002)(44832011)(8936002)(40460700003)(426003)(16526019)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 22:08:10.2773
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ede810-57d7-47c4-579f-08db30a2154a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145B8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8957
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is helpful not just for debugging problems, but also for investigating
captured logs later on.

Suggested-by: Grzegorz Bernacki <gjb@semihalf.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/crypto/ccp/platform-access.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/ccp/platform-access.c b/drivers/crypto/ccp/platform-access.c
index 1ad3a0a512b1..1cc154a1c6ab 100644
--- a/drivers/crypto/ccp/platform-access.c
+++ b/drivers/crypto/ccp/platform-access.c
@@ -149,7 +149,7 @@ int psp_ring_platform_doorbell(int msg)
 	mutex_lock(&pa_dev->doorbell_mutex);
 
 	if (wait_cmd(cmd)) {
-		dev_dbg(psp->dev, "doorbell command not done processing\n");
+		dev_err(psp->dev, "doorbell command not done processing\n");
 		ret = -EBUSY;
 		goto unlock;
 	}
-- 
2.34.1

