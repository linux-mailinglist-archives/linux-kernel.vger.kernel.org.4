Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB9B6F0DC8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 23:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344257AbjD0VbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 17:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344244AbjD0VbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 17:31:11 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2058.outbound.protection.outlook.com [40.107.104.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056851FFF;
        Thu, 27 Apr 2023 14:31:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fuDQ0Fh2d/h4SaLkL5yWeAXFpCk6O8BKKIzTvy6EZDzw/yyVbxQNzXfvGJj9KABikqSaUuTeGlILWebt2py8sXqSsO/3/j83DiwEyio+jBbX4ZHxD2tB4p6jgsVwzHlzbh+fcx057PQQ9n4NR303OY/uB44Ir15/aG/GmazfPB4eER1yG7Xzxd+x02XhQOV4xqPIewutVqaUOljfF1sM3wxaKubCh6Cxb1FDhvTp+wQlSuKMA35eXhdXK8HwXfBW+nEp4iPqP2x4ywhjBO/QCxyUNfLMsWYOqhaRik2Hi812jnQRrMfAz5/X7y/Mf3umj2tf+aeiZsrYX+nX1xI0Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NNLAptyDrPtcwcqjdg+EmeT3vpxAdbvtpJYkhCB89cg=;
 b=AmvWok5xi2NDcKSFmXuzTK+v3TPVXwlHhK+ygYaK84TqGtWYRsUEjGrFJNuqXNMj/rUajeX0mUtHlCChbHnqf6U3mjpNxKb0F3vCWMo3NTRPuOpwtJW1VZFVuuwiWzq1espXQ8WHpCkxEI5AZlrdRWQr+yyeijGVRTvIUpRvg8ph95AzK0MS35mFfhtO3I4o3CEXdIztM/P+W0VcJbWPD7UHGph/J9HLasbF6h2mTESXsNlx2JRxhkCIeNw0IHUpL0PoxPhsej8pc6bkR947pDcuPZtQhKQgGoUAKjQNwRm2T7UN9xZDZRbtSGmwL4ObIwXZJm17coBiFhv+wbUXPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNLAptyDrPtcwcqjdg+EmeT3vpxAdbvtpJYkhCB89cg=;
 b=GAhLSvkEa0BR/gUEOZdx1qtjw1ALXi/1AFkFMe34mOiey4akInh8D8Qn4oGgzWhRq0NHXqfx5ZeKfcgdvrTIY5p5k7iTaIHld7Ev3Dw5E3ZSWa5ICmBjOoInL9LVMb/a1/ruYJt+FlTn5D8/5rSB5aggpzag3PRh1fRkLw/Udx8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DUZPR04MB9900.eurprd04.prod.outlook.com (2603:10a6:10:4da::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.23; Thu, 27 Apr
 2023 21:31:07 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::f1d6:f05f:b8c6:4353]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::f1d6:f05f:b8c6:4353%7]) with mapi id 15.20.6340.021; Thu, 27 Apr 2023
 21:31:07 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Petr Machata <petrm@nvidia.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jean Delvare <jdelvare@suse.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Parthiban Nallathambi <pn@denx.de>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Cc:     imx@lists.linux.dev
Subject: [PATCH 1/1] iio: light: vcnl4035: fixed chip ID check
Date:   Thu, 27 Apr 2023 17:30:37 -0400
Message-Id: <20230427213038.1375404-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0373.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::18) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DUZPR04MB9900:EE_
X-MS-Office365-Filtering-Correlation-Id: 888870d1-756b-48b6-3005-08db4766b5e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gWDMoIo9fVpCWy35wyFg9ZV1+SWf65XXgSLNaaRlmZUz3CRu4pMLP5fc0ol7og7pmRE7DQWVJBMprBUpDkVke2KiqQr7fFC/zcI0Qu6ZMSxJWEUKWStCXj412ZPY7K2U+5mr84GsgdtM6bRl/DDYZDM5QGDDXLQ7hEbx2yeIpSDaCqYS6+/z75bW8g8ozq7rb++JT5v36Kgzq3Jaubn6PEUCEOWDhlQqrisUGlPD5wLmvyKiZcAqnlzuH+n2+Pbe/gPQRbNJ6+Tdz4ZJPKdowR4Bv9CpI1OfWnJ6YYVMioxBEVvFaYcaelt7Ld+ejEpN4mClrcXDe4voIavVBcPEetM2LRdmWiQgFZc99C7lIDA4NItxr6bT20yqZt/1L2pqJWg3QSfmdC3bt8V47ifF2JHiNq/h+7To4BWgSi9+DFINSs/UOq40ArQ7sWic1b/aVLkivPS4JC5iygdxNypC8tqWf8mperiDjcvdaA0xMbqyq2vZLgs1KJTnwZThAdfDswTa2334RbNInG8H/5LX4M3DWIMnod6Jrh8h5mekTpGNyzul80Ey1vQh6tUeUj6OdEshjHypLzOPA6jlGpRPjhkXJAaZ2m4uvFiq0Uh0pAutiwcl/yCkBlmfv1/vbik2u0lGfMSQzbJ6x6M+AacHww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(451199021)(66946007)(66476007)(66556008)(6486002)(52116002)(6666004)(4744005)(2906002)(26005)(1076003)(6506007)(6512007)(921005)(41300700001)(186003)(4326008)(316002)(36756003)(5660300002)(38350700002)(8676002)(8936002)(2616005)(38100700002)(86362001)(83380400001)(7416002)(478600001)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?odsW9L2ZkWmlYSrAi5/N9jcsFYtyMyIxA6u9IaL9HaPrSnIdcWrlQmxQ/kCU?=
 =?us-ascii?Q?ZGL+Wl/4gAUJ+c4LGPhLfRLOqOn8cC+jCVjc8RWOU3BbsT3M4MQ4nnyywU5N?=
 =?us-ascii?Q?hG3CvjoCUMyHJRbj5NVgkvcbWHqFW6W4bw/mSFFk4cOeoVQPAd4ttg2HFGM7?=
 =?us-ascii?Q?BWIke0v7SYJEvSJE6PX+UMwfn76hnyGqxS8hxg4yp9ffQC+A5Ql7KOjzsONW?=
 =?us-ascii?Q?c9wNnh8bdzxvw1QfvYzeOVg9rQ/kBgTCyOtMFxBDzqdH76iHz/RRduQ1aJZX?=
 =?us-ascii?Q?VeNagJ+CxqYABM29mnY3wqNRqhuxTSXmKAqNN9PwfnZqpAf0Iu05n1WtGhhv?=
 =?us-ascii?Q?DO8E3BlyAJNTym1nWX/s+F/sKtj4l8zSZOnGvsVE1RYKjkMU8GZCPplSRfAC?=
 =?us-ascii?Q?r/8DSsHrYFM5ZPYeyY2Htfeo+s2uUuceInarg1gPtQfq6FdyAyuOskigbTy8?=
 =?us-ascii?Q?NJPnzweM6WKY9ReUTdfCNqP8PI7iO7h4/2sGylS0pAq9RGUZyITAVOJHXHl+?=
 =?us-ascii?Q?CHUHrIvhwDyVnuGjg+pdFPloof+V0yJfZH8bExzSrp5kfR3Wda9+huZVAp41?=
 =?us-ascii?Q?hEjIdffQ7guitPOjc0dKf53tz/eDoDEqrxvJ+dOZB4aozhsbLbPBrGyHLl9A?=
 =?us-ascii?Q?FElRiDLeqfybrHfGmZECN6tVZI3slIKauIY1rApHhxc0AEPjXavVP0UXEhV4?=
 =?us-ascii?Q?uu0Z3dE7SiPTjWr7EjUs2S8izFoCOs0jpuvNk+T/I4ZYoKRNRkvW+IZqkHNI?=
 =?us-ascii?Q?c+fc1IEkI5Ncqs6kl0d69EWNUIMj8Vfggrq/d/r0nNwvpQ/bAeDkuwKil1t8?=
 =?us-ascii?Q?OWmdrkxLRwXw8p0FW5SzJsZZremNMaYRHwv7IiNmHcqrxiNE4BNzywp4bCUX?=
 =?us-ascii?Q?rvDzmuubwfeOIkHrBeEtpt8+hGUVFXsuB2E71+z/257Zn9acfDBSP47m5gsr?=
 =?us-ascii?Q?OkQKaCpZwy2z9ggylmYUbi2ekPgd2AzImcyZlLoSoVK4unj+mRM1X2cdYQb3?=
 =?us-ascii?Q?w9cSChDFQNzh8Sypqh73HdcIJYhb4FUa59AK1bfcgnJz9jOYotLVAra9A5YC?=
 =?us-ascii?Q?Xc9xRHojknHLT+WH4ySPpuvmlPmOo1dbHjtozeMx7LYwl3sqBoqFjDbaWs2g?=
 =?us-ascii?Q?8UZ7Zur0qDC12L9q5Rbj1hgnaPzGZdjSfmspv05rqEYghIt8JJzOLknsVhgK?=
 =?us-ascii?Q?FLSrtoPV6cKwqOvQmtsby5K/0bgCqW+p845AvABoVEOh0KiyOuZb4ny/RTIe?=
 =?us-ascii?Q?20QyYYn4ITz4ZpF9qpQtPs1kNBSDbAaUDAJ6F2PwcraYIFN+oHYxDC6o+L08?=
 =?us-ascii?Q?VoqxH0QJHpRnKkLwKYakurNVBPS+eJGWEXQHOegPrb/sYukf6drNKJaiQzPH?=
 =?us-ascii?Q?aAdRB9hvCgAbNR3VzobK7eLowEH0G1m+exP/iunBYRNG2dCHAN/gtbQtA4Ev?=
 =?us-ascii?Q?jzuV6yEtlBM1dWG/0xcFdkC3+g0EIPfENVrHACEo0kvDRAmm/PWC/LpV/b3P?=
 =?us-ascii?Q?tJ/2xYTmfON2HgDsiGP1v8LegNprMUSz3+eBguu0z6fre74XKTgR3x4xq1cH?=
 =?us-ascii?Q?c86RAz5xjSVcd6KymLSloIK21bRJwU/DcKJPBBMo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 888870d1-756b-48b6-3005-08db4766b5e1
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 21:31:06.9775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lAu4rxySkkY5PsoEdTJaKHaEw8rQAse/tRn9o7iXiH7PBXEOsuok1Mk2gnAeZ2QJwJVET/GVHsbG8f1Q6nYFFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9900
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VCNL4035 register(0xE) ID_L and ID_M define as:

 ID_L: 0x80
 ID_H: 7:6 (0:0)
       5:4 (0:0) slave address = 0x60 (7-bit)
           (0:1) slave address = 0x51 (7-bit)
           (1:0) slave address = 0x40 (7-bit)
           (1:0) slave address = 0x41 (7-bit)
       3:0 Version code default	(0:0:0:0)

So just check ID_L.

Fixes: 55707294c4eb ("iio: light: Add support for vishay vcnl4035")

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/iio/light/vcnl4035.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
index 3ed37f6057fb..8b7769930f3b 100644
--- a/drivers/iio/light/vcnl4035.c
+++ b/drivers/iio/light/vcnl4035.c
@@ -413,7 +413,7 @@ static int vcnl4035_init(struct vcnl4035_data *data)
 		return ret;
 	}
 
-	if (id != VCNL4035_DEV_ID_VAL) {
+	if ((id & 0xff) != VCNL4035_DEV_ID_VAL) {
 		dev_err(&data->client->dev, "Wrong id, got %x, expected %x\n",
 			id, VCNL4035_DEV_ID_VAL);
 		return -ENODEV;
-- 
2.34.1

