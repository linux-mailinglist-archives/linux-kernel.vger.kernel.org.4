Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6495D736765
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjFTJOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbjFTJNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:13:41 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2103.outbound.protection.outlook.com [40.107.215.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A98A1987;
        Tue, 20 Jun 2023 02:13:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBamWFcKEiL8fVJuYw8P7JLnvCuwl34rX3I6cfCbNLIMM61mFULX3SOH7PwtQ3Er6SDGC7rJDRAmIhqeDyO2vk2T3RnQVk8jJaTuace8Zfdb+meDmyx7WsTc0NJt9gArfGDCspc+yn98ibx/MouYD/QQI+2b8WVmNcqQEPy5AUXnntzCRGtAL3K/C7LOkDnLmStXETC3FJg1okF4K5fFxjlqovNGo3Myv76Ej6ahMRk1piEiMP7p4PdQiJfVMs1kdeANRx07vTyzX8cUpdj4ILVjDut2n0wHl58gump/j+mk9D1sYNzMvxMe7ZCIUbDxUpn0D0U5ZYa6DLSUvF3xfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdfum3zQ41PAyJBaqzfMXeD4WG/WbS/KD/ReWKJZ84k=;
 b=bceWC8cR0xRj8kFB0s4/1S1dQI2z3dVcYLPTDWyULMKInYez7GJ4YqGWsfNt95GnFrHl8xduNCqblDJggOPDbEmlv6LyU9Vh5Vb0Euh2BTgzhd31uZOAw0TpatOBVw36v6h/yWn6dERhYArrbj4dwqr4g4MnCb+mCTDMWXuDpOFJYoDbNoPehrn7LzO+lO9/1LuPhWbwRshBdprleaaNAyCsBUFs6V6dtNkTfJ5nFfV5n1mpzuKJYRoByJb/QOSo4oM1tnUrVYLKxfKGJGXE2bO0p+Ojv/i6pjIrCrQE/ifhIpX6dENR2zNvYu/8P92YJoEys/sjhuy1raYnrB+gDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdfum3zQ41PAyJBaqzfMXeD4WG/WbS/KD/ReWKJZ84k=;
 b=PQ4Q5WbPJB21ZFOQkoEiPIzA9yggPuAXYzd9UWdC8eZVCskaCYbmwapNRPC17ddLiRUjGqairPsqmZIQ4X4snMvAUAsVvKqiEq8QQ9xdCRXbZ4DSz7iPXfvnEHFyef9Z85qwSmEt5Yd+MXlUMwUAMIz0QQD8RTG9mLP6o4iRl+FEcW5FPIrv+2U82Phm4zj4FJJ0TicgL2XEBUHCl7HhcAFze5B8gYTihvZE4KHlmeoR3QEQsxWfzh+80Ajf/ewp9ZlJyUMVX8H+diRFoVfWNxPJIdNPuvZPY7S9DoTUwxHxkkKDB5j8oEBHAV1I1wnytQWeJwBvqWzJHqSgxdKQUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB4510.apcprd06.prod.outlook.com (2603:1096:400:65::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Tue, 20 Jun
 2023 09:11:56 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%4]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 09:11:56 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     glaroque@baylibre.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        thara.gopinath@gmail.com, anarsoul@gmail.com,
        tiny.windzz@gmail.com, wens@csie.org, jernej.skrabec@gmail.com,
        samuel@sholland.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, edubezval@gmail.com, j-keerthy@ti.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        bchihi@baylibre.com, f.fainelli@gmail.com,
        niklas.soderlund+renesas@ragnatech.se
Cc:     linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Yangtao Li <frank.li@vivo.com>
Subject: [PATCH v4 11/11] thermal/drivers/generic-adc: Register thermal zones as hwmon sensors
Date:   Tue, 20 Jun 2023 17:07:32 +0800
Message-Id: <20230620090732.50025-11-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230620090732.50025-1-frank.li@vivo.com>
References: <20230620090732.50025-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::9) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB4510:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d045f7f-4e5f-449e-f535-08db716e652c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CJp6l93F5kmeiKYp85Azn66JyZ+T55At5WUwQ9rsxhAwKqg5iNIEKdWV/CpLWu+SYC9Ya3LgEUGY07MFNIX+tkYsLj/3N1OgGbnbaiOLSTglPHWwy90l0mJoztBuv8EzmvpuFR0ZqENkXAfEDeTaDi5I9c/AMaqtp4j151Sr2lIx82YWaNgD85JGVqo/LdToq90N23srcvG/UojBoPWB4kw9upikXdqq2aN3InBRQJUe+yeTvXBHBk7mrKBFOGWdz0vaaBdb5dc2zXHuTqxzDXRdxLUReJAcVhZR3p/hn9RBxRX0rvXoq1dDG526CB0I2hys1RT+0pzujH3TNvx7im7GSumnMPGJvjY57gp1GvL0FxUwzYbIDaZjPG/biLMKs3uV93a8VT+pne0VkUmjMqRzOGTih5C3lrxNFHubjDLxQ6v2MXarDT4oO1FxqXTS3mcByWi8lBrWACXrNAi1jtM0NZ+ucKt/0yXPOYS0aqIKoZuq1eI4LCuqRrZNwJuF6Y5z9zUt3ekjPVk/DBnE7ANCCjkF5KC2e4ovS055cGiGCQThXb8WF6bQeUcFRMkW8cj9NhCO6RVrUIyQaRJaOyJY/hDbBMhOypCPbLJ6KjcXjku7mNcGQN0klfDJjq0jQliwMSdqp69mZzb7hFe+dubShq4oNTee4pM36lauxbU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(366004)(39850400004)(396003)(451199021)(478600001)(54906003)(52116002)(6666004)(6486002)(921005)(5660300002)(8936002)(8676002)(36756003)(4744005)(41300700001)(2906002)(86362001)(7416002)(7406005)(38100700002)(38350700002)(66476007)(66556008)(316002)(66946007)(4326008)(107886003)(26005)(1076003)(6512007)(6506007)(186003)(2616005)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BJKCGPGnsxd1mjXatKoQDcaEeDPxLgEe1YPyjkkcGOubu/MING34Xvb98Did?=
 =?us-ascii?Q?2ZTD7+xeWL9Uc7zoGjKCMQyIbyxafG/dKM4DJ8QcjtWlP3Wn90c05F19ROav?=
 =?us-ascii?Q?bRpvong7z4anPK5yDpv1YWQLF6T7hxS3eU3RQfjHbfNfA5EAybyutfaFbmUO?=
 =?us-ascii?Q?QOQz/MpXsR8eqkTKREYi7szHqe3qCiDiyygl7f/Vfrh80wst+vvkMTMwZEDO?=
 =?us-ascii?Q?o20a0MizAxfnfJ5GkOagQVxYBDkRs8uMaKBXtunOZ38E3TYJ3W+lnrxOo9/i?=
 =?us-ascii?Q?hHq5OHMInk3yj/TCS68JEt0W8NQgfL5qHQNC/bnSGa36gO83/hc87bNrN+yG?=
 =?us-ascii?Q?h9NazhOZ1Oex0JVsBOP2nu11KNYqVy9fvp2kFfT6OKXD5eJu0KU8Ib4FKiRv?=
 =?us-ascii?Q?Id1Yxi2+jxnBUetKDT+0F7CCf6+59QqXLELZIY6LgpRDdjLbiIra7e8DfMmW?=
 =?us-ascii?Q?Z0sLnF1jLVcYfBrzb0DEgYLM/Qjh8w4ppG+hnZ6mh6vlXXl3lV75CIIgxihY?=
 =?us-ascii?Q?Lf7iaUiBkyL4oa4G6JOccoIaaogbN6Va+Y8ADfTCk/rSo2nGaOElLMOONMTt?=
 =?us-ascii?Q?7cDaOQoxpiNqdl2LY+wFcp8Q/fDb+7IAbSaCXexzJlwD62yQ8+Y4Qn5VL92k?=
 =?us-ascii?Q?puPRurdl7XM5GdMiuNhE1hWqMUyUlpr6rRuruCFKBIChPpeYWKW69LwrasBh?=
 =?us-ascii?Q?sNPLhlfDJZYdSanxn8kP2ATouBCFzV2EUOxdni5Q4AH+WdYW1uNseO14cEHN?=
 =?us-ascii?Q?LgSJRtmePItpQCYTQvzKrXVslqaQcket7yJfNQVJhVngHYnKVRocpL29y+9l?=
 =?us-ascii?Q?FIW4/HFiDE14vVYyY7KQNDgbt3sbzHD7V3dgAGM38Uj5MPt5aLYPlKDGKMUD?=
 =?us-ascii?Q?7Wi8Mqgp0UDn4rvZF49u0lWCAhKH5o0U2IupVyIJu+WvqV6pvIxnfBMOv5Eq?=
 =?us-ascii?Q?HAOO2KWtrRwS60hIz6vesX+fK9xIkdfpejwuLjI/sTPbxTcWQ4wmDiu/koyx?=
 =?us-ascii?Q?gGgTDumBiVh+wYleXJ1/YM2Vv3HPUc6SOQTfIG/Bdilhwk3pDNWR7Fh0YPbg?=
 =?us-ascii?Q?FU5Kugov9B5EYE2kjHmg+Dz9oyhJI8pmIi8WwE6OfUJFCDigkeaDT0eeQBES?=
 =?us-ascii?Q?b9LPZ59YCfzuV43Rrg4gghu4+thtDuUY4tEZMtV/M3MYFB+jBW4h3Abbm7D2?=
 =?us-ascii?Q?KXe6BIwos2cqKSvp6PP1nXF5s3YX3Cth58uRd88FOBlGoC+uenU5jYD97frn?=
 =?us-ascii?Q?0/EebRTyGqK+gHaNLvvsXNMymE6C8LLJTtP9N9o7+bAjz1UP+e0M952wQWpE?=
 =?us-ascii?Q?h8fVGx8ZZLjrSxA1O3VTvr9v55UpKHcAO46QJB3eOKs+lj6F1KCqveYOy6Qa?=
 =?us-ascii?Q?Bho2S7Jy8DV3fncy2ll/sAfyyZ2dG0XWU5HSH/iex2Fv/Un905m1ITEc5PBU?=
 =?us-ascii?Q?ofcmm0d4EKQkO29OILwmjH5ITwJuTfGIWurHCglgQLCPb9dG8PG0MDFHt4+4?=
 =?us-ascii?Q?zt9ZkwMatA3PkgHCDcvI6KVQpCShdLqjypt0vYJHPnk+3mGpzihdx7qDhzlM?=
 =?us-ascii?Q?sn7miSaaNhk3MXHot2vEYnJ8F7JbxG/TH1UriahY?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d045f7f-4e5f-449e-f535-08db716e652c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 09:11:56.2872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: moG64Hhire5BhADZAEVPJ8vXKH2JhPqfBISmns5hzX5znhWV0JdVIvPRiXHqdonefpRoQwmgZ3r2lN2qEbco+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4510
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wenst@chromium.org>

Register thermal zones as hwmon sensors to let userspace read
temperatures using standard hwmon interface.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
[Yangtao: only keep devm_thermal_add_hwmon_sysfs]
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/thermal/thermal-generic-adc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/thermal-generic-adc.c
index 017b0ce52122..f4f1a04f8c0f 100644
--- a/drivers/thermal/thermal-generic-adc.c
+++ b/drivers/thermal/thermal-generic-adc.c
@@ -13,6 +13,8 @@
 #include <linux/slab.h>
 #include <linux/thermal.h>
 
+#include "thermal_hwmon.h"
+
 struct gadc_thermal_info {
 	struct device *dev;
 	struct thermal_zone_device *tz_dev;
@@ -153,6 +155,8 @@ static int gadc_thermal_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	devm_thermal_add_hwmon_sysfs(&pdev->dev, gti->tz_dev);
+
 	return 0;
 }
 
-- 
2.39.0

