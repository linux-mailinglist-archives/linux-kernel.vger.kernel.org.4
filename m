Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F6066E222
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 16:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjAQP2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 10:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjAQP1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 10:27:43 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB2AC164
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 07:27:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PlwxAtnYQcdbJ9+Hgb8ZIrwiwgMgXPwBCho5M2jv9rmA3WOAuXW5EjRSlLxVZp7jb0C0ptgaSyTpQrWrg8HL0/Eqi/RIXEURSjhl+FIWpKSWnZ5jyoBbQjE0QEj51lU5X8pNqxPoynuuwXeIBkTRNqyR47dDhA0VTLzagRoTVfHXyWFxPf/p6g+Ti9UJrngmkSjJPVWDWLQc2aU0w36KGc3wJ5dbiay2sR14hffgxB0YSU0U9LQxP1Fxsr2+HOqBmRK7fC0i5HujmE6alxqi7B1wtZls/CtdO6o948tq1PstPj+35ur9JiqG7Isu516ooU0u5CwPaTTO/cMVhfaO3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZPAs/yGIwepBy+iuJ+qfEB7RUhBqfg3/uviqfPLLGc=;
 b=IkEcYu7O6bpoGid3P4CbQaXImPNJ0kZW8F0WCgusiT8wqK3V2n+0AnGZ+tsNS5D0dXnay+DHL96rogSVO78Io64uLhGvSFr/hJfNhlYVcOsLsxzTSxcvzY3sNJG//I4w5J6YJEd08Y78p3ZhsQsYgZxf5ALCPH+btKM+fmMaIB+tikr7NrUk3qp9v060sIsVMLuBcQtCG7Ho6knjO0I3Au6dMyw3ArJmwZ1lGSw2QYkcmA//XE2my0e0eEHvhXpwV2GA2k/5VKC+jqYRm9mZMG5AdQDW7OojARQF7BCdDkxlhERL9QP7oIOxYce5FtkTwOj+VVY8s7494ZaLFmXO5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZPAs/yGIwepBy+iuJ+qfEB7RUhBqfg3/uviqfPLLGc=;
 b=FxHbCHg1evjwoxXnD7kVKXyIp5xLfV0Ci8nogHB4QAOh0cUEP8HBCqGvXwlwg8s5HK1DePidjQ+/9v3Lddeb2N0voy+nexCFbsKaIx+mNi4tWCgGU0ocJuDNSyWDsrCPZBAsU1ol0TTQtNJlDYPap96G3fA2q8hCUJQXlFq5a1SKRaDd27M9xZMEBkZyL8hRZCq7p4dQDXCrzmY0A1JY1N/72NKutBETnj7Wl2ELJnBFgdboOFk1Wez/UZlKytOoc7ldLAZ6kAnuB8Qh/duqud+6TgpRneNiVdliHB6+P/enm87kRikr6QhrwjR31wIEvDQZuhfcOm68FQX1hvBAyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB8196.namprd12.prod.outlook.com (2603:10b6:930:78::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 15:27:39 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.6002.013; Tue, 17 Jan 2023
 15:27:39 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kevin Tian <kevin.tian@intel.com>, Kalle Valo <kvalo@kernel.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        Marc Zyngier <maz@kernel.org>,
        Omri Barazi <obarazi@nvidia.com>, linux-kernel@vger.kernel.org
Subject: [PATCH rc] genirq/msi: Free the fwnode created by msi_create_device_irq_domain()
Date:   Tue, 17 Jan 2023 11:27:37 -0400
Message-Id: <0-v1-9195b42af947+89-msi_leak_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0037.namprd16.prod.outlook.com
 (2603:10b6:208:234::6) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB8196:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ff6c9aa-f459-4f76-3638-08daf89f5e2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oj8CTbInfIwP2O0+/Y89i7rhgTpPLYfPd9+7TMomekrSp3RZGENB5nagxflGkUlpts/UhWbbEe5ZW4F5cd/4lEMQzVJ5C6EVL9G7XXAF6/5Q0kmwiKRq+cpaM0zspitao5i3ZNx8j6e1MnokgZjbxxFmjTlKT17Yq9eIVlzxxTfER1PxsAFZ+GoUcZAhkAlYqx0tDek0W61GfHrMTpFzAfbqDgJOMKumztss1OETJf0t2v9TwcToaH1P2soOlpyh7JRPjU9ifCk02ZC5mpzCQdxR+YdEKp3ZWCj1DpX21XZ46qyOfj0t/PbXVVkZY2+Y3IbBXcqP+0xm5ENCUBQ3YfQ4xpR7ioy+sM8HgLIgkV+4ZTbIDiTqnqn2hVmsQzLlvtqiGtVmqan+eCx1ywMZm9mj5wAJfCj8mYgWwyEfPdzGPOu+ifuAhyQ5zEFwBrXVBdN1pC6YCC8sWXm1vvfiNm0ePSnjABWznAiZo4HZmXF8r+Czbu/UXyIAl1GkhN/fOzTeIZDqgd5GEs4s2exjTiVdQ1PV+5MkqGuyRJ82H6BhUNerh04BHdYbXby0K/tPmE0jjXhND6afQrteORYqTyGbcWjW4I+c0aCe6TEe8L20novRq7Hn9w9pzateXYSJonzW4OUxheEB0zS9avImadAoqahiTOYocIzwebHkCBlWclrr6h3zmJsqWQc/eOuo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(451199015)(36756003)(86362001)(8936002)(8676002)(6916009)(4326008)(66476007)(66556008)(66946007)(2906002)(5660300002)(38100700002)(83380400001)(478600001)(6486002)(316002)(54906003)(41300700001)(2616005)(26005)(6512007)(186003)(6506007)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ndzavYYzcV8Ir5W3MOCWftu8aET0U3vvq7X14acLWZbHnW3RxUekC36IFKC9?=
 =?us-ascii?Q?QIViEb1xqF7bw9O28GPhalVTJoHSKEJyW7ELbB1Dzlu8oFjm7lXmOR8JzbYn?=
 =?us-ascii?Q?eozlV1IuZBFEnPOzd2wkARCI3lf1I3RJp3y7yMrVyUFo5vFhj6Q3xKwSgcdn?=
 =?us-ascii?Q?dbMA0H4rg8enVxs6thHp7yWW/B/PnLEk8e4mzDb7+7eQrgveMVrmipGdj2pl?=
 =?us-ascii?Q?LIS8AYZ44UPvHQzkqhM6iZtUDY25EWX6h3kFxVebxR4224hgAL1xnLjtZhpA?=
 =?us-ascii?Q?JKfoUBxCZSm9BnfcgIGzfPza+C6cOMwMB5aDfV6+0yfPgS4ofon61i4ZMU7X?=
 =?us-ascii?Q?puSVbgu3UMSJKlS1EQB5X0dnCU9k7zfxRV2ZraOJCRtvYxkE9iT5IyNfiEBd?=
 =?us-ascii?Q?Ab+amCS6Sa6oKVrWnt0LLoMVDL+q5ec+hVGc6erXE7uPAlgcLGjluLpRp6F1?=
 =?us-ascii?Q?6ba791s2oTKM3IokIhjHd2Ns7QQBrTfcMAqhdTISMYiWFNq4quS3pX02xpgr?=
 =?us-ascii?Q?EpqaOsk5Q2hVjTKKWkMePMMQgiZmWNwsugfJUw6MLrGJ76AAftYzQ1V7U7qO?=
 =?us-ascii?Q?QoPdn1HvOa2bDr+K5+saryzJ9gLwUtttmdVqlJPvtk3RFom8X+ScRPyd1vja?=
 =?us-ascii?Q?nTqy6jlCcLxTxW7VlgJd+462FLRIIxGzXPtojp/Q7leYJL9q+yyRhDhd+sx5?=
 =?us-ascii?Q?dFI8bquvALBKpJge9y3exLXwGhOdOJzlf61I8dLTjR0fQOUcllG9LXorHDbH?=
 =?us-ascii?Q?qx2dyh7YD59zUBjij81zGEnfp63Ohwja0FPPg0tT1OqXQW9/zWQ+TTD/OYcr?=
 =?us-ascii?Q?cOf9tT+8/rd2ANIqlor6OS09APDqvvKpRP3GbPB1uQpN9IO5YCeru52djosN?=
 =?us-ascii?Q?Qol15i011O4mLxgW7mtPh//s+4g/RMNcuocxR6+0WqAheNgmPWToUcSNU5St?=
 =?us-ascii?Q?2CJrvU8JcbQqdhZXP7CxYTI1Oivoth5MRS1T7934hXeeLpOXWi0JrPJ1LzxO?=
 =?us-ascii?Q?5a2GrZs9Djg3fltVeHxs2xvn1H8phuss1ZB0PxY2k1Xh9YRMeDBugYydxUmj?=
 =?us-ascii?Q?bwZqThXEyKVoUJxzXu6jQr9l8dZ2IT05lElSSXJaVEnwczuvYdWfykI0NsBq?=
 =?us-ascii?Q?SSxjE5PmFaH9C5LD9r+HTTgoxkazHw/wxczLXMi4HxSKLCLAEz5c678IMABg?=
 =?us-ascii?Q?8jddDZtKlZFvpIfqSxOQng5qAuuRFp1cQqHTNUzxYkSzH8wACyvxCJpIjfJJ?=
 =?us-ascii?Q?4lGeno/+coHwPfvSWJH5YlDF2cC6QrhVDyvG/6PnZun1u/7GjDfS2TE7546S?=
 =?us-ascii?Q?kEvJNwIMDbZNe3DpZmGa14k5iFaFOjyLKxWwTVcrxoV7rXxwoORYYeuWzWFg?=
 =?us-ascii?Q?QtEdS/6nKV/5XCSz0uqyIaMega/9y4+vJtlAYKRA2I35pyv9K3Zvif38f0bi?=
 =?us-ascii?Q?tLfscvZwo2ob001t4aJo3vYFQgZFs/1eqkj7G36Ebg0EYAgupnp85XTU3skP?=
 =?us-ascii?Q?hDNK5H8V3Z2qf+n3EEi7hODY/5b5DeBLkRUvTcbKxb83mPy8jaaKKtfdvQGH?=
 =?us-ascii?Q?MUy+1pu1F8YT3KUEMPhwgqS4oBmlD01Izn0ml9iJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff6c9aa-f459-4f76-3638-08daf89f5e2d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 15:27:39.1262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cvM/b1Iz0aUEycabicNEJnqzNDtSrGFHDnnKJkpr3fkH3xIkjwJDnuuo7Nm2FVdj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8196
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

msi_create_device_irq_domain creates a fwnode for the new domain, but it
is never freed. kmemleak reports:

unreferenced object 0xffff888120ba9a00 (size 96):
  comm "systemd-modules", pid 221, jiffies 4294893411 (age 635.732s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 e0 19 8b 83 ff ff ff ff  ................
    00 00 00 00 00 00 00 00 18 9a ba 20 81 88 ff ff  ........... ....
  backtrace:
    [<00000000bcb7f3b1>] kmalloc_trace+0x27/0x110
    [<000000008cdbc98d>] __irq_domain_alloc_fwnode+0x51/0x2b0
    [<00000000c57acf9d>] msi_create_device_irq_domain+0x283/0x670
    [<000000009b567982>] __pci_enable_msix_range+0x49e/0xdb0
    [<0000000077cc1445>] pci_alloc_irq_vectors_affinity+0x11f/0x1c0
    [<00000000532e9ef5>] mlx5_irq_table_create+0x24c/0x940 [mlx5_core]
    [<00000000fabd2b80>] mlx5_load+0x1fa/0x680 [mlx5_core]
    [<000000006bb22ae4>] mlx5_init_one+0x485/0x670 [mlx5_core]
    [<00000000eaa5e1ad>] probe_one+0x4c2/0x720 [mlx5_core]
    [<00000000df8efb43>] local_pci_probe+0xd6/0x170
    [<0000000085cb9924>] pci_device_probe+0x231/0x6e0
    [<000000002671d86e>] really_probe+0x1cf/0xaa0
    [<000000002aeba218>] __driver_probe_device+0x18f/0x470
    [<000000002aec9527>] driver_probe_device+0x49/0x120
    [<000000005f45a989>] __driver_attach+0x1ff/0x4a0
    [<0000000000dcaab2>] bus_for_each_dev+0x11e/0x1a0

Use the proper free operation for the fwnode so the name is freed during
error unwind of msi_create_device_irq_domain() and free the fwnode in
msi_remove_device_irq_domain() if it was automatically allocated.

Fixes: 27a6dea3ebaa ("genirq/msi: Provide msi_create/free_device_irq_domain()")
Reported-by: Omri Barazi <obarazi@nvidia.com>
Tested-by: Kalle Valo <kvalo@kernel.org>
Tested-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 kernel/irq/msi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 955267bbc2be63..783a3e6a0b1075 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -1000,7 +1000,7 @@ bool msi_create_device_irq_domain(struct device *dev, unsigned int domid,
 fail:
 	msi_unlock_descs(dev);
 free_fwnode:
-	kfree(fwnode);
+	irq_domain_free_fwnode(fwnode);
 free_bundle:
 	kfree(bundle);
 	return false;
@@ -1013,6 +1013,7 @@ bool msi_create_device_irq_domain(struct device *dev, unsigned int domid,
  */
 void msi_remove_device_irq_domain(struct device *dev, unsigned int domid)
 {
+	struct fwnode_handle *fwnode = NULL;
 	struct msi_domain_info *info;
 	struct irq_domain *domain;
 
@@ -1025,7 +1026,10 @@ void msi_remove_device_irq_domain(struct device *dev, unsigned int domid)
 
 	dev->msi.data->__domains[domid].domain = NULL;
 	info = domain->host_data;
+	if (irq_domain_is_msi_device(domain))
+		fwnode = domain->fwnode;
 	irq_domain_remove(domain);
+	irq_domain_free_fwnode(fwnode);
 	kfree(container_of(info, struct msi_domain_template, info));
 
 unlock:

base-commit: 5dc4c995db9eb45f6373a956eb1f69460e69e6d4
-- 
2.39.0

