Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9386A60DC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 22:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjB1VCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 16:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjB1VCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 16:02:34 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05AA22DF9;
        Tue, 28 Feb 2023 13:02:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JonRgnHi5SSpTGgMLRhf8mxg+0NnwMTCbN1yrGPdAhXp1kr0bijbUIrvNCISwFz8vSMQ6xLgSdi+Kq8/W2yPwSf49H02hw9TuWq0kifKzWUoyOjL8MlHighv7JmRuoNj6rzr0CZPtUkK4IO11fQPAQTTE2VTXhyqxFhJDB4LyiCWcUiY4emLjPkaVz8a7VQjVd1sn0QKCLyJd95ZkJ2hDkYVMps4bbccoqftU+MwnwuzfT/Tnt/i0ASJeICgNFOAgDZHOQVfOZlL69UeLBCgegzamMG4hKZIi4X6cDLBKhiaIc6HH76IHRTziLaySPresvq3Xu1a++0k6PEdP2y37g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ZZbFSCii/bEzZuwFiGNigWIcDZEsXJksoL1k+8ANIo=;
 b=bamowe3dv2LWTISJqUxVFrWo9s5MTsjqRMEv9y+aJtPeyirBEzUqn6ripbqGZjApHyuaczh1vhynJ5I/lRY85gLoIeAN37bH8LIQZLrxTqNFlGRnWELpI8tbDapxCu/fj1DnxEbB1rQUUGYJU6Ar4VQDU4pE8uMlThUR6b77Wl3t7G1r4LiiYIYKTM3UieyNmtm1wytc0C5qBYUr0JyoV2QgPeuZVXYgyGZaVCSfI0cpyxrH2pddxKhqa1kuqhnIC5Hl3L5nhWRAaYWPZJl7sWDNYtt8iYQRqd9LE7EXyMzfA72kgs028r/tlmtSpjyT/o5zPJmI7bay6vWyDydd1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ZZbFSCii/bEzZuwFiGNigWIcDZEsXJksoL1k+8ANIo=;
 b=3e5oM2R9oA8t9tculmjXxqDZPVEnzDummCihNupr7760/tes2h4z0YXSTsJOAQlZeGcT9Nbmkc4z+BdGvdFSYJ+pwEy500lf2nIOUaMbPb6wQPyIuH8QX4fMahiywBUyAY6k5pp0R1eeMJJ5CVP1LV+WMd84Krzne1TCmgB5rzU=
Received: from DM5PR07CA0087.namprd07.prod.outlook.com (2603:10b6:4:ae::16) by
 IA0PR12MB8424.namprd12.prod.outlook.com (2603:10b6:208:40c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Tue, 28 Feb
 2023 21:02:27 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::88) by DM5PR07CA0087.outlook.office365.com
 (2603:10b6:4:ae::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30 via Frontend
 Transport; Tue, 28 Feb 2023 21:02:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.17 via Frontend Transport; Tue, 28 Feb 2023 21:02:27 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Feb
 2023 15:02:22 -0600
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 28 Feb 2023 15:02:22 -0600
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <michal.simek@amd.com>, <andersson@kernel.org>,
        <mathieu.poirier@linaro.org>, <jaswinder.singh@linaro.org>,
        <ben.levinsky@amd.com>, <shubhrajyoti.datta@amd.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>,
        Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH v4 2/5] mailbox: zynqmp: fix IPI isr handling
Date:   Tue, 28 Feb 2023 13:02:13 -0800
Message-ID: <20230228210216.447373-3-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230228210216.447373-1-tanmay.shah@amd.com>
References: <20230228210216.447373-1-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT018:EE_|IA0PR12MB8424:EE_
X-MS-Office365-Filtering-Correlation-Id: 0de68b8c-f6a0-426c-f4b7-08db19cf192b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rkaM2PWXt2rnZuGz2PuApCq3ImCZO+xx2FIQoGedOVhfCT/0diTjbAj5WVllDBgHKYX3eq+3szf8SVZh2GzYr+iCtrkYl44CeVH18C01izIQV2/idE+0Rb+QdMaaTkjvGKfktLJx23GIdB7+ZkSuxpHXJ1ccOq3rcnPM8eK2SPorW0piyQ+LZRC0c8I77m7akgEa63obZiynxVI8FoN23lJV2ciS09dQ9QsggWJooho/B9DVEQIXanOyYIcu6saYcJUOqCgz3ZBbiD2drzElccaHkPbYVuK2WL5TE0Bg9uzu7y5iOE5x9MUrr3+KMT6UWpYjHXaTGYDXfPdVc95UWH1nc9WReU82SgSPrf+/Btj2lXyLPyjQ0lDxSuTMgDjkZ9H8tN7Pw38+EwOXw1H8tpU+IA0vKG0+/ZzOU+JeVgZxYxaUScKMYwHzkGXshduXB+jcFuQIPhCBGL0pCLMD7nJ28iCVdvPXHBeBM3YyebWQYom1LLYw826qLa1XYJBTuswpv4+YEIzSLiTTC0BnZR8yIDL1rvToSyCpaDBeDMKQqzGaamU9pQi5dADMRIDf7PxcdFf+XgENybLzNPduSPaArApze4+lPzsIAnwEuE40G6rT9g3pQdYnND5pPBBSyVxo9E6vVlldxwo9Z9tbgOq0rzy/0kWabc+la5/Ci6KL+kNNK8nSOXjrWykPNjj8Q+JfLekVMzPF2oqcUeq5zSv8a5eci8yUtavfS732Ha4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199018)(40470700004)(36840700001)(46966006)(356005)(36860700001)(81166007)(82740400003)(86362001)(36756003)(2906002)(44832011)(15650500001)(40480700001)(8676002)(41300700001)(5660300002)(70206006)(8936002)(4326008)(70586007)(82310400005)(40460700003)(1076003)(2616005)(336012)(47076005)(426003)(110136005)(26005)(186003)(83380400001)(6636002)(478600001)(54906003)(316002)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 21:02:27.3511
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0de68b8c-f6a0-426c-f4b7-08db19cf192b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8424
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multiple IPI channels are mapped to same interrupt handler.
Current isr implementation handles only one channel per isr.
Fix this behavior by checking isr status bit of all child
mailbox nodes.

Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---
 drivers/mailbox/zynqmp-ipi-mailbox.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
index e287ed7a92ce..b1498f6f06e1 100644
--- a/drivers/mailbox/zynqmp-ipi-mailbox.c
+++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
@@ -152,7 +152,7 @@ static irqreturn_t zynqmp_ipi_interrupt(int irq, void *data)
 	struct zynqmp_ipi_message *msg;
 	u64 arg0, arg3;
 	struct arm_smccc_res res;
-	int ret, i;
+	int ret, i, status = IRQ_NONE;
 
 	(void)irq;
 	arg0 = SMC_IPI_MAILBOX_STATUS_ENQUIRY;
@@ -170,11 +170,11 @@ static irqreturn_t zynqmp_ipi_interrupt(int irq, void *data)
 				memcpy_fromio(msg->data, mchan->req_buf,
 					      msg->len);
 				mbox_chan_received_data(chan, (void *)msg);
-				return IRQ_HANDLED;
+				status = IRQ_HANDLED;
 			}
 		}
 	}
-	return IRQ_NONE;
+	return status;
 }
 
 /**
-- 
2.25.1

