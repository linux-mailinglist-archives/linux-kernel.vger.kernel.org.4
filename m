Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D93671770A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 08:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234331AbjEaGoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 02:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjEaGo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 02:44:27 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2123.outbound.protection.outlook.com [40.107.215.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3B799;
        Tue, 30 May 2023 23:44:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDDRspWmFPg40Gs/oUJPQMDn27IM0edl3Rsz0m35CqXpnYTkbo2rK8PQzM2qmA+aK2seV5/5nEklVE69wLRbdpQ3RHbaYNZh3o7NESBa6p7C149hj1t9AgFG7WAL0fDbcUwLEdFQ5mobdu0Fzkaacb5do4wJ5Kqp1NpdI6KdDdcPpnKrgIo4zHbueENYvZb3+ABIwXSaO2maXa2UMjuovE24rSltg9v64mW3zYiiOk/Qg63SfXHqXVnzgxsmxLMTRaREYCpcyy8BahBlyzSbr5KZvvdsxZCNLdDY9bHr9Lycs9YteE67aY5jjg1yWsei9gBvB+7Qwh6AQesWZCyWEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=476aC48xwj1+Z4sKWSLbW517PFN+tbPkdTt0YRTgZ2w=;
 b=VRUJ1JRvalsMyOi/44GZ68dluD/jfnYVYOuN/5EmWTMiqPoBujEz/IF2QoyHTzevvCouXymSy40WBd6EWjhnPw9TFC7w47cGhrWiktEIPNnNXIgDdz84xlAQSAKwCPzUK2bhdZ2+7ls3R8Xg/4yCXhi7kpzzyDsqB4VZ/ayL1WNf1x+0a/lIyNs6ampsOk4iw+iDC45bONI6CFT8Lq8nDdz3Nuke6ox0r30oFqEfVKGEgozCXBB5c4qtHS9lKlGNJ9Lo4nf64rDb/jeg1MWiZIdAMfRcZjF5+OtKGAKek9Cgo1kUqLtJFGX5Z2aT/POxYMBuH1xDMLJbzuyW2Wpowg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=476aC48xwj1+Z4sKWSLbW517PFN+tbPkdTt0YRTgZ2w=;
 b=PxwKFD+hVHig1QCJ8PZLfwf3MK+xAl6Ut/rRZPR6Au9iJbj5JtYJ92VQKM/qYw6kF6GvAjh8kEKAc4Y4A62aKPh8J+Hvc8Jjux/o5dQNEju0KFl+6Ii4h67PlEGbmg4eh9MiRZEoxUGqu4kVQmyzkX3LiBmAHpS476wjhzeUGQorTgY3dwadGqXTpv1pg+6ZmRiHKijpRYcX4QBLCJ540c+uXOSnxyEIbYSOL7gYBdOP9zj/O9ekBFXQXnG0/Ih4pIuQyKXXbA7gVeO2Jwq/1IizE2SD5Y6BBwtHZ3LJ/LGfqK+DbNOBqO/XIgE0SuwBcsxmE+HhxFFoIw5ipm5pLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by KL1PR06MB5884.apcprd06.prod.outlook.com (2603:1096:820:dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Wed, 31 May
 2023 06:44:22 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e%5]) with mapi id 15.20.6433.018; Wed, 31 May 2023
 06:44:22 +0000
From:   Lu Hongfei <luhongfei@vivo.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, luhongfei@vivo.com
Subject: [PATCH] soc: qcom: pmic: Fix resource leaks in device_for_each_child_node() loops
Date:   Wed, 31 May 2023 14:44:10 +0800
Message-Id: <20230531064410.35001-1-luhongfei@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0067.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::9) To TYZPR06MB6697.apcprd06.prod.outlook.com
 (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|KL1PR06MB5884:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a1b0c61-47dd-4c5d-65c6-08db61a27758
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: udPqlqJz1ntt0O4TdUN3ewzIjmA8obPgCiC8Nmc8XM+EdQbhDFnkDEYUoBkjAOfV+eVcUl+WMX6T0VBHBUdOH/V2D5TZGJBHBK7bZW0IkAxSqHf5nRYkzJOPycjS0Wnb3JndHPWFMNxjnn6IuafhK3+d9NNdLXi5/jKcr8zT9koOnl6dYjgwsIh0o08g1RmYFwMxZKxFNW3ByJ3mkJWZzPEdc806rLPJ+FgxJebsMFYSWbrBrg8IwQcEx1HqNDbTRntK6WwF4ZQtkhzJnGcguYpGT/k75l9w/KxjHBZAY5xxlyfDBobHanmrkWY+XUJrVu+KCt6S89VFLkIvFpaH4KsukSjE4756ATds6FCESRG0ewFi/GzI4nxEkYJ4Cn+GDhY7MHu/uP4Fji0oqSIvnIDmVzVSm8FSaHd56BJk1hM9AQWvfhG5FxEvmY2qGzntfuynw1Nap5FqgoykXqMxvsdvxSltaYleGFKOUW+db4Lw12zl9eS+zzq1L+nlbTx/XAK4rSV8jhI1k17hEKdJWsWhqNH2Xj/w5qR+8hIkFvjSDETpwMsLny8OKTvYwqy4KWCx23hAHIvSVoxtSNZ4IUXdQGJMoTBxNW8bUUp8ArLI5mxAqcp/JLBHL2k7bXav
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(451199021)(6506007)(6512007)(8936002)(2616005)(83380400001)(2906002)(26005)(1076003)(186003)(8676002)(478600001)(6666004)(41300700001)(66476007)(66946007)(66556008)(4326008)(107886003)(38100700002)(36756003)(5660300002)(38350700002)(110136005)(86362001)(52116002)(316002)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HseWw9AxUr3PStFv1G2hCi93blLofP0eSOtbvAFcKU5BNlX2O8Jabx0zUSN2?=
 =?us-ascii?Q?Xc/ugfQhKS3lxdGTn/h2QSuV5B6RIqiCOEYW4WIpmPQdW1Zjc0/qHOOqtheP?=
 =?us-ascii?Q?luROQvUYd+DSFRENKdNgp4Pbc40erVlDVf0fTR3Y4zRBQBEuulSvun/Q3tjn?=
 =?us-ascii?Q?u8Q41kNSsuH5h6GaaMHR9jl+ZU1Rv1Fbbo+aZlwkn0s/6TcoxiKLuhULortO?=
 =?us-ascii?Q?SYDU3+IRQrzkT+BrOIdL8ghWAXhQ1FHQ3ilpv/Y/nZdCWHBBXlBwLULKvEja?=
 =?us-ascii?Q?NC5FCr7XwRgerYUuMz9ijpuHZD3ht+PYYaIhTqhS4xrZFJxSxM9/9H7x1Ayt?=
 =?us-ascii?Q?Py2Ib2h0xF2U/+XpGW0oTU6B3DfUOmcR4ildbgr40YtQCVFmTLAwTpCgSExK?=
 =?us-ascii?Q?Eain5MlfCSeIV3EFIxtm0dpj46CglLBYmKWxja1ZRavsPph8bqop+Ts6esjp?=
 =?us-ascii?Q?rSTabz5vtY5odbJePLBEBo2rqjkstxqYnVfFMn+WHzAaYAKujiRXoDVfhVra?=
 =?us-ascii?Q?bbcTQQ23vSA8+ZDIJu0FbraHDPW++OFJj+h5rwhR92EdaK0Umc/2UVQudJIp?=
 =?us-ascii?Q?JL1ucUjuUbJ8jwlrC8SStPa+WFQ/pxzSn6n5Y8K6W8RytAQq4R0Qr/XiylO+?=
 =?us-ascii?Q?RamW4NcAu7ppO7D/Qv6fBrpV1pQuRAxrcEI+1m6N/bBT4Kp1upLYIZPk8/G6?=
 =?us-ascii?Q?4ZOfGqVc39PhDI4Vn2P81tx85vEUCWGbkhvFxGiQ+1TJTqz+Ab0CCHZxA3cN?=
 =?us-ascii?Q?9YmXOWS2WmPwclWR/eHT8Eluuptx7+CJxUTH+Wz9zGdnSCatvRsiUUqeO+1/?=
 =?us-ascii?Q?g48GgfUSgUJd9XXJEolWM6K4F7lc4wB9/EFIoIZCM6nICyE6A+ZNOtv6wZkB?=
 =?us-ascii?Q?6mXHwxS/BPTo2NpOV3MgUueH0utnv5pgLU7PZAz8O64O96fvPkfddGlV36rA?=
 =?us-ascii?Q?fYzIxqomE7+5l2hQQVDedsIbmINnOt3P9ijZkmK0Zwlqb8LOY/vNpulH5QjS?=
 =?us-ascii?Q?oKviCx513j9hcqYmqiDDuFck1MZ5Jo9Mi3PRvP3ynWVohPyL1IBrKbvAU5pt?=
 =?us-ascii?Q?huzgjNhFfKXXw9xIIyebYDSVQbzaYnz77EUV/I9pvTnDG0oQNRBgRXjNCIL6?=
 =?us-ascii?Q?gKFuZLxdCML7vDHcOLA32njRgFFWtx3DuwPscqVJh8+UeRDAkbTLThqvL2zK?=
 =?us-ascii?Q?KmR1Sz7uVQ2buqjouRE5RMpKbqRPlaVBWUfdNtKdQGVdYqOnldvevXCuL1Cp?=
 =?us-ascii?Q?ngwOlyiqqjxIZwfufhVFbQUH8wtg8Z/B5Mx2+PbeCVC/UUUQmmXQzZxyFamd?=
 =?us-ascii?Q?DEvOuqYoioV16lwMgCb6dLTqCkzry3jLJTjFT95ckrFgZYdiYK3n/oasiige?=
 =?us-ascii?Q?CCJa1AbOq+FhAY9QLn6jNgaPxI0YFSC4W0E580nGrSFRonIgmHzchrTttqgB?=
 =?us-ascii?Q?50knez9q3LVQv61wacawXC7oR0FI9T5ilJZr//lSkidbWU/t5KMUaljnstF1?=
 =?us-ascii?Q?MNBoNuLah4JpRnhmcjDxFAVcrA/Ky/5VXTFEkl85zOcCXQF8SRmL0INJv0sK?=
 =?us-ascii?Q?r/9tyHTK8YdJDeAQ36j5VznPU1seq4pNa1lfWco8?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a1b0c61-47dd-4c5d-65c6-08db61a27758
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 06:44:22.0005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JXWHOuf28ls5RbECEWW6SAjMyR5v36AOdqkHAwNfJZXtuHwwnuYrAfYT0164c1YKVmAjCoAtFVHYItKp+W/59A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB5884
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
index 4d7895bdeaf2..3faabaf9ef08
--- a/drivers/soc/qcom/pmic_glink_altmode.c
+++ b/drivers/soc/qcom/pmic_glink_altmode.c
@@ -396,7 +396,7 @@ static int pmic_glink_altmode_probe(struct auxiliary_device *adev,
 		ret = fwnode_property_read_u32(fwnode, "reg", &port);
 		if (ret < 0) {
 			dev_err(dev, "missing reg property of %pOFn\n", fwnode);
-			return ret;
+			goto err_node_put;
 		}
 
 		if (port >= ARRAY_SIZE(altmode->ports)) {
@@ -406,7 +406,8 @@ static int pmic_glink_altmode_probe(struct auxiliary_device *adev,
 
 		if (altmode->ports[port].altmode) {
 			dev_err(dev, "multiple connector definition for port %u\n", port);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto err_node_put;
 		}
 
 		alt_port = &altmode->ports[port];
@@ -421,7 +422,7 @@ static int pmic_glink_altmode_probe(struct auxiliary_device *adev,
 
 		ret = devm_drm_bridge_add(dev, &alt_port->bridge);
 		if (ret)
-			return ret;
+			goto err_node_put;
 
 		alt_port->dp_alt.svid = USB_TYPEC_DP_SID;
 		alt_port->dp_alt.mode = USB_TYPEC_DP_MODE;
@@ -430,26 +431,30 @@ static int pmic_glink_altmode_probe(struct auxiliary_device *adev,
 		mux_desc.svid = USB_TYPEC_DP_SID;
 		mux_desc.mode = USB_TYPEC_DP_MODE;
 		alt_port->typec_mux = fwnode_typec_mux_get(fwnode, &mux_desc);
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
@@ -458,6 +463,10 @@ static int pmic_glink_altmode_probe(struct auxiliary_device *adev,
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

