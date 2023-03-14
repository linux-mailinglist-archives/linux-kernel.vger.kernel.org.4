Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6E36B96D4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbjCNNuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 09:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbjCNNuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:50:15 -0400
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2056.outbound.protection.outlook.com [40.107.103.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028BB618A4;
        Tue, 14 Mar 2023 06:47:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/mRhNIkkji5QUcgOnhdcRr9SSFtl7BHiMGULB9mIpJ0HAd6xF/n9CyVXqwijR9bJyBvGG7y9dmmr0xxcH1FfWIpwzdCBr4ve0JXPKjfHzWzqBlWZ4e2BV6D3W8Wq8R6//vsNuDL7T91oQ45OgEYkpx3NbZwm6EabeJeV8EB69uKyTSFfgDUAZ+zjf8YFDe/g/MvdatAA7sUJxpxTdsVc9vDU1Zc+3kleTotFx49TTQzrNM2BIYJNu2cHdNJuw+O4XQFdhudZ5pcalskRDQo1pUDL+XFcojvPTGmZOiintedGXK1bLXtlVXxcXHi0Z6dVmE40UUfX2NmLxari/xh5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xfjqW5GlwrTKSJhwwHNfS58Vv86TZipLBF+s2WS+ke0=;
 b=R62NMDaE0bYWAfGd+PrJqQtl+QXnKdScVGYZFfVseVS05crbY3dwTd9UwJrgB7O9FtLzyQkz+cfifkMYCIaAju84Fn3KsAvl+yk9U5Cr62enuud7WLNgQ3xdYt4s7fLsNiGe6A8dydWbQyhnPAgBiga+Yog75S1W9qhbe/xufSbNKEapzHaQzziiiqSV0x5+FEV4+wnEWcuFy0J//QRI6Eag4i4PWH7vUT8OSPJgJUwBkoM96o0dbdKgukEoYVuRP3Fv9va5Txm4MMWQdJx/ck2D4X8L0YpxWTwyJ3kMCS43t9HBBZ9tBZNKd0B5kEcLzdSXibX3pMFA+8hYquqnvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfjqW5GlwrTKSJhwwHNfS58Vv86TZipLBF+s2WS+ke0=;
 b=GiIiiMmpITB/qHF/y7A2w+hy0ug32WXMU8uw8MB38U0YIl8uj+S94i6CjblexGtsfVQ/aSMc0ljscUDBM3ohVT++CzKLQDugyNmNPaep0aNnLKY534nVOJOrG105B7liq4sEVeHwgB+8HWoRNEE1WrdRgOX/4cWVWjNM9J27CrCJ5RVaRGyv8ppQUCDaC8n+lnDELcDfMHYd3h+rkD/DsHMAWOdXtClHG/ETJfStBz6F67XJs9IXtIrLS7rQOkxhOFQDWi+SEjsbcyh5Fjs8cTROmIEn9iRJsVrKB5t/V81IHP/LXdG+o2dM6hc0jXaJSrR9vGQAlZN/lLs9EpxJwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR0402MB3428.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::25) by AS5PR04MB9895.eurprd04.prod.outlook.com
 (2603:10a6:20b:651::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Tue, 14 Mar
 2023 13:47:04 +0000
Received: from AM0PR0402MB3428.eurprd04.prod.outlook.com
 ([fe80::2b1f:7e5:94d0:3ba9]) by AM0PR0402MB3428.eurprd04.prod.outlook.com
 ([fe80::2b1f:7e5:94d0:3ba9%3]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 13:47:04 +0000
From:   Chester Lin <clin@suse.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Chester Lin <clin@suse.com>, NXP S32 Linux Team <s32@nxp.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Radu Pirea <radu-nicolae.pirea@nxp.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH 2/3] pinctrl: s32cc: refactor pin config parsing
Date:   Tue, 14 Mar 2023 21:46:41 +0800
Message-Id: <20230314134642.21535-3-clin@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230314134642.21535-1-clin@suse.com>
References: <20230314134642.21535-1-clin@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::10) To AM0PR0402MB3428.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3428:EE_|AS5PR04MB9895:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fa5ca3a-a43a-4796-c3da-08db2492987c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jg6pGDevBvNR/VgJz7nwflECvS2rYsqx9NKZmHudggkuvUt9Xv7gHbhcvAJMfvwHkN+74FbLprctU2DKuPna/d7Xxj6YcFsrSR0apAmCGrv1eGYp+sBeGh7o39E7ip3Do/cQWI1viCsaccxNBNnKcniJqRfqM9cFre1+8VRTbaOJu2zYQir3nmECdwN3aI+23aQ+DQ6/prbHNzx77qcEZs4H/EX4miczWolkv2y+ExS0S3egFkGRtDiYnC+UsiTVZVJ/Ra7zUcp5GZAWyMKgPMm4ZcfuJDzaS2EztD0l7lRirXt01oAanIsDm5PUtDeWSsV8WKKbPVwPPlxaaTcLYbO0j0/8t0D6mihZkCfc8Shv28OwcE1l+/QjCwVV9xPn3sheAJKo6p8o+BtLlW0ss7p/b6wRVfIVvZthy8iw17tpS7vxRDRvSbzXHEEUPiCBcBiBlPZG7HJpAmJ0U4Ejzz4RqQ6xZUPubCSPUqzNGVQViV/WqELPDO+U7pe5BaEt3wFrLh0M9Rv8jrdLyvDCgsd5YzgFutm+Gnl2xdRcnpWeCmqcnNZ79BcL91z7MT/Au+pHqcBdovYEI01pUNGxCnZmm2T/icUH54bLsn232Ie+dQ+6V1Wk/Gi4/Yy17c0xK9KyHukZ6yZHx2qHXLjRTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3428.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199018)(8936002)(36756003)(54906003)(478600001)(110136005)(316002)(66476007)(8676002)(66946007)(4326008)(66556008)(7416002)(41300700001)(2906002)(5660300002)(86362001)(6486002)(6512007)(6506007)(1076003)(26005)(6666004)(107886003)(186003)(2616005)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o4rnbE4ZN7B4KrT5UDRrECFxxXErchxqA+yWUIXJfHoiZxLUtpQAz4csbJAN?=
 =?us-ascii?Q?7IrSGKOIMU1cYsMko77hZ9FTk/5ndtE1gdPxigo5J+pp80CkcId08jTRW9dt?=
 =?us-ascii?Q?c1UQ2J0PKikuNc5sK+w0HbUP8r9syrPBx5/poVyxYFUk/eqBaRlvlPoWfohk?=
 =?us-ascii?Q?XicfjeY+hRJpibqdZpmIFStluB29QpqyqQU5MutoQjiHP69G2exz5nZhZugh?=
 =?us-ascii?Q?5ACxNKm4r2T8qSOQUifKTVJRmo5UzaHH+zVUkgwiVOUgHOKItWtbbMMu2F+c?=
 =?us-ascii?Q?+DtKJu/F+7i0m2EOEFqaXEN2rvB5EbA5h00yEznOgS5vnV1+eW+RKC/cPuUL?=
 =?us-ascii?Q?CMmtjL11bJejd/TDTOxnPMhFvX7SDek1El/j1pV5YXGEQjFRuGvqX8tthD6U?=
 =?us-ascii?Q?iTDiYAdi2k4gvO+NyA+idTkQBBuUs3t/baVpq9rY98E0XPjPk+XUCCAmuzSi?=
 =?us-ascii?Q?8sO/I1Svu+h5HP6CLzQcWbVYOe0Fi+36HMiYZpz9RCyUxl3cjglHmnPhAMLP?=
 =?us-ascii?Q?j0UB752iSblg9WyHRHxrws/pxaEt0Ly0EmF2xyZiSOSYMNlLHL7Mxr/Q9MMW?=
 =?us-ascii?Q?xLPcoqaa0HTD0NzBkvPJedfLc/yKffv7AOVB6G2iZ5CaxpP+9+mq2SyNjoi+?=
 =?us-ascii?Q?aJx8ObmKXFdgxw67fahuBJ69ukgNXpfv9wcOqQkOeIq1LDcj6Fo1L7eeN3k0?=
 =?us-ascii?Q?WepeBtcvdeLOU2XTmUYlO+BKsMFV9o4Y4QTL3OUjaejWSOz81t/jT6m/1FyN?=
 =?us-ascii?Q?fVoDipNwjQS2yOp3ZcI3IvVNE9PY6WcD+pj9bwx/A8b24Mh+0lP7sZWahrhq?=
 =?us-ascii?Q?MIwOR8JMmyL3GSG47nV0Y/+5Kzw2lgmZ09/8XlC/v/e411iktKsMvMd92u9R?=
 =?us-ascii?Q?b/oiZtiGYdwxP3y0jbYxTpx4JOyJ7C1XWbHDOmRq4LWOxKcQY3VHFCoeh88K?=
 =?us-ascii?Q?Jhl1d2tL1yXrc1kZH6/f7s4PlV6bDDCCUeEkWQJAicwIzY90CHcktoY1cd7t?=
 =?us-ascii?Q?uOTXZD7njv+dCSSGkHRNdnCFzU8yuVljTJ7S3gZmMQD9znowaWdR5gzlyoOQ?=
 =?us-ascii?Q?BLwzXuwzarso0Xlqdjibqtz1AyPLupy9lV7SdjWqYRZM0XKTAvsR7g/DO9OZ?=
 =?us-ascii?Q?G8XvJ0SqFyN8AvbroVijyo8M1ClP3mbecc+mg5Z6ZLXuUm2A5QP5cTxCuRHC?=
 =?us-ascii?Q?as2rIqz0vMZGtuUT6tojp08o3XyJ2lO/6PgijXx9XKQF0FYd5kgN9rlRINZE?=
 =?us-ascii?Q?v2v4vMQqsNFRxYU8s+roFbU0l/bX8QmyiThg/dPvfZTwyou0foy3ZX/tmyOG?=
 =?us-ascii?Q?byBUuDsMj97x0Rjzi1hAdVM09z3nvkdVZt1I5pNJEVXapfwNPVOtmZLNS5W7?=
 =?us-ascii?Q?DjKdUW7uw4eYy1V7ph5abA0WNT3GvrflnY8brYvOB/cYN5LynPV8kyfBAs37?=
 =?us-ascii?Q?opdnd9d0lHpZr0FywDprvw9a56a/4Dlrs+re6zC5f5SPawl4QQ7E8g5aeP9E?=
 =?us-ascii?Q?p5jJejJu8G8VrBl3dbZ/a5HcJJMQROGuA2GrZ0VFt8Q0fGDtpTMYhnOWHd4C?=
 =?us-ascii?Q?NyuZ+YH1bcCbyWcYG6Y=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa5ca3a-a43a-4796-c3da-08db2492987c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3428.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 13:47:04.8164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lQzKEncIBrUvtXc8S5hloaL3Ffxv3M42cYTsFa7l84FuK92FUcfV1VBLJ9OnVgy6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9895
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move common codes into smaller inline functions and remove some argument
handlings that are not actually used by either S32 MSCR register or generic
config params.

Signed-off-by: Chester Lin <clin@suse.com>
---
 drivers/pinctrl/nxp/pinctrl-s32cc.c | 82 ++++++++++++++++++-----------
 1 file changed, 50 insertions(+), 32 deletions(-)

diff --git a/drivers/pinctrl/nxp/pinctrl-s32cc.c b/drivers/pinctrl/nxp/pinctrl-s32cc.c
index 7a38e3216b0c..9508fc1e9a90 100644
--- a/drivers/pinctrl/nxp/pinctrl-s32cc.c
+++ b/drivers/pinctrl/nxp/pinctrl-s32cc.c
@@ -39,6 +39,9 @@
 #define S32_MSCR_ODE		BIT(20)
 #define S32_MSCR_OBE		BIT(21)
 
+#define S32_CFG_SET		true
+#define S32_CFG_CLR		false
+
 static struct regmap_config s32_regmap_config = {
 	.reg_bits = 32,
 	.val_bits = 32,
@@ -475,32 +478,57 @@ static int s32_get_slew_regval(int arg)
 	return -EINVAL;
 }
 
-static int s32_get_pin_conf(enum pin_config_param param, u32 arg,
-			    unsigned int *mask, unsigned int *config)
+static inline void s32_pin_config(unsigned int *mask, unsigned int *config,
+				  unsigned int bits, bool set)
+{
+	if (set)
+		*config |= bits;
+	else
+		*config &= ~bits;
+	*mask |= bits;
+}
+
+static inline void s32_pull_enable(enum pin_config_param param,
+				   unsigned int *mask, unsigned int *config)
+{
+
+	if (param == PIN_CONFIG_BIAS_PULL_UP) {
+		s32_pin_config(mask, config, S32_MSCR_PUS | S32_MSCR_PUE,
+			       S32_CFG_SET);
+	} else if (param == PIN_CONFIG_BIAS_PULL_DOWN) {
+		*config &= ~S32_MSCR_PUS;
+		*config |= S32_MSCR_PUE;
+		*mask |= S32_MSCR_PUS | S32_MSCR_PUE;
+	}
+}
+
+static inline void s32_pull_disable(unsigned int *mask, unsigned int *config)
+{
+	s32_pin_config(mask, config, S32_MSCR_PUS | S32_MSCR_PUE, S32_CFG_CLR);
+}
+
+static int s32_parse_pincfg(unsigned long pincfg, unsigned int *mask,
+			    unsigned int *config)
 {
+	enum pin_config_param param;
+	u32 arg;
 	int ret;
 
+	param = pinconf_to_config_param(pincfg);
+	arg = pinconf_to_config_argument(pincfg);
+
 	switch (param) {
 	/* All pins are persistent over suspend */
 	case PIN_CONFIG_PERSIST_STATE:
 		return 0;
 	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
-		*config |= S32_MSCR_ODE;
-		*mask |= S32_MSCR_ODE;
+		s32_pin_config(mask, config, S32_MSCR_ODE, S32_CFG_SET);
 		break;
 	case PIN_CONFIG_OUTPUT_ENABLE:
-		if (arg)
-			*config |= S32_MSCR_OBE;
-		else
-			*config &= ~S32_MSCR_OBE;
-		*mask |= S32_MSCR_OBE;
+		s32_pin_config(mask, config, S32_MSCR_OBE, S32_CFG_SET);
 		break;
 	case PIN_CONFIG_INPUT_ENABLE:
-		if (arg)
-			*config |= S32_MSCR_IBE;
-		else
-			*config &= ~S32_MSCR_IBE;
-		*mask |= S32_MSCR_IBE;
+		s32_pin_config(mask, config, S32_MSCR_IBE, S32_CFG_SET);
 		break;
 	case PIN_CONFIG_SLEW_RATE:
 		ret = s32_get_slew_regval(arg);
@@ -510,25 +538,17 @@ static int s32_get_pin_conf(enum pin_config_param param, u32 arg,
 		*mask |= S32_MSCR_SRE(~0);
 		break;
 	case PIN_CONFIG_BIAS_PULL_UP:
-		if (arg)
-			*config |= S32_MSCR_PUS;
-		else
-			*config &= ~S32_MSCR_PUS;
-		fallthrough;
 	case PIN_CONFIG_BIAS_PULL_DOWN:
-		if (arg)
-			*config |= S32_MSCR_PUE;
-		else
-			*config &= ~S32_MSCR_PUE;
-		*mask |= S32_MSCR_PUE | S32_MSCR_PUS;
+		s32_pull_enable(param, mask, config);
 		break;
 	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
-		*config &= ~(S32_MSCR_ODE | S32_MSCR_OBE | S32_MSCR_IBE);
-		*mask |= S32_MSCR_ODE | S32_MSCR_OBE | S32_MSCR_IBE;
-		fallthrough;
+		s32_pin_config(mask, config,
+			       S32_MSCR_ODE | S32_MSCR_OBE | S32_MSCR_IBE,
+			       S32_CFG_CLR);
+		s32_pull_disable(mask, config);
+		break;
 	case PIN_CONFIG_BIAS_DISABLE:
-		*config &= ~(S32_MSCR_PUS | S32_MSCR_PUE);
-		*mask |= S32_MSCR_PUS | S32_MSCR_PUE;
+		s32_pull_disable(mask, config);
 		break;
 	default:
 		return -EOPNOTSUPP;
@@ -554,9 +574,7 @@ static int s32_pinconf_mscr_update(struct pinctrl_dev *pctldev,
 		pin_get_name(pctldev, pin_id), num_configs);
 
 	for (i = 0; i < num_configs; i++) {
-		ret = s32_get_pin_conf(pinconf_to_config_param(configs[i]),
-				       pinconf_to_config_argument(configs[i]),
-				       &mask, &config);
+		ret = s32_parse_pincfg(configs[i], &mask, &config);
 		if (ret)
 			return ret;
 	}
-- 
2.37.3

