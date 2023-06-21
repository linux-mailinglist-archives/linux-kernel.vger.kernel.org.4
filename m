Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57F973858C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 15:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbjFUNoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 09:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjFUNoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:44:14 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93ED219C;
        Wed, 21 Jun 2023 06:44:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G18UdQeXsbT+ItRsFHb2TcgZoCP6A6d8Ps1RLeUB2iUfvrFoTjoA5d/VBwaWH9fFHps+/vGBX+M+oUldqNI3TvKhiH5w0xgkxByHIS+nOw+SoOGtrrUPRKW8P1/7KLotoKStEu+RieydnZ6dU62VUTnPQ4SknjQWpho1JLPmxZMHrLHTNdfi6ph52h/LsSHS679fT3s0znQD4aYRbvVOTZ5PVnodOycj325CrhRgkXarxiRbynbiUMjgk2nNvisU5TW9JYg3V1EtpbOb+s9IPEgq68l0pBelVdsVs6UO0f5Q/bwkKhB8Thyi9SZCBAJBiIEr1xdLm7/8HBFzSTVl/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFwahwgyuzD6wb2hguaW43cuMHR5pwjsipJByOa+vBo=;
 b=ScU4YpIh8r7r3WTm8sW9FyU327j21ZAo8tYBhCPyCw+wTEVk7323A2e5X727KlwISePK3loqA1xFS/4yDtcMSSZuuikQJn4/wtQxLhGAGWeHq3D39z6k+R8IZA+WftvJXsStxFMOzkXOyqN46ud5ILQ5b4bmr3+ViM0cFyUJS4nze9qeJO12vhcaij+xtTf1MUBmEvDV6aRHbM+JkStjpqZbp2XnwdEvKCwGypBdX3ddzGo7G21f2/HD6x0jc3C+/2DGHHT4xL6LqotmDrCR5HlbC2D4E5Cw4Vb0OsV5xRIc1W5YRYGT29lwlz05M5BgGUb1VEK39IRC2FHB8cnj8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFwahwgyuzD6wb2hguaW43cuMHR5pwjsipJByOa+vBo=;
 b=qD0me5WZzGrrrhJexogk7y6J/r0C3RiqqrUNePAK+ZwDy1DvnV5xJ9NfvJEWm+pZdo/yXmDUUZ6unSpLGPig1AD4+hEb94Kloo0z6H83AiU6QcaQvW0rCXVsl9wOwnNzLVVhQ59cSkLmjru0majF12iQrVqgHEOzz7OLYAg1LKAoAAeSrzdV0V30U+/BZfvNKtHkLquH/eH23p+aPXxh4KK7WPtphBuvIr6QJ0ueEzli6h4JwuBiKYYBBQPCi8aHXWhYt0lbqLykPo77C+FJIQg07DxgE1pWdKDtZStuX3Ap1z/qkY65mTapKcQM5r3L8IGtvHtspYOJWVRQvsUTFQ==
Received: from SA9PR13CA0151.namprd13.prod.outlook.com (2603:10b6:806:28::6)
 by DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.23; Wed, 21 Jun 2023 13:44:10 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:806:28:cafe::35) by SA9PR13CA0151.outlook.office365.com
 (2603:10b6:806:28::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23 via Frontend
 Transport; Wed, 21 Jun 2023 13:44:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.19 via Frontend Transport; Wed, 21 Jun 2023 13:44:10 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 21 Jun 2023
 06:44:06 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 21 Jun 2023 06:44:06 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 21 Jun 2023 06:44:03 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <krzysztof.kozlowski@linaro.org>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
CC:     <bbasu@nvidia.com>, <talho@nvidia.com>, <sumitg@nvidia.com>
Subject: [Patch RESEND 0/4] Tegra234 Memory Interconnect followup changes
Date:   Wed, 21 Jun 2023 19:13:56 +0530
Message-ID: <20230621134400.23070-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|DM8PR12MB5430:EE_
X-MS-Office365-Filtering-Correlation-Id: e2f14c2e-26cb-4864-b7b5-08db725d979a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S3MTIk/zxcN7lUI0G5ayXLRvIf/cIms27BVwK4naw57u0LUlZCduJ9HmdFGzRmXbFUBPhTKGiQSrKAXbm63LYeR9/PfcFlaYu/3ovE6X0aW9pqN4zriUVDJnOOpQj+VdOGjx8sK8NoYBdFZIciTyxfZRtFsYa9Jt5U/KTgar4gnsQuGaGC+YEyeNBpbDLW5py+/42gGV+N1QATg8Q/OrMyEYPZk0WirWnTOBqVDOCK4qy7Dpv8Td9A3eN5/4Ok70ktZIL9mEdMxXLoijT9iuzlwIjUvF15dZ+yZ9awxF/zjWIhKP8H4k0QW6VW6IK/LY/6e3FdnLp+YafxRriW1Kb32BUqyC98E/gCd7mUW8GQOiVHii2K6exPplQdxXjHu+lHERUDBUE0HfHPkpZp2mfw+XDY8bvnHGtYISrOurZhz+kgSabZguvb2XcuQA8J5X+eDb4gzasMFrfZCp0erLZ+/mSe1lmFIoS3Qk8x9oPMWeg79yGwIn7ZhpppKnB2RZtAmSpeX63wUq7WfxlUdVs6puBYTtV09lNZ25iq/jBFy/8CsH8VIfUQ6n3SPDKxCvBu0ha8W8JGIpvn25Q8yFz1AluNZECygHPTyr4i5EW4T4eyP80VZ3IIxBywIgOyG69ZBTRjhzPxFbQjvsmFpLQOs8+REhvwvCkMuxPCEiCuhvDKDhATcyZhLbfSBBeLQ2MuQkCEe7K4l5eBUjQpvybSuZrIu+ZBRjyicaPyxw327g8xC3EOrmW9pl+BoAESQt
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199021)(46966006)(36840700001)(40470700004)(82740400003)(36756003)(356005)(7636003)(86362001)(82310400005)(40460700003)(41300700001)(8676002)(5660300002)(107886003)(478600001)(26005)(1076003)(8936002)(40480700001)(2616005)(186003)(4744005)(83380400001)(426003)(336012)(2906002)(316002)(7696005)(70586007)(6666004)(54906003)(4326008)(110136005)(70206006)(47076005)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 13:44:10.2831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2f14c2e-26cb-4864-b7b5-08db725d979a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5430
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

This patch set adds VIC, NVDEC, NVENC, NVJPG, NVDISPLAY clients
of Memory Controller to the Tegra234 MC clients table. It also
improves error handling when some MRQ's are not supported by a
platform. For Example:
- Avoid "tegra186_emc_probe" failure if the "MRQ_EMC_DVFS_LATENCY"
  is not supported.
- Avoid Error returned by icc_set_bw() in the MC client drivers if
  the "MRQ_BWMGR_INT" is not supported.

Sumit Gupta (4):
  memory: tegra: sort tegra234_mc_clients table as per register offsets
  memory: tegra: Add clients used by DRM in Tegra234
  memory: tegra: add check if MRQ_EMC_DVFS_LATENCY is supported
  memory: tegra: make icc_set_bw return zero if BWMGR not supported

 drivers/memory/tegra/tegra186-emc.c | 136 ++++---
 drivers/memory/tegra/tegra234.c     | 604 +++++++++++++++++-----------
 2 files changed, 435 insertions(+), 305 deletions(-)

-- 
2.17.1

