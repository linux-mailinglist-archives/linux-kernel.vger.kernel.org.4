Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E32D6C31DB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 13:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjCUMjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 08:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjCUMjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 08:39:02 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4765FE5;
        Tue, 21 Mar 2023 05:38:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KEnKPOGcw6FNUD3t7rff2tCWtc8oDQEUG7+1vTZKstTmDRGb/rZFsx9BvmVBwb5WUQgzSSBuBvlz6hWHvZJFNw+vAjI0rjX4/ncqQj5fMfaxz3GwijATdP5c43t3HBooMBmjgzK85I0uIwgXsSO8UPjgj/Rd7Solyfuu9JggHSc+4A5tNGf04xRQn47aic7+3pNYdlZGwY5e7d+Q2jQ0MTn5lxYdzVO8Ocu+xBKsjpns+tiP7hHHV7oReaccP+50j1VAC4ntCNlVXjyU93xpqB21U7InDbCckiLeQOecchmcVl/ItB0B10IzTOOujK65E1Kr4A6eHtHV2vSzNkDXvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6WEEhg49v3+3iROgDmHgjFTD2ZPMS3r+TroKLngfkCs=;
 b=Lh7PI18Vj7yJjeQz9gYbBr9nS0AJkJiXXToLxz/V0K/LMq1RrRgyeBmOWPcpCTSLhOThDHV5/aTWjBRQZmNDIFcrfrvFl1HtPu36zzDrqhjdkdoVkAPiYZ34StO13tkaTZkx0fHO5Sosymrz9Cy0+N81tDL9AAnALbHS2uf2lerGe8+J/sZ/8Q9N0rgEAW+whBy8dcLyRdDllaotoG0k+DD/vAct7xUnmKPFbyerJismBEvZKTWY9iqmSa8fveJpsnP5AfjLoq4LAzo438FeNJjb2QIFn6t8rYunl5URxcD9onfqnBq/5OrDXJZloCBXN9KNDKMfiNzRM0Q9wV/vPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WEEhg49v3+3iROgDmHgjFTD2ZPMS3r+TroKLngfkCs=;
 b=E7VpHyKjdcGpbn0rwl2Cdkh0gAk8oSkE1KTxSo29Sw/hhaRd2uGfXw/iULNbVjNmGzN0YDS7Rk4s/XMyTjMPRwJPSohICYZ8WO8oCfIcMBI/jsuX/EQtgD76Fk/XGe2yGMKfkTlSUv1AMmLrXw4V0Ez2AGLXH6E2t8duL6H+PyM=
Received: from CY5PR15CA0256.namprd15.prod.outlook.com (2603:10b6:930:66::27)
 by CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 12:38:51 +0000
Received: from CY4PEPF0000C97D.namprd02.prod.outlook.com
 (2603:10b6:930:66:cafe::85) by CY5PR15CA0256.outlook.office365.com
 (2603:10b6:930:66::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Tue, 21 Mar 2023 12:38:51 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.204.84.17)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: Fail (protection.outlook.com: domain of xilinx.com does not
 designate 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000C97D.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Tue, 21 Mar 2023 12:38:51 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Mar
 2023 07:38:50 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Mar
 2023 05:38:50 -0700
Received: from xhdharinik40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 21 Mar 2023 07:38:46 -0500
From:   Harini Katakam <harini.katakam@amd.com>
To:     <robh+dt@kernel.org>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
        <linux@armlinux.org.uk>, <davem@davemloft.net>, <kuba@kernel.org>,
        <steen.hegelund@microchip.com>, <bjarni.jonasson@microchip.com>,
        <ioana.ciornei@nxp.com>, <likaige@loongson.cn>,
        <harini.katakam@xilinx.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <harinikatakamlinux@gmail.com>,
        <michal.simek@xilinx.com>, <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH net-next v2 2/2] net: macb: Optimize reading HW timestamp
Date:   Tue, 21 Mar 2023 18:08:36 +0530
Message-ID: <20230321123836.6906-3-harini.katakam@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230321123836.6906-1-harini.katakam@amd.com>
References: <20230321123836.6906-1-harini.katakam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C97D:EE_|CH3PR12MB8403:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aa76614-85d6-4507-6f8f-08db2a0939c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6vtQ0LfyHWAGEn7l91Pt+pnuIbIV3IMtRX1dgGC9trcjHuOV7q3QgX3zKznmydnSvzyqNvzylfU7/wSqXRt12YbuJa701G3ie9pLKIGnSx97Gugq9FpY50dAkGZN4/BEb51T7MdP3z6MoSa/NuYXbDOpD50Ym2dkUJY3JSASwdsaZxz6sVN+5I1tcgY6RQ7/2QbQvbfWm6l5E9TegHfj+jsTR7KjiCVsrm3whwms5taE9oN+1Ns1l3O5zk7eZriJV3pbz8tq44I57fOQu/P4pe3KAbwrhGhmbSl6MGGJEXKUnGPrTefD5cBaZ4Gfk5swnvu/j+dRTpcQPJJVbJR0jWxfybWubK83dNCSXKzmgDrwsK93yTMdtpk02egTRXmzFssTtFqm9QrzeZhHxg6/Ltp8IcQJJn465u/2QxDRpZzGgAdfyL9C1/bB1yAUHnQOiBYKVhRjHwy6E1JzWr4fV7t4tOuZm2WTUqnu7udBl6G7AHCSIba9U9ekJUgV/PfqlcrE6qeixh1dAGRM6dCjNlhpfltA7PL0wapFtATc2ZlU/RFL3Gg4CokpD4sRn5BP+Wsk9QrRH/Jvk2t4Dug/HSBqMkdw1+8JNuachGDlPvSft3vMQXwNbnv3zI1INRA/5LjOGs+pACJMm/ru/aEAjrjcmscL1QN8onFuORRfeecSqTwaQ5V5wBd1V8wwArWHc9uo5VvMG9AVDqC4Ykp3bRsaadsuF0pKtJ6OuXeMpUI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199018)(40470700004)(46966006)(82310400005)(47076005)(35950700001)(83380400001)(426003)(2616005)(42882007)(336012)(81166007)(82740400003)(921005)(83170400001)(110136005)(40460700003)(356005)(36756003)(8676002)(8936002)(4326008)(2906002)(44832011)(70206006)(70586007)(41300700001)(40480700001)(26005)(5660300002)(54906003)(1076003)(7416002)(6666004)(498600001)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 12:38:51.4104
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa76614-85d6-4507-6f8f-08db2a0939c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C97D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8403
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harini Katakam <harini.katakam@xilinx.com>

The seconds input from BD (6 bits) just needs to be ORed with the
upper bits from timer in this function. Avoid addition operation
every single time. Seconds rollover handling is left untouched.

Signed-off-by: Harini Katakam <harini.katakam@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
v2:
- Update HW timestamp logic to remove sec_rollover variable as per
Cladiu's comment
- Remove Richard Cochran's ACK on original patch as the patch changed

 drivers/net/ethernet/cadence/macb_ptp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_ptp.c b/drivers/net/ethernet/cadence/macb_ptp.c
index e6cb20aaa76a..f9db4501b995 100644
--- a/drivers/net/ethernet/cadence/macb_ptp.c
+++ b/drivers/net/ethernet/cadence/macb_ptp.c
@@ -258,6 +258,8 @@ static int gem_hw_timestamp(struct macb *bp, u32 dma_desc_ts_1,
 	 */
 	gem_tsu_get_time(&bp->ptp_clock_info, &tsu, NULL);
 
+	ts->tv_sec |= ((~GEM_DMA_SEC_MASK) & tsu.tv_sec);
+
 	/* If the top bit is set in the timestamp,
 	 * but not in 1588 timer, it has rolled over,
 	 * so subtract max size
@@ -266,8 +268,6 @@ static int gem_hw_timestamp(struct macb *bp, u32 dma_desc_ts_1,
 	    !(tsu.tv_sec & (GEM_DMA_SEC_TOP >> 1)))
 		ts->tv_sec -= GEM_DMA_SEC_TOP;
 
-	ts->tv_sec += ((~GEM_DMA_SEC_MASK) & tsu.tv_sec);
-
 	return 0;
 }
 
-- 
2.17.1

