Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB396C971C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 19:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbjCZRII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 13:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCZRIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 13:08:05 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9986C211E;
        Sun, 26 Mar 2023 10:08:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uin4IloFZyf6/eKZZpywLucpS+b0bUpp8iuBK8/2QRkGZEfLqqTzK80pC70kJlhhEtVp+CpQ/Eo6wSZDuKhF45o/t8B/z/FNjE4Zaefzyn4LycFtIYv0GoSKZq4cCSoT0kIy5q+yXAtJmTrM8JuzuiDMcirqSMA5DUjK1G1Yxb9FXrn9FZFrqEK2EXl29cdFRbkygftd82Zs0LOzqal3XVc/BN6nrjIZxr6RinmHNvW/bFL8IbwBwxsSYTr5C/nAczlGULcaEbOd2CBaXEZZKByEQRUjj6D9BJicFg7rMURZ627iw59aSWht60x7EZOYFgUFEJkpxEjr6miF6HiSxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWWUdsvN3AkL5Pj0QqMlem1MJTuZU4SUT4iYN2XNVVk=;
 b=LqOUNfPWWym2h0GSEKB8WqfYVT37CFoktXgu8AQJtF6oBl/LU/HZC1tglvTLcXa01QhsfKIrQGUSxD5Vmhrst1veSQUYOxcGxsL403O6zkUfu30SY5iqfJlnZmGlShZktm9Te16b4+7jrc+nUzqlWTYxksqP8ZV3K93KUbbtX3CsgbZ1MSks7PMNolZ38/1gBznC0/tgUvXJKGjfu6/PsPe66Vf0wA1vj+GuoChuc285BebfKctXGyXow+iN+rNHM+D3y9B1EJe9RjRWS94eSDDyw3J7+rFu/dBRXNdt/2u86rUJ4EcczzjB0Od9iWUTkyCX1IMYoc0LP24++P70Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWWUdsvN3AkL5Pj0QqMlem1MJTuZU4SUT4iYN2XNVVk=;
 b=QxQ8QnMb3XL6MICHqNKpnYvtJ7ntGW/Rk9McuyCMbpFYqDKQLtjCewPnsI0aY1gtH0O08FqVKj2n4dsIV4LCgL0AkDYBGrmwVoJd9ZIVE3RoLvLHTfJ+fxnAWnwtnojFFFYsTLYEpOe3VTe2FIBAFEO0x2hEhSMxqrFGp1MHHwHGUxCoH3tpyS4ObDTq/aY6xQH8qSEMIVj7nD7Fda/YIYerioMV5gwN5geHBC/pH+XcLqnXueLjQmP/ViBkytfprow0zjeSg+QWPt4pGDUWPb++OK5Opa0cyND0b6mWKPOiv9th7K6IVZH5Q9Lr038zGnELpNS7MPk1podN5GVLMg==
Received: from DM6PR04CA0001.namprd04.prod.outlook.com (2603:10b6:5:334::6) by
 PH7PR12MB6761.namprd12.prod.outlook.com (2603:10b6:510:1ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Sun, 26 Mar
 2023 17:08:01 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::e2) by DM6PR04CA0001.outlook.office365.com
 (2603:10b6:5:334::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41 via Frontend
 Transport; Sun, 26 Mar 2023 17:08:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.22 via Frontend Transport; Sun, 26 Mar 2023 17:08:00 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 26 Mar 2023
 10:07:59 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 26 Mar
 2023 10:07:59 -0700
Received: from SDONTHINENI-DESKTOP.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Sun, 26 Mar 2023 10:07:58 -0700
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
Subject: [PATCH] arm64: mm: Increase MODULES_VSIZE to 512MB
Date:   Sun, 26 Mar 2023 12:07:56 -0500
Message-ID: <20230326170756.3021936-1-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT010:EE_|PH7PR12MB6761:EE_
X-MS-Office365-Filtering-Correlation-Id: bc662ef9-1e0f-4e44-5431-08db2e1ca771
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UFt+tiwxtVaooBSy+d9xvcnwrrO577e7YZHwm0ll9DmlbAE9UlEV3+cNqzzWrrCmhdRu7gZhJ0vrmQeJTe2Fytakc6Zwa6RQGFCNb++2O8/sBH0ElDY1Gj2Ky/0fldxUwUORcpk67qdWsU/pIRMP85Qfh7hminneftqSXgBzMppYq497h8fQR52rPHF/vp1fsfMAiEERCr3goPAS2slHQWubJaBu8mR9eSRCAVi5mPqA6Webmq0lj1UTlrhyb/7Pmuhung40bexmCulObz0tLrovvd/o+e6GpotmrO8zwyFy7KX2EsRGCV2Dxl5IK56HK2yRkIzFw5XNgPz3+V8iEC1u80F21unyCN1icrWTwtWn+Ox3tCNgGIi9Ab8IZ6wYMfNy0Nn5Qt63xRuuocvh0D3Yytk1bVvBrUy5NkrJi29Lzfhx/D/OIE4Qr4rcRs6BzCE8V6CQFmzwbNgaFiz9k6zOt+2ZFRp39THsDbaW1AKT3xWpFgYJlBBtvP7+2zNnTgWoHv1TtNQ5IcxWY+Bv131XCb4umnk7WGLUnkhQgM071taN/SsdbblQOfc2m3zBjq52cdjzusjhSxyyAuKW8cdfVa65csLSJd+gp0uav4aLIuhM6wFwyx5QbgUlVJqHz6JH5W8BzRckqReSfxeXMCcs4E5yXT/IK6KTDExXvi+66qFpDLrSqqanFh+Om5MsDYIk7GopwgRNCpGKK1/mHBZhYeb4i6e8a0cThgKO12yGWwnS5+KtwACOzGfatRUl2Uo3y+fRwoi9d+zNunIctLL50pDGVHOxX3ug0LnGyYI=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199021)(46966006)(40470700004)(36840700001)(356005)(336012)(41300700001)(40460700003)(83380400001)(82740400003)(186003)(34020700004)(426003)(86362001)(7636003)(36860700001)(2616005)(316002)(47076005)(40480700001)(478600001)(70586007)(8676002)(4326008)(8936002)(70206006)(36756003)(5660300002)(7696005)(1076003)(26005)(7416002)(2906002)(107886003)(82310400005)(110136005)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2023 17:08:00.4835
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc662ef9-1e0f-4e44-5431-08db2e1ca771
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6761
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The allocation of modules occurs in two regions: the first region
MODULES_VSIZE (128MB) is shared with the core kernel, while the
the second region (2GB) is shared with other vmalloc callers.
Depending on the size of the core kernel, the 128MB region may
quickly fill up after loading a few modules, causing the system
to switch to the 2GB region. Unfortunately, even the 2GB region
can run out of space if previously loaded modules and the other
kernel subsystems consume the entire area, leaving no space for
additional modules.

This issue usually occurs when the system has a large number of
CPU cores, PCIe host-brigde controllers, and I/O devices. For
instance, the ECAM region of one host-bridge controller can use
up to 256MB of vmalloc space, while eight controllers can occupy
the entire 2GB.

One potential solution to address this issue is to increase the
size of the MODULES_VSIZE region to 512MB, which would enhance
the system's ability to support a greater number of dynamically
loaded modules and drivers.

Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
---

I am seeking your guidance and feedback on the proposed solution
to address the module load failures, specifically regarding any
potential side effects that I need to be aware of. Additionally,
I would appreciate your suggestions on any alternative solutions
to resolve the issue.

On a NVIDIA T241 system with Ubuntu-22.04, hitting boot failures
due to vmalloc/vmap allocation errors when loading modules.
dmesg:
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
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/arm64/memory.rst b/Documentation/arm64/memory.rst
index 2a641ba7be3b..76c2fd8bbbf7 100644
--- a/Documentation/arm64/memory.rst
+++ b/Documentation/arm64/memory.rst
@@ -33,8 +33,8 @@ AArch64 Linux memory layout with 4KB pages + 4 levels (48-bit)::
   0000000000000000	0000ffffffffffff	 256TB		user
   ffff000000000000	ffff7fffffffffff	 128TB		kernel logical memory map
  [ffff600000000000	ffff7fffffffffff]	  32TB		[kasan shadow region]
-  ffff800000000000	ffff800007ffffff	 128MB		modules
-  ffff800008000000	fffffbffefffffff	 124TB		vmalloc
+  ffff800000000000	ffff80001fffffff	 512MB		modules
+  ffff800020000000	fffffbffefffffff	 124TB		vmalloc
   fffffbfff0000000	fffffbfffdffffff	 224MB		fixed mappings (top down)
   fffffbfffe000000	fffffbfffe7fffff	   8MB		[guard region]
   fffffbfffe800000	fffffbffff7fffff	  16MB		PCI I/O space
@@ -50,8 +50,8 @@ AArch64 Linux memory layout with 64KB pages + 3 levels (52-bit with HW support):
   0000000000000000	000fffffffffffff	   4PB		user
   fff0000000000000	ffff7fffffffffff	  ~4PB		kernel logical memory map
  [fffd800000000000	ffff7fffffffffff]	 512TB		[kasan shadow region]
-  ffff800000000000	ffff800007ffffff	 128MB		modules
-  ffff800008000000	fffffbffefffffff	 124TB		vmalloc
+  ffff800000000000	ffff80001fffffff	 512MB		modules
+  ffff800020000000	fffffbffefffffff	 124TB		vmalloc
   fffffbfff0000000	fffffbfffdffffff	 224MB		fixed mappings (top down)
   fffffbfffe000000	fffffbfffe7fffff	   8MB		[guard region]
   fffffbfffe800000	fffffbffff7fffff	  16MB		PCI I/O space
diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 78e5163836a0..dd5d634e235f 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -46,7 +46,7 @@
 #define KIMAGE_VADDR		(MODULES_END)
 #define MODULES_END		(MODULES_VADDR + MODULES_VSIZE)
 #define MODULES_VADDR		(_PAGE_END(VA_BITS_MIN))
-#define MODULES_VSIZE		(SZ_128M)
+#define MODULES_VSIZE		(SZ_512M)
 #define VMEMMAP_START		(-(UL(1) << (VA_BITS - VMEMMAP_SHIFT)))
 #define VMEMMAP_END		(VMEMMAP_START + VMEMMAP_SIZE)
 #define PCI_IO_END		(VMEMMAP_START - SZ_8M)
-- 
2.25.1

