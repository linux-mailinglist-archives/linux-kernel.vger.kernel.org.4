Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCBE749BCE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 14:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbjGFMbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 08:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbjGFMap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:30:45 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2125.outbound.protection.outlook.com [40.107.255.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C37D1BF4;
        Thu,  6 Jul 2023 05:30:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vf7i941MaiYy8q0cTPowKl+Ernki3Px6mBD6dk+r5wY+8hyVIEG4XQAEIzcE4jf6+LN/+EFV9gIxZJLqY21+CAnkXiEwcotmBWe4qqDUu1IKH5P28iwtvb5eXA4hDtjWB5brajPevOkd+2qokjEY/e0Po+jcGs6Ai3DJLNU1HNMf+PfZV96k4WjIeyfkXNiJdMTx3dx5xgGJJgMK6jnJm0RNAYayKxhmNYe461xUudlBI9JaWsgqtkwrwQ0cSta0gR2UjE5fsMer1fHAaVlmQH/aZ992OYmxyHEnsiRZDprLUBmiz7m/v37K1wxN9xFVcbmiwIcKFbE2dcl4dLalww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1nyyRFy5+OGyUTVX4RcYkh6UHqqVpPnEGxgL2VbtmUI=;
 b=LWfGSjDcG5DwrIagslrYyFeLCDSsqnKN2x6SE/m0qMEXGR6LsjhIHuJacH1xxPKF4fe1El5dZ/a9p/6MViRm9RV7Brt4lzBuPEln7ZnKeU8mo0yktXHcfndDjnha/MC6lwvbfm/SIIXxKnB18ofQ25Ox5iWA49kMoKj60m2e2G9f80FwkbgRJsOLjH0+/Xu6ORZUwTCNH2m2NdYZExjhWk5sKaDT/nBjLVPSvUJdjYdLf9Qbfqf51SBHYGM3ay8Y+Hg4Sg/eACrSVLZxxX18g//V4Gk3YaRw5n/DTiOhBITr7oXkb7sy7bYP7ksOapyOeg1IHEOFUWV5xLSCeETomg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nyyRFy5+OGyUTVX4RcYkh6UHqqVpPnEGxgL2VbtmUI=;
 b=p3t554dHytT6TY0EoRt2U6kRHvJiAnkiWQ11CjQ9K07jxtWUybpa3M5c8y9zhyuGcNErJ42XsP6BqbgJkajYtj/cFlHfh8mBJV+SYMakdw6BIA/1TRe5+rPFpsrUhoJ0HSkczVMqZCAA7t5rpAQE9tFT+l+37KdD33s4lKxu0hVy4D29BYF9TXVwhgFsiv8aBUDN+JiMFNbusqdOTwsCb8TQmTHG9UKvLIfcLQWJxuPdXiAG5ZOxFgvcHyhxk2AM8M2BeyXylS5AiL2UiXgXaZu5V2I/FhysC+h0X3ScCI0/BjPIJ6xYOQH2jjlT5iPlM8V5iZIdI30eVMWYi6we+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 SEZPR06MB5558.apcprd06.prod.outlook.com (2603:1096:101:cc::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.17; Thu, 6 Jul 2023 12:30:36 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c%4]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 12:30:36 +0000
From:   Wang Ming <machel@vivo.com>
To:     Sunil Goutham <sgoutham@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, simon.horman@corigine.com,
        Wang Ming <machel@vivo.com>
Subject: [PATCH net v2] net:thunder:Fix resource leaks in device_for_each_child_node() loops
Date:   Thu,  6 Jul 2023 20:30:11 +0800
Message-Id: <20230706123021.8174-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:404:a6::30) To SG2PR06MB3743.apcprd06.prod.outlook.com
 (2603:1096:4:d0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3743:EE_|SEZPR06MB5558:EE_
X-MS-Office365-Filtering-Correlation-Id: 00908a29-bd7a-40f9-b0e8-08db7e1cccf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Obrt5Dn/qTtFsHv87lS3eV6KHf4/IeCd2gE/sEqRE96J24+mfuCNbna+VGBiZoycQqBL5P3xxoo986x4rq7DaJPWV0ZsL05+ORzU/ayM7lv263mPYmg+LeO9VQvCp8uypRkymvlY67om1FfT8fh3DFHh8lIKNLGWiyRAdxxSLBUbSNxhshhVo3o8Mo7D5ZXdhFpFXPH1qbFnDb7CsaO4dmM6kN5i/bBNtZ+GM2oLau20HimJ8MTbICnEv03ML7rNbFR90hutH8Awy6QS8AUqJjQ6nNotwFZEIFt6JGMhsLMdAPDYQTYk53WuEtDPdCFTfvgtjphilH+mDKfwWyGjE8FCU0HtrpJSB7wVbjVLVzov2CBsrpQMqTwvZ3+kcpIgn+4zzIQjlDTbqVDQJK69jMFSYqJviotSjfw6QnbNVp6yqFyHTzmqnu8rOUGjqg294G6XWf30HA7oRwMXwop1GJn4lF5qCVUt+HOxvMSnuPbq4gbo0fC63rIFHNJKisJv8mA45mm07UxdaMcgm8zpL3p10hnlsteT+3YrQ894l/JRAlEyh5o2HbDhBaLTxk8JOYVSTwC5x7kw3fw5vID2PUhnf2JatrwzlwhuyKcRz79yJJqttHHP5zromCkyQmgX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(451199021)(316002)(5660300002)(8936002)(2616005)(86362001)(83380400001)(38100700002)(38350700002)(66476007)(41300700001)(36756003)(66946007)(4326008)(66556008)(6506007)(186003)(6666004)(1076003)(107886003)(110136005)(52116002)(26005)(478600001)(6486002)(6512007)(8676002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/+ENYQlq4vZqpEoY8XQtclwCgBw3BtabJJ9bLg8GexHcH1cBAu/GerJ9QS/l?=
 =?us-ascii?Q?ZnqXsSPIx5N0Oyl+XyJLW/qV9Ibk7O0GPmKD33kK82XUVc1pHk5eTIG2YU/P?=
 =?us-ascii?Q?0AvKaJpBHKiacGqUU8unAorOD17HzhhxHsbKZs+gjFsXfQ216m5EItIEn6dR?=
 =?us-ascii?Q?1sDxApywonHhJkXjg49rOA1FnKt44H5jLikUZF0ukV/IAX89faenT4jk12hv?=
 =?us-ascii?Q?ltAXUCTUy/uQk+KZXLi8ofzivtznUn1qsh1IQKFjwKmqsH18YEt09CWLSSpo?=
 =?us-ascii?Q?U6yoKLIqHEbTyg0j6m3e+LhIkMVvufmrjmTVsdg/Hm0cpwdZGhidO90gjlPk?=
 =?us-ascii?Q?hSEsTnqC+54zPTbHbEziDATnRVyT5/XHsuMKq9i8pTx/3vOKShQ8HY0bYi0d?=
 =?us-ascii?Q?cZk0DWTUO6HiH11337kIRDXg8Q1WWM33DYArr7cYp2rRMdJr1jwaf6rdr1u1?=
 =?us-ascii?Q?RCi5hXrZVRLsDDWrcoUv7DHH7e7pmAXq+C70GOfNR6Ljkio/eKnT6a74dAmR?=
 =?us-ascii?Q?FarRfHQzzc4/6X+kzIEWuzI2/9faYbAvkGogauknrJBDYDg7cN7L2iuBGnVV?=
 =?us-ascii?Q?BYpEULIfgd0yY/RKychWcNtIAaUWDFhsNjZbapffEMjDIf96UDX60TVRwAVF?=
 =?us-ascii?Q?L0OKdkGz1h5u3xD17c2OFDQ5BdOXnsboNiANHOfo2mDnG+PnSUuPyOlmQCl1?=
 =?us-ascii?Q?f9agIK/i3mLRq5rYg+PAiyW7mGzMf/whNQHBO26d4rhq8sFxYpk0wwoC+Psz?=
 =?us-ascii?Q?03igAVrdwzfdzG3/H/BLhJAzNK1pV6VJOhYXw2TOzHSYC7wa6lf+nF33sOTx?=
 =?us-ascii?Q?yjNaymmRL6TvkjmG+H6EoEg3QHgNtcTrXUqaRjui1oenHuS1NdDqLSWCN4Yq?=
 =?us-ascii?Q?rV8Cq9sY4nBoJXo0ohFcVAgjwlNC2lCD0K9M4z2xcW/G/6qtd4MdECzwr3W7?=
 =?us-ascii?Q?djgXXzQYkRPTMLQYFYZyOSYSVoAWxEkuJsSx5A/UUDmTFnXpgxjLa/5FjXQi?=
 =?us-ascii?Q?VqMTU++F8DRBht3zUFW61JfGVSrKYd8Q3dQj7Sp9sCAaf1fmZ5BUrP36DjGb?=
 =?us-ascii?Q?Tw5Wvhf/J4R69nXJR+4wjLLpRQKlIBYh6+U/38rA7MZcK95C57Drpm1PDX4N?=
 =?us-ascii?Q?QXdtDAo6C/ni8pmF2yQ8/KxTmKkAb3zjTSb7e/CUrp146+nx4eWu1oVFw4bj?=
 =?us-ascii?Q?5RBwWt2MrrMjPaWytX74qP0NxpwZmZVEEA4ZZYhIAk9m7wHIC+jYLDv3tylf?=
 =?us-ascii?Q?AhfWgfRfH+lpteP+A7tJ3FHbcNllHkodkSJO7CcaxZfHi4O2xTYgLSXRj552?=
 =?us-ascii?Q?1oR0HB/bijywD7aX0QpR5MTB17F3wUJDhUdXCvYjRu+RL4c6Xg6Tutm3hb4N?=
 =?us-ascii?Q?lJ+ODDwS9IgmpFA2Uh9Lpypv5IkOaqYV1cDk+b+ALMzhT4e7b6ma24e18AJ7?=
 =?us-ascii?Q?ov/dvbbkwjGz286zw2SHVWrKmbb8c6wZiXvn+RMhoFoaUN0n+iRwWI345WFC?=
 =?us-ascii?Q?Dz/LMlG6MYPaIg+62W9/qudPwNxup+PpzTfsRYMx2VR/2p/Cs+LYaClbXtT2?=
 =?us-ascii?Q?eJkEOFxLjlAmddnajR0r/hcH5Ux6OVwlUV1JQACT?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00908a29-bd7a-40f9-b0e8-08db7e1cccf5
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 12:30:36.8338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T65pgBu4O7gACO28Hld3YbQA3Yr7xnf8pwirb0euStlnO9wi6eGyU2HJrVY3gHTU4uTJfRAK4X9WxyuJNIeqjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5558
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device_for_each_child_node() loop in
bgx_init_of_phy() function should have
fwnode_handle_put() before break
which could avoid resource leaks.
This patch could fix this bug.

Signed-off-by: Wang Ming <machel@vivo.com>
---
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
index a317feb8decb..f8a8b2ab72aa 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
@@ -1469,6 +1469,7 @@ static int bgx_init_of_phy(struct bgx *bgx)
 	struct fwnode_handle *fwn;
 	struct device_node *node = NULL;
 	u8 lmac = 0;
+	int err = 0;
 
 	device_for_each_child_node(&bgx->pdev->dev, fwn) {
 		struct phy_device *pd;
@@ -1479,7 +1480,7 @@ static int bgx_init_of_phy(struct bgx *bgx)
 		 */
 		node = to_of_node(fwn);
 		if (!node)
-			break;
+			goto out_handle_put;
 
 		of_get_mac_address(node, bgx->lmac[lmac].mac);
 
@@ -1501,10 +1502,8 @@ static int bgx_init_of_phy(struct bgx *bgx)
 		}
 
 		lmac++;
-		if (lmac == bgx->max_lmac) {
-			of_node_put(node);
-			break;
-		}
+		if (lmac == bgx->max_lmac)
+			goto out_node_put;
 	}
 	return 0;
 
@@ -1519,8 +1518,12 @@ static int bgx_init_of_phy(struct bgx *bgx)
 		}
 		lmac--;
 	}
+	err = -EPROBE_DEFER;
+out_node_put:
 	of_node_put(node);
-	return -EPROBE_DEFER;
+out_handle_put:
+	fwnode_handle_put(fwn);
+	return err;
 }
 
 #else
-- 
2.25.1

