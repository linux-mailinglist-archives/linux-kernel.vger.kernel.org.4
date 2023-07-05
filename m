Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A363747C61
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 07:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjGEFY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 01:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbjGEFYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 01:24:24 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2110.outbound.protection.outlook.com [40.107.255.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24C41724;
        Tue,  4 Jul 2023 22:24:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kK6bAuhWSEosyeSHCBsZRo14mlDSExGUt12tagnNZQL6RxANaVf8OF7E4nVwH42uCu+L8jwzFUYt5LLaHxbrUGWy+jvtCdPxJq8fe9vJffGgWxmqOiTjdPKy78JmD1rmihpJMwlnXKG+nrTszpKpRfgMDCCsNnEVWi4l9lxJRSdHI+ZOmwsBzJUhvBjuOQGZ+qiDQRlOMmwncjpqARiSWTCbfK7q+gSbM9DBKicBZme1ddqEBbnOj+neevU/9iGd6ScFDo72PT5/qcIhftScf2thRwgUQh+QnPUW+p1N3BEPbb4uhu79gZi7eUkxEjRm+3WQMeaPmsSaeL2ImkU/cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EdwLLZt7SJTc4Q0ItmBJyePFqZew52vfgBGo5KTcf/8=;
 b=cpt6fH8KnBXDL9q1VOEIRXYGY8rGUHKcuag6khirm4unl6ql+klw6GxAlxodPNNHJan+gLz6Vpssj1g+MGQoIRS/qMTDRv7FbFOjLHcg0NQQvDklhpENxeXo9fMpY87lkiVhYq8JK+L7JTczLb7bB1Kob63wWU9EppGZOvuaVz5PMv3XUCGoFEH3pDUakXtNByJPbGAH9HjRbVcBenOIhLy0DJCHgMJkAMw6J6//uRVJrazpaaJ62wkYnslLcGD13cA8HgrANh3YYAYaCsezFbeM0qoguMI1UY/lUJlBreR2BYeBj5Ucy65CPnrq5IYpxP+FLzkHZcVx6QdhB0WASg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EdwLLZt7SJTc4Q0ItmBJyePFqZew52vfgBGo5KTcf/8=;
 b=C9OXWZFjoP5CwJhTMSdpVfn3RRxlVO0oIU/5Z64P/kyYr1L0eL+1GbMXXtP8OtfGNxjKVL0EwG/uQ8+XadUv5MGWWiXnW363iy8OxaCILv0W69/StmibfMwKJ1d4hSdeNtz74PF/L6LRe7J171MTXW65jVCGfVNr+dBDPaBRNxHIODpHruUOv9LRZYDBKDr3G765XYdZNmK8cncB2yMyg3OMyRLjB/pL62QXDlK1h32QkuN0bayzciHZl/eUZuro+cmB3bUzCNl0iZoH6ZX59/25dWb4l4NmVFPfCBJZNrrUeDZA+3GfmRhIhfbG5yvWgOPsIHN4tpVstUwvqHvD5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB5123.apcprd06.prod.outlook.com (2603:1096:400:1c1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 05:24:09 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 05:24:09 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-input@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/10] Input: sun4i-lradc-keys - Convert to devm_platform_ioremap_resource()
Date:   Wed,  5 Jul 2023 13:23:43 +0800
Message-Id: <20230705052346.39337-7-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230705052346.39337-1-frank.li@vivo.com>
References: <20230705052346.39337-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0116.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::20) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB5123:EE_
X-MS-Office365-Filtering-Correlation-Id: d2df92b8-b569-4e3a-8612-08db7d180f5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rAcSLF+omlZe7KJGilfsVvFvxnyIgWhLE4d5kaIgbyd77nFp/71gpunaAFMp3+5iIHK3NMBQ1KVrsqH1CUuiYecjBu1AlN0+RTHYf7ThLPvjPIOBY8WXv5PA979nl4CHaowEKMByb1Cn5xaJc2I6c6j4dOJIZwVF5xTpb1w6+RbrRH1YC5HNjO/Gipg52fPCCMB3bnYJZ06b4yRmeHwJNba5jgKvUUc9VPKchrD7f1cMVs+pgUqdp1IWKHDpwIGg5J/P1xDisU62C7x0o6nfq4106gmnGwIMAaSMFsfksQ1nYRZ8sB5RGU8Wl1eE4RF5b7WJtHRrXDHgEZoOvSt3rMW085TurfeSxvxO5ij4ZuzAn7tq2K7SUvMdCQdQCCgmtrZ8A+tTBUNl0KpR6K7moeuzq7C3zcrVFrbjcC1nzM1pHU8YNny3ajceQTdh4cXgZ1WBHUAnwjMsm1FkFlg1fnJ78Qh/zowlCsoxrdJBlaGY+/fAFbPo/ablDeg6LuBa5fbnKr4+5G0imBi1Aaw2qIB7TtW5S0tpV97YJbFfR8Y9CxxoKgWKoX2VMOsSf+yUrAaXs0NkqsMnWxXhAO997t+DbNJucuRL3rnjBayS3T7gtrO41I61qd0lOlnTvh0EhYhXE8q1pSlWyIZpg2v57Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39850400004)(396003)(366004)(136003)(376002)(451199021)(41300700001)(4744005)(38100700002)(6486002)(38350700002)(6666004)(83380400001)(1076003)(6506007)(2616005)(52116002)(186003)(26005)(6512007)(110136005)(86362001)(478600001)(66476007)(316002)(2906002)(66556008)(4326008)(66946007)(8936002)(8676002)(5660300002)(36756003)(32563001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RunqXYPZR5/crDAZkY6DPDk3EE5kA/q5gdBSAuOB+/VFu18kU85sPCfl9Ias?=
 =?us-ascii?Q?Oolh5n2iJXkN/SBIi1mVac4QDWkyA8un1SkfaksOqLUXEoRj1F7aFugnXvT6?=
 =?us-ascii?Q?vOI8mVSRe0d77uvFC3Yd+RfbMiYlQo+SeRpHNnhHaVeeDdbqh4ztQGHFGF7/?=
 =?us-ascii?Q?Ok6nugY2u/xdK5oFYIa5l7uO9mBoWZrBGqCy7/siQZ9XXR3ldfbtdeH1pVkt?=
 =?us-ascii?Q?q05ofG6nVj1MCvMtlQpCcFePKWhFrQX/5BmFfhu8V4hQHBraZomSJN/oakya?=
 =?us-ascii?Q?LIw49d/mWj1AVd/OsI/f67qZzCQZM2owDoh+Z4g78YoSTresgNIGU3L7IQjW?=
 =?us-ascii?Q?a8BaDn1LtQsyMl7NMI3UqViNwotVsYjgk5NiR/SMncov9pmgGDIVNPfbHeNI?=
 =?us-ascii?Q?wBstyzHW6jMlVcgO3vsUOZT/2oQPmwHlx9GFvqZtfk58lVp360o6rohinIxu?=
 =?us-ascii?Q?xdWaHSTC/k/ArjOig678PfQzp/1RUMvRhj16wrIdAgXlhX3BqJbbHOaISzU5?=
 =?us-ascii?Q?PwK+ivWZofCMxuL45RqqDdLJeP3Nw0RR+R1tJCUFF9zrOI2DGsyRhD74oLIt?=
 =?us-ascii?Q?UeTE+UQmV2dXECNx7B0aiJuipf0nJRyhVsDv5ohal+I2Ci/Mxu9upjHj9y6M?=
 =?us-ascii?Q?KVgZozmCI6JJzddNV3LEWzDj3j8teybg7d/d8kflvf3GjRB8O4uim5aPE3CO?=
 =?us-ascii?Q?jjUIFteAXEtFjtd9OLD/BNwwga6pPQquDh4aPe4he+brbB2fcZvJ6AEnGLOi?=
 =?us-ascii?Q?d2YJJCkiWV2hJYk1KcffKavgOuvxyaq/XO8TdHWu1DU5xCgcGHCnlVu2GAYE?=
 =?us-ascii?Q?09SJdde7/lXF+ACsYdhzrDjgYQK7CIG6mBSdK57zulfYWYCysfoRc0CIQ5Xu?=
 =?us-ascii?Q?vuvEV0NiBZF20aX70iOs29cq6MsApAmxfmvhSjtluUch+2GpGdm/Nh5qoIjM?=
 =?us-ascii?Q?50CGxvlpu4hWCXiRt/me6xNjeO94sPmcEOubONQpibXOZM5KDZppuPqWvRCr?=
 =?us-ascii?Q?TCfqPSD/M5hcyTSpQuLKIrZrzGkuZ26W4gvjhoG2mtl3UZc7UtoZkHttPJWX?=
 =?us-ascii?Q?PoGqTSoZu+tBfxCq9BQ89PMTjn+3sY9U6C4QNMSF0icJ7Hl9vO3SMsYrAuxB?=
 =?us-ascii?Q?ageE0cdymRehlIuVfURs870pVS4zmdKZ4mLIOtk4TnjhBHZ3JihzJfch5EB/?=
 =?us-ascii?Q?SK7w0C4sicbYvpdXYR/+23Bbz5DHxLz6BLdNtcfqI53asv0WDgqAP3Ch8s5R?=
 =?us-ascii?Q?nWRB0aeXKODXmObNzUXft9tjUrzILwdDRwad/inqyCf2XJuD5TDcMLGKQz5l?=
 =?us-ascii?Q?7Z0xHdYe7cRC/h4aVSlsKe7F+PtV7HtT7geTHaRdU0GrhwxYe/vCPAadJNMt?=
 =?us-ascii?Q?q2HQlz4butJyfQuMyqprTH/JRZHuoyaRIf3OWnbUwqgLM1o5JMnPE5UfK92J?=
 =?us-ascii?Q?ore8EotS8S4/VpF4B+cpkTlEu6ztSHcRmjJK0pTxZRxn3MC3JjDb9uwpliq6?=
 =?us-ascii?Q?unMUZi1HwmKXatZ3uE/Ujdvy+CyaVzjqikLTL97XYuBCs4QILm0q+y+Sjpub?=
 =?us-ascii?Q?vU4Skx4PbIDvCxHtJkkoKluGktRoPpSgthhT5QqY?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2df92b8-b569-4e3a-8612-08db7d180f5a
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 05:24:09.5470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fk0aW+H54De+4sUyi5t19IAuV6WY5LkqPh8h6P+PyXrCTKDbjVUgYEwfSgFPhAZughMHH3A1HFZzWPS84A4Zcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5123
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/input/keyboard/sun4i-lradc-keys.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/sun4i-lradc-keys.c b/drivers/input/keyboard/sun4i-lradc-keys.c
index 15c15c0958b0..95d927cc8b7e 100644
--- a/drivers/input/keyboard/sun4i-lradc-keys.c
+++ b/drivers/input/keyboard/sun4i-lradc-keys.c
@@ -307,8 +307,7 @@ static int sun4i_lradc_probe(struct platform_device *pdev)
 
 	input_set_drvdata(lradc->input, lradc);
 
-	lradc->base = devm_ioremap_resource(dev,
-			      platform_get_resource(pdev, IORESOURCE_MEM, 0));
+	lradc->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(lradc->base))
 		return PTR_ERR(lradc->base);
 
-- 
2.39.0

