Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C1A64CF0A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 19:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238362AbiLNSAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 13:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238123AbiLNSAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 13:00:43 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0086FC3F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 10:00:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OB/1IW6b9QRz5DN/vs7yxNG6y+bvo9ahCh60+39mQqMm+7EGbZHl6y6plDwJ68/2bLcOLolWV6FhJfdPwGZN/Q5Fy7xjvqhNGkIGSF9dHqDlcc9viJClmsC68ZK6CbqTHZBU44aVuVhqfrvOvW0uY+vdOsmM7UuWFDABiemVlDtjddcHpAA+L1npsqCK+fyi44Mf3aSO6kR6hcOe67b1wcZEYv9CK9QAT6xjvAY7qXy4Ki9c6R48d+sVwFNhj43zTYAVPz7LuDPUYfEyKcG+g5tHPrfnTJsaV+DfhFn+sBEoV75JsABIAAUyF3HZIviOU15R8dAziACy8o21uanucQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NkANwOBVp1EnfJwpcuRP5jhVYFtwDFBD8SeGlFNM9Wg=;
 b=B7dACuQ6U7nyvplfg1NXx5REaq44kbmKdfZMNOp3zvT1PrqyEWHNGeOzIfw1BD/J+meIQsO2EKp4o9eoVLQ/NP+vzqfywcqO/hP5sPMN1o7S86IAIsxpEmWPLCDjsRN4a4Efc2Nr/+ofGJcHSdZP/zUQqDZi/9pfRHRMy3AIAiS7oSc4anVzkZOtEBmXBRM6QSHGabRJ++6LF/k0p8tNvjgnSYKFVz5BCU9SDwcnGLGi/njagHoEpFcsVr9OOsAGPtBVCg/Avw7zAAjeF5HE30ocBPK58hYAHal6WEDdIWVVBfzoLTwzEPFqzSUnc6FfiS61OSeC1r6Pc+BiL2Kq3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NkANwOBVp1EnfJwpcuRP5jhVYFtwDFBD8SeGlFNM9Wg=;
 b=N5sz4bW58LLTEMr4f4Czasbhf/OrhdLdgY7CFNxu9tDIFayNJGdPvhYAAeeb6jqY+BoaujpXVQnVPLXL65MJK6ijLoMQipt9MTX/73p49yWFc6s47XM/u21DKG4rP7M+nPrDiSUdNXeljT8ctBlDsCQG1hOXb9gbmGkIs0HaLGY=
Received: from MN2PR05CA0045.namprd05.prod.outlook.com (2603:10b6:208:236::14)
 by MN2PR12MB4125.namprd12.prod.outlook.com (2603:10b6:208:1d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 18:00:37 +0000
Received: from BL02EPF00010209.namprd05.prod.outlook.com
 (2603:10b6:208:236:cafe::3f) by MN2PR05CA0045.outlook.office365.com
 (2603:10b6:208:236::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.6 via Frontend
 Transport; Wed, 14 Dec 2022 18:00:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00010209.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.10 via Frontend Transport; Wed, 14 Dec 2022 18:00:37 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 14 Dec 2022 12:00:34 -0600
From:   Luben Tuikov <luben.tuikov@amd.com>
To:     <iommu@lists.linux.dev>
CC:     Luben Tuikov <luben.tuikov@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Alex Deucher <Alexander.Deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: [PATCH] dma-direct: Optimize get_required_mask
Date:   Wed, 14 Dec 2022 13:00:25 -0500
Message-ID: <20221214180025.163207-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-check-string-leak: v1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010209:EE_|MN2PR12MB4125:EE_
X-MS-Office365-Filtering-Correlation-Id: e6f1c868-49f5-42dd-f7bb-08daddfd1ae1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: juiIG3lUEDGjZFqT2Lf+25nXvPxWYQ+57OKe/0vzTrMpmvZhoeuj3rFLiEVJqvPh0F5aQzx0Q+1zaJvu+2zQjp3qo6ovBvvfByobGzuLGgQbpNMI3qAHn+i7pWAY3EGQwbld8bkVCZqzGHrY1AK13gHQ9n6lFNXYyTB57VNiLR/D55Vw9CjL6dMbrLUyli0fIxN/9Axjy1MXQgBcFthxOURf4iTngwa/y7CFxvOWFeJ44+Uh+8I0VgaV3Oe1aMRIN6eaATDLGa1DDYPhrfykhLaKXrthQhgUyqVFZ8oyGNDh2M5mNjWfpsTzHOl2ZsD2nNG7OsasmA8p5cvXDI4TZStfxGfyumxyi7d4TI6yzSOObLGkL7cMfIs4iYLsm8go43sK2A0MYN7H9pfqrT0E7MurMm/7SO011t3xw+eBiUrjW/bKifjIgnb8ARllqmG3vkMsxUkcu4XA8FKW/iLQg8hKGelzrMOk97YtzhAg3BBv8Ie5w2/qKj205qp00EmVt+yjNhv1ZOjl5ffK9qX3jAMauqmDGlUYa9yDXKr+m2TKqbuX65jB7JaTR5aBpH/TdIaBw5aKcMJX0NaEcTzjMZR5zN/n3aYSInKHBmfYTGyo21bMLMD7WF6tmp/2Vejx82mQ/8agxP6zlhw0vF+qEnXqxOo0Rg0BadNlLx7TPbfr+z/ZaQPEbiQ1/8Zd4KJHkvKyB+245ItrRXIblPrxAqN/M3VAV25mk6b0TaVXhUI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:CA;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199015)(36840700001)(46966006)(40470700004)(82740400003)(40460700003)(36756003)(86362001)(356005)(83380400001)(2616005)(26005)(81166007)(1076003)(6666004)(478600001)(186003)(426003)(16526019)(47076005)(66574015)(336012)(7696005)(36860700001)(54906003)(6916009)(70206006)(4326008)(70586007)(41300700001)(5660300002)(8936002)(2906002)(316002)(44832011)(40480700001)(8676002)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 18:00:37.2265
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6f1c868-49f5-42dd-f7bb-08daddfd1ae1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4125
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Optimize dma_direct_get_required_mask(), in that we don't need to multiply by
two if we don't subtract 1 from the exponent. That is,

    (1 << (n - 1)) * 2 - 1 <==>
    2^(n-1) * 2^1 - 1       = (by rule of exponents)
    2^n - 1                 <==>
    (1 << n) - 1.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: iommu@lists.linux.dev
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 kernel/dma/direct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 63859a101ed831..bb416a3949dac0 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -41,7 +41,7 @@ u64 dma_direct_get_required_mask(struct device *dev)
 	phys_addr_t phys = (phys_addr_t)(max_pfn - 1) << PAGE_SHIFT;
 	u64 max_dma = phys_to_dma_direct(dev, phys);
 
-	return (1ULL << (fls64(max_dma) - 1)) * 2 - 1;
+	return (1ULL << fls64(max_dma)) - 1;
 }
 
 static gfp_t dma_direct_optimal_gfp_mask(struct device *dev, u64 dma_mask,

base-commit: e2ca6ba6ba0152361aa4fcbf6067db71b2c7a770
-- 
2.39.0

