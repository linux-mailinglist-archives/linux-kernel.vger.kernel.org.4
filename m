Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20E55B3DB1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 19:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiIIRK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 13:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbiIIRKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 13:10:20 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DCC4D169;
        Fri,  9 Sep 2022 10:10:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UqUye93mYKYXYDqkbKaERu27IBPq6ykZoiwFB9stEhiLep5vq+lxS7s1atyOgzzbxCz5UT0Q3OpuSgRqFrCQcOjeqn0sPYbmMMYptGyth4g1I3cQTIAtabF2Exq38rCL77Vs5698Vk36mrfY5gOhm5emvRQyMCARSlfMPecTf9uC9l7AuJsG6iETdLOjMCSavlaFTRBBT5a0wGh1xDc9yImxwaNna0nOfXEE1j9TubJ+HU/+WZrpMLkpxVJqsInRnLXN/7++3cRVXf/BAUB17to/i0SwNhhtWbPVictr+MdDPbzdmr5OZ1PGawy07LUYbtbHZKo9B/kDQH+UZ0IoMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hGT9tm2z3qkDHy13jKtryH+MXoOAs+/m5sLf0d9r48w=;
 b=fAkMxD00eKABs18lQ1mGJ1riycmD22u/fJNEVn0lDsC+/sUQxIqQihkYQSogLqH3taAt3Dum1L15HK8irbkinqS81lIj+M+QVZxAjR6B5bbcjfwvRq7OZNPW5jOYh3qW3XwohFaPLXmTmAwb3fEFEx5PntBytxySKG4b7+piCfLpTtlF/k4+KN0qGzFXr54gEH9axstbKA+jRcBqY3uahs3IXufRgCLOyMxYEsy7a+SjMbiu9SPaA9FuoFFDuLqNAF/NRaYEq5Cg4tOW6d5jqpKyZKhvXhJpvZeRblX9FIxowWtlFDbC/BD8QMBTyzXlU8yYqExAwbU4kdu1AAJ4tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGT9tm2z3qkDHy13jKtryH+MXoOAs+/m5sLf0d9r48w=;
 b=L7YxblzQ9McihgBK+9adFVoJXxUCNFo54mRZ/ToF7zsohJqo/IX0jecRPI1cwMoPBkes+2T3QAIktpmcmBTZ7AYGFkvfNrgKKyBC4sADNu6PCJXIdHADYINcLr73/mxQPl5yxify3ZC8+0o1lL6EooMNhIJQOo2BiIDWxu1892I=
Received: from MW4PR03CA0261.namprd03.prod.outlook.com (2603:10b6:303:b4::26)
 by MN2PR12MB4582.namprd12.prod.outlook.com (2603:10b6:208:26b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Fri, 9 Sep
 2022 17:10:10 +0000
Received: from CO1NAM11FT103.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::85) by MW4PR03CA0261.outlook.office365.com
 (2603:10b6:303:b4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Fri, 9 Sep 2022 17:10:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT103.mail.protection.outlook.com (10.13.174.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Fri, 9 Sep 2022 17:10:10 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 9 Sep
 2022 12:10:05 -0500
From:   Arvind Yadav <Arvind.Yadav@amd.com>
To:     <Christian.Koenig@amd.com>, <andrey.grodzovsky@amd.com>,
        <shashank.sharma@amd.com>, <amaranath.somalapuram@amd.com>,
        <Arunpravin.PaneerSelvam@amd.com>, <sumit.semwal@linaro.org>,
        <gustavo@padovan.org>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>, <linux-kernel@vger.kernel.org>
CC:     Arvind Yadav <Arvind.Yadav@amd.com>
Subject: [PATCH v3 2/6] dma-buf: set signaling bit for the stub fence
Date:   Fri, 9 Sep 2022 22:38:41 +0530
Message-ID: <20220909170845.4946-3-Arvind.Yadav@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220909170845.4946-1-Arvind.Yadav@amd.com>
References: <20220909170845.4946-1-Arvind.Yadav@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT103:EE_|MN2PR12MB4582:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f826341-21e2-479f-98ea-08da928626eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sUxwk4vE1fvGCXs89BwOwNh2rD7iEV4efgC3S+KYxWQvCzqb90lQt6N9bd09FIIamKByUiiXZ1k6aYbuZtZBgY/FStE98WLq3PqRpJ6dfq/+CYxCpkOxSYa9LS3/SI+lRuERzBvbqzs+K9vhqll7IYLAmYZdJj58OdRGWIPQbedy18ARuNma8E68IQuzjJxvdTPmIffLcfLAH3vOpNvnWS6u2qSWJWg9tAXFsFSSq1GJl+8yyN20xljuABlDf28Eaq+znoNZT4tRz4h6DYK5t59ELdYw1HIM5nnJeV1h+W7vxoFWUFKMTY110iZVkPMYytl8iv7ZVNemkJS2yVWa9uN59Gu/b9coFnk0CwhKfRJd96iOsROD++WnejFuiIXxDFR3Lo9uMA+UqNuR8eA6/QYvl4ZibB7esJATwKcBYJKFzWuQd0vrDhPFYFsAeecJFXh+7Se6ai+Eu4hi1rxrnQ1FN398Dz5bkd0hs9i1jXKuSGnIMIBF0q/Tvu/OqZ9sUlNeZ+OCSIRAugqhNe38BgPd/TYhioW5KNaX5wwDsTlPWUNumRfKOkStv5TOnPCVsp03qBLq5knH5gnlu8bThemkksgP/4MwwOVREM+lrQAzv3koH0jfWYj+mE42w9yYqaKJTlRvjXy3MxXjkBdpXCyH5XV2S+Sn16tVfERfvzrDkKah1Lcb5voZvTF7GYoGcOpuijMBNY1+0Pb4wmCDfArOth6Y/FjYx2g8JgWbxOSu6LUyJdn/YZWNpPH7S7v3g1YAwIgsufq7mg6OsxxCa4ZUC8XahE+RO9mOCcYToKBTXJ7nMbJYruT23O8cWmoCz1F5M+p4ClaB/V6Pdt8dO6d6v+m0KH2nBOZPXEDeWv1yT8KTiGBQsiTCA4YIzHBn
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(136003)(346002)(39860400002)(46966006)(40470700004)(36840700001)(7696005)(26005)(81166007)(41300700001)(6666004)(356005)(82310400005)(40480700001)(921005)(478600001)(36756003)(82740400003)(40460700003)(36860700001)(1076003)(2616005)(186003)(16526019)(47076005)(426003)(83380400001)(336012)(70586007)(8676002)(70206006)(4326008)(316002)(110136005)(5660300002)(2906002)(8936002)(86362001)(83996005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 17:10:10.0562
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f826341-21e2-479f-98ea-08da928626eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT103.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4582
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's setting software signaling bit for the stub fence
which is always signaled. If this fence signaling bit is
not set then the AMD GPU scheduler will cause a GPU reset
due to a GPU scheduler cleanup activity timeout.

Signed-off-by: Arvind Yadav <Arvind.Yadav@amd.com>
---

Changes in v1 :
1- Addressing Christian's comment to remove unnecessary callback.
2- Replacing CONFIG_DEBUG_WW_MUTEX_SLOWPATH instead of CONFIG_DEBUG_FS.
3- The version of this patch is also changed and previously
it was [PATCH 3/4]

Changes in v2 : 
1 - perviously using  __dma_fence_enable_signaling() for enable
signaling.
2 - #ifdef CONFIG_DEBUG_WW_MUTEX_SLOWPATH  removed

---
 drivers/dma-buf/dma-fence.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index 64c99739ad23..bead1a6e9f59 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -136,6 +136,10 @@ struct dma_fence *dma_fence_get_stub(void)
 			       &dma_fence_stub_ops,
 			       &dma_fence_stub_lock,
 			       0, 0);
+
+		set_bit(DMA_FENCE_FLAG_ENABLE_SIGNAL_BIT,
+			&dma_fence_stub.flags);
+
 		dma_fence_signal_locked(&dma_fence_stub);
 	}
 	spin_unlock(&dma_fence_stub_lock);
-- 
2.25.1

