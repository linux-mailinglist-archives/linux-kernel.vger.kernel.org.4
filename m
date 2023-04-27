Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1522D6EFE97
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 02:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242778AbjD0Anx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 20:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242557AbjD0Anu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 20:43:50 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19D93A87
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 17:43:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Plc2DlUMYCIzJEIFLWiZg8ryCbYpxN49wYTpxw5a7CUEgH68Wp/1oXE5u4ueLh8m3my9uC8T/4yBjOFiq3M7EMuO4SqoSWQkSd7ElAXDvDv5JdvCggfB/2OcqVX2kO9KQjfes2w2Su/y1oENhcsFvso0GJh1wxG+CPMBF4zNTB5mA0zeugdNomd9ytI7bB475D9Zb10c6p8G5W5331+fIMXOL93itxv5gwF2RVzQEVYGUY4zj3kBzDuMrUESoPKFlsMsIeBvITWk4cHjNaZUOwArUHAL1aWSBqt9WGco2VBWIgaMYh7abpa6ySgQ88sqYxZyFgWz8HjMMkNnxcUIzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hSjizp/Y9mOyMtA/ozXFLW08QoBG2o5uZBtMW+ZBCX0=;
 b=kbbZWoz26sm3Ay7c+JG/VmaRt4697ivjJoxeY593jzTjoLPmuod3/n3hWnES/0CGDmu5m1Jk8Mrl8YvIUR0x3V01mIqBAMOx4gEW3UcKIUzLROpyn4hra3reO0Ki/8tPQBcsllggWowXOEHmN7R/MSlX+fK39R65vDAaCX5gTkhb3vq032bK10E7C4ZGBOruvfNds98m55iDg4CbfMOx9KN73Y1aEfSlFAOFoZHUEzG5+aBi+e7bIoG6zslVS38CpHPJ/uo41TB8J3TOkfTe6dc4eNTtggWpDtk4ewghR2jKE2gDiRJF92u20YysP8sVGVBcwWqAIaCF7V2l3ndu4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hSjizp/Y9mOyMtA/ozXFLW08QoBG2o5uZBtMW+ZBCX0=;
 b=MaZckVbpTdxuDH9AkKTEsAPW/FmkaFw8AQa8WLHW/PFcVl4LNcoZZF04FQAcGduPYrb9eAGpaSYKLEPIRjwLj994mvHNe4hRvrub5aMC6Zv7lnDOfBckrasJy6YMk+SVi7Yf5GbW9UzLiuWSrkasagGZgcSaEpTl0bi92kISAR521FlPkB9KjdB/CB4esD/p6SHhfpzbScodN+LqvCO8UEH07Rb8Pi7LNVI5HMJKk64rvTWlaO89fy9clYFTOAMLp22uU0+JPT060SBGJLEFvnifr5WV+0zJChP932E5lkE15e0aM7wpPe50jhwFsTfnI1/Msz7EYyt6pY46a7z6og==
Received: from DM6PR03CA0053.namprd03.prod.outlook.com (2603:10b6:5:100::30)
 by DM6PR12MB5518.namprd12.prod.outlook.com (2603:10b6:5:1b9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Thu, 27 Apr
 2023 00:43:47 +0000
Received: from DS1PEPF0000E64E.namprd02.prod.outlook.com
 (2603:10b6:5:100:cafe::c9) by DM6PR03CA0053.outlook.office365.com
 (2603:10b6:5:100::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.20 via Frontend
 Transport; Thu, 27 Apr 2023 00:43:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS1PEPF0000E64E.mail.protection.outlook.com (10.167.18.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.16 via Frontend Transport; Thu, 27 Apr 2023 00:43:46 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 26 Apr 2023
 17:43:43 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 26 Apr 2023 17:43:43 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 26 Apr 2023 17:43:42 -0700
Date:   Wed, 26 Apr 2023 17:43:41 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Baolu Lu <baolu.lu@linux.intel.com>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/vt-d: Remove unnecessary locking in
 intel_irq_remapping_alloc()
Message-ID: <ZEnFPYvNzF8WFgqO@Asurada-Nvidia>
References: <20230314051836.23817-1-baolu.lu@linux.intel.com>
 <ZCGJn3QWhQl4F1dI@nvidia.com>
 <ad57d47e-3f54-0e63-5cef-d786dab5535c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ad57d47e-3f54-0e63-5cef-d786dab5535c@linux.intel.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E64E:EE_|DM6PR12MB5518:EE_
X-MS-Office365-Filtering-Correlation-Id: 82f366fa-b03b-4ea0-4c3a-08db46b87580
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eSNt/LFvFkNL12Fdw1c6CT6WdlsXLJxvOY4qElpuQ7qrS7UCHBFu8fazpNxiZdq0vh5HGaEUaWVkphUVrv3xNEkOgmNaIiiXDOdF+EGJg84gbWyZrQH6XypUp0WrYC6fMQmKoKeaPeSI4WOPjtAi2BcwJIobDiLQFCmVigqFXC1AMlbVJm0L9+U7zIECiCdDU0LL9qWg4MgpqhJliZWGx+hNCWe/X6yFe3NP6L5SSJj9tEIMsNYNM0KHpStNdz1MGWqKuz7Syh/I2WrXE64lWvUVdoraggALVIoq9Vb0nqgJCHSfQYal+fAbMm5FZMZ5xqvy0KU6vk0CoApQDqw2hjllBhRaFAZMyE/V0Pl4Bzc1jtbi7IGHsOHtoVsKT4WhnjzkEnVRlCVM0cH3ZWtslugU3n47SM6qGl9LO4yxHxcJpLiq0uzCbl41S8KbSpg1WalQONHYVWvOcULJZSxcT2Y0/7PbR3sLQAr0VdL7KDBgGWO6Sl1ZZL9cFMsiLnnV657avQnzO4A+K0YIll9qypClPfVMMGdS7zgmmKnKJ3XYpUX8sFNCiv3pd9P/wAWt32/mkBNa30pHg0JpmfRK3jQJUdeA0675x6Y42bySfOBt/vvIg7v5OFfXJAwuh7e9PeTKyxiOaowWs4oJu8SWKdKDIbzvinF4E/9WU1/MiYJcOShXbB7MrsWnv51R8vnJRXqnld9xTH7qtt+Rldtbmkjz6O+5/2ZKW03OwG55ARJj2/18RPA0t+W/fo99yob+
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199021)(46966006)(36840700001)(40470700004)(47076005)(86362001)(82310400005)(33716001)(2906002)(40460700003)(55016003)(40480700001)(36860700001)(45080400002)(186003)(53546011)(83380400001)(426003)(336012)(26005)(9686003)(966005)(70586007)(70206006)(478600001)(4326008)(110136005)(54906003)(356005)(316002)(7636003)(5660300002)(41300700001)(82740400003)(8676002)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 00:43:46.0920
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f366fa-b03b-4ea0-4c3a-08db46b87580
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E64E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5518
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolu/Jason,

On Mon, Mar 27, 2023 at 06:13:10AM -0700, Baolu Lu wrote:
> On 2023/3/27 20:18, Jason Gunthorpe wrote:
> > On Tue, Mar 14, 2023 at 01:18:36PM +0800, Lu Baolu wrote:
> >> The global rwsem dmar_global_lock was introduced by commit 3a5670e8ac932
> >> ("iommu/vt-d: Introduce a rwsem to protect global data structures"). It
> >> is used to protect DMAR related global data from DMAR hotplug operations.
> >>
> >> Using dmar_global_lock in intel_irq_remapping_alloc() is unnecessary as
> >> the DMAR global data structures are not touched there. Remove it to avoid
> >> below lockdep warning.
> >
> > Tested-by: Jason Gunthorpe <jgg@nvidia.com>
> >
> > Solves my splat too
> >
> > Let's send this to -rc please
> 
> Thank you for the testing. I will queue it for Joerg this week.

I found a couple of kernel warnings switching from v6.3-rc4
to v6.3-rc5. Git-bisect is pointing at this commit.

My test environment is MKT enabling irq_remap:
https://github.com/Mellanox/mkt
CONFIG_IOMMUFD=m
CONFIG_IOMMUFD_VFIO_CONTAINER=y
CONFIG_IOMMUFD_TEST=y
CONFIG_IRQ_REMAP=y

Any idea?

Thanks
Nicolin

Attaching WARNINGs:
[   19.680725] ------------[ cut here ]------------
[   19.681083] WARNING: CPU: 0 PID: 561 at include/linux/mmap_lock.h:161 track_pfn_remap+0xf5/0x100
[   19.681356] Modules linked in: vfio_pci vfio_pci_core irqbypass vfio iommufd mlx5_ib ib_uverbs ib_core mlx5_core
[   19.681654] CPU: 0 PID: 561 Comm: python3 Not tainted 6.3.0-rc6+ #1080
[   19.681808] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
[   19.682108] RIP: 0010:track_pfn_remap+0xf5/0x100
[   19.682270] Code: 5e 5d c3 48 89 f2 31 c9 4c 89 c6 4c 89 e7 e8 42 fc ff ff e9 54 ff ff ff 48 8d b8 88 01 00 00 31 f6 e8 5f 97 76 00 85 c0 75 be <0f> 0b eb ba 0f 1f 80 00 00 00 00 80 3d 71 72 ef 00 00 74 01 c3 55
[   19.682678] RSP: 0000:ffffc900014b7ce8 EFLAGS: 00010246
[   19.682805] RAX: 0000000000000000 RBX: 0000000002000000 RCX: 0000000000000000
[   19.682984] RDX: 0000000000000000 RSI: ffff888104a709c8 RDI: ffff888108756150
[   19.683214] RBP: ffffc900014b7d08 R08: 0000000000000001 R09: 0000000000000003
[   19.683464] R10: 000000000e6a4a47 R11: 00000000620892b1 R12: 00000000fc000000
[   19.683663] R13: ffffc900014b7d20 R14: ffff888106a35100 R15: 0000000002000000
[   19.683843] FS:  00007fa8aa4edb80(0000) GS:ffff8881ba400000(0000) knlGS:0000000000000000
[   19.684054] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   19.684223] CR2: 00007fa8a748f004 CR3: 000000010673b005 CR4: 00000000003706b0
[   19.684414] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   19.684632] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   19.684817] Call Trace:
[   19.684893]  <TASK>
[   19.684967]  remap_pfn_range+0x3e/0xa0
[   19.685084]  vfio_pci_mmap_fault+0x8a/0x160 [vfio_pci_core]
[   19.685253]  __do_fault+0x30/0xa0
[   19.685368]  __handle_mm_fault+0xe08/0x1ff0
[   19.685520]  ? find_held_lock+0x31/0x80
[   19.685655]  ? mt_find+0x15d/0x400
[   19.685759]  ? lock_release+0xbc/0x240
[   19.685862]  handle_mm_fault+0xa8/0x170
[   19.685963]  ? find_vma+0x3c/0x70
[   19.686066]  exc_page_fault+0x1e6/0x7b0
[   19.686167]  asm_exc_page_fault+0x27/0x30
[   19.686271] RIP: 0033:0x7fa8a986bfd5
[   19.686373] Code: ef 41 89 c4 e8 dc 70 fc ff 45 85 e4 0f 85 a0 0e 00 00 48 89 df e8 3b ce ff ff 48 85 c0 0f 84 eb 0d 00 00 48 8b ab e8 02 00 00 <8b> 45 04 0f c8 c1 e8 10 83 f8 05 0f 85 b0 0b 00 00 8b 45 14 ba 01
[   19.686773] RSP: 002b:00007ffc2392ab30 EFLAGS: 00010206
[   19.686931] RAX: 0000559646201590 RBX: 0000559646471a50 RCX: 0000559646471d00
[   19.687132] RDX: 0000559646471d00 RSI: 0000000000003b71 RDI: 0000000000000003
[   19.687377] RBP: 00007fa8a748f000 R08: 00000000fedfffff R09: 0000000000000000
[   19.687563] R10: 0000000000000022 R11: 0000000000000246 R12: 0000559646470904
[   19.687744] R13: 00007ffc2392ab70 R14: 0000000000000002 R15: 0000559646470934
[   19.687943]  </TASK>
[   19.688016] irq event stamp: 655597
[   19.688114] hardirqs last  enabled at (655605): [<ffffffff810c9683>] __up_console_sem+0x53/0x60
[   19.688340] hardirqs last disabled at (655612): [<ffffffff810c9668>] __up_console_sem+0x38/0x60
[   19.688554] softirqs last  enabled at (655148): [<ffffffff81064e79>] irq_exit_rcu+0x69/0x90
[   19.688733] softirqs last disabled at (655143): [<ffffffff81064e79>] irq_exit_rcu+0x69/0x90
[   19.688915] ---[ end trace 0000000000000000 ]---
[   19.689076] ------------[ cut here ]------------
[   19.689197] WARNING: CPU: 0 PID: 561 at include/linux/mmap_lock.h:161 remap_pfn_range_notrack+0x40f/0x4f0
[   19.689440] Modules linked in: vfio_pci vfio_pci_core irqbypass vfio iommufd mlx5_ib ib_uverbs ib_core mlx5_core
[   19.689691] CPU: 0 PID: 561 Comm: python3 Tainted: G        W          6.3.0-rc6+ #1080
[   19.689867] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
[   19.690109] RIP: 0010:remap_pfn_range_notrack+0x40f/0x4f0
[   19.690234] Code: 39 eb 0f 85 d9 fc ff ff 31 c0 eb 5e 48 8b 45 a8 31 f6 4c 89 45 d0 48 8d b8 88 01 00 00 e8 89 bc 5a 00 4c 8b 45 d0 85 c0 75 02 <0f> 0b 48 8b 43 20 e9 5e fc ff ff 48 8b 7d a8 48 89 c6 48 89 c3 e8
[   19.690628] RSP: 0000:ffffc900014b7c68 EFLAGS: 00010246
[   19.690750] RAX: 0000000000000000 RBX: ffff888106a35100 RCX: 0000000000000000
[   19.690914] RDX: 0000000000000000 RSI: ffff888104a709c8 RDI: ffff888108756150
[   19.691074] RBP: ffffc900014b7d08 R08: 00007fa8a948f000 R09: 0000000000000003
[   19.691274] R10: 000000000e6a4a47 R11: 00000000620892b1 R12: 00000000000fc000
[   19.691469] R13: 00007fa8a748f000 R14: 00007fa8a748f000 R15: 8000000000000037
[   19.691647] FS:  00007fa8aa4edb80(0000) GS:ffff8881ba400000(0000) knlGS:0000000000000000
[   19.691830] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   19.691980] CR2: 00007fa8a748f004 CR3: 000000010673b005 CR4: 00000000003706b0
[   19.692159] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   19.692336] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   19.692538] Call Trace:
[   19.692592]  <TASK>
[   19.692647]  ? track_pfn_remap+0xf7/0x100
[   19.692745]  remap_pfn_range+0x57/0xa0
[   19.692845]  vfio_pci_mmap_fault+0x8a/0x160 [vfio_pci_core]
[   19.692991]  __do_fault+0x30/0xa0
[   19.693089]  __handle_mm_fault+0xe08/0x1ff0
[   19.693186]  ? find_held_lock+0x31/0x80
[   19.693291]  ? mt_find+0x15d/0x400
[   19.693391]  ? lock_release+0xbc/0x240
[   19.693491]  handle_mm_fault+0xa8/0x170
[   19.693587]  ? find_vma+0x3c/0x70
[   19.693685]  exc_page_fault+0x1e6/0x7b0
[   19.693782]  asm_exc_page_fault+0x27/0x30
[   19.693880] RIP: 0033:0x7fa8a986bfd5
[   19.693961] Code: ef 41 89 c4 e8 dc 70 fc ff 45 85 e4 0f 85 a0 0e 00 00 48 89 df e8 3b ce ff ff 48 85 c0 0f 84 eb 0d 00 00 48 8b ab e8 02 00 00 <8b> 45 04 0f c8 c1 e8 10 83 f8 05 0f 85 b0 0b 00 00 8b 45 14 ba 01
[   19.694342] RSP: 002b:00007ffc2392ab30 EFLAGS: 00010206
[   19.694466] RAX: 0000559646201590 RBX: 0000559646471a50 RCX: 0000559646471d00
[   19.694619] RDX: 0000559646471d00 RSI: 0000000000003b71 RDI: 0000000000000003
[   19.694778] RBP: 00007fa8a748f000 R08: 00000000fedfffff R09: 0000000000000000
[   19.694934] R10: 0000000000000022 R11: 0000000000000246 R12: 0000559646470904
[   19.695092] R13: 00007ffc2392ab70 R14: 0000000000000002 R15: 0000559646470934
[   19.695302]  </TASK>
[   19.695373] irq event stamp: 656049
[   19.695452] hardirqs last  enabled at (656057): [<ffffffff810c9683>] __up_console_sem+0x53/0x60
[   19.695657] hardirqs last disabled at (656064): [<ffffffff810c9668>] __up_console_sem+0x38/0x60
[   19.695883] softirqs last  enabled at (655148): [<ffffffff81064e79>] irq_exit_rcu+0x69/0x90
[   19.696061] softirqs last disabled at (655143): [<ffffffff81064e79>] irq_exit_rcu+0x69/0x90
[   19.696240] ---[ end trace 0000000000000000 ]---

