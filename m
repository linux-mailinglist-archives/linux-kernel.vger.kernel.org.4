Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17971714F34
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 20:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjE2SRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 14:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjE2SRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 14:17:51 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01378C9
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 11:17:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZxMQdtDN+BSXOopvkEO8qNQui3egTFvQsDWMvEnoieYB47yoW42MGwCn9NuHS8EIBLrhsI6M+avSpiDU/SiYo0OTELttReArqXJNEcwUKcxtgLDP8A1n7PhZCxtVIpHOuAAvz2FieCzS/AOuBLsmI5g9frcOJOS/SfBxgEkc/GQau/1Vd4IPfbiwNeH0LDfQJZ/ThoGp18GNsi/Df0jEzTp1sToC0r41tn5Es3oRxG1OzabSBbuGJioOlB0NLdVKKWUutzLkT+YrmSZKYqjr4tSSqpkzOigiaKwSaoIbkCNd7VtkxkVzUavs/H+xw/TRRvRXhnsc11nxGhvc3by/lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3BJvQdfYA1o0URRBfoJB7l6gEDn7P6AR+iQjzuCKlow=;
 b=hCWJOi4T9JrRjeYG/QNNoTMPf0YVlTm3u9GYMhffmgXgn+yXZ+uYc8o6fM99huGgsVNlqyQ3rh5veZdjSk0pTlnFDaXTgc67dinZQowywL4D6RBxRg38vgN9NMM+OP410PKWWo7LW4uwKgPvwZkcuc+RjdmycDonkm/F20iMR1Hw93PYXHjd0Gn4hTvT+iW1FmzDav2huimofIPHsuiIqKdA5kxHKGtol3E+qGyK/T9RWfEJ6IHaMgBPnmRKkRTj3d8GWHBBgNmFpU51xQ1Erh5Qp3KyKdRSr09qKZoeM2KHQBVf83CDDiRvs8XsFo/ZFqAS8PuzxOuuF2aZoLnGWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BJvQdfYA1o0URRBfoJB7l6gEDn7P6AR+iQjzuCKlow=;
 b=r3EdJUwQltRcFURGTQB2EjbEMV1IFX4ETbwf4lYPwwQAUADwg7KuIYptZ3efJSezzC30qEEwCjTcVtxFhalGX8bcn/7luwZcDbBC3F7IlXvPHkIR8GDAssao3hhm46dZ2BL1bJ+MvhOvrZO2orXVCbH6FyBjXgcPZFsrRCXgg2funilcw+KfLsldsqu6JtcX8039GqsRvdMvLZZ+miatsDJjgg7twbQQqqQRgBOdY5XsDG8WNvReWwC+2rp8zgfHZjapN3xRl+jqr26LG2KEmQpusrCY5HPMGA2WRzeghVTOe3aHHAdAtIuXbDXhlPnCENpKBcyqN4e1cBanJsSwKw==
Received: from MW4PR03CA0220.namprd03.prod.outlook.com (2603:10b6:303:b9::15)
 by CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Mon, 29 May
 2023 18:17:45 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::d9) by MW4PR03CA0220.outlook.office365.com
 (2603:10b6:303:b9::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22 via Frontend
 Transport; Mon, 29 May 2023 18:17:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.21 via Frontend Transport; Mon, 29 May 2023 18:17:44 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 29 May 2023
 11:17:33 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 29 May
 2023 11:17:33 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Mon, 29 May
 2023 11:17:32 -0700
From:   Feng Liu <feliu@nvidia.com>
To:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Wang <jasowang@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Feng Liu <feliu@nvidia.com>, "Jiri Pirko" <jiri@nvidia.com>
Subject: [PATCH v1] virtio-pci: Improve code style for including header files
Date:   Mon, 29 May 2023 14:17:29 -0400
Message-ID: <20230529181729.15745-1-feliu@nvidia.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT031:EE_|CH2PR12MB4215:EE_
X-MS-Office365-Filtering-Correlation-Id: 501abb9f-d9e6-43fe-87c1-08db6070ffca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S7PgzSfQThRhmjgAqkdQiL9dbqkIvBL3LDqLu8LK6f+hjLQfLj3ZUjQNEOK5ah+oaTcr+Vx50fMEYiwtFHZp0iqhcvlM9sM1s3523WlLudDMz1UgA44kbf3sbCJVh5iPp/ZdarY4gHFiUYnsW5hheMevp0LFn2Lvs2TYtO8uRJHg19isndCNJoWVSzfluFdZyb1lZJ1WaNlSF6YRUMThJMdCM2XEYLxGjqRcPG/fSDjnihqoNJQSVjd48MMu02n9a2aiJpuAMyRnTGeGxaOuOHW1FbKwSimOU+/wEJyrN3vzHtHbzF8r2X9hNZFdJy2q0etslx7BmAEb9jQ2owB2dyaml9Ps2RVXFbAraUHTZic8HLzrGrphNneZNS6bClHBYqmz3lpCHIFLvTU5A8GgKQ4kJvZAvt6tH4/jdynbOZR+uflfZL9ZA9gz+9JwOoFrFsYXXgVX9tRI4MV/W9uA5uC+1+7k5GQaK2yjc632lMeiJ4vQhCFPgOCm9IzkvgoAEuDzEE2fkNBpOt2IkvuDsuney2CRqkPFwmiBAaSWmE4ZLRnXFCfLo8aOuJ1T3aEJzggTawdj4HZCUdK/AlO6eabF0x2Suf33qtpsKUTMpQGesI9MM5mFqJ0Bscp4YuGAn5l64+2MP1lA6q/NrOzCiOaZFcniu5f8+u65hRKN0ns97MqAjwFllCe9SP31AOUw3G7bZ/hqmxG5APQsC3NBreRxKmAk1r5E3XewPg1DrCcGXCzNAexCkpTt2XoMM/Kt
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199021)(46966006)(40470700004)(36840700001)(4744005)(186003)(2906002)(2616005)(54906003)(110136005)(336012)(426003)(478600001)(26005)(1076003)(47076005)(83380400001)(40460700003)(36860700001)(86362001)(7696005)(7636003)(8676002)(82740400003)(41300700001)(8936002)(356005)(40480700001)(6666004)(5660300002)(316002)(70586007)(70206006)(36756003)(82310400005)(107886003)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 18:17:44.5561
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 501abb9f-d9e6-43fe-87c1-08db6070ffca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4215
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix code style related to including header file. Include header files
before declaring macro definitions to avoid conflicts.

Signed-off-by: Feng Liu <feliu@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/virtio/virtio_pci_modern.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index d6bb68ba84e5..b21a489e0086 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -15,9 +15,10 @@
  */
 
 #include <linux/delay.h>
+#include "virtio_pci_common.h"
+
 #define VIRTIO_PCI_NO_LEGACY
 #define VIRTIO_RING_NO_LEGACY
-#include "virtio_pci_common.h"
 
 static u64 vp_get_features(struct virtio_device *vdev)
 {
-- 
2.37.1 (Apple Git-137.1)

