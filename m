Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9EA62C2D9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 16:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiKPPoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 10:44:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbiKPPn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 10:43:56 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2066.outbound.protection.outlook.com [40.107.101.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3776260DE;
        Wed, 16 Nov 2022 07:43:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSWZGjs2+cfRJufwn8ovpsDxwQ6PNokjPeXgUAOygyvhuKvc14fVpo6D93ljkiPBjGBY31SOJB+NfDzUIShRm9qhOgvk0iMBaORxX5IOqIEKtx6DlFTSAC/Xp6LmdeoB1pRJg3ySdpr1VfroyxEgqWqWXX/2Me1noNblaUOUYxLjyw7NkYpXrqZE+izl1vk30M+R25q5O+s/3JM8rZdPyEZGg8bNQDPRaOBgc0gYmi+y2VYYg6X1SR0H3ziMZOHvucyNmwF0U+rsZmTqSshr7f2w5gqny2zXUK6TcS99ot71W3Le/GN6iTGx5iV+imc4U/m5MllR6a3HqJd689mKDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=STTiHUo8HIMpX7pk6HDBH9HnJDDNVjYT7KMdGMeEF7k=;
 b=ZPX7wkSDST3i1S0XVweNS8Rr4dG8pF59hTfGiirB9+r5xJhjRMXX/yhR2JBHpBcCeg4ZyU5JVPf9dVZZrSJNhwFheUXeSzWI3RhAmxTdrJ3UA0Xed9IFSlUlYH6y8I9dxXjp0asosYLSlZcQiaxcjQtex0QcwDqDG+g21bRTYKeggZcHjnhdh3k3+8RPHj567pRRbtIph6AfDaQnfhq6kR32zTp1TGUre7rDztysBtJXRqxikzcFKZmaa2P1dbmypXgmHkrqwswrllMv7J0J28zzqIfUagor08LqFUUPBhe7NiI6hawpP9mCvB9LMw4z0HW5qAldoFcYLHumkdzLUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=STTiHUo8HIMpX7pk6HDBH9HnJDDNVjYT7KMdGMeEF7k=;
 b=mx2F5EcPUW5ix6oT4IdMWAWjRtcWs60JPVqkUvuruSZvKRVuHatSzzfGWdr0Sw1UVAWNWCe1ATerWvXsdnhHbQL8ymvBofEfLPYB4t7REI0vHiubR5si686z36JitrxBxaI4eYhOPkcBvX9ZaKj3vCrLrU6XmUFuYr0H6hu3Wpo=
Received: from DS7PR03CA0121.namprd03.prod.outlook.com (2603:10b6:5:3b4::6) by
 DM6PR12MB4577.namprd12.prod.outlook.com (2603:10b6:5:2aa::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.18; Wed, 16 Nov 2022 15:43:53 +0000
Received: from DM6NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::7c) by DS7PR03CA0121.outlook.office365.com
 (2603:10b6:5:3b4::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Wed, 16 Nov 2022 15:43:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT113.mail.protection.outlook.com (10.13.173.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Wed, 16 Nov 2022 15:43:52 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 16 Nov
 2022 09:43:51 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
CC:     Mario Limonciello <mario.limonciello@amd.com>,
        "Mahapatra, Rajib" <Rajib.Mahapatra@amd.com>,
        Raul Rangel <rrangel@chromium.org>,
        Mark Gross <markgross@kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] platform/x86/amd: pmc: Add a workaround for an s0i3 issue on Cezanne
Date:   Wed, 16 Nov 2022 09:43:41 -0600
Message-ID: <20221116154341.13382-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT113:EE_|DM6PR12MB4577:EE_
X-MS-Office365-Filtering-Correlation-Id: c9ede0d5-6542-4e80-141c-08dac7e95cdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x10UUJ8Jx8mH6pwcy0diDKkfslVsvd/zOKOuQhgdz/Q4Oe5FQtZU2W8Peq/pV0An2KsW+yzXyZY4OtxzDDU3hLBRleZLZ9snSIfc+lUSlZCGKD2X71iWt3KC5ZuxaW1UvZfk+zKICs+IQEpZfGWlUqpHKzuCZPgpqK2qDKdhZQ6v907dlbbkwjNsykrz1nuYyZJ7iH2D6SYgf613YOQ4ex9J4QsNNQ4jYGXJNmUfTdvplc1uogcWEPv5Ol8vierxJ0kmfQqjos1WfMBFFEVF/niWnoUUQLCI9prA2M8g6Q9VIGmVa3vyZarsuUIIIe4Rxy/WjQ2Lo1HoEfJRcIbEHGRdtwDW4dLJnowctr7nJrzDuEkMIzAGaoihctOajVy5MfMWSxSrZAedFiJFtsJglC4C7bl+SqVzs0/eyp1Y14A+kTmkYm8MHdwOaNYbJEh9YYzqQwJMTPPNqZbjRaSNMH0JoBJ38y6CeMl8uAXJzXmVY/SPdpJDNNNMizTvtf+xrpOgM98GHvq+9k1nejd3JXX6Xec8PVP8wreBJr6Vj4GYp0av97Ij2GNX35IVNGKNrTObBS7Zcz7k8tRz1yNBvkZp1WiuQeM15EtBOccZQlstNLxFGAVcC7bjcM4lBsCCsNufWNqQb+3oH6HFjQt9V3sY4qqhcx8aMDgMCn1nw7eJOxRGahL6xdhJvhzWLtr88iW0Ul8ux8afjyWK7mTyOnL4ikRaQx8gueN3kDI7iDn1NV28kRUj3FybBVL95skB5uPxHb5RtxSR7RaLg08v2ZjN8IVSHRXQQXFrqptpU1DoQ4+cAegJOam3xlUvhDwF
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199015)(40470700004)(36840700001)(46966006)(86362001)(40480700001)(82310400005)(4326008)(8676002)(40460700003)(41300700001)(36756003)(16526019)(2616005)(186003)(426003)(336012)(1076003)(70206006)(70586007)(8936002)(5660300002)(44832011)(47076005)(110136005)(6666004)(26005)(7696005)(478600001)(54906003)(2906002)(82740400003)(356005)(81166007)(316002)(6636002)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 15:43:52.4996
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ede0d5-6542-4e80-141c-08dac7e95cdf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4577
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cezanne platforms under the right circumstances have a synchronization
problem where attempting to enter s2idle may fail if the x86 cores are
put into HLT before hardware resume from the previous attempt has
completed.

To avoid this issue add a 10-20ms delay before entering s2idle another
time. This workaround will only be applied on interrupts that wake the
hardware but don't break the s2idle loop.

Cc: "Mahapatra, Rajib" <Rajib.Mahapatra@amd.com>
Cc: "Raul Rangel" <rrangel@chromium.org>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/pmc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/platform/x86/amd/pmc.c b/drivers/platform/x86/amd/pmc.c
index ef4ae977b8e0..439d282aafd1 100644
--- a/drivers/platform/x86/amd/pmc.c
+++ b/drivers/platform/x86/amd/pmc.c
@@ -739,8 +739,14 @@ static void amd_pmc_s2idle_prepare(void)
 static void amd_pmc_s2idle_check(void)
 {
 	struct amd_pmc_dev *pdev = &pmc;
+	struct smu_metrics table;
 	int rc;
 
+	/* CZN: Ensure that future s0i3 entry attempts at least 10ms passed */
+	if (pdev->cpu_id == AMD_CPU_ID_CZN && !get_metrics_table(pdev, &table) &&
+	    table.s0i3_last_entry_status)
+		usleep_range(10000, 20000);
+
 	/* Dump the IdleMask before we add to the STB */
 	amd_pmc_idlemask_read(pdev, pdev->dev, NULL);
 
-- 
2.34.1

