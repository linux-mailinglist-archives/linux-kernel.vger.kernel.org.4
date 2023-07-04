Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F140E746BD3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 10:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbjGDI1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 04:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjGDI1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 04:27:37 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2091.outbound.protection.outlook.com [40.107.255.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3182999
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 01:27:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EEvrydthwWow6MwlA8ZasM2HZenfIImILMJK1BnWUCIBZTzZA/pnTGXq3GSBmfV3Bvv1j03JZ8OafTU7uarJ77epniKp0/bKQPZ1oKdk/Bi+OOQaI7nZOqdGEmYuxW1InsYEXpT1WWPYJlPcB3AvbW+dVvDrsprXLgymQ+S4CP2JWdHS7mwaODkUtFu2h1Ac5glHh+Ba0x2isXuUM0t4HAvssXKo6OUOiSGe5UUqme+UGKR/TqNhyQaw1nj4Ggfy89l49NIgn0KTJ8yQoW86kSIH8XWQkct1Hgf799ZJFm8R/hAP12igOUgfd52fb2rqmmtzi7IEI5aBvhambUMtig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PPgh38sMAsUySNgo2BMUpXJKbZc26fuOzpxKm4ir95s=;
 b=Go6XRIcThqiZNrFOPtTE/TKqTWQHLc8ZRf0S/rQHiXFB7PxNApVjQUwLvtHz81MiHwp5XLmI+1TWUorDgFlE4mj/EzBirwgoj8ZDcTM02oYN/dVQ/Mp7rHf7B4naGEUEUrnM3uFH55C3QMsUQTTnypowPmo+1oKbHKLd0i5bHZyULB4YSxSFCX3OHpL50WMpwDfxI6JyZhQizlIhNvhgXUR4efKIb3fodXwo1Y/lZigVWjderSO8Dn5Mu6Laf/T/3XTLYvncCTkj+pHFt/maR5BRIpNwJCMpChSsMDuDzr9CjioRa6B/z/0r2XSyL598bwXixYRNQp8Au0IpeIKttA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPgh38sMAsUySNgo2BMUpXJKbZc26fuOzpxKm4ir95s=;
 b=mfzinKepFjbOLEPMUNG4XpXpbfLEtQbhDNb69NVLmR5DB/VL+vzyTbsP3A6aqme4XpsHpVb/Qk6dbWlzcy8N/7KKxV+VBMZrrttkLXtUvZ77WXYYKhCnrpsEnnED6V4OWk+LZAMOe8n/z5X7ws2yuTGRt4BRPL6u//qThHSBYRK1FrKZCkN8wAKLUGJRvLqO1b1nl12CdKXIWiq/NMJJSbiej7AbF8Pzf8wfJBBhq81xwEojvk29jefC9y3TAJH17h08wTWl10hy3E/ij6VGKdItp6WCxCexQZoUDf+86bGzUVLoiRvlsUUYk4sOLZCwGvt2lSjEoB/fiZCN0OJIYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 SI2PR06MB4107.apcprd06.prod.outlook.com (2603:1096:4:f1::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6544.24; Tue, 4 Jul 2023 08:27:28 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::7dfd:a3ed:33ca:9cc8]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::7dfd:a3ed:33ca:9cc8%6]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 08:27:27 +0000
From:   Wang Ming <machel@vivo.com>
To:     Dinh Nguyen <dinguyen@kernel.org>, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Wang Ming <machel@vivo.com>
Subject: [PATCH v1] firmware:Fix an NULL vs IS_ERR() bug in probe
Date:   Tue,  4 Jul 2023 16:26:56 +0800
Message-Id: <20230704082706.1721-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR0101CA0017.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::29) To SG2PR06MB3743.apcprd06.prod.outlook.com
 (2603:1096:4:d0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3743:EE_|SI2PR06MB4107:EE_
X-MS-Office365-Filtering-Correlation-Id: c1cbca43-5bcd-4f41-c337-08db7c68802f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qPnhE9w1D6Ewu9w02H7g05jOW/dR8vaUcgnXE4oEM89dk1GPRu0Z3CjfizPT1u3BSuZNScmn7jAw1NgxCMYmKtGYnRBBczr5o51o9fs6xtNWfvJr2+/1JhiYM4XmWdXsKLYtQBGrxqiR6HFPATNkgwpsTd1k2GYWtnkmUBwNqHMrFA+w6gA8tvz18LVk2Iy7iyTJVRIojUUrDiCEWQYdleDTNIGoOjJkcwqrbbFprk/A8Img//8f8Nxchb6ia2ZDUYYJVZGACazthmEImXfaJgfEh/ohsjTKcnJ6OJN0VuVsbG64VtEZ5CpylgPFlrW4Zxop+zaZfiAvBEyMzfk5hf1Ibxro1hl3ctAgJIrSNzVP8pKelahBE01nQjyy8YIkbSfc84QqEGHw7tk/4J19eOZ0pTiZfs6Ct7Jh20M+64cHtCOW6qj2OSsnQYRvlo1eYWrv6+n5YQMs61/+yG0R5vazvgn/p0svSMQshiMdn0lrFj9DRwiqZuw8lCk7bmDzhMeyGdE1I8dNaXYRGucfUx0Qcc8YHZkPBeIJVBVTXgeZNqU8PGD410iQbcjJmDtgLkszuZeDmccfUDF7Wa7YvVy6X0v1y//7UU0wOzbGPVQBL+TpY3gUjeuWD7cTM2LN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(451199021)(107886003)(316002)(41300700001)(52116002)(6486002)(6512007)(1076003)(83380400001)(186003)(26005)(6506007)(2616005)(478600001)(6666004)(38350700002)(38100700002)(66556008)(66476007)(66946007)(4326008)(4744005)(5660300002)(86362001)(8936002)(8676002)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ynoA7fgtsFGE/o25ODugEnZL6GyaVGE4lObVcZfUA2nUFSg3Y78xcpwnPH7C?=
 =?us-ascii?Q?BuITOAXN3xgOsnKv+YgbgYJ9QBl/WpbQ0IRn30zCjuSFErHz+Jb5KJIEXOB2?=
 =?us-ascii?Q?cM0yeEJJHFVmJv5JmPMjIN5pKRmsmFtF7Fi4LQrr/zcFL/HpUkdp90TcFgGa?=
 =?us-ascii?Q?EYmgs7GiUq3VCP+5rTmfiAiE0q+P3YbzLcv7TVnsAfdomCthJIjz9TqhkX76?=
 =?us-ascii?Q?T/3ygTUbL192/X58h5nLbbKUKbDlqzsM+0f0bQTJRulz+3xborUI3X6PlJ4h?=
 =?us-ascii?Q?DuT3UFrc168M5sPj7JWcH+U91WDK8N0/wf3xLBJbOEveHEhna3XbjqJwgyof?=
 =?us-ascii?Q?3JA6a2443/PGIx0mQpwsyn3DC91S1gDWy1VJ8IHlVbX0YGjziV+Cc7rHD1F8?=
 =?us-ascii?Q?fLxu1oBvg4wfMv+VAQwnM5LUHeAb0Ey1b+rAYyovEy7KyPHcCNiXC3tyctjg?=
 =?us-ascii?Q?gTmJj8RTGmJ4gCPnP6tYH/rid8ngKHJyMejqnARBH+15p6gQqvQTuitkvL8r?=
 =?us-ascii?Q?HyPAxR5ffUbWY489N1MOdnoa0c61Ji5BSnafopHaebh7NX08mAf7ZViPen1v?=
 =?us-ascii?Q?PmQLnLjkl4PARCwTJtMAWt69rZ4vkhPKvfuiX8N747qiEqa7c8P8vD4U83z9?=
 =?us-ascii?Q?kEqdV4zrAhVc0DnlSV6i2W2nYiQf+bS6H8anw9BntF71pMzEGh6u8DJJO+9v?=
 =?us-ascii?Q?h74T1huHD6uuT95i6S84UEmZtHcD3c3UyDFtRbXVJWksCKPAHf+m/GJ+ROYV?=
 =?us-ascii?Q?a+69glNTLgtNB9jJdZkrQwhHZf/Ujpm/tRxndvC+otWxj0cENKNwlkog+9GR?=
 =?us-ascii?Q?aNe9Rx0kxrZcfANHYBzZ1QW21FuqKx8xPnVzp/13bFMielmXYUlGq5QRcnz0?=
 =?us-ascii?Q?zpcv7zGrZmuzA7tcyApzGq+6HNmjCVWSZe0zCIAsg47L3BzUrFKKx2mZOXJL?=
 =?us-ascii?Q?jLiJ6TYpZpKjjg+nnyhH9tXbpYxGECoHiMQsBVLePDK18dyT6szbY1HMKUln?=
 =?us-ascii?Q?XjbXMSMW6NDtSigVVIr6hyenasQUbHD9yYv5LBil5qriPw1er2y/8Qds7VJr?=
 =?us-ascii?Q?+UOx1Q8p8DdMQ/uHxNNTSj6mPUcEWBYz84pAUFFXZeqpm1k8FzUArCZbS67r?=
 =?us-ascii?Q?G2U07aGC4PYNTisBgJw87OMVCJFAQqYIWf+Os81e5iKVpY/u6tUgce2Myryu?=
 =?us-ascii?Q?H3kbaGZAukxc4foCGxm2UEq5wbFKKo+7EPmRmqJlTOqoFrTzK92iQiodT5kd?=
 =?us-ascii?Q?imD4eDC+faheczLNLbiGuV9Qpy8V9Z+Z7y4va2ovnuG28ljnhTT4jibCGhIm?=
 =?us-ascii?Q?rgCKPKG7oUojh6u83H7FIL5RmSYYexsxBlKJsbgk4NUAFTbYyyHfLRdvTq8g?=
 =?us-ascii?Q?imtfdmjlL7P1kZlzyS9a2ZpjO3AgRp6QD4DD9H1Eo0KmeTyo9pGAU8cOa5FE?=
 =?us-ascii?Q?liTo17ZM3EMunewtjqOh2BDjJifCEU2fZe5LqrQ5ZTNHoX8UmYglHoATGjlE?=
 =?us-ascii?Q?aQ4y6o0MVoVTcTD+qvHwOiiSlsBYFGCbkcDIMsHuieuwGNhcljrIfTOKunis?=
 =?us-ascii?Q?atJaaZQEll4iyWYzPF5Wz4JdeCvjcXZEjHvHPn31?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1cbca43-5bcd-4f41-c337-08db7c68802f
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 08:27:27.7942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A0WVw/cgL02YoM6rxRNEGPDRzhPrI0FfiTGIWw7JAhkGbaQmoXeQn7xheTtrt10zs8xdQxtrf5AWo2+geMq1mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4107
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devm_memremap() function returns error pointers.
It never returns NULL. Fix the check.

Signed-off-by: Wang Ming <machel@vivo.com>
---
 drivers/firmware/stratix10-svc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 2d6741261..cab11af28 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -756,7 +756,7 @@ svc_create_memory_pool(struct platform_device *pdev,
 	paddr = begin;
 	size = end - begin;
 	va = devm_memremap(dev, paddr, size, MEMREMAP_WC);
-	if (!va) {
+	if (IS_ERR(va)) {
 		dev_err(dev, "fail to remap shared memory\n");
 		return ERR_PTR(-EINVAL);
 	}
-- 
2.25.1

