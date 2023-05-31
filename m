Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586BD717AC6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235069AbjEaIzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234988AbjEaIym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:54:42 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on20712.outbound.protection.outlook.com [IPv6:2a01:111:f400:feae::712])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66174136;
        Wed, 31 May 2023 01:54:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AS4Ll2deETVQrHB6FJ5Xo9aQT+PuhQwVLY+6GJHOrwekdc+RSqNH4HBnQP6bL2qoi0QOQa+zl1TFgnP8fU8xq4SSt5P8tqSUcOhbi1ljLyCCjunBAFlU/aGnf1S+Tjh4QJNpg6ViVaHasmYXXzl3+TffwDcUp9UhEtC4kOHfMvdaXEKg2BfzQr5STUUvZblbRUQ0dawZEu97ttSz4QCAIO/ARqvXYcZfQECQe9MDWKXaeTm+x6cWnCXs3kiKNyeN1AUBtietfas6ejwZTzr53pLxkms4AhQ+UdPEMILQW5Pd/CoQ8KHzVFdtcfmFUr5SFQwntjDuKde1bPOurKaF1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xm30gSsIPPhVfrxm+F9KtjK7aUyRtHu3LFLgWgqIM9Q=;
 b=dO0aYuVQslZpArp/6qNR2Cacy3LYDrtG5j2quQ39ZploBjYiDTZrJVZFsFzujJJQYp2hH6Iq4RLDlIpUx8ouEubFveJ+ESra66n4DItiPZY0JezvdStR2kaY4YRlg2a/NiBV1vzIUUM0ofAl3dN1yHBW3+1YgxJmX1BjBxxtFjRfoWEWwzBuH5lvOcM200NLzozlariw1EWfBn8dUXXuJsUHs2SGURV1NdOCh6bXhrMuLW/dZ+QAD1I2EeF5mc4MhOZsmGK9stAOP3LTItXcN/21wjTV1600oAS93o3g4hWOYtF/4Dytawn0Ywu3jPLz9b+epwFg9V4BN+NN7H6VFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xm30gSsIPPhVfrxm+F9KtjK7aUyRtHu3LFLgWgqIM9Q=;
 b=TsRgfXRq0mTZNM5kPO3LyKVIOW/VcSQB3FoR0DBNie7Q4/mtCeyrm0HlRd9mMU1lhi8b0fFSTSsdJ32ecCmJZbZW85p/S4WMbmJ20gLcUxN+aLiKLY7IJ3VO/vM1ymwEYFZKV5SkEZQ8SgLFt/iTW4VnYmZqJj+9GZBs+o33FlaF+f8PVl3UqIIHc5qm0sDvneLa6pEXgB5u3bopt5R/U02aXxBlZXKiWo0OTAtNrktQIO07cHAatuuiAq3ql91i65GHvLSgCF6Cq9qmJf/GAJZnWPkFycbL2EetFJ6J1ImL71RTanz0p3OiTKWnp0UN0T/wfEFqc+NvRvMD7GtXhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by KL1PR0601MB4436.apcprd06.prod.outlook.com (2603:1096:820:67::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Wed, 31 May
 2023 08:54:31 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e%5]) with mapi id 15.20.6433.018; Wed, 31 May 2023
 08:54:31 +0000
From:   Lu Hongfei <luhongfei@vivo.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, luhongfei@vivo.com
Subject: [PATCH] soc: qcom: pmic: Fix resource leaks in device_for_each_child_node() loops
Date:   Wed, 31 May 2023 16:54:21 +0800
Message-Id: <20230531085422.4963-1-luhongfei@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0045.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::19) To TYZPR06MB6697.apcprd06.prod.outlook.com
 (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|KL1PR0601MB4436:EE_
X-MS-Office365-Filtering-Correlation-Id: 181daeb8-dab9-47ee-9210-08db61b4a5fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SCIv30LpHSGGI5qhIJr5medeb2wIv1h5o3Jtg0Av3LRmA07F2/ACnnpiEi9GVxF8reR3Uex7WUDVgXfGLH8fQDr/DyyUS0gkLkxjnQI241VUU020mooR4o5dndGTSDXDu0crkon+EPTUWctPv1I7knw0X75ALMgLslAhEoGYTDaFBugZyZpaterBE2dWOXGp0pGZmMlzROaUbmq6beZQj+enYQkoo7AEDHI1sdBQzXCUyJXokNR9ItPEqEysGUBrMquMTNdEU15hubBbrUQyRewgVglQ72r/jrp1EuQ2kzOVgh+vQBTejXrcKfHEU5BbAawQvjVxvmf+Ng2qin7E6tMtcXo57H3L8BIE354S2sXN+f+FRvOZR8lyOwIJ/0lmUTAaF2o/hJSJ2WifWbusyyTjMzwqVyuXKCaXPfIKySpDaolc8SwC7Ip3j0zBIPWgqYMel0G7GR5481VrMaky5CtMPXl9mVgtc3a7Rj+h5+QIvsbb/QL8AMmUGP/mwD3i9RVbsgFa2P0eD3tc9L5pv7t2HNAHHrMO2zAGtStFjqDg6SDgofSUrdJiLPiiDRbBikmHk3U6tj7cXDrbZJh4iK/HgiOW9D82GPt9DG3o2L8pVoXbiDyUWDM02EpzGw7p
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(366004)(346002)(396003)(451199021)(86362001)(2616005)(26005)(6512007)(6506007)(1076003)(107886003)(83380400001)(186003)(52116002)(36756003)(8936002)(8676002)(6666004)(38100700002)(478600001)(38350700002)(2906002)(4326008)(66476007)(316002)(6486002)(5660300002)(41300700001)(110136005)(66946007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HXdrksC6Sdf1EndXIdZq42c/C83B6xbOtZp5gTUd4vdpSQ5hLHbcvCzzgDwg?=
 =?us-ascii?Q?ZJngYeE50iG/9k9KOeSjxbl4j35j4mOkAgz5lSpAmT8wuHEBjJENQoqEdBbr?=
 =?us-ascii?Q?f4gJr2FQPSuHabvEt/eBd9wTvKbxxkkRbk6gG0JQcFtv0ysZDQWyVhKFvRjc?=
 =?us-ascii?Q?DGL1PpuT0s7UHMcFGE/MHIjjpVyiOUOj3XKfOb5YdOY72cR5D33xk3Zb0maF?=
 =?us-ascii?Q?GChSUGF+B7eytUqkwORnC/Gkyd6Mr1aVdsEFjYu1G1PbYESeSX7ClQL33D4p?=
 =?us-ascii?Q?iXtQgoimcfAcLLo65xnaAuf6fvAeinVY5mU0fXLW0R8yfpsd1IdmN40CN1+1?=
 =?us-ascii?Q?v7X+HNzbHVbuIGJpHyAYiP8AMXpr5hJGeJ/cDzqaw8kn4KfuKWKwSsjxb8EK?=
 =?us-ascii?Q?rKJX3xjRTkvPOWAX61KJOcTjvBvbC1OOJ07/5j5zn48TRkMa+bExNRfaLbHG?=
 =?us-ascii?Q?Vn7JODfxvQsBlWZualTfDIFCdNvzDzO2/G4uuyMr9tHdpsuXCd+C40E0sEAR?=
 =?us-ascii?Q?U21NnzjJ79HODd5hC6mfC7T2VIJ8ktJP+AE/UmkcWem2244JDmCzFRkmOYO8?=
 =?us-ascii?Q?qNXisPKHhYHA0MdGGXLiFB550tw+0n5w/eWcp0vMFvgGDk1hdfn+5bjvYVed?=
 =?us-ascii?Q?shWXNM3CjF5X70oV6kzSW++SA0zq0NcOzmuI+8NOfniONUSQSbbyw7XmZ38g?=
 =?us-ascii?Q?4RmVzSxRaPE9SG433VX1ngc+209VINxBC5V8vujGADW1EQ9I+NjHoaQzx2i5?=
 =?us-ascii?Q?LH+SYk5sApjkoKq9UbVmkT8rVOuTYrTY17hZUrSYdwg1Sr0Sx/HeOSS7ASUK?=
 =?us-ascii?Q?ARX0131NpBcYfkexnYP6h2r5PSnrqoM5PtdZIXR2iwxqqoNUK4ydbiN4Jz8h?=
 =?us-ascii?Q?WrcM7WxrVKgudNZYYXwW9z9b3LH1H8nNIHYsN8tzZijwLtkk74IyhL3IGqLb?=
 =?us-ascii?Q?L401l7Nl8CQzz+nHUQFCty2AI7E3NJPj8UuyKHofnKBosguCmWmoMpZ6XOSa?=
 =?us-ascii?Q?TbiIt4qbq0iHgTMvY5r2/loRhMCkjcjyG2F0usUz+B95IGytPx5pm2M28DLx?=
 =?us-ascii?Q?uxBCOZ0VX4zgfyUuTkIvw1dbOmlu6XawAA8EKeWjD/B7b7Dby0X3ahCCD11F?=
 =?us-ascii?Q?lmv5L35jvFkWsk97/BIqrENdXThXO6zsYVXB9EJ/d8kYfYbuMNb0q+4u28tB?=
 =?us-ascii?Q?Sw7zFO5alXX6AfAXjOL5JgFzwS0+OUTUuEVM1ckKmupwaK2+aCft7iuHmNJJ?=
 =?us-ascii?Q?//oh/Vc48SUZMT71KZvxOaXowZBg14jQq6TUfA0Z3YwyGmNumHGlbDYaDdVC?=
 =?us-ascii?Q?9dw7QY+8WSc6EsU+EQP54x9IuTExPUvVIuMAJSuwBXglFAe3MJdYEp/HrY2i?=
 =?us-ascii?Q?XsnVb40bzmKYj7Ag3fLFbaCt7baWyC6lqldn+NBlquif/uaMuXaWK46+uAYv?=
 =?us-ascii?Q?EKgiG58xsbB/dJBQ/u4gk9gCp7NlLu2BVBqCuW/4Rf8gTt8m6zL3og8eRw0A?=
 =?us-ascii?Q?46/VYow3L7e0laI3PQBL20lKFehFVLFQFKWGP8sYs8/nBu3DVg3exvwnYepm?=
 =?us-ascii?Q?2s2PGBQYWROM0pYxcpVVdpsZJgMBbOzgEdHHJ/JV?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 181daeb8-dab9-47ee-9210-08db61b4a5fd
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 08:54:31.3151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p3YCtoZtyZ28Q9J1qKAbU1ZnoqDZ64giuNW3E4/6WSbymCp0d/SxyxSBArpK05Dd3Y5jit4/4L5/GpH6xpw8Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4436
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device_for_each_child_node loop in pmic_glink_altmode_probe should have
fwnode_handle_put() before return which could avoid resource leaks.
This patch could fix this bug.

Fixes: 080b4e24852b ("soc: qcom: pmic_glink: Introduce altmode support")

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

