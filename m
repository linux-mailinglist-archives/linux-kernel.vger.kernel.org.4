Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7439C68035F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 01:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235132AbjA3A5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 19:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjA3A5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 19:57:44 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541FE1D911
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 16:57:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LElveU7e3i5yhSD/Hs3TlW1M3BqL0xg8ScYW5g+qh0MsvQwzohd1rx+AwdIgK0rkBgaylIugIaa4ta3ADWb+jJOqQIN4kgROGA7f5/1gfwuw2LA6kbm7JR6cY2GZ17JP59uR3LGA1SBVBVX5FuJ1n+ilY655cNA4yjILNMMndFDwmyztX7Rl+mMw6zr1W5YjeMavEvKZmtg4Ti3Ak2iXT07Tr87hQ1y62D3eH/YvdGia+D3MjOlpZ0TyxvgW86mUZjvtsY4bvDUGxT1dT7hTDT07E/9j5WVTu9pC6bFE6SKJOaaKd90NMouJnEUefh42XpOeGuZVVZnNMm76xkpcfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLBocn6nVTG4UqRnB8xr9hlNDe+ORbxLVSqvgIB6wCI=;
 b=aQVoHOuXnh7gKdcg+G2NOWTM7fO6jLlzEt07p0xyBSHwdhELmQUs2X7t01FU1eVo5J6M8mLNAabXw/inqi04Jrf540qeVP5OCEnXrv03ZJydkqfU8NqcVSH9B0YeYgXNtinIlVYcY3EkjmYtE4psh1UCGId2r1fudhUtyZP5LAzTqGfrdwdhJaN8mVx1t400uk8czAgXTUsSgSPl0fwrrSYGTM8xIsPnCOZPcxaIa9w+M/Q6lIfoUBOnD19db6+f4yYJYMtZ/Ft96uecYJW07Fa6OA/7YK783tfDMOkm6WyYvyAiDP0WxHnRymgff1Rs0dRRnDveNV8pRg85XXGAug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLBocn6nVTG4UqRnB8xr9hlNDe+ORbxLVSqvgIB6wCI=;
 b=Urps1r54BPSfXSZUfh2TbkO502jNo8/BbqOxQo084Aa1jb627Qh2Tfm44/bYKjNIuxbcclkxWTbhYkVywY8Qs5SrEp0Bv462nq7LRNkTEsmT3X5iizEOIl2ohUy9TrlQt8DIS8DkLqkGGVy/puu5Dbgkne5OCcF90BlcpQDg8A2VSmlOTJrXioojViiWua/AeD67rirrPJoO1dNdK17I37+naklCZLqgQ1dTh6Ce5zyMqhpcRg0FxmV92nWewBIj5nSwkdU4ZSntLZe8hTFCc+UKPExB24EFn1Gb/7pOmLF0afCwRak/Hz0vNBtwFDU5xnz65hOcnd3SCl9Pm9hw2A==
Received: from MW2PR16CA0063.namprd16.prod.outlook.com (2603:10b6:907:1::40)
 by MW3PR12MB4426.namprd12.prod.outlook.com (2603:10b6:303:58::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.33; Mon, 30 Jan
 2023 00:57:38 +0000
Received: from CO1NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::6e) by MW2PR16CA0063.outlook.office365.com
 (2603:10b6:907:1::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36 via Frontend
 Transport; Mon, 30 Jan 2023 00:57:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT079.mail.protection.outlook.com (10.13.175.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.22 via Frontend Transport; Mon, 30 Jan 2023 00:57:38 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 29 Jan
 2023 16:57:28 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 29 Jan
 2023 16:57:28 -0800
Received: from SDONTHINENI-DESKTOP.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Sun, 29 Jan 2023 16:57:28 -0800
From:   Shanker Donthineni <sdonthineni@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Michael Walle <michael@walle.cc>
CC:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/5] genirq: Allocate IRQ descriptors at boot time for !SPARSEIRQ
Date:   Sun, 29 Jan 2023 18:57:22 -0600
Message-ID: <20230130005725.3517597-3-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230130005725.3517597-1-sdonthineni@nvidia.com>
References: <20230130005725.3517597-1-sdonthineni@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT079:EE_|MW3PR12MB4426:EE_
X-MS-Office365-Filtering-Correlation-Id: e61e8bca-fa0b-4812-91c1-08db025cfb72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1tTwnXD4mQGC8mDY44lJnFGmjZied5jnJCYRUgwTCUoKacsWUWtveY6mrJyqvTgP2pR/VMsBSxShTQbVeZDY/C5LZ927qSHEKgiFxot3f9ihH69ycjLzJzF0LVk9q11mMVDpC6nTU/AUodXx79VqDTEqnu0SWZ+6qPntbWW18mFLRxNtBpZhu0VWW+msppZgyOJu8rkrZ2ICVS3fTt15iHT62sJeQscAyVZRzeaV7Oo1IUeAvIaP6CzOi9j8KvnTAclsQFfUOJq/OJCE2rKLCKQGPcOCxO4F3T/V15OwGCm4CFNJdPAsu0jLbwfzYtPsIrFUsk8piF4us/tCiLWWu9UWJrJwy5ezFn3Ev/GJhFQygU6rt3uPT0G9ozJi6xxSYsbLVfgUZz4fNg1v9FcmN2KMaCRPqkA+gWCX5wzOoTfpGPxe9p4ZZdG5N/lj7wsm5mg0ofpvJMZutYDKcm+JNYNVUI3jOnJdV1RD2sfOTyOH6VY2tPgDFeKrYk45Kbo/5+/PXmUpsOtpnrPmhwQ1LVgIosWb0TenOhojITq0KXDY2YF8m/ynLos3wTr6H5jO/bKmJ7j61/HgE6FESD4NgCaLKKmDi/97KAXYzlTtvhjOrlcYC08+92WBpEcqu6pkbwcCHf2F8M6ea76t9G0TR9CRJYaxqOJdtxge+syUVk0Vys+ICGVKTyEvFN1xliJp
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199018)(36840700001)(40470700004)(46966006)(82310400005)(2906002)(7696005)(6666004)(478600001)(110136005)(54906003)(41300700001)(86362001)(36756003)(356005)(2616005)(336012)(47076005)(1076003)(426003)(4326008)(8676002)(70206006)(70586007)(316002)(40460700003)(8936002)(5660300002)(40480700001)(36860700001)(186003)(82740400003)(26005)(83380400001)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 00:57:38.0331
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e61e8bca-fa0b-4812-91c1-08db025cfb72
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4426
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the use of statically allocated arrays for IRQ descriptors.
Instead, allocate the necessary NR_IRQ descriptors during the boot
time in early_irq_init().

Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
---
 kernel/irq/irqdesc.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 21a968bc468b..a4911f7ebb07 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -556,27 +556,24 @@ int __init early_irq_init(void)
 
 #else /* !CONFIG_SPARSE_IRQ */
 
-struct irq_desc irq_desc[NR_IRQS] __cacheline_aligned_in_smp = {
-	[0 ... NR_IRQS-1] = {
-		.handle_irq	= handle_bad_irq,
-		.depth		= 1,
-		.lock		= __RAW_SPIN_LOCK_UNLOCKED(irq_desc->lock),
-	}
-};
+static struct irq_desc *irq_descs;
 
 int __init early_irq_init(void)
 {
-	int count, i, node = first_online_node;
+	int i, node = first_online_node;
 	struct irq_desc *desc;
 
 	init_irq_default_affinity();
 
 	printk(KERN_INFO "NR_IRQS: %d\n", NR_IRQS);
 
-	desc = irq_desc;
-	count = ARRAY_SIZE(irq_desc);
+	desc = kmalloc_array(NR_IRQS, sizeof(*desc), GFP_KERNEL | __GFP_ZERO);
+	if (desc == NULL)
+		return -ENOMEM;
+
+	irq_descs = desc;
 
-	for (i = 0; i < count; i++) {
+	for (i = 0; i < NR_IRQS; i++) {
 		desc[i].kstat_irqs = alloc_percpu(unsigned int);
 		alloc_masks(&desc[i], node);
 		raw_spin_lock_init(&desc[i].lock);
@@ -593,7 +590,7 @@ int __init early_irq_init(void)
 
 struct irq_desc *irq_to_desc(unsigned int irq)
 {
-	return (irq < NR_IRQS) ? irq_desc + irq : NULL;
+	return (irq < NR_IRQS) ? irq_descs + irq : NULL;
 }
 EXPORT_SYMBOL(irq_to_desc);
 
-- 
2.25.1

