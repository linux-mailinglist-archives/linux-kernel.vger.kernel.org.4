Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C956DAC32
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 13:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240685AbjDGL0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 07:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240689AbjDGL0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 07:26:18 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221317ED5;
        Fri,  7 Apr 2023 04:26:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nIRYkJhOM21YOywSZnY8NslJialHvlm6ezy0x6edgyS/124rGpARTKfOdiX+3ymrqGvjcTVdTsQ/ZR1a4s+u4vaIH+SwC6I+qSybwoM4fsG1EzshQO7jcNz9rws48RsJrztQLHdwk84OvimEa/X+SShK5EnepzSXUm+QUwrxWMbHf7CvFy1uW9V+yAXhVu4VB4wdtZKSCA/Fb8ShR6ZvyRMEZ1JPYpY8qXf+RqJGO2cDugRjhjEhMYf+Jlylz3r2aW67OCIG0hGWG4Gl+y7OebXe9UDin9J4sjhrfwihULl55MrZK47kpwOO9tZhsdGchiONJ7fpsjDdOolhyRLvTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVqci0y2L0jE4PcJkKEZDVtZBHqz9Pt0h4kFQ6CQfas=;
 b=hp4ouL+Cc1mQhd0leHNz8xWcNxbL2iI0aQSBX5TUClUAm5ymvyvUmjlJLSHeGZQDm8Za/w7cd3Z4UlUBx9p1N7bvxJllzx5IUjPiagy1g1JNuuhBPoNU+lcFKDgPKL4n2xbu4lg6GWaVSWm/8Rx2SfBroYOab1tVAqhgATrr1fSIvpu+mrEArCGyeRvj3yw8aaxsDKkCpWH8lXslCkC2zbdUTVD/6hKzLC5MWmvnwJ7JhkgHKy+Zo+WGW5+eMw0RLU3NlW9s9ISYwAhosCq0ntOO0ygXU3zPd9uLo7rv3xhvmJkN9yV6erLrL473FyCT3OUFt/Jz8utUwa0FX7LjIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVqci0y2L0jE4PcJkKEZDVtZBHqz9Pt0h4kFQ6CQfas=;
 b=tf9BQwCVwk/PndvhKM/25aSC2uyoGpIHnQSPatz9fh7kRMTTABia9T4Z5JE17cRvC1oga841KritwqqkcEuM6SEXB4lHUFSlLTpF0IvaDh7JkPIJzBj9vXeEsmcQApIpTirFoqjhlbkBQOBZ0nMm9aUvJvDUOC+RuTJ9dwZ1ClE=
Received: from MW4PR03CA0291.namprd03.prod.outlook.com (2603:10b6:303:b5::26)
 by DM4PR12MB5309.namprd12.prod.outlook.com (2603:10b6:5:390::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34; Fri, 7 Apr
 2023 11:25:56 +0000
Received: from CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::98) by MW4PR03CA0291.outlook.office365.com
 (2603:10b6:303:b5::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34 via Frontend
 Transport; Fri, 7 Apr 2023 11:25:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT091.mail.protection.outlook.com (10.13.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.31 via Frontend Transport; Fri, 7 Apr 2023 11:25:56 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 7 Apr
 2023 06:25:50 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>, <namhyung@kernel.org>, <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <mingo@kernel.org>, <eranian@google.com>,
        <kan.liang@linux.intel.com>, <jolsa@kernel.org>,
        <irogers@google.com>, <adrian.hunter@intel.com>,
        <leo.yan@linaro.org>, <kjain@linux.ibm.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <santosh.shukla@amd.com>
Subject: [PATCH v3 5/9] perf mem: Add PERF_MEM_LVLNUM_NA to PERF_MEM_DATA_SRC_NONE
Date:   Fri, 7 Apr 2023 16:54:55 +0530
Message-ID: <20230407112459.548-6-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230407112459.548-1-ravi.bangoria@amd.com>
References: <20230407112459.548-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|DM4PR12MB5309:EE_
X-MS-Office365-Filtering-Correlation-Id: ac134de1-8640-4660-8fd1-08db375adb24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BxDQFFY3ai81OmZx/IdYCpuwBcL0WpDfzFzoj4GbWG1bbYtk1lcFGYEOlZL8QiJDzYF1iyeOHlsTMPfMralpNkFvTsQcZTNuxQ5ic1MgpEtIEJFEfbUbz8XKbp3eyVwL4v255Mr6JimvpBT7sAcRC89QV1LdPz5S6215Ao0Mxp0hXhuNhESWKpN4gX1e2Pn5Ai8dDPzgx0azVJ5mIZHcZQx0VmLMdAIZ29C98YqshR6hqoBqCTGwvfP29zBebvDrYuu/xd/eboGPcCIEdDW38nrCqTXte1SnF5LXVG/McC7FCFTdlTka5nsFH0i6i6yZIRsDWP5s3pqgTlkN1EIzc8Bydimqu82jlXQIh54Dy9N/GBVX7dx+FdDREU2LXTkYSwAklb08rJJC/sUIaDuzAOdu/Otf56E/a3XF7WWyRXwieHfcFBDk/uqVIUAzDZxhjE9tRS98u12wL99gmGQ8kv/sUwiALXvN8/XooisNHqnUxlAW8lrNx2TAn506tOr05zQoMeTH0Or6Xw90u2d+J+/80isxqgkSmYEAGaUNx31tQ5ja2a/W3nU4NQUE02Pg9i8gTToOyJl0WiXXNq2rz48gdm2R40HU+NelvaTiE5EYy9iibS/+mUsPCOmOR0CfGVfzp7WWTuw/ddAlMXGtTI542NzUVwUXedUn06t4y5tp7ha3Z/Nqtj++t+ISBvq+4pwXrJNuzxlJW50n3q69dZJPdctTNcNLUSa+PzB2bmg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199021)(40470700004)(36840700001)(46966006)(7416002)(54906003)(70586007)(8676002)(70206006)(4326008)(110136005)(316002)(41300700001)(8936002)(44832011)(5660300002)(7696005)(4744005)(47076005)(2906002)(83380400001)(186003)(26005)(1076003)(478600001)(426003)(2616005)(336012)(36860700001)(82740400003)(356005)(81166007)(82310400005)(36756003)(40460700003)(86362001)(16526019)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2023 11:25:56.4685
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac134de1-8640-4660-8fd1-08db375adb24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5309
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PERF_MEM_LVLNUM_NA wherever PERF_MEM_DATA_SRC_NONE is used to set
default values.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/util/event.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 6663a676eadc..de20e01c9d72 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -89,7 +89,8 @@ enum {
 	 PERF_MEM_S(LVL, NA) |\
 	 PERF_MEM_S(SNOOP, NA) |\
 	 PERF_MEM_S(LOCK, NA) |\
-	 PERF_MEM_S(TLB, NA))
+	 PERF_MEM_S(TLB, NA) |\
+	 PERF_MEM_S(LVLNUM, NA))
 
 /* Attribute type for custom synthesized events */
 #define PERF_TYPE_SYNTH		(INT_MAX + 1U)
-- 
2.34.1

