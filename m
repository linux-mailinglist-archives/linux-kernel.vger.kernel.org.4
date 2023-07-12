Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54FB6750ABD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjGLOYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjGLOYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:24:06 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2106.outbound.protection.outlook.com [40.107.215.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BC01989
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 07:24:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Akh7h/r9mmAZIrzkQMQpqflS5iWW0cASp4v2rKvV4eih8XpMPH9w/v5t7S4hZcV1Be5VeOEMS5MN+rxR72/ckmpob4bKHapV9sl0uFbY1cM+svvTQPojNCtQIrg8ciW+pSAQlr0DQIgi9JQe5yAjfkeHLV3mcIrm4Ycp52QdJaB0JqIV4JSUw0josYLijNRrrGcVcTuWoJXVo3VsachlU5z1y7RfnCB4P71Q77gQJQz2a6lmp9Dz8kZOPk9Eg3DoIddXEZqg10BkTaQfyOP4JDtxzvbsdGI8yIM+1PspVt0gMm2CLE8WtU37GLh1JVMCikhKt/z7FfwrRV2TMOP+2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IE9ROofK+a5+/VUJwzRyaQkGqzMy3cd0XdzHocuNb4M=;
 b=W0/pBh6Owm2uopCTB3zqNzpmG/gahLbdCpBWerry7+hAemt7iQZqQEeTdgmDYmvTW7DIxFjD0rKtyOpVv3kdDGtG8KG02PRCKPHWpvc9FTHCSFrlnsZ0f8DvZIfUQMPRDPuHbQFkAArgW2wlD6Ka9nyj8/hefiJ9+1dD3KUaS8sNl9Ab3qSOva8ToqIAP5OdeJ79otlQ2PqSE2Bx8aMP4E/pROS3bSYQq8CLBXVe0imBkiy7CAPeDIVxbKSwDdZhlBD5UGVwUbu0mydC6o/Jpn0DXwa7bvlqxzX2Kq8DL8RHjTTRihVTstYjYv+fDpYN7LkWHnmMpkCsOHDZTlYlwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IE9ROofK+a5+/VUJwzRyaQkGqzMy3cd0XdzHocuNb4M=;
 b=O/JyWJozS8Dr5HdL8xEEUBpwUZs9KfWptERZ4sbIkmaF/G0vdFgk+SxvUpegOyXJw+85kfgBH2eOMxacohbFayxL9cF5dOerpulwudKDkoCpwQQyZqM/yny9XvDCesGeQBoLOyV082Bydllk0Mu+g42wyjaLW5XZdOXjLWhUvwAJzHc8372OYtClrkTwSFcvcSYscbl8hzpd1pSUwk5pugfG4vvXOwhcbEGI8hZn3U0JJCSgVMdZt5HLcxBq0Byn6/Ox6ZDyXeIV7Mxdx5ksb2NTrUk0ayhrNumdBNd+eu72zWpycBTxoK5zW7O8FTh0GM1CNkgV8Ddo7qtUaum28w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 SEZPR06MB6571.apcprd06.prod.outlook.com (2603:1096:101:185::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.20; Wed, 12 Jul 2023 14:23:59 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c%4]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 14:23:59 +0000
From:   Wang Ming <machel@vivo.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Wang Ming <machel@vivo.com>
Subject: [PATCH v1] mailbox:Fix error checking for debugfs_create_dir() in mbox_test_add_debugfs()
Date:   Wed, 12 Jul 2023 22:23:37 +0800
Message-Id: <20230712142350.11638-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR0101CA0029.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::15) To SG2PR06MB3743.apcprd06.prod.outlook.com
 (2603:1096:4:d0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3743:EE_|SEZPR06MB6571:EE_
X-MS-Office365-Filtering-Correlation-Id: 03da50f0-ad32-4a9f-3b5d-08db82e3a196
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MrmwR6Hs24U6QZixdb6vg/H0QWN5A80MU51xGDtIzb6AnqXr3fKtzAuDfHcnmdBcgT26Fx7KieoiLdBvCNYpyntuSu0Ob34CxqX18nQcnF8VjLz5c4eIpki9mHqWsqaXTdKUl4ofzXM5rj+bH1FGAX5HKMzLtdxcYo+vmQTBx9xfiQClSNPdW8n1cF/LFqznTHKCHODCLkufO2W33Fbj4y6kcfS0jzHsmDstmlICGKDHQIyGh+WtgbXlcaE8Ji6sETHmexx+cv8QVfL8sGiEmHEQkouCLsxXyxzX3wcfmZBUlti/NcT9y9KgaJ/Oh6J2k7ArmS2OG8voADMHxyNta12PujSDr1egSP7zz5kDhSVxBtxMSJ+GTvwoy5QoIePW8H7t86vKomtxWO8t/Ys6tlD5E350TFfVl2Ei9rYxQK8v6zQU5/yBl6QBhVq+gtAfWOnz5SGpPrPTsbC52w3HowR1XvRvgw+wFXn6jYbut/chjTyhc+rdPK3zgoJoHb5QWD/sTE1YTYJV0uX7PU8D57A87oJGC3VxmjdVTTBwD/rw8aqf0KT/iFr1yAvEKH+bKRQHu+3FrfpW/DT9pW52jnO/Xk6bGfA3DnoJ4SwMmYWcClXpatA4moNg1OqE2RUq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(451199021)(52116002)(6486002)(6512007)(6666004)(6506007)(186003)(26005)(1076003)(83380400001)(36756003)(38350700002)(2616005)(86362001)(38100700002)(107886003)(4326008)(66946007)(66476007)(66556008)(41300700001)(2906002)(4744005)(316002)(15650500001)(5660300002)(8936002)(8676002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XjzZM46YLd2yBQOXblyl3csawXJ1dCIEM1Jo1gdmRiTU0+FLUxqAR5ABqetj?=
 =?us-ascii?Q?Ddzb9oHmHORTUFDKEiUQT798y8IZM7oO1UKDn6XTz0FA/NLgIvaG4s0NzMXr?=
 =?us-ascii?Q?EASB+UGo4s1mUE1BO9Ys8+96GA5wemW1dEZs7J4lbl9VWDb9jRBza1D1GIRj?=
 =?us-ascii?Q?ga6pT7K+UzNV1cOm0acbUKccu440IwUX7Ee9dE4dr8GV7+PAT8JyEjZ6yqzy?=
 =?us-ascii?Q?GVekGUwPoO5f2jsZIoV7cmfBFVKTsChpvhIKl8TE24Hn7G4AYKsyd98ZPxWF?=
 =?us-ascii?Q?h5i+ym5RH2JCNfWOvwzVsLr0lKMlK/fQKjo3wv7ypNPuRFiS66N3A6jKUB9T?=
 =?us-ascii?Q?osRfVmNxKqgAtvcqnxh1QKxl5RvvO9KukDRFHrvLkxBwor8KeEN1pT2xOEFs?=
 =?us-ascii?Q?hrUcOVSftueQ2M/ohczid0B/0DEy5is3gZufl60Liuy7yCPL2+TFc4vPbZHp?=
 =?us-ascii?Q?gTmIffuPfDv8EMipdY+r6ctPgoUKe7v+2MjJs46RBhiMy8Dj3E05NU4gWX79?=
 =?us-ascii?Q?GUEqwp2jMlqsZdNN2YR2GNTzN+N/xC/jtPFjOge3dUifSqHBfhTFKsnG/kOq?=
 =?us-ascii?Q?Fkgn919di5JlE8DecGTYfFyOVwiq2UpnflRTlfSImyk4VvSE+/kKJ1qO9ojm?=
 =?us-ascii?Q?gbRHp3lniJThLnULZOt8z3eQAxVDmt1UprnOSHobsRGaRxGab7SYCsP9kGaR?=
 =?us-ascii?Q?RZkrehCF84l8WMQCTn91oabaK2a9z4EmlD/MZiQ01sFjd5H8cuLnaDZ90f/3?=
 =?us-ascii?Q?bxHbtSiS59WRpnH0tvjXCgs19v5jFvuB6DNbDGtiB9KTGNdj5QN++s/rNf3y?=
 =?us-ascii?Q?6cV8CpgMN9Rwl40+767O0unE3wYBYdzfh+oL32GbYCzmxysG2ulvJdr9Wiaw?=
 =?us-ascii?Q?j+RSCZ+VaauvmNYwpBl3AGjYzdbwCf2tQ3ojQjwRR1scfVPiC7S3w24pyFYn?=
 =?us-ascii?Q?8kYnpTONbK0hXeqmBPvcBPcV+19RCQGeSeUqeCK265jX0S7F5y0dHRk5vE6k?=
 =?us-ascii?Q?6EWy8CcfFIxN2AmHbddsKt9Zg9jC/0eBA+Q4z7bhiXv9sZ/lLoXIS554AtkG?=
 =?us-ascii?Q?mZt7IpflNfsdNeGLK1soMQS4dD9he+M3Vg3VgRxd4D6tEct+xlNvZKXcK1Hh?=
 =?us-ascii?Q?Z/HFG1s6M8+cFwYb9CDWzA6Owv+eehf5fzEcwOuzPJDltfokzesmol8KlA3Y?=
 =?us-ascii?Q?0wM8OUp+XyCGQ6vb87aNa+40p+HZdSyn2eWnIawupCRaloexSDSELhxMNGr6?=
 =?us-ascii?Q?e2A4u6vUpQ7muR9BNArIVva/T3RH0OFJOUjxh0ZRAU284TJ+5o1C+1kDwQQn?=
 =?us-ascii?Q?jzCbk1Ht+NAoVQNc4vcfurcwH7OH5eKt4TMuK8woDokCQ6H9IH49d1PiKw7h?=
 =?us-ascii?Q?mFuMCl0IhmSvzMCS98O9t11YDR7K7lO4P7sIzpa3eRhdgoLewZj7E83gD3hT?=
 =?us-ascii?Q?qAW2J6DMHxdmXVGO2RS/Y1oim73Pi59oumpDOLhvtTgUyRqILp0O7Ixx0PJ7?=
 =?us-ascii?Q?tfrFCYXo5XrunMTXXafHdHeg1Derbqk6ZinO0+GPuVUj0KMO9wTUADeGHJbu?=
 =?us-ascii?Q?cSGIJ4dIkPS1YXmkWHigE/3dQMPb+281MAOHfj4q?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03da50f0-ad32-4a9f-3b5d-08db82e3a196
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 14:23:58.5198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cqrUUDkerBXg0SEaXqkkD7JJzQkyQUdeb7EZoTU88bwzo8OjbR4d4QdZY5Krvn+Pmo97eRUFu3Z5N+8Rtn0MYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6571
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of failure, debugfs_create_dir() does not return NULL, but
an error pointer. Most incorrect error checks were fixed,but the
one in mbox_test_add_debugfs() was forgotten.

Signed-off-by: Wang Ming <machel@vivo.com>
---
 drivers/mailbox/mailbox-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/mailbox-test.c b/drivers/mailbox/mailbox-test.c
index fc6a12a51b40..ae9861c57fb1 100644
--- a/drivers/mailbox/mailbox-test.c
+++ b/drivers/mailbox/mailbox-test.c
@@ -268,7 +268,7 @@ static int mbox_test_add_debugfs(struct platform_device *pdev,
 		return 0;
 
 	tdev->root_debugfs_dir = debugfs_create_dir(dev_name(&pdev->dev), NULL);
-	if (!tdev->root_debugfs_dir) {
+	if (IS_ERR(tdev->root_debugfs_dir)) {
 		dev_err(&pdev->dev, "Failed to create Mailbox debugfs\n");
 		return -EINVAL;
 	}
-- 
2.25.1

