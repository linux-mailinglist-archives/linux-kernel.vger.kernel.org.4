Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C78569A5D4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 07:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjBQGyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 01:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjBQGyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 01:54:17 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2041.outbound.protection.outlook.com [40.107.7.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4D05D3E7;
        Thu, 16 Feb 2023 22:53:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NTdxHGwV5Xej6VSCQf+q6+4ibNMqSo/QQ4tPQ8DvdtLExKA4KuXgkdbHHtKieIc5AT/cg5oVZl2CuKGboc8cCzSSeIc31ZinAfQ151gM5bRBTiIb99RH9J9us0ohnMkqQpVobGF8oflkwlUwGkB58CckFwvFLJGhvKWwIMdCKumTJuJ4eNVjUJnldP3h9fIqJREJK//ltRnUqWDDrTrTXeao73uyIJY8VZodB/V6gzGgyjhNTipSdioeq939KgUZo6Q3vSePNUVGx5ETtkFb3MOUXMxOVXGqrhasnHkApDOFNtmkj2skF8Xuf5eKtNfbLbO/9ECQIsCviJSgLVD06A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LlUrH3hpx3rLt+nYA/CYaT8zoKu2SwrLq4NRHDueueg=;
 b=ZLZW4qbGP9PHD5iDvUkoHpJTf2UHG73hDbA4xMVOrtYbbkVs86TVvQqfN0xInqu9ghJJKfRdoxtlCMbhK74FgNBmAKIKv7kN2UpZUOj9SLX6YONXnvZmfVz0WEFrmSrNKErlwKr4YcpP1NNcSqdgxrNPzG2cb95PCb+qCYniaxOSgTNlkCrVPZkzyQngpPCZc9LpWX29PxwW7/BbZ/Q1/Ar3WeiL/1v8jh/ARwNPMXy0TKCEnEgSR40MkDIzAioFWVA1lVa0PBTR1RYa80PRa6eAgHG7a96QUMbkPq2G0gni86Qw9iO6ueiF3tj5jjXuaSWq0+v73uYYi6knrX6lXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LlUrH3hpx3rLt+nYA/CYaT8zoKu2SwrLq4NRHDueueg=;
 b=bxWLBjfXAOWHkqnvx1GZpQPu1m3wdDqc0yXuUeBLThIMHTKo4wjcYXnJoEnqHAhflChJYYuaGMYQh5cjzm+xKjNdSDlrHPAPLNn6q3V2UU2KZs490St51iomA/XzJ2ShzSMYnRbMmhxE4gJdLFvz6qeq0MZis+TtdMN1YxI5WZc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AM7PR04MB6840.eurprd04.prod.outlook.com (2603:10a6:20b:10f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Fri, 17 Feb
 2023 06:53:35 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::5725:92ec:f43e:f5fc]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::5725:92ec:f43e:f5fc%9]) with mapi id 15.20.6111.014; Fri, 17 Feb 2023
 06:53:35 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     marex@denx.de, stefan@agner.ch, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        krzysztof.kozlowski@linaro.org, LW@karo-electronics.de,
        alexander.stein@ew.tq-group.com
Subject: [PATCH v4 6/6] drm: lcdif: Add i.MX93 LCDIF compatible string
Date:   Fri, 17 Feb 2023 14:54:07 +0800
Message-Id: <20230217065407.2259731-7-victor.liu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230217065407.2259731-1-victor.liu@nxp.com>
References: <20230217065407.2259731-1-victor.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:195::20) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|AM7PR04MB6840:EE_
X-MS-Office365-Filtering-Correlation-Id: 7af8050f-fbe6-4c90-4b90-08db10b3b05d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oRV7WFTzAoOfma5MzY6UO2i/a3SPJwidpKCGYg/WoqeZkUFx7Bd1CRDE9iq3titjcgovgt+Le8uXd756oKLAR3hmsHUQQBpW9Xw8zPSmWDyTcYPUJZ2v4Aj48Pac7fc0CxQ/ZLP1iiiwpG5B9EMCxhZvf+LauA3eFW5W1QeQ5IgERPsni90PjgLSdyvTJ0y3fbkqW90Oqmyou9yMaJTh9OvTonTpVO4O/RklmK09tNoEUxsw+pRGGhmYPCnIh+tNvANzhXiF+FAFVlYG4MOXQbGYjViTPhubIUUdAM8fosUDfPE7GXulSMcztIAqIpVKtwCmM5zSXqo04aKpYaUumS/QMaiTx27DxKZv3Xhk6a2+JxeJg94L7nsHdeH5JsJU0+7XArcAn3DACz6lvbSd21VkLPuWn5cgG87T/gPd0KQxdVEwEenT3vxWhjkSAtpGsDcIqABK8bslodREQz34dMQI5HVmK4PiN/RN7EXmZWZKKjF4I3onvSU1fAoCFmYtSWzA9s5A3vB/Vdq5vmrEMVW2nNeirkuXuOA2FqMyhvgavTtS+IfYwaBVOQ76VnAW/AtmvFreOD8VptmlUPfW7qqkULQuEr/ioPGglMkrPli5Jh4D/yNcnJ6tHt3tDDnnp+a47VS8Mg379963pG7/WBvSOwN7JGtVc4KkDYUvgUxiafLG4PWC02zR2m6UrAyDdh6oYcVIVkwgLPayB8ecJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(451199018)(36756003)(66946007)(4326008)(8676002)(2906002)(66476007)(66556008)(7416002)(38350700002)(38100700002)(478600001)(1076003)(6486002)(41300700001)(52116002)(316002)(6506007)(6666004)(5660300002)(86362001)(8936002)(83380400001)(26005)(186003)(2616005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C62RbMy4+fbJ5whwQqtMni3bgGrqJTJYX+1KUlzcNgwAxooOKcfNiL85t2/T?=
 =?us-ascii?Q?/NoghXNCKcHLk3KEibHdpGVJRtWrSfDBYLJrwXvd41qIVGwY6URiKdcBuLmG?=
 =?us-ascii?Q?NINsJT2V36I5vJjY1U4dyjCwLwRByqg1muMmmKJQqZmXXT2rpLQA5GNloMtj?=
 =?us-ascii?Q?AuMKCGJZe14vVgZhqdfFnsg7zCfOjGmc9aw+8NO11km2V1Wha/j0+CpsPiDj?=
 =?us-ascii?Q?+TWXaRDP2rUNrvNhkgAJUpM+/FJLzWzyy1xyvuQlPOTJcg0X0RXwMcjDwMTF?=
 =?us-ascii?Q?1t1mJb/6+BoBN5S5CULPAtRkiLoNQSKHcxyzXQlrGV+ipEfJ2vSkK51YgSLB?=
 =?us-ascii?Q?yTdLBjnvNRbAkMsBwTJiLSnZLE+B4qLZuXzMS8NSKH6/yZTs9NRG789k+P99?=
 =?us-ascii?Q?70xzTixB3a4OXFP4lAeghbGsZwpvBUHt5pRteesNL+X6hEZaOBum3BN7xFFw?=
 =?us-ascii?Q?Pn5DDiBz/aXZ5Sea28uk7e3wVZ5djlRKXO+XV9Z6gqxcFOmqW4VMsDSSmTvI?=
 =?us-ascii?Q?eehUmr60tz/1/O882zkDoqAcQ1cBOSkhTCLX3oqOyDbV4jpVIoe1i56xUwKT?=
 =?us-ascii?Q?6BKTwGIZhVVc+T4A74VibH3b1QFPrGQbqbqd1i16qDnbKqfCIvUL7b0sB3LM?=
 =?us-ascii?Q?n4N8UXAsQVExYI98sfCbi9Y3qyWcXEgvdwXrvCl5s2Ek6KmWGELP3yYt+z96?=
 =?us-ascii?Q?thdUkJuBmwC2z/j5Dn579hiFRCq9wBdrRL/jDURxgELu6ULMknFInsr/j2aH?=
 =?us-ascii?Q?K76hqPxf7/HSBdb2cIOCEvZvOKjjFuQv4KBU9aZpd8FEYAXE6ihETRMwJr+Q?=
 =?us-ascii?Q?anV0aB5HwOcY7nxvMuk0k0dUxOya8xdqAQDw8vUEcxC7qdj61hO5itxaxp7H?=
 =?us-ascii?Q?Z9mHza9ZEyNtnVzPeQ6yl2H7QRBuc/K1bGc5IiIe/lrid+CRiMWoMXPD/Hzs?=
 =?us-ascii?Q?PxiRzdpXbBz7nWSL53VckeyyUcZRNkcPMBfNX37gzitxJ5Nj2PZxwhdmSi6c?=
 =?us-ascii?Q?8o3xX2fxjwC3QyTc5IZEg651OZmNabsCgMV35VUxr0IrPZFZ93VnxEqCHziv?=
 =?us-ascii?Q?8QZ5S6YdADrtdxHfESjeH93nSvXU3F2uFEgJtWpyrpQIVgpJjiInvdtPJkCA?=
 =?us-ascii?Q?JQNe2OAgISaUwlNcjqXEg9l6UaqgrPtNlVWtAfghoKL6SSrJORMyQoya757m?=
 =?us-ascii?Q?HgOkxV/tG9+t6/9Fky+sIS94ASCKeyG0sz5hdEQvVLi708dErqtLych5n2JF?=
 =?us-ascii?Q?5ZwRXJXWqn66t58QGJVd86Lp6D/88fMjpBiL3uoSZ8lQgndA1eP8uuOyYbPZ?=
 =?us-ascii?Q?vqr4EVzP6xai6SLJsmSNtmM3GMFa7hXcTZakEjpZ95BnCXesZ2CDkffi6n00?=
 =?us-ascii?Q?9LdnrnO00OBbtwRCWGPRLZJhKLV5Um7nqnMmG/goTxtVBwvfYK0orNFKawlw?=
 =?us-ascii?Q?B0WEU3GlVDC0Ef2FVs7KF55h+aTXQVv4D0smM0NIokM7CDOODbAaAgqVAva/?=
 =?us-ascii?Q?VVvEMjgUB6c7p/KTaui33WLyDJKHuNC7tuv6HALtTLIpdfHJrkKUXqSTnrVR?=
 =?us-ascii?Q?amMfY8/BD9Gfr6YZKYEEUIgtVty4TEJ7YxSAzRTV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7af8050f-fbe6-4c90-4b90-08db10b3b05d
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 06:53:35.0727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F0bqszIktnXmPOy0fS1P4UT0vWYqaw4DWlJpSBXmXZFhj+W4YXwW9TN4aamMVHiz3o7mr9CQ/toHdvAaoGKLcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6840
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With all previous preparations done to make it possible for the
single LCDIF embedded in i.MX93 SoC to drive multiple displays
simultaneously, add i.MX93 LCDIF compatible string as the last
step of adding i.MX93 LCDIF support.

Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v3->v4:
* Add Alexander's R-b tag.

v2->v3:
* Fix a trivial typo in commit message.

v1->v2:
* Split from patch 2/2 in v1. (Marek, Alexander)

 drivers/gpu/drm/mxsfb/lcdif_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/mxsfb/lcdif_drv.c b/drivers/gpu/drm/mxsfb/lcdif_drv.c
index f1f5caef390a..0eb132cad181 100644
--- a/drivers/gpu/drm/mxsfb/lcdif_drv.c
+++ b/drivers/gpu/drm/mxsfb/lcdif_drv.c
@@ -249,6 +249,7 @@ static const struct drm_driver lcdif_driver = {
 
 static const struct of_device_id lcdif_dt_ids[] = {
 	{ .compatible = "fsl,imx8mp-lcdif" },
+	{ .compatible = "fsl,imx93-lcdif" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, lcdif_dt_ids);
-- 
2.37.1

