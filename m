Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39A36D6A8F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236249AbjDDR1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236335AbjDDR1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:27:22 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20609.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::609])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79AF6E8C
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:25:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mh7RVM4kiD3uBi/GWrtM/heUFRc7fUTeKPxMGB2OAGs5OQimZS3emRRYC+PDuuUg4An/yCedC3LXd7/5Yh0975IeFzBVGIGQ0ZFwt9cdjpk75Clz3JBmDcupRXzBbYoa5WN1aXAHdOQTkEG9Vy3+dkEZuLSLr3Pwt6bkJQKU9jibL3kC/DDDt/ttVMq+FY38KTXBufGbKkjvC3lmHJNAlzUKHX5RKr6WKSDxp1iVFXNCtiViiAbUY/eBwZngkINhbixLsBkTcsHdgD5m8MKQXYkuwlNOHFk5Re7JQH0+vAP6we/EyADiATXlKyE3fgpD4YDy52zeL0ujul2kja8Pcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ua/JAhWpwRQN24wUKwp/qKfiLdX/ukBXUDTLahHI7u8=;
 b=iT8Uu/CeH/RPu259Gje/agnGo2F5qR3PQ4F3qOhEFeaNR8aVUn4i+4IuezP3GTtI+7zpwn+LpaVA4VpTtu6nwh0vbmTkHYH/GHBkAzdAphPc399ukFtZy2E4OFMG/JnVATdzLv3kKCCVWnrpgZdcCuUfdTh/sW0Qo+gr8nPKhrF6rvUOnoa3MFUtk9bkHr8OTmeyasrbSlMKK91ajVMjA7+sLpwCmYLo3xGU6tJBkRQAt7q4Y0nHciEgcihNHFpxHm30wLWaZ31IeSQI0q3vYan9LEbT2uFG9D1llnMXN/7+ToDdaVVMu8O+7MhHUkedRmex6vRYqt6LzduM9vL4KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ua/JAhWpwRQN24wUKwp/qKfiLdX/ukBXUDTLahHI7u8=;
 b=0dvKFOeyPE1EnzIYZQM+TlYTTydEZwm035sHKM4kPIWQ7DPBsMklGyOcoj4L6/0Z5h3/X9t/i94EblxMysUBIVyctx+tnYMHlscpnEgIvly+6MZrUtItUlNcx8L1Y1W0bmU7XA/KB6OTD1uJAiuAxGgtf4HLVdoEtkZsCuz/DhA=
Received: from DS7PR05CA0101.namprd05.prod.outlook.com (2603:10b6:8:56::21) by
 PH7PR12MB7892.namprd12.prod.outlook.com (2603:10b6:510:27e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 17:24:10 +0000
Received: from DS1PEPF0000E641.namprd02.prod.outlook.com
 (2603:10b6:8:56:cafe::d0) by DS7PR05CA0101.outlook.office365.com
 (2603:10b6:8:56::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.28 via Frontend
 Transport; Tue, 4 Apr 2023 17:24:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E641.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Tue, 4 Apr 2023 17:24:10 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 4 Apr 2023 12:24:08 -0500
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
Subject: [PATCH v7 6/6] x86/efi: Safely enable unaccepted memory in UEFI
Date:   Tue, 4 Apr 2023 12:23:06 -0500
Message-ID: <1d38d28c2731075d66ac65b56b813a138900f638.1680628986.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1680628986.git.thomas.lendacky@amd.com>
References: <20230330114956.20342-1-kirill.shutemov@linux.intel.com> <cover.1680628986.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E641:EE_|PH7PR12MB7892:EE_
X-MS-Office365-Filtering-Correlation-Id: d218344c-abf9-4398-b8b4-08db3531673b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RZPSbBTGGfskKqXaaRVUSrkmszox9WKemfNijB+J6rvHN29l725paMEm55qnFVbjyIutH29jBVG3n7QuPd4Ei/zb2mA7KS3MnVIGwvbAW8/JAheKZw3Fdo9I1IO6Ht6tTVRwuEhkr1UwjLmhybFl9Nok/a+gzoJhT+BlLM3FCM0SGRFY7FeqCjg2V5xKooygI/PvvdE1Nus6ecwEm99SmhGA4Wmf2Z2tbzPC9y2SlnWQ8F/wes0FwubfWQwbcyvPLAm5L/Myh9RnXPNKAaLsU8/c2F6rxwBYAi7nIQHCHr2o35SskfrKr7XNg0YUErRzHZ1oUReVKpJ6/t7jpAlCL71FOtKeH/ceYdg3kxpJdXuPsdu9bkL49FwV9ikenVFqlACYFyGry/6XE0Fo7FOmE3+GaELWfpYP+c9io5fXKPQfuX3Md0QFMO/n73tZ5mEXkShGJ5pk3T/E2baaGRHolA6cK+m2vj2WeoyhsGuLFxj9HKFY5iilWdpKv0MjLwvkfWO4IJ3rTx4Pa6xQcognGSVO9oSB/n/5i77LqJpUIP8IyR0yjNylDJIHhC3izqhtMRnotVS8xDumPBA0J39GkCxNek/xvp2/dCdGVLxBFTDMIsCCpeJ/L2txc8Sk+YBX7jH9Xkm8+VhljhlCW1QUfPDjtiloL/be0eOqIg7DZ8a574HCwykbkOqh6oHfuiphO9uqQXlpUOypWXOIEa5kLxtqWPZxsx+DBrol88oOTps=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199021)(36840700001)(46966006)(40470700004)(86362001)(36756003)(82310400005)(2906002)(40480700001)(336012)(2616005)(47076005)(186003)(83380400001)(426003)(16526019)(26005)(8676002)(4326008)(70206006)(41300700001)(70586007)(36860700001)(478600001)(40460700003)(5660300002)(7416002)(82740400003)(110136005)(316002)(81166007)(8936002)(356005)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 17:24:10.3756
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d218344c-abf9-4398-b8b4-08db3531673b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E641.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7892
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
index 1afe7b5b02e1..119e201cfc68 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -27,6 +27,17 @@ const efi_dxe_services_table_t *efi_dxe_table;
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
@@ -311,6 +322,29 @@ setup_memory_protection(unsigned long image_base, unsigned long image_size)
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
@@ -967,6 +1001,8 @@ asmlinkage unsigned long efi_main(efi_handle_t handle,
 
 	setup_quirks(boot_params, bzimage_addr, buffer_end - buffer_start);
 
+	setup_unaccepted_memory();
+
 	status = exit_boot(boot_params, handle);
 	if (status != EFI_SUCCESS) {
 		efi_err("exit_boot() failed!\n");
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 1d4f0343c710..e728b8cf6b73 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -436,6 +436,9 @@ void efi_native_runtime_setup(void);
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

