Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702705FA1D3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 18:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiJJQXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 12:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiJJQX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 12:23:26 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DF974E2B;
        Mon, 10 Oct 2022 09:23:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KHVzfQI6hptXgmqwDJORtSstBnhyeCRAu3cHrvBHMQawALcPXlfO/V8plJHFUPX+qe42yYlwf0uU08zIIOlNafogzSNhOeqZSkVeqqcEoAomVhHnlmPIT+v3qTLP6ox0CVb59xpZPGplvqHZbCRE25O8WKhUMXwhHT0pnXw9XOESKdseb+bfpQk7pfHxSrpdtmgHqAOBr84Kvx+a0d9f6d1+u7tFng7ZmxoyjlRxLCz/I9pyi5Oovaxhg0TsiuMA5QiZA4Ncs3fuRnDz8aTbKv/l+R7oh92KV5qlPOKA5Xq5n1UtNrTtorW86QtYvSRejyYRBNFIRfrpQSzywj4iBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w20tGngp6m1RBy4HJ8y+hNogiyLgimNYkmOL5mlmuEA=;
 b=T77ZEyPJ3DKt3WAlqfGqv0J7lS1BPu296YOt8jepsMtSTQ1KUUPuP/EScNvD7QsO3XrHICwZhe3ncYv+nGKRy1LdKtplK0pjUr4XDFO6P38Txbac/+KW/9a/yjWwtempYbUkOGW9Uf2TCCNlpkt405D+4Z4VH3QagcuCdLtq6Cuk8RMlQxVkxY3AUc0QFJGpTKHNOd3j/cy3Ff3xHEnEWHTrD4ojfrkqTSjUV70f8GX98+EZ2YyqxtyEoQub+ztYwfWBCubqVCTJQrKhcpLQcBG23Nf9Ag5hX+aj8a0cH3IzJEOJ0cyVKAZRACge1KgsbPJJHJLRj4uxOz0GAf659w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w20tGngp6m1RBy4HJ8y+hNogiyLgimNYkmOL5mlmuEA=;
 b=FR2XicH2RyDaNC7LPoywxpndwooUC08C4JgNJSsF/sW1rpdwiwOeVnoxwS0rLhngV++UDD4Mo2vU21Z7l9HYsFHZQWROBYV0WFZs103BwiEGn2w7fk1xgXIs0H2V4BM7PgTV9CJfrau5L7PhZiLDQYNyu/R/y8q5J6+g8lvwJa8=
Received: from DS7PR03CA0293.namprd03.prod.outlook.com (2603:10b6:5:3ad::28)
 by MN2PR12MB4110.namprd12.prod.outlook.com (2603:10b6:208:1dd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 16:23:18 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::8e) by DS7PR03CA0293.outlook.office365.com
 (2603:10b6:5:3ad::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.19 via Frontend
 Transport; Mon, 10 Oct 2022 16:23:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Mon, 10 Oct 2022 16:23:18 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 10 Oct 2022 11:23:14 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Shimmer.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [RESEND PATCH V2 2/9] cpufreq: amd_pstate: add module parameter to load amd pstate EPP driver
Date:   Tue, 11 Oct 2022 00:22:41 +0800
Message-ID: <20221010162248.348141-3-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221010162248.348141-1-Perry.Yuan@amd.com>
References: <20221010162248.348141-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT052:EE_|MN2PR12MB4110:EE_
X-MS-Office365-Filtering-Correlation-Id: 78a51297-860b-440a-fd6a-08daaadbbdc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1wytC7NHZc0huHIOTEHs+CJ8Oww4OGeSQfkWP8zGp/pemEChBtFhKQaAH3cAB9wK87XpBjg3ysywWJcC2uoenZURNbClLgfd/6XCXpYvMSOBBq+7AgGPTsyMXyfgrMjDAHiCJjTF3662rL14FPWaQS4ywahzi1YdsT83XpXvFG5nXMUp9Q5UPIR2boNP5iHHAH+adiNNEq7SHwdDOnHeCRMqkHQENIXd5oiOsqv+Y7gdluq8xDWWCSj/2KAL5/1Qr5aU7s9S782MLTRty4GcM04f5uQs05T3h4iMYNvsd2O7pDCUZptrTX6hQ1yMVtpKhmcx5pnEpHsHG5so9+BtT0HFtkXK8utXbovMLjXfVBtxjJu5lsc8DdGwEI/Xhq1/26yXZnBMyt37QvZfjFalneZLFeEGZEa1dw9tWngbciafdLwhiFjQfBC+/Xhwu1Gs4ZECFkM7PPW7Dy7189DP6EkLI38svjSGLH1EClXi497VRW6czmOPtfpbyNCxqv9Np64Vx2pNnd/TkdyoPkcZVHsZ8INZp++14uhZHbgh68w2A0/k3soycxrJussjq5GTGv8wSRFOfU6xBSyH4+lUab3Lgo15Y9i1IGknMYyFAhmaBQtLoRqPQ5KWX27L2u+Ssl6TcC7SRc1dPyyj5qDvM8AvYKy4jF0kB6eI5d/+maIWgS0dQ8XZo3aI+GYV6kEb9xfotx0SmAULJN6BneWWTSYdpgp3Gm9B+wGCK7K8y3h4sCUrBZQo5yL9WwJN1o8mnq8S4qmyGIxZ+qfzm9Ck95glPHMlOiJPymxuWYK5xABR3hTRkToijeGoKX1fm0BmmAAJ90ZwuU2IM+uzt2SJJA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(26005)(54906003)(110136005)(316002)(82740400003)(356005)(81166007)(40480700001)(36860700001)(36756003)(86362001)(40460700003)(83380400001)(426003)(47076005)(1076003)(2616005)(186003)(16526019)(7696005)(6666004)(4326008)(8676002)(478600001)(336012)(8936002)(5660300002)(2906002)(82310400005)(70586007)(70206006)(41300700001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 16:23:18.3172
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78a51297-860b-440a-fd6a-08daaadbbdc2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4110
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The amd_pstate mode parameter will allow user to select which amd pstate
working mode as booting mode, amd_pstate instance or amd_pstate_epp instance.

1) amd_pstate instance is depending on the target operation mode.
2) amd_pstate_epp instance is depending on the set_policy operation mode.It
   is also called active mode that AMD SMU has EPP algorithm to control the
   CPU runtime frequency according to the EPP set value and workload.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index f52b8f2fe529..2d28f458589c 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -63,6 +63,10 @@ module_param(shared_mem, bool, 0444);
 MODULE_PARM_DESC(shared_mem,
 		 "enable amd-pstate on processors with shared memory solution (false = disabled (default), true = enabled)");
 
+static bool epp = false;
+module_param(epp, bool, 0444);
+MODULE_PARM_DESC(epp, "Enable energy performance preference (EPP) control");
+
 static struct cpufreq_driver amd_pstate_driver;
 
 /**
-- 
2.34.1

