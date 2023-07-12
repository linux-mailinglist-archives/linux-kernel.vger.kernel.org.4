Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D5874FF58
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 08:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjGLGb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 02:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbjGLGbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 02:31:10 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2106.outbound.protection.outlook.com [40.107.117.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02E326BB;
        Tue, 11 Jul 2023 23:30:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XeTcBwUcOqLWDixtCmVeLjRPuHSmRUjs9DgjbqzO4IzHL2X5+QPqreZ1Op3Pba2Tk1pRnfYfmJgJhnnURQ/owI7clkHIXmyeDbwzcLsi8Hdp0Ro0oYeHtKMaz6vTPoH9hGQ2jXjiaPZqHfl5iB78El3XNGa2jv5qNBIXs15Fc1boWKZSosWySZ4UGM1oF3kqrZ5qvWY30PgeEzvMDDIp3kRQAmcWENM/VzGVbHEydoS4GxsIhQ9pugKJwdP2Y/Y0BTp+PX7TdZXy54VN3L5ImEUZskESmLiUXzu/X5zYz0yo7s2TFajId0d88Qqmg4u6kx/4JgL6XbaPDAgRkSJM7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L50JRKFfh+EuPnMI1AHbtb790FfijLhRLUMWGF2EAd8=;
 b=hI7VRbBf4Sp7wwAsxw0NEHOrQVYDh5DrUE+ckcTsHP5UVAM8iamZNAFEpst5e4AkE65ikj3AYHSQbVcYoAI3rgqgVajf+63WhtBbRLjZCQEAQxqcvTwzwGNfe/ZwbljOxDU7OKokoIuRLROBBcINBmcWphiZJSMRhYkhkptoy0opc4bEchyN0t8rKEg0bR3EDBwdh85GA50X19yekEcisaPcRBTO09vRO/CJ4lv4LP+JoMNRSH7bX2Q///1sghJPjQ1ZmDXRsGFE7KeNqXyaNhIXF3OLHuJV2IpPhkx5SyIUYqNl+xG9vFLB3nKFW5u+hnmt/q7vYsgKTPMNnPBzgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L50JRKFfh+EuPnMI1AHbtb790FfijLhRLUMWGF2EAd8=;
 b=mwucXTE1LU+w0FzzqKZACe2OU2LhIRHf3puNAo5SI68nJSYHsWvPOsxOntr6FcuuIJ1ORrHEcEcp5Ulu3oiiOCY9VFnsUCXKztJZZrTLQo0WRMM38zULMAzVco5RMruoCAWF+VeFKwpzg1BcVnumtgS4HdyO5uX0RpRnNKeVim71qsFRgyg4E5RubNnAzSpwqHYX4dZeLL2mu7pn8bzinHdtyk5qnLqPtJhPYoAbujJ7UPvPcjDCF2iieL1Romk0NhWvtNld0mT9An+9XLeUJCXmbbUghNgfgaOQFq07tTm0ia0Vyx5c5ZrRviB/bjMDiSq8RtjohCGYaHlSpql2tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB3963.apcprd06.prod.outlook.com (2603:1096:4:f2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Wed, 12 Jul
 2023 06:29:29 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 06:29:29 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/15] serial: sccnxp: Use devm_platform_get_and_ioremap_resource()
Date:   Wed, 12 Jul 2023 14:28:49 +0800
Message-Id: <20230712062853.11007-11-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 58a7f62b-9376-4e85-f113-08db82a1588e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 058FRvsYPVk8zPnwE+w+LJ2wbq2ezYRDpawihnVPL9InRmZzJ3iWKwj64DgN2y+Sf8eZR4rnSsb0nIb4FP2+WGhPDWPTlTq5g3XeHSksNTqVgYRvFVu6gddUS31dTZXeGuMdAEuCmcqAUnLa6CX3umsEN77BVAourZVbIFS+6K/ykq5fqPNiQUovwueZjA9/Prv6e9EzPHhIFZKHCjHAkH0xL1Ee1ZuvhNY8yKn9mCKa9bo2tPh0awg5aERz7IynjTt0BSC21wxNgPyNfEr9xyk2YRZ1LoAB12wgT89eTraNek3zRwv66Ks2cBL2N2yAOitXnjJni5AY8LuJ9iRApycL/9yUXISdzJZ1tiKGyJj56fjnPN5m3XmQ5aPbFm+SGFnKfy3tygjlXCNTD/iZ7Z1c9DojBapOfe0B776XQDiUqr9nwZXsoXZ92Tin88KjjZqt1Y20udPeGytI2ojUidfeCR/BE7b7o1IDPOHcjSNnJvAhNfdgS+uZDeA2DM0ULO4b+CrLRqp58cGWcErV0VqI6sLEoj7LoxgRNy2E1n/ndKy4F0yJ18Yfrm4sjoiof0yEhlB2zxSbR7+YHaqD3XxJPv8ktV7UXg9OUJi6u6ROUXyZeWmYdNANoQ+KuFbq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(451199021)(41300700001)(316002)(8676002)(8936002)(6512007)(478600001)(110136005)(52116002)(66476007)(66556008)(6486002)(4326008)(66946007)(83380400001)(1076003)(6506007)(6666004)(38100700002)(38350700002)(86362001)(36756003)(2906002)(26005)(5660300002)(2616005)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?12f/8HOEdKbA04BS2fjh+177QNn8hcQGoInkdadmp7HX4sQka0g7bqF5M7IS?=
 =?us-ascii?Q?UtzqNJlQz98pAYRKXoNr43QGuk7qxypXnRRzRal8gnlEJjKox4+VjekHxa0W?=
 =?us-ascii?Q?pMlvNmVZ8ZDCo7S/o4fmJhpFBmbnVqx14asWPQIZaQs7ShpVQdDQj3ih1K6h?=
 =?us-ascii?Q?oIZ2z/Qw/h4G6KMAdKQLiFvJB+rcaGpF6JdHPtsxFIMkBgQqL6yL9v//jCHK?=
 =?us-ascii?Q?RzOM7mGL8ClImop7E5yq3JFJeIYuseBsRBdAzNv2xUe8syCniRL3M4QNMAyH?=
 =?us-ascii?Q?w3bxE7PXc5Z7hqhE2jPdE6cq0nYdOQl0L1MDoCJB949ctosZheScwfZ5XGR7?=
 =?us-ascii?Q?t21fhaKcJjL8cakUtIfJ3VzrmeXBEls56UeD7L+lZVTx+l22T83i5aBF4CxY?=
 =?us-ascii?Q?VlL4oTCLcT6aC/ZZ32AsmKjfJgZlIbe111dTPL96+7F++4dUjNqmIzxRGZU8?=
 =?us-ascii?Q?449G4fVv0hWozYPlbBKNFqDKtCrUexoJIzwE241T0Y8Cibqkh3rGPWakyDdf?=
 =?us-ascii?Q?0IkglEeRVTFonuuvJEIoiXQPfZE+XGmv7zit+aquplEThIaqml/t/gKk17/A?=
 =?us-ascii?Q?meyayaYHo6Bj+tbHkj0bYTadMqQj60/Ri3BrRy5ZBsRFZ6/Cn5GxspdXDFu7?=
 =?us-ascii?Q?vPFfVTS1GEQ3VZiYNMZcijn2bB4L9zvgNBp7MdABB1GEFc1qPMXXb+nZmVFB?=
 =?us-ascii?Q?o+ARtZP83li23pC+k5G7XLyA2zq0ENOWpjbGjaIFThc5xmqCdGDP85rLI9xP?=
 =?us-ascii?Q?vvSVTnH/0qanJXqsknOEABi8p/JfQPAK/rQnOn3rcNJB5HVZmJ0prL8nqEKE?=
 =?us-ascii?Q?Kip9DzL90djld/VnoRerdofLTkspC3YQAIlyFntG30SjJAHxa9DmFONm9sIZ?=
 =?us-ascii?Q?oBYNYrylHJPbBU7rmqywl6tQL49ufPTHjwlEQpXNPyemu/mDFM01a3e/p7OP?=
 =?us-ascii?Q?M6BmslLS00UK1vXALvMFv9oZ1wHowhRuFUL0+GuutQhPxRZNVwtbCkaZ8a4o?=
 =?us-ascii?Q?xa8zssXy6q0vW0jjT2mwxLscWb8zz59YGiITm32wBzQWjdBn5Ol42S+7mtUu?=
 =?us-ascii?Q?UUIRmF7BtKUJf1T/yYq+O67mask8UObS66q5fQIXs2HdB44cWtN65MVMOScq?=
 =?us-ascii?Q?vGTkXhhQBtbrwgrsWReUyJojRAcVfsOSrHNdOvVwV+0K7iey/4bGYI4x9TsA?=
 =?us-ascii?Q?VCFnbGWQQANk6fmWUCmYf6/495S5CKFAlP2axhUXkbJ+V6ABkSNDcjyzcxdg?=
 =?us-ascii?Q?TyPA97NjLKrgqlfGEDsAZkke0XgCe4FXT/q6c8Ma4hggU1K5TpLI5N1adIYA?=
 =?us-ascii?Q?eXZMzwAFAZRCzfygJvpkXxmrZWNE1/H6C6Q9+pGR9pLYL4y6klVZPGrfyS2U?=
 =?us-ascii?Q?dpUQeVu0SXjh/Ru5QON8ZALDNv4MN3RYWoNRCUEbT+ZvHBLUoR0+wR29To1K?=
 =?us-ascii?Q?nrrJ6NLkHxCff7OBvT8/am8fbbzFBxfq4zOU8YFA605UYo2kD5F5k6b6qKPJ?=
 =?us-ascii?Q?Qs6oZuPA+8UxFijZ5bUjLVDiKKww81BsCcTFIE6dDpN/EAlK4Yqs3Y/2NeEM?=
 =?us-ascii?Q?NY1QZRvVj5KQQOuCZ862iWShswMsTnQE+KLr3WQj?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58a7f62b-9376-4e85-f113-08db82a1588e
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 06:29:29.2382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /CjXs3+4HmoUoR8RJMFy1hpZHVuUZEiVEnh+7ufPt2IkQNMpsIoPW9Y+/6j5shf1W9E0ykHSyIXOYhPshWl36Q==
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
 drivers/tty/serial/sccnxp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sccnxp.c b/drivers/tty/serial/sccnxp.c
index 4f2fc5f7bb19..d0f571a4edbf 100644
--- a/drivers/tty/serial/sccnxp.c
+++ b/drivers/tty/serial/sccnxp.c
@@ -880,14 +880,14 @@ MODULE_DEVICE_TABLE(platform, sccnxp_id_table);
 
 static int sccnxp_probe(struct platform_device *pdev)
 {
-	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	struct sccnxp_pdata *pdata = dev_get_platdata(&pdev->dev);
+	struct resource *res;
 	int i, ret, uartclk;
 	struct sccnxp_port *s;
 	void __iomem *membase;
 	struct clk *clk;
 
-	membase = devm_ioremap_resource(&pdev->dev, res);
+	membase = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(membase))
 		return PTR_ERR(membase);
 
-- 
2.39.0

