Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6619C74FF59
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 08:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjGLGcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 02:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbjGLGb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 02:31:29 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2131.outbound.protection.outlook.com [40.107.117.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76291FD3;
        Tue, 11 Jul 2023 23:30:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DkO0Hai9eqZsshLSvQzgpn2VOozo2gwTcqudFq2l7Q2TfU0DLh/Bg9XMIzhqh2ZnwzgpWLK62laW6u8nYXuMaaAKNltW4u7mGPHF+zSQRa6XLWWE/n0UUYeSRFn6sJJ+cTQ/MpzMZC4p/+sBW6hwibUNRlomFFnO/V0UKGh6kG8GYjagwOeEbLY75lVxE0fi/JKb1Kf/+XtGWw6yFFuHOLL3Lo68JZAJQgOOzS8Otz5VZx3WbLpH8db9ANqW8grZt2mHq/SmWRNln7q0wiRjge3p5G1bSCZq3ogYbW6pH0aDH/AojUxNNSPTe9qQzMS2EfdogG3mPdaU5TbvtWIcTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7BY+yXNNQyQNKuIDWMiQfGqD2yhadOq2kmjdUW5/5p0=;
 b=RLJRnQFn56/Jf0Pp566tKHzBM1ORMyUehrjgeaOXuUCSahUbsRkrVMZ54SqClZWQ7mlFmEf+w9jNktFbp6R2JJ7TGybnr6INLPlK2q2Zk6A/uaHF03E7uWw2k4PekqQJRwI3ErEdKPA505o2pVzBQerLwBUQyyIxXZMadhUcZqtYp7WXUQB3yAaZrj//B4UbSvpmly49gZLcyMRBTVGgfqZp87Xper6S7i3YPDB8ktuTJnqfg86iZM9TqNGfLJEp6Ey68V31jSldk6oIVG0K1TO4KMW7wPsHvGShBcYdm4LuONruDDrYy3rrra3IuVJcVAjTZEFR922sU21kk6jM9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7BY+yXNNQyQNKuIDWMiQfGqD2yhadOq2kmjdUW5/5p0=;
 b=lBbIAhqMO7ptPN9tbqJNoFMY8Fs4sz1aKwAoh9v7qDF96KT2oOYVdBTzXe5fvR5gxfz8VO+uWLDgWEAv/HXCMvNElCXTRmcSbfdDbw/ivh+ucOSTyrxOWLea3BoTx9tzcDlp4poA5nFBBPmyrSbWLf4H6DH2JwFAA6OPziVSmjx3aMr2p2PZrc2YonU3mBS+1RKkOoWf2BAX3xVhn+y5L96o5uVJ4yqh+ONcIzfHTnA9+h2RD5wBb3ksGRkNocg9pcHmVdp0xx950R5gtj1lFk7l85c0k2wynXv7y0vVciinc7wLDxxvJwTPvgbVFLeaToOLN1Zhw+Ur+USW55q4Qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB3963.apcprd06.prod.outlook.com (2603:1096:4:f2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Wed, 12 Jul
 2023 06:29:31 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 06:29:31 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/15] serial: mvebu-uart: Use devm_platform_get_and_ioremap_resource()
Date:   Wed, 12 Jul 2023 14:28:50 +0800
Message-Id: <20230712062853.11007-12-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230712062853.11007-1-frank.li@vivo.com>
References: <20230712062853.11007-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::20) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB3963:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d625185-8f50-469e-d3af-08db82a159c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RETuC5PwDf2Pp1SMt30jGnAApzvqtCAN0IQmBnqqBaJrZQy9SsN5PJEFbGmqqVn2X6KbBRCNm4N/lKiJe1NdJSBSo7P+fdgDd3hcyQGG2Ihs7SYpxikCjlnoDGBgpKORByJNHZtpZuXsQSG3LWV2MAcJ+C2za1FebDGg35h3i7qNkyoUCWlqNQQPdOToGETfvq27gRfjVa1eA6usfiOMXgpyLzRBBquc0PDtYfeAPQ1VI+wfFvUP6OJ7vty3rTRs6ZWVtIhYugMK7EgrOYQ8YKJG4Hobl86l55w3oFugH8g0DXLchsT49exNgA6PYm9AUH2uIgIhq1nTHgWTxPWYNrI7NGqdzrTxfcD4hciwJVzgx0H6vNdPz3uXMaQHA+nNEVpgmK8/5Lp0a82vF9DPIWbWObtUqgmG/jJ1WxVmamOotvBjlVGB4XOfrX7s+21d4yPBh1BrRRYyyntLb+48xW+9fEe8CYJgSBfbrWy1BBSq/+CIT+RDsGCA8cj3XM33DGmwETWJ0f+mvai6P2fiDOSisLZjcpdZGtcCWD4sC1f8D+gKp+jJ0+pgct0hRiiAekY83EzNs0E+VBSamCvQpD9PwM7WlC3hOAgDx2G7uBx5nX/UuEQfZKLnMDtkLPbP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(451199021)(41300700001)(316002)(8676002)(8936002)(6512007)(478600001)(110136005)(52116002)(66476007)(66556008)(6486002)(4326008)(66946007)(83380400001)(1076003)(6506007)(6666004)(38100700002)(38350700002)(86362001)(36756003)(2906002)(26005)(5660300002)(2616005)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bj6nxAqvq20DW9eq4C+URLzN643yISItHGGIHI7Q5aKWhAFmiPS8Vu8Glpd3?=
 =?us-ascii?Q?0unhaZa7J8bat8gup63z+mmw4A3vOvkMv4fQ5BJFlFt/ykBgRAOEW71Uazrq?=
 =?us-ascii?Q?zUG2hLW1iIAMZNm0d/oMh3C6bZGEnfhrH9mngZrTVmOVjgtAxjctpGjOh9jY?=
 =?us-ascii?Q?Dx71qX2P2J2jXG0PTIda/0RalnSZg1xlnvgfYke22qO0GwWmUKBuLgHDIqQ4?=
 =?us-ascii?Q?AHA46THJ87J0OqHmbpK+QhGAnIQVz7pQ1+Vz21hXVoZgXpkH07vFwJG6nH79?=
 =?us-ascii?Q?jzCc8ALIY8nk8So4/dPmjM6EIjP0wlS0z7jl2NKeuowXkEgjXSr8rUeIJe9p?=
 =?us-ascii?Q?lq+d1I3NA04Gy5wZSg0rwc60yw5tNAvJXpVGueyqfAcnTqaLIE0Qs1lyMGDF?=
 =?us-ascii?Q?an68aCo3d962e+1u+lQFaxZecpfzeyvPkMlU41HBCLs+C5YJDK3d4XTuRfS4?=
 =?us-ascii?Q?/kxIwOpiAyU9Liljxg4yzsIrO6qfx8RYgRaJ6JQhfW0rMv6LNE8kO5RpZ8XE?=
 =?us-ascii?Q?YF0jrahmw/qA8pt81dQ4+av8Ev+eEPnQkEpiviDzje7qCRVclx0FxbnK01hz?=
 =?us-ascii?Q?8tO8i38X0vfC6Pbd01/pRRCIiLLnxa4BgFsrZ27Bslsy5RexwV2wMnzpLlfD?=
 =?us-ascii?Q?oVhzvZggnFLKhZFWp2YIWOogxsid90XYzkRVxijvJyfhcUuQ4xxPaRmwNdhN?=
 =?us-ascii?Q?YUx+RkmeEOFJxL6i6LWZeTWVtX9tTLXnQtIGWEOyRemPiKmewi99T579bgsm?=
 =?us-ascii?Q?QkizQytoymUn9DqlaYU0QEkhmAV2hEuf46fHFnTQ5yLMwjQxcDO3T8k/xi1R?=
 =?us-ascii?Q?2DYXEBzuG5AsxbhnBEjTC1ZcI5T0V4Jf7+6saqvmS7c3lCNfbjKDmF5UWNB9?=
 =?us-ascii?Q?lEV4DVjJoqS3ep7fygCNbXo8PmSsf+JVwfYrYjfYMpxPuyLOOhjcWBK3r/Yi?=
 =?us-ascii?Q?z4RiRmlla/HFmjr3NTr+xK1IldWVkkmeEoAmxEhWFGNf+UFjrjjX8ffHNTDl?=
 =?us-ascii?Q?eATIUbv086tOkOpNVPNJhjCswOVzCvdapLZ7FnANeQ8fsdZWOErIDS8z9ctH?=
 =?us-ascii?Q?LAZr9jHxSPhoKNeEDuGyeJYy5Llu7nSO+MuozJ5w8IYgZRWgQ+rLjqrMTnGq?=
 =?us-ascii?Q?p3t7NI0Q3GExeybtGloCiahUpVDSNZL8mPN+ZRUrHJatWp+ckbWA0TldLSQl?=
 =?us-ascii?Q?FzZyMTBh1S2P0NT0iHNa7X41iszyFdbZZcEqpDoVzEPvF7LOUYRxowj/iS8G?=
 =?us-ascii?Q?6YcaU1rl+RKEdO4pbamTt0t6/h6s+/fTb4odUxF3iBD9PgHACVSXN6Bay3Ea?=
 =?us-ascii?Q?JLLkbQMKrq597Izy6T7O1v/EkYvZrNsEL/rbECuMSRO5hI8v8kaeXwWZDbM3?=
 =?us-ascii?Q?dTCpl/XDfAEiIdGZHeS5DFzg7M6eILF0L4Gwjp6WMd5XITFxJ16dF2EvYGGA?=
 =?us-ascii?Q?nvI8TRvGZCRPKPAxotB1OdsSroZhCWre9gbQaY303YYhQCj1FJ6gR4Tr0iji?=
 =?us-ascii?Q?FJgm7XDon4xdWNL3cOZXknFsBQuHIlQ9cVGK4Syr+YnT8n7bZE3tSBHG+S41?=
 =?us-ascii?Q?+VarZK4UZuVHBr0x9FPOg203MEszT8tsHXxrJp23?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d625185-8f50-469e-d3af-08db82a159c4
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 06:29:31.2129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fsmMx3AgwBkf/yUttMPJVA8A5O8oIBbWwH38SOnzirVFcnEEjviJPDLtTLMJVaKAPF7Uv54Xgg4DuRaHyWZkUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB3963
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/tty/serial/mvebu-uart.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index 31f739c7a08b..ea924e9b913b 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -876,18 +876,13 @@ static int uart_num_counter;
 
 static int mvebu_uart_probe(struct platform_device *pdev)
 {
-	struct resource *reg = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	const struct of_device_id *match = of_match_device(mvebu_uart_of_match,
 							   &pdev->dev);
 	struct uart_port *port;
 	struct mvebu_uart *mvuart;
+	struct resource *reg;
 	int id, irq;
 
-	if (!reg) {
-		dev_err(&pdev->dev, "no registers defined\n");
-		return -EINVAL;
-	}
-
 	/* Assume that all UART ports have a DT alias or none has */
 	id = of_alias_get_id(pdev->dev.of_node, "serial");
 	if (!pdev->dev.of_node || id < 0)
@@ -922,11 +917,11 @@ static int mvebu_uart_probe(struct platform_device *pdev)
 	 */
 	port->irq        = 0;
 	port->irqflags   = 0;
-	port->mapbase    = reg->start;
 
-	port->membase = devm_ioremap_resource(&pdev->dev, reg);
+	port->membase = devm_platform_get_and_ioremap_resource(pdev, 0, &reg);
 	if (IS_ERR(port->membase))
 		return PTR_ERR(port->membase);
+	port->mapbase    = reg->start;
 
 	mvuart = devm_kzalloc(&pdev->dev, sizeof(struct mvebu_uart),
 			      GFP_KERNEL);
-- 
2.39.0

