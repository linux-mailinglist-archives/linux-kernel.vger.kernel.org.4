Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBC562A245
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 20:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiKOTym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 14:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbiKOTyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 14:54:24 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A1E6250;
        Tue, 15 Nov 2022 11:54:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2aHAXxmKfdty0S/wWFv2yUce1uoZdfZ+wVvKkNJ3rfiiL/1vOzlpWrAAnoEWjCduBwBm4F2bB6x61SOFkppsAD0K61v7oz5N8NUU2TuXaKMsps7jcsy8vYld6tQyUe6fyViiLlfhTY2gXOGWVb5YaV/2msKrgWZOP57KfxwA2Prax6IQWyfF46/bvFYK3pfzSMFrk2xO8EjgUc9qFHZu1XFIa44YMQ5wGPmfIBBOSf7a3G+RTlYLRmJx2YJgz+h6RXNkhxL+IHzNESaEoXKHlcdCD3cFwLGhfFHNNDm1JeafWQvzm+V+o9qC1+YAsd8B6IM7et7spF1+45YZ9Kquw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KiLAjJ+YWiKO/cZsJFmLCEH8r2kiulS+akAiHUDdbmA=;
 b=HgIwnDdbxUV/T/AFdywXy4IkLzDHbyTLCYXhkHH8cUkU3kYvdD4eunj+pOKuoNGtdYVWJ6ARxyQJhRO3pLwh3294dCs/Pa7ZHh+tiATNJZ71Lh5aZVcHyBuCgXRfuQAxkaLNXJiTc7e1XZ03AhX7/moQ8yfjT8lt9a4MHolJ6oZDzk/LowFKFmjqc7vbcS1n9c5Aaqr0Hvc1XrbLRizRbuNw+rUL7Wz9LJvnO4AnCq4dNdjUj77lMi3JlPGGDDnx255CWEG3yv/oldS/k/UYvDtBEtu1mR3VeKGFBrF+GeQ2JcItCWNlslwnwA34zAqIgv3c5jfabh0fbSAC0OmYSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KiLAjJ+YWiKO/cZsJFmLCEH8r2kiulS+akAiHUDdbmA=;
 b=skyEmr/vTBoxoKs5EMsgKmGys6a2wNSOWI40rhonA7OW8Pk/ZyGsI3DilYzHLJiBbQY7A+cRwFHKEzHWlP7m3xqwZmVP1/lt6p2Rvmkm15OXfuaYTWM2o+Mis8Was9Az2Hx6Nt5KZgqVYNfqiW2AWvBfNXpZ0g5IUtscktXhThtG33kqPMfU9L0b/JwTRgtmbqgMXvDYkcg3MTvk1CvKCIzK/ieyQshpZNOrSKF7Yze397TqoVt4dFjC7dDxOFn53OvAAm3KPKrWYiJIhuPdu83JNdmHFB8qSpWPc7p7KCMZ7F/ntQxDsVkt+1CIQHKB8uEqOzB1xL4kFEXdHg/+5g==
Received: from MW4PR04CA0205.namprd04.prod.outlook.com (2603:10b6:303:86::30)
 by PH7PR12MB5758.namprd12.prod.outlook.com (2603:10b6:510:1d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 19:54:13 +0000
Received: from CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::7a) by MW4PR04CA0205.outlook.office365.com
 (2603:10b6:303:86::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Tue, 15 Nov 2022 19:54:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT021.mail.protection.outlook.com (10.13.175.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.8 via Frontend Transport; Tue, 15 Nov 2022 19:54:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 15 Nov
 2022 11:53:59 -0800
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 15 Nov
 2022 11:53:58 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <bvanassche@acm.org>, <ming.lei@redhat.com>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>,
        <yukuai3@huawei.com>
Subject: [PATCH V3 5/7] null_blk: remove extra space in switch condition
Date:   Tue, 15 Nov 2022 11:52:51 -0800
Message-ID: <20221115195253.182484-6-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20221115195253.182484-1-kch@nvidia.com>
References: <20221115195253.182484-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT021:EE_|PH7PR12MB5758:EE_
X-MS-Office365-Filtering-Correlation-Id: 45edf247-74bb-4cf3-559d-08dac7432b6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s5/IVLoERFua759+t5Y+OUd2aeNdPfMbItdzI7jlokf2uw3G/owtGtW2z/MNdeWxj+uJMhpkn/To7VRweK8sKOI5uJE2yDe7+PmqssHzgKYNcxMkoTbgfufG7gDSg3GJKMpW0AmnzDWzSe3B++xMHZ3tjArFV2bdqIdgK7xQY+yLzuSpmk9BlpquYhNkJ0JaYH339jOZgHY/uLN+rDD5qlewFvGNQCshPXT52w8uNvjtIiqhWVd9UfqZWNiBECUnIXHJCGXPduaXt8t6N62pukdCM3SOaIJ8s+drUvwYIjVyOWic6RRuutZfHFbe/zyLp3aE+pj7NAQgVYfsuNRsR3IjlmtLajSH8u+yIPWcK7iUV4tbCI1ucOudTIzKjjXRUxlV9vGCxoGQFK/nSkob2lz3ZAvIRy4FibqhzEd13RifbJhPn0K+rWxGAWEdWfku8J8FALI6nydi3YilAbtFiVcSXi27xOCfx4dr4vmH6BPXVzg7yfsY/XShe2TQJJpCdcNXY4whb7xQ6bCRpgtL1LpRmzW3PuHveqsAafKz0nmTL6Mxq5OpAksE8xHjLWXknxOhWiGnA0fn/0rvatd6Uw4dHtp4HGBgDKnYnd0GEuKCvB/2EyE50YV9GvrmhVeQ0SjuAAqHRWuL1AU/iCOgz3DmY/6c5wjarQ073LnMwaTjt+80Hd5v8WAuh5FUEYv1O2ybEEJRqzBkCEWQW8aW581KBqmEskCHq5U+OzKmZnQNsGLjDE1cty+52gewno1SJ69gW5eBTHMIr1weTK0QyA==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199015)(36840700001)(40470700004)(46966006)(316002)(110136005)(54906003)(70586007)(478600001)(8676002)(4326008)(5660300002)(41300700001)(2906002)(70206006)(40460700003)(40480700001)(36756003)(82310400005)(36860700001)(356005)(7636003)(8936002)(4744005)(7416002)(83380400001)(186003)(336012)(16526019)(1076003)(82740400003)(47076005)(426003)(6666004)(7696005)(26005)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 19:54:13.0171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45edf247-74bb-4cf3-559d-08dac7432b6e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5758
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The extra space in after switch condition does not follow kernel coding
standards, remove extra space in switch condition end_cmd().

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/block/null_blk/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index db849e6bc475..96b8aca5abda 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -789,7 +789,7 @@ static void end_cmd(struct nullb_cmd *cmd)
 {
 	int queue_mode = cmd->nq->dev->queue_mode;
 
-	switch (queue_mode)  {
+	switch (queue_mode) {
 	case NULL_Q_MQ:
 		blk_mq_end_request(cmd->rq, cmd->error);
 		return;
-- 
2.29.0

