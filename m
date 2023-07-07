Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBAE74AE4F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 11:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbjGGJ4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 05:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbjGGJzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 05:55:39 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2095.outbound.protection.outlook.com [40.107.215.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B51210C;
        Fri,  7 Jul 2023 02:55:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZRwDUCsF+9QO1S513mvfJny5y+GtpLRxn8dEECG2X9dqZRwccvvg4yOohOpTEa/tQJ9CH5tKtteqYRlHV98/td3prHEEqT2284Ueb3WI65piQkba75R6RpGLJSXbm1k1U0XrEfReqWh/Qlqdx1EZziCxkPf/e2HBo7j5Zl3h11aPfu0Uo52Wv+aJiKAsqsQp0AmNQMxiXRBrG9xcA9XF1t2R+xSG6raF+XqnDXEgU4908YVpGeLnimFwWVkmAfDW+BDBL33oXh/5rKdFVRLqn9Z9g8aDaUeAJMXdvOPNiPU9eBRYMRlXRraB4MCS7tWEiRvhbCKC5S+Fg6GUwMk1EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZ6EW3nF9FBgSOGqtMO7sA+4CxK7678/Ifrog9feFnA=;
 b=BUNGDbl3ulUtxc3FnfCRBtkYUxVS2r/ODMLbaAuuwDCNG4EZC3bsmrSCozK7WRJcWteXflGSjJx9y/xIfdLOh2H4g7Fej48IZ+A2CoRlXV9A+g3fL37RHxGjuQMBH6CXyxmg871casHyqBI2RSWwjmIv/fNekiTNqQapTx19gUdxfAxlnD6BQ+KPln15lSZzp2nk+Q76RwrqOH1kuuRJdF3sxqfj17RIi5G11IVUqbSWLm8yuWeE5LOvDgEs/xvTKv0sJzHIEEy871D6bvmm2y0ClHkoM9plz4r7x7Y4BAXmEgdsnMQyMsdzrO9x8r7XSELKIJpJiG1yqExsk2qmrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZ6EW3nF9FBgSOGqtMO7sA+4CxK7678/Ifrog9feFnA=;
 b=FRoNLPKDSoCZELU4g0q9WyiZnbg5q8yHNr9JZ9L7QeK6PKh7coTIJmnhIwR+1hEMDQmSJ5JF7jRRIR/PXMqOq5UKU7po/wpi889WClkFcU7acda0KruUyH2BNcIuQVoqLvYJJ9L6FPWyl9Xpl/PsCb5vClk3jnu4Jcxxx+MJ+5uDWEoMWKqd9VAzVgeM3+mZ2WoDzGGGXnMswztY+ow46Zv5f1wQiwKwEGLIS7FYr6BjjWjceJ2Q1GyPw9c1eDauwOzcU3WYAU2VlfSXpQFhaF+YJ0XAkwSYqvzF/xpk0UVOCTwlzeMXEfdk+NtI3WXGrEFU3hjqKbs2PHtRGUueBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYSPR06MB6793.apcprd06.prod.outlook.com (2603:1096:400:473::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 09:55:34 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 09:55:34 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <dlemoal@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-ide@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/11] ata: sata_rcar: drop useless initializer
Date:   Fri,  7 Jul 2023 17:55:07 +0800
Message-Id: <20230707095513.64224-5-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230707095513.64224-1-frank.li@vivo.com>
References: <20230707095513.64224-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0004.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::23) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYSPR06MB6793:EE_
X-MS-Office365-Filtering-Correlation-Id: 429e2b9e-1d10-4d74-5d69-08db7ed04ea5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xCLWKG7c35mbONxRTv/nsiGo6ITsVwGIuWICL+K/CRKZ/ekQuzRp2ahq+4kRd+i3OeiTK51iRPojWU5yjCbZD/y2dNZmAFnQ9FOZ60oCUhAOKpZJIbpjh5hlbg/9qOlqhNr7mAopmfIV+olYRysZH0Ck+cxcpiVY8dGMPy0fSoMMlQTMVg2WdQrT66iHueSMexKAJalykO9e1Qo9eAu19hXBgDkuTt4tZRtTXXdRp1JfvBGDlCrwBNzTiw7ZgmbFMZ0jlqNX2f+uD/sx7KAVJBjUpjib7GMWnSTz+o/ViGd5bYxK2Rx4z7WuvGHqQNjxIrnFTBffhFtXPbnjLws7DGCS5NEs7BEILsTLbB257/jOAjlEF27n4oOVLSxePltjWyZGF42VyHp+4eDn/Bp8jEZSe1j+WS7xiU6BPnAbxJMAHLn2ArfEoWoxhP+x5HIBqQ4EENTCHBfYf5qT7Nz1CLDr4Ztp4emBc0USaEtjFJDXoi+nzp03a8ggb/FTJ9IO4SoJBjeTBPebwq7u/HuKoLphMoWTNpE6AVkpH8F8jiA80qUFILN7Uzg78yb3YiDC4a2u6hCGa1ePr1BxMv1yHPHIiqqsnFq6dRehxAcKs41xm97q1JQM+DZGGCnicigI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(451199021)(66556008)(66946007)(66476007)(4326008)(2616005)(38100700002)(38350700002)(86362001)(186003)(6506007)(26005)(1076003)(83380400001)(36756003)(52116002)(478600001)(6512007)(6666004)(6486002)(110136005)(41300700001)(8936002)(8676002)(4744005)(316002)(5660300002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ac6eu6gjCpR0U4yIC9iM5FrBjfsvB/hY3sYFnneDrEl/fGsfy9CjX3adTdaQ?=
 =?us-ascii?Q?gPX0dNnEbWz5fc3RESDcx+C0bHhPoGerWcLq3Z8ZqoE5siTzICsIoZO4qjA4?=
 =?us-ascii?Q?VLC8ab+uVPoZroR/TlqT6S26qVNbxkXd6BSyDQA59lKxwI0nCQNK2QYSPE5u?=
 =?us-ascii?Q?x1HmaRFEcfe2FdhlaenN6DnGL/Jzgar4sUB25g7Z9Ic87+4TsKUscpIzI/Fe?=
 =?us-ascii?Q?dTovpw9fyFndIaK6V2K7CDxXc8J2wSZpopIzJRKjOOD7G6up8gyng2j17qk1?=
 =?us-ascii?Q?WENUXMpDsOIDE1XV5hA/R88QOWfp6oz2V9orFdie2oasMbZMVjdfGXLCvagH?=
 =?us-ascii?Q?GOd68/PNsQphZiYqdP1DyHsl5QaYzwp3elNjI8y/bB+PPQm7MBOR8WcCv+ZN?=
 =?us-ascii?Q?XLPjzzOpqWB6KxQBMxNSqx5ZebK26Q/Ftopx4ED3US5Y0nXQNRyPqEE2VBUF?=
 =?us-ascii?Q?Dj0hPtkhWJHssZuC6+kYmF9xrtvanSLEADaNDEyZ8RanulZZfhsOAowtN4Vm?=
 =?us-ascii?Q?no7SC/fJYueiSGvgVZBTXCj/LSWA2/6yqrtU3dtUFglZxPZ3RIfoonztxznj?=
 =?us-ascii?Q?40IyGXY7t7ZvVUtYfFLe/tFzB2Vu00vrsdQXbmBSONDtpd8ekN/jJoZWEC4k?=
 =?us-ascii?Q?hNKOx0EvMmhFD5aum3RNYSVzUT1QWh2LkG8bkaXgWiq4kibV8tqDeUiTnxQj?=
 =?us-ascii?Q?In0JPouDrfi+FZI6peDQpNJBien9xlonT+rvpjN1++Hxr+kV9dpWcK72oCCT?=
 =?us-ascii?Q?gqgkSjwQwm60/mxl/wptG+RUWTkpHPLZc5kdSqHIVX0H4L8GQOMl9W1Y9OoG?=
 =?us-ascii?Q?RAP7kttq2M0pxk5Ll9Uo3VxCFczcHNIenTLOV4KZ5a9lWbjVg47FfFPd3CLi?=
 =?us-ascii?Q?vtVQdXCO7mUqY5hp9LHbTWlfRlStH1Suv+GtTIe2X3/O5oo0bW7grVJUWu7V?=
 =?us-ascii?Q?Zv/FAiKjlV0qpdhB/rtg6IgbEbLKkr4WcvXuigytm7uZdeyuOnrkI4/ixOOh?=
 =?us-ascii?Q?G6t0YJtrpdV2IJlabZdpXAIpCdjpiUtjNQEW4c6SCxqeDj7nYoPT2JUgcmU9?=
 =?us-ascii?Q?BtbSWZ8rhdmLDKfuzZsNtCt2iHvCO1+lPg1xrjbR/OshYJIed9bt/P2qkeKv?=
 =?us-ascii?Q?voFUS3X9X/KTqxmDGAP82uYtmIpxSnjIzbi4GvzrxQrc7dtjMQeklKf8tXv4?=
 =?us-ascii?Q?/G1h8Q4P7U1vI9++UJp71JP6Oi/2tvcrdM20llT5r7keb/zu0eJMdVSVST4d?=
 =?us-ascii?Q?mlJByEaZllG0tS6cX87Spaf5XLVseRHYDb9/rqFhg0ikL3tdVVDxr+RHBKqw?=
 =?us-ascii?Q?7UffQ5EViCg+vKr4j8TnxKZlXYs+UgGQbCEi0rlshP9K1RwyslHiBdnZN3Ri?=
 =?us-ascii?Q?sFobeH5U/59l6DX7FrJX0mBOM69zrg9xKTaAK7sSCbOZv6zSQSd+DqFo4pgp?=
 =?us-ascii?Q?zwDTfeQLFmriS1Jf2GrxHW/1mXnMhayoXCqhBptomqnmcx9zG79N9QhpF36O?=
 =?us-ascii?Q?jzwqQRFQpgSxOE/9PSy6FLl9Soej+VTGoT/bMv9bjUi+IM3ouNJmxCHu9/Dk?=
 =?us-ascii?Q?vNsEhdn4S8W/H9psr3CnAvl/alQgnvpgXcPi8MNS?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 429e2b9e-1d10-4d74-5d69-08db7ed04ea5
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 09:55:34.2752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iu6eN9zE6ImPNpSjMOIUmWtQ+50v/1alsYkZgSpxrTJh00B8WvQ6KNBquF7KrZV0xRQcGLQ61fhPtXnDDcvMBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6793
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to initialize the variable ret, let's drop it.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/ata/sata_rcar.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index 34790f15c1b8..f299b41ab3e6 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -862,8 +862,7 @@ static int sata_rcar_probe(struct platform_device *pdev)
 	struct ata_host *host;
 	struct sata_rcar_priv *priv;
 	struct resource *mem;
-	int irq;
-	int ret = 0;
+	int irq, ret;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
-- 
2.39.0

