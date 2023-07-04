Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C245747296
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 15:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjGDNUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 09:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjGDNUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 09:20:10 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2114.outbound.protection.outlook.com [40.107.255.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7025173B;
        Tue,  4 Jul 2023 06:19:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ee+gx+Cn3AtGL3eOiEHByv7durINCfiZ8MJNdUzxE6WZzokzzpSrbzCyKJzDzKYZhiq6ti4i4oiRzgobOVMLUqKcUBbPMHywIVVr1uhPyF1NCZ1CAmnenRG3cYV6G6hLKpl+Q9bHGuvJ18J7gFN4kcarXZpbgDPSFpxLQwkns4+vua0NuBnyTfVxt/3p+tUYiyFhmrTevNMoE6oPzhelzSRmxJb39/e6Hee1W5us3kPToLvAg5982Krlho2wLlcNW/oM/EJ6/tSPCe34QxeGkGLMhjeiEBv3sXjhJDfup8lHLToC9ZrgAZaTTNba2znG2D6xCsenQwlnUiS0VIUriQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUJYWgy5/3vkJfn151l3IAIPQvU5LqBW4ITzlcsIqr4=;
 b=OaJhhZ9vzg0Qvv6hI32/y/xZqSXU4QFY5oZRlA/fI4uXI0uBZmWNB5Jas7ZpcXWRLYcxbMVzAT/t8pk0VFDF3z9UEXa7O89XHsB+yPhBcLiDpOmDg9ffHpUCaVeGYrKJPMlS8jrU0eIDr0KQHZKfTciGvG5mJeU1sOerxzmPin9Shq/WdW4WLbzM0+MczIQ3dxHlEHnCoQhVvAM8a68wPKPADaeUa+IVkc9MwQH+6xcx08FE7LNoltKEt667Lby1d1USjR4mA8YqxJrBU35AVF9gVwVBtXKK9nv4lRRDU+ruihiiDrYiB/6vtI0nN72LrGgta/xUIN85FCX9st5hvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUJYWgy5/3vkJfn151l3IAIPQvU5LqBW4ITzlcsIqr4=;
 b=EUL8VFLGxP1NH58ixvBaErrfQZqg8VaRo2qYLEH++L7ODxEdrLONMhZglcn5pBZh30flwuVyKfz9Yk3njAmAgzlgN+IcvObK3Wg+GOZo8GmpKExJM8uSNHfqK/Y8otK/YuMdbPnFYPYUAYZMoN6zizpruIqvnGQQ6S/fhKp0KlIdfaVb5v6/LmK3QFlweapI+l/iKRRFkzzSiFlnkvb/1ve7CT74tJeTDvcGMNU53bFjXOnRgfFQQ2eFEkBBXZrkV6wv7nYojlacMfA2N5lwxx8QLCy+XglapVhj7LJqV1KbhMq25WYbzZ5ZkF5MA9aROCIGzLDEQP9fkvYrZWHYsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB5027.apcprd06.prod.outlook.com (2603:1096:400:1c9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 13:19:48 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 13:19:48 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] mmc: mxcmmc: Use devm_platform_get_and_ioremap_resource()
Date:   Tue,  4 Jul 2023 21:19:36 +0800
Message-Id: <20230704131939.22562-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::8) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB5027:EE_
X-MS-Office365-Filtering-Correlation-Id: ac2f6f6a-f9d9-483c-0df6-08db7c9156d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QZsHlVv7PWrlwbVoIXeXIOGhni/3QUPuDxNlrVV0BYngTkvrtmJ0PsaAL4O2B/NedZRUhcPZO6S8RPpdH5ryy1eji6bhnJ8HXDFVmTzImBWz+ekBHn4kfbWx/vd1PN64N/R/CRl7Q7WGlFntwMjbqN+RSBRgHUi+N6gNe4m5SAjjnNBDAo1nQNsACYjiSmWVp4P4X8RplsYCm80LAPS4YtFP5OUO3kQlnfFrmdkUnZ6IvVeO4AFVsQtRART4qB8Z+Wkqk8hVdESAOmzWS3LCxbtRBZMuVR9gn4IkaF703IFyutxy2YL7g2UB1IqREHiRWBdtAkPFvTGKBczpjfcnkRulWv5YJhqsqKoeqNqNeqC4U87ZkBb5VmqchCXDaN+AdRqed/o+bmQrXRi+0CFFnxaRSWa6RC07PkKFuqcrgp9HOSlw6AS/ne3my0D4fKir9aNqapylk5KGX/mjcrUAbeKd0joB582mgjEA1ud5dD/ViLkAXW0IU0qT+yXze6t+7LL8CmJT6UNZ3YAX4utGCewN7uH3RGtFFm3eKt18oSF16oaNQBV88D0Lt6IU7nY4FID8tNrw0qrtJCrG4PqZXR/6K7pCb7UVG3pMQ2cg/Yo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(346002)(136003)(39850400004)(451199021)(2906002)(4744005)(478600001)(26005)(41300700001)(6666004)(6486002)(86362001)(36756003)(52116002)(8936002)(8676002)(5660300002)(84970400001)(316002)(6512007)(66556008)(66476007)(66946007)(4326008)(38100700002)(6916009)(38350700002)(6506007)(1076003)(2616005)(186003)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g33LNJnAAMzs0HSvokUZFXWk0lxifUG3E+IGE0mq3yjoFboFkMBJzbqE6dNB?=
 =?us-ascii?Q?kobritgi8XtLuXkycZSfLoAqDjgvU+8B5KcNIjjvVNkTDvxSvY/h13Y1RKEx?=
 =?us-ascii?Q?2FOvMRubp1Pzyxt8c45iuuHOJKlvr7efrxnvivQl71E2QQs8TIJW+Bo9YNY4?=
 =?us-ascii?Q?OWtuPjUHGNGWYrTvz03tGvLdsXUf6p7F7xjboT4kSz/GXgNiq1ReffL1aiEQ?=
 =?us-ascii?Q?a168XdIPpB7T1vTTf7EaSiUkxuagirzcfLdFoufZALheUsJsEsQGGpVZJHq+?=
 =?us-ascii?Q?Tn/TsIiRz4GgPTvYfdI+VfaNjU0zk48r7wUn02IPxoq3e9AZHY4EBgj0H4Q0?=
 =?us-ascii?Q?yUhh6j5o+xtyCILVdqxXmh5uMzxTuRcAvxSx2HrFL+JgeeDXkfO7LNpzWOhC?=
 =?us-ascii?Q?BmH3LTYs7xwUhakHJqOC6//TjEOLV/o/JRyNObf+b3MQO6ptPQog7qhbDMxw?=
 =?us-ascii?Q?GhuQd7t30za8sYSQJ/J7mq3CmD59Yl0ri0nrwniQTajKcdJb8Lu0W4uBRiBr?=
 =?us-ascii?Q?TrM6T5LMBkDw2oVBSNPLwJ8f3eT20q0tmwRRnBy1tRFifsPCOHxlLSxE0lAU?=
 =?us-ascii?Q?X8Ci9lDXPg/s/8xnb5bhq9vnwE0KRUzZBZcn9JH1ClH0gGkTDoCsrHN0NXxk?=
 =?us-ascii?Q?6bGO4S7lo2OtPe1vkPXLcsVtmAyKoTEZKy9k5uS2N1x/tDVZ0RSWIcnwkPkP?=
 =?us-ascii?Q?5cz3K6Xj5nDvBBqN+HHF5syk1BnMPIdG5IzmSf9tTa1WnXM3bKTOswLuoO8U?=
 =?us-ascii?Q?mPZqDIwCaTSFmyhqHSfQa/T5pR1QHmJRyydE3CiRO01ZZIwPLTnNkKAFY7cR?=
 =?us-ascii?Q?O/OfmL5Um6mH6qWBbl7/3p0ST4GhGxJHgIh4GBuAEtdn/RZ/HlmFudc8MUAi?=
 =?us-ascii?Q?noTvIPl7ZnwqS/k+ZzzjyfK8ZJisnQc7ir4rlndcqZ4HeNeWz+wzLDOCIGB7?=
 =?us-ascii?Q?d5o4zuPLjemTHef7OAzaEiYz7zbkMEI9LNd/TMtda40htLAKDO0GufQ6DUNd?=
 =?us-ascii?Q?+k8hc/p7iSrpF+PysbBIBNiHzMsPY6fVHA81pbiW2FC6AjzIfteflwWB9lR8?=
 =?us-ascii?Q?4croOYSBMRfY5yoLf1eCfYYCxOxhjx+r5Rbekt91EE335wx7Vn1WL++k9ggR?=
 =?us-ascii?Q?zM/k2/YMgSPv6HsN6JEnnf78MjHicjisjHJFfhlVxEeiS0KNHomCZKG3fy2H?=
 =?us-ascii?Q?PPBONnlyjkV1BCBEovzSs3rJQWjModXzW8Jmt+CazjTcLafoMCP1ErnbWAP9?=
 =?us-ascii?Q?OTZ5w87Gvrf3OjD1aRAoZfoMl65VeOk1VaT1xFZd9mvVq/H/Uuk4B07wDVTX?=
 =?us-ascii?Q?ZbvL3wDKqqKdMIX4rrZtYnUAjIiZ+G8B9r1CrpaJuGSYnQw3aFHkRvW8oKfG?=
 =?us-ascii?Q?j5qjQ+dHh9zVxj/48ebhr8BpNKU3rhOP95hQxWmEd8qBKc1bSYLIgcUXXIpF?=
 =?us-ascii?Q?cExj749teiYDD3aJiC0Wf2u6eIOW1rMs6Lmd5GhNghqjE/8ljcE4Zr2JkDGd?=
 =?us-ascii?Q?S91IbnOrHKbMUJ1l6qNQaMwyWAGw6+1iczGlhyHbXio/P+MT4pucoOyuNrAD?=
 =?us-ascii?Q?bVL1ZBK17kGAsjm6774uD/jmn6/RagVsxO8/nVAt?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac2f6f6a-f9d9-483c-0df6-08db7c9156d5
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 13:19:47.4705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K2ixEu/N/C4kVewhFb8fMkOzSSziyJhIHTwVp8YzanvYZqZW9iSf1bkD+y3VUvl31Hr9rum5YvUVL2PRD+TfsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5027
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/mmc/host/mxcmmc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index 668f865f3efb..f3a72569dd1a 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -989,7 +989,6 @@ static int mxcmci_probe(struct platform_device *pdev)
 
 	pr_info("i.MX/MPC512x SDHC driver\n");
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
@@ -1000,7 +999,7 @@ static int mxcmci_probe(struct platform_device *pdev)
 
 	host = mmc_priv(mmc);
 
-	host->base = devm_ioremap_resource(&pdev->dev, res);
+	host->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(host->base)) {
 		ret = PTR_ERR(host->base);
 		goto out_free;
-- 
2.39.0

