Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377246BFB03
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 15:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjCROrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 10:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjCROq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 10:46:59 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2109.outbound.protection.outlook.com [40.107.117.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4378DCA2F;
        Sat, 18 Mar 2023 07:46:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JtighpnZeyUCP0N8ueMLoTWZmULKd0IcA8fPSyZC5IzwwebHBwzN31ySC/hUI4zXysm5traLREJNz1di3g/dFXUHRkjGG1FBjXGM3ChqpxPhdguCML6JTrej0OdsAdFhBA51ECHOui1dsNzFl9d9aKqwa17Ev+w2gIkEgtoyfBLMbJsRFVzxN4EKLsBTtyv+1ENowM2sZX5+oJHb6sBg7Pum5ytbKY0nz5dqP11Qb+j+5Dm/+CPOLrUEtEnl5DK/tLQY+FRW3WM3Ds9aCB0B+cH57WtOu3BGKJ2x3zXVLuRdxPSmbCyRxRP79WRw0nSIVZ5d+JDvcowUI3rgCAcLjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GE3MEtYd/t6m9uX7tsCrsm/xazH/HurMYPLnGfjf41A=;
 b=lSJC1M0lBOvH2H9Sb72AUiUkRFPaH+wkp6cEICkVsfPdgWgH643h4QbMNFiysPSTrfEveFE3Ez4aaOYLPIbsDKFkKfuIyFDdqF7X4Hul4vkstDTeMMTnzyXmggLxmw4fUrHhsaGO1CcTx2zlr9DpQ9xu6M1HKEnvyBa41kt7Ktqv7vmi/VQWXgQoqB/X/v4m5HcxBbhXUB9ZylcLI8C1MbuKUdHC08W50gHvP5crM3QqGFWTHIq3fYnKtWDvTKxA3Cgin4yNL/lyeBGMhz5o7HamisOd1dIVM78VK4tBzk5ocPUZ9w/sig+859Cr88xL+nZLQnXVYA4tLX8NHXf00A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GE3MEtYd/t6m9uX7tsCrsm/xazH/HurMYPLnGfjf41A=;
 b=BstLJmB5qBYfLuP5aQTUGTnLzwbl2c1DKu4G+Bu7rS6d1fcHEyUW5Bv5D2OMOrfcJqtmo5vk+5vTNkQwSYh1mDkM4b/ykwzmcBk4CACWgzK0TsxBQiIn2uoACTEscCWxSfRTK2YJXivhhqV83Rb2Iiyn+7OpzECIFhGuafelVYFy+Sa4WZhmunv2RchGr7YGUUcvQYIo3vy/tgBeYyqWDtZ+kK5dFcv2Ml+4k9Eattc1uFy1iCYiCLGPhi+7VDI+6pV6KWk8hZDcoPENjnDkzdAXTp9npv8ZH3HgI6A7c/aynj3EFb8OOXaOVBnuD5MuQ+GgJUWv69hgwFS190XoSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5283.apcprd06.prod.outlook.com (2603:1096:400:210::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.36; Sat, 18 Mar
 2023 14:45:16 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.036; Sat, 18 Mar 2023
 14:45:16 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] thermal/drivers/ti-soc: remove redundant msg in ti_thermal_expose_sensor()
Date:   Sat, 18 Mar 2023 22:44:11 +0800
Message-Id: <20230318144412.75046-8-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230318144412.75046-1-frank.li@vivo.com>
References: <20230318144412.75046-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:195::12) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TY0PR06MB5283:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d6364b3-69d4-46e8-16fa-08db27bf632c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1BvdNsw6gt6DYeYjrdBU3QtxleLDOZJtls2m8i9BtdZoGolzwC3gtrcLZlCJ+LWEQOG6ibDIJT/RQVi0HEfh5SvfDGBE+q0vveMz7rm/d3aZrghXd+xXW90y+YlZhIpVSA0Vxuok5Voh+3Cd+Jwr3bLVnflM/BAQWcAN3k5XIEgM4jfzUSRDVxvqm0KYKCvZ+tPuulVnnL2h2RQYNWwH/b/UeKUatv2kdi+JubrB26/SyMdyS3etjzNHcMdcmS+WswWV0ZuYUuU9go6N3ODCr78Dde0G4xLQunrbKFQ7fn/QWi+2wEQIz3a06lXi7OIB8vidQ1mc5zH4HynYkOHb1NkPJdC1trHfK5pJYo0kH2kp/Cmf5gFctcg3TzD2Y9N16j2gwajNJ0Zl64Kp8wv+AXz/+6U4R4LYkYWECKjtCchmBbNQE7mItMplUvy5zQiEOqmCN8IoPQfWJblxRNCTPOD/HYhU17fDDrpd8ynU87VkD5DezAGUg5DEh5CHhdcfXISYtgpb+BajRtp84dzAwdbi9DSaVMcdUSk/c/liTp9Z8CDM2C5dnsYndy0Y5vzietQWrvnkTdSZfxYMtsXjg3Ax9EAAq/OVQho/3aIAlCM41ySmxxwR+1t2a9Fnk1oPYsGF/fpyVhINP0iJ4IJnuvfH/qqBqqcODJ0lO7k6hyExGJmIPXe52mn3hnMws/MPKyP5AIDDOEOO5iy6T/ntPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(451199018)(86362001)(36756003)(52116002)(316002)(66946007)(66556008)(66476007)(8676002)(4326008)(83380400001)(478600001)(110136005)(186003)(6512007)(6506007)(1076003)(26005)(2616005)(6486002)(6666004)(38100700002)(38350700002)(8936002)(41300700001)(4744005)(2906002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X+e/OsTX4dDM+4MrTTTOyNlynD2MYhRnTYZXC62RGMWZNC6JpCGZBcAXnE5/?=
 =?us-ascii?Q?MRATcrH1+csMcmAhZXUmgwuvtJtmAeAZ6kfoEZeGYryMNDewWbWWy/F58SG9?=
 =?us-ascii?Q?Pj36WbKZN/5aP1iauhgGSMcIZIRX83hL4Jxir8k2zXb4K24sboHbcUcyDu5m?=
 =?us-ascii?Q?RvHYyUbDABEWv0+xippTXk3opk7Rh94ZTNVjozkgEMoU/1zNu+389BX8nSWj?=
 =?us-ascii?Q?J89PLnuKIMhlYXwAU3W3906ht3vVcmDBxwtmTCn3ox/z3QsCKR8TgEWxLNDP?=
 =?us-ascii?Q?XmxP3jnk84DDuD0DzbUDKdveQklDblzcrkB3954L6I1ijuodgdnBQNMPeknS?=
 =?us-ascii?Q?A57ZZRVdF1OSCJkP97hePZFicpj0Jd7fIpFzgsxafQMsEuJKxnvW671ORqQX?=
 =?us-ascii?Q?FYf6GhKkMFRFn7cYZ73+bcAtXKf1szRNsx20ioJDS2ree69WcbslvD52UTfa?=
 =?us-ascii?Q?h1kBLXZbR01CjusTdTTMkumlEOv8lkNMPa3/gmZgTFWZl7M1QzNemVhYSBK+?=
 =?us-ascii?Q?LXbC4CVGTXlopYaA1vJTzhCKro6BTR+nUCrpCL6+C6qMu+gTiX4Fh9LB/Wyz?=
 =?us-ascii?Q?MGk17/nYWioVeuUAHGTz1sPSWbOFLuSVPMjuuNhb2JDy5cimFZCTaQtEJ/21?=
 =?us-ascii?Q?7656YfE+YBJIJq5BpJb2OgHaWworiEe4mslguuWt9oEXG/GRgNC1S4avdo9w?=
 =?us-ascii?Q?E8bp1ie3rOAjD3zfEgoMApmn4kLN48U7WwXVtepNZdYov6eBEPvnAfkKiKLs?=
 =?us-ascii?Q?VbWP6xFXjjY6o1+WtDp/QK6Plx3HMwSdy6AuDeZUGnN5hZL/r2KzB0bVhR9v?=
 =?us-ascii?Q?h4jWoOs9CDVPtRQdz2VNjHeB+CQD4aYMtyf0VZl3hfHSdqhlUud9aBsB/HS1?=
 =?us-ascii?Q?8NETioCFM9u2Jd5BJykBC79Zf9KUtZkcV4gbhdA5IWFoZDpnE+B6kSR3qkoD?=
 =?us-ascii?Q?HXowRW59alpr+TUouWCWX5sfcKRBamnX0o8s4OP2xyjcsbRbM20p8i7UQyI0?=
 =?us-ascii?Q?j9LGrt/0bkbnpHn6CiQ9oUBnsyj469ITjItMGu0p4L5/V8CBI40wyICniFmc?=
 =?us-ascii?Q?VgipQ5LDzAJFuBgP81xzK+vjEZBXr/dg6WlJ9lToiIGdCAFPEeQoRkFeS0h8?=
 =?us-ascii?Q?VEcrYrJgiyv4RRut352S9mpBfKl8lA/EMlUEE2c1LwtGNGfwyhZZBhFPOgQt?=
 =?us-ascii?Q?0nMLivGqOchdUOPIZ94dbxjUHhiwc7z4+xX3eNn3qILONPm/DDB2c1rg2B7f?=
 =?us-ascii?Q?nMdWWxdY02uIAHAh0JMqy+qyhHjHrd+QozAJGRQxtXBOw0zpTnaDLPQXcRc0?=
 =?us-ascii?Q?3mnP5HATqGS1QL8LxHUPA6ch3/R1ngA+J50Ot4hqotFFE2GnqKJMiFZGn8Es?=
 =?us-ascii?Q?sB0oipEvnTBbYH7FKINNzlBHZQuoDiGjiYEE09PQYoiUrK6PPnJ66iaY8OA6?=
 =?us-ascii?Q?3hvBfCnTVYgymR4hESdvpB7Ha0f2dGYWZW5rUGEHVEmAWvfumvOpAArs7V7q?=
 =?us-ascii?Q?6nWR183hEed7ZoPtNaBWAIId9GAUzaIp1BdRK0brsP3qcDoHavlqiTa2hGDS?=
 =?us-ascii?Q?07rnYylvgY9Q7SvZGaL7z6I6bMKhHYI8MaHVtjjG?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d6364b3-69d4-46e8-16fa-08db27bf632c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2023 14:45:16.1314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UwANLDm7LTWDQCiym2Jkf7Iy/bWdzdxntgJ1n9sTHLlbpH9P2eDsVL30HZeSBC5wcGXBEqYwrNh24KC2cymBJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5283
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The upper-layer devm_thermal_add_hwmon_sysfs() function can directly
print error information.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index 0c8914017c18..e39091f999d9 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -182,8 +182,7 @@ int ti_thermal_expose_sensor(struct ti_bandgap *bgp, int id,
 	ti_bandgap_set_sensor_data(bgp, id, data);
 	ti_bandgap_write_update_interval(bgp, data->sensor_id, interval);
 
-	if (devm_thermal_add_hwmon_sysfs(bgp->dev, data->ti_thermal))
-		dev_warn(bgp->dev, "failed to add hwmon sysfs attributes\n");
+	devm_thermal_add_hwmon_sysfs(bgp->dev, data->ti_thermal);
 
 	return 0;
 }
-- 
2.35.1

