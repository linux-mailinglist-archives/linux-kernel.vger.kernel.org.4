Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74AD733B7B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 23:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345565AbjFPVXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 17:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbjFPVXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 17:23:04 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9B935A4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 14:23:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNuuoDtkzLQzhKxq6OukWIDKpGnI7vpR4jmumm7IC8ax06VF9zEMHNwce7Oaxv6BexbNLf3bkq3MLgjdXW2SHgiHMujKnPTOLkxuaAC7babHT8H7lctAIsnf6qJlUhwdCTasYWh2osFRO0+en3kPPUscrzxy+AZRyi1ZOrJAc9l7rRf3qTMdofj9GXu+/veSo+X+dt6D/7mEv3ZCqEvhAfcV9+p4bpFrZwvt1N8plP2yLdGn8NgDVpftBayZ8qc/b9neTaiOh5Pe/Z5BwEl07AOZTf+FUyxMRXIM6YmwINqAGff2b4YYzCHTnozzvsrKgUSc05yakxgYV/LIhxEfBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHlr56+BQ+akgWPp2dv7cU/XNy38bRGVETHmBhTazgA=;
 b=eezuF3T5OTDraomdyyekI+rnV1iGYoyFklGSe9XLot+p5Xt2zm09hgaDkR9p72G2xAo4weMpd8bQqTGEw81XXTiC1XypVY0fmtfwzocPXVqt5QzpFymG9uV3HOBqvZWyWH1kD2urNljBUMitLt7CIfEsVkcSeU1Vzn8SakkrOENxDDdXkOPNSH47fItfRhLDYCQrtSOTpmGafXe8cqRAQHHfjSLgNRuOM0wpjbxv1vCXrLkmRZaKZzjnIgPxHgo/xd6l/9mMSADflDPrh+zZZ9UbTIDg54iGjy6nffpYeUqVZUI9o9hxArZPxMWJhd5/GjToiVn1iTygL+hRiFx3FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHlr56+BQ+akgWPp2dv7cU/XNy38bRGVETHmBhTazgA=;
 b=TF6qWp377FIB9+bruHtNvD3HOOfKIqT3emPW5rvJIDdPkXB8D4Ij4JjxAvy+6l+Cm616apfNlRcwy6Jz5OPbbuyxA9Ha4FDQO86OmhfQg2Qd5qSRznMgTwLZn9/8gkY0qRJvJy8Onh6/9cuDM2YImbhWQ4eyAIOPyBfvnAHFOeI=
Received: from DM6PR04CA0001.namprd04.prod.outlook.com (2603:10b6:5:334::6) by
 DM4PR12MB5866.namprd12.prod.outlook.com (2603:10b6:8:65::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.29; Fri, 16 Jun 2023 21:23:00 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:5:334:cafe::a4) by DM6PR04CA0001.outlook.office365.com
 (2603:10b6:5:334::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27 via Frontend
 Transport; Fri, 16 Jun 2023 21:23:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.27 via Frontend Transport; Fri, 16 Jun 2023 21:22:59 +0000
Received: from BLR-L-DHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 16 Jun
 2023 16:22:55 -0500
From:   Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To:     <linux-kernel@vger.kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>
CC:     <hpa@zytor.com>, <gorcunov@openvz.org>,
        <suresh.b.siddha@intel.com>,
        Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>,
        "Kishon Vijay Abraham I" <kvijayab@amd.com>,
        Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v1] x86/apic: Fix kernel panic when "intremap=off" and "x2apic_phys" are set
Date:   Sat, 17 Jun 2023 02:52:36 +0530
Message-ID: <20230616212236.1389-1-dheerajkumar.srivastava@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|DM4PR12MB5866:EE_
X-MS-Office365-Filtering-Correlation-Id: 4547be4f-d844-4d87-4919-08db6eafdc7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H3iMB9PVU7R2l6/b1Zg1biAL4Nb1T3IzMdyFqwGP5Pe7kYfhGSTTF+npO5z4b21ksZIv7EiusxmyV0l98lIKsmgUAgY5owokANsQvcqdsc2FoeUMDSP5kcEFgWpQWlKS3H32VeYiBd0GYlPwE6uQJxyJFnrTzy2h3UCUG/HY5TAKl+bzyW3K5s5O0/tqQsVT0zSyhlOf9zn+EIdhESg5CV2r6j9+qTg8FW/ILDbGFTvp6b4ZI84rVfUsWMvF0Z3Rp8VmNr5yMFAIJfHSR0MOcUgdHtrbb6tP25IFtp41Ls0Rheifbk0bmCTzMF3FHuJBYypAAKAuAqEDZKS3qct6APqjhOBHBZ6CAo0n72iubuhrgUWjiFxH8lgt3lPgV/NXGZsFvEKHm0ixEH9oVMvdWLkxGR7tHW/l22xE5UITvFoSs+9M8amrOPhFnFb6DrAWxn6ClP5iN37n4yd04BVOLH2BQyHYTwSA3NYMJKo2wUiHuD4mst8CoRj5IKCMtdtbgC/Anj1HBBZzNw6KIaRCtDQSqRXMZ7pi3VxSyBdiCl/RMHvVQe0nQ1T6r7Xb4LFwQk3tH3aJswy69OkLyKzLz4srEk+wqxR0SoWaH1GaydqxogEWSmudXaFMwOKCWuT755B4P5kFbK6Cbu9c5aHczdlEL4wl8URhFjKWM+Q1NG1lrhWdLgtOhBPrnK+KEMXUvrZT+hL4mf89EtO7/3zRn5K3MnZCxBliFO/qt/dr1+Rz6e9b7MuegxhzSiTB4rBdZASxuHDtPySRQbwfV1hSSIPgdV+o/dhn6mdlLeruW7KBR5NJUbem0lEoHzPVbRUv
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199021)(40470700004)(46966006)(36840700001)(5660300002)(54906003)(478600001)(40480700001)(8936002)(41300700001)(7696005)(8676002)(316002)(186003)(110136005)(70586007)(70206006)(6666004)(4326008)(26005)(1076003)(16526019)(36860700001)(2616005)(47076005)(40460700003)(426003)(336012)(2906002)(83380400001)(82740400003)(356005)(81166007)(86362001)(82310400005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 21:22:59.9559
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4547be4f-d844-4d87-4919-08db6eafdc7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5866
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

x2APIC mode requires "Interrupt Remapping" to be enabled and the
"physical x2apic" driver can be used only when x2APIC mode is enabled.
However when "intremap=off" and "x2apic_phys" kernel command line
parameters are passed, "physical x2apic" driver is being used even when
x2APIC mode is disabled ("intremap=off" disables x2APIC mode).
This results in the below kernel panic:

  unchecked MSR access error: RDMSR from 0x80f at rIP: 0xffffffff87eab4ec
  (native_read_msr+0xc/0x40)
  Call Trace:
  <TASK>
  native_apic_msr_read+0x1f/0x30
  setup_local_APIC+0x4e/0x380
  ? zen_untrain_ret+0x1/0x1
  ? enable_IR_x2apic+0xe8/0x250
  apic_intr_mode_init+0x4c/0x120
  x86_late_time_init+0x28/0x40
  start_kernel+0x626/0xa80
  x86_64_start_reservations+0x1c/0x30
  x86_64_start_kernel+0xbf/0x110
  secondary_startup_64_no_verify+0x10b/0x10b
  </TASK>

This is due to an incorrect conditional check in x2apic_phys_probe().
Fix it here by returning 0 when "x2apic_mode" is not set in
x2apic_phys_probe(). This now prevents default_setup_apic_routing() from
selecting "physical x2apic" driver.

Fixes: 9ebd680bd029 ("x86, apic: Use probe routines to simplify apic selection")
Reviewed-by: Kishon Vijay Abraham I <kvijayab@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
---
 arch/x86/kernel/apic/x2apic_phys.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/x2apic_phys.c b/arch/x86/kernel/apic/x2apic_phys.c
index 6bde05a86b4e..896bc41cb2ba 100644
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -97,7 +97,10 @@ static void init_x2apic_ldr(void)
 
 static int x2apic_phys_probe(void)
 {
-	if (x2apic_mode && (x2apic_phys || x2apic_fadt_phys()))
+	if (!x2apic_mode)
+		return 0;
+
+	if (x2apic_phys || x2apic_fadt_phys())
 		return 1;
 
 	return apic == &apic_x2apic_phys;
-- 
2.25.1
