Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A52E717A55
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbjEaIk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbjEaIkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:40:23 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2122.outbound.protection.outlook.com [40.107.117.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B7210E;
        Wed, 31 May 2023 01:39:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fmKkTNqBxCM1Cl6hfA9rhN+fMT+gu6lVTP6CPkep2PK90CGl4dYCcPpQ0RBwrnXbYUS0wXjtuMk+QPlfzfPdwV72y1XJ7b+FwcLpiFz4YlAO6Csg1X1Hwj5Iq5kTEJO9AlJF9CpidUW2G7Nwwl8e/JlpBOqMY+qw3SuCE0HzAMRl8/boSa9ZmtjjFfI0LriqxaK/k8EgmkvoIGf84znR8dH/Zd4uQLZBYgOq1GE6GGtU8t+OR9HrwMInOvi4kF9xi+0AyKbHRfUZkgS4Qs9l/kt/6xkNQWjeOjKi1kySuIMrCE0Tg6e0lY2IDH6LMEoEQPqtQjoxdsfEaOVCommZHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOAnxc8uaZ68rhVQ7n4++WhrCeACj48VBHhcXVgh5R0=;
 b=baXSPGKTM3gglIIALpMXZSkrOoLjj1dIkYS6T6z74HuTnyMLamZHvszbVlfVcLiAdxIaE6jjG8FxYozva0sl8AygzRkEdZYhnUFIvL1wyHA3+zDwJcY4n7ugZr2YB6UMdZLNvpamMl/tx0qssxor5DyfCipcfnRHQZKn8/kI+AjdtSBemx8x10MAmkJlcInFh3P2w7Sznyzms1T77CvGY4kF+1r9T0r2hHzRgNzQApd9n0N1Lrlagknui+0yGUpQJInXdamSVLlVxvwStpwfciZiUqjPW1mUyf2cCcfMBsrTjB2yyf42babEGVjtScrX+ktNJrtSdtSIIpkEg7AzMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOAnxc8uaZ68rhVQ7n4++WhrCeACj48VBHhcXVgh5R0=;
 b=Uy5rT0weitl1HQd75jd8ODtsOo8GU+faXU3Tdfv1iTDAyyWOGn4wYmnRe5/Im4GFyMqM1cvXHQQVfFoQIywCuYMG4s2Al+GaDrgI2/jULaLzWn9AIe+tEjTYelppDscI7Ec1Rbp6p8mNeyC7w14WK52zHe1LNUvL0S5465LoxqmHW8vWYp5dxgLyN/rRO4P56sR3dnODmlDdTQf4kEzE5RxX5TYPCuzUxGfaUi06v67taAF6MgiHpP96TNqIxgMmKQwaDmDEw6Kn2jhb2+lwTUtA+NypobJq/DLGsxG3IhjRa8YT06rkxcnZb+hsOYhv5Z2Gxf7v/HvhB1bUy40G2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by SEYPR06MB5765.apcprd06.prod.outlook.com (2603:1096:101:ba::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Wed, 31 May
 2023 08:39:26 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e%5]) with mapi id 15.20.6433.018; Wed, 31 May 2023
 08:39:26 +0000
From:   Lu Hongfei <luhongfei@vivo.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, luhongfei@vivo.com
Subject: [PATCH] soc: qcom: pmic: Fix resource leaks in device_for_each_child_node() loops
Date:   Wed, 31 May 2023 16:39:15 +0800
Message-Id: <20230531083915.513-1-luhongfei@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0162.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::17) To TYZPR06MB6697.apcprd06.prod.outlook.com
 (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|SEYPR06MB5765:EE_
X-MS-Office365-Filtering-Correlation-Id: 529c0a89-e6c2-4beb-af6d-08db61b28a8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L1nUui7AqFrQAUSernJFXObVu0rm4pUsx81e8+2t/3y+54BmlX0lIt5q30oNDO6sjo7yqRpH249d7HKnNQL93hyLxlLs9ZjUV3UbB8cT2tzii0vsevOS4DoAnUErnc4kgMGTlswVzlDHxnZGSoPtONxW3jYLA8LXaDvFZKdkhYF5ox8jJHRqzKZqfR+HKLA5xWvR+LRpdGOlg/Z8yuD0GaW7BeI4lg1+O+XCsuFpn5vmDKs/jAE3tjbm+POeYEoR/4cwxkkEuQ3rpD/OUpLkmQ2RnoRHYvluGfajbgbO0ShWe4d/kAjf7LcIFPSYE+5hIeWig12N4Miu1gw6TiYKa43vyPWLtBZA1Bf0zR2JvFZzx2d1IiMxLrILjbCY65y4OxYEw4AirVOR9H7GhgLYXUl/2LM5HbsmiXex1dq0qVGuuCAA+O3iKYCRXBLf+SA+9jKbX0bFb4Cvr/OJMTwA78GjsAtFuhSYCB1awzONRV4CuahCQioigLsKi/5tkf+XgKJ1pX+yv3Y8ySqMuMUD9sqE2C4nLwe5YCOP2Qk3et1gC7g278H4GWsEzA5yiQswO/jlet4iOpvnJ4UGNLcaEY76EtITBHRDxZz51HuhTMcURd3VZ/W2ywOP8MkQqCi3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(376002)(346002)(39860400002)(451199021)(110136005)(2906002)(2616005)(6512007)(186003)(52116002)(6486002)(6666004)(86362001)(107886003)(36756003)(1076003)(6506007)(26005)(478600001)(83380400001)(5660300002)(38100700002)(38350700002)(4326008)(41300700001)(66946007)(66476007)(8676002)(8936002)(66556008)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ewl5+4mGBR4os13kHpcd+C2qUJxiHiZQb7YP0UH4FmIrTfJn6AiZuhCcDynb?=
 =?us-ascii?Q?2WAk1qitBR63+/QDscuo4mdy7XRRfpexC819EdFWg9BLgltDoXO0Y7qssIaz?=
 =?us-ascii?Q?MI6tIBt+0IVnMdf82ThJmeTypW7H/hocH46U2St1xlZftFL7/DJ+ED40sP+b?=
 =?us-ascii?Q?PGQH4ve2gzvOi4KY2CM2qX8QFH6FpXJhAAa62v24M40HrrjhIC9xSJc858YN?=
 =?us-ascii?Q?AWgOioJtar/y2VDwq0qr/v+hSrMPoUCxc8BACiOMDeVcpwOiTRKGbCQSOK2o?=
 =?us-ascii?Q?DOHfSJshNSJUYQVm8tPmapQeIU50fzI30CPf02VQSL83d0b8JEQYH3V3nJPH?=
 =?us-ascii?Q?DeAKuC24qhy4aIyDS7ECSc5mBx8trz3Y9aS7xMoUlf7qDVOL2ths4I6xIXYO?=
 =?us-ascii?Q?r4USVq3TmeUPcDjBz/0yMjsO1YiWpqIjFI3avdU8VWwlw+T1bC9xcFa9gB2v?=
 =?us-ascii?Q?Xv79uZ72SYtHer7bFg1h2AWeqQagsgKMNRhzzf4lp/L1T2hHbyH+ysiGLhYd?=
 =?us-ascii?Q?wBdmpk77JeWVe7m8dZMBui4FL1RSnYcDeeRP0i0elFc/7l/p6bpwwLEkIYUO?=
 =?us-ascii?Q?IxG+1JJiTg7V7eekqcoH9B/fXoZd5Pf3j2uqkZwS1G6NZGMJiAyXhzT0wwdS?=
 =?us-ascii?Q?sxcacLE7bUrtKaZUnVyHVqZJqz9VtXnb2io3k0itdNB2W+GMwAn5CyztwO6v?=
 =?us-ascii?Q?86Lb2RjvvRhDPMUMYE0UVMBp4AxK9zeWLetvZr135QM3WbEud0qMR2aqw+yZ?=
 =?us-ascii?Q?XfxGUAr//LDsYItdDoG/gJshY7LrQpKOkd+4DtvzUMID5XpN3WgZHPpO6GLH?=
 =?us-ascii?Q?54vwbFobUAr3BIyEwK4gdnHLZBVLBzZTph5Ui/i+42PKVEyM8ipMQmSUDIbZ?=
 =?us-ascii?Q?2LV2PQhz1vwNWl+v9hKZELIBBD5zCW4zqyYlXU3XF+uOiZ1MfqV8DAau2LDZ?=
 =?us-ascii?Q?Vc3P9Q4DV4EEXi7CGQwn3BT7ZLvmF1Y4RDWHaGwWECi2svhroRRVGmbrZCB9?=
 =?us-ascii?Q?d2lsqyy8Jp9bUpsurjI3MZLYjVV/209z4t9VbukzoFwpAKFkRB5A4r1i8Y+e?=
 =?us-ascii?Q?F9qPc+hZCUUzOooEWiLco9Wk2uKsni5f3vub3v/vilhkha/8fcQvyH7tsFv6?=
 =?us-ascii?Q?wu/jxaGmRQQUZcbg38SOPHcI8uv3iiBukGD7VbOoPM2iOuX8K4VmxvIR3hD1?=
 =?us-ascii?Q?dXjpn/2+t/eH02KzBJNl+ess19aSHO0UMRHZqy0GL3CWm4s8w0QHQ+zQOT+F?=
 =?us-ascii?Q?/5WsWlRuCmcsxrqVDaMpXBNa3pOedQ6nlzHCQ60TzUyTmyTJ00cBdwbiNPXq?=
 =?us-ascii?Q?PLj6Mft/DEbkjTWYLJo07ih9C1e4qMA492qHblpOWscqttr5LBPuJ+nRajka?=
 =?us-ascii?Q?rvYphiRt7jEbFi1lRUL6yLdfVl3EIp0ZrRF/FVULQ2WyFVDLV6cNJoYeeOK4?=
 =?us-ascii?Q?J2vEySjon0T+KdnHsV8kOzkZ8FEHDRUIl/HCaAkNBZFaN6sVcXWCx5RWIyC+?=
 =?us-ascii?Q?jve4Am6y/mYhRfMnuRuguazjVWfRlCz7tBoUPbmH8qM565xB4xyxGNg6AE7G?=
 =?us-ascii?Q?2v2O+t1uzMp6GxFKGM4JOndGJ+c1dbFyzT7qYEAJ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 529c0a89-e6c2-4beb-af6d-08db61b28a8c
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 08:39:26.2304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q5LPaFGNxKAnWLnjB0c4qe/gKwncSTZVK+O6bDJULjX4eIDm/FMq1NmIG8FpL7AjKEXWZrpesyoOJh+4XIffLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5765
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

'Fixes: 080b4e24852b1 ("soc: qcom: pmic_glink: Introduce altmode support")'

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

