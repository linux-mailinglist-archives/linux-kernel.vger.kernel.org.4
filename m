Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2566D6667
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 16:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235032AbjDDO5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 10:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233828AbjDDO4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:56:48 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2041.outbound.protection.outlook.com [40.107.20.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32524EE9
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 07:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8yvtBCZD9P8Se9ALiAo9HFkUAu77SHsj3CkpFvRPm0=;
 b=g3Nn+7ataJpPtcrZaP/A0dmhgRyMKdROSHMAUcjptQ9vvm6acD71vgtY0NxL1Yf2Lff95QVo39X5Y8Bbf56kp9lwPCqyUQJQF1JIHoL0W3yoeLZzPVO9IPXlcw2wCC972yHROcru+q0n1mv2IpwlxK3cvdQ0ACRbMIwAkO1ySTHVkU/LKWF+9z5LpmFmEqpLjfa0DG28uoZuiU2J/yX7COTHxU3ZV4un12ec2X05iMJxcti4nZo4V6h6ZuPB6jhCz20sdAGM3qf172JLXJ/wNmGXlj7ptxarFTW68B0OvfqYQC/+CpQUwqnoZbBNZT0VwNAF3pD362i9ESgb8okReg==
Received: from FR3P281CA0125.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:94::7) by
 PAXPR03MB8273.eurprd03.prod.outlook.com (2603:10a6:102:23c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.30; Tue, 4 Apr
 2023 14:56:21 +0000
Received: from VI1EUR05FT058.eop-eur05.prod.protection.outlook.com
 (2603:10a6:d10:94:cafe::5b) by FR3P281CA0125.outlook.office365.com
 (2603:10a6:d10:94::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.28 via Frontend
 Transport; Tue, 4 Apr 2023 14:56:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.86)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.86 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.86; helo=inpost-eu.tmcas.trendmicro.com; pr=C
Received: from inpost-eu.tmcas.trendmicro.com (20.160.56.86) by
 VI1EUR05FT058.mail.protection.outlook.com (10.233.243.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.45 via Frontend Transport; Tue, 4 Apr 2023 14:56:20 +0000
Received: from outmta (unknown [192.168.82.135])
        by inpost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id 8EA132008026E;
        Tue,  4 Apr 2023 14:56:20 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (unknown [104.47.11.46])
        by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 3F0F22008006F;
        Tue,  4 Apr 2023 14:56:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CNGCFtcXs872mkyhxeyrvloxZso53+PPjYb8PC66rjw27L4HPZF6DIo9cIsqrf6sjCJOooTfncXD3b6Qe9+F/+lCyzE2O8dkXJfqgrGZsV1tqKQGrrDDGDZdpj9lLuEA4qCVEAxcEEf4DqMtJ9oYm3QeCOZp4atlyV+uR6YHxidre+i89R8A8+IHJ3AQoA/bqdsCGzq1rQ4XVtmetWCBgFqyVAadTfVaFPrdwl12KaLYlhhm9sbqnfReZnNPMr4S+zLgWVm2gLZ/XY6+pXER6XLbWypBlPVM1U3QtgmCMuqzBuE1wyCa+Pid/5Pw0k/rF/vB7xqUmcbT1qhlf0WJQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q8yvtBCZD9P8Se9ALiAo9HFkUAu77SHsj3CkpFvRPm0=;
 b=dydAC3boNHiFNlsncKJ6+65Sziy559ismg8umftUyn2Hb6dfjAVlqRWAqIgN44M+H3ceg73fxgIGRS3m+Gkvxa1BmmBffWHG5rysjjrbpTh3WdVC5UoGhSOXlK2frZS6Kmxg1wzyDR3BhnsWXquUacM7+6b3/UvE4MPjPV5RwSUa2oUB4cVWE2P7m3V+r7v4hD1pMgA31Px7NFAM5p+JOrxS7earUnZGz2nN/pt/8VWp1StiqfY7lyehYFfiQsR58VFDoWjPCYocFqD3QLTfR7ZuUiKoYpOLgjywaEKdqCaaIu/hlXyK8Pfigy+hUTSvJsbb3zE/4ywocpuMtw+2Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8yvtBCZD9P8Se9ALiAo9HFkUAu77SHsj3CkpFvRPm0=;
 b=g3Nn+7ataJpPtcrZaP/A0dmhgRyMKdROSHMAUcjptQ9vvm6acD71vgtY0NxL1Yf2Lff95QVo39X5Y8Bbf56kp9lwPCqyUQJQF1JIHoL0W3yoeLZzPVO9IPXlcw2wCC972yHROcru+q0n1mv2IpwlxK3cvdQ0ACRbMIwAkO1ySTHVkU/LKWF+9z5LpmFmEqpLjfa0DG28uoZuiU2J/yX7COTHxU3ZV4un12ec2X05iMJxcti4nZo4V6h6ZuPB6jhCz20sdAGM3qf172JLXJ/wNmGXlj7ptxarFTW68B0OvfqYQC/+CpQUwqnoZbBNZT0VwNAF3pD362i9ESgb8okReg==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by DB9PR03MB8824.eurprd03.prod.outlook.com (2603:10a6:10:3df::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Tue, 4 Apr
 2023 14:56:15 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::2226:eb03:a8c:a7e5]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::2226:eb03:a8c:a7e5%2]) with mapi id 15.20.6254.033; Tue, 4 Apr 2023
 14:56:12 +0000
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
Subject: [PATCH v3 2/2] soc: fsl: qbman: Use raw spinlock for cgr_lock
Date:   Tue,  4 Apr 2023 10:55:57 -0400
Message-Id: <20230404145557.2356894-2-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
In-Reply-To: <20230404145557.2356894-1-sean.anderson@seco.com>
References: <20230404145557.2356894-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0285.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::20) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|DB9PR03MB8824:EE_|VI1EUR05FT058:EE_|PAXPR03MB8273:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a593f6e-3733-428f-d2aa-08db351cc09b
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: xUW4ja8IG8w4JmzXu2S+ZHnhwUhVc5gGpM99x/KK/RkTc0JDsSaeb9ujUUdUX5LE8xMUsKEDcAFulBJEFqtnUVSlgwn8X5sofSj05HJu6lZB7vNl67aXtr9G/0crbVPO7cj31grEv9PhXouiL+CsgejgAD2ktIo0vUQUQQZtQzc9OSrg42oCHoCf9lkXqV5V3xB5gkD29se1Kk6u10jxLPl3dYq4H41Gq8oZ6L+pv3ak3L6IuOHb28WpNSTV6+iC7uHUdiFPbeB5LqKY5gQ2PAu0ypz1zD70P56+lvn6tZZ88lqr6er1Dea5TcQbLeQnCWDBRhm2SP10vxv3wmMrqwAQdQX2JmIo9izZKQKC2m2z77+ujNPHq7bfGVXqs5zgPqeYm0swWrKOaofBbUR0zwBZC7IUL4AT6WRiR9FyoG6HvYxTyQTKMnp8AS3poICEFt3uitwg68Uuidus/Aqry/hBAXkwYtuWlz3wuOb6RZ+S4wkVBaOwX6LHd+XurMO/isM3AfDg3KAxbJtSpnRhAg4av2ZDWPh9nfv/Z3Qb7cbSMi30HYlb05LrqcubUGGxBDJoSHwxsGd0l8Ltx/EY8DzRoYHD7xN7hXW95c9KG2g=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(39850400004)(396003)(376002)(136003)(451199021)(66476007)(966005)(2906002)(86362001)(44832011)(36756003)(6666004)(107886003)(83380400001)(66556008)(4326008)(26005)(6486002)(52116002)(1076003)(2616005)(8676002)(186003)(316002)(6512007)(7416002)(38100700002)(66946007)(38350700002)(6506007)(8936002)(54906003)(41300700001)(478600001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB8824
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VI1EUR05FT058.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1fb96465-5a10-426c-5540-08db351cbb5e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1UCPZgnayjAjBJT2XTGjx9Fii3PXzSZa64HvO4q6zZo4vRRw8XnAMHdZHCksdK/HfoT79Qu60Tn5UdSk4EUX/sVMxg066tXWCGj1nW+EXfwncv6Zt/Wzz2htFaLAUHGkK/OBnXJgkQlfrM+7J/8l5Erlq4KdGEj0OZj994CJYBGx8PgwtvMLJxKYfKtsm9L1w8BfznQ/ZsdPk+fDxRyRDQfNibrfGYmSvGRtvepkLK/1ksS5KYK0oNyd50gmATQmxDE3rgkYyxbiY2YDfBhXHfh7aOeq7QDhRAAH+DLv39X1Ok8PvJdWVwqfs82bnn4rm48qJOyJK5pY57+h1WU/T+zE9ezKC58zc1lY9u9chb29Lqv53z2eDJdHjC04EVV+HB1vwiGk0JzUuVOd+rW8lHK02qrn7JNHgOPQj3IpwNvasGUim1quxN35WOHvzNNwDXI3dy8B/FPi14afplrn2HSIB1I+RrI10kqbWGLTDamdsTgrwo6rKhNJJLt3K+Hox/Ykr5nDHhiLEilULeyhoTvnyB/jkJNnYeXkjXK2AT1UIGbACJVPnG95mDZa67XkvGsNtdjFbqkO53GFB53dqvkVsuG01H7XEriAR03te1jPBbxFjj69J8avRZUfGUzgFq3VKnPAasQUYs5zk1UMTB9xKI15DD+h+FJWuQNiL+L+N0xrH2hlgfdPmTw+pl6OzTBvVuAgl33vzJdn8nkwvY1vyF+gxV+/TnmZyKt/ZEU=
X-Forefront-Antispam-Report: CIP:20.160.56.86;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:inpost-eu.tmcas.trendmicro.com;PTR:inpost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230028)(39850400004)(396003)(346002)(136003)(376002)(451199021)(46966006)(40470700004)(36840700001)(40460700003)(8676002)(26005)(6506007)(1076003)(6512007)(107886003)(966005)(186003)(36860700001)(47076005)(83380400001)(8936002)(5660300002)(2616005)(336012)(70586007)(6486002)(4326008)(70206006)(2906002)(7416002)(54906003)(478600001)(6666004)(41300700001)(44832011)(36756003)(40480700001)(316002)(82740400003)(82310400005)(86362001)(356005)(7596003)(7636003)(34070700002);DIR:OUT;SFP:1101;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 14:56:20.8913
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a593f6e-3733-428f-d2aa-08db351cc09b
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.86];Helo=[inpost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR05FT058.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB8273
X-Spam-Status: No, score=1.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cgr_lock may be locked with interrupts already disabled by
smp_call_function_single. As such, we must use a raw spinlock to avoid
problems on PREEMPT_RT kernels. Although this bug has existed for a
while, it was not apparent until commit ef2a8d5478b9 ("net: dpaa: Adjust
queue depth on rate change") which invokes smp_call_function_single via
qman_update_cgr_safe every time a link goes up or down.

Fixes: 96f413f47677 ("soc/fsl/qbman: fix issue in qman_delete_cgr_safe()")
Reported-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Link: https://lore.kernel.org/all/20230323153935.nofnjucqjqnz34ej@skbuf/
Signed-off-by: Sean Anderson <sean.anderson@seco.com>
Reviewed-by: Camelia Groza <camelia.groza@nxp.com>
Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---

Changes in v3:
- Change blamed commit to something more appropriate

 drivers/soc/fsl/qbman/qman.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index 1bf1f1ea67f0..7a1558aba523 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -991,7 +991,7 @@ struct qman_portal {
 	/* linked-list of CSCN handlers. */
 	struct list_head cgr_cbs;
 	/* list lock */
-	spinlock_t cgr_lock;
+	raw_spinlock_t cgr_lock;
 	struct work_struct congestion_work;
 	struct work_struct mr_work;
 	char irqname[MAX_IRQNAME];
@@ -1281,7 +1281,7 @@ static int qman_create_portal(struct qman_portal *portal,
 		/* if the given mask is NULL, assume all CGRs can be seen */
 		qman_cgrs_fill(&portal->cgrs[0]);
 	INIT_LIST_HEAD(&portal->cgr_cbs);
-	spin_lock_init(&portal->cgr_lock);
+	raw_spin_lock_init(&portal->cgr_lock);
 	INIT_WORK(&portal->congestion_work, qm_congestion_task);
 	INIT_WORK(&portal->mr_work, qm_mr_process_task);
 	portal->bits = 0;
@@ -1456,11 +1456,11 @@ static void qm_congestion_task(struct work_struct *work)
 	union qm_mc_result *mcr;
 	struct qman_cgr *cgr;
 
-	spin_lock_irq(&p->cgr_lock);
+	raw_spin_lock_irq(&p->cgr_lock);
 	qm_mc_start(&p->p);
 	qm_mc_commit(&p->p, QM_MCC_VERB_QUERYCONGESTION);
 	if (!qm_mc_result_timeout(&p->p, &mcr)) {
-		spin_unlock_irq(&p->cgr_lock);
+		raw_spin_unlock_irq(&p->cgr_lock);
 		dev_crit(p->config->dev, "QUERYCONGESTION timeout\n");
 		qman_p_irqsource_add(p, QM_PIRQ_CSCI);
 		return;
@@ -1476,7 +1476,7 @@ static void qm_congestion_task(struct work_struct *work)
 	list_for_each_entry(cgr, &p->cgr_cbs, node)
 		if (cgr->cb && qman_cgrs_get(&c, cgr->cgrid))
 			cgr->cb(p, cgr, qman_cgrs_get(&rr, cgr->cgrid));
-	spin_unlock_irq(&p->cgr_lock);
+	raw_spin_unlock_irq(&p->cgr_lock);
 	qman_p_irqsource_add(p, QM_PIRQ_CSCI);
 }
 
@@ -2440,7 +2440,7 @@ int qman_create_cgr(struct qman_cgr *cgr, u32 flags,
 	preempt_enable();
 
 	cgr->chan = p->config->channel;
-	spin_lock_irq(&p->cgr_lock);
+	raw_spin_lock_irq(&p->cgr_lock);
 
 	if (opts) {
 		struct qm_mcc_initcgr local_opts = *opts;
@@ -2477,7 +2477,7 @@ int qman_create_cgr(struct qman_cgr *cgr, u32 flags,
 	    qman_cgrs_get(&p->cgrs[1], cgr->cgrid))
 		cgr->cb(p, cgr, 1);
 out:
-	spin_unlock_irq(&p->cgr_lock);
+	raw_spin_unlock_irq(&p->cgr_lock);
 	put_affine_portal();
 	return ret;
 }
@@ -2512,7 +2512,7 @@ int qman_delete_cgr(struct qman_cgr *cgr)
 		return -EINVAL;
 
 	memset(&local_opts, 0, sizeof(struct qm_mcc_initcgr));
-	spin_lock_irqsave(&p->cgr_lock, irqflags);
+	raw_spin_lock_irqsave(&p->cgr_lock, irqflags);
 	list_del(&cgr->node);
 	/*
 	 * If there are no other CGR objects for this CGRID in the list,
@@ -2537,7 +2537,7 @@ int qman_delete_cgr(struct qman_cgr *cgr)
 		/* add back to the list */
 		list_add(&cgr->node, &p->cgr_cbs);
 release_lock:
-	spin_unlock_irqrestore(&p->cgr_lock, irqflags);
+	raw_spin_unlock_irqrestore(&p->cgr_lock, irqflags);
 	put_affine_portal();
 	return ret;
 }
@@ -2577,9 +2577,9 @@ static int qman_update_cgr(struct qman_cgr *cgr, struct qm_mcc_initcgr *opts)
 	if (!p)
 		return -EINVAL;
 
-	spin_lock_irqsave(&p->cgr_lock, irqflags);
+	raw_spin_lock_irqsave(&p->cgr_lock, irqflags);
 	ret = qm_modify_cgr(cgr, 0, opts);
-	spin_unlock_irqrestore(&p->cgr_lock, irqflags);
+	raw_spin_unlock_irqrestore(&p->cgr_lock, irqflags);
 	put_affine_portal();
 	return ret;
 }
-- 
2.35.1.1320.gc452695387.dirty

