Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D63272D787
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 04:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238474AbjFMCzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 22:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237581AbjFMCza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 22:55:30 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2123.outbound.protection.outlook.com [40.107.255.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379D61727;
        Mon, 12 Jun 2023 19:55:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ewR1mlNic77KumcEz6eBccHYr9KJbUfD1RjnJ0akIZgWUIEyV8CbW+a3qAT+Se791oNgA0OH5LfHEjUgloVbjRxaIzyLCdODyKq2jCqGShsdl7cj0pciY5Z29aYoa0VP03AmXi4tJkNS+BE/6HjPH0gUGpSzuFm1Pe0C04FanOvPBPCPTdhBDcXmA/PjcsilUQzSrYgaMEoD78DfM4o21O+1YnLyJY/MgB8hpW8OysVaskgN27n+mylm9wBh5hFff5LZo0MS1Fu75vOkgB25QQzRwhXIHfmo02WYSNa4hLGt84IbemqdZ52efE7KHSRi+HPnGCcmVuMdyU0MiTYapg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1SC9/6V9Q9yLvKFSrzd33BzCPBnAiXkOeKS5R1+NNs=;
 b=hXsf2AvKZZJISI4wWj0E/WpvoTnQ8md5uwcL51P7Cg7PCApov7as9fBe1QmKFBsqIq3RLaO0lazKaR/yFU0Cddxj/AxqpAEUJJp7L+Zqh6UBkWYo55W2ZsnTQfMG64EWghowlFoEwUIJ6xq9X8aQObhIN0YyIn1vIhswRivKn0UekLvguA4rp5lxJpYuAizawkI3H2nyRWwuda4T3rCbiHlMxdYVRPmX03lZozOSmW1ZsMon2KcdOAxMkyHIipuwZ4TDLNRUWdIKkffUwqFf+u6rtmjqtPk2Q6/RGlG0+gr0c1bp9hBxJDRNQeuZxjnDRpJeafiBYP2t9lEqwBkBmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1SC9/6V9Q9yLvKFSrzd33BzCPBnAiXkOeKS5R1+NNs=;
 b=kBQ0tmZ2WIut6pumheNtKwlyB0jp+qQstODI9gyE+e2XdHX2B1MbT9FenbVXRIUYQCdQMUbluFn+f0HDSClDUJzaShL6po8GVg3ayBFyfgQQQug9hiluZksnedPI23cQc2vncB75E9TWSQy4pqY8AeWq3IMXuVbrP0WmqnBT3fEAH4BRHs0N6qdqeZZpljHpO9qJF9S2mftb+QK35o1EAAwZKeBzpwL0wk7CBq5brDYdgSBAi6u0GIQJU2+emk5Z2LyXcuHVC2b7IwzVK6Y0SNElXtFOhH/n9jU5NCSsTzJbmmEoKvzi/Z4EthcaeUNdMGWLLCPCLIsVlJH8WJ2fLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by TYZPR06MB6418.apcprd06.prod.outlook.com (2603:1096:400:45c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 13 Jun
 2023 02:55:25 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e%5]) with mapi id 15.20.6455.030; Tue, 13 Jun 2023
 02:55:25 +0000
From:   Lu Hongfei <luhongfei@vivo.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Moudy Ho <moudy.ho@mediatek.com>,
        Deepak R Varma <drv@mailo.com>,
        Arnd Bergmann <arnd@arndb.de>, Sun Ke <sunke32@huawei.com>,
        Lu Hongfei <luhongfei@vivo.com>,
        linux-media@vger.kernel.org (open list:MEDIA INPUT INFRASTRUCTURE
        (V4L/DVB)),
        linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support)
Cc:     opensource.kernel@vivo.com
Subject: [PATCH v2] media: platform: mtk-mdp3: Fix resource leaks in mdp_get_subsys_id()
Date:   Tue, 13 Jun 2023 10:55:06 +0800
Message-Id: <20230613025515.24512-1-luhongfei@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0192.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::18) To TYZPR06MB6697.apcprd06.prod.outlook.com
 (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|TYZPR06MB6418:EE_
X-MS-Office365-Filtering-Correlation-Id: d3884ec1-da1a-4fe4-0990-08db6bb9a336
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4TGleOyQF8VcsO8q7c9ULiyqmELaTQJzV+PMyB1tRBxLdilsQhUZJrFuw3T0q+5nCxFq70Fl3AzAon4WvYvcc7qshxmDa61vY7lmmkl8EDiAaY23Anck3bQgODdOS6Py07A3Wbhmupelr6QI6ijc25qmvJlmuHv4IZQvwCrtlqb9Y4VmEDNKlueIvBwGt5nLZpHcjFlariy50dkczSyA5xqlHQR4L/RhaVbBKkNumCKspwKKz6+LFbObmepzdtONhiQv+EZlE+0gPLPLXX/s4H7cyYJnWSUyyvay9qFZ2/TmOzS2P68JzYzd+Syv2RKB6bpzqd2zrEve78ysmryHfKEic+Pk4LpAFz9XBt8Q0MFn156pFGtQJDWzeXKxniJcmenAPAZWcJqL+4vK9P77pM7nKL5sCA2KRt6eJD/ZSKS0c2qUufgeF4Q7HPKZ6fSn9fzng64lRSs6StqlJ/J5Aya1/X4dcZ0Dbj/xgzHroJG3XqC0MZpuAwTXSDIUBmKiG6weT2ZdOEPj1GuffKRmImId4CxSkqmggwb9/KBJdYWj2IM7zfyRVijm7IVQSyNSuw1Ol0zAMKr4l1ueAX+3cWEAbprCJ/o2pDAmHwqiGQVcM2J0JB2JcCa5ePNU2atqNSvmiU8dkuM8Dg9dCSxKlA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39850400004)(376002)(346002)(396003)(451199021)(83380400001)(107886003)(38100700002)(38350700002)(86362001)(921005)(478600001)(6512007)(52116002)(6666004)(41300700001)(110136005)(4326008)(6486002)(8676002)(7416002)(66946007)(66476007)(2906002)(316002)(5660300002)(66556008)(8936002)(2616005)(6506007)(26005)(1076003)(36756003)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nWhv4lchVax53ZjlVwP6qvuAyNl1CDqjjZmgpgO+07dNrng3yl/BKNTXSHKO?=
 =?us-ascii?Q?AxyBnQMYjanSRdJm2ZbOmBObksnUKuYgB+YOdWAnlKrU9lpX//TILq+Jk+At?=
 =?us-ascii?Q?kaNhs/Hhz8KjgmEhSWaV6jCyJCR6U1arHlXWln3+phY5AmSTTgPjYBZgowPS?=
 =?us-ascii?Q?OMta1rjuVE42snGPR8gTBYtr8dt7e012LqwNXhQcYI/YrWWe24lR01C8iLzg?=
 =?us-ascii?Q?g9hkQHoR91vxcIvWLxc50LLkvs2aP/5uZV4OBxmB6bzh81S1jLUx0vKuQq9O?=
 =?us-ascii?Q?bKQ+Moojzgy1q4nEP4YsY0tE8ltxCqGKOJsXDGKKDLxQqyq3GAe4rHpCjF5q?=
 =?us-ascii?Q?ICa3MmYF+/8JuGZsQX/WdXcJvEj2mjueYLpQMjWwAfDzgeSOV+XvhEtkIMBP?=
 =?us-ascii?Q?kPsPHQRWleQ4ioZshBCKbLOLMNnU6qtZ9G7rEklOUzoProfbLeBAkn3NUtzC?=
 =?us-ascii?Q?1eMcPXStNzen6AUvOi/tWOjOPA9KTB1CrMrNIdXZpS9/VrEY4/mVRjybc8zp?=
 =?us-ascii?Q?73+A4NOkhiB499Io8PH5K2a8bfxejybCAWs3pTLayry6/1lWu8nD3v1WpBcZ?=
 =?us-ascii?Q?ZRe2MntYqO4+EKe3o5NQrbEZtCAxAEJOt58/hAAexzAjuMyzAPxlbM+OVs7C?=
 =?us-ascii?Q?N6CG43nhEyD6RybPvBG7be1oTrwP2d4VUXdzBgL7XtvqfWUIQ/PF1NNzvLSe?=
 =?us-ascii?Q?4Oy3hT+N4urtygu2rRpTp+3SHKSxTeMNzL/rogjdsXZ6Nzxn6tBXfGtUq9/L?=
 =?us-ascii?Q?E79ANuFlNls4C4pXueTJFAolRIl/MlTHVsELyeeXfyOl6nw2n1EPD3rLp93d?=
 =?us-ascii?Q?nanuKI1PuiRDUXAxQVX5WglnLmU9OkWY1rgs5p3wxrixIpKov1N6OggsS++g?=
 =?us-ascii?Q?TYEOEcg1ya/aLjfn7soryPDFIJJOmoeN+aP7f9YxM9OvCcRyzB52fHekZnf3?=
 =?us-ascii?Q?Rl6aJnrBWv8LUmDabJRT4zR3p2NflIHr5iDUORdPS5g17vuYf5eYkjRvz+nB?=
 =?us-ascii?Q?MU1epamsNa6ybgXBbXEaVqBwTlJPjoATqFDUxhhJXRpTXc4PdNsqmQevdjuV?=
 =?us-ascii?Q?qMdj3/VvjLKTYLy3hXqEiaQbvsdHN85qS28hEuG1RK4g4TrG0YpsM63sUmOh?=
 =?us-ascii?Q?jWnFVVk1TRy99wikOtrP0s/nttUQK8x2K5EAgipt8JzEjJTyXgaxstagDnIG?=
 =?us-ascii?Q?nB9Q+GgpFUGEUZ/h+mWy9VT3zbPcaMkEj3mJyPRP46g9WukSQOXEAhmhZgBt?=
 =?us-ascii?Q?TcOZTWG1ziesYQBUMs4a8EAYk4XiMQZSqiwf5snAdQ8Vb4R9ovDcCMdVoQ5i?=
 =?us-ascii?Q?gO+icpvJCB0du5K4xjv/Ke2Ji0Ao2pXxLAc008O1/5KKsDXdKkWYxkdJS5WY?=
 =?us-ascii?Q?Wdf8H4Ych6vhbkSB8BBoSmEUYMBi8X5p0Anq6j57BlBcU1SQwTuXwenT0C3J?=
 =?us-ascii?Q?+0KeGP37ceKWanLfixG5+f2bv1IYZ3SQh8LcEp8gdBnl09fH0/3Yqcr+BUT2?=
 =?us-ascii?Q?/AWZfsHDr6GBuvHW8uWDEgINRlekD+8huEoA92aAdXzea0TVBkOMIFG4IqCg?=
 =?us-ascii?Q?hhycAYynnMSlqTIfhgYwWiw8EWBgnt+hw3NeAZ9f?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3884ec1-da1a-4fe4-0990-08db6bb9a336
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 02:55:25.6574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b4JkDjssdTeHaI9mRyTwhEn0oqEQ1VbcodUKYMQu6WR+mI3i2sVzqo3hX0rLtEBIQq+ad6np21wpdCSTyFuE4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6418
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a put_device() call for the release of the object
which was determined by a of_find_device_by_node() call.

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
---
The modifications made compared to the previous version are as follows:
1. Modified the patch subject
2. Modified the commit message to make it easier to understand.
3. Use an additional label "put_device". Increase the usage of the variable "ret".

 drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
index a605e80c7dc3..ec39662a2282
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
@@ -892,13 +892,16 @@ static int mdp_get_subsys_id(struct mdp_dev *mdp, struct device *dev,
 	ret = cmdq_dev_get_client_reg(&comp_pdev->dev, &cmdq_reg, index);
 	if (ret != 0) {
 		dev_err(&comp_pdev->dev, "cmdq_dev_get_subsys fail!\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto put_device;
 	}
 
 	comp->subsys_id = cmdq_reg.subsys;
 	dev_dbg(&comp_pdev->dev, "subsys id=%d\n", cmdq_reg.subsys);
 
-	return 0;
+put_device:
+	put_device(&comp_pdev->dev);
+	return ret;
 }
 
 static void __mdp_comp_init(struct mdp_dev *mdp, struct device_node *node,
-- 
2.39.0

