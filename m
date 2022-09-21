Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135E75C0067
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 16:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiIUOzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 10:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiIUOyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 10:54:43 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8F1175BF;
        Wed, 21 Sep 2022 07:54:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1fU1PC7AWzIluX076xBRradiaoPoAYH/DOVCH9jpCk6cm3sVt1jUp1ae/EajhS1iwV63vkTB1W8SM+hTnzvxA/Pim4FpDLaKmjPR6guILB/wyyMMxtOF9wET7MCollrqI+QwsDuXjM4HfSyWEBM66YhzH1yr7fEOvQgQBhMpb6y2KMk6vhA+BVYK+Oy8DWz6z03jprjC4uxC//DkLz0cYkc0dT16y5rg/TNoXUK5QIjekpzqaq/0DisZZ3IOlRzWSgY1Vx4MNPJDBQaWqHTX59LLS98gYp770nbnV5hf9K7zl3W5Sg7KCwaLPNvSzO6VXJg7YHA+UpfQFrQ6XtREQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gtEEKX4Mqr80ZiaAUrQ4Xm3q8mimCTxh2KlKSHj9rsI=;
 b=AvMlYDZeQpUpm6k3uv2411y8hsd5tVKfDGmQp+zQhlncwJJSS/6eAVrc8kDhiKELC3saZ2JqEfyYTpRBBx2TGAkXNexsboNVJf6iCrrCkd0pBcNxFZ0olh6Y5zFNfr0GehYSh05fOim9LK4ERX1AQToBpwbLXxtWdK5fPl9/Fh1gX5yZMcDMBLZzJ++bWuzOfAAGXQfuEa2gAYqhvFAxl8kUi5B4ldDNJoAZTrWgrZ4q0s8Y1IVbnvo1fOJC4R9YghrMj9FUbn6d+yEzrdpvSQ6SzWL/MCDOzGmSuvnSMXtYDBvxjp/yFmCD820bzaTEX5YrnB0rM7OzD3/bNuZAJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtEEKX4Mqr80ZiaAUrQ4Xm3q8mimCTxh2KlKSHj9rsI=;
 b=K0WJIyUkv4z6NpaZoIJzb0PgD5WRgSJtlvVT8U90qm5eUzeTMrQmFK79lnHY3soRlPaAgG43qzXI47op3PhSg3sZdMRaQTaN3bsr9Ts+kYOzJjDj5+AFxFFrE4H4TZ/qDRlDVPTvNYOCp2AfhetyhJJ0TQ+Tf2pT5umv9ObOmoE=
Received: from DM6PR08CA0013.namprd08.prod.outlook.com (2603:10b6:5:80::26) by
 CH2PR12MB4296.namprd12.prod.outlook.com (2603:10b6:610:af::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.16; Wed, 21 Sep 2022 14:54:38 +0000
Received: from DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::c4) by DM6PR08CA0013.outlook.office365.com
 (2603:10b6:5:80::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17 via Frontend
 Transport; Wed, 21 Sep 2022 14:54:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT079.mail.protection.outlook.com (10.13.173.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Wed, 21 Sep 2022 14:54:38 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 21 Sep
 2022 09:54:37 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        "Yehezkel Bernat" <YehezkelShB@gmail.com>
CC:     <sanju.mehta@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] thunderbolt: Explicitly reset plug events delay back to USB4 spec value
Date:   Wed, 21 Sep 2022 09:54:32 -0500
Message-ID: <20220921145434.21659-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220921145434.21659-1-mario.limonciello@amd.com>
References: <20220921145434.21659-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT079:EE_|CH2PR12MB4296:EE_
X-MS-Office365-Filtering-Correlation-Id: a367bae9-8117-4544-8373-08da9be134fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uPZFPbfKDfcFwtQlGsCcSE5Mk5mmC068fca+nNsq9j4y4tHRqavz0d7XCKpkqhoiIN8Tp1aJ29IVrvgtV1Wfnk9vIG3kZpnyDAxHMBp6XL+uVxuwRRpo1KMiBnqs9LKI84HMxOmNUEo19phMSKzGl4NS1jY7/K3ckEoA/NNdAVQoYeOpL4P0QozpPUQn5t1123s4oKjoQ779It9ezOouqEpGjWooohCHQ/dgeogW0g8GcovclyH73QRx3lqD58/Jb1ExMKl3YzEj4C9mvbkOwa2iWdw21MVBeKE2RemmUy6HJeLHd3pzmpF0pDNWEZZSw38SXgZfxzXLRqNrHoEtuAtuy1LzbnYx3Pfb9o99sMawLCr7Nst/UcClnn1YYk4CER0+jMSD+i8j0BswlcmPjw8RGvanatUud8meL31m1Cf87Imhy2UH0gia+fz1yytcVrBDvAmhVAkQAYoe1L2y6Rf3AIbPy7o0H7t9qA4ky62LCKFKEH02o2ACg1mCJuZn1spIifzmHm8WvXuqMQ8NncHqNrWaf30n9ia7vlGsCqm9i92wDf0JgPek322uQcKz5sXLE5atnB831oof3pvSu9CXHCqpaNASUES2LzOZ3Kyn96vIGWcTnF6HXIl4M7jjw0elzDUEajVvKPskkSBPU5mH/NzfB6I4r20EXgTRGOfVDyTbioShAEbqxKLSH7oDmNFXMXSloxIGZvf1hoycv7OSV7sBtVxqWFhwvTrnbzT/LRChdVTrfdy0r3lNE4G8NM5SfRisjmlcdTCUTP03N3aLrOxP7GVtL8Rd8hGHpRHVev0NRhObCf+7WRWWdqEf
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199015)(36840700001)(40470700004)(46966006)(2906002)(8676002)(316002)(54906003)(110136005)(44832011)(4744005)(70206006)(40480700001)(70586007)(4326008)(40460700003)(82310400005)(6666004)(36860700001)(41300700001)(86362001)(5660300002)(8936002)(7696005)(36756003)(2616005)(1076003)(26005)(186003)(478600001)(426003)(336012)(16526019)(47076005)(81166007)(356005)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 14:54:38.4229
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a367bae9-8117-4544-8373-08da9be134fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4296
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If any software has interacted with the USB4 registers before the Linux
USB4 CM runs, it may have modified the plug events delay. It has been
observed that if this value too large, it's possible that hotplugged
devices will negotiate a fallback mode instead in Linux.

To prevent this, explicitly align the plug events delay with the USB4
spec value of 10ms.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/thunderbolt/switch.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index c63c1f4ff9dc..77d7f07ca075 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -2413,6 +2413,7 @@ int tb_switch_configure(struct tb_switch *sw)
 		 * additional capabilities.
 		 */
 		sw->config.cmuv = USB4_VERSION_1_0;
+		sw->config.plug_events_delay = 0xa;
 
 		/* Enumerate the switch */
 		ret = tb_sw_write(sw, (u32 *)&sw->config + 1, TB_CFG_SWITCH,
-- 
2.34.1

