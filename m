Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC546E5FED
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 13:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjDRLfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 07:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjDRLf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 07:35:28 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BF31713;
        Tue, 18 Apr 2023 04:35:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ANJ4XgoT6V86Tv9n+mIfL2LfOshy8Aq1GELWEJFuymWKDB4KudSLsfj+oeW+wqKc5dXfB4Z8fhmlOBIoBmMKBa0qxGKb4QChIKxY7WgG0rA+1FjPMkIEcLxVYBRTBuiv9QFZYTxh88/U6OwPlq0W/9cvYDoylqrEeaLnHGZfhefIW/ReXiNHt6XlMexc53caMBvH415hxTWjyVIgkzx6DS5mtrspDGgBu+w+sNUP6/sO08+HS+IFfDuA6p0qhIi45pSryDH35ddQPFrBCjVTkk6vQaV6yREDx00JUmkGKKVKNyUYm7466nulLu9aR9yYOTsAAKF6fBNPPXcIqiMshA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1rlalZ4WigH/v+i2a2I2HwqhljC7aMXGN7wsDQyCVTY=;
 b=JA/+MNq4NiJ1rCJVU0fWRTcFRChlVyxCE2+zi6gIH8fZXqkyDAIyu7maeHGXv0/UDT4QpDVKGhhDtgWfdbLD4XvwzCYGM7U6WZtn9mC//bc5tCO4uIcJzo0r/13pXi1XeFeQKaBOocWOJIYmkZWk34ebHBeOfvlV70ZTX4mEFbc/itFyUk7Vr66GFvfwlfMKwwJyBHnAOpdyWAQ/Wghs59Jg6fGP5FrnYiBwje7YLZ8l6lAW4Y47x4SjNa6inWucJQdB35AMbAy8Eu+tK5CrCU8siN3diBU7ugtykONLgNhcpwFonugcV4muHkV3VZ4L09NMsPXmjFm+U3mQ5PC/zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1rlalZ4WigH/v+i2a2I2HwqhljC7aMXGN7wsDQyCVTY=;
 b=OkStxcaWWHjiL6YqZFiRFVnllJCCFlFgLtypRp6ro3GG3II+DZ/zzqd6EedVLkfxuYK/jubeu4FEcJ5wkc8jbtwIhXXR6yr0HvdPrKlrIshXrj5AIkkbsbgwD82qKuSoj5Ffq2Tw6iR/B8cqWKE0ejGJmI0jOi6j3VT4aP1z11OQ7mfsYk36XARlUKb0oiw8X202aFqXLly7h1Ql1Kh/HfCZH5EPTUEV/ZPcuhxeKt/rF0OLtTHqmIEhaFNLGi4jZCcdoz9ZYkzApTdPsyWgUXlsMKi9Rx/2/CcFd7t1RXiRcg9wmWrtp6lwNV2wFdDwX4PJgAbE5NY7CdD0NLrjGw==
Received: from BN0PR02CA0033.namprd02.prod.outlook.com (2603:10b6:408:e5::8)
 by BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 11:35:24 +0000
Received: from BN8NAM11FT077.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::f9) by BN0PR02CA0033.outlook.office365.com
 (2603:10b6:408:e5::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.47 via Frontend
 Transport; Tue, 18 Apr 2023 11:35:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT077.mail.protection.outlook.com (10.13.177.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.20 via Frontend Transport; Tue, 18 Apr 2023 11:35:23 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 18 Apr 2023
 04:35:18 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 18 Apr 2023 04:35:18 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Tue, 18 Apr 2023 04:35:13 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <viresh.kumar@linaro.org>, <rafael@kernel.org>,
        <ionela.voinescu@arm.com>, <mark.rutland@arm.com>,
        <sudeep.holla@arm.com>, <lpieralisi@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
        <sdonthineni@nvidia.com>, <sanjayc@nvidia.com>,
        <ksitaraman@nvidia.com>, <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [Patch 0/6] CPPC_CPUFREQ improvements for Tegra241
Date:   Tue, 18 Apr 2023 17:04:53 +0530
Message-ID: <20230418113459.12860-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT077:EE_|BN9PR12MB5115:EE_
X-MS-Office365-Filtering-Correlation-Id: 023b8b46-5602-48b5-3cec-08db4000ffe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GAcF1SFX95nxGzcZn5KCe6dcONgrVOk1uxjzmkGKARNOq1XDvffMF3oQOu2Q7woS5ZIaHci2br7UjcaXEz8hcPMgiR8G71UCh4At4CVGHlQRL4+cLsto2nyCb0p+IvOGNLa0GYBXsJbcofOk0Ut2aG66ReF0dAg59T33FUMO07i3+Dcc+HTH6JCL61xYG+QMbuWEtqWffokBHiJVQR4uJN7vYi3W0AjPtoyNUqg1RsPrjy0skDHYrEUEZ8sCE4JmK3/B0tggDvceFPpdtbvaWVpJeT8U7YS6zoL5WaM5FKh94hzrXHqrGq3eHa2xAoEn3qzh1/UBK9cqIcX6mpTe0ogYa6oPr6yyTVjZT/oA4GXUwQnd/2xJsvHkIgXoCuoM7ZHHjhcftijsBViyu9BGy3y59VnZn+IZvja6F4H0mk6SI9Ewm27k5HRPVAPBQwL/4n3xrRJf6Kd9GCRm0zV0D+A0XYEf+EgOIK0gUvQeXNA/JfsNWCQAPE4uKQ3/B8m3qNRo6RXbp1zneru/kjWSwVlSUN4DePUjxegA4ylgq5a9qMnaDgLap0UeCW2hjLNvQi6VxCs7JsLo32nFcx++fVx+GPDTPQaYN640XQYJq+ssdYpj9c86StTQYzOvFx7cOviQHieh031uF4crOXUGA/8IlQgi4eIpvhU9JfZjFYpfoSb7R1SoliKMrd4EDcEaAOM+npGhUql72bWZWjbOQCYOBsdhZRtnYDGu7f31QvshwR0QK65RhW8nfI8yosWO5fAPsgRsRUH0OBBwba8xHHJ49RJ7Xtg2w9EITsKnHb8=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199021)(36840700001)(40470700004)(46966006)(36756003)(8936002)(8676002)(40460700003)(5660300002)(7416002)(2906002)(4744005)(82310400005)(86362001)(40480700001)(34020700004)(478600001)(7696005)(6666004)(54906003)(110136005)(186003)(107886003)(2616005)(36860700001)(1076003)(70586007)(70206006)(26005)(41300700001)(356005)(82740400003)(316002)(7636003)(83380400001)(4326008)(47076005)(426003)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 11:35:23.8679
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 023b8b46-5602-48b5-3cec-08db4000ffe9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT077.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5115
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series contains improvements and changes needed to get a
stable value of current CPU frequency from "cpuinfo_cur_freq" sysfs
node in Tegra241 SoC. All the CPU's in Tegra241 implement the ARM
Activity Monitor Unit (AMU). On reading the sysfs node, the frequency
value is re-constructed using AMU counters.

Sanjay Chandrashekara (1):
  cpufreq: use correct unit when verify cur freq

Sumit Gupta (5):
  cpufreq: CPPC: make workaround apply code generic
  irqchip/gicv3: Export arm_smccc_get_soc_id_xx funcs
  cpufreq: CPPC: update sampling window for Tegra241
  arm64: cpufeature: Export get_cpu_with_amu_feat func
  cpufreq: CPPC: use wq to read amu counters on target cpu

 arch/arm64/kernel/cpufeature.c |  1 +
 drivers/cpufreq/cppc_cpufreq.c | 99 +++++++++++++++++++++++++++++-----
 drivers/cpufreq/cpufreq.c      |  2 +-
 drivers/firmware/smccc/smccc.c |  2 +
 4 files changed, 89 insertions(+), 15 deletions(-)

-- 
2.17.1

