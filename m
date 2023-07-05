Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2989748493
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 15:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbjGENEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 09:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbjGENEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 09:04:35 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2102.outbound.protection.outlook.com [40.107.215.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08D712A
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 06:04:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LkdyJR/Ys6EOdtwgQrF0F1I66TmvI5vn/2o++8DLUp3R79vEJsHmZ8p9fGLQT0GErNscYk0Wd017Jmq8Zt+F0lG7i7BIMTgjQqOdq/OKyZrPbY94vFugEwYg8Fa3xhGdEOSg3ZNlL0w1rYPpmM2I7C4PaZf+NHeb+EoM5FTKk3weWoQg9RACuGqreCZoz4IUuYEePKzawnMWi2OftNE85sXsCDU3ES13XBwlUaB0LcolEm0rL4gHgY1N0NCUdUNzMhqISjwTjgFSKBNiTCff8x4bJP4zTwlx16L+rSWLlqtsIJXFYjS1YcetbjFfGgs1LfRMdQiAONpXdFYkmGJk9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CAXNVLMfiMiePTwicI/t9P1S7D9m5trUOLK6R5mVURc=;
 b=dAmJObrtmSvXqXY7HJLy5WMXezDmP1CvQspiHchNmi42Z8ZFF0O0LU3wQ46Xhm6z/uAq2Eg/Ygn9eRGflmFMivgdEHWsY9dPFNRjVDRAyt3p9OpmRGRPvgxGqKF7SrXPDmS81R5IlJSn9g/3F2flwVyH4CSC4mJ2UKk1iawfaw/pqAkrualSm13h3n77Wntch2Hh/zDQTGtA5z9Ezug2Loc9y70gDIOAwVZjRHlnYeZLi6WbSBXm0zG7HWS0gCwSVELuOBYliiWJ8RhhwrGzAvIu4nRKhn+6xDnlAbxrq76NG3C39Wi0B4K2iF7zwH1WOGiQWJ1GwcE8nzDjwhygbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAXNVLMfiMiePTwicI/t9P1S7D9m5trUOLK6R5mVURc=;
 b=dDwZmdxJfzI4221aybsUOIggUuIfz4FBpViHtIu/rNCgx8RIF6iBDB+r8v9cygIX2cA/SylJ1L3uwPodfmifyDg3XTTw+cGiUILLgWVqKGm8oKsxeVRPvTNYGSVPG0V6Nu4o1be0mA4veO+coicX0Eh9VRZKvCKN0aCc/UhiVk/i16ic8+ypp0Ta7+4YGb+lek7EY0N4EGxXX2dOebiizNZ4jKEKN//6hpwLjSi26bJOetoQOLqa9nBgKRoVo5+48C45asCoNZ2rWQ0aA5Qjkj/eXfEVWgUh7tJhTzBpJugKQQYjNnUButhEWYcyysTl8TbY7x7xjZctSMyUUA+w2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5891.apcprd06.prod.outlook.com (2603:1096:101:d4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 13:04:29 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 13:04:29 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Yangtao Li <frank.li@vivo.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] iommu/omap: do some cleanup
Date:   Wed,  5 Jul 2023 21:04:12 +0800
Message-Id: <20230705130416.46710-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230705130416.46710-1-frank.li@vivo.com>
References: <20230705130416.46710-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0057.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::10) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB5891:EE_
X-MS-Office365-Filtering-Correlation-Id: 07ec7b15-a600-4fcd-73d2-08db7d585dc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vJz/hX+iiV2cTu0Qy6BlKPbhxNmMSmSgHKW2D2u9jZbptIpDH36dTzERJiPCvaaAETcFJoIGbu05sOfnJIIQSH2ahF5EKBzM5A7Dyuhy7QiN19LGCtwA4rW3P1UJSaDI/+A1BvpTYWxHDLhcXEfm8FbFOJFgkM0UyEmv9vH2ptLpytJTzcghA034WOO/F08kka2s4nhMxnqOQG/aNS3WsKjbOwllNtryIs4LlTlAXFBFm/ZyzSaoFMIAo8JlaYfgjQktZpLmDhtW/ZLAQkL2D7/ZIGYS2yBVMK6d7D7N2ctfAPs8NN+BWkIUsSZ3GsuvqrTSVmRiNvuks2T+1cEx5KjrkTae2odSYbSwqBEB1itr3wBxR9E1cJHtcmIPxv63lhj4pe4QhvWg8B1P6+HJYwNpqWnGIv7QoqAlAy1ipEtrVoJ4BVUUNSs9TgERDhqyide21eveZzarZUhqjQK1LvuOWxUQbD5/BNXTVVw0ieTIzvtVSb9X9KNJdsEgEJW7kHcwXlzzNYAyVjEkOrt1CVouenU7BYZakdHl7UVrYPqHFII7mMcpvkK4jNosabxvowPllvVGp2RGBPoKmBJ7iCz5SS7uEGsLd2lFvZjrRlrltL2T7jHhBP3+bn2J5RVB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(451199021)(478600001)(52116002)(6486002)(6666004)(110136005)(66946007)(186003)(6506007)(1076003)(26005)(6512007)(66556008)(2906002)(41300700001)(4326008)(66476007)(316002)(5660300002)(8936002)(8676002)(38100700002)(38350700002)(86362001)(36756003)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Iu/Og58sb0R43FBDsNniJpnpZ+6SiH1ZJlyuwTfYegHBbIMJrWqoze0R6id9?=
 =?us-ascii?Q?9qadxayroQyx9N9CevLV0duj3nuAIvW12/OHs5VhEuNZ4wNtme6bFrcHpEFM?=
 =?us-ascii?Q?BLppfqXt2uwjWlhlPKFOlC0OajW5N05ySF3ExKHVwKLyjmWkuEov821Lmjne?=
 =?us-ascii?Q?oG9Ob/MGThGmdcizr/E2mOFduhK5nT20+BCb1VXnH+JR/M7uF4aM2kaHibFA?=
 =?us-ascii?Q?5YmzbTcHmXeAXOq7XEpVRSbcn+Va9MXSX4i/JiANGXXQHLJECFy7dmPeuf1h?=
 =?us-ascii?Q?23cZF4I4fDbF7SiZGOUb3HOj/xjJ2Z1v2zkvm148yYoqLEPtIxhF9G6KuqqL?=
 =?us-ascii?Q?wt/W1kojfCxcMABrH/cXYYc1WMlHcwYGt1QiGrZhmru3rRmLDF5guAIHuYAg?=
 =?us-ascii?Q?Kh3EOEglP3tXeFdg3/D3CCF9tv+DPdkt5JqITl4V0TxfMeO9VU1V+nZpu9nv?=
 =?us-ascii?Q?7kLNbDwd0wmaI2vXL4g6jBijjaL16iE3pvIM7tsomjpbxtiB1X71TPZjePB0?=
 =?us-ascii?Q?T1+BJgTSgkEEInG+Ru6Jv52t8SQTaei1eN88lrK5oGC898vglOhP/P4KOpAC?=
 =?us-ascii?Q?dc/vCeq+f0lNiCX1yHjVtGuh/B3TLdaGDwAhOPDUsEUO55pUwPx0wR7jGtl3?=
 =?us-ascii?Q?WIPP3+ugZOZ9tUwsS9KueBfAPt+ZV/3LZJtSY7wDXUSoZnq908nNnKDul1xB?=
 =?us-ascii?Q?Xl33poBtA1Ya2xQu+c6s6DYCDpvX7pwtjf9uN14lDOuqlKnkQrn4Uy8/cyj2?=
 =?us-ascii?Q?/VGvWUiHP2oxkv2i3ijsLt3GJQck6Y4+iCwl9nnkcPieDSVDRpjJ3GKYn22c?=
 =?us-ascii?Q?9qjuS9uyci8jMh9ncOPxtPOin/n6HrpldoU/5CbPb4Dc/igyvCT/H1JQyujq?=
 =?us-ascii?Q?aNDUFFoCPNrpxmcrZ9bYt5drzZyZKuG+AsQtaT0BwL3V/efc0ksawe95vP9y?=
 =?us-ascii?Q?FT9yOimVSg2eNdqK6xBwBKl9+Nq89hMP9FRt6yZlq/3dKJcIGlF8hOHdFGU+?=
 =?us-ascii?Q?vEzAjSaeJmRYue3T2qKenmx/VCuweJvTfMbFV1/M4Ej845sRKTL6f9BmndzA?=
 =?us-ascii?Q?vI6u7TkO/hyeqw39NzFY223tW/mDwkFPTT8pXaKOG7NiGNk3Ro3poj23mfSP?=
 =?us-ascii?Q?Fgnqlwx22X32nRDQRTXRO2h5OdsKUuWFbDIrzOIwNW+aKilxUeZDMtc/6nh1?=
 =?us-ascii?Q?wfFgVI1DT+rsd1Ql3zAA1UDlywxUH4WSgRM79JnmrP75l0RT2JiQkNlbJz/y?=
 =?us-ascii?Q?7PZELlVYjjtjyfS6X1EhrO3+sm4bSy3meHhDY9nTxYbjCM9eY1aLjdySQ+D5?=
 =?us-ascii?Q?Zb5WiqdaPEslllf0khwHXSmuveSqwKyzV6jP1HBS9WvtjnhLk7/mWfnP/Wdf?=
 =?us-ascii?Q?lwPLMLQTceJKhKBw49q3F/enPxcWt1/U+vulg8dNZWmzs2zWqzlQ8BKWW5Kq?=
 =?us-ascii?Q?1FMu5ywPXqY8Z1zRRO8OdU6WcGzitGkFikb+5VrDNqyje918J4FkU+QyZT4D?=
 =?us-ascii?Q?P8mjjI2Hq8Rt7lzbVEmX8Pt+ejarQQGGq0US+zrEWJ3DyS+CZbY+GxRilxSS?=
 =?us-ascii?Q?+RsHbLEDEIwyqYk4qQM5yn63sWF0LYcN000YTkXq?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07ec7b15-a600-4fcd-73d2-08db7d585dc5
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 13:04:28.9076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IU/o1nQzrSun1bSAdPEjhgK0pj6nXF+icnvUTTZEmWH5TcInJWsXMODaZlWRZILneOdTmlNaHGwLL+RdsmajWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5891
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert to use devm_platform_ioremap_resource() and fix return value
when platform_get_irq fails.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/iommu/omap-iommu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 537e402f9bba..ed4a29478473 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1163,7 +1163,6 @@ static int omap_iommu_probe(struct platform_device *pdev)
 	int err = -ENODEV;
 	int irq;
 	struct omap_iommu *obj;
-	struct resource *res;
 	struct device_node *of = pdev->dev.of_node;
 
 	if (!of) {
@@ -1205,8 +1204,7 @@ static int omap_iommu_probe(struct platform_device *pdev)
 	spin_lock_init(&obj->iommu_lock);
 	spin_lock_init(&obj->page_table_lock);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	obj->regbase = devm_ioremap_resource(obj->dev, res);
+	obj->regbase = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(obj->regbase))
 		return PTR_ERR(obj->regbase);
 
@@ -1216,7 +1214,7 @@ static int omap_iommu_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
-		return -ENODEV;
+		return irq;
 
 	err = devm_request_irq(obj->dev, irq, iommu_fault_handler, IRQF_SHARED,
 			       dev_name(obj->dev), obj);
-- 
2.39.0

