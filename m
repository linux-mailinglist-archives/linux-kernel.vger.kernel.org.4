Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1234D7457FF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 11:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbjGCJF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 05:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjGCJFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:05:19 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2114.outbound.protection.outlook.com [40.107.117.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF326CA;
        Mon,  3 Jul 2023 02:05:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMFOa0sADL6rTGJzcgutDNMXOPrUxO4bmG9FTLhHQKjSJe1ZNJTqeNAG16ZX69gZcz83/axWQOSGCohKxUml0KbskQ5J3fGCgFi2BxsAFclNAFBjtbv1WRxXHTPxu4awyyIEH4pfRAVlsXciDPdTHyzUYYE19vtyj8pmWYlhGCG7y13geXQ1lybo237ipXxDMaLr3eyZdIof26JtLyfOwSPKo6YY666hUqHgZkvqoFCdwj0y6Wx5uikMV2rIj3h5LEs1iJSCJ7vMHXimjWDKJROvcunoCBMt2ZuQi7l9nRyi266zq9q5kYUx7FEApks7VkMWxvryMamfVnw6BjehjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYGUVywrmxzNO+kWApoSurXTtnHeZ5eGtEzct5L3Y98=;
 b=fVdumqv10ZnD31pIE9sUyTT0gvnpLvWvxguzTohGfYw3b2nKlUbp7Sb+TF6Dl6puxVknLy4kt/w1qUTpSQr6l2NXq7M2NoTv/LM7z9ZQKRPAbDKuRonPt+HgZY/mA9Hdz41WM21j0zXa24Oq8ki62AtevU5d5FVZnuwxwJ4kA0ZmW7hk1DRXFHRCovhRNO/flB65UhXq+zDI5924g73CcNxdMwbWEyPaAN2L6aT8cIpTCGDfkJG8m8F+8p1RK2K8ecUN7ul/3v98xoi4vDiQxLInLLm/gjkYIHBbpInK1HRtMxesp2VqShjM3SODhth2fzBL5cAX1Yybn8S8tv2tYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYGUVywrmxzNO+kWApoSurXTtnHeZ5eGtEzct5L3Y98=;
 b=jafgzI9H/ox1F2MJx5qVPp0JoJaNqqV5LSY3yVW7LOYn32TK0YiMbrA4h0f+DrvGB01939moNMpZsOr2E1nmeW2Zqlj/cZyOFH2vHakHqeUIWlPeksvu4fR9VY7MuRhogq52HuLXSYDzuYJO+PVzidf3tiW1/AgLmdH1PMk48k9NT094uYbYsNDb9udsB/0JtUwas4O1dbSG2zVMoax6JONXwN3dYGQwTfEf0wMdn4cgnckviQVJdJKcF3Zy1C5LjyF4AmSCajNyb/+rpf1nxwYHE/1osmkoYYqvdcyivsQDRhSMMEDFAK+BKO4n8EGRjF8x7KNRnkvJfv4gIIMACw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PUZPR06MB5850.apcprd06.prod.outlook.com (2603:1096:301:fa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 09:05:16 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 09:05:16 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     miquel.raynal@bootlin.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        mmayer@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        florian.fainelli@broadcom.com, tglx@linutronix.de,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        bchihi@baylibre.com, frank.li@vivo.com, wenst@chromium.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 2/5] thermal/drivers/armada: convert to use devm_request_threaded_irq_emsg()
Date:   Mon,  3 Jul 2023 17:04:51 +0800
Message-Id: <20230703090455.62101-3-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230703090455.62101-1-frank.li@vivo.com>
References: <20230703090455.62101-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PUZPR06MB5850:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f992d0f-f8c4-4004-d595-08db7ba49e39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3pF0aBmFlCFjWqbwlIQhWPZwHC8KXI/IRdljHlDcFmWaPlG7tP8/WW70MGruBebBQTehsljs/2idP0CRCoZnmq7im4gg4sEa+dYHfrrLFea++8eLM3fdQ8Yh58JboXjiuJchgj9hG53DJMEng/1o+4RVn5xHu6RdyMLUXnyIdfvicufqZWVpHhEdgxTESjR18Ml2IzyohT4si4Y+b34rBuJpsXEQxwz7toYqfdNYGNTyTemM17EbysONhSvQT8N92bR0rcPU3IyjigHnW8y/pR4uhVhyAGv20k1prlHOeTtPNNxeDGY/pmXNbiqKgIus6CDYk5T7POdZO0nCILhrZjoBHZfKt18NyiN+qL0O4m/M7hRt21PcBZBsPkcpnQaL3UL5chPZgw+U279uMp/aHGnBgV6YPSb2oRGwp8DHoYHeD4WdmAtL1aNTlbnF3NQpPms+GsQIDiskgtzau67tQ7lRHMbPzVg251fqBfJInYC+fxhv1mJn2bBTB0h2HH+rwW4q2oWWgRTMW42tkgcNe0bBdCO2s/o3BcW6gq2BHEf/0kT0VClIvKDxKJGw0UBicOPCcfYzUhBtjuDyOIfD4Pu1owpyXCB/9IhVRt8Mqx5Hiln4+3Bg07jRkPWIZn+C1rWglvlPR6eU/SrQ6hKBXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199021)(2906002)(41300700001)(5660300002)(8676002)(8936002)(7416002)(36756003)(86362001)(186003)(2616005)(478600001)(26005)(6512007)(6506007)(1076003)(6666004)(6486002)(52116002)(316002)(4326008)(66476007)(66556008)(66946007)(38100700002)(38350700002)(921005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aoqqFQqOKKcXj6ZBZp6NpE5OtfQARxNk2UuAyrHzkwSBkMdc2p4jabM6QCOY?=
 =?us-ascii?Q?AeUnSVR4p/LBIIGzunLaquwUjzA2fQoDWsw5GBAYclFlFbVnRymSmQNVccnC?=
 =?us-ascii?Q?MEzALT3Qi5MJoK85ByuyJQ/4LEo9yq0SWV9jOr6M606fBduur39Ct9MyxdW/?=
 =?us-ascii?Q?YzWNKs1BW0kFr3cEUWC51P+i8LG4D8+l7sJQbdUSmwNvA1htuAAmBBx4AfC4?=
 =?us-ascii?Q?2egeRLal99tNSz3kQGhkOm4+SWNT5AEw11+Hpx8ZvVyhO3yh6F6nuuWEJ2+1?=
 =?us-ascii?Q?pp29blzyN+oVMy4cOvuF96Jin5Yz7v4Xqiftxlt1cQ1Ky2OIM/CdC6Cxh+Jn?=
 =?us-ascii?Q?g3ih4lr3Qtk3KuF+nXkCnyNCeXOE9Ew9zO/Q2HbMvamvv23bFe2mnF0suYHu?=
 =?us-ascii?Q?rWasm1G/vml6I2p6VYfx/6iV4lV26EsPV1JdcKahgKjFQ0elmWWlJxtURlQt?=
 =?us-ascii?Q?Vza4vOXBv1g6pv2heMqR6NTKkmcku46xcL+CxvBQNNyioQg7AzXZdEAt2VHP?=
 =?us-ascii?Q?UemthKHoL1LxsaJQxCHyXZDvQ2PqFSdSqn4bx+yutuQIEv7QGZ7TlZrJg9mb?=
 =?us-ascii?Q?rAXNmYnnuE56RbW1Vjs/r9iLjYZouedQ06zZ/LZL2z+zlD1ciHc6Dn/6c15o?=
 =?us-ascii?Q?v2AOEQFSRK6ihKAUYIJJl0I+JSE+nJink75aN1BOgVpuDQY6eYl25UKoWblJ?=
 =?us-ascii?Q?UNnfi5fWf6oZ2bRH3Q+4FRKG+IHxcw2YSXXqghOOOKviTnAS+O9+dtRFCgO7?=
 =?us-ascii?Q?0fbfFN6XBVtWU911QhOovIXgDzETFHlIhGyaDKi0jOPL3iGnWenJPPu5VjKQ?=
 =?us-ascii?Q?/tu5qifI6ESkE7UxypuJ/7pd4G33tINg4J1dB2T+pL6sedks6nJQc0vXSPaM?=
 =?us-ascii?Q?KuGaeoWGyVseEN2ObHq71UQ3c573m1OAB5ElCntaotFjgEX1tFCdA6Ges83i?=
 =?us-ascii?Q?kZjykapvELNVIgDDhAdKCTeCWvCGomzyj4gU27VNsh4+1HO1QT+voHg0V9Ag?=
 =?us-ascii?Q?o24AeSR9VkQtBPGuHuNMb+F/m6ZiUivYvs0QQYgh7MRaMbS6qa0Hj3vNiGjD?=
 =?us-ascii?Q?nYnk3cotmYqUCjKW5R+8VHSKVA6+Rvhgvp/zl1+RAeVzEryXpw/9opt3VYFb?=
 =?us-ascii?Q?Ls2/5KEBSG0O10d9mkD8XKnMjEnLg6wObWOc6gk1ZjqBggMnrGdNZYpuBlQZ?=
 =?us-ascii?Q?QpK1ImuCqVBHbUIs+C9tr5mjUyFhHwZtk4nKG4d+XtE1pjXaAY8eEIcL7xwe?=
 =?us-ascii?Q?BqV1ij57u4F2z9d87rcFGl+SDJLCSvnFSVzfZgMRSig+6r2zy8c4909ZG1Go?=
 =?us-ascii?Q?P9RKXjGe5wenitllYf4bakd3sC4EwoKS1GejvxBn+J8mrz+8uQjRzQ39VNZI?=
 =?us-ascii?Q?cHblhuu0J8wxy14GBuFv18uVcSNhYQHxSkN9juXU8D9KcfR8/xzhADG84f7u?=
 =?us-ascii?Q?6OGDzG/J2F1pgaE4XJhDd4mRLWcafTreIAKPZyJq2mfntwI3bAtkkAH4OZsl?=
 =?us-ascii?Q?hS+3pBVSIgw9nNrWdl08TGNjdBd2yDE6Txxe+nefyZz3IHFCbcuGPOUdjPUN?=
 =?us-ascii?Q?12qFT/aJwNAA/er75p8oQazY30XXk6fn7DSG/hls?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f992d0f-f8c4-4004-d595-08db7ba49e39
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 09:05:16.3937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dZObO4O8x2rUclmcAgKQuQL8xHcnirv4twVGlqw21q5Z5YlkeeNI3PNZSCJoili8A0OvWqui4MNBCZDC2nQUqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5850
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are more than 700 calls to the devm_request_threaded_irq method.
Most drivers only request one interrupt resource, and these error
messages are basically the same. If error messages are printed
everywhere, more than 1000 lines of code can be saved by removing the
msg in the driver.

And tglx point out that:

  If we actually look at the call sites of
  devm_request_threaded_irq() then the vast majority of them print more or
  less lousy error messages. A quick grep/sed/awk/sort/uniq revealed

     519 messages total (there are probably more)

     352 unique messages

     323 unique messages after lower casing

         Those 323 are mostly just variants of the same patterns with
         slight modifications in formatting and information provided.

     186 of these messages do not deliver any useful information,
         e.g. "no irq", "

     The most useful one of all is: "could request wakeup irq: %d"

  So there is certainly an argument to be made that this particular
  function should print a well formatted and informative error message.

  It's not a general allocator like kmalloc(). It's specialized and in the
  vast majority of cases failing to request the interrupt causes the
  device probe to fail. So having proper and consistent information why
  the device cannot be used _is_ useful.

Let's use devm_request_threaded_irq_emsg(), which ensure that all error
handling branches print error information. In this way, when this function
fails, the upper-layer functions can directly return an error code without
missing debugging information. Otherwise, the error message will be
printed redundantly or missing.

Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/thermal/armada_thermal.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 9f6dc4fc9112..a5e140643f00 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -913,15 +913,12 @@ static int armada_thermal_probe(struct platform_device *pdev)
 
 	/* The overheat interrupt feature is not mandatory */
 	if (irq > 0) {
-		ret = devm_request_threaded_irq(&pdev->dev, irq,
-						armada_overheat_isr,
-						armada_overheat_isr_thread,
-						0, NULL, priv);
-		if (ret) {
-			dev_err(&pdev->dev, "Cannot request threaded IRQ %d\n",
-				irq);
+		ret = devm_request_threaded_irq_emsg(&pdev->dev, irq,
+						     armada_overheat_isr,
+						     armada_overheat_isr_thread,
+						     0, NULL, priv, NULL);
+		if (ret)
 			return ret;
-		}
 	}
 
 	/*
-- 
2.39.0

