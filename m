Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCEB374AE47
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 11:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbjGGJz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 05:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbjGGJzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 05:55:35 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2095.outbound.protection.outlook.com [40.107.215.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1892107;
        Fri,  7 Jul 2023 02:55:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TnDloWQ9shSLG6UjO0RcKwveiiEqHgctgQij5YlK7RZxM2CXHWYJorW+PRPMlnJLYrlldHdP4Lu/MnL7s4Dz5G7YdDlOCQSmoaJrsTz39RA3TmNF8vbxCm59D/eByGka22ZkROOC6F6/HiqfO1YPU9AVVR8pzd4YfRH72UkyOeMoRrV+FnYb9+RdgalQPzZIkzw3Q6gtUcMuygXmn0ps91557Sd+s8UA0eRMDz12OEblYpUMSHFdhfYiI4O4z8XygKPaocpqfczFMa9Xdc2PY0hRmpc9dO6mCHk3ONV6L6hP/wgdYQsVNsnK93GMHe9JP6Kq7PNgB2ImJVL1oU77Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tTBEk3ERPwGYe9e803WybvcvhM/4AUThNLDY/pAo4aw=;
 b=FjnKygDWBJpWHwPqAjONexeP/Pz9jeao43gHgzQMBfmyusxooSII74HQh/OnbH8jYbgqWUlldtFNgtjFsevx4JJTu2QtEfZ6nLq/DV1Rslknjm5DLetNmaQ/i6pfkb62mJ4GOTQBDNRx/8aZrcfX38/62NspjxD25CtcyMpMiVAB38ZpgLCRjCQj2IEP+Wjhy3otd9rHpmdkNoih7httGVgLEeXugaABaOFgoIbeoJFQaruQSbI93tcqtWg53QV4viA5CmIZ10tfo5fRxZyWlV6MaL3g/FcyqhS3zCGpBBVp/imudVuN6IXCRPdszYBg7m2/7UldZE58nDQCkV0QQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTBEk3ERPwGYe9e803WybvcvhM/4AUThNLDY/pAo4aw=;
 b=hYkGR4AgJPeAqjl08baE7NcFYi+gTKKfopWRXBXeKBNXVtl3PBDtbf8Ukh9Ti+xk8hgfh/2bGgPOMc3rt5sQZGYYUBmX2h5006rjNJ19QWbuFBN8Y843Xj4JiZAnORC1+E+VNIvoafVnIZGSyZHsZnegDpEthcDLXgLPPbRd/poUVa0+pZkVdzcN1ZkGl5wMPomtZnEu0duXDnL2B0N5ukuAk8i4tljy/Rwt/xOLihpwqlLrdKg9hn/LOoE39lLIkKs3qD6Ws9G+yuBKR89GqlHOXJye0vkSBDqI2InyztKM3j5Su5QYLg++Eux5Hq7711dPpHzvFDzvst1S1MgxXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYSPR06MB6793.apcprd06.prod.outlook.com (2603:1096:400:473::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 09:55:29 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 09:55:29 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/11] ata: ahci_seattle: Convert to devm_platform_ioremap_resource()
Date:   Fri,  7 Jul 2023 17:55:04 +0800
Message-Id: <20230707095513.64224-2-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 172d321e-a2cc-4e80-08c4-08db7ed04b82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dr5w2Igh6AGggHMbIWqUdTECr0XUsx7FtP5qST5zAP6kVlhbPcV8SB9uoW4S8/XdudrTA6DtJkuPApd/XbOg4Kqllvjer1DwJk72/8o5PRwFeOZ7oT5t/pOq6u/n9n6rfvXBNK5X+wOjEMPnlDCkQ0NRvDAVeD0Js5eh465TZXIODZ2xr8qXEbzlM4GSOMcO5ZoaCVpR+6wN5Kflt8iHMo2E4CVEsPbvYN3Sl0pSU6nFKv1DIhkBHOZsyhcnJh9FG/CtYoMOkjGwgYeORT3vasHqPB1o5Ap1plAvd9DAqGqLzLANV9q1U/G9b4L9kgQvHegQnHGb2RmvNeCy43pS0tjiIxpkO2KF6Yat2Bvb4la55tnw+n42kBRT5Aq1h6wRRYRow/hlF7oMcWLj5DP+WMCQMZFfm4y1lxMIGO2VjzbAnoOvcZIog012t0nTTgwDm34AJFaPggWP5TnNUXJq7WpJ416SeXBs41/dVzjOOU1onq8T13LxjvWOi8qEDDGLvav6Pket2JSx3pXvtn5bNJl4a6EbbomcluKjLXrBK1W3s/i27a1nzknx8b8qrI9hPujlAFqJC8PMIJCEEAJYUpvOdcVpxQMND+3Monf5EI+eHVnRGnaGDvqOVNvGthtc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(451199021)(66556008)(66946007)(66476007)(6916009)(4326008)(2616005)(38100700002)(38350700002)(86362001)(186003)(6506007)(26005)(1076003)(83380400001)(36756003)(52116002)(478600001)(6512007)(6666004)(6486002)(41300700001)(8936002)(8676002)(4744005)(316002)(5660300002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6VVGCb/imcr4vhCOA+oOYF1tloV7cgrMELXVjimlLR6+vmfswcJ61GsPmZTw?=
 =?us-ascii?Q?y9Q/xH3CMIi0hLuQh7DuZkxxHPUMmjIalYqSx6yI3Hu5UEWeKLUKcSL4/GXF?=
 =?us-ascii?Q?Ojl/eP+feYrBJz/9H2yNYcwlQnz4xJ4tXDQjG6h2aMBnqUvIIInYqSZLJcej?=
 =?us-ascii?Q?gknZu9SQ54tqPGCxKGw0IE5XHXLUC/Puh4jINWz2Ow/p0zJCJJhDwmzC74fL?=
 =?us-ascii?Q?Kp+9W2JW060Cfi/E1kf5kUn4JG6svLGzBp1KY+UpWjkV/UR8gS2+le+9RIE/?=
 =?us-ascii?Q?ABKp3a/rMXME+p1b6m+XICiWMjo/2+NBklyxB6GSIyHON7AVuXJKYExAC5JM?=
 =?us-ascii?Q?FCwZjZ3wvVWNt2UPhbjZpSKCl3qmJNJeKePcwy/u3/szrabHUxG0owol08Rr?=
 =?us-ascii?Q?JUY7Q0ruJBN3duwffxcT4vLZkG5ayP5J6OIJm+qAf5u6JiaOTkd/b9HbCWm9?=
 =?us-ascii?Q?UM87USZhoLrqusz9uHlwBRiDAF6tABNW3laB5Vd9LsPPX57RGgwA42J7nqE9?=
 =?us-ascii?Q?m72gnu/dRWs3wAA00riuTT+5XqyjMcL83quchB33yy/f8+WYW0nFe4ddNmal?=
 =?us-ascii?Q?qmA2Fe0w04QG/l1UUnKVw84/h5mKxecwpHxneJUgpKnKMAiyv+ZE+XQvEni7?=
 =?us-ascii?Q?G5a9Kr1T39eRxj9OKn+yWeaVpoH9wbIoQyhDsb3xDthL3JpFhNVnSMffEVIj?=
 =?us-ascii?Q?EldetYkfbcYMMyTFoBzhfDtj9tBk1EjckjfYK9qDBJ3voWRzpMelDK7V0ZYc?=
 =?us-ascii?Q?2d8xGdiUp+ATxf6dQtHy5UyPiBZIri+d4H3sjCIbD9Xgdxn9Maxp0mH+1Yul?=
 =?us-ascii?Q?55ywSdqlfr40sRQB7tCoYCGBa7NEUiavs0V3Subm/YrCYemHsZq2gIeURCyX?=
 =?us-ascii?Q?ebR4CM63r4O4UKVQQYe5qLKaqx0XxKlpi2AptzR5o/DNB6luqoPTLRXIxj5Q?=
 =?us-ascii?Q?7FLVP8wh/Mn6o0xhlhuWi34bEy2sugHDeUo2FwMehHHw6tClg87PVQwkyoGB?=
 =?us-ascii?Q?/MHqV3+xRdjfvq3gyR9h7kF3sGOylQjOPo0qQereryu1FwfCnWp/rYZ1qNkv?=
 =?us-ascii?Q?+4OBl4ThjybPVPk2Lf7FODWg/ty+WKi5b5aqEXpvYt2faMG1zk3POHL5lypk?=
 =?us-ascii?Q?VYdtfgmsVphy+uH8eC8P7K7u9f+9367GxD9OBLtLQmIimkzkbY/lojaywZ/y?=
 =?us-ascii?Q?U/YLpsaRVLtBxEb1iFvoqYVWZMSyEsSZ+WyMZvuiC9Pi7lsrth6xjn4hqOO4?=
 =?us-ascii?Q?kZL/lzpNnwcTt43eX5SU+PB0gJ2yzFKl5pAwOHxJ+MXz/M4R9JpvxuR39Ml3?=
 =?us-ascii?Q?VZ1X0dqYznlJGt3YHjp8bGKG35LWI9Q1h7ljAOVeHJyt1uZyei5cs8Jgpk+t?=
 =?us-ascii?Q?AgAFjres19Uh9Yiqt4qLtPxjPh92as2+nNzB0sO6/NFY08SESIxiqoP3lpxt?=
 =?us-ascii?Q?W/vEMSqrviNkgmOMNzcWlt2uy0x/0Y9MbdObUuOzyvtBiAsZH7x3WZ7bMeMO?=
 =?us-ascii?Q?AyBuvudzTV4VY1Mx2etDVFdpoY6qxbm+BlXzt69wQKnDbnaib79UD6+gKs1a?=
 =?us-ascii?Q?x4qhpIMyESoGS8irHHLKxlnSvpTmT6NcmZRDwVFH?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 172d321e-a2cc-4e80-08c4-08db7ed04b82
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 09:55:29.0137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tLTvu2PqnWjbpEWNbtPp6mqSaSTBjIQhhAPGG9TOzRb5AOUOCGljcw7ggG4NA1AA+EpAWol9e5KPr6l86RPT9g==
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

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/ata/ahci_seattle.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ata/ahci_seattle.c b/drivers/ata/ahci_seattle.c
index 2c32d58c6ae7..a64c9c4704cd 100644
--- a/drivers/ata/ahci_seattle.c
+++ b/drivers/ata/ahci_seattle.c
@@ -132,8 +132,7 @@ static const struct ata_port_info *ahci_seattle_get_port_info(
 	if (!plat_data)
 		return &ahci_port_info;
 
-	plat_data->sgpio_ctrl = devm_ioremap_resource(dev,
-			      platform_get_resource(pdev, IORESOURCE_MEM, 1));
+	plat_data->sgpio_ctrl = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(plat_data->sgpio_ctrl))
 		return &ahci_port_info;
 
-- 
2.39.0

