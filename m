Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0843D747052
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 14:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjGDMCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 08:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjGDMCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:02:34 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2090.outbound.protection.outlook.com [40.107.255.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4023E6B;
        Tue,  4 Jul 2023 05:02:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PC+F9bmT0A9VWt3nbRO9XNFG3+MMnS8DkUgpuzLpxxahedcboXDfIkY5GZCQ0187jdAmokIfLeRNJrW7FIpbkR8glediELg98f+0QNfsP+HaFvgp4MiN9xlio93Q/nUNGvy5FxP8dFoMgQk2IfksYLfS2BoZ3Z6dvNAResJZ8kznTbwSCJ+2F++yiTPQt1Ezy6zZlCxMtlp4Vk2gE6C/3PifZFaEY8WJbzYGGntSAgW3pojDxgNcn2XgWBe3HGGhWtjCbJmCw1VxrzshwqoOLMJBCxdQlbmEHZzFrn/LxH6b3/TcXUsuVZ1WNheMLVZfNTcpjy7RXC1VtG647OoB+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVrBwZBniYy3cx6EBtbxfzPD3+zks+yKbbat22yW7FU=;
 b=QTKTbARYcLRVkKcdZn71NFozdrswilFa3EyfVyaCwFpoDiS9EQ7RKVvyaO0wz3opAFz/Hu0oMrrHlg3d/BTdYweFjN7HZ8KgIc7ajqOnfmPhcGttALhnePoO5CX8uSakmuiXBVJfOl/GoP5OGIYB+wp1XKl8mJGzoPPxcPGitK6GMXvIq/Yj6MRmZcmvpT685IksPnFBIXZ1ng3erZIONsePJv1g/vdfp653i95aDwfVz9gWjSPpvtGhUc15TTEDKYSC+ql0TgLMq3ap4WfsaAevsew82OkGdwMtZtHZHu1/Dc3Wt7Z/cCXitxxCm4UlHbbgSuVxpkGan2191IaSuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVrBwZBniYy3cx6EBtbxfzPD3+zks+yKbbat22yW7FU=;
 b=VdN/VS9Bcl6rb2in80HSDuszatbD4tFW7bOxtd16WKQP2oNYjMpKQ6GoIIltn/8rImdOYPzBEoROQQxxyELT7tv7d/7bXAWWRl1YaSLNa0GxjWqXNTfKKslg36AFwvkdpDGup8zrwM3Cb7wWC/mHO8tcOc5jwTrI+ExFwytkHH99Ryn1BX7PSzS2fS4NMXy+HAk6nqoriiAmQ+EhdYFSF+lnkSfNgTpRAijAtO4DiayEXWa04fSmHS1ekWkdoFMGRYocQa+2p8/iFVm1cK4mbOt/XEMsLbvYx+wBFgCpD8eNvI1Utai7//wz2iDSPbs3IImbR3FFkLTanEATaJuqwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB4999.apcprd06.prod.outlook.com (2603:1096:101:4a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 12:02:28 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 12:02:27 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] reset: qcom-aoss: Convert to devm_platform_ioremap_resource()
Date:   Tue,  4 Jul 2023 20:02:07 +0800
Message-Id: <20230704120211.38122-3-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230704120211.38122-1-frank.li@vivo.com>
References: <20230704120211.38122-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0144.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::24) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB4999:EE_
X-MS-Office365-Filtering-Correlation-Id: c9d5b579-2373-4a6c-2cf6-08db7c868947
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 54ZhvwdXV4RktlJKZsxcw0lvclZUiPxD7NYUfzAYJYwcV4wWfkkDBIvISk1HwTmtUB7m0jazunMqO4vwrK5CHf+EuS+vR2SCOYVNz5CXkZ/wtjONrHPkkW/+2+Cz6b852SKxKOgg4enS7Jeo1TVRUAq+1kM3jL+ceXCrHkkNC3/X/LaJEcvsS57kEFJBj+1gYTT4UwVbzOJ13s67gaAcwLMUiWvRlOzdck+y5y2J7E3ketcnQl7NRtv5jB0H6wWVx9LZYljJ4u9qooVyO4u41B1zCZ6A7PPMYP1MYGGY8OR+6fyFEcVQqaZNu9fzWnCOxeUHKg9euSS01O/QX9Gwuwm9tAyeFOo9Mp7TUHIGDt8JawRePxhnTLHIT5xYL/VHZcCDKjfcI9alC5yV4jHYfy3rtI+Edu4zIzwJteILwndSegeXcwBP2Tj+F1CrEJEPIy4Ttt+A3LuAWKJgohY2+hR1sSjY8lS6uRnHZIxHbCYnyiieLNRTit+ZfT2IZ5mhOlz1+/w5bjq1TMEbB2If2n8+cgl5+tiFC4T1SYuqeoUtDBpbt3FWTJw4KffZ4xQ8np/P/nz5Acu+NPr26G7vQcwWnnFO50p9zVrrH3+b4muUQrCACim2qy4pVqaGfgZc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199021)(6666004)(38100700002)(52116002)(38350700002)(2906002)(4744005)(6486002)(8936002)(110136005)(8676002)(36756003)(41300700001)(478600001)(5660300002)(66946007)(66476007)(1076003)(6512007)(186003)(26005)(86362001)(6506007)(66556008)(316002)(4326008)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wkBgN1gGVKrDpJ0spev9XOrbiWTu15XjMpNTdbrkBFssa6jUZ56SECx25lrg?=
 =?us-ascii?Q?btq9HCoGs4J7O4rOIuahsXUj1cZKi61B2RxZVhZVxk/i3zqCyDmw4vVDEC5+?=
 =?us-ascii?Q?CFfia8NfqHZaO974dBBTtpS6wbDdCBogeBFxlueEcXxb72d+kWlrCpt39jpx?=
 =?us-ascii?Q?i2NVpW3qGF05HPqIjv/yYMaIQ6W+U/0uCUBy4pwVdqWgkDla8xLe2B1VgCs6?=
 =?us-ascii?Q?T0mY7+Xz/cRfTLVZQTwxdf08qmhcg87aIE9peYyguQQu5+3FYDz0n1fhiT1g?=
 =?us-ascii?Q?davrIRB9Xu8XkZBIakNQG6fObcHS8CnMmfEJOb/MlAI8JsqSrnHzzbUbYQZi?=
 =?us-ascii?Q?vXFC8z0KQ1WCjVyoXgNCRxfAKWveQ+lPPmW1VLW7Gqvq25cqvcpLyM3TpcKl?=
 =?us-ascii?Q?c8QFeHqMHp2eFB1BueaXfQ0Kj3NUWgUhDfitlTfk3S5+b8D+yk1rHvI2J2zi?=
 =?us-ascii?Q?LvG89rYF5WWfviKvymYxb1YKPt38mj7z2rYpSguJoa8dU+a7xEk4Q/jzsv8s?=
 =?us-ascii?Q?E6wTFf7uqqnWF2VOAoEQcMvXOkTXE9IPygpTkRnOfcIzqPkNF9US808A9S2s?=
 =?us-ascii?Q?AjC5yO93JmWqqAwhJeV5Wr+u+7bKbCL8MlIA8b1rGjlI4aEWNO4t8mOZdZqr?=
 =?us-ascii?Q?GyRrkVWYaHpAaj4gORxr6BIZGQUw6xZaELMKniZb27TOYCJ3MUFfIfY3T/KZ?=
 =?us-ascii?Q?I7AehwDSS/LodImHyoHjRZGeVPMTQotNleNG4tQ5d0wm4FT9yBltri/7/7qa?=
 =?us-ascii?Q?5fzi9qyEXc8SNjr98Vp4A2QT9JwVSvSkkAfMFbpd9ENGdLwg2QD7RtAUqINk?=
 =?us-ascii?Q?1iiEDOsDaRQAnumGBh2lwHIuiyzblwFA78iSas7hNhS3Dqry4jTe89TAebxO?=
 =?us-ascii?Q?8Xa52M6mdC5vBYVVxn+z4o4WD5rqON1830jpcoNynrLYpnRd2ijNb4I26RKw?=
 =?us-ascii?Q?VhD0H3M24p9K0OF71duijPuB5Cd6TrpVtfK+5qle2w32fWi1m2pMA1vWeIgC?=
 =?us-ascii?Q?RAMj94/o/hpYx3McmKF+25sQjA7Jyi9jvewO75hPokRT37AwftnSjyzIDTeY?=
 =?us-ascii?Q?xElSzz5A0jYG39RxZv8kSBHnnpFpibryz3ip89wwmCAQhjmAh7B9ZF+uO3vm?=
 =?us-ascii?Q?AEDYIYnUZaRIRvp95L47u1s0TmTmklie64o3lPzBiYQ141JUZxPKotEdc5w0?=
 =?us-ascii?Q?U6Hxn1+A2sek7ix64F4+lr43iLvhxkRyN1DEjMLvTjHE+lADS3G2HMmVSzrA?=
 =?us-ascii?Q?PDgCOmhylmcYUmJsxSfISAuMMYH6bLTSjAxnSyLtZikxBKlYzEG1JsnvtgSn?=
 =?us-ascii?Q?RONb1DdS8EmBUfJkNWDEir2Z+kPXXTSLlJ6taOMosvIIGENZPEnoVLsC5ua2?=
 =?us-ascii?Q?D82nZVBO+g5le4KpEtHWug/XQ1ZCYGvfZ2EUIrHf+8VXJ9/PXfzftUVmQKHC?=
 =?us-ascii?Q?YU/XPLBviKAmBWKI3KRcsu8R7cYBEf05mM7gPT1CtfuS4GZt9mGIumoTBQPX?=
 =?us-ascii?Q?Ck19F16HE0kbrVhH/V57NjNmeGuF6UqSz2ZuuoPNLkDuwv5BJzOFtQKpZRkb?=
 =?us-ascii?Q?V5iVaOt+1E9PWdngy8OLLbKT6gM8hm50Ag1x/Isu?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d5b579-2373-4a6c-2cf6-08db7c868947
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 12:02:27.5694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JuIgtaaEXMDU3t6R1DERswPDpkz77vFFMUydrCf7y6AFTaHjXOvqg1WtozH1QGwFp0wYInqubnTr5UXueqyXpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB4999
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
 drivers/reset/reset-qcom-aoss.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/reset/reset-qcom-aoss.c b/drivers/reset/reset-qcom-aoss.c
index 9333b923dda0..28151cbd30eb 100644
--- a/drivers/reset/reset-qcom-aoss.c
+++ b/drivers/reset/reset-qcom-aoss.c
@@ -90,7 +90,6 @@ static int qcom_aoss_reset_probe(struct platform_device *pdev)
 	struct qcom_aoss_reset_data *data;
 	struct device *dev = &pdev->dev;
 	const struct qcom_aoss_desc *desc;
-	struct resource *res;
 
 	desc = of_device_get_match_data(dev);
 	if (!desc)
@@ -101,8 +100,7 @@ static int qcom_aoss_reset_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	data->desc = desc;
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	data->base = devm_ioremap_resource(dev, res);
+	data->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(data->base))
 		return PTR_ERR(data->base);
 
-- 
2.39.0

