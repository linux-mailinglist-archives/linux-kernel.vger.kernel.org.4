Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA38717934
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbjEaH5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234909AbjEaH4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:56:44 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2119.outbound.protection.outlook.com [40.107.255.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3A4E45;
        Wed, 31 May 2023 00:55:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L7fL5tu89idcloRtpJkjXVIFcAnSoqnnPivdHSP14UVY568wV+y9dv2Fynzn/A24Smli/kUCejNaqWcDyVZb7CS8cDn03QoQU8xd4/ApDAL4/mCB9cTQ9g0en2Hs514JWH2xg02wzj0kQsbC3iE3flCjRTEYsFVsh4vIZ7hFfrPSkWoKXojKnzyX8UGofTjP21WlVrZh5cXt00C6fJ+vkySloRy3JBPZN+T4JIV4vVaHeTGxYKeJzXxEdG7biEvZDhacbW313ioNxLXSALdLnI3eS+7JnJy8HunVVXG5DI9S5dlS2EO3P2Zsjmp0tGHP933jE3vveMREmZtaUPBm9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhzVdXyhqzuGvimP9ysBJkCuVgSTWlCBkxk0aAYFj58=;
 b=Qp83gskFoSRfRfnB7VSc84F/vRmQvviGjMn/K23ATEX/x4knsmseHcnrMsZUcK69STT1MXDjj/Rz3fPzIYyl41QpsufsDF76SmElG3V3m6HAHn1lIo21VIqDdPO9mfTPZNSPiiXuet9kWrHfVPPz6RLx35DILxqx0BxXaXwpaufxQDkf27aSmHmiMVu+Fy5YbwWPe49htVs5nHluGolc3HJ3g+rmGw264oUXQfrHGQyMaMV1ekNcXG/WHTK7yh5LfzPb36doH0oq07TwRdmkzlGv9zO4UhKeO8l9G7PGGgq6JBQUs8fUipmyuxqHzJ+ctGJvBgRhMbl38fyunbW8Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhzVdXyhqzuGvimP9ysBJkCuVgSTWlCBkxk0aAYFj58=;
 b=QrH0GYr0BsVw2OmXxA+6JGyBk6Qkq91XUM3xMpWUPsEkjG3wzO8Yf/Yn0tnUWWoYweZNtbPewjLXJF4LBsbavKRiG6oFEPAJoiwb3kQd8ew896iZxFNDOXqLb0d8dxdyODdFB3bwBl6z5B1jiF6KrHDx+jvCFh9gxvJTk2MmVxE4QasuHma3SHg/6yCLy6fVuIo3qDlqiQUzPN74AnQNRD4jFeiQlYGE8YHZEblBMvFta8ekOPYzyfv8KbDivirZgz+yNCIxZAxrqThczFmWf8xN8YLD2oU1z3jvTZGXpJfwMRZgBcvLGeKmAM2OVLx065cMDCHXZfh+dWlBCTiecA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by KL1PR0601MB5551.apcprd06.prod.outlook.com (2603:1096:820:c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 07:55:23 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e%5]) with mapi id 15.20.6433.018; Wed, 31 May 2023
 07:55:23 +0000
From:   Lu Hongfei <luhongfei@vivo.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, luhongfei@vivo.com
Subject: [PATCH] soc: qcom: pmic: Fix resource leaks in device_for_each_child_node() loops
Date:   Wed, 31 May 2023 15:55:13 +0800
Message-Id: <20230531075513.55182-1-luhongfei@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0015.jpnprd01.prod.outlook.com (2603:1096:405::27)
 To TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|KL1PR0601MB5551:EE_
X-MS-Office365-Filtering-Correlation-Id: e06a9905-e936-4c99-f0a6-08db61ac6314
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G96DibOagTX0lr1cUNNDpWMDvQcsf337jHl1vCshbnygp7vYIE1VUsI8kHQ0fmFDQMMYeWeDnAkwRtLdtnPoekvIzNUftIZJdWC6VC1ZdDdJkA+G2cq7tgJm9+8n0mvpqK6V9HcfMkLFZKp9cQkQwvrRiuR5hbYpLVQ0sQJ+cVqjrU7c121Dh/GSFRfiHvg9zaIuuiQTsJljh9LdCfoFqQsk8XNkDeT0+IxTRcqTQ0lyUuyinjlUnMGJw8Vb/KGoxycZ/2zi2YDlZ5BzutXYl5/H7OjUnyGlCtJsIAAYB76cNjBtuhH/qcXT0YYIZUloQNGdRwRuXzka6hiusG3chxwXCKxBPlNTaFtY3Sn4Ory5sx+74AmCV5KRu9YDNxr6aIGF+kB4qqLu8QFgEMcRYiC3C4eiCfX2cjb4FF+307TQ92O3IQ9Y4qU5HGwzGbNZz3oPqZHmr1Bd5wNqvQcNJThoVM8f8GCDiEpBWF0a7+xffBhnoN+RgouQrCD9pSou6g1lpEQSez2Qwe4Vj7nfWnLn1Fzej9KGbSZqQDymMXP1ELwPVba+N73Vq1nS3bx4zLtKCVVcO/4gaDfE76ztKnlyvgHvO2luWrh1ayL4IqETPAdyvOX5eMmanmHBLzjf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(366004)(346002)(376002)(451199021)(66946007)(316002)(107886003)(110136005)(4326008)(66476007)(66556008)(478600001)(36756003)(86362001)(6506007)(1076003)(26005)(6512007)(186003)(41300700001)(5660300002)(8936002)(8676002)(2906002)(6486002)(52116002)(6666004)(38100700002)(38350700002)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ATwFXqEzy0YPO7KoABkuDd9+GAetoGXMBwmo15fqH83uJevbeMGqVQb3uW15?=
 =?us-ascii?Q?d+SiGwD6p3/UpaONbCKWbpBKATq9qqcNdIiUHsm0TtgJ49TmjQL0QVz86Mtr?=
 =?us-ascii?Q?hUo+T3QX5wVmvCu12uCNn4q4OljlC4j8U6bAqLuBI250uMDgB3Tc6I93VtLl?=
 =?us-ascii?Q?24/3G2SvUsyo1xM8zmhAK3XjlyXeN0rYMn7fmeZtTe7YollG9KS3W8OqZQge?=
 =?us-ascii?Q?urAxsJPx4CnuiJSYUhhuhuC4iC8d18kbZTDhsZeU7EFH2AuXYjK2vagelXxL?=
 =?us-ascii?Q?OSvozOjtpP38curCsRgQDCOnVugaR20AiuZJWmhwpxphFM8TX2oNYkTX5KhP?=
 =?us-ascii?Q?9GSUUSX9I3S1HabUExzyUNC4UG1IaiGTsxTueM1+mS/lfEt7Yx8S/7jglhAO?=
 =?us-ascii?Q?xWG+kmkEwFexBJ/hZBkUvPDV/8b7MaxA9VH9AAYf3arrr1Us2YWa7YgBF6p5?=
 =?us-ascii?Q?ZMZrCWPqKXb6YjATd58XqdSLcZGQVT4evv1Nq8Q0eGrdmYID7ZuOoVO3h8dq?=
 =?us-ascii?Q?+YX+QoapjEz5+UXcQDFOdRKaL92n3cuTwt2CeTp4prdMbEei3vqJVsd4o//S?=
 =?us-ascii?Q?VsLXdG9ZA/7gtfhfIAxxARGRQW3PpAoem3PdQ2MPlykj/VeI3oKi9QnKZ1UZ?=
 =?us-ascii?Q?GkoyzfPbyBxKrvI05qsYO6XlfFTawkWBkb500JUbHNNDXns1WTkcpPPWK+rT?=
 =?us-ascii?Q?St/S7N2oKf+ROATGPEQpX785Wjuiycxw1enhicFauvws913oYIzahj30NGpH?=
 =?us-ascii?Q?U6xC9xOZALwwXfcC5pgNGXkjmaZuVT9YapbUObqfLKewNmT4rNO1Askj0bwv?=
 =?us-ascii?Q?AXyArIl+vLXT2CL7Hre1HdJSicOJA8W8IpDmJOk11TFCFI7f2TZUhlljWSYM?=
 =?us-ascii?Q?OyEF5G+7UFesNZn23CJLCvvSE75mi7ZVI6xoobW7NIXDJDknYT1qdNcxkUtL?=
 =?us-ascii?Q?ajmDyERSpLYPq/LcE5HlhdaXQoihtg976BYwf52UNA855u3HWq8kT+ZaNovG?=
 =?us-ascii?Q?7CDFEfr3JLE5C2tPCsLaeriOBva5FwtTdt+SFrHsSCcHHHdzWhOmP5tvOC7Z?=
 =?us-ascii?Q?WQBAa//37RdRq+VsnkdlbpQU+ZsPlqnfkifZE5ERKOpohrT71Gt8jaeDLFy8?=
 =?us-ascii?Q?7XrghFr7wooSWVdcXy7xg9UW4c4CQU6MQjFNDSs9MLfhUksv5IYyqfseEVwr?=
 =?us-ascii?Q?N75pFpI6dZ7+/lj4YPPtbZ+pmlVjMqNXD3t9quRLc+g+Ijkozba0dUpFWmPh?=
 =?us-ascii?Q?iVok52VLrYrvSTG+APbDkMnKEt0kw1BaWf4CHuXlW6eecy0NUGZ7ZRM5H3cQ?=
 =?us-ascii?Q?qBnD0KEMZGKHfNHBGT9V7DyW6j6s9rRseafMfV5W+mDdz+snCpolwoYmyUxN?=
 =?us-ascii?Q?lk2bGNB89lvNQmQKcDeE0NE6AAaPAe3A8xbJcnwiwn/fFQDxJq3y1kUfF4G3?=
 =?us-ascii?Q?Bm5C0w/fNs4lc4HdNJ1zVfX88NbMygOmyUS93rapcyRI3SUa4vRj4jacRKk8?=
 =?us-ascii?Q?9iibAwtA222ysbVKyuO4+SIVra+7XQMurl3CcZ3+pwPPch75M76wIOLIgqvO?=
 =?us-ascii?Q?6ycCruVgVc8H5sQg/4aI9uew+EHeel0/H2zEGy5m?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e06a9905-e936-4c99-f0a6-08db61ac6314
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 07:55:23.0164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +SOWLCXGby+H9+0Bx7X+XlFD0q05cgAN5P3YyuQs6hHaeCBNUcVmIU7pZt9gE+k16hiIctgPSIEyNIyZDdOCjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5551
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device_for_each_child_node loop in pmic_glink_altmode_probe should have
fwnode_handle_put() before return which could avoid resource leaks.
This patch could fix this bug.

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
---
 drivers/soc/qcom/pmic_glink_altmode.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmic_glink_altmode.c
index df48fbea4b68..a7fc6570fa1e
--- a/drivers/soc/qcom/pmic_glink_altmode.c
+++ b/drivers/soc/qcom/pmic_glink_altmode.c
@@ -395,7 +395,7 @@ static int pmic_glink_altmode_probe(struct auxiliary_device *adev,
 		ret = fwnode_property_read_u32(fwnode, "reg", &port);
 		if (ret < 0) {
 			dev_err(dev, "missing reg property of %pOFn\n", fwnode);
-			return ret;
+			goto err_node_put;
 		}
 
 		if (port >= ARRAY_SIZE(altmode->ports)) {
@@ -405,7 +405,8 @@ static int pmic_glink_altmode_probe(struct auxiliary_device *adev,
 
 		if (altmode->ports[port].altmode) {
 			dev_err(dev, "multiple connector definition for port %u\n", port);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto err_node_put;
 		}
 
 		alt_port = &altmode->ports[port];
@@ -420,33 +421,37 @@ static int pmic_glink_altmode_probe(struct auxiliary_device *adev,
 
 		ret = devm_drm_bridge_add(dev, &alt_port->bridge);
 		if (ret)
-			return ret;
+			goto err_node_put;
 
 		alt_port->dp_alt.svid = USB_TYPEC_DP_SID;
 		alt_port->dp_alt.mode = USB_TYPEC_DP_MODE;
 		alt_port->dp_alt.active = 1;
 
 		alt_port->typec_mux = fwnode_typec_mux_get(fwnode);
-		if (IS_ERR(alt_port->typec_mux))
-			return dev_err_probe(dev, PTR_ERR(alt_port->typec_mux),
+		if (IS_ERR(alt_port->typec_mux)) {
+			ret = dev_err_probe(dev, PTR_ERR(alt_port->typec_mux),
 					     "failed to acquire mode-switch for port: %d\n",
 					     port);
+			goto err_node_put;
+		}
 
 		ret = devm_add_action_or_reset(dev, pmic_glink_altmode_put_mux,
 					       alt_port->typec_mux);
 		if (ret)
-			return ret;
+			goto err_node_put;
 
 		alt_port->typec_switch = fwnode_typec_switch_get(fwnode);
-		if (IS_ERR(alt_port->typec_switch))
-			return dev_err_probe(dev, PTR_ERR(alt_port->typec_switch),
+		if (IS_ERR(alt_port->typec_switch)) {
+			ret = dev_err_probe(dev, PTR_ERR(alt_port->typec_switch),
 					     "failed to acquire orientation-switch for port: %d\n",
 					     port);
+			goto err_node_put;
+		}
 
 		ret = devm_add_action_or_reset(dev, pmic_glink_altmode_put_switch,
 					       alt_port->typec_switch);
 		if (ret)
-			return ret;
+			goto err_node_put;
 	}
 
 	altmode->client = devm_pmic_glink_register_client(dev,
@@ -455,6 +460,10 @@ static int pmic_glink_altmode_probe(struct auxiliary_device *adev,
 							  pmic_glink_altmode_pdr_notify,
 							  altmode);
 	return PTR_ERR_OR_ZERO(altmode->client);
+
+err_node_put:
+	fwnode_handle_put(fwnode);
+	return ret;
 }
 
 static const struct auxiliary_device_id pmic_glink_altmode_id_table[] = {
-- 
2.39.0

