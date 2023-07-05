Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC21747D9C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 08:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjGEGzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 02:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbjGEGym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 02:54:42 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2135.outbound.protection.outlook.com [40.107.215.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2C01BC8;
        Tue,  4 Jul 2023 23:54:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hs9aRLHnAr5nqtR3qwLiV11XDh6DbBD3lb8vHIUA68IoV0bQkg7ajU1A2J1bQQdUTazmID+AQOT1dmjp48pn7uWW5mxhVGk5Eme+vYRw2U9J1y5Q1ug9B9UuP5EM2mLtCMifqxvA/7oFzGeu1XjUCAlNIF5VsN/Qo8rGOIQ40JE6DWH/0gLst9Nm3ogyISEA08vuBxpBq6COIgB+Xi86zfHFfpK7JrG15EmvNZzHyCFjT+ljyatAgZX1mm4UEu2iAcBQ1Kj4Gt1w0vuG/LUAoAG+WEAs5CCaHpPa2zvdCb1feFN8W2aIT/RXV1+GQmuZXRDGgIQblcF622Z+OmgUxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1YP7k137/B2iH9EDvN6Wq3AEvFkUfKevE7BAGGMcdN4=;
 b=gXFgKNfDCp9NHmhq+zsJ5v1TqpuG5E6IvGZ5cx2IYQmewMbyc+yq41Wo6E3XHMZfuheVx/6EPjbLkSNxXO4oLBCkH5o6w1wc4w8oZHGhgjI27xX9lnxTqabXzON+GJfTncUNesLEbnMRBT4TNTVyYx9HnKYbkB/hLzfL8Zm2kujSiRmJQKNpKSm5uhORdHmWbOJ2FDSM6lWc8CyiN5jW2W6lkHDjQuuk0j+GJRYus1eCq7ihFHsI1feiAVz88GWKS8fLSc7mOFd28aZ8rrSlLwVcZpk/k6m2uF3nqVEfNq4eKHR1Jp43iQkyuzZSLN4WYkkrWMQgHBGeAjPQcDcUQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1YP7k137/B2iH9EDvN6Wq3AEvFkUfKevE7BAGGMcdN4=;
 b=mjt+hGbMjhGEeeg8x5SgvG/mN7qBB1R9yeBzY82FiBOEaQmQY30ZdqxTfbuDLLSTwnCDaOfu/PDg5SAcP8c1C1a7RaGshc1lePWRK9Cne+tp5AKwGa535NY/rV8Vy1SuLFZE5oCZDeTGo8Smmf1NwyeIp2zAE2IWowo6pH2ZhBQsJaEF+I695y6sLkHjsJkK8w4ajJFdJZxWWg/QXZVbYXuXBNtgKMth0gryY4P/e2tGz6qGFxN1W4jXLbaEvuL8tDmIy3cuOFBu5jCvIpXZTBFqPNT81pvfaBzS5u/8sXpstTkfUjK7YYr4TTzeAkgLsqEzqaA60ZwO+2K+ZjD83w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4140.apcprd06.prod.outlook.com (2603:1096:4:f1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 06:53:47 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 06:53:47 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/13] clk: socfpga: agilex: Convert to devm_platform_ioremap_resource()
Date:   Wed,  5 Jul 2023 14:53:11 +0800
Message-Id: <20230705065313.67043-11-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230705065313.67043-1-frank.li@vivo.com>
References: <20230705065313.67043-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0196.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::23) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4140:EE_
X-MS-Office365-Filtering-Correlation-Id: 633cd278-5909-4c8d-17c0-08db7d2494d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GcWLqGfHUqaGU4T/hqcfzg8TbyHZx8HtG0tUgNCAI0r5s/eH1qWbPICbNwRWBA4G/DEdrgahNCq/62yRjNhfdfs/J+DZAMxtG/aOxeNgQaqqIsybhEd8d/iS3nWtavgjSBJW0gweHZx/C7bkWKpoNQZ4PtyRzpdkkEvNIz8rw/c1vVw0PixffhovwftNGzxdRGaIM65ZUsRiYpXsWHK+FvKMkPubp8DuJ9/oq45e7h+wzU31bKxwHrNwvGTykG1KcUsxiq+QZESM/8Y2H0wCFhdTcSyupMHGQMBEU34+N1aWpJGOojZt4Fvy2FotWEywmWLt37mMARSDSzNS6mwG/FFjl040d5MjoTOQIUqEFOpQ4F9qgKjASo74IVULsIraX7FaXhoidh0RjIp9gayhsUQPCHPPV7GQ749W8THf8ay7kdW5/0NvX4a9TPk9AWONHyCUih0yKy24g4ueEBeMYI+NOddtSzYC8SRMbUP9jwbFsmg0bIfmP1qHyA/5Cz1XJos2NfBNFjAn2iMYKUFylq9CucHlfivisQwXxESxc3ncH/PxNL9EjoxM0bo40HUPFl1n2/ZIhg/oyjpkJqDr9INhXdFucPfCVNMhHX+Pu1OWLvUIUZL4pXkzezOsQzIl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(396003)(346002)(366004)(451199021)(41300700001)(8936002)(8676002)(110136005)(36756003)(6486002)(4744005)(316002)(5660300002)(2906002)(66476007)(4326008)(66556008)(52116002)(6666004)(478600001)(6512007)(38100700002)(38350700002)(186003)(86362001)(66946007)(2616005)(83380400001)(6506007)(1076003)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jV+FLcIF1FF6KPaQlowEVhW/m2MR48cy1/ymK5Q/RUDftexBJA5DQJjkxZ+y?=
 =?us-ascii?Q?GCuHkKc5Oc2Z99rh//4nYW/uv5G4FvzJU3pBsylKSXZXghhvO2dePSlLLJWR?=
 =?us-ascii?Q?B8LYGieHlGF6RjAPsXPWMOaAWBfNg/C4m/63wesTbwyTkRb38Q1hSfjj0z81?=
 =?us-ascii?Q?7Wi3hTE1SauGEqG66jRxraKrf5ffSi80l8jrOKd8IDsaFdkUtsfieWYNTbvO?=
 =?us-ascii?Q?idxBcnUi4WaPUzCRkxP6dCGxXotP5W3yjCn46uZFj3El7Jl4H+hifnzOK56b?=
 =?us-ascii?Q?0zOA0tEFBcYoGP8SM5TtivmCHjm/47cKWnfwYFmjVDD8cB7N5TEtXhi7l4Z7?=
 =?us-ascii?Q?y0QGlkFO1qsmJ3ltH5vsiu/N0GwpwOJhcjGHLHBbrVG5j1V2itY0R1V49bcZ?=
 =?us-ascii?Q?v1ZmJkHN7rUEedxXZXFftXySnOF9Py4WETajue9qV/RepJRkyzSwcWDlMjep?=
 =?us-ascii?Q?IBZopcsdLa+Azymf/6DFL9T+P8CaveVHXqicaJYKh3HBRrsh/f0qVF6Rfqiv?=
 =?us-ascii?Q?8T+w6YdIfw2SAsGJfRUe5E5EHHothF0WkrrQOniTBVIROk5j/s6rvl159Z/J?=
 =?us-ascii?Q?Ng4NM/qiPX0eaXjJ8sYuQMQ/tuG+278lLXTFAJ+a3pywwXixuazud6bprKh+?=
 =?us-ascii?Q?UMgPGlEgBXVodd87hqNNLll78vV0KfgLe3YmaZyOAqzCtx7zkB2k1ysjBwuD?=
 =?us-ascii?Q?fiW0ibZNhW7uWspDDRPYf+we2qjTVSN7N5uCU8cZMBY3+fTHll/4Fr/tXVpC?=
 =?us-ascii?Q?GjNiB+u7NwcW6uMvMP9hRUfJpjklWGB6cQk2ToqF8lMesrOtps5wK8vbH7mq?=
 =?us-ascii?Q?IXX22br5lHXaTphtKHprOnrkmG/iKAuwGrxGRsHm7A8wOydS9lpr/dqsTfOx?=
 =?us-ascii?Q?RhATF3CEvbJ3X2qqTo2DUA41PFm37Qfb3sSv2F9q1TDmDPfxCc5DiPqfL0+K?=
 =?us-ascii?Q?JUNeEeNjUTaV6W7CRZB0c8CX/69sbc5JN/0xNfjRdOuYA3nys/R3lAc2rcPV?=
 =?us-ascii?Q?gc1StmYrigunKBPF2oAPid6QtfO1Jf/k+e/Kkg30j4rn8/cDHjr/WL3Qu9uH?=
 =?us-ascii?Q?BgFH3y4DSokl/857pOD3+EgOzrMaa/eLq0lto5xzmkGh9rTZSPCG0222gH4r?=
 =?us-ascii?Q?UD7D7vDug3fzZiwMgOHqdW1GD1sNt+GD9j/YiBMcStOWzDHjw6KBtQds83K2?=
 =?us-ascii?Q?MB78R2dVVf41H96kjC2rA98RZWgNy+JobyBzEel6cK6cozDZzzxDRuhy1Z8p?=
 =?us-ascii?Q?lub1W11huZ2RFmLSNou4AbR7OFaKU3nrEWZInOuB9RfbnvdvV3F40xVaLltG?=
 =?us-ascii?Q?ONFM4bRK5OlFYcGrhW3iNc02QJuU7vaYCPiD3unjp5jsD0FHb8q00KcML0Gy?=
 =?us-ascii?Q?zVIL0qavQ/snfDcrqz6aNyvE6WaWKRawUx+VmMesQkFUJWXLsUL1ZnifIEVo?=
 =?us-ascii?Q?Ft9Ivkq5OOJK6tXtstUTtswkX9cffDjbYTPw90RCv4ISEkOy2hrCFGqszMSk?=
 =?us-ascii?Q?Rf2bBt308/zJq6aqCWlUTGiwyWAC9VxMMX1uBJe3vwRC9aCrUxjhh2+E37P/?=
 =?us-ascii?Q?miwvBU/hUbLa3inEKoA8U/Wwa9uVE5W7Jqk6l+l+?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 633cd278-5909-4c8d-17c0-08db7d2494d8
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 06:53:47.4508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c0ZRcj/Hujr3g7P2a9+UN/DcWhLvmk/UHF8xtONdMPbEbcIH/m2I+wZR8VWPsTTZEVrXvWyTuQCcbrU8jw9m3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4140
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
 drivers/clk/socfpga/clk-agilex.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clk/socfpga/clk-agilex.c b/drivers/clk/socfpga/clk-agilex.c
index 74d21bd82710..ece4684a5fd7 100644
--- a/drivers/clk/socfpga/clk-agilex.c
+++ b/drivers/clk/socfpga/clk-agilex.c
@@ -458,12 +458,10 @@ static int agilex_clkmgr_init(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct device *dev = &pdev->dev;
 	struct stratix10_clock_data *clk_data;
-	struct resource *res;
 	void __iomem *base;
 	int i, num_clks;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(dev, res);
+	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-- 
2.39.0

