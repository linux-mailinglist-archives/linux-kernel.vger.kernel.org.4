Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3366C8005
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 15:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbjCXOh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 10:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbjCXOhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 10:37:51 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2071.outbound.protection.outlook.com [40.107.22.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE9322DFD;
        Fri, 24 Mar 2023 07:37:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=buxsYivCrlCFimFQJz5x9N7rxogleg9cSy18q+ACV6Amvev4kdcpNAW6sM855WRY6U4tpfy7rryTlmGvTOnB/KRlQymXush6APVvmDers7GGZwsfvBf2/mVz//1d6LRzJM0nPeLPgGRcL3vLVcZwTmo6WYWpIuFssLXs5+HAzPYLM4/AFMUNmunpVe7/NA8mk1tFTkVS3KgfnjCh/x/QKhGsd9L3Xsuy8jJHr1jFbKfxcReFT3vUtcZFdGEzYf625A3zpRYY5Dh1X4It5ZlS9D+ZXQA+g9H29i1EkxhO6ApEQaglzx4GTHG02WwUosq4Dy4g+war/zHIHLtgyRpGJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ZRs/jyzaHHU9yyQ5B/+4/wBwOdzvv9NMFuYlMaN61Y=;
 b=cGzgWttJlMdxoPydE9As+KQfTTANOWGTNcEr3eUHq1FLXFgpU86tTPTo8AQIEgbipLGYbjrFr4ahUOMvbznKvnF4B5MqQuL2R7hVdLasEl1/84OP7TFJfaTU2yCDkATVDSQ91ODRx3XgtrMDUAsiYCM8OvyRn7AuKmCLb7UrA0nrbowXVx6DpDMu9u9tpBWSPuImxlLXiH5r8ZWDlRC06Fsnsy9YrBeWKKUPq4mE5CF7bty+CKZZGQZoqh4/9ZbzQmdU+Hyb+5/zJpeYL5b/VDRfkvfOXwRJxlVdrwaFUF/siuo1oge1cQou3JoiXDIvVGHuHe3qSsSy89/kA3oEZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ZRs/jyzaHHU9yyQ5B/+4/wBwOdzvv9NMFuYlMaN61Y=;
 b=Xl1ZXlR9Peszu72hJUfw0AdDZGeLNLHa1ARBvLK0fFJIUm3Xm0dMgI+rrB2ygx0jlMQibsomm5peVSMAZS+RUomDZ1AjBynlXkNgejusvL+yLdCzFlWm+8/BN0RvN1/zg/4Clf8meF59zbKmdvlUk2azcEUDdKnded8gt7Av0oIoYDHkfIhzLPBP/9K+NOVwGM4MB9yPDiK4YCXyqrFfSA5DwTr+9pI7X3dnySRK1XcqJq6Bv/8qY+ckxZTwozZC5COp0jDtUeJdmYuMJXvzEfP+0m9JutmPcwZvADo6JZxmy9HzYbe32jepfyRS4XUBXvECtvSV11VZCXpaJAcehQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by VE1PR04MB7454.eurprd04.prod.outlook.com (2603:10a6:800:1a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 14:37:40 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f%2]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 14:37:40 +0000
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
Subject: [PATCH v4 3/5] pinctrl: s32cc: embed generic struct pingroup
Date:   Fri, 24 Mar 2023 22:36:24 +0800
Message-Id: <20230324143626.16336-4-clin@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230324143626.16336-1-clin@suse.com>
References: <20230324143626.16336-1-clin@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0031.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::19) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|VE1PR04MB7454:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ec24fef-1540-470d-f56f-08db2c75520f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EdS7LRVUPH3gN2491dBjhOszW3sSzDBeH2Ax2c85rA9EXh/kxzuQruvd7lEPg0yoieJwoUnx6yRZkTO8N+Ts0EpLiSKxzCngYI0hYC9gf06dZKp2rwBDq6Q2jnKJuD/g5j/SJAVfZ8E0myNNF9iNe+YRlKouKNRM/gmQ+cvMCqWgaXHEgBz/SMX4MuTSUOa2HAs9JrXNgaVR+jt78Qmvw4UoMZ0aT+TCg5h9EYeugBpCd2nGHXIKb088gw46GgLiIw84FgKDdwYKBKtVYy2VioOXzhJdvVsRQeLxs8yGYuiyj2wfaDHkE7le4Qx9lfhAailCChFX5s/0OpgoiK2oPlG1r2OFn8m5tSSvxl1Nc9YsobCobrlMSUw5XycH6PIX8SCEfkF3fxq6o450vTREpFNMwkiE5HteT+0RgSeDEHtrmyfT+ngb2DtyMJmlzXh4q5GiWqarU+w6g75CH1KqhBbZofD43KjN5PmCs2HT4PqtIuEuVUqIy5x0Ymlc06ce8dPcSfPvaryUEE9TRLPOMUKrdCZ+4e5eVzGyzJ6uukBcphfK3bP/F6hGXmIu5a2xDh9NUpAceFsVhgbZEzQsOalTJceSLzMVfy5pADD7B60rdj8Ru4fHxUftLAn7Qs8JqR7caz3rZWS2Hns9jnzNEzcAhtqPIYFCjRC/MlXl12Ski5LSQde/d4iSWWOnjy6I
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(366004)(136003)(376002)(39850400004)(451199018)(8936002)(66946007)(66476007)(66556008)(41300700001)(4326008)(86362001)(8676002)(36756003)(38100700002)(6506007)(1076003)(6512007)(6666004)(26005)(83380400001)(186003)(2616005)(107886003)(316002)(6486002)(54906003)(110136005)(478600001)(5660300002)(7416002)(2906002)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0/qxAM1Bw4O96uboU/sgeR0+NzlL9/fF7IoQswweVROZZphcSD363bl+GAMA?=
 =?us-ascii?Q?79XD6v7pSn1rTVT85QYUD9aTDYaxlS5FQSGzyw7nE2Pxm4IJ9Uefqc0MogSN?=
 =?us-ascii?Q?k69KGb0L3sQRJNRTkdd2Q/p2V0MTuLBZYTRPwvd6DZPEDUWOyY9hhYqOyHsI?=
 =?us-ascii?Q?7s6Gc0JZt5G6IVQaBwPO+9Lo33a2wfcFLTGjEJlGhEvA0lvEH1lk29hBPCF/?=
 =?us-ascii?Q?aLV1n6FD2JmnmrwupwrX9CyZRdMFpuWd/+Q1S3ZCUhZjnBEfwCMnLPLosZ0I?=
 =?us-ascii?Q?Bvd24w/Yy6TfOzXp89MoNqiAtUoj1oIhNNemxvIMlHjVdQ/s3q/iC+JEPuHH?=
 =?us-ascii?Q?rezZJArWplPg0aMhw8BgO2v2wmlLvOAdRe3oAGMN4u81ppYb/2rJ8b19J5fr?=
 =?us-ascii?Q?sW7YNUaPinMEcufs5ExxQNmvhRelkQCEgOLM+UZ6y11aH/KiCX6Ae0FR7xkk?=
 =?us-ascii?Q?lazdzT69SJCUWxLwuFjK+xB4BZWglRHNiGZDd79h1ozvfotg9NSItfvZiuk+?=
 =?us-ascii?Q?6vUWiRGWsed8aFMOQ4vTHKaNIbpJEomnKyU7VV/5SHBIFXBlJ4MffOEkI16i?=
 =?us-ascii?Q?vaH/KKYjmiJe4R6/kZDFky2JsutNRGz6M4Jueu+lh8Gm6027MKlR3E/l9ItH?=
 =?us-ascii?Q?hYYH2YeSvWHgV00c5FfdpYSk9KabwC7ffo0ub44BV0ZzBy6Hhz7gk0wDtfK8?=
 =?us-ascii?Q?7s6hIrCMB0XDY53w6cLn7GSVX8PC5H/75+OmDCUplodAoo5HioaVg2sVqeP8?=
 =?us-ascii?Q?CW2oTCHHkdgbNbMAf+6/MibcDldKQb977ntrV82w1MfHYmhGN3BzB6AtFilW?=
 =?us-ascii?Q?QY0iP9V55BLzQZ/Z9vVQOHvSfxoAkcY30oG3zUxCrvc1yZAQgSMI/u8P+WR0?=
 =?us-ascii?Q?K+HGy+3jbrbOfDNXQ0JsKEu4frPyifj7VtDXUx1I1G2cUa/E1lhXc+doCA4I?=
 =?us-ascii?Q?6WPKcpLIlA3lYVJgJzokX9wdGl2SxpXUxMDZsg/64eBXVP4XQeZm3X1Q+F9M?=
 =?us-ascii?Q?5Oi15Kl9CMxSHx7pNwag7svQ2EgiUfe0wAdiGSSO2l8jcTAbdV+BZTap5aij?=
 =?us-ascii?Q?Ya8sC2/OuEBBuV6CPcu7Tqu9HnOtXk5hBKWefHXuiBzzq1Orkwx55SCdRX2k?=
 =?us-ascii?Q?lot1FORlJS0pDGvZ2BW0oRRVAHK8amVF/OQcJ1HhOhgdu/ovnfSqH4msJ2e2?=
 =?us-ascii?Q?H0GP14j3OK/Q2LcDPrvIF0zkrtGRUj5+jaLcJscEC18k2j1EPZfkUgZvvHXz?=
 =?us-ascii?Q?qhijuL9Vgi0OhbFpTLuiDcUEw9ZTd9+G9qXKFDYHTMI1tpEseBUC1nUqljOR?=
 =?us-ascii?Q?r9kwV+aLV7R1IwPtSRo/bGaJILGwCX6iUAxSGUFNg960wiMt/DPXTygBWkpG?=
 =?us-ascii?Q?72VBjg1wqHxD3Ve/DmwyUDQ4QebjH1vRQYimniCc3wSIZYSTnyOCgy8+YKv7?=
 =?us-ascii?Q?/riThc4chPPFlSS/xOoTcOuOCu31fwB40G+p+2raJyxEGYwmkhCzVcG4U9y9?=
 =?us-ascii?Q?277aEYW0cXRBjmP7TxmGdU6sAgNrP/A0vKp9Gf3reGZvl2nG+Xat3T6sLPJw?=
 =?us-ascii?Q?R4zYaALfDkWmj4HtAzM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ec24fef-1540-470d-f56f-08db2c75520f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 14:37:40.4817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /HxWb8pfFh85CLfifHJMdGiwpuNX9NkgUBfvqGCCv+StCumILXJ0+cN/GG9iniUu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7454
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use generic data structure to describe pin control groups in S32 SoC family
and drop duplicated struct members.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Chester Lin <clin@suse.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
(No change since v3)

 drivers/pinctrl/nxp/pinctrl-s32.h   | 12 ++----
 drivers/pinctrl/nxp/pinctrl-s32cc.c | 57 +++++++++++++++--------------
 2 files changed, 33 insertions(+), 36 deletions(-)

diff --git a/drivers/pinctrl/nxp/pinctrl-s32.h b/drivers/pinctrl/nxp/pinctrl-s32.h
index 545bf16b988d..850cd668f406 100644
--- a/drivers/pinctrl/nxp/pinctrl-s32.h
+++ b/drivers/pinctrl/nxp/pinctrl-s32.h
@@ -15,16 +15,12 @@ struct platform_device;
 
 /**
  * struct s32_pin_group - describes an S32 pin group
- * @name: the name of this specific pin group
- * @npins: the number of pins in this group array, i.e. the number of
- *         elements in pin_ids and pin_sss so we can iterate over that array
- * @pin_ids: an array of pin IDs in this group
- * @pin_sss: an array of source signal select configs paired with pin_ids
+ * @data: generic data describes group name, number of pins, and a pin array in
+	this group.
+ * @pin_sss: an array of source signal select configs paired with pin array.
  */
 struct s32_pin_group {
-	const char *name;
-	unsigned int npins;
-	unsigned int *pin_ids;
+	struct pingroup data;
 	unsigned int *pin_sss;
 };
 
diff --git a/drivers/pinctrl/nxp/pinctrl-s32cc.c b/drivers/pinctrl/nxp/pinctrl-s32cc.c
index 36f323f87785..e65c88162d7f 100644
--- a/drivers/pinctrl/nxp/pinctrl-s32cc.c
+++ b/drivers/pinctrl/nxp/pinctrl-s32cc.c
@@ -188,7 +188,7 @@ static const char *s32_get_group_name(struct pinctrl_dev *pctldev,
 	struct s32_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
 	const struct s32_pinctrl_soc_info *info = ipctl->info;
 
-	return info->groups[selector].name;
+	return info->groups[selector].data.name;
 }
 
 static int s32_get_group_pins(struct pinctrl_dev *pctldev,
@@ -198,8 +198,8 @@ static int s32_get_group_pins(struct pinctrl_dev *pctldev,
 	struct s32_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
 	const struct s32_pinctrl_soc_info *info = ipctl->info;
 
-	*pins = info->groups[selector].pin_ids;
-	*npins = info->groups[selector].npins;
+	*pins = info->groups[selector].data.pins;
+	*npins = info->groups[selector].data.npins;
 
 	return 0;
 }
@@ -314,23 +314,23 @@ static int s32_pmx_set(struct pinctrl_dev *pctldev, unsigned int selector,
 	grp = &info->groups[group];
 
 	dev_dbg(ipctl->dev, "set mux for function %s group %s\n",
-		info->functions[selector].name, grp->name);
+		info->functions[selector].name, grp->data.name);
 
 	/* Check beforehand so we don't have a partial config. */
-	for (i = 0; i < grp->npins; i++) {
-		if (s32_check_pin(pctldev, grp->pin_ids[i]) != 0) {
+	for (i = 0; i < grp->data.npins; i++) {
+		if (s32_check_pin(pctldev, grp->data.pins[i]) != 0) {
 			dev_err(info->dev, "invalid pin: %u in group: %u\n",
-				grp->pin_ids[i], group);
+				grp->data.pins[i], group);
 			return -EINVAL;
 		}
 	}
 
-	for (i = 0, ret = 0; i < grp->npins && !ret; i++) {
-		ret = s32_regmap_update(pctldev, grp->pin_ids[i],
+	for (i = 0, ret = 0; i < grp->data.npins && !ret; i++) {
+		ret = s32_regmap_update(pctldev, grp->data.pins[i],
 					S32_MSCR_SSS_MASK, grp->pin_sss[i]);
 		if (ret) {
 			dev_err(info->dev, "Failed to set pin %u\n",
-				grp->pin_ids[i]);
+				grp->data.pins[i]);
 			return ret;
 		}
 	}
@@ -606,8 +606,8 @@ static int s32_pconf_group_set(struct pinctrl_dev *pctldev, unsigned int selecto
 	int i, ret;
 
 	grp = &info->groups[selector];
-	for (i = 0; i < grp->npins; i++) {
-		ret = s32_pinconf_mscr_update(pctldev, grp->pin_ids[i],
+	for (i = 0; i < grp->data.npins; i++) {
+		ret = s32_pinconf_mscr_update(pctldev, grp->data.pins[i],
 					      configs, num_configs);
 		if (ret)
 			return ret;
@@ -641,9 +641,9 @@ static void s32_pinconf_group_dbg_show(struct pinctrl_dev *pctldev,
 
 	seq_puts(s, "\n");
 	grp = &info->groups[selector];
-	for (i = 0; i < grp->npins; i++) {
-		name = pin_get_name(pctldev, grp->pin_ids[i]);
-		ret = s32_regmap_read(pctldev, grp->pin_ids[i], &config);
+	for (i = 0; i < grp->data.npins; i++) {
+		name = pin_get_name(pctldev, grp->data.pins[i]);
+		ret = s32_regmap_read(pctldev, grp->data.pins[i], &config);
 		if (ret)
 			return;
 		seq_printf(s, "%s: 0x%x\n", name, config);
@@ -736,6 +736,7 @@ static int s32_pinctrl_parse_groups(struct device_node *np,
 	const __be32 *p;
 	struct device *dev;
 	struct property *prop;
+	unsigned int *pins, *sss;
 	int i, npins;
 	u32 pinmux;
 
@@ -744,38 +745,38 @@ static int s32_pinctrl_parse_groups(struct device_node *np,
 	dev_dbg(dev, "group: %pOFn\n", np);
 
 	/* Initialise group */
-	grp->name = np->name;
+	grp->data.name = np->name;
 
 	npins = of_property_count_elems_of_size(np, "pinmux", sizeof(u32));
 	if (npins < 0) {
 		dev_err(dev, "Failed to read 'pinmux' property in node %s.\n",
-			grp->name);
+			grp->data.name);
 		return -EINVAL;
 	}
 	if (!npins) {
-		dev_err(dev, "The group %s has no pins.\n", grp->name);
+		dev_err(dev, "The group %s has no pins.\n", grp->data.name);
 		return -EINVAL;
 	}
 
-	grp->npins = npins;
+	grp->data.npins = npins;
 
-	grp->pin_ids = devm_kcalloc(info->dev, grp->npins,
-				    sizeof(unsigned int), GFP_KERNEL);
-	grp->pin_sss = devm_kcalloc(info->dev, grp->npins,
-				    sizeof(unsigned int), GFP_KERNEL);
-	if (!grp->pin_ids || !grp->pin_sss)
+	pins = devm_kcalloc(info->dev, npins, sizeof(*pins), GFP_KERNEL);
+	sss = devm_kcalloc(info->dev, npins, sizeof(*sss), GFP_KERNEL);
+	if (!pins || !sss)
 		return -ENOMEM;
 
 	i = 0;
 	of_property_for_each_u32(np, "pinmux", prop, p, pinmux) {
-		grp->pin_ids[i] = get_pin_no(pinmux);
-		grp->pin_sss[i] = get_pin_func(pinmux);
+		pins[i] = get_pin_no(pinmux);
+		sss[i] = get_pin_func(pinmux);
 
-		dev_dbg(info->dev, "pin-id: 0x%x, sss: 0x%x",
-			grp->pin_ids[i], grp->pin_sss[i]);
+		dev_dbg(info->dev, "pin: 0x%x, sss: 0x%x", pins[i], sss[i]);
 		i++;
 	}
 
+	grp->data.pins = pins;
+	grp->pin_sss = sss;
+
 	return 0;
 }
 
-- 
2.37.3

