Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6447746DC3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 11:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbjGDJkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 05:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbjGDJjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 05:39:54 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2072d.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5212226BA
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 02:37:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BcVfzsGOHiY38m4ej3oXRK5RsN0B7czlgmp/WQRtxs9bgGA/eLLTilnjA0vO1666YNobY3fq4pNbTAwqQpsO+23xVE3K+XAeTrvoNch/5FFqFYtIeJ/YezGY4UCBhAMw0MjgNYBlvxmGWi7qzw83Yi/7AhrZm7cvZYiYzkeGGBKEZxu5b4iJpWBuExAezx6bMN1yXUyQowaXUVXGYEkqyMDQo6jOdccqXkQCBVUOGfeIY5QflefsBN3QW35nVwaX7cK0RANmtham1tYGS2CUEvcUmkOT5vmF1h2mmxJ4Kai4qMNrkiQZVumQrLkAb95nBF16SPC6E2fNA9wlMF9FKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8OI6ew5GZ+/KaN67nm4MzAPYFmmgTlVTFAFcXnpJFA=;
 b=LB6jQ5er+hYObP4M7zMK1qxg2ZkI5TvCzs/yv7Aesy+aMWt8m7EgbQuXub+FXszo/ob1lATREG38IKiOzxXBx+dp7KRtXVfSw/H4UaYFBjjf27ZKX3K4sbDckZ1gnYeX2kaDFEOYVepiLAEHKWoHsVNXXg8wi6JsogmI0KTvaEtGUhBTTd1yORzLbTLcBAoj2USiuCCwFReQq1hduFWrIAd2vLS69VT+QFub9ttOBUu+GbDZD5l/2OMP33svXB8AYlIoFPaWuQE5wV6bfvA7WxPKdw5elL2iRU6LM87NmFWWCzhl4AZUYEtbETMEBAPC1L9R/owpmDNfubg8opoa8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8OI6ew5GZ+/KaN67nm4MzAPYFmmgTlVTFAFcXnpJFA=;
 b=FsbFWwLS8oepSxV0riZ9f4qzkC1p781rLf3mkDhndJqMampq3PQyDqjDSP7MRul7fNCIy+ou5d6qPdwrW9ScLEkzjQMgVXpbk+QA1MggeHzG072tTCvT1PqLMESjawpM83mUMNpk30N8hV3UtUCDUwIeLK2NPCRTL6GcjDmqqsppRlh2JT3E0jO1YkUbJERlRIrZCa7jFRtkvMhdzX4zkx54p1RH4bUSw0NCwB0kKkR/AO4hL7H6RCe8LnJM/7BLrIXEfxPbzhkSGC7zZOl4PcfndT8UWsIE/J9xyqcE61/hA3Xy0cTWP4SRWB+NxNp1mzA6hHCxOA8/QKN3PqRkzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB5565.apcprd06.prod.outlook.com (2603:1096:820:c2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 09:36:12 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 09:36:11 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Khuong Dinh <khuong@os.amperecomputing.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf: xgene_pmu: Convert to devm_platform_ioremap_resource()
Date:   Tue,  4 Jul 2023 17:35:55 +0800
Message-Id: <20230704093556.17926-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:195::16) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB5565:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c8d6a8e-91ee-49cc-60f5-08db7c7219f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zVtQmB7foY7sCJDXjRHMknNM/6ubDbTKpkONjZ9gKaunXWYVgNzzFepsm60AK2iUC+tJ6SWKSMZIKeTQBzbqYNqFo1hbBkSuMaMk3zZt/pQtucLZ8Sd3epYLdH485Mf3tn8hKV26uLAO0UZfj7PoNwE8bEoT0qz/u3V/fGXjp2PSM+zYHUvrnz/nplS8j+5kEUVY6o//gVkvNnG/8ER6DNhpk5pXvgJvWLV/sl/2pny2zvS25TunsmlHw6D38JSd07Awo+lTXF2Lzprf69gCIDQ/HRB3vO9/0kXSkiSjmSs0M1n9ABikXc77OT6JsV2Rmbt0wK77f+juiDoYExIuX6LzjJdOFHm1Quwehhtd0OdSx4pPVXbQ4IUrxYc7U3LYFGpuRObg4zZO+/DDk+mXXQuv9CJN4z4ywl3byRXrMtJPvsS4kITOwArEUTr6oPgyDOgx1kU+4TDuGgJ4k2cbQdkk3CUaZLLfe8+uqENL8tA8C2ScqnskThYLDQY+j0zQb8qYWvhwm9YnOpCHgF0WwaIc0juVWRrfmpWIdqk/+SNMNqFUq8jidUef0uai1CFwl5RCbx3l7fCcxuOV53/bYmOrmgkxcVYy8cpmVaEYKy44hipDyiW/mh+MAOCjOZDp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199021)(38350700002)(478600001)(110136005)(6666004)(5660300002)(8676002)(36756003)(8936002)(86362001)(2906002)(38100700002)(66476007)(4326008)(66946007)(66556008)(316002)(41300700001)(83380400001)(26005)(186003)(1076003)(6506007)(2616005)(6486002)(52116002)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Az3O5Q3suSspK4usmLykOxDrhnl+adw32DjskrE5SYmRCLwrtaAFwN0dflUp?=
 =?us-ascii?Q?bg0ZcOHQeYAo0SnWxZKejtROpO9g+vjUVtevdQvy3jKRUM9dwTP1lyqDRity?=
 =?us-ascii?Q?H3TsMnhlq53gsz+meMrrFOjx3E0IX7Ae00hiJcw3ax+KEwucskDHLUDPa4Ls?=
 =?us-ascii?Q?xQZEvUDLz2c9WE2uok1ZFXc3/yFWzcVBP8fjeoygOiUrOSTSJGTm4solBjK/?=
 =?us-ascii?Q?YP8QmSuFvQgLMdyPAVvAi0tbe6EXejTKDAKCvdz+VsAfHxyLttL6l5M9TRFs?=
 =?us-ascii?Q?i7lXcW4ENuBkEJ/bx+VQQX8vcKxbbdUgL13w3Z5XzPbmeKBpzqywWukQu4eg?=
 =?us-ascii?Q?qojt9m/YVco8CyBfndxWEupegu23kGCIT1ChdVL3HHVi0F8L2+WkcgGf1G5J?=
 =?us-ascii?Q?vDdJ9+AbdR4DTlVfIf7HOx5NdqM1Qi1klp2DsVJbdcw2InBfeCo5hd+EHSgg?=
 =?us-ascii?Q?lNGGyVHF7rukNWk1uqqxSkkuMWUfdfvjum3NCcxX343v1RdLl47oXYaRCvSk?=
 =?us-ascii?Q?+wi9XCHnMYzPA2SivSmFSkM1ETpSh1ij92BuaE2GveEGsHhZNJGt1UfS0WjP?=
 =?us-ascii?Q?CcBT8B4THIpSdAf+l53oTtwpyT0pDKlFCWgg4NMFKp+fYXOErExOgSTcjagh?=
 =?us-ascii?Q?s0ooDfXrdQXDzYghgeBMr/3hKEkQ1kDhTHYb4Exf8yss3Gylmp1bFEmbpPeL?=
 =?us-ascii?Q?flvvkHZZAagRr62pI1gRJPOKF2AdDyhnX2PJJbLhnZYakDpWLzxt17MhDN3f?=
 =?us-ascii?Q?Wf2FmSquH5SosNm6DdGmOrRThqkCv7NejjYHgOtyV9fgXKM7IKV0nAtpmGLi?=
 =?us-ascii?Q?G4rldxNOWwn+rch4kmWu1aBJ9BKXZrM1RDh4CULmO7d1lBoMqNTnHFDh4WPE?=
 =?us-ascii?Q?Hpyqos6TWec7AF6m8s1nmBSbtFbjHhLqSnpxtDpW74nSe2GGrxiR8JqXa/uD?=
 =?us-ascii?Q?D4IO6dZSGzrgcf1oO6Z5C8ExVbqA/ZXrKz8msx7iQIKduc8dusPnyIhoDbSC?=
 =?us-ascii?Q?j+MxT5+E7lvm79uBRvj5dLnhUzBHmxr13F7wpiw2HtiYnrOuObuCwUQysIvy?=
 =?us-ascii?Q?b3SbH6xIK5i49pZ9s3yfcEt6GhFApGevLphkmXkpeel1/QAenwPisUFa+TCs?=
 =?us-ascii?Q?r42bTltCQVDt5oQg99WuHmn6YYI3XNkL/Gw8JWDm3hQmXZ4bkdHkKjEr0dCA?=
 =?us-ascii?Q?oiVkt8bWsTmO1P1H5I+2Q8iSCK8X1AKwj4zVeknefkBu6ItYztq1Txa09h8M?=
 =?us-ascii?Q?6cr1RbzlrUr67RirCRsw3h15momvQIJg8XOTz788aRa52aVkStG8dhGuRmmh?=
 =?us-ascii?Q?Z90gV4au08y4FG/lI12acGVv1Z5ZASCnQUh5kyTTT8YK4Y8ygLMfLuHoJyNu?=
 =?us-ascii?Q?7wLT7RhvbRTp4v1FMsctoBVFoqRdRJ4cFV98VHFCt/45ZgMjpmcrP1Mc3NMX?=
 =?us-ascii?Q?nt0LLb6QwhZH4Az0oSfylgVCjLwM6CBqTOHuSNF5GIc7e6B95jX9sHVRmqux?=
 =?us-ascii?Q?PWcruKT3kHmA6NoDev5nnoaox/AVE3rzDCN7CXxBSMvnb4mroG+gCentJsjy?=
 =?us-ascii?Q?ud06Rv+pA2bhMdOVBneDljWW8u/efQ8BoaTpTddQ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c8d6a8e-91ee-49cc-60f5-08db7c7219f1
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 09:36:10.9590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MXosgQbBk6czY1UEizHWkm41vViyuT9Cy46T/HOS5NM7NEmSyMFvFn9NOtet6z/fb/Wul3zr1DVfatvROO/W2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5565
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/perf/xgene_pmu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
index 0c32dffc7ede..9972bfc11a5c 100644
--- a/drivers/perf/xgene_pmu.c
+++ b/drivers/perf/xgene_pmu.c
@@ -1833,7 +1833,6 @@ static int xgene_pmu_probe(struct platform_device *pdev)
 	const struct xgene_pmu_data *dev_data;
 	const struct of_device_id *of_id;
 	struct xgene_pmu *xgene_pmu;
-	struct resource *res;
 	int irq, rc;
 	int version;
 
@@ -1883,8 +1882,7 @@ static int xgene_pmu_probe(struct platform_device *pdev)
 	xgene_pmu->version = version;
 	dev_info(&pdev->dev, "X-Gene PMU version %d\n", xgene_pmu->version);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	xgene_pmu->pcppmu_csr = devm_ioremap_resource(&pdev->dev, res);
+	xgene_pmu->pcppmu_csr = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(xgene_pmu->pcppmu_csr)) {
 		dev_err(&pdev->dev, "ioremap failed for PCP PMU resource\n");
 		return PTR_ERR(xgene_pmu->pcppmu_csr);
-- 
2.39.0

