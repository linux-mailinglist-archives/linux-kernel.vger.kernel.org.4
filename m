Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC5D74EF3A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbjGKMpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjGKMpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:45:33 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2112.outbound.protection.outlook.com [40.107.117.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1FC9E;
        Tue, 11 Jul 2023 05:45:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7ebJlQtMP+J4Fnq2A3F2kT4ON9iZW+f+VAHxqI+DVx2NTDFPIAfDUuRA/fdYvnhgwqnnkytSqX7JJ/LKDnloRPcaSyULDzwAnJjbJzAmEhv8BrQy771gL4XmeVRpkY859G/YqkA/QMmIculioJlFtms1TJh+FG6oBw9bDKQacl/7PFhOssMPNpKQtmcB0mKkS4gbyKdHvmsF9QNa1Hjdjs32c7UBB4tShzxpxyrw3c1pDqN+gN7UGX7ImTp7Hdt4gKU+WfSwkPPXIQBDk2COwVrRW0mDwNYgC3r9y5u2MwQI4A8FJ87dlPhOv5AQxgtvRXlGHVFa7EzWzY3hqzh3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0ktC7CJms/ki+GW2IJDpPkDeZE+eLUm5r3WNDEIkTA=;
 b=Hc2H63PFSoP6Yuh8Y7Dcwu9HkJULsEvXDb7V/11A/0ECVMtwBkuVYd/lseQGPdcWwotruBLZMiaV6s8PlxCM5o5vu4yHvb9nIbMz0gR+L5PCFCu08xpeOcdEC8WmTCqoqd8P5btMW5kulf/YP0e2X6QC7FkAbjui/RaIX65nZxSDL3kzeGv8gxn4hfiB1jnFWerYo5Mou/zA37j0yqgnqyBsg/n9UrrhtRK8Kw6nZQO2OpqHlJf0MgBq3pO7uOLlPBsv4uEgeaisx2joJCVnnpV0/rRK0RBHQF9XTXFTVMCn1DlNFAplwydiXuT+Yr42Z3clqfbHQJ8YAPMqU9amwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0ktC7CJms/ki+GW2IJDpPkDeZE+eLUm5r3WNDEIkTA=;
 b=RE+tm9f5FmWSP5fZvNDSAx7gYVll4A/lXZZEtcQEYsCzw9T22RiC6l4bmsxGqxp0Lpe8XirSq628JzHsvotT7RGqLfiJxBqDpmw2RM+JSZae97fcaEkZC7G2NRAA1PKue5OdW36QxDZK9XT9Hdyt65NUJxM6rUCNSMp6F0WubzWeGjMzAE04yTR4EXc2MNYtb+/nyPh1jw2AhMZAu4fdUE6f9io1bCV0sGbu4+bc3bA4rlNpjWo7o8T/DZn5r1OHzQRaLrC0dCpXSMM9f6QqndZnNNHRfkee2BzU8Nt+mFabsJMDFUAi48+usSt2og1bsoZ4wpw4ab3sMjwoEPhisg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4314.apcprd06.prod.outlook.com (2603:1096:4:158::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Tue, 11 Jul
 2023 12:45:26 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 12:45:25 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] thermal/of: Add error information printing for devm_thermal_of_zone_register()
Date:   Tue, 11 Jul 2023 20:45:11 +0800
Message-Id: <20230711124513.47771-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0042.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::23) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4314:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a04bd2a-2574-42ac-204b-08db820cb28b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5YUACi7+L7k4uAXGWOAliQvffjP4wf9gmWeO9+cSeHEee/rl3ehFtJLKO1qJGC3+lkRm64vMi/qd6D/pdqU++6eu1rBjEJHfFCxyPIIQqbhfcV3eYq4UpU5CQBG0Yvr658z4uMu4ItAt8549EGQaJm9JfDb7QX5Q6KAZd3S5eLaG+S0XT4kUdxqNBiksb93Rwmks9lbQssAuyTKtQYgzDprA3UH+VzCRYoLYQh/2QoKwhzD+4zyQUiH13L5n+DQgh+MLlBpEhD2Nfvp+7jNv52t6qCKkOoq059qzNfgVJi/h6KNT23zCmhHVR35rApazj0XT7Ldlfwnvu6Isv4xL+M9rHpOMoZP1YYCcAqw9ePrv4fHzX6+9HwF4X3nJ1e6BJqrXQjMj5mdW/elsg0ISTc3Dx1jcVbspl3Qly9YQHR6DKEZLr1zqcM4u0onJbpV7FsC0wuBFK3wXZ9n8jLBK4vybH2bqfCCuf0oU5ZTLH0UXjistRVBGxuRpm8drIkGmFdd8Ca76zan1lbcIQM8nV890VFjNcwlPukb0zdalX1/oxAgrKhsM4LTQpzXCYvzXYwkZpwW0PE5RNAUSqaTRmZVFZiwIjKMv8QiRl0PqD8WbXCe6NVip61eXYeBnMG/e
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(451199021)(38350700002)(86362001)(38100700002)(36756003)(6666004)(6486002)(52116002)(110136005)(6506007)(26005)(186003)(6512007)(1076003)(2616005)(5660300002)(66556008)(2906002)(316002)(66946007)(8936002)(66476007)(8676002)(83380400001)(4326008)(478600001)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rwHr7IxZU2gxHQzT4ZUiwADPL07F+YayrZgzukislY4NGY2LR8RLMs1H7TQl?=
 =?us-ascii?Q?KTX3ZhTtwV2WzCsee8v6Weolwobm4r8KLJ166+s+19e/CxT+XIDKd4rBYD5N?=
 =?us-ascii?Q?vzEnHXHEy1v6LZbWYMbWLfbm+090A9PEUDKpTLEvaNskOgzkZ9fhXS0XPs8E?=
 =?us-ascii?Q?bhpVJaGwuQ6zRDW96zVZ/bceB0PjrvZWs4zkr2MxcJXV9jPEvWhT2v70870r?=
 =?us-ascii?Q?zn+MzHdP9zXbY4bVSwGaSuvxaV4Iz12pPUACSJ5IZY+Z8MlvmyRTjN2xeM47?=
 =?us-ascii?Q?BITDaaOCw9/lvPnn1VAa3kFmgQsjTOx1A8ZV+52jz1tmxhnyj8upFDXZvPmp?=
 =?us-ascii?Q?KWx5UHQs6e1m6i3saE1mT9c3uHb3nXEhEt3FX/XDM3RZprS6SmnqkW4IoD2F?=
 =?us-ascii?Q?D8AbfErO39t5wHCuA26947XdnV6rpxTnvNK5CNLl2q/vyxTcmlMD7dIySAnL?=
 =?us-ascii?Q?Z65FdOC41zx+8eVkCFnDnXhpCK474vBRzwmdAXcU1eBEYXdnsSTdjHoMUnS+?=
 =?us-ascii?Q?eKVBH3FYiREWkFSKZyhchAoiWW6RK8ggj2asV3nv22OltfglJSRU4K0AZzWt?=
 =?us-ascii?Q?x0fTXF8DPmCLJS6eUNqyGwPScSe2cCZCV1LhANTjO8MYtgMyujqULpANhTYD?=
 =?us-ascii?Q?i2dOnhMQelyk7zjUwrjUIgzU2tnIQa2sF53NSBQrhGdjk0MFaJu47NqMvFm4?=
 =?us-ascii?Q?oGBPeEMApEVYbO1u5D2Fxxd1/RwCjI1OYHTgz/jcSj+HJ0aXwgEZGWRU8Vh2?=
 =?us-ascii?Q?Uz5BEh5YP0t6AwD1uzzOoUXoN/lgtHYazs4BZPRAQlZ6T+Tj7f1uC9tehsRN?=
 =?us-ascii?Q?TsclSATgpd5p3J5IGfiX1hCzQwktzZ1BgDrEI2pR942w+a0CTHGmWcrxD2y3?=
 =?us-ascii?Q?2KxcOKZrEFyYgTt2NMxeUC6dXqtxNSFfhpUJu/Yv3pgcnk25fYUAodUnfOaa?=
 =?us-ascii?Q?Gq5q0Pv0YGMZ0YkSP/N1CFONzgsZmj+yXKJe+r92Wfjpb0RAI4RE/kqSieiC?=
 =?us-ascii?Q?pjgL1FJYkjxMZY0Xbi2vKCRgC/qgyEvNwtJ0yE2HQsVNxSEYO0racanBltdU?=
 =?us-ascii?Q?gfGH6A/oz+jP11ytIyX7rdJtIDYqH0t6fKIoMpC6mQ9dLPqzRw8oniRxTpOE?=
 =?us-ascii?Q?cXnMaz+WfBuhUxIFbyWEb0VuaY8aDjDr3fHq6AwBV6W7RBwSv8ywqX0GS7AO?=
 =?us-ascii?Q?T2LIR+Pb+m9ZPYp0hO+jaE4gOLFOZi/VhQ3OoKCtR4WNjDbf7zFqNsj7UrKD?=
 =?us-ascii?Q?dNKxa+5GlA0SD5rrcCSceorUiriBAAZI+l9VHEB5qIg6jO7HU0OxV7Tmo9yw?=
 =?us-ascii?Q?InyDrHyLb4xJBnZqAupk546RLjEe4kSamvM7y2OWkMaUBBb0CymIpg4uMQPj?=
 =?us-ascii?Q?/18dmVvEzFvO6VssFyT2+K0gyJRe0vZQaJ0tHMHidPhYRCgPlJSKjngJkhHu?=
 =?us-ascii?Q?VwxC+KFOaaKr2nFh6irejUUXwKenCfnMZV48Ienu4uOMhxSa/h4AvZV6phLG?=
 =?us-ascii?Q?VPcguMuTdNcoDUe5Seq2ApGIjBz7PzXoUIVTtxHAPQ8b5m4PYOXDKNt3EwHU?=
 =?us-ascii?Q?NTysUH+SSpFBMv40j30cNsVXzo9fMSfIkmTnofZD?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a04bd2a-2574-42ac-204b-08db820cb28b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 12:45:25.3180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZWzMayWfSDQLpSzdMZdwXOUkClWfC6U7bDy/ntV3c2xUmioPFe2XwFPn9/EaywtWMF5KpJxIHHfBkugCjW0o4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4314
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure that all error handling branches print error information. In this
way, when this function fails, the upper-layer functions can directly
return an error code without missing debugging information. Otherwise,
the error message will be printed redundantly or missing.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/thermal/thermal_of.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 6fb14e521197..8ce231f7639a 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -583,11 +583,14 @@ struct thermal_zone_device *devm_thermal_of_zone_register(struct device *dev, in
 
 	ptr = devres_alloc(devm_thermal_of_zone_release, sizeof(*ptr),
 			   GFP_KERNEL);
-	if (!ptr)
+	if (!ptr) {
+		dev_err(dev, "Failed to allocate device resource data\n");
 		return ERR_PTR(-ENOMEM);
+	}
 
 	tzd = thermal_of_zone_register(dev->of_node, sensor_id, data, ops);
 	if (IS_ERR(tzd)) {
+		dev_err(dev, "Failed to register thermal zone: %d\n", PTR_ERR(tzd));
 		devres_free(ptr);
 		return tzd;
 	}
-- 
2.39.0

