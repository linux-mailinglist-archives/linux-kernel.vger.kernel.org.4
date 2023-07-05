Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72595748050
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 11:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjGEJBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 05:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjGEJBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 05:01:40 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2110.outbound.protection.outlook.com [40.107.255.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F42811F
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 02:01:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5tV8P+icU5MNpe+Yu8IioQJ2UqpMHgIJqw7olbShCUOlAhjSF6DW8NwCcTRWiqXixAuzzL/eCZqe6UtKpJ7D/evCZqwfFcYydm/Vz03fkhgOcxiUgKVr3K21cmqqCkd2gKzz0H5Trptuq75/M1U7euPOz41JKZk80fySPcLuyKu1E8n+pThPDEptsMkeykKeOl/nfb+UjTse93Ap7PCp4QBlHAiv2O+5fe6Q75JDm+hCddztaOql+1vC5Y1kjD9kC6b7LlB1T114b2+H3oqYalFt9Zp7qSY87984Gph2TLVnT7BESmMZAxJDtLju+CK1s44MOj57h9LQxR4yuWnWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bi5MN2Lo1Xh02TYYVOUmZNbL2ihcOvEZTo6JAy8MYTU=;
 b=RvmJPcWD3oMEboOoyykuNBfE3ipiCOrTmgqgdppyK8LpCOZMIFtGVSKoRZS6MMhz9GQ4s8EZVL3AWOKWDZVVk/qHajcrek5sxNiI5g6KQespaxOj90J7VeTuhlRAXO2Mw+TzsIWh93wnaZz3ag4vZWi8qCfNn4/DZaQnklPzZ8ONxF1SkM2X36CWU0NvbC6i+pwcoCD9rYmLWehFGLCoSStrS0T6h9c6Y6wkHucmOTzdLpWqp3XuQ++lmQOhfACq/gIDsXS0+w8cQaFp1DrsdR8Dj5aI/wapy1oE3K2C4+bNHBuL2EOSE0iPg8TIk3FSpBT1CSY1QDxpMeshDIbpyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bi5MN2Lo1Xh02TYYVOUmZNbL2ihcOvEZTo6JAy8MYTU=;
 b=RPswE7d5b6Vd9Hoa1X5z6wAyrtZyy/1f0f7QNSWpb6myRvjzt7Fcp0t4xKt/IJnZvdQvpHf0ZuPQjYpAtCJyaioIRO8kI1CF9gFy+IZO4ht6wOdJZgmfRpHPQR7yrqr3uMLYDyCAADjrLEVZCYsy4cu+ZSeVyXXP9GIKW1WAg/+PFY02YHNkXtRhJztmfPiEV8HaBr30o7n8oIeggX7s/OyVnPVRn5Vfkti66FFujZxRVkCHwFQTddGgkF2jpLf0bEG6AbbOjYwYOJUiiUrJ+cuiHQcYNO/1YHvAsveyLMj0Rgc0/SuFyRY572AwoZ5xisO970kEplemugPj7T7O1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4354.apcprd06.prod.outlook.com (2603:1096:820:79::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 09:01:36 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 09:01:36 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] phy: marvell: phy-mvebu-cp110-comphy: Use devm_platform_get_and_ioremap_resource()
Date:   Wed,  5 Jul 2023 17:01:23 +0800
Message-Id: <20230705090126.26854-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:3:18::19) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4354:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bc4023c-0242-4600-7031-08db7d366fbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2nbYAh/ljXdWpkVwx0Lxou3fWvBMqNSSIDrI4kxf4SGSiz4FNOaUGG7HnkfONWRHMHLivbKjZ431F6YFXR48ec2eIoTJJfd47PPeS8k05LCWDBYwdweXKMZkoQnUwAjwRiPq4H5GMjjDQvr5o9jZK7gm300RFJ0vrVp8xGj+RSOYuv+f8B45c4FkTD/f4z/fc3G+PlWQhk1WuHo5EFzHGhEWswZgWC3iTdK8lui4Aj9JsCFSio/4vRUVZP42Hm4z4aYKA06Txc2OVSZVVIGkhVJUsPaGO8r8tvGw0h16ryNSacE6r4la9XrLFzsJlN+bud6199JtOevJZcfjTFW1zAfSE8AoUoP7e0VcOQ8CHx0zuNC9AnS9PMsKosYnKfgXEsSk3PQkHg/1KUVZCnWnryjVH2eoF9eyCE5iYeFqnyE87uSpSl9Ijsxp04DoRE9AlYcDmDcYQSSaGubf8i7Kn8Aczlnon+aPetjioklFLb+tKoXBEQC+kVZvJ/aukNnK28uRgoSbkgw7eh/lZod3EDd9W3xVa5HFUPkHeYThTOECJkuyvBDvBQSkqqQr3PRSbJ9Fcog3EpBY0QrQ3jDQS7xRQiv9NjS5SE4VT+Ld7hGI4dQVT1ybfuAPTJ0w6oey
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(366004)(136003)(396003)(451199021)(26005)(6666004)(478600001)(1076003)(6512007)(6506007)(2616005)(186003)(38100700002)(66556008)(38350700002)(66946007)(4326008)(66476007)(83380400001)(110136005)(6486002)(52116002)(316002)(86362001)(5660300002)(8936002)(8676002)(4744005)(41300700001)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CQpjogTVyBlMuMEzojRZwM04uKhyJt3R3/3maLZJTpjhxwxzgDFYCRK5LaPB?=
 =?us-ascii?Q?GRy1oGJRYDihzYROhnlb6PWKg6h8T6BbLghySK33E/FnxI7tvnQZRTiTvu7W?=
 =?us-ascii?Q?ZkvyDl8zpX/Tlb5aeWjh+JbiBVoEs6dZTAh99yf6Sj9Y107CE54YynWBn1JU?=
 =?us-ascii?Q?G/FcFUliEBVYJxxwFYzm3WSZQgn/4alK1vuqQfizsf18aBMa5aIeLfxeRRqG?=
 =?us-ascii?Q?hWJxuKqQgRPEg5dDk+VSsouIY9SISn3/0NUQLf6pHAwIKOBKRZioaSJyoAI6?=
 =?us-ascii?Q?NsLGRSXBacm2+XPGk6X1Xcv8pK58gPOrQME1XDxBDpaG0PPwaShcdXV2O/Hn?=
 =?us-ascii?Q?z6Ng9189FCCGvVi3AA9QaKz6xogc6nuyWcX7NKSlQZms9HcLq2xCCYFwI3wC?=
 =?us-ascii?Q?HC0bESY+6GaO/+4mjkrIpSTSxn/LTABYykceO23DzdQEsQLhqklZdA81dMw9?=
 =?us-ascii?Q?s+o3v8z/1asqc4ZZcHZXA2DlX0k3iwqFm4NujePgFbmN6SJJ5ngc2TS0wL2m?=
 =?us-ascii?Q?LHPWiXBNweUBGIlZUtOQ8QMRYbz5iJGZKT1BeZYZJM2PjAHurmKfS9v/OVzM?=
 =?us-ascii?Q?+VH2219Lk9h+BZ1q0E+GUkiaaC/jygWY5jv/MALL1jr9BMujEYaxD0TWYz/g?=
 =?us-ascii?Q?pk5S5wLSP+P2Sg4Z0SRCEDrTcR47uA1SQW1GGpnLbCxroMvqysVeOj5dtp0R?=
 =?us-ascii?Q?YqGsUKl+5OWrk4neGUVugGycYLNJCJnqka5DEGtjSBAQy8VHcN2tC8h+Eypj?=
 =?us-ascii?Q?emLNg6zN4dzZ8QBGq0fOWXmkS+sE4vCVe42g0QYkNZoTiCiRPywV0gb7nmUj?=
 =?us-ascii?Q?BRyLtYRxjKsFq/L4/cbJcMj9agv6P5wLffvTTlRKLxoRhsHmQ0h5YTSFApuC?=
 =?us-ascii?Q?KjtMeAS31KUcS6I8jMmJa+NbwbvE+/fPsrFo4sMPZa/T+nwo8b0SR87ghfH8?=
 =?us-ascii?Q?e+IJ1LlF9PHUBVRaqlOh2LfW1VXXMpoxqfd2dfVj469HMMaWskM0Cebmul8r?=
 =?us-ascii?Q?Gk5vW5giYxhcpds3ixzp9zfprl/slxE0GOfFUOz6hgbVaUVsmV54S3cjBbYV?=
 =?us-ascii?Q?7TZBfpXZn/B/IbsvX8aTC9UtjjGdzlzrrWWgx6SHBAMNZAieSmdrckRl70eC?=
 =?us-ascii?Q?nlqjNs2SWJQoctBXOG/mrhOdNsZUeoBGX2a2hBp6KwSjkjBG8iH6X5yh7AEz?=
 =?us-ascii?Q?RU95dTnSK7bK+6Yk2RhC3ZhJVcgKK07yPtCR4T23+jBThjI4gN1sXlShQtXO?=
 =?us-ascii?Q?SNBjpZQTqo2JBnwuycgWh0JUxUPDrKwjWAjZ4gEHZnCxa1twBtGzBBVvlFF/?=
 =?us-ascii?Q?hbKPpfb/QopSpsj92F06TMbhmHIWFcocdFskcck4C6NDP15hiGfFKn5fDjsm?=
 =?us-ascii?Q?kKZ2ijuh7AfJ2G7arazkmkVtasCX3pApapcz9LuprOl0epYiXVAXmpeUg+4K?=
 =?us-ascii?Q?JerWFic/mTc4+SKnq9Q231tmLfnnG6aFzL+GrTXJEt0x35mLaInlb4VHJK5c?=
 =?us-ascii?Q?bplocZhpFewfRvmpfGiyECzoK7K7SQxGqNT9nGug+otkU7exREAw9kqI7RRJ?=
 =?us-ascii?Q?5ug4tt07cOOsu7wS8XwWpCLnUQFbISGxcfTSeOfr?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bc4023c-0242-4600-7031-08db7d366fbb
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 09:01:36.1480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zTUBNuaHCtn+8+ATV3xiNWVL5FT+7D7FiRSsG34Wsw+MW95FLgWikmzoGDIhmjCBXk+oAtCA2+ZOT+cULjvDtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4354
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/phy/marvell/phy-mvebu-cp110-comphy.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/phy/marvell/phy-mvebu-cp110-comphy.c b/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
index 34672e868a1e..ddaddb3c498f 100644
--- a/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
+++ b/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
@@ -1011,8 +1011,7 @@ static int mvebu_comphy_probe(struct platform_device *pdev)
 						"marvell,system-controller");
 	if (IS_ERR(priv->regmap))
 		return PTR_ERR(priv->regmap);
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->base = devm_ioremap_resource(&pdev->dev, res);
+	priv->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-- 
2.39.0

