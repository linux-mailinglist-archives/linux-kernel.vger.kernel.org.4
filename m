Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10F673BE68
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 20:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbjFWSbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 14:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbjFWSbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 14:31:43 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8050B2721;
        Fri, 23 Jun 2023 11:31:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=chTgOQZ+2qxZFvgcAzJh627/knNR9QSdgNUvFfk1fg1CP+VhK1XympQbCpbhbYMp8xYASCAAmfs4oIth8s2cATiIfuxJb/Hj5GSEeGGxhNgxAQ07MmRK8ONwbOGYrJhCGOOOqu2irNuBzndxMDl1+SiZo9NEcLCkFhOQ7yEaFz8GdnqZoEDbsBd99H7VCn0o0YqL//cxG3nYjY983ivIKXQIg8CEOoswDpotCfC6Z5bM3yDkuwXJhrXJ3/E8X8O7TjxKkjGUZHoeZJXuo47+/05gV4ts0LKRQ3zuzyhS/gRsmR3e64YZJ4DqJK4WDPFnm24ezyas7tn8e7KNfgn10A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NyXvkhFZE6b8we/dZ3sslnP6SIqpIRE+gYH9JUOn+/0=;
 b=H2fQ3/zfBgn9i0FVhLMSzSAAO7lf7B4QjBwC453IyGB+jLWQyP8lMPcJvAbooiAdYeksgn/Ilv8gj+SssTHmthHQTSeP49REoLFym1bXeESGnfkFurlsf9Pnw4QS8KPSSYF4OFtyl0PM1Ky4+k6qB/Bw/sBPKXwwwAe0HdRNNEo52HwkH9OJXhu25eyRQ+aW0NNshpure9scjgrG+1yD19XL/RhaLyAAdTIv0WEnm5y4qZF41eLIioHj+gK5yhnx/9gGfVxdyzlAYs4p6nAo3y+dDfidW3EmzO4/RbE1AT5YRo/m7Ge7OUphEXYbUGrGVfUtqL05HhK7aaseUWW0BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NyXvkhFZE6b8we/dZ3sslnP6SIqpIRE+gYH9JUOn+/0=;
 b=PVqURThiUWp66CnibjwcFitt8SNR6gDzV5PkTnQK3KSdYQK09E2OGOGXvSbKV1CrImej6HtvDjym9QExr9YNUfVpTAWDnbrkJGnPz0l5yBrRlltM9t71sVSyyrwclnP9cMIWdCu+bH4ccjQQMn6O/t1D2kMPEjT3uKTtW0lnmYI=
Received: from BL1P221CA0029.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::25)
 by DM4PR12MB5964.namprd12.prod.outlook.com (2603:10b6:8:6b::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.24; Fri, 23 Jun 2023 18:31:37 +0000
Received: from BL02EPF000145B8.namprd05.prod.outlook.com
 (2603:10b6:208:2c5:cafe::cb) by BL1P221CA0029.outlook.office365.com
 (2603:10b6:208:2c5::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26 via Frontend
 Transport; Fri, 23 Jun 2023 18:31:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000145B8.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Fri, 23 Jun 2023 18:31:37 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 23 Jun
 2023 13:31:34 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC:     "David S . Miller" <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v5 04/11] crypto: ccp: move setting PSP master to earlier in the init
Date:   Fri, 23 Jun 2023 08:49:54 -0500
Message-ID: <20230623135001.18672-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623135001.18672-1-mario.limonciello@amd.com>
References: <20230623135001.18672-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145B8:EE_|DM4PR12MB5964:EE_
X-MS-Office365-Filtering-Correlation-Id: e2c146f3-7add-4c2c-5441-08db7418144f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ofWl9LfbaLGgOo/mBYQ8BvYOtIcaPtD6bHrUdvyAI+8N3NVEtLo3zuXCt+hNpJL2JyZSpbv3HQt1xhMHUETN+9+CximqfrckLQlxUswuxAY9+oGGxnwlNwisaxWjR/XbjNY4EQa759nJXpkFX/7jgNdAfZ+HSv0sOSJ0tjY32whIlIO2dn+V9Rq9boj3/DmOkpn0Bsb4Xkq4RjiDqXa5xFZ1zmouzdlnn9T30E/qk/ITCpxOltzNVPS1oPjAwsC0AB5IGjFEmXqg7wVmmmWFDzEqSPv+mJBB3PWG7c4ZX6JJIW95rLVj47Ex+tvXr6At081Q1VvS7ADulDOJafUq7dV7XwLFtfvLqyR582czEveZvFOUSOBCYXFYc3QLH0jVxPukXAQ5qtlmipOaU4jWBbgrAmnTzWHnVpgMSVSN8l9CIotkSZx3i684KW0ApJ3W8L5tOymrLsUnz40G1mvUf40YmPhCMDos3TFwKpmsK7es5Bnf5IwoN/zQwoOFJI6UQHJACYb8zCqr74iGQjLwb6mX7CORUapLjAAFBtrMCIM0l8ScJ8L2+jGuGfUpV0F4NQRbwShvi3cWHKEbQ+6fzIaasz89mikwjia65Qm2KYoXUi1pbNruB3v6ILNDDo2G8fi9guUFcDY52xr6Y0ZE7DlxO6yItB288JyDw1bYebwWBZUUvFrd53Vot2ryp1JmewZFtuVF1OC8zrO3/OljzsBuUqclMqES/R+xOwb7WtjMlKQPGXDTDYSY3ueH4xaKpYvg/R7FGjPfiyJbYzsGzA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199021)(46966006)(40470700004)(36840700001)(82310400005)(40460700003)(40480700001)(86362001)(41300700001)(8936002)(70586007)(336012)(70206006)(44832011)(316002)(2616005)(478600001)(47076005)(83380400001)(7696005)(426003)(1076003)(5660300002)(4326008)(186003)(16526019)(26005)(54906003)(110136005)(82740400003)(356005)(81166007)(36860700001)(6666004)(36756003)(2906002)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 18:31:37.1368
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c146f3-7add-4c2c-5441-08db7418144f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145B8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5964
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dynamic boost control needs to use platform access symbols
that look for the PSP master as part of initialization.

So move the PSP master before psp_init() so that dynamic boost
control can be initialized properly.

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v4->v5:
 * Pick up tag
v3->v4:
 * Pick up tag
v2->v3:
 * Clean up master device if psp_init() failed
---
 drivers/crypto/ccp/psp-dev.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/ccp/psp-dev.c b/drivers/crypto/ccp/psp-dev.c
index e3d6955d32655..3390f0bd64085 100644
--- a/drivers/crypto/ccp/psp-dev.c
+++ b/drivers/crypto/ccp/psp-dev.c
@@ -173,13 +173,14 @@ int psp_dev_init(struct sp_device *sp)
 		goto e_err;
 	}
 
+	/* master device must be set for platform access */
+	if (psp->sp->set_psp_master_device)
+		psp->sp->set_psp_master_device(psp->sp);
+
 	ret = psp_init(psp);
 	if (ret)
 		goto e_irq;
 
-	if (sp->set_psp_master_device)
-		sp->set_psp_master_device(sp);
-
 	/* Enable interrupt */
 	iowrite32(-1, psp->io_regs + psp->vdata->inten_reg);
 
@@ -188,6 +189,9 @@ int psp_dev_init(struct sp_device *sp)
 	return 0;
 
 e_irq:
+	if (sp->clear_psp_master_device)
+		sp->clear_psp_master_device(sp);
+
 	sp_free_psp_irq(psp->sp, psp);
 e_err:
 	sp->psp_data = NULL;
-- 
2.34.1

