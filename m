Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30AEE74D2BA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbjGJKDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbjGJKCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:02:53 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2093.outbound.protection.outlook.com [40.107.255.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5EA1FEC;
        Mon, 10 Jul 2023 03:00:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OLXNsb5TPOSxD3nk8+tQbzOcqi8tpvz01vKsfRl5z25+UhqVahof6jlLQo8UY7qNcIIhyBL+Lai/jYxHCA8p2LH4dOur8nDatkqi9tW+hAaUX/lEREOUUO+nLEh9OcuWrEIDu787UjuonUh1d4CD1AGl/rGSU/H/0lRk48M4lfgThENL49GMmib7TDF83E0SsillXPO0F7Lk7F3ptUDrG47RWpR5tGm2iEKnFREXn6Pv0/7g/eFmFae5ByB3NLKssdNY1IpPfnD/XibnMzyy2ltmGIIOV1yQBS1POV3xakNMGPCYeTtv/NoLkkFtQYpIkhSMLKd8tT8F0p2oqfFwCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2g69HSmEHuTTYKyKe+Ic9ejjUzfByis+TpAlcnSq4U=;
 b=UyxYhv0Vh2KT6ygqGjl5gC7dVb5CNdSXJI91sDbqlbXxKB/X0pU9TwE++RvGeyUdxoz7TGV2Xr65vroPMU4FLKvRbgFl5K+fStUSav5Oh/F6q1tuDLtF2TtO7TZ2JJ4p/wpg1JK6RrzBd3Qd6WrQwk+erJw3h11vHf0JcwyV9vNWfyepUv09gmHxR5CzX93PoGAWGaSPMxvaWEdgczAwXjheGkU3C2aYJ+qeXwpyQMtS9udjn8Lyy6RQJ6Z0JPr8DpcL3wDDktg0r26zFiAr6zb4FeAGhAWJFxLReH/6eYIUYjAdjrOg0AH9Auz/Pdy8BI9S5fWT5jwIJ8M21AHttQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2g69HSmEHuTTYKyKe+Ic9ejjUzfByis+TpAlcnSq4U=;
 b=AT40YGdufwDaOVOEV+ha4HA4p2KbzY3AUL/1ByQoe04WbEYihn0vx3JDzcKKF3rsQxcGqfKhO/ZjR/PDcckHhNZQABeEttyihYo/8YYEIE1H8OtDT8w+yZbqB7aWnp7Wq7qYNen2nu1zagn9/OTcWtGy/SbaDWNXkjIQmGNx9E9sJxG8/seL/bKJffE4IeXZKoFtLb/9b0P5iKO7JM0KPXfbHGjXXUifFiUWkamLfOGFxt2Xtb9d4+NIS9T8JyGwrTAg94CehK1s/EDzSP/EPbcrW0mMHZvj5mAIdFZIv1UzWEeKzFJeMFzBmbskpKH5mVFT+nlyRXv+F3YwZVZwvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB6096.apcprd06.prod.outlook.com (2603:1096:400:33e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 10:00:07 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 10:00:07 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 11/21] thermal/drivers/hisi: convert to use devm_request*_irq_probe()
Date:   Mon, 10 Jul 2023 17:59:15 +0800
Message-Id: <20230710095926.15614-11-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230710095926.15614-1-frank.li@vivo.com>
References: <20230710095926.15614-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0167.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::23) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB6096:EE_
X-MS-Office365-Filtering-Correlation-Id: c012a024-865f-4e2f-da4e-08db812c70ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VCfBdFcFVDBbB1xWMbL4qv+HwaiTAXjGYzsY8pjZcQp48nEji2U5iBkmZMKjvvWl1lzPqvu5zkZcAaWq3qAbTamRRljPKoky1Z60pnv8GPWDDwDI/jv7wpclwH5KsGqDKmhkTTHcOnPiPcceSnzJr+VyzKLQujXKzDhVt4iaSpjnPV76oWAo80wWE1NBVjdU/Nj8N3yz3EgsgkZnR/PXjtnLPwWzf0NhZ5MTkeUmCBDCN4oBN/4S/Eygrk+YAkxbGNtOzRmw9TzXYb6m75DuJR5LxA5pKuB5MuS4/1DZmx5CNk1IXHs6g4FiQmUAuA2i2X8JlnvuyRMl/TVE08P8lMMvBzAcbl00fnEoKA2z5JSwQfTpRVWXXxyfipCfS/xjbasAUvv5kSa76VJPgyNxwW8Vt4LMYEPyhmBysHtVagYMMvXOxaADy29WQ/gFO/ZtKtBbiYb4cH+SO1kD/UdhMuf03U6MaPONSPPzeAZJSlx9FOiXotMIx0Dw3SEfbHEMN72mEaIxqfMGIDuBdxzlTC8z0mlAMxad/FsYJosMtX+T+eTAeFLkC2feIkQT1nKvmel4ptsnpoJtZWFByyhXLP4oPy1hgi3doYhryKfIl2iZlO6nv/6aUjPZ/zpvWnJh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39850400004)(366004)(136003)(346002)(396003)(451199021)(186003)(6506007)(1076003)(2616005)(6512007)(26005)(66574015)(83380400001)(41300700001)(4326008)(66476007)(2906002)(66556008)(316002)(7416002)(5660300002)(8936002)(8676002)(478600001)(66946007)(6486002)(52116002)(6666004)(110136005)(54906003)(36756003)(38350700002)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTRoN3dEL0Z2Mzdnd0lCSzhENFdZRm41SDhGWGpCbFVtMnExNGx4V0hqTWU3?=
 =?utf-8?B?Y1RDUTJTU2pJVG1adThMTERvK1VWT3A1RVVuaHE5SzhKanJ4ck0yZXl2MGRj?=
 =?utf-8?B?N2RJN2FSZzNOaTNQVE1TK0FPanZ3dURsQ3FWclZkcngzM2FDa25QL0NpckFM?=
 =?utf-8?B?cTVyQlAyQk0wMEcvZWRsY05GTjgzanZOckdmRlZhN001enFTRTRrMWNlWDVJ?=
 =?utf-8?B?ZW5FRDVTMy90aml6SGgxajNGbjM0bHdDZm9aOXA0U2JXVlNxNVJQYUNKTEFG?=
 =?utf-8?B?NjFoUkx5WFQxSkxyWTJZYXBiWUhDckZBdEZud2d1cjJ4WS95VlhuZ3VyMGdu?=
 =?utf-8?B?V056R0hJYXdud0RLMXFZczZKUTIzVEdndkUvaUtqNEx2TlpMemxPNFh5RlZF?=
 =?utf-8?B?RlRHNkJRM0NoOHNsdXlNR0xmRHluaXRPVkJiRnhRN0FBN2FEdTg3V28wb1Ez?=
 =?utf-8?B?RXdjL1BQUmd3NXFDWmRJdTlYazNTZzNIWVZsbWVwNWhyWmxHNTlweXd3OUxa?=
 =?utf-8?B?MUcyL29Nc2lVRlRLY3Zsc0VjRTQ0K093NWpTSEpITTNpN1FjSFV6RFkwdG5U?=
 =?utf-8?B?NFNmcXFJRlZxb1F2WFhITVlHWFJRL09hTTdXOFBUZTNYa3EybTg3MHIwbENw?=
 =?utf-8?B?QUJKRUtPZEFRN0pHckVLc1VxVGxINEk2YXNJd1A1Ym5tdTNsd0Q1QkpoWnd5?=
 =?utf-8?B?dXRoT0pLc1UxelNwaDZ6RkNPaTZrR3d0d2RDVFgrWHJSa1JEMmFxRFcxdEVG?=
 =?utf-8?B?ZldFR3UzTWpiSUh6SzZjUE5JYWhJb1ZZYm1BQzBxY1Q0WndlL00yakR4YnBN?=
 =?utf-8?B?ajlzbThyOTE1V212YTNKMnI3aUJPVmtCb3NaZUFzQmhhY1J1UC8vY1NzN0RC?=
 =?utf-8?B?dEl0Rmt2bjdmZDlaakRPQXU1enVDSUJoQWdhUmU1bWlOQ25ucmIwd0F4aXRV?=
 =?utf-8?B?OUlQSEtWTmFTTzU0ekN0b0JMNXZLNUo1b2VQUHg0ajY2b3dvZi80NWRtUzRp?=
 =?utf-8?B?Y2RsRmZGUVRRWG9zeGFxa0xmMjd3VWxTNE5HYW1hMXhLU3dsZTNOdmh3WXFF?=
 =?utf-8?B?VXBEVllRa1RrbzJiOVBPd25zU2szWUkwcS9UT1NVMjlWdFNBeGRZWDUrTTlq?=
 =?utf-8?B?VFdpZ0VCblBETWw3c0djYmQxc0xSbmwwS3NQWTRJMmF0cUxNeGFEWWUzY1Vo?=
 =?utf-8?B?eWYxa2tMTkQwSVNGYUplcVRmRjF4aHpoRDBFNFVkNFFqZmFyMHBUQzhab0ZH?=
 =?utf-8?B?Ym5ZcGNCZGtPVll1MXFPU0ZGa2lBQ2JmT1hHV3FTYjd0SVRpc0JZTDAzWGFp?=
 =?utf-8?B?akloRzZ4Q1dIUm1wK0ZYSHZWRElCQXAwQjZ3Kzgyc3NrUmFRai9uanNVWVEr?=
 =?utf-8?B?OUFvbnNzM0RLdThrNVhwMnRVVU1OVytObzRlcEJ1aDdNQnl3UmNQV0hpWDZN?=
 =?utf-8?B?YkxIS1p1WkJ3bEl2QjhtVW9wRC92YnJtWFhickRYTU5Vd09xYWhaRng0Ky90?=
 =?utf-8?B?ODFwSklHMitaaUtFZCswL3YvTGpGVVAzSFIvOVp4QTc1b3pmbVVXR05NaFA0?=
 =?utf-8?B?MEU3bnRUMGRzcmhiMVNwS2tnSzhwbUtHRmVMSzNOV2xiakJRRGxVQ2g1Y0xL?=
 =?utf-8?B?Z1BSeUN0SFRxWEJyVGgwc1NxRmMzdlFXSWx4ZWYydm5VQ1Z3c2kwMDkzTTFt?=
 =?utf-8?B?WTR3STNRNVBoTGxLaWJxWXIvSGhNTGRrKzFhajdyMmw1a0wwRWc0Z2xyRDFZ?=
 =?utf-8?B?RGpMN3dqdjdOdy9BM3NyR3daa0IvdThiZ0xrSTJZZy94RE0wdWZGZFk5S1Yv?=
 =?utf-8?B?TUtPTnZsMGMrV2ljTHBad1BMUzQvOTROdWRvOVd4TkdNZTVid2pZTnVxNUps?=
 =?utf-8?B?akdROGd4Q2lhMndpRFo5dGlMRVE2bmN4WVJtVC9tTzhwMVRtcVR1T1FBTS9R?=
 =?utf-8?B?NDV4VmM3MkJPMmhtRTg0SVRpWTZMb2puUkNVV0xYUzhnNUNETXpaa1gzQTFu?=
 =?utf-8?B?YXdhc1RLSldJNnJ6RTFiaHplclRtMzdhdy84d25NVFp4aldxOFR3bkxUZmRQ?=
 =?utf-8?B?WkJmTHNibGVDV0pCS20vdHdRT3NIb1docGdkOSsvYzJ3TkdtRzdSb01UQWFk?=
 =?utf-8?Q?LIkV2iGIqVWL3XVyBM62oKyWx?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c012a024-865f-4e2f-da4e-08db812c70ac
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 10:00:07.3731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pvez/33xPWAzRALUN2EeHni9xPzxHBPjDXCB8lzrLe9mZGceLEHuvN9C+TKZ2T6WiYJ8fV9nt23/eLGnNJWD5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6096
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are more than 700 calls to devm_request_threaded_irq method and
more than 1000 calls to devm_request_irq method. Most drivers only
request one interrupt resource, and these error messages are basically
the same. If error messages are printed everywhere, more than 2000 lines
of code can be saved by removing the msg in the driver.

And tglx point out that:

  If we actually look at the call sites of
  devm_request_threaded_irq() then the vast majority of them print more or
  less lousy error messages. A quick grep/sed/awk/sort/uniq revealed

     519 messages total (there are probably more)

     352 unique messages

     323 unique messages after lower casing

         Those 323 are mostly just variants of the same patterns with
         slight modifications in formatting and information provided.

     186 of these messages do not deliver any useful information,
         e.g. "no irq", "

     The most useful one of all is: "could request wakeup irq: %d"

  So there is certainly an argument to be made that this particular
  function should print a well formatted and informative error message.

  It's not a general allocator like kmalloc(). It's specialized and in the
  vast majority of cases failing to request the interrupt causes the
  device probe to fail. So having proper and consistent information why
  the device cannot be used _is_ useful.

So convert to use devm_request*_irq_probe() API, which ensure that all
error handling branches print error information.

In this way, when this function fails, the upper-layer functions can
directly return an error code without missing debugging information.
Otherwise, the error message will be printed redundantly or missing.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: AngeloGioacchino Del Regno  <angelogioacchino.delregno@collabora.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/thermal/hisi_thermal.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 3f09ef8be41a..ee5f50fb2b68 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -576,14 +576,12 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 		if (ret < 0)
 			return ret;
 
-		ret = devm_request_threaded_irq(dev, ret, NULL,
-						hisi_thermal_alarm_irq_thread,
-						IRQF_ONESHOT, sensor->irq_name,
-						sensor);
-		if (ret < 0) {
-			dev_err(dev, "Failed to request alarm irq: %d\n", ret);
+		ret = devm_request_threaded_irq_probe(dev, ret, NULL,
+						      hisi_thermal_alarm_irq_thread,
+						      IRQF_ONESHOT, sensor->irq_name,
+						      sensor, "alarm");
+		if (ret < 0)
 			return ret;
-		}
 
 		ret = data->ops->enable_sensor(sensor);
 		if (ret) {
-- 
2.39.0

