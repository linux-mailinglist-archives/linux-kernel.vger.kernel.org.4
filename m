Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361537472D7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 15:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjGDNiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 09:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbjGDNh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 09:37:57 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2122.outbound.protection.outlook.com [40.107.255.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B510910EA;
        Tue,  4 Jul 2023 06:37:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZj2Z0mVgmvbJJTWb12zyptzZ7lc4gCH9XIZ/9udFrajQ3QAmShVUDtODp4/yMqyQSWDzSLlD1i8rYu+gIpYZXHhN6FOmWzFluF1SlgOCJNxpqY7iFEE+pf27RVYXw8jUT4wkQEqJkf+6LLb4OhmWXj21actMakA/56WeRhB1vWOmG/44I7gjaaDA/3B/ymkh3S/o15lY/TICEf2vw7+hPbUn/yWoqsrtNRgTz468cI036QKiSEAJaTCUByiLvUPjNQOjj8NtbeqmdC8aZ2NhWLl2qbGjxYjqdJLeN39nIPfjILonEFhgoopjgsKRIVLG+y5acg0aNYQH0J1Gk5TVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tpItvDxAV5J93DGBK4DnagyX3yo6vM6e66EADWHI3Q8=;
 b=aqH54kaqyMkV7lppEJ4i3E/+RTIeWSqDVWXIPGUA7mhz979eVRgdWYL2WH0MlqkoBX09u9r1FArrHmy9ig9/3qBTBLn2Rc9zXSGxqeZj1XzJB8hnVuJw98C5eX+Z83w6ICK1JlH6nziQkO6C4Q6TeDLjpI5YQyrwADKB2g9Qyof3BmmxxXx+NLnCDxSZtO7ILj0yiheruRPdKr8RNp/ZY8d6MxQvSffOdGD0Bwoi2NrFL3WvhEFhZr7W+VuUFa/SbB4+/IOogTrOfaBoOQhQIgR77+Zu4DKEjT+31D0o/l/blUkYnE62dP8AJAyeM9khne91Jn9lDFlJpH4evl/4vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpItvDxAV5J93DGBK4DnagyX3yo6vM6e66EADWHI3Q8=;
 b=Or2pTv1eAp5pyaGmtvBVo5tP+h4o4+uIKY3yNhwh6ofmIBu71a27ttIJtFriHxn3F2Eiss1C/0a6CxbuwqIAivHmQfOqPcB5T6RsWmT2PwkCUP0Vpwn3Ra+nL5KaUAlS6BJ5Zh9c+pom+19VyF/28iSpV9KbYSbuA+sjr6ZTT83WHvzf2/chbbIOlTGYzakdKBc/lFZRhiy/lamAMRUA1xPWICrinFmERAyx1eKjb4xw2qqrshrVmXUhGNC+4HzfilgFuadUoeeOpyT6CffLUreCB2jR5ES6CbeBy4klushwmrgIoKN3XGq/Z5ArWSfJtINrX700+g9+/aQEFrgagg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5708.apcprd06.prod.outlook.com (2603:1096:400:270::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 13:37:42 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 13:37:42 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH 5/5] mailbox: tegra-hsp: Convert to devm_platform_ioremap_resource()
Date:   Tue,  4 Jul 2023 21:37:26 +0800
Message-Id: <20230704133726.28861-5-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230704133726.28861-1-frank.li@vivo.com>
References: <20230704133726.28861-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0034.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::21)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TY0PR06MB5708:EE_
X-MS-Office365-Filtering-Correlation-Id: da155f2d-aa50-4807-1b8a-08db7c93d7b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HT3YiY4uPJwquduRPdYNl4XSRwbYyDWm3O9e1ETUGyAOiAY9G9eL2qu3JEiWHU4v5MRN5XmyDcx9xha+7GyyCl5IT64lt1Eo60U/Vnn88LtYrftV5wk/AHPW6w/grWkNFVCdQxL5zUHVw+oHd9EGGXVphv0h8IOcgOOKg+wRK+KtjzmzrQZjlXBWiBANDbQKIQWEbfNux8sta2Y0f8NlhNnCQgML3Supi/ffgnNDu2rYyzXxHLEbrF+tfsKjaLG8ulfk0ojhRSHCtQzNbTe8PJtbRzknXcrF4Ad+roFFcf+VlwNBQLmvbZDub0YZjCCOlRkSIG+xK8vhsbrryuAdbIfy3Od/3N9waDLt3ophfCGoqYB1IGdC4Mygilp7+leYSt/l5wl7J6urP+YUPk37lNgi1ZvidHuGtazI4D6XQ1rkvntdER5FLgYflF4gsqWYDEagS44n852kRJ7WRxxAkTGM72CByQ7jvLQtS7/8SLOZxWYRZ+w81NoNnEgqgKDdfIQYF87L56rQ5KhvpQWfrPctu/T+wVc4uVKoLn8SZfl84y+jj7YgmSfBWQc/RNPOt9+hyaBzbKCZY8KJLBlGVTWTJlRqSjRCot8e+ZkzMWPIboSD9xlyMjr7uRDG+5l2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(39860400002)(376002)(396003)(451199021)(4326008)(316002)(66946007)(66556008)(86362001)(186003)(26005)(6512007)(66476007)(1076003)(6506007)(83380400001)(2616005)(4744005)(2906002)(6486002)(38100700002)(6666004)(15650500001)(52116002)(38350700002)(5660300002)(478600001)(8676002)(110136005)(8936002)(41300700001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tpe/n5Jg43MgDrQnCeEwLCLCvoUF+XTAxj+EUvFwmPLSIfWi1Y5EFnHfutju?=
 =?us-ascii?Q?Qa8gcZxsDk85mtHWUFhMbij9Y8J7Lcvb4qHPrpncwe5WQUS7iIIvNLQILdS3?=
 =?us-ascii?Q?S1z2fHyRYaokAA5+HE1nOQqI8qCPQKCJ8oM/IqYa2AlxNGx05cGAb6NIRdWv?=
 =?us-ascii?Q?FBJLKfUSLhtcHIfCh7vz+isIuIaKxlfPe0+eypIwvNJUybr2qzbZ2jZve8w6?=
 =?us-ascii?Q?za/V7B6JDVOj+1Ll5hJFMKzO4O2xMLGWXdZFsnxBx7mhWkgi/0uY1qQYj2RS?=
 =?us-ascii?Q?tzKEyBgud4vKvY4LAEnpUjouNmHznsC4Y+opaG45Q/nWGz85UIZTejo+eHEh?=
 =?us-ascii?Q?Bs7opFV455ehaH/cNhFzpmuOalrgXjo9OHOY0+1LhSQN+/y3G9aX0BdjlEEY?=
 =?us-ascii?Q?861NMmZzToQ/LCIgvLQkQ9oKStBSNkhDgpn0pw6s6TWH33KLbSG8imxAqzf6?=
 =?us-ascii?Q?9rbHMixAG2wTxOjzIUQWKfWZXSqdIzgDwrVzV6mk0ZHo/WNmla5QJwJ1Lbo4?=
 =?us-ascii?Q?9+pWKNtNowXyh8h/LU/1kXvXDOyaf27CdypLIBQeQL+RSB8qh101flus+n+Q?=
 =?us-ascii?Q?phtyD0kC7E0acns9dqGul0hISgQst1wL9bgrbENY1HfiAEH3QnqMJyeQ+zUo?=
 =?us-ascii?Q?gBlTLuQ8HFDa8JTPGrPJoGF8eDAMfMhoPloS3R9UfAh6/j2B1P6TL1LpKvrf?=
 =?us-ascii?Q?HAa7Ira33dSXU8JHJWDdFvNLub1AkoG04mFsSkO1zJHYs+bzwxzE6rlYgL3u?=
 =?us-ascii?Q?Fy2Mn+G+SEpC2MxTHkFkLKBfPhVsRyVxPUOVm2NAh0eaQ7GyAdMiVBYr3QWY?=
 =?us-ascii?Q?iwbe1kitRvcEwZFv18bG1JmLQFmCPljeYr8FU8lPQs7ERkot+KO4l98o5Y0i?=
 =?us-ascii?Q?i9yxe6oSb3/oPdhsgGWCyNUjwdB/4zHok2xsTQQprN4YsnU4TnLit99KOXST?=
 =?us-ascii?Q?ESzYx9Ys+x83CHjgoHSlinh0AKej3wZfJdSGNBNnZVbPGnU5fHg4oV4691rt?=
 =?us-ascii?Q?zmnJLKtq877D9aVzDuvyfzVM1nJwMFukkebMc/5n2v3RGbuv3giuezg3hxZj?=
 =?us-ascii?Q?RYWN+P2Aq3HBsx+gGg7c64DS8xkZiOIwCLMBsUbG01IUBiD4o/ADVysqDoUE?=
 =?us-ascii?Q?Ie9wJBNcKVp0jV8s4m4aHfqu18hzgpe1OSKEDcDeJoSpmQdw+pB+zjbAdoi8?=
 =?us-ascii?Q?hVEXV1HtlwW7Fdshq/zziC0KL9+eB4cB39hU5aOQsXu6riwVS/HNJ/8/fgS9?=
 =?us-ascii?Q?QlHYoyk+OV8oXhS+QWaV5Nv949kkpPel+mLKIyEMv6WlvZotsYgvh505QmlH?=
 =?us-ascii?Q?MUzLZ36WGbbYWewyr4O3F5qtAwsF7j749S+JDUP6gLQzpGc4L5yLVmQsjHCy?=
 =?us-ascii?Q?j9SpFw9djqcJKhUHZymTIE35a2dahOSVUtdd9+ykZE72AtpDZxVX6sBPbt/c?=
 =?us-ascii?Q?3tUGE+ZV2N4WabeU0ncU7IACgu9dY9+WkFjLrWRQ584osOr/T0cH8o7q1L2S?=
 =?us-ascii?Q?HpS/ZFReh3vsGUlXWRMweAk3FGpYohoEw64AMDroI3vRHpYemebpv9CI0PW/?=
 =?us-ascii?Q?xawG2ASasIRc30mhLki6uyXyHQ4kHV/dGN+54Xkx?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da155f2d-aa50-4807-1b8a-08db7c93d7b4
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 13:37:42.6088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yBdlGoZ5NqUldZOoNDjrP12pM+aZhlLlU/tfQlhAuEKHQsZnzxQEWJyU9uqKJTDUNZZURMKEwehjBCSiB/hV8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5708
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

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/mailbox/tegra-hsp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
index 573481e436f5..1e82cc2661e8 100644
--- a/drivers/mailbox/tegra-hsp.c
+++ b/drivers/mailbox/tegra-hsp.c
@@ -727,7 +727,6 @@ static int tegra_hsp_request_shared_irq(struct tegra_hsp *hsp)
 static int tegra_hsp_probe(struct platform_device *pdev)
 {
 	struct tegra_hsp *hsp;
-	struct resource *res;
 	unsigned int i;
 	u32 value;
 	int err;
@@ -741,8 +740,7 @@ static int tegra_hsp_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&hsp->doorbells);
 	spin_lock_init(&hsp->lock);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	hsp->regs = devm_ioremap_resource(&pdev->dev, res);
+	hsp->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(hsp->regs))
 		return PTR_ERR(hsp->regs);
 
-- 
2.39.0

