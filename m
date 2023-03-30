Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE536D0792
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 16:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbjC3OE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 10:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbjC3OEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 10:04:55 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEEB7AB9;
        Thu, 30 Mar 2023 07:04:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l39z7ClYAN6W5xLmEe4gcDZgdLLvSLlapxbRa6nHMwbysaUmPibvxfN3Owl4md5o3VbX54FDOFi/zMDqrw4Omf6UZn7rqNwL6lalVRVJ82Xwgq9T+nSszdAggM7grhzTuq6iyaXt3nk9sANTLGDxUf6BlHvhzQGrd9s6ESZXCoV03ZxMGOxK5YqVukBCLx0Dqn4CIFtPBgfgXwOce2j08/Ns+3zo38vhCMEMeSYk8NYtRFsQy45iKxLBOKYCh1vhk6+HMfMs5lqM68/+ekghYTBMCFo8DC0FOXKvxRfjOH1CTXj3BQ71iGxagpohikkWGCQUPxjLEIO3jjVT8FOW7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vsLKkTp8hz4w7W7LuG08H4lzukZ+jsr2LWNhriQ6xXY=;
 b=Nw60edn8gEVqgpQexbsD4kivhYQP33hruw1gRcvKbl2Luir3TVvFb+P8JKvipA+mhyMgCDiRJkV00tLC8Dt8EN4Hy1PBQ6eQXFWibaG6nc471H/PWzJhGhruRHf6r1WDmsMYCKoGiFh2225a3V1hNScE9WoMInCv7SmCrx9qem7mLZAmsOA5svd5V7m3i1ocz2j/h0J9CmlWsXdALMAw35Yc2sI7DWA0pyQ43js5Z+k305K7TMjMGMxcsqXfVsAcY4p3HLzca92yWUkWrjJkjnwH060BlxKfqhIj85ClwfEGg7XTpiu8wTgckB/eA42gJ3flxOf8d79tMRi4w8A9Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vsLKkTp8hz4w7W7LuG08H4lzukZ+jsr2LWNhriQ6xXY=;
 b=WyLJ3AR/oagkpfklwqZjgswb4QHcPOU/ShDSH8nCrOvAcaERf8j1Rk+f5mqUr4+rGEk5Vj3+e/LjZ1wb7PChjLzHCRhYFfyeB0HVFDdJ4eTdxZRmU67IbIeA2hjb5D29nRtL8bioEGd9cJxl9+8bjEo1CEAw0H0XK3fFs+vT5FcswJ7FkMd73X02UaQtV1AsCx3trkZQw2hi+WjxwmXuo42IGGQDM7z4tFrP4cBFVZRpYBsPwtnJGlPwnxXKC0W1KbxruYvFOz9B52UzskHQ0XTU+6lxYJUBhIejAuCVCaEQAFrecurywBSwpkp/U8LIVY5JFMu7UvLruNRNfpcK6w==
Received: from DM6PR13CA0004.namprd13.prod.outlook.com (2603:10b6:5:bc::17) by
 DS0PR12MB6655.namprd12.prod.outlook.com (2603:10b6:8:d0::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.33; Thu, 30 Mar 2023 14:04:50 +0000
Received: from DM6NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::27) by DM6PR13CA0004.outlook.office365.com
 (2603:10b6:5:bc::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 14:04:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT074.mail.protection.outlook.com (10.13.173.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.21 via Frontend Transport; Thu, 30 Mar 2023 14:04:50 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 30 Mar 2023
 07:04:40 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 30 Mar
 2023 07:04:39 -0700
Received: from SDONTHINENI-DESKTOP.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 30 Mar 2023 07:04:38 -0700
From:   Shanker Donthineni <sdonthineni@nvidia.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>
CC:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Zhou Guanghui <zhouguanghui1@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        Vikram Sethi <vsethi@nvidia.com>,
        Thierry Reding <treding@nvidia.com>
Subject: [PATCH v2] arm64: mm: Increase MODULES_VSIZE to 2GB
Date:   Thu, 30 Mar 2023 09:04:37 -0500
Message-ID: <20230330140437.984211-1-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT074:EE_|DS0PR12MB6655:EE_
X-MS-Office365-Filtering-Correlation-Id: 02e7a66d-031f-4b83-9230-08db3127ba56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AZM/wYZWQPRu6ARbtzhYpiz1RFgJ+p0QWTKUYG7peTiymbR+foSkYA7GL+z9rjuBfdhSlIdujrVfoc3XNMRUReiQYF1yF0PHssnTD2jaQUkqp96KFi82HQPOFeLX0BUDt5aw73QRl0j84eFBJx90Kk94Z4IPhw4w7z/4aZlj3+U7Mxu8VrjK7U2VBCsNK1F/h6JBnewVG6qNly4kecxpRS7EtVB3SwAcDThS1v+aycDnyqwTtaMjrN2k0arJS9IeHK0Jujb27fhD32nlZL4cPVVV94DU7m1CR9KrgZEfDYhtPu/mR2EpwjHF6lPKp1biR5X2qNwYKqVYLb4pPel2dO8XhYoIIK188BRzUyDNJfJGDacwJvpLANVGXbymkGSSPTPUdCgSDdDVRuc0kfUekfzw5o3D0VQusgzCBrLbsi3wBlcc7iZVu8uB1CCE95YDI5tSNhcu37bAl7EhSv5cJcvVkeNrvz3ebaAIPLgRrkirsSmtVnZbntUd2clwqJypkO5Kv1Z3ufUzyodw+Y9rKioWRGGILXbOYGYK2wagsvmiHQxEglcAHee10Cy0DyiDNnkL1rTzJqR/cbJYNBWLSQw8WvRQtp7mv0+pUaPG28v+WWw1YztYoF8EYe1gapM9IhEXBkCoDJUBVEaftbYEJu1sNmEH1avOnLS15o4zAsM25Et62PsbyaeBqjObdS6HACn2evDmYYyE5WNBSORXO8Ky6k2rAY6JBTIJqvQScU9lhX8XCFNNOhngX1QTFN90ZEg9hGPdcvhY8O72czNTdyk2BgnuKg1Pm+7bExfamao=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199021)(40470700004)(36840700001)(46966006)(36756003)(426003)(336012)(47076005)(86362001)(82740400003)(83380400001)(5660300002)(82310400005)(2616005)(186003)(7416002)(1076003)(26005)(356005)(7636003)(8936002)(2906002)(107886003)(7696005)(70586007)(40460700003)(36860700001)(70206006)(41300700001)(40480700001)(4326008)(54906003)(316002)(34020700004)(8676002)(478600001)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 14:04:50.1216
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e7a66d-031f-4b83-9230-08db3127ba56
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6655
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The allocation of modules occurs in two regions. The first region
is MODULES_VSIZE, which is 128MB in size and shared with the core
kernel when the KASLR feature is unavailable or disabled through
a boot parameter. The second region, which is 2GB in size, is
shared with the other vmalloc callers. Depending on the size of
the core kernel, the 128MB region may quickly fill up after
loading a few modules, causing the system to switch to the 2GB
region. Unfortunately, even the 2GB region can run out of space
if previously loaded modules and other kernel subsystems consume
the entire area, leaving no space for additional modules.

This issue usually occurs when the system has a large number of
CPU cores, PCIe host-brigde controllers, and I/O devices. For
instance, the ECAM region of one host-bridge controller can use
up to 256MB of vmalloc space, while eight controllers can occupy
the entire 2GB.

To address this problem, a possible solution would be to increase
the MODULES_VSIZE to 2GB. This would improve the system's ability
to accommodate a greater number of dynamically loaded modules and
drivers when KASLR is not enabled. However, prior to switching to
the 2GB region, it is advisable to allocate modules within the
128MB space that covers the core kernel, in order to benefit from
the direct branches.

Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
---
Changes since v1:
 - Included Ard's recommendations.
 - Revised the commit message.

dmesg:
 On a NVIDIA T241 system with Ubuntu-22.04, hitting boot failures
 due to vmalloc/vmap allocation errors when loading modules.

 [   64.181308] ipmi_ssif: IPMI SSIF Interface driver
 [   64.184494] usbcore: registered new interface driver r8152
 [   64.242492] vmap allocation for size 393216 failed: use vmalloc=<size> to increase size
 [   64.242499] systemd-udevd: vmalloc error: size 327680, vm_struct allocation failed, mode:0xcc0(GFP_KERNEL), nodemask=(null),cpuset=/,mems_allowed=0-3
 [   64.242510] CPU: 32 PID: 2910 Comm: systemd-udevd Tainted: G           OE      6.2-generic-64k 
 [   64.242513] Hardware name: NVIDIA T241, BIOS v1.1.0 2023-03-18T21:32:31+00:00
 [   64.242515] Call trace:
 [   64.242516]  dump_backtrace+0xe0/0x130
 [   64.242523]  show_stack+0x20/0x60
 [   64.242525]  dump_stack_lvl+0x68/0x84
 [   64.242530]  dump_stack+0x18/0x34
 [   64.242532]  warn_alloc+0x11c/0x1b0
 [   64.242537]  __vmalloc_node_range+0xe0/0x20c
 [   64.242540]  module_alloc+0x118/0x160
 [   64.242543]  move_module+0x2c/0x190
 [   64.242546]  layout_and_allocate+0xfc/0x160
 [   64.242548]  load_module+0x260/0xbc4
 [   64.242549]  __do_sys_finit_module+0xac/0x130
 [   64.242551]  __arm64_sys_finit_module+0x28/0x34
 [   64.242552]  invoke_syscall+0x78/0x100
 [   64.242553]  el0_svc_common.constprop.0+0x170/0x194
 [   64.242555]  do_el0_svc+0x38/0x4c
 [   64.242556]  el0_svc+0x2c/0xc0
 [   64.242558]  el0t_64_sync_handler+0xbc/0x13c
 [   64.242560]  el0t_64_sync+0x1a0/0x1a4

 Documentation/arm64/memory.rst  | 8 ++++----
 arch/arm64/include/asm/memory.h | 2 +-
 arch/arm64/kernel/module.c      | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/arm64/memory.rst b/Documentation/arm64/memory.rst
index 2a641ba7be3b..55a55f30eed8 100644
--- a/Documentation/arm64/memory.rst
+++ b/Documentation/arm64/memory.rst
@@ -33,8 +33,8 @@ AArch64 Linux memory layout with 4KB pages + 4 levels (48-bit)::
   0000000000000000	0000ffffffffffff	 256TB		user
   ffff000000000000	ffff7fffffffffff	 128TB		kernel logical memory map
  [ffff600000000000	ffff7fffffffffff]	  32TB		[kasan shadow region]
-  ffff800000000000	ffff800007ffffff	 128MB		modules
-  ffff800008000000	fffffbffefffffff	 124TB		vmalloc
+  ffff800000000000	ffff80007fffffff	   2GB		modules
+  ffff800080000000	fffffbffefffffff	 124TB		vmalloc
   fffffbfff0000000	fffffbfffdffffff	 224MB		fixed mappings (top down)
   fffffbfffe000000	fffffbfffe7fffff	   8MB		[guard region]
   fffffbfffe800000	fffffbffff7fffff	  16MB		PCI I/O space
@@ -50,8 +50,8 @@ AArch64 Linux memory layout with 64KB pages + 3 levels (52-bit with HW support):
   0000000000000000	000fffffffffffff	   4PB		user
   fff0000000000000	ffff7fffffffffff	  ~4PB		kernel logical memory map
  [fffd800000000000	ffff7fffffffffff]	 512TB		[kasan shadow region]
-  ffff800000000000	ffff800007ffffff	 128MB		modules
-  ffff800008000000	fffffbffefffffff	 124TB		vmalloc
+  ffff800000000000	ffff80007fffffff	   2GB		modules
+  ffff800080000000	fffffbffefffffff	 124TB		vmalloc
   fffffbfff0000000	fffffbfffdffffff	 224MB		fixed mappings (top down)
   fffffbfffe000000	fffffbfffe7fffff	   8MB		[guard region]
   fffffbfffe800000	fffffbffff7fffff	  16MB		PCI I/O space
diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 78e5163836a0..b58c3127323e 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -46,7 +46,7 @@
 #define KIMAGE_VADDR		(MODULES_END)
 #define MODULES_END		(MODULES_VADDR + MODULES_VSIZE)
 #define MODULES_VADDR		(_PAGE_END(VA_BITS_MIN))
-#define MODULES_VSIZE		(SZ_128M)
+#define MODULES_VSIZE		(SZ_2G)
 #define VMEMMAP_START		(-(UL(1) << (VA_BITS - VMEMMAP_SHIFT)))
 #define VMEMMAP_END		(VMEMMAP_START + VMEMMAP_SIZE)
 #define PCI_IO_END		(VMEMMAP_START - SZ_8M)
diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index 5af4975caeb5..b4affe775f23 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -37,7 +37,7 @@ void *module_alloc(unsigned long size)
 		/* don't exceed the static module region - see below */
 		module_alloc_end = MODULES_END;
 
-	p = __vmalloc_node_range(size, MODULE_ALIGN, module_alloc_base,
+	p = __vmalloc_node_range(size, MODULE_ALIGN, module_alloc_end - SZ_128M,
 				module_alloc_end, gfp_mask, PAGE_KERNEL, VM_DEFER_KMEMLEAK,
 				NUMA_NO_NODE, __builtin_return_address(0));
 
-- 
2.25.1

