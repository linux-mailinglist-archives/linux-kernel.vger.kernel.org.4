Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA5A5B79F5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 20:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbiIMSpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 14:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbiIMSpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 14:45:24 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60053.outbound.protection.outlook.com [40.107.6.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F1272FF5;
        Tue, 13 Sep 2022 11:25:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NEZ61zWH1xhk6X/flD86TjFPXeShSolwl59Pv39fZvmUGaF04mEJO2caDTTgE/CGtdmG5bpwlbcDHzzsDMr1BfT6DTnpATgPignVXPtHR8TdKkwub0jUn5yxCYs8Igj871CmtT12+NZRSeM87lDjlGYTScfxG1Zn8UTpuikg4VoeBFE5v4ohX69F94lLam8UUtF/yuYt2lu1/ZSuI7wrFxRTzOgKVQ60GGbTxVb5rNsMCnwaFjGVGPBN4vJ4Wy3Q8stJbuIX51VUMRAh/ZDyLy5r9OxnJz82qERN+HwbI/bnbtU1wWvrhY06M2ehZYfhstYT/62qSc+D1R9wG2c89w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7JJb0+KLIkszdvuFJ8NTPM1cCUfVgIzleKkqxxBKF0A=;
 b=AMpRU2Mv2eYpOaDZSL0z2SYol0zqWFNcjCIaflF4LABwr/mnFe1iXzxoc73MuinDRB56Ueg3Vzc1FWVgNSRm2Xh6MARNmr4xy8C7u2ax8KV17FmZ0o3vG+4wJucr5ac3R4J/zFtZN/KghEbN+nYaxkieP+KOb+YAIfj9qxliPfDmNaDUYdBwTuCupLTGmNHZNarIFHmfl48DUa/gzMXDTpexC4h1wws/Z0VX6+BlrE63TBy5cwy3pGcM960VMAEiMAOmMZu0SbY+VUDINGNIP8OwRETpkl6Oldzowcie3VuoaLOvNCGqkMoOaGjGA2gVgEIZaBMtVKu5B9Jqst8mEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=variscite.com; dmarc=pass action=none
 header.from=variscite.com; dkim=pass header.d=variscite.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=variscite.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7JJb0+KLIkszdvuFJ8NTPM1cCUfVgIzleKkqxxBKF0A=;
 b=m7hI0u0X+aOzKXeKOUUxVDIbZ50ZCD7D6ls6gSs/KhMO/hofOEPUEyTEPXimOj3Rv9qIpd3PVoMvZdU7VAkf6Fc643Noi4Bv/FSs8jbavOU7ChRbPqRbr1wEdR3/1gbYrd39Ffb8JdV5sesoXoQw7frCphwHZMlc2m+G9AT/EDrsfg/OgPNZMj1MrzGeEHstpnWATprCOMBarUdH4OEpek/wWy8eePUoMzqHB/WKwZaIwCIpbc4s1MbTnVljocx+a+PFKvhmAfHaF+MdQVd1AS/z0GbYbUcpH96d5kDfH8/vhaLQ9b8HiVQ3UiLuH1vxPJ4z7nYmdcu5LaiGBK3E3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=variscite.com;
Received: from DB9PR08MB6825.eurprd08.prod.outlook.com (2603:10a6:10:2af::9)
 by DB9PR08MB6716.eurprd08.prod.outlook.com (2603:10a6:10:2a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Tue, 13 Sep
 2022 18:25:07 +0000
Received: from DB9PR08MB6825.eurprd08.prod.outlook.com
 ([fe80::a88a:b945:e903:42a8]) by DB9PR08MB6825.eurprd08.prod.outlook.com
 ([fe80::a88a:b945:e903:42a8%9]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 18:25:07 +0000
From:   Nate Drude <nate.d@variscite.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     eran.m@variscite.com, Nate Drude <nate.d@variscite.com>
Subject: [PATCH v2 2/2] gpio: pca953x: introduce support for nxp,pcal6408
Date:   Tue, 13 Sep 2022 13:24:36 -0500
Message-Id: <20220913182436.589713-2-nate.d@variscite.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220913182436.589713-1-nate.d@variscite.com>
References: <20220913182436.589713-1-nate.d@variscite.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:610:b0::25) To DB9PR08MB6825.eurprd08.prod.outlook.com
 (2603:10a6:10:2af::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR08MB6825:EE_|DB9PR08MB6716:EE_
X-MS-Office365-Filtering-Correlation-Id: 801f8038-c19c-459a-7677-08da95b548e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2H1w+5h5nPB4AxBlagomEfc+t5mCfAvu/WixxV/7Ot0DGpofVZ7P7iq9gSNUKse3EUWYQNW7MXdm21qefYIXB7YfeKWorx5vMrVk+cHet+tZNELR3xGs0V0xhjL2yqbtTLajEyj+wnE60JsCKECtkCQe+pSo4aiUyVQWoJo+r/XFGa3q21ezSTHklgRoJhFg5/xF1rNPRneR/cmm6ahXwdFa/9G464RBDHTMAbw93Q6XUYwTU4n56xAhgGAD2juNS/Al1mH1CgkBohHGUnnkuUpmyO10EsiaBiBc8flecDkifmZXemR0wsJQB2KYfUvZPI3y3Ed4/PDcjmNnGaZo1O27KCBEwLXrdYKWbp823JJzzBKagw8g6QlXtA175v1V+9lpK62U74gq9acAR38HIHvs5lKXe0rbhJfT8suYjnkJds71vqpxL+fJHGZvYyHHD7rn+6Q5ZZ1cgAdyylXWaxzLv5NRv9PhLOrAub2sYfdqZP5UAwCXpLn8fnQ8Qm9082lDSTmnHRrioizo5CW+NmN67nPrwprvxoOBR+qlA8wy6lajYPfYuy4bU1wUt4a1TQaKM/Gy9sAkIBRn+f+pofKvhzKj/echihmldqoz2dOXOJPMrqTpg2GJz34QU/Va1JqYjiryk9/DEQYA/NQ5wzViLlEWN8ipshz9C+soHEwsTfIeFQwiaslOhpJev9s0MdKOA3XDBQkI6+/75JXIUOeDYTj+W6nr5vZazh5L00s3xuCkC+YCZ1J4XCW4z4xT3xIEJWza+eCdtFGHeEpLig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB6825.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39850400004)(136003)(366004)(396003)(346002)(451199015)(316002)(1076003)(6506007)(2616005)(2906002)(52116002)(8936002)(66946007)(4326008)(38350700002)(38100700002)(110136005)(8676002)(107886003)(66556008)(36756003)(5660300002)(6666004)(66476007)(186003)(478600001)(41300700001)(6512007)(86362001)(6486002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DNjnQgn1JHg0DGPy0OwfdR8D9j5TngU5ju1dYPoaL3H89L94R610lmY5Te17?=
 =?us-ascii?Q?XTo0XGrCqMakDHCRkrWIaTYg/eDg8Dlyja14SxBJqHgPTf/BbsYuXxnz7z86?=
 =?us-ascii?Q?6H1GWShJnMrOhbw5wDaGdcaprHqG3lsiEmMSczY+VNF3WwYqcKWX+gNMMNuo?=
 =?us-ascii?Q?nreOf1306eFEpJ94yb5jczUqD/7DXTW1tbG2MxVbSa2jGntQCIG2isDIjzPw?=
 =?us-ascii?Q?t/6HmV5KCAAtl0zrpLD22qxpM6ytb9YViklDpmdXmq5eITdtnpNBC7lKFsNf?=
 =?us-ascii?Q?aoFVNT8hKqi+ucvAGvahYJj6vEdZTisEhC+EX4jN8n3QkSOUGK8G2Qsq7oul?=
 =?us-ascii?Q?kMWYXKvKwSU8hHviLHg48SoEtdnd6O6nKLW1pyb0CYeIBGPw40Q2oGSW13nM?=
 =?us-ascii?Q?WprR65ixstVQ3tqwD1gJ78OEqn7ixx1UbNNd2BIQvQBxnzN3+8X8ILhvxEan?=
 =?us-ascii?Q?ZwAl8rp4fdoslAdkZkfeEz9casp6Um6PDUyzXvoGn23WYJYfiuQF+0n1H0gm?=
 =?us-ascii?Q?E1f9ZjTFqud7U957c4Foxyl5krUyiHiLrI1u4ytX+jkXfboIBpakXtaIT86O?=
 =?us-ascii?Q?YlB0F16z6HsgWJfcTL08K3kye9rcq848G1t3Cfp/Ok7Dr/F+JzjrIN3NMezK?=
 =?us-ascii?Q?ZuOdAqkW4Q1Idf8DTZTvah6/goZqv5XgR1U+a4/lt/IUej1I0qkLaLrV2mJJ?=
 =?us-ascii?Q?onjM/3bw06cT6xddmFXuHpXsfMeZTGcyvoPA+eS9VMfNzJirHG5jTp5yTDSt?=
 =?us-ascii?Q?bMdiXyBkqhjMwMRkZVc1TgatEDAUJRmuyETX7M1IgEpBroFAjrBDIeLhcAEN?=
 =?us-ascii?Q?LG/LvpV0OZUpGCMn21jG1CjkQtqbrPXPg6v4nRm3j4el8R9n0ZdDswtjsIPw?=
 =?us-ascii?Q?ZQZTueKUY9a/xPsn4yTNXW310CYoa512mmTZwGS8WgTcZuF4e7HAPs0eRZi7?=
 =?us-ascii?Q?Sxg0TMiz5U7eHQIGR2EeZowr1yuDCIP9zmkPj969N/BYsmcTF5yjl3Z4MbWg?=
 =?us-ascii?Q?egZgTGx+UB07mR+z3mRp/vBo27fcS+PgpaDxpN14C4mrdLxWGFLldVLhJyf/?=
 =?us-ascii?Q?cYRcOzmcBe1ZZoHEVpEdghqq6z41QWfu8l9EPMbR6n2E0uoQO9ak+4yUr6DU?=
 =?us-ascii?Q?FVmhVqORZ2s0PoUifWjzpjZ1M+TX0zIMbWfvj4+PujbVHpEsw7ba1DDJ+RpA?=
 =?us-ascii?Q?ZcZg9cRMDF1d2IjypCAaQRMibRTCxamYQSr28tbPpFtw75hchrEdfOUa2nT3?=
 =?us-ascii?Q?Me2QrZAC1g9sdLHXtwJ/zBCbiJe7o16b2ySCIN7Ng8ZT0RDgaDswoKoNbo4H?=
 =?us-ascii?Q?wQ3SE4WMwSJF9RYP+yAD0ZMav5OCMTU4cDxJZC0w2yEOHrnKMznDySzzXP07?=
 =?us-ascii?Q?aBwGFr7od+Fpp++jbfXg2Dtubs7Ujzh+qYepoTD76u83YHV29S3ov1aJi5FW?=
 =?us-ascii?Q?8eBtsl/ew+7Xh1Dr8pIUQyZErZCO3YNueI4vWv0t7o6CZICblLElEGkE7BN9?=
 =?us-ascii?Q?Qwgu6RR26wHLJL06gv9ZaiLVstOJUWtZ4ss/l86c/ByPwvQN9hRuggUsXm33?=
 =?us-ascii?Q?A8PATKPkATgcZjx87WjUd5ZitCLZwX041jp/KVJl?=
X-OriginatorOrg: variscite.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 801f8038-c19c-459a-7677-08da95b548e0
X-MS-Exchange-CrossTenant-AuthSource: DB9PR08MB6825.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 18:25:07.2822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 399ae6ac-38f4-4ef0-94a8-440b0ad581de
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qx0/gyMw3LaNmFea0N6VzzGX2OFaA78tVSSNk/Pyw9ajcbhLxL70KtrHv7+8TuVP0Ahki5SyoiOp5mkolKUIiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6716
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NXP PCAL6408 is the 8-bit version of PCAL6416.

Signed-off-by: Nate Drude <nate.d@variscite.com>
---
 drivers/gpio/gpio-pca953x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index 2925f4d8cef3..ba012ac7cd8c 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -89,6 +89,7 @@ static const struct i2c_device_id pca953x_id[] = {
 	{ "pca9575", 16 | PCA957X_TYPE | PCA_INT, },
 	{ "pca9698", 40 | PCA953X_TYPE, },
 
+	{ "pcal6408", 8 | PCA953X_TYPE | PCA_LATCH_INT, },
 	{ "pcal6416", 16 | PCA953X_TYPE | PCA_LATCH_INT, },
 	{ "pcal6524", 24 | PCA953X_TYPE | PCA_LATCH_INT, },
 	{ "pcal9535", 16 | PCA953X_TYPE | PCA_LATCH_INT, },
@@ -1243,6 +1244,7 @@ static const struct of_device_id pca953x_dt_ids[] = {
 	{ .compatible = "nxp,pca9575", .data = OF_957X(16, PCA_INT), },
 	{ .compatible = "nxp,pca9698", .data = OF_953X(40, 0), },
 
+	{ .compatible = "nxp,pcal6408", .data = OF_953X(8, PCA_LATCH_INT), },
 	{ .compatible = "nxp,pcal6416", .data = OF_953X(16, PCA_LATCH_INT), },
 	{ .compatible = "nxp,pcal6524", .data = OF_953X(24, PCA_LATCH_INT), },
 	{ .compatible = "nxp,pcal9535", .data = OF_953X(16, PCA_LATCH_INT), },
-- 
2.37.3

