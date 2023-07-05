Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628DD747C56
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 07:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjGEFYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 01:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjGEFYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 01:24:03 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2110.outbound.protection.outlook.com [40.107.117.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13FE1700;
        Tue,  4 Jul 2023 22:24:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=URJKIha+GVw4WIV++Oee7pivgRtuU7GwK6Gj1fftAH0IaNwQepXijPAo5T2XA1bISL/9IcG7kFlxBVzAkbS9XyzJ8eFZ2mKN8EBNxz4J7BFK0FqJgaNqFva7nM+d/1b3eY02ByKnv15MpcfNtVqcNuLyjdeOb2MsiMFBLJWi6BIHTQy2H1JmxVQ/mlhIC0/ou3/24BI0UEnKSkEsUCvTPWnzB40/Lo/5M46W704j4n1Ld+E4ZNn7vzrA+riCtDMXldMtVZH4kmIalB4Bd/UPCUyj7sgwsNEj9j5hOO1jJyRELdPF2g/6Dn565J4xM+wJ4itgKGvs7CLPbgk5mE84Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6gsBsLSlyLAGNU+ieRv+h5DtghGL4ms/638mXxhszQU=;
 b=AvQ+zl0Jb4KdyC9vihCE8Zdz6SY9k/GNqUHAURfh5Ynwnj/WpzXAMi/o8m6Ypq1GvbVpX0xbrfGzZZ1T37Nn0M8VMlmaLHZEl1dcnuX9BACMhZp9Pe3ysctnsS/NyiDF3tmW3Iw1lDBFMHbW510enR+3XQWhCyKdt1rmCGsOmjSFjcr2g2X0RaO2zKHrxPpF057EjfxLoqLn6iZ52z8Wv6D7K3ysihOprSNeLFbmlVIcXzqrVrBqJif01CY3H8S/+mpWxx7Zvefwzd2rrzaMQtkOcXqwIZ8t4HLWM3G12c7GB8+IRDLjGy6QIvsOlWL/z3dB6C2PnEgk/ZW1RKPCMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6gsBsLSlyLAGNU+ieRv+h5DtghGL4ms/638mXxhszQU=;
 b=bAONTXQlHzi46dsVyUteTL1AuftsleW4DkUT+baZMIheD3NGqS1NzTarXWTbn5r00uiyQq3qiGm8IA83ADVu+BdIwM/GvCtwW1HVp+hvOOlmAae5IqnmFt0++eaNmCrs0dyNIqa4e0zFvHp0pgCLmr247a3n9nrmYrKWtW4U8tCBB3xcbujfZAqONXjDh6c8w6Bi8Jp6QhxQesjl/LX/qDigkH13MRcSuKnKoMaE0ZnFIcQDwAvJO6qXNdroOhVaj10ZSQJzvM1WZnIx+ffjsADzUCPpBtydEPVlfj86xmx/oruHeLTl/7rhVjQV1p4mhqcO+d5hVN4J0d/xV0AoiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB5123.apcprd06.prod.outlook.com (2603:1096:400:1c1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 05:23:57 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 05:23:57 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] Input: bcm-keypad - Convert to devm_platform_ioremap_resource()
Date:   Wed,  5 Jul 2023 13:23:37 +0800
Message-Id: <20230705052346.39337-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0116.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::20) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB5123:EE_
X-MS-Office365-Filtering-Correlation-Id: 94691827-443e-4271-0f0a-08db7d180810
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BDrbCusCe7nquR/MhZb0ai67jJxuAuiWgNrgbYQnClxpxupRJJo9njtKX4lSQmB1HBuqezVLtm/PKuB2WmeYm22aCLJ95qOY5EW0TkZpYE3/2yL3V62it4C+JQI4O4IRR+F89VkW8+tUxsTQx1DEt3XWyqDd2U8KdYeM63rm1zFkxkW95mYNaHjxsWg1Ug0ghm8xvY9QptwVFisBYTZgRaluwVL8AU/Qr612YLZ+1eEr8PsrNNFgDVUOm5pAt8VfhM65JbodpVgm5z8KbtZDCGAivgTam2PPejEWNi3o+EvkG9jcVYKPrxlaNQN2yPO0mDD6EAgCdUEdwnHpXo1BV1cuPTsRAafq4Otg/4sNqY4Oiaa0Y7OVdiQGGZf0L5h3d5yAKap2xUHC8KZeJyaiTfjEwnfE2dXHq4Y010PC4QUkAh2sl+cV2NI8Xdk8eABlUjwWmwkjAjbJEr2Q2OPCSHx0Q43sDhat8b6zzYnf2FSBCT98csnpA87VBYOR2eVsfZH4nmmGrkDP9yGINXdvjnTo0tS9UUotu5Q0cUUtQi/FgYpYelWtwN/hp4v9wH+n4EMAB7cSaB7KE5dc3YozaawZcVVlecSD/dGBI7TP1qAW9kmAOhb/QSXf7pVAaIKH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39850400004)(396003)(366004)(136003)(376002)(451199021)(41300700001)(38100700002)(6486002)(38350700002)(6666004)(83380400001)(1076003)(6506007)(2616005)(52116002)(186003)(26005)(6512007)(86362001)(478600001)(66476007)(316002)(2906002)(66556008)(4326008)(6916009)(66946007)(8936002)(8676002)(5660300002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F099cZsxgEuhltfxLcss0JmIHCrkOfVzv0VAgWR2wrRNUpHI6SUejGX383Wy?=
 =?us-ascii?Q?mcadv4E4sTftYtK9TLWqi+nZ+8JwFEP48NskxhcPVehyG+F2WsWnSgQI0Gw/?=
 =?us-ascii?Q?UxPZI77I6aXcjHbu1J6RqBC8kWg6EOMAIaANsarmy8RUcnL8tjobSEuDRC/r?=
 =?us-ascii?Q?8EMc1MDZclIAW2zP/BDlzN8JSMZs6djLhlUzeeJxPoGZhYb7RRXYmRbJ53/p?=
 =?us-ascii?Q?4FVw3LBwOCfohXe9A9BVT53YNp+hW2IVgAeq5d61Y3DXBcrP6gkN7QJxJejc?=
 =?us-ascii?Q?6RZonPrImotxWCzdcfe5w2EpFzihnsbbPEN6z4KrLjLjOFil9Hf5zf909+Px?=
 =?us-ascii?Q?5GsdjRwJwM12Uh8qJUHx8WNy/K0CpH8rthiepFok6Y7koFc4dK5kznt0lfWH?=
 =?us-ascii?Q?sFTh1+iIt9AAorOP2zi9HCD8gf1y5Fd65AaUk7+DeCq7/bwyOlrh7POMpKMM?=
 =?us-ascii?Q?FBdoKMwjPmcBUNe5w7zPPDrhzqTxqmcb0VUh3bFVdptBw27wv3CvMJATbR1j?=
 =?us-ascii?Q?HLD5O0f0TTn1Ks/GqcjpHtkWq1LEQyx6kYrAtTW9M71usmGEPjr1KgEXMyy4?=
 =?us-ascii?Q?4GHS5aMHb+WKHHYTSwobE0j6SiKEz8VdFFkvFq4iejcG3NTb0bDqYo2kihHK?=
 =?us-ascii?Q?In3xJG+163XM3qBbJLY+ll4eLWskjuWFzdXQBtGCSgSTlsVMa3rvE+Z1qpe6?=
 =?us-ascii?Q?QiG6xEk30kYF4OtfLZ0mfuYd7PgrjFWQts9Dgl0q7OKCkp2dDod5Et/VizJT?=
 =?us-ascii?Q?0glzFX830U+MufSQyiQzwNBB+S096X2dloXLExihsbDNa6GIScRfDKr6lEg+?=
 =?us-ascii?Q?UIf2vhLEizTKOxTJrAa/fAH0gNGd34HCu+P/tmfkFd4ePXw7Td55x/9iZuHx?=
 =?us-ascii?Q?JGvTfTuJ4aTDKYcYtRfJ/UcYkvI2OvZ8qGGV15Xsd9fMuJl5vY4+mJqC6LDA?=
 =?us-ascii?Q?LJvT+RJTJh5c0OruPjX1NFJChVPtotHXfzRkk9jlUOQn66XUbsVOKNxDmyuc?=
 =?us-ascii?Q?98gA/euLoZ4+vWiKPjB7ukrSWkSnfyNUomELn5bGyRg9A4yB/alrllJ8B2W7?=
 =?us-ascii?Q?mK1XN5oRSlhZUWdYrevmZvUSPL3IHeVmiw3TGECKM1WwPnRbH/PwRZoGS+lD?=
 =?us-ascii?Q?YDNQn9Ax4imS1ReWVvQ7qXVAY79ughKDoIhlDeYtToEE+DmjbTPN8V7WuPO7?=
 =?us-ascii?Q?IDYkevuepHrk8XJj/SJc0jWR0BeAHsM1yzCOf91V9oLF9AQ8OO0ptXYT9Ng9?=
 =?us-ascii?Q?F00iXEPhUW/kWQzzeMf4ps7NS7/44BEFimxIRIUlOekPIRYiONvzn4r2d8lN?=
 =?us-ascii?Q?anoq33B8/T3JQ45tJexlAUFkhX9B8T7g49vu58mQtWArk9H6E2+Te6fo0Kaf?=
 =?us-ascii?Q?2ZyT4Y6zuMVUMAUmrvFBNpsiMSsEZa0f44wmFdLz78lt69flxVXCUjaPtZI/?=
 =?us-ascii?Q?6OI7wc/CLhgOtrgGb55FISWGTCQMA7yH7tzZVWX3EQ/QcXnkDyCf5oWU13De?=
 =?us-ascii?Q?0XIYKOw3+jZRWkGkgJs/CPQ1GHy4kolX1WvIyLwGvmt+wuryYc9UDTo9PZh5?=
 =?us-ascii?Q?hXwayzq2t2QtgnF7k3Kx9E/pb1pEHMYACULeG6Yc?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94691827-443e-4271-0f0a-08db7d180810
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 05:23:57.4063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0dAM2FBhkLiEdnveg3wYO2gi8rBD6j3uBkG2RYj3xbpAtAqJc2S/42ijrW988gXqFULn1xhnQ+Fvij19laetSg==
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
 drivers/input/keyboard/bcm-keypad.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/input/keyboard/bcm-keypad.c b/drivers/input/keyboard/bcm-keypad.c
index 56a919ec23b5..92e1fbb092b8 100644
--- a/drivers/input/keyboard/bcm-keypad.c
+++ b/drivers/input/keyboard/bcm-keypad.c
@@ -307,7 +307,6 @@ static int bcm_kp_probe(struct platform_device *pdev)
 {
 	struct bcm_kp *kp;
 	struct input_dev *input_dev;
-	struct resource *res;
 	int error;
 
 	kp = devm_kzalloc(&pdev->dev, sizeof(*kp), GFP_KERNEL);
@@ -353,14 +352,7 @@ static int bcm_kp_probe(struct platform_device *pdev)
 		return error;
 	}
 
-	/* Get the KEYPAD base address */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "Missing keypad base address resource\n");
-		return -ENODEV;
-	}
-
-	kp->base = devm_ioremap_resource(&pdev->dev, res);
+	kp->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(kp->base))
 		return PTR_ERR(kp->base);
 
-- 
2.39.0

