Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB14E66E7C0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 21:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235322AbjAQUhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 15:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233654AbjAQUaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 15:30:06 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2053.outbound.protection.outlook.com [40.107.95.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AE43D92B
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 11:16:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6nGSyF2w15i029Ic2Qg0CQlGXIPPZqS1IZAGKpZKwWDY9TnA3oocyj8WgNr5GYWRvzTIXg2rCG1ypj2MsEeBkJoZhhUrHn3HU/UJRixDTkx/Tuq1jTIsINpNqyHWjjk+73QLjjnEOZX9YIXeMeN4BTD1xItVrY8fs5Yj4enySSnOT+Kex1hSwx1jEUMbBRLL7EXGNro4PeUyJ1ZaY90GAso5mazKIiBIWTJ3nkumujtLBrBunS7xVF3+SEI8pk+BVOIMxuHE2LkPSjNhdDgYWpfYGrxHoTMtvgBdyMF6GveDFFwhBct1F9BQefWTztlA+PoA7NyIkw6Nn5V5qVknA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mEeQVgx9i7tusaruuuAqih8lAAn9a/2Em5F2kit5aoo=;
 b=U5bX6YYEeLEobB1DmYo0pOnIEcsvgmdxRSLAHRWt+aBVd0H1yghOPAqY00eoOWs2vO/bI6HZM6XcV912K5u+HVwYul6WJrP3adpAm5hfGggLrVEUIe4ojST8gggNhHQABncUaImpkg/Cozfxilt84ADJ0iP7Sh1CvyEmXxCk4y+QcDzmi157BZ2k12kpy8bXvmY893a16iWlqhVNAmy7dbggyjK4GEarsHGmvsny/xKx8HFoaeP8X4JUKIDOYKJVvhOLW17Y49E8Lv5ZxsyptpErxLOP4FcM2Ema1s8IRxoVzjcXOAhPWXrPt2rXrduBgWbL13NEiNd9HlkBkkaWdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEeQVgx9i7tusaruuuAqih8lAAn9a/2Em5F2kit5aoo=;
 b=AGItkbD4Uu//d/kOdARc3Yat+upM7XrHWdD3HbR/tpTFRjFfMgwD9Gu5E+3UBVBJtopA6Mm+wxgSiDupIrdw1FDst9UFFGlVFlspdruHSXgPomrZn7n0uh0xzZG1pAVW+gShdmzU5iHF0FuvAIv4wT+HiynuWaGR65pnhRGF5GlW8kUFwxpfjpTcFsHy27afw1iZhAhanp3Ktq500WxbmZ/ya1UYOEJhcifatOBlWAKFjoMHaZapl4kNIsUl/Rs2eRymi4LdNcyvJNItsFQavW5RRy1Dib8Y6GUFu6QE9eIzjtStYh8CbPkcO1BsKTZVlIsGnLzgnTa2k4UVFzuLVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB8328.namprd12.prod.outlook.com (2603:10b6:208:3dd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.21; Tue, 17 Jan
 2023 19:16:19 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.6002.013; Tue, 17 Jan 2023
 19:16:19 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Cc:     Kevin Tian <kevin.tian@intel.com>, Kalle Valo <kvalo@kernel.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        Marc Zyngier <maz@kernel.org>, Omri Barazi <obarazi@nvidia.com>
Subject: [PATCH rc v2] genirq/msi: Free the fwnode created by msi_create_device_irq_domain()
Date:   Tue, 17 Jan 2023 15:16:17 -0400
Message-Id: <0-v2-24af6665e2da+c9-msi_leak_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0168.namprd03.prod.outlook.com
 (2603:10b6:208:32f::6) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB8328:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d5b05bc-5111-429d-099f-08daf8bf5005
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T/qnSsAfLo9wSvh/iovosCcg55dE54Y/sIuuEGufimSushQDQ/jfITLp/CKVEOTri3VQIUpg9a9bEboloaRPflmDYLVLuPhq4dOavBgbDTPei/AkxPnGfltnh6JZlDRa1oJC7/NCL3lK5KmfQzeUvSVi3QjnLRaDMo+S45fbkJ0APHvu04BDi3Wu50YoQLnUgZ90+TEgxPa1iYjEbY1SZJJQTZ6YRnMMFAQpW/goaQ9yZYIpivDJQ/9EEyjZrzavSoAg7TH6wTPQ9LoL0FKq5TO4iGnFaAMVDpeLIDYAzx0Hfa/SN6PwAWST7XOp9lr5J6giWPLeM2mWgPxDut5utrtpkhsnDJagG0LeSDMkpUiRP8HhWEAnOUjcJKpUW+Jn26+icriFtU/85bqNHgykor4uYRyci57AFvQBDIAmdALOP6xSL1Zfl0SrJpGXo/nmdUvO7G/w7rQ6aIPQny8lUibxlim9eCV/M5DLplgs+bD0QiThXX9w7Rk/K5hXhpobpScVEziwAB3lCT4dhWmJsyejSv82XHFDgNSN7R9c597fsp3aElLlP1EDwJu/Rqwn6X5sGBcU+tpp40h+L73hzrMEoPGGNSbWWvoykF547XjxzBx27pD/+/xXeQ3DOa9MyCkmlf6wQt970LdO7+9DQD0NXkpEIqPrrsGHI80bFAjxCP9LgUKyRs6IVkixhuobVV53LC3mPRwVQL8PFmM1zt8d/2AzYKsVvseDMObKCM9gNn1OJI4jcCsyIv8jSUglHotQ+QANO0HiJCxvUSQ/PQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(396003)(136003)(366004)(346002)(451199015)(54906003)(316002)(41300700001)(66476007)(36756003)(8676002)(83380400001)(6916009)(66556008)(4326008)(86362001)(66946007)(38100700002)(107886003)(478600001)(966005)(6486002)(26005)(2616005)(6512007)(6506007)(186003)(2906002)(8936002)(5660300002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BTH7DiHfmYj52GW09+80tXdBEukFWrbUZxq12p4tHrPlzvyBJJQt3o3WNC2z?=
 =?us-ascii?Q?aXRnRanOULlBxda4Uyrfd5yhcFY0aP2Yg/98TZYIo50vDxjCOwMwhqjt1/MJ?=
 =?us-ascii?Q?dYzGWdS21hIhHNzIGfrejiqi3Pa29aZto2gjkhA4o4ruFlt3QLjf+1JWhn1V?=
 =?us-ascii?Q?t94BqdzIV9+ob15KqlTfgK1KkhvtwEOtzaDi7O1KpkE3gG600qmBmR5Qxct/?=
 =?us-ascii?Q?pBGUFCSepvTG3i7UaUvpkk1mGe+wNLUewkCONxv4P1fpeMabsXHWIVREBY85?=
 =?us-ascii?Q?zQNp1tGJfdcdczLk33mQTP/o18yIPlLVCDC2FLDvmtu+/HWThXIj2JucnpKj?=
 =?us-ascii?Q?SQRaDoZvvso76q1T7m3HLrbmA/XLNO6V8BkdEzfgExVyICkif5lWouz8O8bW?=
 =?us-ascii?Q?9jCfl45+zjvlnQD5ejmFn0MFNeaYfKBOwtj/Ut7VDYFWYZvJzmxjXoij7pdB?=
 =?us-ascii?Q?7QwjBrKHKL8KoGTZ+jCts6+AisrU6GxYrrGL+akR8nMQCEa1ub1oVo+vhUDa?=
 =?us-ascii?Q?DpZYW6BIblNQUAoBhQwBWdw/oPT3pR4dc7O1ogLWlQ63V09x1CCXZI1oW9d7?=
 =?us-ascii?Q?/EcWrYtyq7EIIWzKtk5ur3jaAaWpqPgWAAESj0WsU00SjoUPTEj5T/u0n7j/?=
 =?us-ascii?Q?E28OTftBoNuLpQgPfCGz7HPE6nY46OrGbet5/ELdA6qugGAmBA/mmb9jThC/?=
 =?us-ascii?Q?MeEuHAy3FSLX8tSbnM51KklqfcTp1TWFbRo2Q9zUucbdIt2VPQbmcKeo9kCr?=
 =?us-ascii?Q?y2a2KRfuam76LPKYJ0Dp6fphuIYQYz3oGeU4cdGAK+SmuiSVL6o4qEBSXj9G?=
 =?us-ascii?Q?V85jb5DbZztrw7Tho+7U/+XeFzfKkfqwBYKJYjpXiPsKL8ETpzEJFKLug22J?=
 =?us-ascii?Q?UDFxswP1cVPm2kNM0K/vmHe+AAalZ1H8CAnqz+e1aJLNfuG6m1bF6lw2Fko5?=
 =?us-ascii?Q?wqa7Nsfwr/4Scn5ZSaRENIn+EU8NyJ2EKawyEpXuIvtGjqluI3k2HD6VavUd?=
 =?us-ascii?Q?Dkj/IdQAHTIiNxJRy8D5gM6lYf7P4i++eTUI2MzHyNPZbzZtZ816rCXOqY8U?=
 =?us-ascii?Q?C+L6935exqhcJSaHzx1BX4skOO2rxQy9i0Mb17vfvOZdEnkwz+dPdAqEwx1u?=
 =?us-ascii?Q?+vEYmug71n55suxgIxFlCOUy7me/er7Yq5zFNs/lQp8/IclASCeAbJMK5aHH?=
 =?us-ascii?Q?zPyGU82h6jco4+zNLTNojS6jqNzR6IKpxlR67rdRjEbjkyRe1/uM/6yDaNIc?=
 =?us-ascii?Q?P52Y3xxTm8DnW58y9+//EG6pZvvz4qrKuZ/E3iw/2Rgt9FpUXkJkH4N+t5i9?=
 =?us-ascii?Q?2OUJmS8hc4EA3zr9ropC5EPROzM6zTfDlJEO6HNant7LJCPLE60IB67djoEr?=
 =?us-ascii?Q?sgms8gCPXOfAVrL6ltTZ87GoGhGGom2Tz+bE6BTwAJFZ7vOHx1/+HLoa4ov2?=
 =?us-ascii?Q?9VzFcRn0AR79/6PGZ+cjcvWTe0SygeBGk9vZJKlZ3Mv1G4mi/1wkBXdMp/tf?=
 =?us-ascii?Q?KC+o/cApTvIrksmzhW1C4WjhZGjbQKtWoXPBMUFXLYwf6Jw/JIPuPk9BE8M9?=
 =?us-ascii?Q?jwr0URGslh1CaAj2hMtNtBPQP7Idbe1SxxZqWQcv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d5b05bc-5111-429d-099f-08daf8bf5005
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 19:16:19.2545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 09Y/DqqPmnXRkZoT8VBNr6j49RsT/uwURz5MfkriX00mzZSL+ia1Jhmx4f7cPX1D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8328
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

Make irq_domain_free_fwnode() tolerant of NULL.

Fixes: 27a6dea3ebaa ("genirq/msi: Provide msi_create/free_device_irq_domain()")
Reported-by: Omri Barazi <obarazi@nvidia.com>
Tested-by: Kalle Valo <kvalo@kernel.org>
Tested-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 kernel/irq/irqdomain.c | 2 +-
 kernel/irq/msi.c       | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

v2:
 - Protect against NULL argument to irq_domain_free_fwnode()
v1: https://lore.kernel.org/r/0-v1-9195b42af947+89-msi_leak_jgg@nvidia.com

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 8fe1da9614ee8d..5c3fb6168eef2e 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -114,7 +114,7 @@ void irq_domain_free_fwnode(struct fwnode_handle *fwnode)
 {
 	struct irqchip_fwid *fwid;
 
-	if (WARN_ON(!is_fwnode_irqchip(fwnode)))
+	if (!fwnode || WARN_ON(!is_fwnode_irqchip(fwnode)))
 		return;
 
 	fwid = container_of(fwnode, struct irqchip_fwid, fwnode);
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

