Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41946C4170
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 05:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjCVEKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 00:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCVEKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 00:10:12 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802554DBDE;
        Tue, 21 Mar 2023 21:10:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=knQL4deXc1nXWUSrMOLekH9O12E2Yyn5BUOZjo+oiMi/T13go0DhQEIfLfHQE4AsKJahvnnKy7t5MMNmBhQcx9bb7vTNqrd1B0bVs03ZPUr1GMceVGBA2rB5Bj2lzqS3sBfPqY8lj7ZkV1tdw3cw7jd/NHamveQC40wAUOmskPaeVKw5VVvK8DQYymGT9wpNbKius8IFonmndQEAgnpLeVhbI/brt3Q/R088fNsRdMMTjz3y2yxqQtFqc5zQqfrj++dX7pKgN+OS5atozzQvUT6W1J+L/PVDbzMy4r1RpEDCMW14arh0LYQ2+2x4ErP48bEy50GSr9MQEGb0/fC57g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ddw8ltqMLp92O192tH8jzt37jvQEfthNH1nj1RqgnSM=;
 b=hmSqFSw+WorozqPuzfTh7Ew2v7k2mQWcsB2wsmzdPMKzH7/f+TXsEJmBTXUTGwSR1LhKHSrZNWQwKzUADyUamr+uO+aspW/LaRT05PrIvXj2ThbmKzRjaY9DlFH39i3jLkfqazO1NAVVOtc3Ss4nxxZEclPMRJ0F6qgqxJiNY8izr6nxZpxw+ZRtuP/H/r/TvraG9DSEv/9+TnN1B9ME5x8MGZ9oTx+6BMiHugTtLjqrWqEiHAM0g3V1LeyZ2aYxa1LkyGHoZukMihbgxhxqpTXyjSmMvhpLKqWpgXOUpVsY09Ynp/f6DVCnHKHdmZAserOYdYcNXDfpkJ4f8tLBMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ddw8ltqMLp92O192tH8jzt37jvQEfthNH1nj1RqgnSM=;
 b=Q4SeduSHjjMwTmJ0RHZwCzDAlDOLK5xDDnKmi1hrR6vO/EuYlIrPmCoIyiIunKM5FBE1olBRAlllIacW8R0ac97cXQxkMrg4w2iqJH7LUpAqBe4OCCcau1OBmrxX4AG7PQgGMxG9+gkeLq1Y4vF0Nati2OM2wf0FEpr5+sUEy4I=
Received: from DM6PR11CA0061.namprd11.prod.outlook.com (2603:10b6:5:14c::38)
 by BL1PR12MB5731.namprd12.prod.outlook.com (2603:10b6:208:386::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 04:10:07 +0000
Received: from DS1PEPF0000B073.namprd05.prod.outlook.com
 (2603:10b6:5:14c:cafe::7f) by DM6PR11CA0061.outlook.office365.com
 (2603:10b6:5:14c::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Wed, 22 Mar 2023 04:10:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000B073.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.29 via Frontend Transport; Wed, 22 Mar 2023 04:10:07 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Mar
 2023 23:10:05 -0500
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 21 Mar 2023 23:10:05 -0500
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <andersson@kernel.org>, <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Tanmay Shah" <tanmay.shah@amd.com>
Subject: [PATCH v2 0/2] remoteproc: get rproc devices for clusters
Date:   Tue, 21 Mar 2023 21:09:32 -0700
Message-ID: <20230322040933.924813-1-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B073:EE_|BL1PR12MB5731:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e5f196b-f6b3-4621-89ce-08db2a8b5278
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Glchvb9Y2ItJqYMm4Ojz8gkXutFZvh3AVLxkwufDcEbP8dn+gLQE7rah0MLUCLVD9QAkRtjA6opQDuLZxP7gKNSuju+3XUhLEsKtRu9aMzhXstKQ9sUASJTHpNswHqT21K1j9b3UDL6ZCHzo9X3MeHp4Kc/T1EQr/w/iw5W3/AvG2rPA3OnBIaAKQOrQhUevS5OxF83hacuohtPNevFr2Ki6+v4KyhZpGCRQxj3FoW+dydzF13IvLwYhilb86clHm3L0smK2ykwx6d9ilyPb67ua/sZRJfEVU3ASrIwlii3poaq3eUHayPOh1JDm8SHheMrnTfZ/IXBFW+FAJhHMzmHpAYcjc/OKorTOAttTlyeXh5SCzXq5JZUzv204T6CM37vrXiTBbJxHC+AxEd/1+9ZfEbEqPrfvIUXdsM7PfXiaq2Z8jNlsUO9ZAxWIZH8BKLmnh7jnQ77PEseeONWhruOiOtDjEODbV6O9DYBsH6+Lt9qtIhVRXjqkpF4emnSCIKacFsXwbEUv5DxFN5fBQFPVY3P+HSW1XKVTmAMf28oYG5mzxXfrBGgpL+rR2mLVxUxp8tmMQteGXlAA0zD5PYU22JUuVeGumNvCq+XVSjyIEbaFFpkiZQmwRYLKzlPFiO1gapESA1LKk1NCKJOgzQFXKqsPuVcCsGD1/6OAh9ieuw2nde25W9gwoVYhDJYTOaHFvqDRat6ZBmGn+MgLo3j45W8srZakUIb+NoQaf00=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199018)(46966006)(36840700001)(40470700004)(110136005)(336012)(2616005)(26005)(1076003)(426003)(47076005)(966005)(6666004)(4326008)(316002)(70206006)(83380400001)(54906003)(186003)(70586007)(478600001)(8676002)(36860700001)(4744005)(41300700001)(8936002)(5660300002)(81166007)(2906002)(82740400003)(44832011)(356005)(82310400005)(86362001)(40480700001)(36756003)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 04:10:07.4727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e5f196b-f6b3-4621-89ce-08db2a8b5278
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B073.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5731
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series extends original patch and makes rproc_put() work
for clusters along with rprog_get_by_phandle().

v1 is here: https://lore.kernel.org/all/20221214221643.1286585-1-mathieu.poirier@linaro.org/

Mathieu Poirier (1):
  remoteproc: Make rproc_get_by_phandle() work for clusters

Tanmay Shah (1):
  remoteproc: enhance rproc_put() for clusters

 drivers/remoteproc/remoteproc_core.c | 41 +++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)


base-commit: e19967994d342a5986d950a1bfddf19d7e1191b7
-- 
2.25.1

