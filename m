Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5FE36B52BC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 22:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbjCJVWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 16:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbjCJVWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 16:22:35 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C6812B650;
        Fri, 10 Mar 2023 13:22:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5PqEI6X6pKIwblrHkwQJblcAk6YaCpHN8pIAXqmOp6YRYej3mN1zgCsRLdwHCLoUJnBOfpZstm/zzLsDlzqYlNCegHvX+dmiEQgwnVN7ZX0JBLHEwLuwIdnyoY8BRgYBdUBM5Cb04MbvD8GmwA+jhbvQF7O2QmaTmcZNJfYhN3zSCOsL42u6qLM2o/e0cCPxjsqGRkgLSQd7kvc34kpHNAleZB5ZkRmnzPymVbVEHjr+H/XsprOR4Kn1K/TOPQpYtq8ZR8E0bbQ3htYb7GQDP9vkJss/CivGAbx3oTpQRgwxtJqLHhL7Y9jYY1iLwrj8gn9BqWctAwcdZTSYYu2Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/aVSlunfWlm151I2bSWyLK3BJuipEXOGb9lGA5WA4oo=;
 b=cVZ8nDQsqlsv9FvKDc3RkYegmRcJnyNqIcks8XWXXFwU6eMf/pKdaxQ7Y5T4IDil/iZpLTX8Jq46HNXZPuQo4u2G1ivjt7swPH0iIC5/zsDhG9RPAbc0jRfSapiLdUywwRjdJTGrRhdWst8qYoj6ZMYOk0nU71e6LAdMcyAbyuOaW4pBaUmnjpC5z2hFqAwAzaH2AALkTP+wDHMx5Q2BsUnIcB5MLd97TPrchholMELx46CTlRM0jAvQwfMtRsNrX1X1kDBGcyf0uVRP67QenJ/nZJ+0hByxPlUbyjjjgzf7hw9kDXXB90DEnJNJaCEHr1B8z2GNV+YMYQGGvbL2gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=semihalf.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/aVSlunfWlm151I2bSWyLK3BJuipEXOGb9lGA5WA4oo=;
 b=Pv4Ee15LRHHM1Pf0mNGHhKQpiQDVAEL4yMN7ApexlqNU8k56WsnE8Cji6mKmiupsP3lbTlplxvxxkbqz12Q0+eAcbUsPp6ddjd2cevn2kIZXIuQhdipF4uhvlfDnyYASf1eAiPx81m2ieujYOElGs0iwf7XJaVbzguN+jm1sRtk=
Received: from DM6PR12CA0017.namprd12.prod.outlook.com (2603:10b6:5:1c0::30)
 by SJ2PR12MB8980.namprd12.prod.outlook.com (2603:10b6:a03:542::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 21:22:31 +0000
Received: from DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::f0) by DM6PR12CA0017.outlook.office365.com
 (2603:10b6:5:1c0::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.20 via Frontend
 Transport; Fri, 10 Mar 2023 21:22:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT070.mail.protection.outlook.com (10.13.173.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.20 via Frontend Transport; Fri, 10 Mar 2023 21:22:31 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 10 Mar
 2023 15:22:29 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     =?UTF-8?q?Jan=20D=C4=85bro=C5=9B?= <jsd@semihalf.com>,
        Grzegorz Bernacki <gjb@semihalf.com>,
        <Rijo-john.Thomas@amd.com>, <Thomas.Lendacky@amd.com>,
        <herbert@gondor.apana.org.au>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "John Allen" <john.allen@amd.com>
CC:     <Felix.Held@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 5/8] crypto: ccp: Enable platform access interface on client PSP parts
Date:   Fri, 10 Mar 2023 15:19:48 -0600
Message-ID: <20230310211954.2490-6-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230310211954.2490-1-mario.limonciello@amd.com>
References: <20230310211954.2490-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT070:EE_|SJ2PR12MB8980:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b4c491f-a4de-4bcb-64f6-08db21ad8eb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DuBnLhVDldKnAtqQaAkkarXMJYA7R/KjQncRupK4vphNl4JiRvQp1ZrUiY8LWBWD2AnlRgKix5Vb3XpaMvAQ5VzZemx33LR8IMnyLijRWpiRC5M4JNBpGnQRYlJHhBi4vLmHzXvKacn3pxtrthd97c0mts5Ds81JkQ5J1bicX1dcFynLbo2jeBb5Bym9vkApxvIx6tLc/BvYPv6lMcx0Xt37T6CE67N8Eo05NKe4VFcuEcghcKUmSXVcqxyXkPryR+oJVsz396oC4lWBRHEI6I0VBsaZyu5iaUz7QQU0A8u0KlgcdgW2y/ZJ5rMLMjCMMYi2L3S+vUHCqtD2vo7/9vjPjVOOaPeymiBZEDI1S8Uurq2fBQ9nTO62qyeQBSU6O/XKqrHbP5+XhKcGHnSS/hCj2fhBUJgtSzIPgffCaEt5aJtlK587Ja3zJVvgB69WlhjYQvLg/UJ5JctbcUYP1HLO/91ag2fsVzOrg/lDyMuRvWgQFDwvhV7Z/KAWhvsWFFTmf9BG7LWB4kYdA2f8li34jQRpxKLBqzZdgUiD96zuTU270btPAGB6bISlr19RwA9tmJmA5am1IlNZx1g6L7wkOj+FruQl5tKR9JnUHPXWnBvHhzIiNacIHg77ZFyN9j3q4PeqvHCWJydvgzgMXLcEQm7+ug3dQtGCH9WN4byOD10H0Ch9UiE07839lEQfp4yJJtPsIu8b8j9hsdRo4hoDfcUrsvBeR+9+in4itu8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199018)(36840700001)(40470700004)(46966006)(44832011)(40460700003)(5660300002)(36756003)(83380400001)(426003)(82310400005)(7696005)(47076005)(40480700001)(26005)(1076003)(6666004)(2616005)(336012)(16526019)(186003)(478600001)(4326008)(356005)(8676002)(86362001)(70206006)(70586007)(8936002)(6636002)(54906003)(110136005)(41300700001)(81166007)(2906002)(36860700001)(316002)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 21:22:31.0005
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b4c491f-a4de-4bcb-64f6-08db21ad8eb9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8980
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Client PSP parts support the platform access interface. Add
the register offsets so that client parts will initialize this
interface.

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v3->v4:
 * Pick up tags
---
 drivers/crypto/ccp/sp-pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/crypto/ccp/sp-pci.c b/drivers/crypto/ccp/sp-pci.c
index cde33b2ac71b..18aa902eb5ce 100644
--- a/drivers/crypto/ccp/sp-pci.c
+++ b/drivers/crypto/ccp/sp-pci.c
@@ -361,6 +361,12 @@ static const struct tee_vdata teev1 = {
 	.ring_rptr_reg          = 0x10554,	/* C2PMSG_21 */
 };
 
+static const struct platform_access_vdata pa_v1 = {
+	.cmdresp_reg		= 0x10570,	/* C2PMSG_28 */
+	.cmdbuff_addr_lo_reg	= 0x10574,	/* C2PMSG_29 */
+	.cmdbuff_addr_hi_reg	= 0x10578,	/* C2PMSG_30 */
+};
+
 static const struct psp_vdata pspv1 = {
 	.sev			= &sevv1,
 	.feature_reg		= 0x105fc,	/* C2PMSG_63 */
@@ -377,6 +383,7 @@ static const struct psp_vdata pspv2 = {
 
 static const struct psp_vdata pspv3 = {
 	.tee			= &teev1,
+	.platform_access	= &pa_v1,
 	.feature_reg		= 0x109fc,	/* C2PMSG_63 */
 	.inten_reg		= 0x10690,	/* P2CMSG_INTEN */
 	.intsts_reg		= 0x10694,	/* P2CMSG_INTSTS */
-- 
2.34.1

