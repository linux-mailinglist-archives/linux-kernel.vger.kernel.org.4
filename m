Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B309B749AEB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 13:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbjGFLkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 07:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbjGFLkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 07:40:02 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on20715.outbound.protection.outlook.com [IPv6:2a01:111:f403:704b::715])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEC8AA;
        Thu,  6 Jul 2023 04:40:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BFKk19ezVHfz77Vs5KymfHGM3ukbjcN//oy/+xE6jJWHIjy6PtxOQq+u+20jqn29tKfdaHfPC42QtIodqee6dIYX/ot9QsMajBqWfvYPuNG7xeHvEeMyWt1Hob3Cn8bUdn1qtbyHFstKAe3IE6bJxvV137TKJp7wVwlYKM4eDkghz5UIBq5Z5GHt//Wi0hteQKZlPeP7JB1kkOA63lmSf8rA2wjRIlCnpiy8ARXvheW+7VHk/ZuukYzXosGTA+cCWv8N7vuODf07xaQgemJ8tAoDiKKUIrtMuPUgzSfD4+ea9nAqZJ1p4o1QDx37yzQAs553sTNrti2pJmWNXM/aSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4TibxnPfReehNeHPaLi5eW9sZyTCC7O9nyfb5qpGRk=;
 b=BPmfSNAdOzHZGuNoJHyDrw6rwaCMlpsI1dOynO9UYlXAsg0No0T0eFWac3GYGaCf1A54oLXC+//qwqMrz4A7P/kJMcJh26UBmrj8wu3oJ/BavWI3izdcUFtog2B8XBYISchxCEp9czcj8wDT9DnksP6nFDPP66SabAXc+E/SZrDgil3tP78Va8Jb1kfyP+5lM0LPcz7K2g0RpQizEFCPJW3ictAfnHSvIp03TX2mJvDPrPJnMUEV9ddkl/d3jgL151lv7ZxatYWllnfoTfxx9NS8tqiBun0fIDtZNDIMDEKoGOhXQwbJs5Q2LVYT6PLuWHmeBNgV4NOU89PvUuXSyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4TibxnPfReehNeHPaLi5eW9sZyTCC7O9nyfb5qpGRk=;
 b=Iog4qEBJpUBGx3/u4jZlAc3QtGQBgfjeYa2pB5wuR8eHpUp1KTSBgtQux/yAl+94omyk+zqFXB8V3Jbgqzqd+Uyee1/dVy8wFXIwgKJAzmi59fEVpWpV6UCtA5mqNISc4lxpivhmSIfP8+qPfPf27MJ52UeNY78wFf3TlsFDcsGjiokgouH47A1j4oVeBrHGC9HGu1IepBXW+aS2JfjoVxdZy2YmKJKVMOm+srP0Yof00p8N0qmZz3xN092CdZOgveh6hRr805PC2x9AqO+Htu+4Q0j3dUiTr8f07NzVi8kvGjEuCJqkAT8MpKP71mZ5saz6+sZeU7kqnkv/wXgkzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5889.apcprd06.prod.outlook.com (2603:1096:101:d2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 11:39:51 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 11:39:51 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Tony Lindgren <tony@atomide.com>, Lee Jones <lee@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] mfd: omap-usb-tll: Convert to devm_platform_ioremap_resource()
Date:   Thu,  6 Jul 2023 19:39:34 +0800
Message-Id: <20230706113939.1178-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230706113939.1178-1-frank.li@vivo.com>
References: <20230706113939.1178-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:3:17::25) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB5889:EE_
X-MS-Office365-Filtering-Correlation-Id: 5da967d2-e179-4eec-8849-08db7e15b5c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XwDKGIEQLBSny+LY3j/FzJQ9wwFUpdNjPpzWdyxn8TkwJcgZ3deuvL6O1eHCgoBeJnnF94FAQMAmnkY0eOFufHT8EJreIusWeX+vDePEkhtX4C3weWqCWXzO1wtFoUQaa5q1BQ8zRX4ySYbWxbbuTZJq6zXfj4jiM+kH2Gn2hHikerIbbIcieBajrtQ/4UQc8RKWEfbxwjB+Urz+RT2W35jz7wrp6qUZlIdif2QWARbVzR3jNcXnCONHDrjmfdawUzLx0SxjcvRv/l+oaXxH3nI4PG2CYEeRZ6VXcn0jpn6OW4WJ8pH2HFiZ/w7KPQlJm2Ifn2NWlRzynoPJIIcTMIV3DE8AzHqCSDSW5ectT+vlEyTQftDKZNvp0g9urT8FZXOPiwg0qQRcMVPDoW/K0gdvP/OUV80Z1iW2Oip+WsAfEJYRMizWqySewE8wMxfd6tFVqBBOT3ZtzP3sdmu/Fo2P3Eft6GUoNDPIlDI0OF2zFYYHUclQv05a/Oy1XnioDHfOlYbkagI0fTExG1bDH1XRpJaT81z+ee17UT2mP9O/rt3+uGBVvU1DzbNoD3zoKik1BMzH5dJNAdrJqJJ0H9RVDqFQR7oHGdjT15Ql9YSmioyaWqf7eV1vVZmyAMco
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(451199021)(36756003)(86362001)(2616005)(4744005)(6512007)(6666004)(52116002)(478600001)(110136005)(2906002)(38100700002)(38350700002)(26005)(186003)(1076003)(6506007)(41300700001)(8676002)(5660300002)(6486002)(66556008)(66476007)(66946007)(8936002)(4326008)(83380400001)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uuFANVTabQ3HkUoALAYBlnlkGbZMFHbV+Iv4oFxVDvfiwJ0sWs+XyrJ2qf5M?=
 =?us-ascii?Q?U5urgDLf/KXrfhlqvG6kmRXe8p2To31HNAy8N6/n26w5JOa7OQoyFM4PbX9h?=
 =?us-ascii?Q?u4LrL8ElmcnQiQDix1bjZuDRCJSsCJwb4E2ZA/TjsFS8p9v+TkYar33dxpeM?=
 =?us-ascii?Q?9FuYOwaj+1z/K/4VnKTxCX92r/k6qzHX6hU+15cwzVXimmR98QRAxwGNY+mK?=
 =?us-ascii?Q?RROiY/ZgE1tY4eS0589GpcKaeI3XlS9ENtITzICWuBPLU/hTC9wAdWIlR0/3?=
 =?us-ascii?Q?ulwTuWaqKrKLi8dxOAt4nOXssLbuK1hWzZwUpJfybhKNr0bzcngzEsCPjHUZ?=
 =?us-ascii?Q?hKA8ycROqC7VgcDTHYGLIAVxRMqBx6nzUAGhaqDeepNPmJgqOUb3xqAzEd0r?=
 =?us-ascii?Q?OTqwmIq44QwIvIxbrRZnhlc58IwZlah0AB4A+cpLbxFsC94bgYwttrzO6xdF?=
 =?us-ascii?Q?r0V2PO8LzAMyH4VeoW6rVDlbs7+Nnc+esgxqdBGGho9Fj+DTs4w4npw+YYt9?=
 =?us-ascii?Q?5RSWzGiJ3sCkz0vb438xyCY26W/dxQlnaBfV5kHpJS2bT2UIh3taY+YoumMq?=
 =?us-ascii?Q?Gcms44e5yg+Ab7mcqygyENQMAdy20hTvT+bTGL+iZGRWxo6/28LGHCeVNHt9?=
 =?us-ascii?Q?/sHUbeDLtL2V1aQbibCPlGG4RFwkmuteRQPurfzacfI8s21T2CBE3s6bxy8y?=
 =?us-ascii?Q?TJ7Wgs4XICtRlSUt+o2WIGSlTN01gw7bOEG5AQzqcWo83gTWhJYzZKHz9FUH?=
 =?us-ascii?Q?E1grjS2my+PKXwUsACUO8gQSk0COp4N5Pi1UnYQgTB1uy3lmKXW6cbTiRMEd?=
 =?us-ascii?Q?0iuwezjD6+YGA5440keo+eyasUumqzjgOhIn+/mDCooxVPKvXDuETVi++xAu?=
 =?us-ascii?Q?QcI1P+4KrDhYo69h4mhmPwOR4jUPStaHgMPPqlCiF9CXUgQMTonxkwqLSP7j?=
 =?us-ascii?Q?4eEiElAPUzxZK9feN8H3Jt0OvmQ308EJO+vZ8p+hza3i49yJcRrL9+KCTjxx?=
 =?us-ascii?Q?g8BkjLmCl0t5KZVHBzE3QiDNtqbO30x6uhG9K/E/m9ZmsXU/9SCU8HpcYNf9?=
 =?us-ascii?Q?1FQlm29Usa/GrVAGRAZAQB6cS4QeVL3ZE4wQqOoxwENBLSLAjm75mtJfgQ/Q?=
 =?us-ascii?Q?06DFDwZeqOnBo+pAR8rCj4Iz+5pmDUUZ+NtaoejD6r8YdREYIt6I/DG3QyDg?=
 =?us-ascii?Q?FsAIUNRkeIG3yY4oqal6Lpd4J1Ff8u6KiuLP/VDZRtUJhqNTC4MjFLCaP8TJ?=
 =?us-ascii?Q?bsx7y1k88jE/VTbxiaOcFmYHOh3kaG6EDlSSYdxjiv5EDEC3knJpkHpoiv2W?=
 =?us-ascii?Q?nvSTe8BSdoO3SAiP1H1wTaaunH/X4hFzGxwR0VECJo9vl2G7AoM1kurIvDeo?=
 =?us-ascii?Q?2zfVoZTh7vj5uff5wUwTtzpLhm04lgA3M82LT6DSnK/bmRhvRGUkyyUWLV4o?=
 =?us-ascii?Q?TgDaZkDu7ArmGijHeAtnLms+45BI08LtceJACX2C4w+Cc3qp5SVdMG0wP2ZM?=
 =?us-ascii?Q?kUP09nMkCPYDT+jwmgoX/FF9JSJGGwHz/fUwuVfjXpxMgZQRyBoHBm7gV9e1?=
 =?us-ascii?Q?kOJ63TPTfvjytajq/S+hcpcPXAQ9sdjxjJalfnd0?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5da967d2-e179-4eec-8849-08db7e15b5c2
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 11:39:51.3868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bln/4Ra4CtWYzhGKBtVODk27U3WQYtC4xrwLZU7JMjQNiB8Wg3tfhKIMAXvqwAaNFFh/hwhJlenLVZ/9USCAyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5889
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/mfd/omap-usb-tll.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
index 69cbc2097911..906353735c78 100644
--- a/drivers/mfd/omap-usb-tll.c
+++ b/drivers/mfd/omap-usb-tll.c
@@ -200,15 +200,13 @@ static unsigned ohci_omap3_fslsmode(enum usbhs_omap_port_mode mode)
 static int usbtll_omap_probe(struct platform_device *pdev)
 {
 	struct device				*dev =  &pdev->dev;
-	struct resource				*res;
 	struct usbtll_omap			*tll;
 	void __iomem				*base;
 	int					i, nch, ver;
 
 	dev_dbg(dev, "starting TI HSUSB TLL Controller\n");
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(dev, res);
+	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-- 
2.39.0

