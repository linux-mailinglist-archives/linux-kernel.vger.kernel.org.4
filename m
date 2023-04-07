Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDAD6DAE80
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 15:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240537AbjDGN6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 09:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239506AbjDGN62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 09:58:28 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2037.outbound.protection.outlook.com [40.92.98.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8C8E60;
        Fri,  7 Apr 2023 06:58:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ms09a2RE6+ACR+d6cvcJqY95K+FR+uEwMv4khoRx5WJVevBvRBLyNboGB2vKSS8icjaaPg857eL//PeEq2sqDvucIrtOxwUbCcQDxU8gTKKSZ3Ggojti7a6eWaqw4+BO88+6kGXftCz6a+YQJ5VaYET0vZZExL5CtM8tBho98bhwVHBWLOtdI0DvlTyRniuSlZHtBHy0bQekGNoNVXGVlfNTCVgcx86w93gAd/K9gX9ZTCzPN+Ku0NWHcYKfWN6cNpMQ7Sh+K8zwYoKNJm5GC4XRlV93GEmFuoRqA3fkD2JSi2CKQmmDjQTPU8bBCpAr7f8MFXooV9yJwG5MW0w+5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oY4jFFNw0M7yIh4a0N5pllOYfkbx7ClJRAnYHXblrLw=;
 b=mFWCgLkVjwr9Ocsz1at5g0w7efdTls7pY53iLoG2219DyZLNUjOZx2oX/RNnpI4dapdwOHFw7EFm1CxBwlixKjvA45Ltv9DbKEUDmHuzzEGuvpJrUb4VWv1SBxCI7DEj7PWHXX3m4g9+ZMK5FmUKLP1ZB237H32mpIXoD+EG/x7bIBtEgAGCfB7/gbw6YDIst8sTY4tFQw1xY+APaIwPjw83j2Iygc/F9lW8Z6sF/XW8va9JoSbo9cDtlvn+KChnrbWY/NKqE9zHKd/5db3mIU1H5KfZoWHa8yMLabVXrSjcdpNbdtofDeHvK/QMhZlJDKcpzm4rsrcuLwcfh2GSQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oY4jFFNw0M7yIh4a0N5pllOYfkbx7ClJRAnYHXblrLw=;
 b=Tb9CxNE/MHc+d9k9mzh7dgUlUAqW4b1DNdMwOYQR2UVkrFy6F+1/I8PBFyue1npJdP8RKwAgt2fWUusGz0mXKUEWJzCs7jZew5pdb03Mr27beuov54xqugj6QYyARVemquhM7BvUO0Smx+7jMWVXphf4txAnJHY4M+3dwgqN7oS4X8oYLdYKO7Nksi5gjJl6GlZ/v/L53wWuLZe98rPPSQ4Sxjeh/6cTMStcfH7VcISxL5W7Q4FKP7bLtvaWJwdq6i+Iqe/di7aKiL3JvRGgw9l7K2Zyccl65Omeds91RL6bz6Vmh4pj+F0b3a23SMrWbkL9pDzDQAvv89WJo2Nfrg==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
 by OSZP286MB2208.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:18d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Fri, 7 Apr
 2023 13:58:23 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d190:6e4d:5a1e:59a]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d190:6e4d:5a1e:59a%3]) with mapi id 15.20.6277.033; Fri, 7 Apr 2023
 13:58:23 +0000
From:   Shengyu Qu <wiagn233@outlook.com>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        lgirdwood@gmail.com, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v1 4/4] regulator: axp20x: Set DCDC frequency only when property exists
Date:   Fri,  7 Apr 2023 21:57:17 +0800
Message-ID: <TY3P286MB261130B4C62D76DB6703D3AC98969@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230407135717.17381-1-wiagn233@outlook.com>
References: <20230407135717.17381-1-wiagn233@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [5ASSQoryS6FYig2XikeZf+LtwxXlTot1]
X-ClientProxiedBy: SJ0PR05CA0050.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::25) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:252::12)
X-Microsoft-Original-Message-ID: <20230407135717.17381-5-wiagn233@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|OSZP286MB2208:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c052bec-f708-4899-5961-08db3770269f
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9Xmovywdyt6JbrF6Sw9xOtJaeu8ZRRwqj0GRz5gUysH2WYhzzjKQ5md5abvB2PUv/ROwRO2RXuix4ilWx9K2hwmd58vFtPYtzciewEPFndLjvEpkfqB7HbxgyjZTunatWUdtDt9NoMtrSFmcWOrvLjuOb88AEUhYHhIyPtwXm+0wakOL1YvGb1Cq90WB/xr9pTpSuGk9K0ieQsFf8q0b13LNCaMtCswVkcCXQvHjm93gfjupF8bX+SkkARiOZonTOpSo3DQ/GRL3kMrlNiadUMiNMyDwb+QLTpqw2ZUMiLxToBFqcwo38y1qTXlMEJIpYbJvyEjeIeIGn8MTBj70ajT1IG6RaVg3iv09ASLz9WEVzKOJxRkdKb4GnBETXieD3aIkMahR0NBCRyyugUkXvrnDiUeHc1FBMQcwvP2OKx5Gjqo8o4l9ojXnOKWPA0Ewprc1bh9zkAZ5j0pACUnJk41ITEyVW72exk09zEb/20ToJZc3VEKMMIGxpqo0raoYX/d23UGScVL/lmLOUEG83mP5qlDdhqp8rB286u5Xcj6QPa7O2XURu2W4U/GSvl0iCMDHNp+Md/vWBcrshuL2t4PGkRvYlM+E5HffIztO34Za5MzFpLk3at/xqtqhxherl/NP3nM6GnST2ApS9eS1dF9wCYuGrFQ9Z91ZqIGhaQOvbXjOF4rpwSYNWBha3eZ1fDE4s+893GJKlWbAHAhAfnEjeCJi4JTT0thPGWcaX4gl+2hcSd1+YPe6Cl69OXObQWOw=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AJW9XaiiG30syuJEmfFu9bnhwSXy6xIFM0hqYYsBy5c5Uld3PmKyFSam/cE0FBQBURgOlc7IrKxR79jmwcKU/fisyt1x+UiCr2Eh8Lv9i/cPeI2OYoTtoRAFFi2D8d8OykE/dR/8L3Eh8Z4YBBKYOIWv/wMHa1lpqyjdgfwA0O1Yg8/G7u8gSBw5tQD/lTpupoNqfifmd05Iws9fCwxDT/8m3DgSekPk4rZklDgXimT01l9Kgrs3MOtzwsTcGMjTbdF9v4kdIbxpob8ZvCJrsqXS8ifzWgQ3bwoMM1rzYC8mMHdXqYfG8lfynrvksHIxgoepWac+/2azBXiS1RHMW5TfMFfZg1rd6EyRaX87rMbY4a2+efSoG2jlYwlT4PI/vsIh8LIa0oTq9AAr4+yi9MeAYFG5EZSMgN2RwXz+Ss8oPhkkj3OwkA8XiRuEVG7WMwfVoTvUfEPHeN5MUVx87HUh1dq9ajSrFNB6fjr3Nnbsqcj1PDgy2i3eKb1FmT01Ws8djVtPI1P5o5Gt9sZbpgJNC6KdOIFbBW0P0jQaWTiZPnowpZz7vdG0z0bB7uSJ7JZcr9dsH5en38uZheHAGjq9QwNmaK5vfqvo/LN84BfJf6XYpegVe8XM/j8gMfEg
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lW3bJUWDHXoZzjK24Dg8iCelSU2DT9Q42Wo3pHOGoLYpcfkzoF8xyS3SUiTH?=
 =?us-ascii?Q?cWRmz9lX+wrYiik05+F1fTBNbWmfqIFYUVj+vZmBTkV6dFiwM7oY2BGqSGh0?=
 =?us-ascii?Q?uG3o+7owNXd4pEAKfyamjlzAcnbxcZYRlPL07Y0ijNqOenQrduJzdZQ2E0JU?=
 =?us-ascii?Q?68QOo1IvTD/GSKrrIiUSvNzkF/vAdbKjNlLQf1A+HPsWqcCk4YS/4KS8seSW?=
 =?us-ascii?Q?1UNyw0lFg24sj2ZOL5rdttgt2cxbrWcygBVOW1+kUnc3DCuaKdhExPGtG5vV?=
 =?us-ascii?Q?N2hLJCj5fS8uRgWNvON8/6sMPxdDolQN36Q4+9GecCdjhlzISNl8KF0FNrKA?=
 =?us-ascii?Q?QUH5bZGt7njLW8rgsJflcKVhulqCPo1Rp3mTn2qQlvScYg539ytYK4ip6BJh?=
 =?us-ascii?Q?nYiQ5UrcfvHKzJrmDrMPltjud2io6VqYedHlJ9rVGLr3dzwgoS6AuppAU39b?=
 =?us-ascii?Q?yexBE3O5NJHsMYiJFHyyxsHdxB0tDsPssM5wDaZZf33es5Xp8KCAImhVG5nm?=
 =?us-ascii?Q?6pVJ+hA2wMwCEUhl4DxmcJJDejGUib2fRaAJa3GUjYd3oMVkm3XNzU6/pfCy?=
 =?us-ascii?Q?Y7IlhqP6a1fvR+lXZUqyJO/LIffl1auZMcCgPm0mEfsiVblDu6Sd2RntrYeI?=
 =?us-ascii?Q?StK9JTlvWYU0+R1KPyLWmScEygtQb8NRW9oLUBYO7naj1Uh4afxHnPXgefDf?=
 =?us-ascii?Q?C7zpfctqQAhNtoW1FOCAaUtDECu9dTJx+r/08NP/STL3CKlOOKlLdcpRHU3U?=
 =?us-ascii?Q?Boa5qrHkl0wh+KY9mJMIyCnmfMpAAt3XN/pPHWp2OZ90HmFpqm/8zH0a2ZfJ?=
 =?us-ascii?Q?TH5toehVx+fU6ha49lkt6r0ef/ixK5J7HEvL5T3At0vjZ8YaOpHM4XKdDszn?=
 =?us-ascii?Q?T9hyZJy2k+XunPobIltBA7ufXnBv/urRJR5lrbfHaKfQcjwETI+Xe9O+VoG/?=
 =?us-ascii?Q?cRpReCCSfQNNiLRHLkxMyEwcwYhjERgNYJmuOC1eEZ1PZ6eR+5btwOtODljm?=
 =?us-ascii?Q?ImBWiAD2ig7aQzizID73XO4k+XUNN5f4V0dHkHoEGNCCCOppq5Qj/2N/eVJB?=
 =?us-ascii?Q?56x6knXuq3Oytkn+dPL+yBAzWlnCsi0X2GRfoAtdqby7PZoMTVziolMp0wez?=
 =?us-ascii?Q?MK1S1bfx0950g+5r8xaB46TVv11gGd9e5Vz0hK+d4kr/tQ0vM26jUPHSaFca?=
 =?us-ascii?Q?DkmB4qpQfxpQVoW9Vzt0nRv2OFiIshCUH3GdRg=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c052bec-f708-4899-5961-08db3770269f
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2023 13:58:23.0016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB2208
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current axp20x regulator driver would always set DCDC frequency even if
there is no x-powers,dcdc-freq in device tree data. Causing meaningless
warning info output on variants that do not support DCDC frequency
modification. So only try to set DCDC frequency when there is frequency
property.

Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
---
 drivers/regulator/axp20x-regulator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index ece4af93df7b..12a12923bc7b 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -1247,10 +1247,10 @@ static int axp20x_regulator_parse_dt(struct platform_device *pdev)
 	if (!regulators) {
 		dev_warn(&pdev->dev, "regulators node not found\n");
 	} else {
-		of_property_read_u32(regulators, "x-powers,dcdc-freq", &dcdcfreq);
-		ret = axp20x_set_dcdc_freq(pdev, dcdcfreq);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "Error setting dcdc frequency: %d\n", ret);
+		if (of_property_read_u32(regulators, "x-powers,dcdc-freq", &dcdcfreq) != -EINVAL) {
+			ret = axp20x_set_dcdc_freq(pdev, dcdcfreq);
+			if (ret < 0)
+				dev_err(&pdev->dev, "Error setting dcdc frequency: %d\n", ret);
 		}
 		of_node_put(regulators);
 	}
-- 
2.25.1

