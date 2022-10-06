Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3175F63D5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 11:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbiJFJxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 05:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbiJFJxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 05:53:39 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70092.outbound.protection.outlook.com [40.107.7.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7227C772;
        Thu,  6 Oct 2022 02:53:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+8E1qJ3/hrpM5Z4135SoKvzyhIXcOJFeRCHxnA4UThyOOJixrq6i/6wjTGippflRBPkcG9hS+C67aYgMN3uVOsmxv+jzghLNNpTNYqjWEko4T8SqtF4B4037J3DkIt7CTsYP8z78GRPp7serOIABYmUznW3X/AHTxWspcW7Wzken8UifQRVKMnXWSE/WX/wZ6+zp/S+g3AwEgvYz4XaPoIwStVMpUli3uv891bEBIXqxu4gkjVb/dCGwqAv4aZvCebIyyxcKBIIrJAq4/b8paL5RYADI5CatS1YigkqzCHVLAYAZQlIPslow2NQvVoHeBvG/fDPbJsfZcu9eT0Tow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8guXpKtrhAvEf+c5U9vDlZX19/Nrk9GbJq8CPEJypQ=;
 b=WaH6xdDJTacbKPQfblb/OjSkdn8qYtRb0WJ9xc230Nd4ULysZZmXnP9OcxjVIXEzSSBpOGjr2cCVX5qO2ujnQdN6V3B0PwI+nxNvPPoPthUFtndxlsLz/twAePsmBqBgsg1df0r2kPj3ci2NqB0DsHAhbe4Zng30xzeZYtWTOfFXX07922L72qulDfebyfSsg95PlLXKArTKGT85X8kNWmRBky7oP25SqM4q/gyV48MdIdPx0HPm+kG7HmDlWocwHRjK5V2l/JvFUSDXZN7Rd55YzWMOpTcqmpEzjSS5+ifFOGBMaotPr0tWHAoptd2n2BnoI60/5MaPNVojtXdeyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8guXpKtrhAvEf+c5U9vDlZX19/Nrk9GbJq8CPEJypQ=;
 b=IFcgIDEgvZgPr9JPWyRVuLhxpRPFr3Uqa6jcTdpYlvDAEJsKW8ZGlCEcmwAr/1m+SoEAT9CO6Ql5X/3UEJZBEiF5eWTcKA+Lk6CxAMYuQXHUAsyCoLuD3sQjwxzAdTXwjplCEkAbghxrFfV2WLRypkE2G/pkeFy1v/QHQ67r4x8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by AM7P190MB0776.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:119::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.34; Thu, 6 Oct
 2022 09:53:34 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::eb13:ec7c:e027:8404]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::eb13:ec7c:e027:8404%3]) with mapi id 15.20.5676.032; Thu, 6 Oct 2022
 09:53:34 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Elad Nachman <enachman@marvell.com>,
        Yuval Shaia <yshaia@marvell.com>,
        Vadym Kochan <vadym.kochan@plvision.eu>
Subject: [PATCH] usb: ehci-orion: Extend DMA mask to 64 bit for AC5 platform
Date:   Thu,  6 Oct 2022 12:52:57 +0300
Message-Id: <20221006095257.6934-1-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0133.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::11) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P190MB0317:EE_|AM7P190MB0776:EE_
X-MS-Office365-Filtering-Correlation-Id: b9051235-b677-4686-d704-08daa780a215
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ug8cYPXBQHb+NFok0HXHwpcjOFXRDLKV3XBctlJqwDPhaCEyyyjoA6RUSekmF2i8yvmCsVcGZoQQdNKjuDDCc5vGtOX1pNAhEuYVzVkFzgtcE/+EgAArRbv01TmLEu/bAtAlIqMFKCz0i4ike+r2SJcqgnO4ricWq5O6r4nIzBs+ev9U4HYOZALkQ3Ael6ieKY6DddpbmsvtYxWCgx9Vz54196daAu8SERS2bO9os6Y9StasBnPv1suYbJtDxbV7VTBT1s/GUf00sd+N6/ByKi/6mjiPYsDN+o90wyynlGtc4xoTOhXAyzGDv1y/X53/H/GuSiBHLkn/gkPIYrQiajpf24CCNZDDIyTMnhTD5lv6MZJpjKuiGxOLyPT+SiWbMm/XEvwmkXnmQiVsqE8L/LlA4KFJeXdKCCpzwXHfgKG2yNwy4mx0OontSYPxFCVLlBdYwcVDOowQK1cGjOkeJumiWWusRK/y5Frw3WqcoD1bKaA1ioQlPC41DyQZU/L7NBThCvdiAEEMacjj0BkoYa9rkvxuiiOn9QlIF3Xddb0Xweru/MbKpHETuCXiuReM+rUJEdOrG6O8JJR+50StjahIpq1Krym2lCd6d1gbRWj+/ZLr2aOMdeslJ0cvtvomCHONMpctTemguVZyO4v3yIzDxVHyx3EetubmqsN08+/sL7/LvvIzhRSYfjVc1CVhFko68Jd9WOsm6FkNdhfg1cgSa6uj/FsTrm2cacDZOxtjGfYn6X9qmbMIwH/z3aDs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39830400003)(396003)(366004)(376002)(346002)(451199015)(2906002)(36756003)(54906003)(8936002)(110136005)(41300700001)(316002)(66476007)(66946007)(66556008)(38350700002)(8676002)(86362001)(478600001)(4326008)(83380400001)(44832011)(107886003)(6666004)(4744005)(6486002)(186003)(52116002)(6506007)(26005)(6512007)(1076003)(2616005)(5660300002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s3SII+E9H3hqIlR3fmnDzO92WclGLSgUQrHWNH8hVe/kjelPh0aHO509UFSm?=
 =?us-ascii?Q?rHd5snHsQAYt6SWWFC/wimGs/Lmwt7HeLMgFFybSm+mt6/pY/JkWfiV0xi+W?=
 =?us-ascii?Q?ngmjlDy3rDQv2vM1bpoKelRPCx4dpBSH3caB0wgzO2Es3jxI56a38kl486X3?=
 =?us-ascii?Q?OnHeoqO8HzRnz1uuW3/aJ47oRAsZEoufA0B05CvBFGYDW8L11lQY94u3oHGg?=
 =?us-ascii?Q?4KDQRC8bC0qRIoul0aYF0Wmecv64Zp6X5YCs9YipleaOT5e1StmKq1E8yMXa?=
 =?us-ascii?Q?Vu0U257tTSvEK/7GyhxRir1yTLbYNO7ZuAP02NM5EDO6kTOs4t9En9lRqImX?=
 =?us-ascii?Q?PVncq1QzCOq05Zqth845z+2o5ANH/Orz1VWVe+nqnZvAV9iI+F2Es88zFGkp?=
 =?us-ascii?Q?QYukUcsMguIaVGCZNZIHGVtTkXpHZwWllnxKZffsaND0BQXLvjo+Y7KeE5A8?=
 =?us-ascii?Q?z+2Ft+MAsUKpNMavZI5pTIr9K2gXF+IchHiJhrWQRZYtjKzJbRsQRCIzg9bB?=
 =?us-ascii?Q?BoZdf6EWQLc8iVYG/K0bNB8BfcOakIOIXnnAYEvTlfs2nM3y8t11mdGFejrf?=
 =?us-ascii?Q?Ym+X4MNp27aG4fHWpCrL0dqsEx7plippJ3vU+/rWFUM1OsZP2UYgm5DKpe0y?=
 =?us-ascii?Q?QOYrB8LOp+2A7QJH/36fz7xVZxjW8H5AFc8oqxpGeqDVjSFg+ys63pGn3Kda?=
 =?us-ascii?Q?P4XzTetMqpYlegoSPpsxWBVyBm0p7JkvRUJAEMSanBAMm5DB1OGcf4hYRQLO?=
 =?us-ascii?Q?WnfdI+IBOUeutna9rJgbSU8ZVoK0v4NhoVMemqUAoBgnGlKNlivj6r0d6NKK?=
 =?us-ascii?Q?/W2d4QOC/qco4IHEaA7A9olVG7xcRZXjMXMIAvQkswOsZvkneoY9gbAcxHvJ?=
 =?us-ascii?Q?gx/wFTufbTZgZfv8L7jJPHxZFqNeNht0CyYAbA+pCCDjp5nZJ1d0b78aF4v2?=
 =?us-ascii?Q?6qJEnJ1mtS0VRflGVu4sLW6TOAfjY0rbivRxZGU5Abg6oJey1Eob4YuRxlu6?=
 =?us-ascii?Q?EAo4nQxqGtpRMJKPlTXIV7T3E74k/RIKnBZsCWrW8tNUTvj2VZ5l4PxoTTHV?=
 =?us-ascii?Q?1nwoxUiFREdjaVdMIIfrSDmMQKsRjlrW3koOAvBpesDQXd7RZBa1XEnPwW2q?=
 =?us-ascii?Q?e3NifjVJWVWAiguhlNUucKqEa2et7fmRCPH2sOE+w5jDaH8XrIIZMgCZCpVi?=
 =?us-ascii?Q?9DcXA2BvXlEVXiGOKHYIiX56uFKgy/pWRL/KURWdlgdJ3CHWIBXxv6VpXiU3?=
 =?us-ascii?Q?gAefQy6JssxMcLUz/tH7GBGlm5O4LWclW5z3tuVx0L50i1AfTfT2tmPtFOY0?=
 =?us-ascii?Q?Z6KXKiiKyWtROPmeHtLUW5fqZjbCTBX/MxSf9lrB3tIgCn3816tCtv9NFepc?=
 =?us-ascii?Q?wFOOtEVDHB0iVpxzECBsEfPsY67Oi7a45U4qAyh0qQhrjtWluJcWXeoef/uS?=
 =?us-ascii?Q?CC+grdxh/82Uo92rXVnbQyjKH4v0RK/e/7z41yjeY+WnSvERVzAX/ndU0qtF?=
 =?us-ascii?Q?xM+aBHXWsAVXzxpAG9An0/WOOkqiGZ1yUjrc7gqW/Lz8wwnp4G4rA5weW9Ku?=
 =?us-ascii?Q?CU1aKkz3Rs+F9QcNV3zdFQGxYpOF2TJ8h76g7XvKnoSVWcpwuh2QIBws0Kf1?=
 =?us-ascii?Q?Rg=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b9051235-b677-4686-d704-08daa780a215
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 09:53:34.5370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ulUc59+B1nThSycM7cp1ulQMDGKuFXNlG4U+vVlXOGGhrxCAQ8WHYpsSrBjmyF9mn4JL3j0D1DRfQMvo54IdocyZqs3FMnHK3Ozz+ClyrRw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P190MB0776
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Elad Nachman <enachman@marvell.com>

Signed-off-by: Elad Nachman <enachman@marvell.com>
Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
---
 drivers/usb/host/ehci-orion.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/ehci-orion.c b/drivers/usb/host/ehci-orion.c
index a3454a3ea4e0..c6205abebbdf 100644
--- a/drivers/usb/host/ehci-orion.c
+++ b/drivers/usb/host/ehci-orion.c
@@ -230,7 +230,7 @@ static int ehci_orion_drv_probe(struct platform_device *pdev)
 	 * set. Since shared usb code relies on it, set it here for
 	 * now. Once we have dma capability bindings this can go away.
 	 */
-	err = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+	err = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
 	if (err)
 		goto err;
 
-- 
2.17.1

