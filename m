Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5DAD709C7B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 18:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbjESQcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 12:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbjESQb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 12:31:57 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E7310F9
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 09:31:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ljeGTnfaFvG6KsoFBQ+ghS1FTM8CfWSNtcXKhzGpm6A7Z3FDsF4N9uaJVNTJrCWhFhm1O1SKPwICwlJJLLxY2wyqjuPvdRGTlLK2uNkjiVYHOEhsCbzf7FAi38PPWknjXb5cMpRRJn5mo8bQxVO8O+IEmIgb4GjlWHLcdDbFxNDg/n1nwZId4NMzJYJt20S7mFLrsstJD+NFnQMt4DqMuNuFY7oM2Qtu2z+RfYIGxFbeTFqN5kaIwWTUXmV8i0WtT3UL/h0S+qx1HNAG9A9dDQ2Wp8TbhahsnCvWWubfJfgsH6swI5xxt5e4p4Od8OWVrV1Df9v7hhrPKjDyVPPuyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MH9GCEWsgAt9YKaKenSWcFZ6c7NWvrzv26GHiVvz04o=;
 b=gN7qlV7033lFckMMoOmLZsNiFJwQX0cQ+vzgH+dM1gOuIMkZ4n4r98l7bduRQ2CafvvwnAl2Q9RxCklZ+CoY30r8TnrolJ3bW9ztCyPWrP/ix5C63peK7haZgzfgDFtRf44gyPhmtm4SreIb7NoNy1T3HVn076r5SRJieoo4viqDdw87EnfVyhdMvLsCTyi/l9TTKBhQToj9rrjSaeDwkc90oZggM/NmhnpHqUkD2c/5LAnnqOjTRrY0CT/EXdtqbAGMpxbt4cGsno9NtjKA07cD2KyCzYMwj/ZnVHNFUTx0SYdRt2UcW0YZBH2Y1fPjZTQlbOBLAUJp3vq5o4y6xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MH9GCEWsgAt9YKaKenSWcFZ6c7NWvrzv26GHiVvz04o=;
 b=Jb3vWBKq+0BbPU1Af1yIsBj0zwifNXhDnUgd1vz48y+7GSeLJpY9lf29I6lauM1h3Px9XzN2cpZ0FBTW1nTkZT34f14Pr8lfTc6tPyM4KdxorxwDN24rRXWniCb2pWStaJ/OYFHt0ir8bIFawgSlJkE+ENU/yDaU7aLOpYSnRfY=
Received: from DM6PR13CA0022.namprd13.prod.outlook.com (2603:10b6:5:bc::35) by
 BY5PR12MB4919.namprd12.prod.outlook.com (2603:10b6:a03:1d6::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.33; Fri, 19 May 2023 16:31:23 +0000
Received: from DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::50) by DM6PR13CA0022.outlook.office365.com
 (2603:10b6:5:bc::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.7 via Frontend
 Transport; Fri, 19 May 2023 16:31:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT082.mail.protection.outlook.com (10.13.173.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.21 via Frontend Transport; Fri, 19 May 2023 16:31:21 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 19 May 2023 11:31:19 -0500
From:   Tom Lendacky <thomas.lendacky@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Dionna Glaze <dionnaglaze@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biescheuvel <ardb@kernel.org>,
        "Min M. Xu" <min.m.xu@intel.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Jiewen Yao <jiewen.yao@intel.com>,
        Erdem Aktas <erdemaktas@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [RESEND PATCH v8 6/6] x86/efi: Safely enable unaccepted memory in UEFI
Date:   Fri, 19 May 2023 11:30:13 -0500
Message-ID: <430269747cb961c7e70288b5808925f4fa4c544d.1684513813.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1684513813.git.thomas.lendacky@amd.com>
References: <20230518231434.26080-1-kirill.shutemov@linux.intel.com> <cover.1684513813.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT082:EE_|BY5PR12MB4919:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f698388-b5db-4b14-4a4d-08db58867b31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zWY6vejXYPtE/Ak68a7ThSXn2M3vKQVjEPa2EF4jdG1FvYlqhlz9DpC7UlKJZ9BvyE89kJ5JMvtY3M1LXY2RedkV7rfycc1YZ4DOw36fpsOpXmPbg0tNH3PPcrGM0AtdHkwINNILHk1PVE6G9lK4odzvpf6HgkNXUZN8ISVYwFsHnoXPRFm5Ui8rEQYu5QtGp7SUg0OzXMNLU9LI3/4lqOAR96c1grgGkTmJBgpeSPtvDDKndtdDmoKjTU7OtbvTtPd8qabD/uD9M9hNOgP0i1FdPm+hkoGP7LaQmFHhw5oq444FEHCTKbs3QbI5cyN2gY3oFRnULo7gL6FYzg6Yn24aDTcrVAnwrvzh7XTdC/I+yXjgT1qCnrLzip4GPRtaTc+RuVviY+Zmc6BqJeJSr6LMr3UOkDOcxKT90dSTcPI69UD0Ufv3cGUN0emagrO9ZnFySnFAnqRYVB6Va9frFeHxtgXGfNShGp2XfGWnDPRtOog+/UM5HUOef1mZgS/+qasx9ESh8O10PfXkA5DIEgUa67mGQSTORaPfbgqsTp+4pAiYPFj0l853bXY05ElG08pz+WBUb8Bccg0RUrY7yUYb+iq9A5cwQGCY4wi7eHm7eDmylhzOpZfj4PzJxBMFGMG/0XmIYehSYGqeW9D4YpT8JYMPowjBPXcaHj2a14xMJQh6Tyav2hbXvlRnTGY1Fz6FtJkx2SLemHu7ojuJtWRyXPrIUl3ZTrzhSeJHJu5NQA14G9Y1uEgyNJlgQnLlKmsGrTohZizZXtAON1krPQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(6666004)(40480700001)(16526019)(40460700003)(186003)(5660300002)(26005)(7416002)(82310400005)(86362001)(8936002)(41300700001)(82740400003)(356005)(4326008)(70586007)(70206006)(54906003)(81166007)(336012)(316002)(8676002)(2616005)(36860700001)(426003)(36756003)(2906002)(110136005)(47076005)(478600001)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 16:31:21.8122
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f698388-b5db-4b14-4a4d-08db58867b31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4919
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dionna Glaze <dionnaglaze@google.com>

The UEFI v2.9 specification includes a new memory type to be used in
environments where the OS must accept memory that is provided from its
host. Before the introduction of this memory type, all memory was
accepted eagerly in the firmware. In order for the firmware to safely
stop accepting memory on the OS's behalf, the OS must affirmatively
indicate support to the firmware. This is only a problem for AMD
SEV-SNP, since Linux has had support for it since 5.19. The other
technology that can make use of unaccepted memory, Intel TDX, does not
yet have Linux support, so it can strictly require unaccepted memory
support as a dependency of CONFIG_TDX and not require communication with
the firmware.

Enabling unaccepted memory requires calling a 0-argument enablement
protocol before ExitBootServices. This call is only made if the kernel
is compiled with UNACCEPTED_MEMORY=y

This protocol will be removed after the end of life of the first LTS
that includes it, in order to give firmware implementations an
expiration date for it. When the protocol is removed, firmware will
strictly infer that a SEV-SNP VM is running an OS that supports the
unaccepted memory type. At the earliest convenience, when unaccepted
memory support is added to Linux, SEV-SNP may take strict dependence in
it. After the firmware removes support for the protocol, this patch
should be reverted.

  [tl: address some checkscript warnings]

Cc: Ard Biescheuvel <ardb@kernel.org>
Cc: "Min M. Xu" <min.m.xu@intel.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: James Bottomley <jejb@linux.ibm.com>
Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
Cc: Jiewen Yao <jiewen.yao@intel.com>
Cc: Erdem Aktas <erdemaktas@google.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 drivers/firmware/efi/libstub/x86-stub.c | 36 +++++++++++++++++++++++++
 include/linux/efi.h                     |  3 +++
 2 files changed, 39 insertions(+)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 8d17cee8b98e..e2193dbe1f66 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -26,6 +26,17 @@ const efi_dxe_services_table_t *efi_dxe_table;
 u32 image_offset __section(".data");
 static efi_loaded_image_t *image = NULL;
 
+typedef union sev_memory_acceptance_protocol sev_memory_acceptance_protocol_t;
+union sev_memory_acceptance_protocol {
+	struct {
+		efi_status_t (__efiapi * allow_unaccepted_memory)(
+			sev_memory_acceptance_protocol_t *);
+	};
+	struct {
+		u32 allow_unaccepted_memory;
+	} mixed_mode;
+};
+
 static efi_status_t
 preserve_pci_rom_image(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
 {
@@ -310,6 +321,29 @@ setup_memory_protection(unsigned long image_base, unsigned long image_size)
 #endif
 }
 
+static void setup_unaccepted_memory(void)
+{
+	efi_guid_t mem_acceptance_proto = OVMF_SEV_MEMORY_ACCEPTANCE_PROTOCOL_GUID;
+	sev_memory_acceptance_protocol_t *proto;
+	efi_status_t status;
+
+	if (!IS_ENABLED(CONFIG_UNACCEPTED_MEMORY))
+		return;
+
+	/*
+	 * Enable unaccepted memory before calling exit boot services in order
+	 * for the UEFI to not accept all memory on EBS.
+	 */
+	status = efi_bs_call(locate_protocol, &mem_acceptance_proto, NULL,
+			     (void **)&proto);
+	if (status != EFI_SUCCESS)
+		return;
+
+	status = efi_call_proto(proto, allow_unaccepted_memory);
+	if (status != EFI_SUCCESS)
+		efi_err("Memory acceptance protocol failed\n");
+}
+
 static const efi_char16_t apple[] = L"Apple";
 
 static void setup_quirks(struct boot_params *boot_params,
@@ -908,6 +942,8 @@ asmlinkage unsigned long efi_main(efi_handle_t handle,
 
 	setup_quirks(boot_params, bzimage_addr, buffer_end - buffer_start);
 
+	setup_unaccepted_memory();
+
 	status = exit_boot(boot_params, handle);
 	if (status != EFI_SUCCESS) {
 		efi_err("exit_boot() failed!\n");
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 9864f9c00da2..8c5abcf70a05 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -437,6 +437,9 @@ void efi_native_runtime_setup(void);
 #define DELLEMC_EFI_RCI2_TABLE_GUID		EFI_GUID(0x2d9f28a2, 0xa886, 0x456a,  0x97, 0xa8, 0xf1, 0x1e, 0xf2, 0x4f, 0xf4, 0x55)
 #define AMD_SEV_MEM_ENCRYPT_GUID		EFI_GUID(0x0cf29b71, 0x9e51, 0x433a,  0xa3, 0xb7, 0x81, 0xf3, 0xab, 0x16, 0xb8, 0x75)
 
+/* OVMF protocol GUIDs */
+#define OVMF_SEV_MEMORY_ACCEPTANCE_PROTOCOL_GUID	EFI_GUID(0xc5a010fe, 0x38a7, 0x4531,  0x8a, 0x4a, 0x05, 0x00, 0xd2, 0xfd, 0x16, 0x49)
+
 typedef struct {
 	efi_guid_t guid;
 	u64 table;
-- 
2.40.0

