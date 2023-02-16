Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75230699D8E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 21:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjBPUTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 15:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjBPUTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 15:19:38 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A750752CED;
        Thu, 16 Feb 2023 12:19:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1pdpuD2vlCVDUNSDy+fTT8ZfZIx3IGmfXr3UD+BxA5qWclKxLtWLhbUd21lWLe9cNOWhE5FmvlkIzpmsjtI8aj4NcoZoh5ifZeqcTv0tlJV/D0MHllAZNwmLsQc4NnYrdUwndIzIptSHrXodvLmu3jl6PCM6Xho1Kvl+9dkVA1Hg8nrnINWU3VuC/oYQszgdYRYpjwPWTB7sc9glgFW8JFdOIt01ZPolUkJ/NGrU8hFpiGhY090HEOxEPWj51JcPY6KvWyKHriV7QIdHPfxl2D0I7L/K2XU7TfaQlQ+Iuavw4lwuSlKyBBaEbkeIr2PAGXAmJdzT2BVa4JVsR4QWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJ9f0hbEZsZcMLsiZ8NXXy5FHxSK8VWeY2TvRX3djog=;
 b=WrFi2JInC9f/QdQ3EGN8e1WsPMWzWySjnpXOR/D9fnxtTx0lGoxZHDwnldu8TkVtBOm0UWO398kIzlVpDxsq7oSzklccqloB/Me5UNsXs7e0qFVv5tMd8WN2y/CnV0L7dfrr0apeFmJBvipWqYKBQke5cn8HLGtyvXkNYxPvo1Ez2/6l+XgXHxe3ergLPetGU6h3CsVDXe65fvBP421RcLnzWw7Xn7P1512jYepds+h3AA/Z694kxt6nSDkYevl2obJwUSHLnoK7CZYOgpbFi/RNMTxwPAmy+QzkJBiLqcgcmt2R6JzKmDa+E5tukRIY9dki39zi3XvuUnSxDVpT9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJ9f0hbEZsZcMLsiZ8NXXy5FHxSK8VWeY2TvRX3djog=;
 b=slgh2PXiuHvopBRNQmpNpjOh7kE5R6ne5FeNny6GXhhnm2ci16xLg8a0M1Z4hiikBYbgE2+SQWOUHVJ4dhPZ4bzVXJ1odd0gvHAg+urkPws5ASWuAifEO7hVZz5bMR+IWr9xDGH990xqyl+gRaqUQUf4R6gstrktPMRjGBddQPk=
Received: from BN1PR12CA0014.namprd12.prod.outlook.com (2603:10b6:408:e1::19)
 by IA1PR12MB6090.namprd12.prod.outlook.com (2603:10b6:208:3ee::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Thu, 16 Feb
 2023 20:19:31 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::21) by BN1PR12CA0014.outlook.office365.com
 (2603:10b6:408:e1::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26 via Frontend
 Transport; Thu, 16 Feb 2023 20:19:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.13 via Frontend Transport; Thu, 16 Feb 2023 20:19:30 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 16 Feb
 2023 14:19:30 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
CC:     <Sanju.Mehta@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/3] thunderbolt: use `tb_eeprom_get_drom_offset` to discover DROM offset
Date:   Thu, 16 Feb 2023 14:19:09 -0600
Message-ID: <20230216201910.12370-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230216201910.12370-1-mario.limonciello@amd.com>
References: <20230216201910.12370-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT043:EE_|IA1PR12MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: 54cbb06a-7297-4317-7479-08db105b1c81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RE5pPdlFMtpkQ62p9mLXJxGLizrm+pX0QLzBJz261u51xiGVi+5datBQDanvzYT90ghLIVlBE2gfjJQnERDGFsedxCQEXQl09nBIlhMKjjwGjKIQ+4fnFZsemOWRnF1slE8S6iMRtFXFg2OYlbQfhk9Gb7LIfQCuAwixLuL3Mz5GXX+5rgMH2gYlx7feyDv/Oz1fhMcLrU1nVMR4+jPHXEAWZfF9g7qLN7Sem11mySoE/4BT+2qBrJGS96jIbd6DisBLY6x6CPW9Zi4FE1ZPwaccz0s3cRGuNXXY9xpQC/ZiWkGwfKKTCh2FYvS2YvKUQbdAVUYlEkrQCXkw6YOenG+44ZjG5SyydUnxreSIWzsl8UA/ylVj/9gRdXP243WmV5zJ4o1a/9gvfCp4/ZU6JqpQv8MNaX7HYP2haxsm/cDve201kPtTK0bFOpaQA5dMXqi9UjcR9C5kLbXyE/68JLdOCk5haf4X4D7T5cjet0PJDjpsT4GuTaiJGHRDm6bXGju3NaiNbuQFKOyN5EmcrNDG04yV5UsC5HYpXCCb9l9p49lUs+LlrIlweGW3ulvXHBfL9aW5RuxXC8T53SqA9oFlj1ewt7oWlIcQ1T6MWI1LrnmFYrk3ozB/AtGNT4h9pypgEeIkZOFWcKsNEgsw2JPIJqo+PiZjgsTcBPBsAAMSk2JkhspZ3kxmmBIt7x5y95anN+D5X8JwVwi/HuYUnvW1DAwP+1tZhqY6l7jz2j8sygcsZ7VZbqgu+MPGZ6MK
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199018)(46966006)(40470700004)(36840700001)(40460700003)(40480700001)(47076005)(2616005)(26005)(36860700001)(54906003)(7696005)(426003)(16526019)(6666004)(186003)(336012)(1076003)(82740400003)(356005)(478600001)(86362001)(83380400001)(2906002)(81166007)(36756003)(5660300002)(82310400005)(110136005)(70586007)(41300700001)(8936002)(4744005)(44832011)(316002)(70206006)(4326008)(8676002)(81973001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 20:19:30.8902
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54cbb06a-7297-4317-7479-08db105b1c81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6090
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The static function `tb_eeprom_get_drom_offset` has more safety guards
for the DROM offset fetching.  Use this instead of just `tb_sw_read`

No intended functional changes.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/thunderbolt/eeprom.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/thunderbolt/eeprom.c b/drivers/thunderbolt/eeprom.c
index 177bc51316f7..a326cf16ca3d 100644
--- a/drivers/thunderbolt/eeprom.c
+++ b/drivers/thunderbolt/eeprom.c
@@ -471,14 +471,13 @@ static int tb_drom_copy_efi(struct tb_switch *sw, u16 *size)
 
 static int tb_drom_copy_nvm(struct tb_switch *sw, u16 *size)
 {
-	u32 drom_offset;
+	u16 drom_offset;
 	int ret;
 
 	if (!sw->dma_port)
 		return -ENODEV;
 
-	ret = tb_sw_read(sw, &drom_offset, TB_CFG_SWITCH,
-			 sw->cap_plug_events + 12, 1);
+	ret = tb_eeprom_get_drom_offset(sw, &drom_offset);
 	if (ret)
 		return ret;
 
-- 
2.34.1

