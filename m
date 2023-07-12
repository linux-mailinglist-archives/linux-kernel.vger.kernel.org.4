Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21BC374FD04
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 04:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbjGLCXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 22:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjGLCXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 22:23:09 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2120.outbound.protection.outlook.com [40.107.92.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954891722;
        Tue, 11 Jul 2023 19:23:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q1SLl8RQDUaSJIX/S/yGf11OcVDle6fuSquQqeewoanGn+s2t88xznRkg78QvFsjTT5NFkwTZmPyY+mh2S3bG/Tsd5d3/kWjuy/CBPkRN/yK9Lgf5/SBsuCXfBF1VwUrkGQf8cFolsw6hDUziHpE8TZbEqTOGJOq7ReFawItfWaoKqSq667x/8ZwpcZtG6NsIVRucbxtcXHPdpLhlR425+H0kUM3FFeG1+f9kBzXPU5ubmtlWOHs1UoVC8ae7w2+TiRToH3YFQTwxoJg48f21IvZmHUwpU6Gyt24RGAVwHHDvqaHrn9yAOTVm64AJclYA2b5QAHuUc8dObZ72AjftA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z1pIl7S3A9QKhyV2Tb5uhGibnAzkoHPXQjsumWu55+o=;
 b=a6YCOwAzVY2SfkAKSil+wILjjKtfbWwPkRg/CKaqfNz0wFkRtjdJbTwxbISToy+9QVVtPIXQLNtLJhzbGRi/UOULe1xKXuvdB5deC5OVuJUG/hF0AmMLC/BowegbHcHBSCoYjKhB/ITM8Kd9QR6kfe5BA8w6IkU4lekR/WgbOadVlPIBkPK6SGtEnshwyTTA36FVWdFWJLbZrTjpcUe2gLTdPH+f6hg42UImd24dRc5z3yYGJRmDopY41wH+0EJTeUQ+Wy6qba90w5l9INeYuj+BkfEiDb1TmX0gPkY/PImwXF3GcUo4trxsxFRpu9HxaNACW/GiPVq6+G0lfGgc3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1pIl7S3A9QKhyV2Tb5uhGibnAzkoHPXQjsumWu55+o=;
 b=p3SNM9VGQqQw1GKZZ0fjrM/kdGankO63mpLTcWpPXtP0QM1sH1I9Yh5HgiAFFyKtyoxkOyT0zBTQ6LMIa4X+YfAoNP2oLo/zVHoxMz73H3P+CdrC5xRWz6Cw7m27OwAarp7SZzpGQepEGJhU7A4CKm73bYWiHqNLIdPmP+ZWE8E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by MN6PR10MB7467.namprd10.prod.outlook.com
 (2603:10b6:208:47f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Wed, 12 Jul
 2023 02:23:04 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::f575:8f7d:c91:5078]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::f575:8f7d:c91:5078%6]) with mapi id 15.20.6565.026; Wed, 12 Jul 2023
 02:23:04 +0000
From:   Colin Foster <colin.foster@in-advantage.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        UNGLinuxDriver@microchip.com,
        Daniel Machon <daniel.machon@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: [RFC RESEND v1 pinctrl-next 1/1] pinctrl: microchip-sgpio: add activity and blink functionality
Date:   Tue, 11 Jul 2023 19:22:50 -0700
Message-Id: <20230712022250.2319557-2-colin.foster@in-advantage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230712022250.2319557-1-colin.foster@in-advantage.com>
References: <20230712022250.2319557-1-colin.foster@in-advantage.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0034.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::47) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2351:EE_|MN6PR10MB7467:EE_
X-MS-Office365-Filtering-Correlation-Id: c584b02f-b42b-4ae5-aab6-08db827eeb1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cPnB+MzunOMYPCd+mmbeiiQKQCJI5E6TyRfN9hrGeWnThff5GC1wJFfRmACsYGbbF9gvIrfM8YuW5ZWZgAUz/1QE1FL51vNm6LFgzMgMTJdB+LjY2GjF+EFrf2d7VygD8G/9CHvsZiou8lI5nSPGD/+YoyJQRy2qsVEd9moVSXAPqjsiifY0hpKSF7uD2apmEyldAp6nHxOFU6NMYWaBpAMj4iXrLTH53zyMnKTtUAcFkBiQ7+xFWCtXjS6nXHCIcx/4fesY2U6ELGznsE2NwTNMPkyQqLigmSBPewp4t+7ASghr0IPJYL5zqw2iViYbLIH2WDc9ruEOVoa3JIWSkmJgb2MbnmCSY/yO9g0mXkG1ZDVb3BjS3ylJu6gbQK/eQCu7H5MK3qp/xOcBZ7NpyWga+RBd9xDbpvUTBATH3ckhIg5jJ4OFkIIg7oYXnZVaKTZr7A12RuoO0imIBtizY9hYt5uYpJ2hFDE/aUy+4U9LbQuaYECuOidld7x/GgpXyKjtXeJ/YTorfWHlUnOxsQVfe2lfZAbaEqtWftd4ZvH8AgR2m5LTlu7EbsEXcZ2fsZOswNtSLPKMBSPLLt63extQ7m5hxi3pGgxEa3Cue1Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(39840400004)(346002)(376002)(451199021)(38350700002)(54906003)(6666004)(6486002)(52116002)(478600001)(7416002)(8936002)(36756003)(5660300002)(2906002)(86362001)(8676002)(44832011)(4326008)(316002)(66476007)(66556008)(66946007)(38100700002)(41300700001)(26005)(186003)(6506007)(1076003)(2616005)(83380400001)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rg1noNsc8cIEkqvG2x3xKvzbkxz5WOASJPMOl0Zux+UC+x4uD/KVa0sRWnb7?=
 =?us-ascii?Q?59Bgy1f6jQkuOUeVW0Vv0hZB2nXOOVFe51xmFo1cd2xxBhYyfMC4RVaIkby3?=
 =?us-ascii?Q?rkH8WFm2Vrn1tJ+t7uGcaf+zJ3wyFJ/ZhMtiuKlIhI10YOfzFUoo5Ck5nXsU?=
 =?us-ascii?Q?YT8Jfuf9VTNg4rqu0KHl+0YuzVTcvpAiSXa/8YNmKRo66oQ+tWVKKWgTyY5d?=
 =?us-ascii?Q?NmW+eUJ1yDGQ/YpgqYdtaQXjlkJ3NEeZemcaCT9Q3Dmk8+ELIAqtcNuZ63HN?=
 =?us-ascii?Q?H8WXEJXQYEwpv1+iMbUf7BjU3Ng7ECdakhUX6NFqzY1Gmwea4FRYaF63ahr/?=
 =?us-ascii?Q?4Braxfj7wl14O+QZ/ffGPG6GrTArYSaffqTQBfA0I0xNSBGRRpMYfnZpzaZE?=
 =?us-ascii?Q?NEwLx/5s62qaU6bQHaLT4dERRTAdtt9Q1eBURzbQhMX8UuCKTJixst7hKQgJ?=
 =?us-ascii?Q?/e3F/MSvbDghz1hBeUgHw3cz6TnFYaNBZRhm9wDnz0p+GEj4Y/S/XjLHloPL?=
 =?us-ascii?Q?69oVMHeAzgU5nIA4HyzgKcH407J0S57tx51p+s6+M8zxvoNQ2FHgRy93eKBf?=
 =?us-ascii?Q?KEeDVBaIL2NpefPbjgn77SqPInkiaW4ExMBLL6G/ricqKQp0DV6EKumFjXC7?=
 =?us-ascii?Q?a91BODuKnSdE85J/muuE5uRVq6DAIXDVfkq4M3guVhcDSB26M/qlDjT8xj2j?=
 =?us-ascii?Q?CTVsnF8atOJSsvAvmYRbX0JniA9kj5L71pKS4jiBrb/3DLkj4mWkk49JwLzg?=
 =?us-ascii?Q?ZmANVIAhI9LJIV733ZVlHWbbT4hgP3VqviixY+d5zLuMkc9Tg54rAGqV2pKK?=
 =?us-ascii?Q?Lz0DwVXLTWkXvWOdXhgKapxZ/Jr8Op4DzXznPfYS0jxqJgTFw6EuisqIaDgo?=
 =?us-ascii?Q?X4AKYTYQvPu7lm/KdGy/BQqmkFpWANrAFVeYdKhuuheqaOXSDj1jjYDZ9nIX?=
 =?us-ascii?Q?vMqetO4nND7ibcLpfAm2z7+FUXK8uaJUi5xZT62mg+5UxAdJlzqAXvJlqfga?=
 =?us-ascii?Q?ImN5O+viUIRAzEVKV7Y8Y73jVnX7ArceSU0T3yL+QuVYnXXyVbjNph9CyTGm?=
 =?us-ascii?Q?zW8v97Pzk+w5+UyBpcW5ryCPjdFTJNXauzG7q6rsEyMW+P/573hVSlFr6XoJ?=
 =?us-ascii?Q?N8zZBEg1bRCvPZVf76YGAnUgRfNKpowzAY87n2nNxTY7DfbtuGNb/g6+kskn?=
 =?us-ascii?Q?uK6X6nYd5ZsZRYzzCaI7u0MTmeAt/bl+yTpwhlcJeoGXv2XVopKiZ0Sqg3UR?=
 =?us-ascii?Q?TLME6iwhh13czzRg7/9xqj/TsBqxgc0m/fwqYAdI+GAjpxzXjGAXCpCY+02u?=
 =?us-ascii?Q?c3ZZMkpPQdK67PUOBU4SAAdjKNi3hZd8SbcRYMwgIyUNW28xacJyrGkTefor?=
 =?us-ascii?Q?o8JV6g7rOb5KPeI4AUtvau7iV9t9n0/xPpmZ7VojBCFfpPAhKFVBYh952ySu?=
 =?us-ascii?Q?j0OvEMl69L3OiPnI9dUdPWOy38mfFDP8yYItA1o83Dl8tsUJk16B/71OxrSf?=
 =?us-ascii?Q?2h+7Dy5RjGrO+OLSYoWNuRwMJWDyHbZVaV/l8zHkaRJ1fRg8NbGYI/j1PbN7?=
 =?us-ascii?Q?sfGjyZfwVfA67JphzrA5x4E8DYp5MrCA9/OKrI4c1qY+ceiA6D1PAaY87Ll4?=
 =?us-ascii?Q?BoxI7u1Rgzse/sHBroMEcNk=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c584b02f-b42b-4ae5-aab6-08db827eeb1a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 02:23:02.6715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PvHKelU1huwfIQV5i8Ieo7C7EYqSB1tKJ4eZbHWwsF9ZOXuiPBN3Ljf1kCwXKwIHV3hbBJ+/NYQGBOkvY1fCi8aUhXvepQ2lf8+u1MeMmq0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7467
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add additional functions - two blink and two activity, for each SGPIO
output.

Signed-off-by: Colin Foster <colin.foster@in-advantage.com>
---
 drivers/pinctrl/pinctrl-microchip-sgpio.c | 135 +++++++++++++++++++++-
 1 file changed, 130 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-microchip-sgpio.c b/drivers/pinctrl/pinctrl-microchip-sgpio.c
index 8e081c90bdb2..e3230e5dedc0 100644
--- a/drivers/pinctrl/pinctrl-microchip-sgpio.c
+++ b/drivers/pinctrl/pinctrl-microchip-sgpio.c
@@ -51,6 +51,15 @@ enum {
 	SGPIO_FLAGS_HAS_IRQ	= BIT(0),
 };
 
+enum {
+	FUNC_GPIO,
+	FUNC_BLINK0,
+	FUNC_BLINK1,
+	FUNC_ACTIVITY0,
+	FUNC_ACTIVITY1,
+	FUNC_MAX,
+};
+
 struct sgpio_properties {
 	int arch;
 	int flags;
@@ -60,16 +69,22 @@ struct sgpio_properties {
 #define SGPIO_LUTON_AUTO_REPEAT  BIT(5)
 #define SGPIO_LUTON_PORT_WIDTH   GENMASK(3, 2)
 #define SGPIO_LUTON_CLK_FREQ     GENMASK(11, 0)
+#define SGPIO_LUTON_SIO_BMODE_0	 GENMASK(21, 20)
+#define SGPIO_LUTON_SIO_BMODE_1	 GENMASK(19, 18)
 #define SGPIO_LUTON_BIT_SOURCE   GENMASK(11, 0)
 
 #define SGPIO_OCELOT_AUTO_REPEAT BIT(10)
 #define SGPIO_OCELOT_PORT_WIDTH  GENMASK(8, 7)
 #define SGPIO_OCELOT_CLK_FREQ    GENMASK(19, 8)
+#define SGPIO_OCELOT_SIO_BMODE_0 GENMASK(20, 19)
+#define SGPIO_OCELOT_SIO_BMODE_1 GENMASK(22, 21)
 #define SGPIO_OCELOT_BIT_SOURCE  GENMASK(23, 12)
 
 #define SGPIO_SPARX5_AUTO_REPEAT BIT(6)
 #define SGPIO_SPARX5_PORT_WIDTH  GENMASK(4, 3)
 #define SGPIO_SPARX5_CLK_FREQ    GENMASK(19, 8)
+#define SGPIO_SPARX5_SIO_BMODE_0 GENMASK(16, 15)
+#define SGPIO_SPARX5_SIO_BMODE_1 GENMASK(18, 17)
 #define SGPIO_SPARX5_BIT_SOURCE  GENMASK(23, 12)
 
 #define SGPIO_MASTER_INTR_ENA    BIT(0)
@@ -98,22 +113,46 @@ static const struct sgpio_properties properties_sparx5 = {
 	.regoff = { 0x00, 0x06, 0x26, 0x04, 0x05, 0x2a, 0x32, 0x3a, 0x3e, 0x42 },
 };
 
-static const char * const functions[] = { "gpio" };
+static const char * const function_names[] = {
+	[FUNC_GPIO] = "gpio",
+	[FUNC_BLINK0] = "blink0",
+	[FUNC_BLINK1] = "blink1",
+	[FUNC_ACTIVITY0] = "activity0",
+	[FUNC_ACTIVITY1] = "activity1",
+};
+
+static const int function_values[] = {
+	[FUNC_GPIO] = 0,
+	[FUNC_BLINK0] = 2,
+	[FUNC_BLINK1] = 3,
+	[FUNC_ACTIVITY0] = 4,
+	[FUNC_ACTIVITY1] = 5,
+};
+
+struct sgpio_pmx_func {
+	const char **groups;
+	unsigned int ngroups;
+};
 
 struct sgpio_bank {
 	struct sgpio_priv *priv;
 	bool is_input;
 	struct gpio_chip gpio;
 	struct pinctrl_desc pctl_desc;
+	struct sgpio_pmx_func func[FUNC_MAX];
+	struct pinctrl_pin_desc *pins;
 };
 
 struct sgpio_priv {
 	struct device *dev;
 	struct sgpio_bank in;
 	struct sgpio_bank out;
+	int ngpios;
 	u32 bitcount;
 	u32 ports;
 	u32 clock;
+	u32 bmode0;
+	u32 bmode1;
 	struct regmap *regs;
 	const struct sgpio_properties *properties;
 };
@@ -223,6 +262,32 @@ static inline void sgpio_configure_clock(struct sgpio_priv *priv, u32 clkfrq)
 	sgpio_clrsetbits(priv, REG_SIO_CLOCK, 0, clr, set);
 }
 
+static inline void sgpio_configure_blink_modes(struct sgpio_priv *priv)
+{
+	u32 clr, set;
+
+	switch (priv->properties->arch) {
+	case SGPIO_ARCH_LUTON:
+		clr = SGPIO_LUTON_SIO_BMODE_0 | SGPIO_LUTON_SIO_BMODE_1;
+		set = FIELD_PREP(SGPIO_LUTON_SIO_BMODE_0, priv->bmode0) |
+		      FIELD_PREP(SGPIO_LUTON_SIO_BMODE_1, priv->bmode1);
+		break;
+	case SGPIO_ARCH_OCELOT:
+		clr = SGPIO_OCELOT_SIO_BMODE_0 | SGPIO_OCELOT_SIO_BMODE_1;
+		set = FIELD_PREP(SGPIO_OCELOT_SIO_BMODE_0, priv->bmode0) |
+		      FIELD_PREP(SGPIO_OCELOT_SIO_BMODE_1, priv->bmode1);
+		break;
+	case SGPIO_ARCH_SPARX5:
+		clr = SGPIO_SPARX5_SIO_BMODE_0 | SGPIO_SPARX5_SIO_BMODE_1;
+		set = FIELD_PREP(SGPIO_SPARX5_SIO_BMODE_0, priv->bmode0) |
+		      FIELD_PREP(SGPIO_SPARX5_SIO_BMODE_1, priv->bmode1);
+		break;
+	default:
+		return;
+	}
+	sgpio_clrsetbits(priv, REG_SIO_CONFIG, 0, clr, set);
+}
+
 static void sgpio_output_set(struct sgpio_priv *priv,
 			     struct sgpio_port_addr *addr,
 			     int value)
@@ -352,13 +417,18 @@ static const struct pinconf_ops sgpio_confops = {
 
 static int sgpio_get_functions_count(struct pinctrl_dev *pctldev)
 {
-	return 1;
+	struct sgpio_bank *bank = pinctrl_dev_get_drvdata(pctldev);
+
+	if (bank->is_input)
+		return 1;
+	else
+		return ARRAY_SIZE(function_names);
 }
 
 static const char *sgpio_get_function_name(struct pinctrl_dev *pctldev,
 					   unsigned int function)
 {
-	return functions[0];
+	return function_names[function];
 }
 
 static int sgpio_get_function_groups(struct pinctrl_dev *pctldev,
@@ -366,8 +436,10 @@ static int sgpio_get_function_groups(struct pinctrl_dev *pctldev,
 				     const char *const **groups,
 				     unsigned *const num_groups)
 {
-	*groups  = functions;
-	*num_groups = ARRAY_SIZE(functions);
+	struct sgpio_bank *bank = pinctrl_dev_get_drvdata(pctldev);
+
+	*groups  = bank->func[function].groups;
+	*num_groups = bank->func[function].ngroups;
 
 	return 0;
 }
@@ -375,6 +447,15 @@ static int sgpio_get_function_groups(struct pinctrl_dev *pctldev,
 static int sgpio_pinmux_set_mux(struct pinctrl_dev *pctldev,
 				unsigned int selector, unsigned int group)
 {
+	struct sgpio_bank *bank = pinctrl_dev_get_drvdata(pctldev);
+	struct sgpio_priv *priv = bank->priv;
+	struct sgpio_port_addr addr;
+	int f;
+
+	f = function_values[selector];
+	sgpio_pin_to_addr(priv, group, &addr);
+	sgpio_output_set(priv, &addr, f);
+
 	return 0;
 }
 
@@ -693,6 +774,30 @@ static void sgpio_irq_handler(struct irq_desc *desc)
 	}
 }
 
+static int sgpio_create_group_func_map(struct device *dev,
+				       struct sgpio_bank *bank)
+{
+	struct sgpio_priv *priv = bank->priv;
+	int f, i;
+
+	if (bank->is_input)
+		return 0;
+
+	for (f = 0; f < FUNC_MAX; f++) {
+		bank->func[f].ngroups = priv->ngpios;
+		bank->func[f].groups = devm_kcalloc(dev, priv->ngpios,
+						    sizeof(char *), GFP_KERNEL);
+
+		if (!bank->func[f].groups)
+			return -ENOMEM;
+
+		for (i = 0; i < priv->ngpios; i++)
+			bank->func[f].groups[i] = bank->pins[i].name;
+	}
+
+	return 0;
+}
+
 static int microchip_sgpio_register_bank(struct device *dev,
 					 struct sgpio_priv *priv,
 					 struct fwnode_handle *fwnode,
@@ -716,6 +821,7 @@ static int microchip_sgpio_register_bank(struct device *dev,
 		ngpios = 64;
 	}
 
+	priv->ngpios = ngpios;
 	priv->bitcount = ngpios / SGPIO_BITS_PER_WORD;
 	if (priv->bitcount > SGPIO_MAX_BITS) {
 		dev_err(dev, "Bit width exceeds maximum (%d)\n",
@@ -738,6 +844,7 @@ static int microchip_sgpio_register_bank(struct device *dev,
 
 	pctl_desc->npins = ngpios;
 	pctl_desc->pins = pins;
+	bank->pins = pins;
 
 	for (i = 0; i < ngpios; i++) {
 		struct sgpio_port_addr addr;
@@ -753,6 +860,12 @@ static int microchip_sgpio_register_bank(struct device *dev,
 			return -ENOMEM;
 	}
 
+	ret = sgpio_create_group_func_map(dev, bank);
+	if (ret) {
+		dev_err(dev, "Unable to create group func map.\n");
+		return ret;
+	}
+
 	pctldev = devm_pinctrl_register(dev, pctl_desc, bank);
 	if (IS_ERR(pctldev))
 		return dev_err_probe(dev, PTR_ERR(pctldev), "Failed to register pinctrl\n");
@@ -895,6 +1008,18 @@ static int microchip_sgpio_probe(struct platform_device *pdev)
 		sgpio_writel(priv, 0, REG_PORT_CONFIG, port);
 	sgpio_writel(priv, priv->ports, REG_PORT_ENABLE, 0);
 
+	/*
+	 * The datasheet and register definitions contradict themselves, at
+	 * least for the VSC7512. The Datasheet Revision 4.2 describes both
+	 * default blink modes as 20 Hz, but the registers show the default
+	 * blink mode 0 as 5 Hz. Two identical blink modes aren't very useful,
+	 * so override BMODE_0 here to match the 5Hz "default" described in the
+	 * register map.
+	 */
+	if (priv->properties->arch == SGPIO_ARCH_OCELOT)
+		priv->bmode0 = 2;
+	sgpio_configure_blink_modes(priv);
+
 	return 0;
 }
 
-- 
2.25.1

