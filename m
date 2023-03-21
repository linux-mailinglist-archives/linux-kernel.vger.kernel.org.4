Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18BF86C3CA8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 22:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjCUV2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 17:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjCUV2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 17:28:38 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7255419685;
        Tue, 21 Mar 2023 14:28:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOdbV/cYGl7qa2Qe15S4i/AzTcQz8xoSEtbT1vs3KR2oFU9ZU1DnUUvcfanjCJdwd5N9dWlvau+jki5iwLuEiUI+Rmd4EATZwSo+o8mnb3HWUY/9v9FdxzFd+NPiLUiOwEkhgJgxjUZ2CDRJFqvudkbT2bN0bMkoTKplSSdj2LGqwWBBjj4VFdRHo74xBrkisz2xzDgumXxCm8mUo90fajbmVkGP1f9ml95OzJWaRSYq0YKM3PJPJZd8xly6zmaJVm9iYTYmx4BU0iunFflGRXUyY/IljxX7864UyIYBa/NLqHvDB5VKJb/yunmM42yCjVDfsv52ACEt0FmbA8eXaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sCigtSDtZohjkmbdS3ZrmX7ohprOND7zAuWWtRdSoa4=;
 b=WPee5tg7eG4cSJMWQw51BfiCczqt1gA5RaEnzwETipWFQqd8cOgEZJ02t4W7zkc3qKVlrKH37KpefJjwTHsh+HZ2ARp09lpn4wCBhmHNwBbmtkB8hxJN8YZRBCXC1kwcuiogium2izSGvTfGzV21d/RSUInnfLiTT+EURnbp4DE1YiQyds/JUP9cOMuOFs3EZfbhRdjHRoG/DE4UK4mF5/50+vl6N8IcmIq+OZM+/3TsfNuSuiL0P70j4arVUDu7bdcJNTeH/znWWpV8KHcYUUf/w8y4vj+5C7Bg56G/1yWcLUanT+osju+Gg8FPt9GRQ2Vu9dtb4wd3NGVeTkPvsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=chromium.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCigtSDtZohjkmbdS3ZrmX7ohprOND7zAuWWtRdSoa4=;
 b=sotLhk0KmChq0Cb+xYunR+0DuSQqsxe6UsqSTFtHUdodHRfMiexQQsC/zi8ZQr1nq0Ok1G+SSjAn4BpWCNEhwTUnXqakyMWiY5CloE8OMRKOeRrORzZlPTKVnykpZMAr4W/ugOWk2Kw64tsEYH/Pinh13l/TM5FkGbO3MNysNRM=
Received: from BN9PR03CA0118.namprd03.prod.outlook.com (2603:10b6:408:fd::33)
 by MN0PR12MB6029.namprd12.prod.outlook.com (2603:10b6:208:3cf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 21:28:34 +0000
Received: from BL02EPF00010207.namprd05.prod.outlook.com
 (2603:10b6:408:fd:cafe::48) by BN9PR03CA0118.outlook.office365.com
 (2603:10b6:408:fd::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Tue, 21 Mar 2023 21:28:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00010207.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Tue, 21 Mar 2023 21:28:34 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Mar
 2023 16:28:33 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Mark Hasemeyer <markhas@chromium.org>,
        Grzegorz Bernacki <gjb@semihalf.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Tom Lendacky" <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>
CC:     <jsd@semihalf.com>, Held Felix <Felix.Held@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 1/3] crypto: ccp: Bump up doorbell debug messages to error
Date:   Tue, 21 Mar 2023 16:28:19 -0500
Message-ID: <20230321212822.5714-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230321212822.5714-1-mario.limonciello@amd.com>
References: <20230321212822.5714-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010207:EE_|MN0PR12MB6029:EE_
X-MS-Office365-Filtering-Correlation-Id: 103748a6-bc07-4521-1c14-08db2a5339c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qcjiw9L2YgUGNLpuugVQbBkj5lMMHknjmUETCWQc/lBSOW4deKrqc1CSr+ywoY+R0Z13z+p+frwT5IOiQEKjjUZJ9u0fawqQeh26xkH+cURLvau9842vI/qTutfOH2yZb1Q6RWhNgviDoWPD5XcPuaQ8GxQ1UFxln9NfABFkioRb2Ks7ew3iocih6Dh5Fw1UA1Zoe6Nq+YIBHKzhQPxW2IZOErHERE4r8qvQlZB/UF8EnKqOD1or1avAGZsKnC6X8MRVsa9Qww+Fe21bGTbIjSVw71tRI8SEwJ5uqtBkz7+5rUy/jDqMxvQMISsfAtiVyCbXg3mAsL6NS2rrEhJS9aZWzdIiNfhvLi4u4LZnYaPyOo+YBkJBLPx7RNpxI78qMZOw8A1JbSuBKkcLRVwjdqK1Jfn4kdSQeVi2gpl4IfD2IHR0quEr5V70epLdexdJKMcc3DBh193fx0SBfuIH2aiJwUS/xvn5GH1ZZnXKJpXJ6q5AfImca9ciXFMoY3RwjK15heNrlt4TWNpEY35kh6EaCMe41//EpviJD4U84oQ4Z9qRB/HqQ29dCUYMG8eMD5/NSpM22UKza74GoWUlmNzGD3H/mZAaNvqaJQlowKzMUl2jh5rjjhPm3qnx6PEy+TRKJvEPGLyS8cPZQYySa2WuDSRhfPHWbB/TqBIkgZckAJ+YnC/gUZXt2EQ+cUye2VT5jc6jkg0mCQ58+LFU28ZmTCTcBC5WVGIFDbi1FdM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199018)(40470700004)(46966006)(36840700001)(7696005)(40480700001)(6666004)(44832011)(336012)(41300700001)(8936002)(47076005)(36860700001)(5660300002)(40460700003)(426003)(2906002)(16526019)(186003)(82310400005)(82740400003)(356005)(81166007)(6636002)(110136005)(316002)(478600001)(2616005)(1076003)(54906003)(4326008)(26005)(86362001)(36756003)(83380400001)(70206006)(70586007)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 21:28:34.2656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 103748a6-bc07-4521-1c14-08db2a5339c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6029
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
 drivers/crypto/ccp/platform-access.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/ccp/platform-access.c b/drivers/crypto/ccp/platform-access.c
index b51fb1196932..b9f94e1aeb78 100644
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
@@ -184,6 +184,7 @@ int psp_ring_platform_doorbell(int msg)
 
 	val = FIELD_GET(PSP_CMDRESP_STS, ioread32(cmd));
 	if (val) {
+		dev_err(psp->dev, "doorbell response invalid: 0x%x\n", val);
 		ret = -EIO;
 		goto unlock;
 	}
-- 
2.34.1

