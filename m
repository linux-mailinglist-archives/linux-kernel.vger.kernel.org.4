Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617AE6D6649
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 16:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbjDDO46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 10:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbjDDO41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:56:27 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2074.outbound.protection.outlook.com [40.107.15.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B941710
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 07:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6fXCbHRRVft0iNX+9haj0XnVGCo0rNodsR7gxZbNqA=;
 b=h6VTEWYXkhYUEIVVGwqlL4r8mbnmtBAlGu8jqPJ+wwF136kQa4l0wZ5YL3CH6X8C0yxQhygS8nuPTLq04e+9Q6/9yV0UjY0B+QSzw5JmI496nMyCoNwX7eUeI8fHtHH/2/9TlnytjYYfVAAEDEJF8xsB/89PgwOuXeNKOlKoL7nXkn22pXgSnjd2O9vRcEt39YhITJyAdFG+reYy+qf5NRd+tVw00IDsqCETOuW3YcIcC3lUh1+GN+kkZfx476V9RkrHoOMthxDNFaO4j6pV2KqiEzMrVRfGZUyOqO/TrdTevN/sCeOrB35XhoRatZdbm84tQ0uD2HUFu5sZ7hpcYg==
Received: from FR3P281CA0106.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a3::16)
 by PAVPR03MB10141.eurprd03.prod.outlook.com (2603:10a6:102:32e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Tue, 4 Apr
 2023 14:56:16 +0000
Received: from VI1EUR05FT040.eop-eur05.prod.protection.outlook.com
 (2603:10a6:d10:a3:cafe::9e) by FR3P281CA0106.outlook.office365.com
 (2603:10a6:d10:a3::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.28 via Frontend
 Transport; Tue, 4 Apr 2023 14:56:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.86)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.86 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.86; helo=inpost-eu.tmcas.trendmicro.com; pr=C
Received: from inpost-eu.tmcas.trendmicro.com (20.160.56.86) by
 VI1EUR05FT040.mail.protection.outlook.com (10.233.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.45 via Frontend Transport; Tue, 4 Apr 2023 14:56:15 +0000
Received: from outmta (unknown [192.168.82.135])
        by inpost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id 6F40B2008026E;
        Tue,  4 Apr 2023 14:56:15 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (unknown [104.47.17.104])
        by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 5117820080073;
        Tue,  4 Apr 2023 14:56:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nb1hd/f46N944eMjMaw2gsRIALgbOOAxwYld7aO7TGXlR78q40E8fcJ9Q0OrJEI/Z5yCDsShuSSmj/GgU/xLj9QuCQHHUjg2TLY7PrtrA7MalvYcesRFsMbsyAIdjD6cKGTTxRhQWDYfMeeDTykqpZ6fxy1ZU7BPJwm/XxjRVpA0DLYK6DVqeUatyjAHW4RXLp0Srj3w7t0Mf9ZV5uZrTjgl4HjWDO6L1gv1KPqax71U9FBlmSLhXIop5Jk5VafCuabwjLBL2kZ3qnMNALOZTOL6Yryh/KDMolgEDwznzu12Widhqb8rQn0LJdC3qsHZRZ49RoEy+7QlgiA01xDEKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6fXCbHRRVft0iNX+9haj0XnVGCo0rNodsR7gxZbNqA=;
 b=KPCZ9JepjTpuCNzN4fgMQSf1ZU+SODHYGoo+8ibqu0cvLo8usGO9Xa+8BlhZrYSaYWQWycsvFICthLKqfc2wScxkbUmvJQGNrWH889WHsBmbe4UyhkGmLol9eLBBsPoO2WB5ZGuH9IXd0IVrdtpm8gm+glty+zUq0iB0zYul8rgeJD9zKAxDKpjjR9PgpBky94WQR+8ZRxVurQyQBsplRElfDGl+66MY7V7VwLFyLlJvOBRtUvdcn66o1OZ7tTnAGlFuVfw8GBktKWElZ8njvp4a1q9XJsMUVsd1TXapQaVtL+O4Ju3jDIZ3qaIza5vyBStxWLVak7aj61sy8a67Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6fXCbHRRVft0iNX+9haj0XnVGCo0rNodsR7gxZbNqA=;
 b=h6VTEWYXkhYUEIVVGwqlL4r8mbnmtBAlGu8jqPJ+wwF136kQa4l0wZ5YL3CH6X8C0yxQhygS8nuPTLq04e+9Q6/9yV0UjY0B+QSzw5JmI496nMyCoNwX7eUeI8fHtHH/2/9TlnytjYYfVAAEDEJF8xsB/89PgwOuXeNKOlKoL7nXkn22pXgSnjd2O9vRcEt39YhITJyAdFG+reYy+qf5NRd+tVw00IDsqCETOuW3YcIcC3lUh1+GN+kkZfx476V9RkrHoOMthxDNFaO4j6pV2KqiEzMrVRfGZUyOqO/TrdTevN/sCeOrB35XhoRatZdbm84tQ0uD2HUFu5sZ7hpcYg==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by PAVPR03MB10144.eurprd03.prod.outlook.com (2603:10a6:102:327::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Tue, 4 Apr
 2023 14:56:10 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::2226:eb03:a8c:a7e5]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::2226:eb03:a8c:a7e5%2]) with mapi id 15.20.6254.033; Tue, 4 Apr 2023
 14:56:10 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Li Yang <leoyang.li@nxp.com>, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Camelia Groza <camelia.groza@nxp.com>,
        linux-kernel@vger.kernel.org, Roy Pledge <roy.pledge@nxp.com>,
        Scott Wood <oss@buserror.net>,
        "David S . Miller" <davem@davemloft.net>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v3 1/2] soc: fsl: qbman: Always disable interrupts when taking cgr_lock
Date:   Tue,  4 Apr 2023 10:55:56 -0400
Message-Id: <20230404145557.2356894-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0285.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::20) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|PAVPR03MB10144:EE_|VI1EUR05FT040:EE_|PAVPR03MB10141:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f8ee172-4b6b-4aab-8033-08db351cbd85
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: XIYxLFeGKfeHXbMKnvJKAIddwtGFCPYfTyS2HPdRBMWc48cYloLTvrlMtdwjfzXJF3yrEFtq7S6+f6PmEdj1PNV3jLfCDAdzAJ2LG2RGpY127NRTFfHiP7B5S5lKWak7Ej/NHnCrvW8yzAedZq52KW5n2KVAgeK2qvr6bFOCBnAgYVRCDGnjSdrV1xo3wlX01ZmB0duyGpo4HgmmZljitwP+AJpA2BLzB6NHnjlsGo2bZEompELO/2tyr9jmuYrN6SVgoCod0V5QZfZPXU6ZGHwwSj2cOQjtNRDMqh/JfOtnshHIILEdhKjRV28DUZ4iqEw4u/tRHYvCa3ZLbbMVqxDX1W4gjfuh2qBUNbNM0fBSfAbiaxDlelDXsE8lNiZCqqxUJfucc5KACW020vNpf929jkH3R8bRTuNjLhwCirWu6/2bDfyX6Uv4rWSlF8FObOt6kUG3hjd0OoGV91cUc+et2RM0oD+ciuS5Nv4Y4X0SGfRb3weGiyHpcZR0ApfRSZwHk3aMiiNL0YOK81/lrdH8SW3FUi2NoVaVAXe6mCBcJzf1yt8n7zi8/SW+idSCuz8H09CqkMbnvl4TukXILKIGhfQynhpXoqUZmcRrZ3mu5BiraCpIOlhO8hD+XdqU
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39850400004)(396003)(376002)(136003)(451199021)(38350700002)(36756003)(86362001)(316002)(66946007)(41300700001)(66476007)(66556008)(6486002)(6666004)(52116002)(4326008)(54906003)(8676002)(478600001)(44832011)(8936002)(7416002)(5660300002)(38100700002)(2906002)(186003)(6512007)(1076003)(26005)(107886003)(83380400001)(6506007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR03MB10144
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VI1EUR05FT040.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: f492a7c3-9130-41ab-2390-08db351cba83
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m2RXXwxkjrw4Stf+j1XWVQWdzhFJTNXS5QhdXJ7T1CbIv4P0gEi1v9bt56AI7hhoF+jADdPhypYeIry6qQZ2lPGS8EHU1tMAxPvb1Wf6M0+TCl0XlAljxBcQoiw/UbBhpY+d12bbIFRXitmzbts8oRs3FOYVw7k7M+uLR0HE0SxyxRXLBmscr7BQqMreijfNAm87wye83ECjqANMPEJH5KnVQiIxq5wGUvH/QPQYvKPnCNF1V/NH1iH/Fypr47Ub+B72A64q/95XHNBm8tUlIF1fUJDjQ1jHuGB87Usprt2zZUZemCpALFH7uFtAbowMDW6b5LV4A1WVl27EtvGOVV5dgUQl8Q/c8kOvGMayaa8Ygd0jGURX9krDEATTYV2Oo9lIPHgskKO5wPtHbPL7mtxkpvirtD6FG3cVk1g5Bl3jd0LzHtt8HtU8kW+RnCkBFfIf8t0lgwdW3aDrHDvyM+5w+w5VcXrnZunEez36hurdgRG/JSRWtR+jzgGN587OkD/7IOau/aIiB40INyq4X0sDOduVQU3pt2i0Ssmrd8NIZc9ZbBK6wlE8inY4qBSlpEwAuytJXdBKEwgD8Y9Zim3iDSjEJEp6FK+Sc28W3mDCZqYN7mAsLXiEWC2TX7vWSZTHbytEZR8WeunnaxIRL/K4B0bUeYhxjLfTReYpoJ33yWwlRTdA0ucjdT8wAA5im1LQDqw1NOw6CF/r7tqP26URHIqLgVsjYsfiXl2+Ec8=
X-Forefront-Antispam-Report: CIP:20.160.56.86;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:inpost-eu.tmcas.trendmicro.com;PTR:inpost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230028)(346002)(39850400004)(376002)(136003)(396003)(451199021)(46966006)(36840700001)(40470700004)(47076005)(2616005)(336012)(83380400001)(34070700002)(36860700001)(8676002)(6486002)(478600001)(316002)(186003)(6666004)(1076003)(2906002)(6506007)(107886003)(26005)(54906003)(6512007)(41300700001)(44832011)(5660300002)(7596003)(82310400005)(7416002)(7636003)(40460700003)(356005)(36756003)(70586007)(82740400003)(8936002)(86362001)(70206006)(4326008)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 14:56:15.7119
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f8ee172-4b6b-4aab-8033-08db351cbd85
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.86];Helo=[inpost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR05FT040.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR03MB10141
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smp_call_function_single disables IRQs when executing the callback. To
prevent deadlocks, we must disable IRQs when taking cgr_lock elsewhere.
This is already done by qman_update_cgr and qman_delete_cgr; fix the
other lockers.

Fixes: 96f413f47677 ("soc/fsl/qbman: fix issue in qman_delete_cgr_safe()")
Signed-off-by: Sean Anderson <sean.anderson@seco.com>
Reviewed-by: Camelia Groza <camelia.groza@nxp.com>
Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---

Changes in v3:
- Change blamed commit to something more appropriate

Changes in v2:
- Fix one additional call to spin_unlock

 drivers/soc/fsl/qbman/qman.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index 739e4eee6b75..1bf1f1ea67f0 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -1456,11 +1456,11 @@ static void qm_congestion_task(struct work_struct *work)
 	union qm_mc_result *mcr;
 	struct qman_cgr *cgr;
 
-	spin_lock(&p->cgr_lock);
+	spin_lock_irq(&p->cgr_lock);
 	qm_mc_start(&p->p);
 	qm_mc_commit(&p->p, QM_MCC_VERB_QUERYCONGESTION);
 	if (!qm_mc_result_timeout(&p->p, &mcr)) {
-		spin_unlock(&p->cgr_lock);
+		spin_unlock_irq(&p->cgr_lock);
 		dev_crit(p->config->dev, "QUERYCONGESTION timeout\n");
 		qman_p_irqsource_add(p, QM_PIRQ_CSCI);
 		return;
@@ -1476,7 +1476,7 @@ static void qm_congestion_task(struct work_struct *work)
 	list_for_each_entry(cgr, &p->cgr_cbs, node)
 		if (cgr->cb && qman_cgrs_get(&c, cgr->cgrid))
 			cgr->cb(p, cgr, qman_cgrs_get(&rr, cgr->cgrid));
-	spin_unlock(&p->cgr_lock);
+	spin_unlock_irq(&p->cgr_lock);
 	qman_p_irqsource_add(p, QM_PIRQ_CSCI);
 }
 
@@ -2440,7 +2440,7 @@ int qman_create_cgr(struct qman_cgr *cgr, u32 flags,
 	preempt_enable();
 
 	cgr->chan = p->config->channel;
-	spin_lock(&p->cgr_lock);
+	spin_lock_irq(&p->cgr_lock);
 
 	if (opts) {
 		struct qm_mcc_initcgr local_opts = *opts;
@@ -2477,7 +2477,7 @@ int qman_create_cgr(struct qman_cgr *cgr, u32 flags,
 	    qman_cgrs_get(&p->cgrs[1], cgr->cgrid))
 		cgr->cb(p, cgr, 1);
 out:
-	spin_unlock(&p->cgr_lock);
+	spin_unlock_irq(&p->cgr_lock);
 	put_affine_portal();
 	return ret;
 }
-- 
2.35.1.1320.gc452695387.dirty

