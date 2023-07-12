Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2392750456
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 12:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbjGLKXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 06:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbjGLKXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 06:23:09 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2131.outbound.protection.outlook.com [40.107.117.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C469C12E;
        Wed, 12 Jul 2023 03:23:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BKgGse3MCJFEg/45dfMif4aUCn+ONlW1YzoyE4nk+HpdA3sVJ11EZZ+n8NrErV3aHbEO6cfVJ6kr4eSdPmE6HTeywpwPQG2z0mZbQhF5q4iRCiNBmbVYcf3+zqTLbEKZ0N7Cn5GzwAudt8CWQbProJc8A3BbLQLVMYG87kfahY6ENGLsQAn/4O519ew11aUnWsLRteqKQeLp6NYa+APvSLttcRiIndfaUj0FMg1wcUh0QtVdJX1N2rVPvrb2Hg4gafmvFYET+F3YJLT/7YkLSwnKNxao6ArS0/xukqs9QUkfMRkOkNm5lMhyFk9F8cbTmOUuHfdt2YvTON7X3EYEOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3yKJ5xKClMyPgWb2EqUpHoY7o8ibMMrpGM4R3iFpu4=;
 b=IjoQRFtor2brYu14KaGFK5q+iYq2o2OFdoHao65M2mML3EI2JnhnrrwopsurEtG9y/bf6aqTK70c39S2cN9VqAlDZzN/ryfclj2HSr0vp8yWrlmjP+mD6Lg3DqjQ/ajDTCxRwGmEJ7Zk2ymuWhq82Xekg26onDvfmIIaoV+a+MaJZyzBEYbrN89NBYXRPQyQ1PtJaQA46808v8qukmNflQ2UiGlsYuKiL2PRLGabs5cq5RjJGg07jEoHs7LQtcod3b2nu+UZWp8VlnQ3sQVtPh/lyGMw86ZU2glgam39vxq15ygE2WfTxBR2nZkpJakdH2dXbWkBpyj4+ml/2W1+5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3yKJ5xKClMyPgWb2EqUpHoY7o8ibMMrpGM4R3iFpu4=;
 b=DoeR1ewbSW03enkU5uERljzxvQX0q1YZtqeeF82/DeF84m8v6JTqceXSZqvZ15ABaHdACAPvtwFRy44lS6OAvohUp2fXjINKbEF3hc16WBh9LD5Tm4ozdGoL9kQRSFaFWUyGmeisYv80OFMrMwj2yPpPBIVSsSrWbNsn7xHbQfhW2/VqNcsEi/Hy9d5arq5lMr/6rhVeww/NgFOdL2kUgCFRZ04NaL0eeonmhE7mSMfpcAm2DJonfZ55HajYftDrdTZI46ZXOD7aVBh+GqcYD5XoyNAdFiSzyBIaeHMhQZbUxpKYlhN/4UUhxQTkGgIRsjYhsXD0YUC6TOUc/KAmxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 PSAPR06MB4213.apcprd06.prod.outlook.com (2603:1096:301:29::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.20; Wed, 12 Jul 2023 10:23:03 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a%6]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 10:23:03 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     Santosh Shilimkar <ssantosh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-kernel@vger.kernel.org (open list:ARM/TEXAS INSTRUMENT KEYSTONE
        CLOCK FRAMEWORK),
        linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK)
Cc:     opensource.kernel@vivo.com, Minjie Du <duminjie@vivo.com>
Subject: [PATCH v1] drivers: clk: keystone: Fix parameter judgment in _of_pll_clk_init()
Date:   Wed, 12 Jul 2023 18:22:46 +0800
Message-Id: <20230712102246.10348-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::18) To SG2PR06MB5288.apcprd06.prod.outlook.com
 (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|PSAPR06MB4213:EE_
X-MS-Office365-Filtering-Correlation-Id: c5be1ed7-acfd-4b9c-7df0-08db82c1f995
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f1dWIQ0EZ+T7KbEKFrfkot5kcVZNkWwYt81WMJ3EJQgz1TXBMmKvC+j6wjXVYn7YBMqIzIYYl4v3+34+J4gQMvmxbtY21bFAPM1sAt8tnN6LYu3bc1jFIzzfWXFBStHYa9B793/Yex4CuSDoRDvprQwEqufYpsURvGVCZNbRTnnRp8l2nbhJROXC2fjzPijTjp7C2xvcvLw1PXAwNY+hQe2vzKBiyC1CugZ2GL6y8qeJ7IodSwDGNkb9N4dSJyvdkJIzmee90sEFjpFwq9rMj/0sZnS1oiucnyq7MzuN7T1a87xsT2LtnazR5kR0l6w40MnPixObX2Q4O+Qs6e+kyQpeDSKwRWbqWV02oeCGlXs5ao+b3uVMW6Efq6RbOORTae06/tsaPsJaSZ0rlHhuWGU/FcHDSAFYSgVVvNgKONRtB3En1KgXi5+WJVHrLUgUc9Ybz1WYCI7rY6Ovnr3NabCfcvdT9vIJn0Mf+db/F4JLazjHMFWqMRvYFpQkMoVIrcDzRtTu16IKx0lz+hlR6CQ/nxdrx9ap0/n/oIabWYPCXt+EV7gpMeQkKI/DC7aTSbVS0vJ1rf/Io66Rf9bA/wDkiQI5NxMjwP7jFbqNjDlYtDjhQS4tFYsH/dSPe0r0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(136003)(376002)(39850400004)(451199021)(36756003)(186003)(4744005)(26005)(5660300002)(2616005)(2906002)(1076003)(6506007)(83380400001)(107886003)(6666004)(478600001)(110136005)(41300700001)(316002)(6512007)(8676002)(8936002)(66476007)(66556008)(66946007)(4326008)(6486002)(52116002)(86362001)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+eZbbSC0m1XJCNWMa0wx0fw/ncXZg3yGoULe3o2In2jjVcDQqJHBgvBtufYr?=
 =?us-ascii?Q?Qu+ROdLIaqjVWJJ0l92yWr1j80CCnvbO4CRmhWQJ3crUAJvp0YVl0FviKrw5?=
 =?us-ascii?Q?yx3P3QCCIW9SLec9i5+Ou35H5aybTw2DmuKOMgyGmoj3kH5CCAfvgYSTlRsb?=
 =?us-ascii?Q?22fmfZLIePsV0qq8ZVjYlansSsBMQ5pavvCR5PUr7Umge01sXKH0SCkuk9QM?=
 =?us-ascii?Q?A/IheU2aBGLotdMhKfsWJFuyA5P5snymZcT+DAlw2+wGSclXrJFl7NCo/szB?=
 =?us-ascii?Q?RxDEuah8zMA3E5QzMFnS8TdID0LodKa50/ho/HPQB5k7HZqTeqIkpcWqGGPw?=
 =?us-ascii?Q?sPx0s2CiDSbD5fX81lQbmX/WV2dqiA47TLGl44VlCkn+r4Vu0CLlmqdikRGL?=
 =?us-ascii?Q?g/xqAmXeGGLg7dg9nQxIsn2fBfQIA4+kDIbqZgk8RCI4sb5qKpfP5TdaJw1h?=
 =?us-ascii?Q?KWMi7ZMqlxGoYXxVxs9lKpTmYba89eR94o20JolpA9jI9U7bxnnqBlsPJ86Q?=
 =?us-ascii?Q?dP7VEh/k9J9FrcyWfajAD7t5XP0qI85pGigMU3nBy6Lk+AqFipZJYGtPzrSL?=
 =?us-ascii?Q?27ht4yck1fVm7B8QsuC9nA5LmsdH9mcn6N9LkpRcoVACeXayi1XODZE5vCg4?=
 =?us-ascii?Q?bo/GPjd20zGii/2nOa/ASVlnVIn2edX2GA26OCJw74teTjLmpLHR8m2rx9Rw?=
 =?us-ascii?Q?xrnSvxuGJcHEd7uXEfneu/r46s2w36sbXPegBbvfTvxe3GxEk/0sBaRd1sSf?=
 =?us-ascii?Q?ArgWIzTrZwbjmX/I6u89Z4BhYLuAu+9C5+D6AW+HnsDnlkicsOJToCZVqTbI?=
 =?us-ascii?Q?W59TmclkMwSLT0A5GwWw2ayTyp3dxvi/KOzb/MHVtXOgj8n9DpA+o6gNj8x3?=
 =?us-ascii?Q?oivM3olkVeKXYg6x4EJjswLQ0v14yGDmeHdLG4gezwEvkkSh/DhhXMs/LO+H?=
 =?us-ascii?Q?AMKsIh6FNgtSQxfWqQNIJVGeRZ6F/ifu5QudawFPsHQ7b2WvVBlsVIeQ3I42?=
 =?us-ascii?Q?F4XhL3bc6txgsdlxTZWfr3VxIZViu3H6GbPNFU23b5USHdejA6nT/yLmlhnM?=
 =?us-ascii?Q?aEHRb7lX3PvzPaogEddpq0KpBS1k6dZ6Bj9P1eE6ieoxtTMqHFukF2iWFbU/?=
 =?us-ascii?Q?UnzLqo8+FluLZyhmsoeChT+PDjiDh3sUh5MOsIWFoTL2ThfHiSitAVZSy8Kj?=
 =?us-ascii?Q?y3nDsdLxXcipBH0s06KneAHgMf8j/sZZevKA1e/TQ/w9vt+hbAeMBFfDexbt?=
 =?us-ascii?Q?ukIIvP9sf5tiO+16MgkMLpWnPEF9Ns9c6SfeLpBpA20kCG67QSLGtr7Ysg0u?=
 =?us-ascii?Q?TOR7Z2gwgQgWqRMFpCG/AiqdEWaTvDq7lUM7rLuBV8vYJBTTx2XKVdoePr0V?=
 =?us-ascii?Q?yyNRghF/sAFg93DBEotsIzNQ5LMMYqG6rPuUk/GfBAnB0mgPD1Ad/Zjr4yEY?=
 =?us-ascii?Q?rV+A0R1cudYdpnz/A37AFmwogySOqMFR6/9Oa0Z65KP9tP9CCU7pOyj30/6i?=
 =?us-ascii?Q?J5JNrgEph9Ki4JAHCDvesbp7slZvsv8ICN7Myr0iQdM5shAWF+LqGvxRv0Sp?=
 =?us-ascii?Q?y+uLEnIEVLIApoFfHJ2odZ0Xd1zjtea5l30Vlqhc?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5be1ed7-acfd-4b9c-7df0-08db82c1f995
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 10:23:03.2199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i29oXt/iq4dS8nihaQkcw3Vk6LSlY06IbRZTdpUubvz0VaWpbu9wYnnoovlNhw4HvQ6zbZEdsq+67y+kvn2k2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4213
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function clk_register_pll() may return NULL(in line 149) or ERR_PTR
(in line 131).
Fix: make IS_ERR_OR_NULL() judge the clk_register_pll() function return.

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 drivers/clk/keystone/pll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/keystone/pll.c b/drivers/clk/keystone/pll.c
index d59a7621b..ee5c72369 100644
--- a/drivers/clk/keystone/pll.c
+++ b/drivers/clk/keystone/pll.c
@@ -209,7 +209,7 @@ static void __init _of_pll_clk_init(struct device_node *node, bool pllctrl)
 	}
 
 	clk = clk_register_pll(NULL, node->name, parent_name, pll_data);
-	if (clk) {
+	if (!IS_ERR_OR_NULL(clk)) {
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
 		return;
 	}
-- 
2.39.0

