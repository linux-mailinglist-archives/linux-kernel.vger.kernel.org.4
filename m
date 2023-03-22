Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8756C5868
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 22:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjCVVF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 17:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjCVVF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 17:05:26 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFEF4C1C;
        Wed, 22 Mar 2023 14:05:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZowVKGZ7MyBYx8KYYUowJpm2hllpA+hhcblFGZTnxDcviCvt1zZ5RX3F+EpiqIdWXaHggsLXeiLe15MydkAmy3rWeBYDXAK+ePF3aNV1+XloLfQKQK4lz76TIBVQvOD/OcAJ4sWtOeD7p6+rksolcGov2Lv9eLkj5fflSSd5jNr3uuBrmTbwtUL2UQnKReZSHn3BCoxAtryJu8D6onXjRfSaLEl/dZwTUmoMWkgPjgAdQpU1es7JmzY/d5sJjVMbi63sEvdM+OqGpPFXAOHLJjQqDgv2ZdUnubYeIG0HsyWo0dnWIG1Wd2rUdqk9m6WkczUMSTot51rSrla7UUfVJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTRbkIa7PKtrxeBtpxZIjayLz+HvNGRx+GkXVRovL0A=;
 b=TvK6ivZ4fpxnuLpcsz/wrG4IG503tzPwv8fdo7ufVYOgPtoqv6vIZ3sQ9ccwsHuU6i7IvQP5rEodU9/FejZAreYRKLdD4DtNbi2p1nBNHBVuNnrQsruS4jDnP2ftkJlR3/ARyx7jvvjp0IohW7AdwkCDzBsrpo4QGTAZ8M1pygQRLcIBCd7zWF13EIYu/k70PiQ6QyubzZ8oMpuJbYZtnE22u+QU0AwFupWD2AM0C0Dg2VpeSHC23OYjpeuWIzPeeS7JsKKJgRMQXwjJrznAkOOLVR9L+IryqZ/boKtgY0aESg8YmPYhnpq3oZKRNxirze6S9zbhuL9NtZvwh80O0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=semihalf.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTRbkIa7PKtrxeBtpxZIjayLz+HvNGRx+GkXVRovL0A=;
 b=0mprCVZlLEIl9vll/5tJcNTJIzTfjzmcvuHMiOMFqi7cPOz0A+uCdnRX795qsJG2J2FQdr6Iyy8vLNkjySoqDTejszXbN2yZ799ws7szJxzSYU5A73Re4XQnQVY5dpyl9MtiCmtAAzq/gMoTPiCpc874b50/quYwuSIKm5qv8o8=
Received: from DM5PR07CA0065.namprd07.prod.outlook.com (2603:10b6:4:ad::30) by
 SA1PR12MB8918.namprd12.prod.outlook.com (2603:10b6:806:386::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 21:05:23 +0000
Received: from DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::d5) by DM5PR07CA0065.outlook.office365.com
 (2603:10b6:4:ad::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Wed, 22 Mar 2023 21:05:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT026.mail.protection.outlook.com (10.13.172.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.17 via Frontend Transport; Wed, 22 Mar 2023 21:05:23 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 22 Mar
 2023 16:05:21 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     =?UTF-8?q?Jan=20D=C4=85bro=C5=9B?= <jsd@semihalf.com>,
        Grzegorz Bernacki <gjb@semihalf.com>,
        Mark Hasemeyer <markhas@chromium.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "John Allen" <john.allen@amd.com>
CC:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 1/4] crypto: ccp: Bump up doorbell debug messages to error
Date:   Wed, 22 Mar 2023 16:02:23 -0500
Message-ID: <20230322210227.464-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230322210227.464-1-mario.limonciello@amd.com>
References: <20230322210227.464-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT026:EE_|SA1PR12MB8918:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f88d96c-1ce4-4517-f4dd-08db2b192706
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 83qior7dlpN80RxuewXggh9iOiRAKO8p3lN0Vn/j9rd3x+dao0pKnrmvHysSMuCbTEZXs7aC+MAwjzihlCFiJ3dlxoW9JSguFp0u4bENXpfYMQdsVvV+fRIRpqIerpHxvM3iRyxNVgV5XjgU2YERfGC0DqlOXakNAqqBfbQ75hAp1+Q9vOAI8JFbHRIL/2U2HnHdR7bc/A5JNGGaOo3ropaPp2YRE6KEl10EG8/6t8V6l5lu1yf7peaCQkNCXBr01dBGRxIOiZ3ed6e7C2iKh/RDj1JPUHr2ukh14u+g4TWnScOCrFPDn853PkbH2OESAYIo9eftKHWDnN2w3arizV1JSUhkPv4WUnGWBx7Ni7MXfyQsRXONPu1YVcO3kqlgtQj0hOlIU0jhFAIeEwF5RU+VblVNjvQ0YyjEMWiQoegJmQEbEkxhXT7+C9X78XNzcrxVrpyM9750InWEaO4A9dNaS8anuP/t3i0bom/F4rB/HKJgdzVOaE/TymDYVc9uJB15Jw5c9Llo6siiPySLkPWqDlYEx/7B5NkY5S0I6Y+4lCe8nNWYUt+tNuPgGPIvDNJmkOXvrAbuSSNenO1zCuBHwnPKAs1cSctLqpCoCEcZ+23e+wgCHmkx8LaHkeEauYa9RxbS2Ec2WO89tsE3IiX8+8m3cWdlbRibQocrITkct9aBDr2TSAF0/WddJ+WRw/svuhh6iVUSkI7JgaedCNdwNjJ/DWp5I/DFAczOJCI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199018)(36840700001)(46966006)(40470700004)(8676002)(41300700001)(4326008)(40460700003)(5660300002)(44832011)(86362001)(356005)(82740400003)(36860700001)(2906002)(81166007)(7696005)(70586007)(54906003)(36756003)(40480700001)(478600001)(70206006)(83380400001)(316002)(110136005)(82310400005)(8936002)(6636002)(47076005)(186003)(26005)(2616005)(426003)(336012)(16526019)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 21:05:23.1063
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f88d96c-1ce4-4517-f4dd-08db2b192706
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8918
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 drivers/crypto/ccp/platform-access.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/ccp/platform-access.c b/drivers/crypto/ccp/platform-access.c
index b51fb1196932..3e97ce60270d 100644
--- a/drivers/crypto/ccp/platform-access.c
+++ b/drivers/crypto/ccp/platform-access.c
@@ -157,19 +157,19 @@ int psp_ring_platform_doorbell(int msg)
 	mutex_lock(&pa_dev->doorbell_mutex);
 
 	if (check_doorbell(button)) {
-		dev_dbg(psp->dev, "doorbell is not ready\n");
+		dev_err(psp->dev, "doorbell is not ready\n");
 		ret = -EBUSY;
 		goto unlock;
 	}
 
 	if (check_recovery(cmd)) {
-		dev_dbg(psp->dev, "doorbell command in recovery\n");
+		dev_err(psp->dev, "doorbell command in recovery\n");
 		ret = -EBUSY;
 		goto unlock;
 	}
 
 	if (wait_cmd(cmd)) {
-		dev_dbg(psp->dev, "doorbell command not done processing\n");
+		dev_err(psp->dev, "doorbell command not done processing\n");
 		ret = -EBUSY;
 		goto unlock;
 	}
-- 
2.34.1

