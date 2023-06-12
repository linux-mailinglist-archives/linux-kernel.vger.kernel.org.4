Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA4F72C34F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 13:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235235AbjFLLoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 07:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235207AbjFLLnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:43:33 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E0C526D;
        Mon, 12 Jun 2023 04:38:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JOROSHLgGXlNsbAgsWY/B6DDWrx8rd+4JZb0zMBLA40K7swYGdg78ivcV+xJ1FalCTk5OfJSBDvM0bs1xBb6w+2TPuDLG4mk4CAWW4C1CbNpf85REJXKW54xk9REilK851KBZ2G9g1Sijl0Cq11beoZg3+RBEVkTNpeVAoGG3DcRctV9BxJzkM/iJRwmudok2MkctCAEEz3/1DQ5UOnCUFDimn2MkwL+Jbgq2/RYec/t96dzeBrOuBR6yT+QmVjN6fMiE/L/9hvM/n/yDJnF1L0Eik1g44ieTgmoPT78PMW9KkM4HdIDg29TpbucMutVDewnVGMsKOV62YqsIyrClg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AlYkodrzglfXDTN5fkJDf+04scGep/JAEY4NiAyB7BU=;
 b=EoouEi6a09HRt7CKW7E8eeiqXTwcSSD5//a5nV8lmNXN8D44CvHvEbK6S/b0N/2R3oEOzurc//zpfHwrEdLJ8eOJrLbIq4yS9kccu8sHTbfTI6W0xALz0j2sYFjNiOTSk5oA7SOMeUJLY0UrjqrVQgQ0Z0RnA+pt0eJYQN2iCkLwx1N18Ph33209LgQ8CjCV5Y36j1xLDOCikFmRAsQ9vadMxyww6vp2rBdgRVW00O8+phMpcmW3weRdmdMq1ASs4rB4k6MkeFGYHe178Ye3ZCxBL74p8LG2Wht14vkC1oLEH0tB8OJhZN6sJkJBtqQswFTXhncHQRZSJR2ZA0uCyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AlYkodrzglfXDTN5fkJDf+04scGep/JAEY4NiAyB7BU=;
 b=GrujtZjGptjwIPtcH2v2534dJ4n4MGogilbqPqxFk/ajz37eVpiqWSy6+vLapNT4Uogy3P4DgPtXWI+2tr9jFpYkJXv6iQdiU4fRneTDLGb6XabHOhiOWhdyMuWBm5d3FJ6gWCQffxTLS/OHsDxfExeaUo1szGm0HbQsAIqrVVs=
Received: from BN0PR03CA0010.namprd03.prod.outlook.com (2603:10b6:408:e6::15)
 by MN2PR12MB4319.namprd12.prod.outlook.com (2603:10b6:208:1dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 11:37:30 +0000
Received: from BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::d0) by BN0PR03CA0010.outlook.office365.com
 (2603:10b6:408:e6::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.33 via Frontend
 Transport; Mon, 12 Jun 2023 11:37:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT074.mail.protection.outlook.com (10.13.176.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.21 via Frontend Transport; Mon, 12 Jun 2023 11:37:30 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 12 Jun
 2023 06:37:27 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     <rafael@kernel.org>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>, <trenn@suse.com>, <shuah@kernel.org>
CC:     <gautham.shenoy@amd.com>, <Mario.Limonciello@amd.com>,
        <Perry.Yuan@amd.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH 2/6] cpupower: Recognise amd-pstate active mode driver
Date:   Mon, 12 Jun 2023 11:36:11 +0000
Message-ID: <20230612113615.205353-3-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230612113615.205353-1-wyes.karny@amd.com>
References: <20230612113615.205353-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT074:EE_|MN2PR12MB4319:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b7c7a62-8fa6-4824-cdf7-08db6b396830
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ekmj5NOoEMIak/Wb7OCYsLsy5OHcbVzVZ88/bNzxMuWGKz0G3xOi+IruIUsm3Dw3jE8wQZqOxKeh4BmqfTqrOMcbExxtatWkA1fkGI8wZ0fNISg8Qrr1lkxxhgmoBq30zfMU9f3GHWDzmQUmLtBvxEgpOiLjdGQYhP0/z58oppU2pEuN2NVU+nd9WH7kZuw2JEwPmSHO6Gs6Y8vnO0Gc94suOsli/GIm4EO7lI+5v/y0bI3Gb0diKilccF04FO9eHEKDlvNDndqvAdG3y8LL4/K5NMsqhYchv7py7kL1J5qmPwPECYkmawHFS5GoK5qvU6CUdkv6x4pD8XwHaLkY2c7FDvP2zJEi1S9uAFHSdgJvTDan8Q0ITIOzRpttGYqFYsy+ZmGzDAuSDbhHh++jMolpfRv1FEXOar7QaEiCGxvgVk+BnSWYWpxMx/ysJ1PDdqTx93rxbsMmU8lR690dMFiPDS2/AuS3kHPqsflAN3Yjwb4cbKSccybfU2xql4VZk57xOIxhciWvKhPKDZWW1mDX2jSaznzL7zYh19ExYKPMlvZFJBfY9CqRmy6At+oGWP3MNkQfETZRLJ7qvK74+G0fhrmGwitLTo5Q21Smn0r4XUxLq60yS7ZARdYLVWPYGJj2MNp2yQKNSU+wLpcH2v0TlbnaOCZTLkxMSk35UMyJ3NZCHhlfprH9uExHz00FXcRk0ys8mPKrdeJqqF6AyGAJ/kCYhLN/Uz7yPdxDHxz5bZr+APTPPPSzHlWTbpAi3RnoxSQIYzqEHpLPqs1Gm9iETt0LECKGET5tvC6I8HQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199021)(36840700001)(46966006)(40470700004)(4326008)(426003)(47076005)(70206006)(70586007)(336012)(36756003)(16526019)(186003)(478600001)(110136005)(2616005)(4744005)(2906002)(54906003)(8676002)(316002)(41300700001)(82310400005)(86362001)(7696005)(40460700003)(356005)(6666004)(36860700001)(1076003)(44832011)(8936002)(83380400001)(82740400003)(5660300002)(26005)(40480700001)(81166007)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 11:37:30.7925
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b7c7a62-8fa6-4824-cdf7-08db6b396830
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4319
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

amd-pstate active mode driver name is "amd-pstate-epp".  Add this to the
string matching condition to recognise amd-pstate active mode driver.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Wyes Karny <wyes.karny@amd.com>
---
 tools/power/cpupower/utils/helpers/misc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
index 9547b29254a7..21f653cd472c 100644
--- a/tools/power/cpupower/utils/helpers/misc.c
+++ b/tools/power/cpupower/utils/helpers/misc.c
@@ -95,7 +95,7 @@ bool cpupower_amd_pstate_enabled(void)
 	if (!driver)
 		return ret;
 
-	if (!strcmp(driver, "amd-pstate"))
+	if (!strcmp(driver, "amd-pstate") || !strcmp(driver, "amd-pstate-epp"))
 		ret = true;
 
 	cpufreq_put_driver(driver);
-- 
2.34.1

