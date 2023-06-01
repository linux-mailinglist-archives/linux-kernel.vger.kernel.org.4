Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B8571907C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 04:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjFACUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 22:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjFACUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 22:20:06 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2123.outbound.protection.outlook.com [40.107.117.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3B218B;
        Wed, 31 May 2023 19:19:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/rQwXBZZ2KZuLRr75J0QBqMYi5ZF6eFohj0ECBXT547jCpfkvPm+Y2UWXSKeM3YXj1tH+f47efvbM/GugfVndWY8e/C/QVD8PvUUvuQic2RxL0Gw7tndFsJxhzTnpMonfnlJBkRNR6gDr4mtmxQaQz43xPkZ7rbufd0GCe2mvnKovDKVL0hvJ9A/08JB0WBTmmp1nJPfRaGga2FskdgGoJ6tEZkAlK5DbOWrwPmEcXjguiNFP5C1b64Fv051Ye7FNxmSVYB+jv7G2irp3vLpd3SfaRznRSFziHR46PWNubpKU6FDPG7b2ZO5GMwhVAD43wFi3cU4YF7El9drQNGPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgXCFRPc30NHc2rKYsIu506EZOgAcKPRMbhNGsI1AiM=;
 b=Yc6QsVLuv/DzaCgJnU5UIX0PtmyTNkCk2M6mhXgq5tjK8Ig8Lxw/hbLvC2iQiEe+oYJnxpS6IZr7+okbdZFvvyeFuypd7FgNYPEapDJxKOprvIefCX3Joh/1SQLSxj8QSlEXCg10R5eaBn0zhhAwDhXhECuT1d9eXinKVqfiwwChzffVRZ4TmFgA3VPKXw/e/WlGto/NuAdA2OyTnMz7UkZ81GcuRW41ptnbffiEGTqwjkr6jKuSviQlXXZj+7BWT41HLESoC1BG7U9kS4RMGt7a3GweP21KcspipyardkhohV5cTht3/Ec7140U6rFww1f4MFo2YCE/ZHibKREy4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgXCFRPc30NHc2rKYsIu506EZOgAcKPRMbhNGsI1AiM=;
 b=qvzmBB2BSUpYJbLs/c4f6zIIBSNJ0GzJMGpazCNRRUtg26JJY/qNTY8y/gJBjEhBt1aQ8PSrW8GrjHNq6t6+S/0jZWGS0ErImdT38Gxlzy+funX8CAr7QH8hU/Gm9T98MwO8W0IjKRexbu/KxEiH3LggsgdTGzfFTOqFVv+DDFZELO/7EG5b341/DWvuw8EwSegEE+TBL6K3xCAmXbi/Tgs3Ir29hTGWifji14dKAavbVc3Z8eD79O79xeIEwfs0aR3gY5DBySB+UHJ07YYX4oelxm/CYS/naQwnHWCOLUW4LAxrEDslYxYJ+5l4RVz9SyeUyYcqDJIRRe8j8D2A4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEYPR06MB6684.apcprd06.prod.outlook.com (2603:1096:101:176::8)
 by SI2PR06MB4426.apcprd06.prod.outlook.com (2603:1096:4:154::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 02:17:37 +0000
Received: from SEYPR06MB6684.apcprd06.prod.outlook.com
 ([fe80::dcd9:1869:3b38:c446]) by SEYPR06MB6684.apcprd06.prod.outlook.com
 ([fe80::dcd9:1869:3b38:c446%3]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 02:17:37 +0000
From:   Lu Hongfei <luhongfei@vivo.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, luhongfei@vivo.com
Subject: [PATCH v2] soc: qcom: pmic: Fix resource leaks in device_for_each_child_node() loops
Date:   Thu,  1 Jun 2023 10:17:26 +0800
Message-Id: <20230601021726.34908-1-luhongfei@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0139.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::16) To SEYPR06MB6684.apcprd06.prod.outlook.com
 (2603:1096:101:176::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB6684:EE_|SI2PR06MB4426:EE_
X-MS-Office365-Filtering-Correlation-Id: eda8d466-6294-44cb-1e70-08db62465e02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d9zZR6++fwMwMT08jrCG6IWCIdJImL+f1BQrJJx1ksRYXPijMP2psJm0gBGSApz0tPih+woD1Xbm487oTmB1W+SCJLJmG+PwS4x6PS1YNWoCpODlwzbSKoO3PRd+4+x0yasgXv2aFgeEOe5FNz2Au9rO+rdk1sDZAoExEIxgO7wwbxyIVRJ3uMRIHf8faJ1ff5sSNn/cZCJpwUZyvkzxzQmoxkPity7M9p6PA8hwBAPYOmu9QmGoqbDGYq5UF3lHW3SWtBdwwHDrq1v7EnAs1bZlW/E7YK1JT+6AKMKn0d4+V7xrmbFTMDrr4Ep1q4ORrF7B0VcsaiB5gR2IHLZ9ZdeIyt/w8Dsn3jVh+uCchWebtvVKhQpgICGNXJv9gdz8j5GiA3mvjSK3xJEIjhmVUNrmi/63WRfU1bNpYIdi1voeJn6ak+fTeDmbLJlDziXubs/8F8P+bY4JXnMDvJdk6phv4xktQdf/RRuQtEQcFpWU5mn819g3bEDLR2Zx6RxV/n4AAAC/HahNb5TkRKvPi2wvYGbxNu0ZJuJmyAiZUEF/ADccgAhm23VLy2fZd5+yB4GvLKGeTcyzAzTsTFB2O3ilsPjeq+arUlGuqd/RpqjUqcEFd6BM6Lt7hJbOOjkX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB6684.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(136003)(376002)(396003)(451199021)(110136005)(8936002)(8676002)(4326008)(66556008)(2906002)(66476007)(66946007)(316002)(5660300002)(41300700001)(478600001)(52116002)(107886003)(6486002)(6666004)(6506007)(6512007)(1076003)(186003)(26005)(36756003)(86362001)(83380400001)(38350700002)(2616005)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4sFNI2S+d0Dc3anyUd3sghYexEjTT1D/VyoAjKK0MBMMPTGeeNrRXfLd9B+9?=
 =?us-ascii?Q?CmYrGYIdEtsUe4epsf61Wpmo+suS0XDTga8md35IJsBUWQ23grvSD+QOoldP?=
 =?us-ascii?Q?yQTsL3rbIpGr8/37YDsbg+eOp9TZRKECq8tGOqcCtmTTJUeUNC/kAIhkofxc?=
 =?us-ascii?Q?phjxKw5M6loVZxsvk9J+Tqsr3yFemA0ZvAhuHjp/VjU1Bbprw61JwlamKjeR?=
 =?us-ascii?Q?FQXE3mMvELMgNg8PHt8mwtJi9NTWYdmcCW+N+uL3xgaciGCanJ8ZNh2cz2FE?=
 =?us-ascii?Q?HyY3ngQljLsqyN7V7qT6C6P41+heAeuRNsZ5lGTStMUW9cCp7a/ttkCHx7aB?=
 =?us-ascii?Q?6cM+NstDeq5WekGs/fyWVg0KQKzY7uNjJS8dJ0hPTTUZHo/iFynFPtgqNTtb?=
 =?us-ascii?Q?mm1tnE8Z/3soEvhWOucg0BBxpO1O+/MS6YSL0qeKyCTyWccrFj1Kdv+DdjZn?=
 =?us-ascii?Q?3ep+dKzCznoilg5tR/00ALhej0p2f0oQAR3cfezzjT4dRb04LDNJqfFFQZEM?=
 =?us-ascii?Q?QbRucTaoDM7+TUevN6Z9t0wfP1r/T0j+eiEHn4wTNHtq2PB19vmbTWsl1PaK?=
 =?us-ascii?Q?G6tjI0hkoeSUFcuFvOtQNhFrd7UD9E4m8o2sAgD16H0G+Z8OrXAIL1FsQgus?=
 =?us-ascii?Q?fHwyx7vvoeG/3uJdc1X/+NKIVyODLsG7zv4NZ77eg/NgCQcYAUJVzHV8D1T7?=
 =?us-ascii?Q?OFvKk3nLsPO5s3n/LuUj63d4roOoDD44Rd4Dro/le2PYlnBVRRkgECfV/PLo?=
 =?us-ascii?Q?lcnpamOOFC4TnMC4toBtYh2dhN0klLr41zz11w4lJ78dY2Bm/xV3LRCef4bJ?=
 =?us-ascii?Q?TKrYlrIJXeoxH/zlo3AaIBhY++khX5NAvSXUI1yWVg8Sb+GVlLi4grPcSMF+?=
 =?us-ascii?Q?lectI77emgcMpH6cU5WduVot5D1gBwwvXDCwVQTlsMn4abodR+5gMMhGBpZi?=
 =?us-ascii?Q?dpY9VlxxOO6tey4WMmoJJJLlk9OHk8145RaMerqGsAe+Q0pfIxXXmNQeYiqL?=
 =?us-ascii?Q?atcff1/KRDA3jTXjnBLg6qL2efl3zUipINPyWYBVaq5Fu/gsfuj62OTmUhQq?=
 =?us-ascii?Q?me5bjpaV9Or0w/45hm3FASAUAjoyRqoJEVlj/PRQIF38Fi9eM/kAOHY2+B/+?=
 =?us-ascii?Q?DcbZx9iDQ7fk2Fhq3pZorA+48JrgnZG2w2MRexfs579UF9Z+qenRH116v02a?=
 =?us-ascii?Q?FniiAhOhVF2vLGbN6SFc6vaOnwsYgC06cdDiy1iscuMgwMelPapi5W14kM+z?=
 =?us-ascii?Q?KTRV44jIBmYEx6R36+g0LxYLv5y2dV/GU81NM/fIiNxq87Gq2hdS5AwjcSff?=
 =?us-ascii?Q?VMGLzOzBThtbh4rtbjjCppwBst+Z5ARnWpo0Kl/FZe9zsqSbFd8PMF8l1HiI?=
 =?us-ascii?Q?+EhiVZWyrJQ3+mVF1+Ao9xd+y222oP+eOZd26nVoO44NSoAcH57FR8kdAm3E?=
 =?us-ascii?Q?bGpBM5Os7Fp/qDY6BXx/6N3SpOmdvk6Hwvpw5KAqQ5bIDLJqPZrj4m7BrT0c?=
 =?us-ascii?Q?TWPaRD40UEhJ3N/D1H0FarNeNosRQD/Np6OzmJhCoDGjlaDAYmPMdet4Vkav?=
 =?us-ascii?Q?5SjvOzmAI8fWsaNleGdK7Gd9AemrP+TQpJavQx49?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eda8d466-6294-44cb-1e70-08db62465e02
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB6684.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 02:17:37.1561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bXotEtNm93eMVABEZGKFWfY0JdDWKwffx7ImGEEfyz5lD9HpnQuL6lQwLdLmno65+IBP80leqz17GK0zuOLcsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4426
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device_for_each_child_node loop in pmic_glink_altmode_probe should have
fwnode_handle_put() before return which could avoid resource leaks.
This patch could fix this bug.

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>

Fixes: 080b4e24852b ("soc: qcom: pmic_glink: Introduce altmode support")
---
This version adds 'Fixes: tag' compared to previous versions.

 drivers/soc/qcom/pmic_glink_altmode.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmic_glink_altmode.c
index df48fbea4b68..a7fc6570fa1e 100644
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

