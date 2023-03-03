Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A52F6A9C55
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 17:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjCCQwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 11:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbjCCQvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 11:51:45 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1715D751;
        Fri,  3 Mar 2023 08:51:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DB2irz+zjOMxAwh9Qh931gQk3UBHOYQ+nXQ+T7pJNJrtxczcRIiLWUBYmarxlOm6Gpw63WAq8jJ12Zc/qPsJX1cj3WnWmaAnwNKaUpGFhaQHFtOHFeTTN7ce5oURrXHY1iSnje5f6Q/tvXpHsgPgGDSd5KcyMA444SYoJkY7Nw9QKjDX2aQGEONCb0hUVefzVa+GTIZeOm+mGFv79S0McPeo2UhZg/iIdS/1k+622hHxdRa6m1Pn4epLAJ/3sPYunOgTfC7vOmynY+Pg2D70+ENyvLwoa546uyK1uB1CDdXtQOMg94ScL6X9xTTc7Wa+QGSxTbpPmRIGGU2vp4Uu1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=miIKd2uqEYODxld1Xk6KNcz1a3s+EFrV/93HLXFqcRk=;
 b=eYpHZUAWCxCpUx62dmH1+8RBZB2TPQ0ZunP7IZKmEgvCLDi2KTnnif3+bcoAqTjnTwpsYNqIg6frQOknH6E3tQ7rmrS4+MubZfceY987InNCxPAbvSQmkMX5ggMoGTRB4W/Cm/o4F+EgzvOwbXVJSv5lIQeFtwNrusOGcAxWRfVy5LtqjZH2Q2B+i0J3HUJgR0gIS6U5+kSblSMv/s10fEyBNFGcNJqsIeKMeUEbshA9+SazH5AJrz1wTlStf86xkKZkBsVjEUm4+3bFdiWFo/iPvHCHmOJ8OCYS1OfDcAcuwwB98b8bbAFjbOO8cYdneYQgfVq7DADYkTQfjRI90g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=semihalf.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=miIKd2uqEYODxld1Xk6KNcz1a3s+EFrV/93HLXFqcRk=;
 b=MS8SfrmzSrmfRiNXXGxtRwf7jgXtLJtHP50Rqmhpu2lB2AVvUU/h+HxMBUzikki9rlfwr935CcXhBx73qrvfdmrwAcr3lsrmSgsU/+DT8j999xilTVpzxh4cJyNakAIRpp51SFYka1orJyEgRmoYpuVSL//fyyBrrXO2KXlMS60=
Received: from MW4PR04CA0168.namprd04.prod.outlook.com (2603:10b6:303:85::23)
 by IA1PR12MB6188.namprd12.prod.outlook.com (2603:10b6:208:3e4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Fri, 3 Mar
 2023 16:51:15 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::90) by MW4PR04CA0168.outlook.office365.com
 (2603:10b6:303:85::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.22 via Frontend
 Transport; Fri, 3 Mar 2023 16:51:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.22 via Frontend Transport; Fri, 3 Mar 2023 16:51:15 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Mar
 2023 10:51:12 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     =?UTF-8?q?Jan=20D=C4=85bro=C5=9B?= <jsd@semihalf.com>,
        Grzegorz Bernacki <gjb@semihalf.com>,
        <Rijo-john.Thomas@amd.com>, <Thomas.Lendacky@amd.com>,
        <herbert@gondor.apana.org.au>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "John Allen" <john.allen@amd.com>
CC:     Mario Limonciello <mario.limonciello@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 5/9] crypto: ccp: Enable platform access interface on client PSP parts
Date:   Fri, 3 Mar 2023 10:50:43 -0600
Message-ID: <20230303165050.2918-6-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230303165050.2918-1-mario.limonciello@amd.com>
References: <20230303165050.2918-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT054:EE_|IA1PR12MB6188:EE_
X-MS-Office365-Filtering-Correlation-Id: 0827aafe-f93f-4609-d725-08db1c0780b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oTMZ+H8zcbbeTvIbpClFs1nODM/Pm/LE8RbctVzjMQ6pC1ZtpMXXR1FJ4UyMlsdmm0qgarRrf3II41TBTWkR91GCWkB/K1HA3XE9BnB2C6rks302GEwRtLq1vFie82bwTuwqvM3j+PXNTR0c+xanXbu770O9Bond9i1pez2YzWxUtwFPpygcgJzD3OILqqaCfOxsMWue3UMebNLxLpgtCke4QrqLVrqpmJWO6ZpQTbAQXdW1l6UWpA4loVN75UC2qX1muiZDCKoUdN+jALZTTRjBAsVHPAfr9/MSIv0H0WYwhR14LdxP4w5RpQbU9mV8tCMCLZkEuIUkdnxV+PdWV+ckIxECnKTNcGzxJ/ldd8+m690Xzw1OCfUXgZg22K6kgJrVIutvVtFQs66OsAQDGQLDCflMTdIcU8fhgP8xadTGz1uyafq/D3L4sv07r+iChm6Z0FDf6AiphqYCRcQ/xh4+aCOZ2FRuh1/yAIzqWSgJqHccYRU+bsG+TcRmaf3miFIESSdJ/pC+wdu7gq6Qrz0sFJEyBWBy4bKscXMm4x3TfK3PyRyBaqM8s+rUb2h/KJ/diYgsfujWctlUUUJWY1AgxnDdJGDQUXAi/0gfI0YLexm6tcflifNaamRc0FNM81al5W/K0z5B7TI2OZbt0J5Z0dx99bAsBvPAu44T17FBn6e3cf5wsRMic9fDeeQkLQ5HNaCtrYdVJStThBoYGvxnWbzKGMpA/MmUoDFFw3Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199018)(40470700004)(46966006)(36840700001)(86362001)(36756003)(82310400005)(8676002)(40460700003)(40480700001)(4326008)(70206006)(186003)(70586007)(336012)(41300700001)(8936002)(2616005)(16526019)(6636002)(54906003)(316002)(110136005)(478600001)(7696005)(6666004)(1076003)(26005)(5660300002)(82740400003)(356005)(81166007)(83380400001)(47076005)(426003)(36860700001)(44832011)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 16:51:15.0916
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0827aafe-f93f-4609-d725-08db1c0780b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6188
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Client PSP parts support the platform access interface. Add
the register offsets so that client parts will initialize this
interface.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
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

