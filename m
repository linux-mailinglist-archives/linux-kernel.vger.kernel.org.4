Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B0C749910
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 12:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbjGFKLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 06:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbjGFKLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 06:11:17 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2106.outbound.protection.outlook.com [40.107.215.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC08819B7;
        Thu,  6 Jul 2023 03:11:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NtLzVq4iFAgT6NbOwDc7YgwAP6oF3MfdEp5IqC6o3JdErynqIvyRZrIS2agC1moV0qwslcl/fgRam9Ph4mqJnsaEN+RUxk+ZiYhvlRmfTj3qibaxZjXfKYqNWqfqLt/rXorxIOk2AT3SyamCOZizyInz6CODSrwDEZXkoOynk0mxR8uXVuuO/sCpp4QmIgk8ErkTxn/wRntMXn2t1wHUFk+jNwX2IQy+7wYqMtTazvtujVLn10WOsi5tzdN71gNuMVg/IdinD3/yLGuDF6ig/HLoJFOfyjnugg/XnFjrXMokzEEpnmlaVpYTlNQtk3UwDo7hJBCOpV1MoLEn47Q2yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTxE+of8wCmkptrxhllbCWnCjYpgayfnaPWM+yL3Y20=;
 b=ZBYv+nJMnzn2SuRSHp7xgJgdnONZdJYpxv71gHzeOCZfoa1lrXKKVgwdxWk65sbNnl7KxG+o6se6ZgYetLrFbdzsqaRn3nvGzJI+zx/XUY8gXQZCPeHn7k/Sv02RwKgEUgvTnXvD2FdLjlf5hMjOt1y3S3nzJ72zvmHtTwzPchVli0mq/pvFzAjS8g8wdwRFVqL1alGjLbK0Fc51CIVnSaW2Omsv9X5oT77qhLN2dH4jtt91nIXep/CCI7N1OQxAHKez4kaM3q9UnXFJN7xVCCtL8/AypAxdLF7S3pg67Tmi5tNFYqmpO8wQGwf0QnlnIEIGZo1UCowMpWRWV7RMGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTxE+of8wCmkptrxhllbCWnCjYpgayfnaPWM+yL3Y20=;
 b=UPh5lAT6oWMdrN3hqQPbhQN8E4H+lVVPWYhsj9K9g/jusyao6oISkQ76aTQoDT2HBDVABRQvle2wYTYGBei0L47WLDSRqIXA9DFEczoazgJVdX4WmNrStyhxOvYQWtt49jluZ+HEUzAir7Ajhib0bUXzLi6brt71ZfxfZmsx115H5SmZzY7Qv5T8NjLiBPq8vR5lkoQ8Dn35kMWoCM5dlt2QBG+t6lYNnVddImxxhdDwWV2CdOulnwNGYj5k2E++broU5M+CsmME+spHJDKKWs/QGXOxeftuC3fiwTOmYvnx+0eycn4fzQ/oXC4fZQI/kh+7I6sDmI8LiZQOhIl/Fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB6447.apcprd06.prod.outlook.com (2603:1096:820:ef::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 10:11:12 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 10:11:12 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] media: pxa_camera: Use devm_platform_get_and_ioremap_resource()
Date:   Thu,  6 Jul 2023 18:10:50 +0800
Message-Id: <20230706101100.75654-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230706101100.75654-1-frank.li@vivo.com>
References: <20230706101100.75654-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0093.apcprd02.prod.outlook.com
 (2603:1096:4:90::33) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR06MB6447:EE_
X-MS-Office365-Filtering-Correlation-Id: 367139da-5ab6-4a93-904d-08db7e095382
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c24gtkZLe1g+6RRN1TLfsmSsr2qmeCTRFz5l0wn5p8l7/rVb7sph3Ov3aEGRPhIKgMHcWCBcXyjpfYTvL6kvCd4j/aq1QA7I7G3RQuyTJ1xlVDZXfR68nrUIoEu9KAe5uXoEB9tGFb+H6/hgbysGZ+mBfHHBjh3/bkYHYa0oLXtvZwnFZ9TAshK7BN7ElDhNe2Xikl+nYfReY1Qu7jsslgU2/rTa05UH6KGEgUPvjtiGme8sl9Iqx8FjL8lf3xfBSIcx/oG2LwE3q7y5w7yVpkqnFbFW5wRksdCN0Of2648cGCXt3n7Tc6tQKnWae6+uvR2IPiUeFEtvUCMbVg+i6GINXHYbQHbweze9ynBJhSXz+KP4PpOleOOSXtrY7whi/DQLBkXmfFQXZK/7LLj+XGi1OjLg22/LXWnCEhz0/FqZ2fkY0JT2PVCZzxkbujqQbXDjktB73seqwA1cPz2uE4UoiODo/O9BgLVat5i32hB8sSy2UFBr1kVGC+ldhqlaRn20LLSMm0ZB2OcHM5Glqie2ZNTUGZTBECQ/M0elFUvEcJ3JPkvqIRcluV5XUbkvyqw/EoaHMH+G2Xh/AUK9ct/xRB9TRa68mwWIoYDAq1pHT7GS+mJEVdveqdizfuNC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199021)(8676002)(8936002)(86362001)(2616005)(83380400001)(38100700002)(38350700002)(316002)(41300700001)(66946007)(4326008)(6916009)(66556008)(66476007)(36756003)(52116002)(6512007)(26005)(6506007)(186003)(1076003)(6486002)(478600001)(6666004)(5660300002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wkO8tZFsuo6J3ea39VvxaFrrEb7s8ZVlGxyqk0lDungGYZtl8piCv6/6Ab1o?=
 =?us-ascii?Q?aoJc6aRrMhTb5slN8XSpZOp0PZwVufibC2H4m/RvaoTaj3/z2tEQmYDqo/R1?=
 =?us-ascii?Q?5C+63Y2/HVuXNDbVFODLeo8bd7Tr0m5ZRG1iq4HSSMPgwdznW7zZD1SX4JX1?=
 =?us-ascii?Q?qruGz87hxH+apM6GwtPDuRj5d5R+exAwTmi2EOR7KLeJvk3KfPUCVqDO4Zdl?=
 =?us-ascii?Q?XV3EZ2MBmKqaBlD+lQ+i7ZyueRoWpaWMTT/kCnNYo7m/u4kIJbJDXD9/70hz?=
 =?us-ascii?Q?h2e5697S3NJodCeV4OMlDjbBZBHzgXIELPraQ5VmtSOrqBtBaRTMlrZnrPb1?=
 =?us-ascii?Q?pACVKTxdregXE59UF0WlHIoRZ1MNJK5oz3Nj2TzXq0yEyAMS2Ze+iyAWGAA6?=
 =?us-ascii?Q?wLoROc7aku3UHxjlAto8DjJWcDvNWxqY7vG1NRxHcU9fbvakB5cmISOaLKoL?=
 =?us-ascii?Q?ZTDdYj86nke2xnFX3QD7hIz5dZ8sws+24R8g/jeezsrgwwEZsTAgSF7/c/hv?=
 =?us-ascii?Q?nYYGFshsD/8mAb8/dd14myjgXETMHkKnuPoAR7F0kQrHmZEqOzVTxrlfnL/q?=
 =?us-ascii?Q?NXUQQ2o4djqVNYlYaz3EBCnv72VKumqpQ8fRJgviAio1MGkpDX/VhON9jLoe?=
 =?us-ascii?Q?4KCX4uOXgEd+wzZ0UrcHWzRYTLrOcYFrb8Pcb8UeWN7bpiSrrsQSiCf1ElAy?=
 =?us-ascii?Q?KXdZZEy2vJSRYy1BL1KnpQoTAs035Jqwf/NgyfJG6+w+If+beot69ssln/oK?=
 =?us-ascii?Q?2e+uHh2cGhJDqO9d9z/j488cY/8KWt9qTazF5BAHBtiwSiCfWJ7Td3SUiztl?=
 =?us-ascii?Q?NMToqDo9AN4du7VwKL+J3ArfRgPhpfKlBSsTeLgrT7Lg4bbPLFSfM8rfCoEj?=
 =?us-ascii?Q?/xoICuFfe/CeNZ3D4bEyOFOLprrRv5SyjaOmIfsLou5PKChNGT/JmnIqvqi7?=
 =?us-ascii?Q?0d7b3ksCiiBXr7Ksmvt1LdJ41KHDuKs/hLAjdQLexB974r2SeZn87T+4OujN?=
 =?us-ascii?Q?OjfAKjmSwhvNLQIBUloFgonfa0XpCRJAPZ4LoNOrHK6uLVPyiTlZWwBT9tiR?=
 =?us-ascii?Q?EEPBxGgGOGHZpI+S/JUaWDGlOtfhPUORsXHg1icAeLjzAEbOwXH4pa8VxLvN?=
 =?us-ascii?Q?O1Hb7f4Orklw4bvLHEyfpKE5Y/YrVAxL9sTDFEoUeI4C/NL3mMu4DZu7AEhX?=
 =?us-ascii?Q?l36g3ri8h9f6FxVDG5rnLYZJtDz/077RmXin1k4pDw+PHO7fz49C3SmyM8GO?=
 =?us-ascii?Q?kMWOws3vQp4kgKl4AIcG3GL9l4kdHHUpqfRAanlET92TUCTh8RV+Uu1z5KkK?=
 =?us-ascii?Q?cJWQK2UYSoetJGOna+okW0MO0LkPWwxX4n4I7KHGOEtPOXlKfStt1iQwbnrO?=
 =?us-ascii?Q?HVKoxWSTM71GyM2NckjDle5bPch1tgXtPvEdwalo38vdeLwNZGT9f0Le8lYF?=
 =?us-ascii?Q?SbR7TjFt8lwQ8BY6WGmHJOXzjc+WQCG1vNBBewAHE1MtE7Dme2GQXv/Qe8k7?=
 =?us-ascii?Q?qDGR0skL+BJVDG850PXUTG9z5Xc//AO7z8WfAQXVs0++ELqLR6Z2N7O4UBBv?=
 =?us-ascii?Q?21xdtGH4P7GcFfVbV8iZSPLZLXaj8pOUmNf9ux3L?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 367139da-5ab6-4a93-904d-08db7e095382
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 10:11:12.5299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: He5Rd9GOoAJe4gwcp0vEjcsETeTNoRgcqr7EOLUVQS+KgxWbIKsPx5ybXD0vmo3+9nAhTCD9B4RnWQg94g19Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6447
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
 drivers/media/platform/intel/pxa_camera.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/media/platform/intel/pxa_camera.c b/drivers/media/platform/intel/pxa_camera.c
index 9ed3c2e063de..aaf83e515ff7 100644
--- a/drivers/media/platform/intel/pxa_camera.c
+++ b/drivers/media/platform/intel/pxa_camera.c
@@ -2274,9 +2274,15 @@ static int pxa_camera_probe(struct platform_device *pdev)
 	int irq;
 	int err = 0, i;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	/*
+	 * Request the regions.
+	 */
+	base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
 	irq = platform_get_irq(pdev, 0);
-	if (!res || irq < 0)
+	if (irq < 0)
 		return -ENODEV;
 
 	pcdev = devm_kzalloc(&pdev->dev, sizeof(*pcdev), GFP_KERNEL);
@@ -2338,13 +2344,6 @@ static int pxa_camera_probe(struct platform_device *pdev)
 	spin_lock_init(&pcdev->lock);
 	mutex_init(&pcdev->mlock);
 
-	/*
-	 * Request the regions.
-	 */
-	base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
-
 	pcdev->irq = irq;
 	pcdev->base = base;
 
-- 
2.39.0

