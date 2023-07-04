Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393717472D5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 15:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjGDNiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 09:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbjGDNhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 09:37:55 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2122.outbound.protection.outlook.com [40.107.255.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C04610C1
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 06:37:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Unm4uNCiDkXCiNA+H6kIac/hfUsxio6XwnwkZTqaZ1zifdLuFKTvDFtqXqqLk1F6bLSrsZwPlpa96ynToX93TB8k1PLWfcJ0FvHto8E3XieUA9N7S72mz9Y/z+9pMCQr88zWpRCaUbjsQbh4X/K5XU9IFnFQCj6PFzrvctK8lsCqjnJ81VFDHACAkW9qc7qCIe3/6mcd54YeKdepL2sCFVOspEQtWhD+R4fv0HoT+LiYFz4dKRR/bi0Uyj7jWncBP+cNHgtKStsPPg+3xC4BI/GL2/Xkb84a+n4c7d32IVGiA3gljwP7pFmuhH7dZp94a5Vr6jVEnjWzzy+vjIhM9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmIAVAFKl87Y9/NyeIDknl9O71bA5hevNgqhyEW6rnk=;
 b=gJqcvicRRztwM4CldlSLybl6e9pDiUNsY4A78R5+j/Zo3oeoSiFRzKtoJqSodEn3kGru9QY36zDNQ/wUzKAlKA+udG3pPaCXjnQjDmk6hyjppBLvFxtEDHSpU/UD6Sw+UzURIZibaqe5YCRoInFRc/RnQiKOHvN23jP4+ZS0wIIT4WWgIgll2nzb3jR9rM7PwdqYoeGRSpoOG0dIeJ0D70Tf+UoROrxNIXsRJYEAO2e1MtELsbwAfmIn3mZJhugL2q1dUfdxRODnEo/O0ds7a7hHT+hryPRavVj9aq8xv2pjLJjgL7Hd+aeV4ADqAE87NJSpoxs1hvLWHO8vqW5+BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmIAVAFKl87Y9/NyeIDknl9O71bA5hevNgqhyEW6rnk=;
 b=SQeSKcBsrci8h9JBZH012FxUlYNaQ336Agblu/hWDd7JUaQQuXQXo7IxYL+GZcMQzZnBKtUsWnXE5Q6JiFwZBCldgjRmRt6kkezKFCXxcsoeZVAKsJV7aCedq5OXHk8kY5gKTAOeimCaAqc+VReFzigjiZOrwYdQ3rRdoeI1eUC59bm/zP/DHS8dtKyYyTuhfzaPsIn6LpZ1b2i2wbV1T98W41MqIRJlQAIrQA7CxGHKZ+8WWFtQUc+D5ACAhN8bHdJcCtagcs9wIJ710jyXr5SOAgm1vsic9a8N+RJp7gjPjYThc96zgQXwC3bF3ErJ0eUnOQvZRAVRqy9AqLgKnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5708.apcprd06.prod.outlook.com (2603:1096:400:270::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 13:37:40 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 13:37:40 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 4/5] mailbox: rockchip: Use devm_platform_get_and_ioremap_resource()
Date:   Tue,  4 Jul 2023 21:37:25 +0800
Message-Id: <20230704133726.28861-4-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9cf67fa3-bac4-44d3-f894-08db7c93d6a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xFU4cfmNojNYi7CjEFPQ7PLy90HtO1ATuIHAVUHibOq7gZd37Ab52VqL72f54Spv0eZzDSB1AH+aIJkAqChNgGzUiaTMFRMKBb0Topg9u0nY8MuNCUoFzphJW5BD28Uxuh60zMLgbn2Rb6IDu84WzHiMsUl5DWXUmvJ9otiUsF5B5bZlHCG3QmWXvmkTYdYzpB14T0FN8IzpHJcvrbrtPEifhcuDDVk+QY3PeRQzbifyCHRULCpk0Q5I7LMAZm5yeqLy4AViOqEy4ZP+WoMA9eqF9nmDI7oTaoNnnuKDD6/y21O6qiKSb8oWNXj3UBCt8jfgKC9UtQRJTKfOn6HjQUgZmLbohwn9uFB76FSHkQlYckI35YYbkjLA71jTbAptmH7mj0OSejr9btaMU7AjIYul/n4/IiTz+Y+laF0zz2y37yTXYpCEvE3vTO3gMR+CViTO5WKGkiJ8yGD+qvzLZar2ggm1AYdBs0AKf9E4oHwJrdS6LFa6SAo+0AQFGFaBtg8rPiCTTH6Qctsjs3lddZYNJa1/ffJyyc6swUJhqoTchN5xY/0CUqvrlx477PSa7cv/vEFYxheF8Yp5bkpcFiuDz9h3jn2ZdexXVIQwpY6wBW7PkPo6vscsoj4RxMKk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(39860400002)(376002)(396003)(451199021)(4326008)(316002)(66946007)(66556008)(86362001)(186003)(26005)(6512007)(66476007)(1076003)(6506007)(83380400001)(2616005)(4744005)(2906002)(6486002)(38100700002)(6666004)(15650500001)(52116002)(38350700002)(5660300002)(478600001)(8676002)(110136005)(8936002)(41300700001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A8W1jHJQZ3mV0IUNn/0niU26A+C3Ar0Ak5qaWdkbVjfrq3Wmmj9Tp/+fxjHo?=
 =?us-ascii?Q?g0lVCDTQCZ99gJlMMwPBIWp/ziTXPaDHiMZLgGQTJ4yRk2Y/l7upRs+gXxl6?=
 =?us-ascii?Q?a94yWsnJZ3swkN1/eYv31dey9aursbrvhYAJJOjvtCrKeNVkyPdhk/U00juA?=
 =?us-ascii?Q?2fWx9o0ZweDhDvdgmw23yWkUENW+jbaVpyO8wGdhH3VNRSxhiEEPhPEhX3fb?=
 =?us-ascii?Q?FO1a12bvFNMGNs9E7ZJhEG1TpuEXX39L7Pxk0o81AOsL27grq5TfxgzBuUaW?=
 =?us-ascii?Q?x6u4teClcP1QCWW9S7CCRS3bPcXBIxbIxiaBtdz+Gt3hNq4ZHS/qNJjOEn+W?=
 =?us-ascii?Q?GwFJl3zFMUJAx02O4W37ShUlN9D7fFsUokgSww47xzlHzHmGIkPga4xt1qlI?=
 =?us-ascii?Q?3spnTWGt//XMyXYmKlWAy4NbRSfPyySVkAw8+lgfYXCrpC7H1C7mDFWHyelq?=
 =?us-ascii?Q?ZPXbwWysGnEalQ3u5KHIn3lp6YikadzZiXgt/R7r+M4mSezW0lA9nwdteDbV?=
 =?us-ascii?Q?1QauK0V+Kkv8hHIuj9XmPFGVc6e5LgFLl9/PWBmQD4JVRz9bswni/q3bDipe?=
 =?us-ascii?Q?54Pl0eCLNWOWXmeiQQSWAZ6csT10dgrITIhVEwbHC9ZOn+UaBACFPkF5HBZW?=
 =?us-ascii?Q?8VuJK1mmNr3b/Y8Qw5BbAx+uZsjJAR78Mq3fJII0aZWS5ogQbcBBMY45m9IW?=
 =?us-ascii?Q?oPqH8eGr2jaDGTIXvBkFs98XHmkonNg+5pIvzbG8Tf1biN4kAgRU4XCI6di8?=
 =?us-ascii?Q?drfWy8Ec+ZV12vf4wyMAwVerTWmSIn/bH3njZrBvI0dPnGYqt9eE0jgZg6mI?=
 =?us-ascii?Q?JSYuPe+4mLIqgu/XSjmc1wO/HuMbd2cSdedfaK2pk//HYpv+ZWuSNXi2Ggnj?=
 =?us-ascii?Q?u1CtjNJxZy0EwKVQchsNrI32/7321Ivh2bE36RqBisuC/31swAWS9sL6it34?=
 =?us-ascii?Q?URhZQXjpL5a+gauglQFCSPl/xYDRifyt3HbAvJ9BljMvYnTloyaQNeXMZbYE?=
 =?us-ascii?Q?mbUQMnlM4HO1LA7rSXaD4zZG/50anPB5DXelAiqcJPRU0cuCfMC9QslEDCn2?=
 =?us-ascii?Q?YRwncgrWPoxYR/WeI50iHTby0NirbJYSnmfXDeqjVjtC3fIFhmXr5T+9dTeX?=
 =?us-ascii?Q?AATvigzP6EGKsQhkrkd2nP1/59HBCVcejShtyHJ3J8bxXpUJ+OQKgNXAznCT?=
 =?us-ascii?Q?Dhow+5b99RRe7K6CTQp8dgVAhSn73Sjx1YujAq/BItW5lOZuxUHFE2HsKJA3?=
 =?us-ascii?Q?RhGd3gO4f3UJyXHWXFmo0v1r2a24KrJqN8ZFt4Qt61yBInbQL41k9vvlRRSW?=
 =?us-ascii?Q?+1ncTitYIrfESP14UrW872GD9OQn5VT3d5xMdisj8lPnSI/QXZ9AqMUqiE3U?=
 =?us-ascii?Q?Pw+P+OoO7WxnXPu2z08dhhL6RR8s1NpZdg0H5piSiWnlxRYgmuZlO3xFLdMN?=
 =?us-ascii?Q?nsB5gvkHoIxGExJXIIIrIHUW8UG1/PYwsXJJxs/v06VJz9fQ65RgFhoOqk9G?=
 =?us-ascii?Q?ZofXN1a3pZZQrKvQVU5ZJ53Zo4rkSGE686MDAGcGJBjsSFMOdV8z3koRx2f6?=
 =?us-ascii?Q?5RJ9IV2AYEtyPU8ITRly4QaAABcY2rNZPe5TwsCv?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cf67fa3-bac4-44d3-f894-08db7c93d6a1
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 13:37:40.7016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wEgcpBIcvv5UGx+5rNXhNXr96VxhHy5cZ7RR9/TDYkev10SMcM1aaSJoObz4ibUOVMlkEUhypHqraMJZS5axIA==
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

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/mailbox/rockchip-mailbox.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/mailbox/rockchip-mailbox.c b/drivers/mailbox/rockchip-mailbox.c
index 116286ecc5a0..d15c490a5a46 100644
--- a/drivers/mailbox/rockchip-mailbox.c
+++ b/drivers/mailbox/rockchip-mailbox.c
@@ -194,11 +194,7 @@ static int rockchip_mbox_probe(struct platform_device *pdev)
 	mb->mbox.ops = &rockchip_mbox_chan_ops;
 	mb->mbox.txdone_irq = true;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENODEV;
-
-	mb->mbox_base = devm_ioremap_resource(&pdev->dev, res);
+	mb->mbox_base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(mb->mbox_base))
 		return PTR_ERR(mb->mbox_base);
 
-- 
2.39.0

