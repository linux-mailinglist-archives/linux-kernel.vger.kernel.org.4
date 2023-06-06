Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C2D7246DF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238507AbjFFOxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237822AbjFFOw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:52:57 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED321BE3
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:52:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LjRAw6u70MiEZtDz/ZOYWvVSJudsyRBnxb7+t0/x2/JLI2sLAyg9HNu2CZ4LPJA11OXsfDsvbVBeCrZQ1jEbcPLF3Lq6xJiDcOEum8S3GNmaKT/VwHD5VbnT5KOxFHMimhZtrpW4rFwhNo3qrwKP4CvurPvBMLzVPNWw9whOIhHU7Nh1lfy/bfYEtTZ85GDNA0r18SfqP6/EUt9wLjaEsHdIu84ELTpzg011gjsghdYW9yumMytev+xyd3tGBA5mm1JfQIWQz2yvK9l08ZxL+quXFxKJAbxVU5veHf3cNH2A2rZ+SDvRDhEyY4HFBVUsttl7C8sggGNMu5w8Ye/cBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Nxajyk8eKxvej9jI08aDPnLBj0Vz+sgI0IjX4exDQY=;
 b=aCAnCr9wNGb1WKtNc0FFjGhCjB2u15YbdfR4pkMZyqj7Hcf0lDFed0xgUvbIRPcpTtk35N/3oGM3SvQXRricNe50HP7opZCBc/+JtHGn9h2+P/PrWodd9VbbEPAHSceNgtNxGqItGVpef5wHKixEpepdUrJhn6gMaZDbRs/xj/T4f27TtjzWmJ859WloDSTlEgsHz5I2ep/zqNhpf45QeaBJ7Gs66Gy1OgbKBV+6H1uki16X1uf40enU0nbP79ocRvtDZiPDXzAk8D7ysSr95kPkz/1S5Yaw9B3bj9r5lLjC567a67rcW8ZnRhyapv+so6KiQNa1H7vIcqRl+MRFdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Nxajyk8eKxvej9jI08aDPnLBj0Vz+sgI0IjX4exDQY=;
 b=5KQ2+3Qd9sjCahiH1dvU2tJauRIRgQNvY1wlkJC+vJHixKODDq81IrA+nah6ay69JfHIR5r6/K1r9tvJ7bdP0xHZH+EXxEbg5fSoIzrdLrzAxskGLpUNwtg/UjSBIfo0mVoOW2c1oKsPR89kZmy1Ff3k/K6Wa22XMzNuWqB50sw=
Received: from MW4PR04CA0208.namprd04.prod.outlook.com (2603:10b6:303:86::33)
 by BY5PR12MB5512.namprd12.prod.outlook.com (2603:10b6:a03:1df::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 14:52:36 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::c) by MW4PR04CA0208.outlook.office365.com
 (2603:10b6:303:86::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Tue, 6 Jun 2023 14:52:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.33 via Frontend Transport; Tue, 6 Jun 2023 14:52:35 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 6 Jun 2023 09:52:33 -0500
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
Subject: [PATCH v9 6/6] x86/efi: Safely enable unaccepted memory in UEFI
Date:   Tue, 6 Jun 2023 09:51:27 -0500
Message-ID: <0d5f3d9a20b5cf361945b7ab1263c36586a78a42.1686063086.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1686063086.git.thomas.lendacky@amd.com>
References: <20230606142637.5171-1-kirill.shutemov@linux.intel.com> <cover.1686063086.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT045:EE_|BY5PR12MB5512:EE_
X-MS-Office365-Filtering-Correlation-Id: 222dbb1a-d3dd-441f-716a-08db669daa5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mg1XlaZ+wAp2LyUBnv+F7UUptxSFQRAC+2LGBQNlyhDI90sy4wavLeATqJERniRfM0LziIj3BSZXVL6Pc6JzdT3DGhQapnsXrycWjadmPYnp5bHEKHAfO6Y2nlCYAywuyMmXDb0lv+oeCDws0d2CgJ6M3KkuIWGQvH6cGRKp1YEbORUTjZMlBOTwELdb3JK4ibJDK+wBAiObkisTe23sj7v5RvSXDV+iDlQZKFkObK7PAR+sD8xhciuPQCwxceW5GKnVKq5MS87uCeM9vp0w/rC1UUNUEYXspf7CnOQX52Infol3A8XRYo8gp/58JFxr19bz4AJk0mB7CEiRnS7cc1uR8/+vZv8Ax/Z5RCoFGaAMpo20zgIsVKB/GphBXlwmDOXWFzDQWB0HsPm+2lNwOLBRWhWduf1O7XUPpG/6iqjIuwhf9hpv5V+6kU8o6MDTsMEPMRF9DBmbZEqINL7etEtKzGLeQXt+M/boKUuh3qffRMxamjASEbQqKsjyJQqdz+lT28BhQeFjvmLXNq5LU8eLA7Z08vZwajxdjSGPWaBGdIOk07fcUgOQ8qfnbWalRoclrMcfSNvQDFQWTLlnyq69ohA54KzdAnnl1FE4bbDqIIXwfwLj2lZBs8aKuweDjKdXwGbEn6jLu9mqTN8VLQ+UgMAKjClN7ZND4PP1v7MytdjysLLvl5FZ2Y6QAjnlVA7AqgYpkEOylORJmDG22uM23aBdSKciRlgvXANzE7D2KECGrFsrce2xrgc3fwcuW6Y4ZpjVsgJan1T3WSjq/w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199021)(46966006)(36840700001)(40470700004)(41300700001)(316002)(478600001)(40460700003)(40480700001)(83380400001)(2906002)(36756003)(7416002)(70586007)(70206006)(356005)(8676002)(86362001)(5660300002)(8936002)(4326008)(81166007)(82740400003)(54906003)(110136005)(6666004)(82310400005)(36860700001)(47076005)(336012)(426003)(16526019)(2616005)(186003)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 14:52:35.5865
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 222dbb1a-d3dd-441f-716a-08db669daa5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5512
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
2.40.1

