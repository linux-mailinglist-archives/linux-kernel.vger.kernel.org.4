Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D03E60C9BA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 12:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbiJYKQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 06:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbiJYKQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 06:16:20 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888D31D32F;
        Tue, 25 Oct 2022 03:09:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTlVCiFLVY5P+8RwXAf5+fMnnYGL7eAxSl/nWuAWTyd0zn0fffkm3dbEKrpvvq2QEicFLQ1G14NP4KnM8/dBpLiTiY//Pw+U+p5pTy/brkqSgXnfhy/UhMCO3HvHlf6AMsfzpdAyPlzu7LfTebT0mO0y8n2vZx2CURCMZf5R7UsoI69qeVdG9tMmfx3njDLil03/K0qiRLIhv4bg4xQkoS+GvJw+EWoAzBAUmylDjyLu1sgNMM9YSyURbdmG1zH0kzsnoj3x+bz0h02ZZgdymmDlxGjJmmUY9vm1AFxtpbweZyP4W7rZVvkSFIiujbdkRXqluVhCn9oC4yGgZV/tjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CaXUsVBLvC09k46BLu8L6Vk5lZW+blIFJAIR2hSKwqE=;
 b=mSNNOpljBtwBRU4mWPg0nL+dkT3Ydb2+kOI2lxZuk6Td5Q2gUbuopKwhbf27M69hhq8FHNjUYWWSzrK3WGAPuhwEQmZ9kP6Xm47rGGVIbRv+L1iXWicDr6KFvXwos9llKI+t/5NyS2jFfGkJlhZ7hWByLsZMtnNDOitNmToxS51IOWkjtkUo4o7aG/sMjtRsDamUtACCVYZfv/WXZa2ZMobqc+SoQnh1OWR0VQ/bwXQqPGPRPCF+pY3lFatp3VImSdh17ukSM2zHEaZVOizdOYia4bffQ+xGCH7LTsfet+JP2JVduwaMsUBpa26s4QzxGdD9oREuI7Ayu4QZcQFKFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CaXUsVBLvC09k46BLu8L6Vk5lZW+blIFJAIR2hSKwqE=;
 b=ei5DLyUWhSqhhDkw2ZumUdHO+YYIX76OodcYQKC0+8htTxFJTXKX51ymtDVJdWuMievcDc+VOY4o0h9Naeej9vSspN123sS+Y4g12GRtGlvk6EcOau82ybXuqWUGyWnScEvQI5Dpn8WidjE1Ghbv+gFDiHjPpdTRAGfgTlan1oM=
Received: from BN9PR03CA0071.namprd03.prod.outlook.com (2603:10b6:408:fc::16)
 by BL1PR12MB5111.namprd12.prod.outlook.com (2603:10b6:208:31b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Tue, 25 Oct
 2022 10:09:54 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::15) by BN9PR03CA0071.outlook.office365.com
 (2603:10b6:408:fc::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21 via Frontend
 Transport; Tue, 25 Oct 2022 10:09:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Tue, 25 Oct 2022 10:09:54 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 25 Oct
 2022 05:09:23 -0500
From:   Meng Li <li.meng@amd.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Huang Rui <ray.huang@amd.com>, <linux-pm@vger.kernel.org>
CC:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Shimmer Huang <shimmer.huang@amd.com>,
        "Perry Yuan" <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>, <linux-kernel@vger.kernel.org>,
        Meng Li <li.meng@amd.com>
Subject: [PATCH V1 0/2] Add speedometer new test cases for amd-pstate-ut
Date:   Tue, 25 Oct 2022 18:09:08 +0800
Message-ID: <20221025100910.1682567-1-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT023:EE_|BL1PR12MB5111:EE_
X-MS-Office365-Filtering-Correlation-Id: cef770c1-154b-4ef2-5512-08dab6711037
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g5o90B/UH9OEh8H3CiRgYIpduTLvvMgHCmTKO8seYIogI3kuK4IjVV+fIQubkByzj5biqNKT1r7CnJrgN0XeRl9OAoGQwxKA3vkWXpcrDhPnbTzsGThULa/LeRagSx5GbSXyyhSsJtzHY8v29daA0T7M6VU09ZST/akc26GphVyYAFXfnlFpOA6ARGwVrVyIRlfw63btSyJTen7jac7FukkReyXkP5Sh9R9PKeh17fWz9UXRpRBRG/HRdybZif8zVrkeoz99A11tT9SsVk7SBHj++SwlhUShnnudlmJe+RBW6g/4+AKLLgLr7nv/fc3IJHyAdLi1zMMnnhJ5QhGn7Sbooh9P5i90+9vWVWIopPwpVYAwOEJf8wmjIlOz/kuQsX99G8s2uKHWkYt5sTQRf/7BX/yWNrdFeBJhG5Hbt16Eh9zeMaFV/NU2C/zchb6oRdSUTbkBAK0DIPr23oCRUmEHePyjpHKosjrraZ5NaC/xe4q6aCMAuvPzvomIkMBq/9Eim2CRclymaEadvCtItQSKWI/kCJsRq6M44PoXO2AV57GEBk9F6TTC36gJ9gwxAUKckzc2jRWp2GqUb2oO0m05iRzC1jD+HXF25yEZ4cgHTnRHF2ACWwPMbNCMWAJcby6pbMB9vlKLjxoAtUeif/hmHLbeb8Vp2UrP+JbMcTFKoNAtfe6CTvv3IsekfjX6zDaxGY45D8OTFwfcWv94zrZx1Dhi7J98CJc6WUunlgYzat9VvZILatWJJ5bX35z9TFelBpFUlPoWVZBwFuyMYvFOrkvclf7XFk3MYu6hdvLnn6OtkEiG2Vv+wD5K2ZRRXooLLokFNnEOwIlECRGr2Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199015)(36840700001)(46966006)(40470700004)(966005)(356005)(81166007)(478600001)(82740400003)(110136005)(336012)(316002)(83380400001)(86362001)(54906003)(16526019)(70586007)(4326008)(8676002)(70206006)(6666004)(82310400005)(1076003)(47076005)(36756003)(426003)(7696005)(40460700003)(186003)(41300700001)(36860700001)(40480700001)(26005)(2616005)(2906002)(8936002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 10:09:54.5655
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cef770c1-154b-4ef2-5512-08dab6711037
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5111
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all:

The new patches are modified on the basis of the previous patch
https://lore.kernel.org/lkml/20221024013356.1639489-1-li.meng@amd.com/.

Add speedometer.sh trigger the speedometer testing and monitor the cpu
information.

Modify rst document to introduce test steps and results etc.

Thanks, 
Jasmine 

Meng Li (2):
  selftests: amd-pstate: Trigger speedometer benchmark and test cpus
  Documentation: amd-pstate: Add speedometer test introduction

 Documentation/admin-guide/pm/amd-pstate.rst   |  75 +++-
 tools/testing/selftests/amd-pstate/Makefile   |   2 +-
 tools/testing/selftests/amd-pstate/run.sh     |  32 +-
 .../selftests/amd-pstate/selenium_server.sh   |  15 +
 .../selftests/amd-pstate/speedometer.sh       | 349 ++++++++++++++++++
 .../selftests/amd-pstate/speedometer_web.py   | 106 ++++++
 6 files changed, 571 insertions(+), 8 deletions(-)
 create mode 100755 tools/testing/selftests/amd-pstate/selenium_server.sh
 create mode 100755 tools/testing/selftests/amd-pstate/speedometer.sh
 create mode 100755 tools/testing/selftests/amd-pstate/speedometer_web.py

-- 
2.34.1

