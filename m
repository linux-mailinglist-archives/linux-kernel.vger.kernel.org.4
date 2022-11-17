Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4B862D439
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 08:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239395AbiKQHhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 02:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239434AbiKQHgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 02:36:36 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C016A69B;
        Wed, 16 Nov 2022 23:36:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCv0xFpzEYc9FUNDGV+AyWdy0y2/SDwyL+R2kPvLbPkGkAi1nHI+GLtpc53E57PgttjJa7XJf/EfDcF252Vzz0lcWXR5gFBQTySpWHkdd//ZGZji0251ZPpKNzJKtJFNlmTjaCCYs+qylkAyH2nUM+bnAA5WLmvWqYpyD0wyJQAjwvefgVelj05Ct5mc2KX2zVkiLxir8Hq91g3d3jVii37C0kH17ZixzAsSIIGPJNAuZQim+M61LV72dqnnnXJBzM4z5faiyoYTHgy1uacoHzf+TDX/VtmoMnLGYUII/Z0JuSx+DpNJ3ygTT18LqMrC3bjklbL133LO7a0rndofWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hbjg3aQ2dI0luwPEC4G9zdF0aZJZYP5hXY1mKmBBlVY=;
 b=a5M1OkFotfKNTYb6PQ3ssimnfEdMTmL7rPyfUY4rfuvegs1VyEjHK9pY4KijIt/nJBPHHnYtuX/WHdYhoXCnIN84qCwBlmS+fAG4KCP/3HisWNEx7hkqce6VgO3NobOlDPVyx9ZzgmKhChnVDLZ4+IVXFfBrIPfXKprPyGq2VeOSmQmTKRuUefsF5gd6utM6rkOkNhGP73DvI38iEXY+i3pNMpE6hmMNft34GqkWsiL8x0Rn3jzJGGTmskuZrmSJrb4ADWFOlkuOS+nXfWqWRge9ncoWu5OrZRYhmusD/PqKMi9AU3/uJADhmEI/0ZfP/vLytBSoS1qYknCBsdVbLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hbjg3aQ2dI0luwPEC4G9zdF0aZJZYP5hXY1mKmBBlVY=;
 b=e12X1AmzWPAz8o4w33e2mAyKMzx4oKv0W9NBxt06H42qeCKezxzxvdtLQM/JKjrrdKJf4cCbAj4qRxgpHotI0EuFwX/VTgSB4oxAKNXOUqViep+kfgfd2E225cMLp22D7mOGskYnpSZnUz8SmePgIxoI7PhP/DDX6pHdfxWa6uU=
Received: from MW4P223CA0018.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::23)
 by CH0PR12MB5266.namprd12.prod.outlook.com (2603:10b6:610:d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Thu, 17 Nov
 2022 07:36:30 +0000
Received: from CO1NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::5b) by MW4P223CA0018.outlook.office365.com
 (2603:10b6:303:80::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18 via Frontend
 Transport; Thu, 17 Nov 2022 07:36:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT106.mail.protection.outlook.com (10.13.175.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Thu, 17 Nov 2022 07:36:30 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 17 Nov 2022 01:36:25 -0600
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>, <Mario.Limonciello@amd.com>
CC:     <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Deepak.Sharma@amd.com>, <Shimmer.Huang@amd.com>,
        <Li.Meng@amd.com>, <Xiaojian.Du@amd.com>, <wyes.karny@amd.com>,
        <gautham.shenoy@amd.com>, <ananth.narayan@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v3 5/5] Documentation: add amd-pstate kernel command line options
Date:   Thu, 17 Nov 2022 15:35:41 +0800
Message-ID: <20221117073541.3350600-6-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221117073541.3350600-1-Perry.Yuan@amd.com>
References: <20221117073541.3350600-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT106:EE_|CH0PR12MB5266:EE_
X-MS-Office365-Filtering-Correlation-Id: aed96e96-c5fc-470d-e0d5-08dac86e718d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fHhj/hXRnoMDi/7l36FQZNShyBSeTSmLv/0u4Hx8jg3aRb6YrZ6bq1GCMkynPAIhsOMwWr3dFzjTGieh2/TtACBI5NL0cLpF87WFJeCsH5CrJqcaZgTTpF4y5eY/r4F+ywImew7p08YegaiZ8ziCkNajs1rZ3fMd+g72i3gQLWUcmnO3YzeosMpCg2zKQx+24n9nUHxnq6VmFbQ2da31I8ND5Yw7x6tzRjDD+yxtROGoTCNFi0Z/cmZDeZcfLucUhiaukdNSHtF2bUF5kUkUcK9eYJtVCULx24rsd6bmDCqZowbH+7c02BED+bAe7BhzS//ZPRhv5/taAo/rXgDZS/dQJb1vwAkhRs4Fk6IuZAhpKvvK88C5fZiqhv3NS+e4TFCyad3xYoe4+aBmK0t3DDiXifkBJ349c3N2IMaPFe6dIo50AxzVaUk8yJQKUEb9zryeYKnsrbF/DJfA6GKDdT8QKdR0Y4L5uISOyub5jen86o4C2vgGqcgLwqJ4lUwF66zNnEhPW5MIahoEG+5wQi82a722aFZNwtnsMZNBBN6aA30FppXLG7OGqtEHYEYsVTf6h4IBlf7GWiyh8a93gjwc749wGypGaaH9PeZyAGrYdVR5p4fcnPkBDTY0PKLsm/2VMuY7pr2FvrSYDD+kumg6noUvaKHAC0XezT+67qqvoWp0aQCygcG5du/QVlF/LoSthoPXp40lqS7YRfEfFFbH/G42g3yd0fhIiA361grYcvx2cfpcFgl5kyFnxEE2
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(1076003)(186003)(16526019)(40460700003)(336012)(5660300002)(316002)(7696005)(110136005)(54906003)(6636002)(41300700001)(2616005)(8936002)(26005)(4326008)(8676002)(70586007)(70206006)(36756003)(82310400005)(36860700001)(81166007)(356005)(82740400003)(2906002)(40480700001)(83380400001)(47076005)(426003)(86362001)(478600001)(6666004)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 07:36:30.1709
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aed96e96-c5fc-470d-e0d5-08dac86e718d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5266
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new amd pstate driver command line option to enable driver passive
working mode via MSR and shared memory interface to request desired
performance within abstract scale and the power management firmware
(SMU) convert the perf requests into actual hardware pstates.

Also the `disable` parameter can disable the pstate driver loading by
adding `amd_pstate=disable` to kernel command line.

Acked-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Tested-by: Wyes Karny <wyes.karny@amd.com>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a465d5242774..42af9ca0127e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6959,3 +6959,14 @@
 				memory, and other data can't be written using
 				xmon commands.
 			off	xmon is disabled.
+
+	amd_pstate=	[X86]
+			disable
+			  Do not enable amd_pstate as the default
+			  scaling driver for the supported processors
+			passive
+			  Use amd_pstate as a scaling driver, driver requests a
+			  desired performance on this abstract scale and the power
+			  management firmware translates the requests into actual
+			  hardware states (core frequency, data fabric and memory
+			  clocks etc.)
-- 
2.25.1

