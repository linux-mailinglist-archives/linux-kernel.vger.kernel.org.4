Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B98F704FBA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 15:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233754AbjEPNq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 09:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbjEPNqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 09:46:23 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF615264
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 06:46:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GoPSA21pPl+dRNQCzo08Grbr7ZOAe8Y3b6Xlteq/t00ojuj51iBmV/u3A6xvDF9XwMkfMv0lIQS4ZB03+SeRkixzIqpZTr5Fj1nu1kL4DgQpInQLHYJHqkh67x/aOEqikz4xhbhNs/cOcheu13fGBTdtgnGP7pgecCOzJAeuNOKyyPco8JMV6c7/RZYwN8Mk0hoAVom5G8kLBmd3z1yQQbcTM5l7X7BNvdfW4gAsvNmmO9uvwAm76OiMKTYDJkuJO7vnHy7UiboTC9TE6cDjmo8yup2rWmKIEc+HrXkwItzAs/HBhHCpggCOAGghLGJ8xrgXcbIHrlnxy/PkgbfesQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aAJt6m69ghyq0nXtxzQ88tH3ZjoBjII+S+YpanmKbqo=;
 b=QrOeLO7mW1E1IB3GQKfRALdsMCB/waHejZsmZ1Lfhzbz75clpZ8ic7aM9QAvFevlcz9HsGCLxNeWZ3NantROanZrRx0hJTW67S7Kahvitg0rODJZVZy3GjuuY+G2X/Ev5llul2z4m0bKrdVHNsvEf4pW9I4ghb7QsE4tFQelE0kCk+XuxlpT+fd1ZxBSTVsXKDtNEsB1E7cGsTUHth0F/wF6qjlJzrInXKC1AIs7ee3vNqemM3/sf9WRNKLNVSFVPCwiS55ZDEP5vrs7gI3+qEqH1a/Ocq6Mzh4y2rqVQrXCYJW1YLKjXVSv4pQllYFfmC5KFYAblsIbUHX4y4IDbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aAJt6m69ghyq0nXtxzQ88tH3ZjoBjII+S+YpanmKbqo=;
 b=y/2x84fZPCHwburrFy9plKTvfGrrsBfeHmWQUz8FyqEZgdnSNxrwSuVSLGdV3zcHiHELFOm95vRuqcd+W69doH5QsoJiupLoUoGx/ez+qHwbiSuWS7CDtx7+MdbCq/X1yTRDZuj6u2qxdbmB2sNB6CQoTpEfMZViTwMF05+3ypg=
Received: from MW2PR16CA0056.namprd16.prod.outlook.com (2603:10b6:907:1::33)
 by BL3PR12MB6451.namprd12.prod.outlook.com (2603:10b6:208:3ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 13:46:19 +0000
Received: from CO1NAM11FT087.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::8c) by MW2PR16CA0056.outlook.office365.com
 (2603:10b6:907:1::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33 via Frontend
 Transport; Tue, 16 May 2023 13:46:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT087.mail.protection.outlook.com (10.13.174.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Tue, 16 May 2023 13:46:19 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 16 May
 2023 08:46:17 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Arnd Bergmann <arnd@arndb.de>, Ben Levinsky <ben.levinsky@amd.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Marek Vasut <marex@denx.de>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Nava kishore Manne <nava.kishore.manne@amd.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        "Roman Gushchin" <roman.gushchin@linux.dev>,
        Ronak Jain <ronak.jain@xilinx.com>,
        "Sai Krishna Potthuri" <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Tanmay Shah <tanmay.shah@xilinx.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] firmware: xilinx: Switch Michal Simek's email to new one
Date:   Tue, 16 May 2023 15:46:14 +0200
Message-ID: <36d119221aa12369c601cd37160306aeb84fc973.1684244767.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2503; i=michal.simek@amd.com; h=from:subject:message-id; bh=NcziUp62dpOPtB7VOMKLieq2UxkaaIHUMuZ7vVzdF7o=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpTkTuX9k6vXMoe21884sycgOWxnad5R46zuHad1Av/OK rPvOfeqI5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAEykPpBhDv82X72LXrzuDl+v dZyIWf3mSdI6W4YF/f4q33Ri+xs2r1olmzF3Z9rkCQK7AQ==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT087:EE_|BL3PR12MB6451:EE_
X-MS-Office365-Filtering-Correlation-Id: 7348cda4-328f-422e-ebd5-08db5613ed81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rz4O1PkA178i3IK9/xdJyo2n6MrnXXnspALiXOp8iwmCtw9JhXAyWeUoqIjUVZNGNRA2lU50iwTkJTEn3KSg5rUJuW1ZynbVKgBPjq2LXWJRUhKIGdC94Zn9X635FhZXqkVLnOY1G//Alho0T8DANlDS1QBHEsd5R1LUysnpTtDOeVKMQUr4J670ORVoebtClce1wRPyn3SKNxgW19ijAV2k/Pi0dzuVFWjmkVQ+iacPqqeuprjSlSPc5bV+9v7Zh9BasXdZLwUBYvYnESZyxrRjupT8W9ar+0c74lpk/KalCKzoGX8EYssSF9hmbJOCWkyLwY/hUbGDvGRzKbxkqpUoaxsVmDBMRDtJ0x3hKOLgFeoWwq5eKJK0086cj3Kg1lm9o7T7pqMLCwZpjRskISFrE24OgozT5vuEmJ7Hiqk6moFlE92ptGpfgqFzrJI5vHp3bHOFAjJFoMTEwXkto033SGGDARDUWKRJSgRiCfiHT/3qZaQpXLdlkgRJJr3Ahv72L21vQfI306FegnpbMS39jCz9O+adyv9vDTvZwoQqWmn+v9dU7htcCB3WpNNKt4w5sRgAP3+ngX/YtE4wBiN8i0xO9uixjXh50fjqbK86iZyip5Qfl5zy2YrzXTvd7PtvxFm+E8ybPNmcz51NLm4LRySHQoWUmnvcHZt+dHTz3hcvvr2fq95qWXHhStyAm1KQBGNgF+0Z9Zw0EITuYSYGrCaOrojkogqQuoRlhsW1MiAx3YOYv22a9HWqEIopDImeY5kmKS54hYbH0heXcwgxCPq4cGHX1xnNd4M6QcI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199021)(36840700001)(40470700004)(46966006)(110136005)(478600001)(16526019)(186003)(26005)(40460700003)(6666004)(41300700001)(36860700001)(316002)(4326008)(2906002)(83380400001)(82740400003)(86362001)(44832011)(5660300002)(81166007)(356005)(82310400005)(8936002)(8676002)(7416002)(54906003)(47076005)(2616005)(426003)(336012)(70206006)(70586007)(40480700001)(36756003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 13:46:19.0576
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7348cda4-328f-422e-ebd5-08db5613ed81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT087.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6451
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

@xilinx.com is still working but better to switch to new amd.com after
AMD/Xilinx acquisition.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Jolly and Rajan no longer work for AMD. Should I remove their emails and
keep just their names there?

---
 drivers/firmware/xilinx/zynqmp-debug.c | 2 +-
 drivers/firmware/xilinx/zynqmp-debug.h | 2 +-
 drivers/firmware/xilinx/zynqmp.c       | 2 +-
 include/linux/firmware/xlnx-zynqmp.h   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp-debug.c b/drivers/firmware/xilinx/zynqmp-debug.c
index 99606b34975e..8528850af889 100644
--- a/drivers/firmware/xilinx/zynqmp-debug.c
+++ b/drivers/firmware/xilinx/zynqmp-debug.c
@@ -4,7 +4,7 @@
  *
  *  Copyright (C) 2014-2018 Xilinx, Inc.
  *
- *  Michal Simek <michal.simek@xilinx.com>
+ *  Michal Simek <michal.simek@amd.com>
  *  Davorin Mista <davorin.mista@aggios.com>
  *  Jolly Shah <jollys@xilinx.com>
  *  Rajan Vaja <rajanv@xilinx.com>
diff --git a/drivers/firmware/xilinx/zynqmp-debug.h b/drivers/firmware/xilinx/zynqmp-debug.h
index 9929f8b433f5..e1515a93e9e9 100644
--- a/drivers/firmware/xilinx/zynqmp-debug.h
+++ b/drivers/firmware/xilinx/zynqmp-debug.h
@@ -4,7 +4,7 @@
  *
  *  Copyright (C) 2014-2018 Xilinx
  *
- *  Michal Simek <michal.simek@xilinx.com>
+ *  Michal Simek <michal.simek@amd.com>
  *  Davorin Mista <davorin.mista@aggios.com>
  *  Jolly Shah <jollys@xilinx.com>
  *  Rajan Vaja <rajanv@xilinx.com>
diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 9e585b5646df..f8c4eb2b43f8 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -4,7 +4,7 @@
  *
  *  Copyright (C) 2014-2022 Xilinx, Inc.
  *
- *  Michal Simek <michal.simek@xilinx.com>
+ *  Michal Simek <michal.simek@amd.com>
  *  Davorin Mista <davorin.mista@aggios.com>
  *  Jolly Shah <jollys@xilinx.com>
  *  Rajan Vaja <rajanv@xilinx.com>
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index f5da51677069..9dda7d9898ff 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -4,7 +4,7 @@
  *
  *  Copyright (C) 2014-2021 Xilinx
  *
- *  Michal Simek <michal.simek@xilinx.com>
+ *  Michal Simek <michal.simek@amd.com>
  *  Davorin Mista <davorin.mista@aggios.com>
  *  Jolly Shah <jollys@xilinx.com>
  *  Rajan Vaja <rajanv@xilinx.com>
-- 
2.36.1

