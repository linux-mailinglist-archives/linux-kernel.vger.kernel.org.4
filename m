Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD44174D2B4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjGJKDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjGJKC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:02:29 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2133.outbound.protection.outlook.com [40.107.255.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D5F2738;
        Mon, 10 Jul 2023 03:00:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPqqTzodWjLsxFAoM8NdLPV1NFH5TOqobDUG60ZrZtO+x7ajS7hVkmBbrQoIgxDQTXH185pc0fhRLu3D68705l3eyMisM/9vpMYzGAtmM6ueFcfWDK+B4/Y/Kr/B0eNQpR1+MJNtOf6pVDy6G+zDKdIV7xuk1dKYgrdNhuy8jq2SYCRHhRIyF7kag+4oYtbeGP3UtdhG/Yw3PzZrUWo7EAlhREwZkATwnKpi3zbh7cd/mY7svG0/69gSc0ZoJLI5KopsTap58we0/ykLIMse+j+ngyITBzDJekUXEhl+21EcEVxTgZNkZ5kU5oxtSu4jTmiy+R8lNBl1uOeX5udaXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pFDeDTPXu5A6eL3rEJyodTUDBnvTJW9kaFDZrAyicWI=;
 b=RKH/7QWLa8Adb8rNU249Wj12njkgSBJOwATpSfZnVOCNUrmiNHKS/zQHkslZ+FMT2OR35kOyvU24m+2DhHTG44Kf7czrt9dqYrwKpEu4dpq02xqNE64YE61lqt5Y4f0hr4oQ2WEcRnHnL6MWgPcdIN0uQZsNxP3gAfDJnxAWgn1T6cbQa9n0++RqzS0dqGoZKaTwIJZCiP8I//FwK/e7f6xRi35nPmJVXs5BxkBR3ZpkaMTz7MrZTD+Qv7c3PSJurGLvNACouBCVIPRqewtRHi+4yK1RN3hll8r7wJrI+A4+ueIvOGxRfm2tRRDonQqTLkLo6aKL1w3dWZ5JoDK2kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFDeDTPXu5A6eL3rEJyodTUDBnvTJW9kaFDZrAyicWI=;
 b=UVzz6z2RphKTvBp56mmL+r67HjBC0VFSMZsGaaAt07ne+Ce8BotS8tNSLNETd/U+V7VnW93jOouLk9A01hv/jSaWvclZYzbiWF4RNWQWCl2J3p0fDFtZOJSmfEbtFiSeHKcB5QcCx0vvcuq9NDEeBOg/o+ld27f+N4U3e1HFYfzMRPs93sHvuhOHlNufhEEhRLSXHya33WfxH17XeS+lE2cmmeShrhMiggdoijvh7lKhNd1gluUHyIdg2Lz/fEwF5OHiyOD1j8Y7/LM4b9kkZvVfSRf6xUoPHAwIHHLYFhq0zNVInhqCCfRbSMeHvJvnuLaM8DGf3pX5cai4/mW7mA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB6096.apcprd06.prod.outlook.com (2603:1096:400:33e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 10:00:01 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 10:00:01 +0000
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
Subject: [PATCH v4 09/21] thermal: intel: int340x: processor_thermal: convert to use devm_request*_irq_probe()
Date:   Mon, 10 Jul 2023 17:59:13 +0800
Message-Id: <20230710095926.15614-9-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: c60271ec-6491-4a28-ca0c-08db812c6d46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YyJueZQLrmGl01i23IkZbc5Hy1I9NhIoRAO/h3KRYrvmbrh8gjo+eXXmmjf6MuTQaed3ochEs3iGHaUSgsaHSf9TPTqHKV58zfo8L7YCAoydVbBCLIpXIfwH8tcW/21gPCdUOZGeBX3LovdAhfv7j4qdxtS1q/druQ9/pjgU8H24/jwWClgsfATfrHw4hL/L3DCGYyDCSO1pUPtX1CfzZnjLqLfW3N3zx2Kl0/cBZ3/++JtgU2Mzxtq5UlL/6A+euGotcs/IrCjqZnthbU9tLrJP4ztLlLi6FDiImCe8Fpr0Ud3zJFF0VmOSXrcI5xyrB2vr397QW3FYWLmX9auCtVSkTp1p2MyGNgqqE0oS3RhWhr5dTH1DXC1l0BYW+GazKGli0vcf/DO4WkvZ9XmxqWX4QOZScAGg9Xtmdf98YDqRxGewHTATMa7Nd8mYEXRsjo5eLnZ1SXVwScwzSeUlItl1w/19K8a/wS0gGr24TUn+kbE8Fxmr1JQtUMZt31QYFhsY5f8FWWKOAP4/cliI0MCjcMkt/4nwIltSu01K/pYWweoZp4ufqwExDo/HCmJCE73PATPUmSUXkDLSFEmUne5XQ5THP18hpduIAklaJ4j7Q5VsryCtCfiqNghmARRH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39850400004)(366004)(136003)(346002)(396003)(451199021)(186003)(6506007)(1076003)(2616005)(6512007)(26005)(66574015)(83380400001)(41300700001)(4326008)(66476007)(2906002)(66556008)(316002)(7416002)(5660300002)(8936002)(8676002)(478600001)(66946007)(6486002)(52116002)(6666004)(110136005)(54906003)(36756003)(38350700002)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OU5XQUIxellGNnp2U0pMZTJ0K3hMODhXMVdNVFFQTjJMRlZPSytrUmRCZlBT?=
 =?utf-8?B?elpDTkw3VXp2MUJucWd5cU9teGJGYng2VTFCbjlKREV2MUpRUGpML28vTVBU?=
 =?utf-8?B?bDA3bmQ2U1UrOHBlcU5nSjd3TFhxODBMcll6STZ6UG9TS3JldktqTlF0eEZV?=
 =?utf-8?B?UEM3UTFLVUdYZFFpN2dHOXY2YW9RZmRxNlJUTy9oTDg1ZFhlVmFSci9Qck5G?=
 =?utf-8?B?NTAzTE9rNTB4TlAyWWhJSlZxR0dkcHJ2ejgvV1NTendkamsyeVZqdmtCVm8x?=
 =?utf-8?B?cHZLUUxVclBLLy82U0pOeHp4SFVqdlplRFh5TzBZMXJTT3JFQ3pQQmJDZWtQ?=
 =?utf-8?B?QS9ueTkrZFNEVGJIYmhrWWlIdHB2SGtiWEl1QVlTOUp5eWhyZkFvd3Y1UG5t?=
 =?utf-8?B?UDFqbjFmNXBSMHVydWV3ZDc0ZmFhY1VJV2lDQWtsdU0xMGdYQ2d2Mjh4UlZh?=
 =?utf-8?B?cEhnMXFvUFY3L1NLOHBPVXpMMXYxb2QzSC92dGpaRnBlN2tNRC9pODBDbmlF?=
 =?utf-8?B?UzRER3ZJeVZTeVdyU0JLNk5HY011QTZmSWwwdEEyKzZtb3NZWENaY25CZU5w?=
 =?utf-8?B?TlJrMjlSNmozTDRYUmk4cFFFbzA5OTR5MW5aNmk2S09CdkpvQnpYZ0RjenZZ?=
 =?utf-8?B?eVJ1WGE3a0ZxcUxvSlNMSXBIejA0SWZmSHAxdUsyRHRnVDIzL3B1bk1aTUhu?=
 =?utf-8?B?NVRPQ21seHZFZWUvS3VoUDQwd0hwb2RUUGFjYnZEeDlEeWFVWllzdjNib0xR?=
 =?utf-8?B?V1dyT3Q0SDR5RHpNSi9WRHZWajFsaFhCSklrQk5tZzhORW9Id3RGeDZFak5Q?=
 =?utf-8?B?RjVFVEduaWNPdXdPWFdFa0pmeG9zQmxyTllOUnUwUmJOVHNhTW55M3hFZTFM?=
 =?utf-8?B?NVpqcU9hUDB6K210eXR4YWVtVnNvSHQvU3p0Z1JGRENqMTExMmVwN2ZWS2tG?=
 =?utf-8?B?eURGeFBLcWdCYWdOL1hsNGFITzZCTFkzMmdhSjhnNi8xcXY0VElaQlBiVUdQ?=
 =?utf-8?B?NVpaYi85V2ZLZkVLNFRwL1h1bUJzUjl4Z1ZJNVdaWGV0YVRJeUVQWkdFbHZL?=
 =?utf-8?B?cVU2Vjl3RmN1c2RCWmpZN0ordGFqZ21kcjZNbTMySm43aVR5ZWZnZCs0a2pv?=
 =?utf-8?B?Nm5zTVpTdEFqU3VxRVpOV21HbEZRZ1IvNG8wajhJbVhtc0NPbEVFeWxLTmxv?=
 =?utf-8?B?N1ZWejcwUWVBSFh1MjRYVEhJbjBMN1psRDg0THNNbE5ER29td0h4ODVIMXJx?=
 =?utf-8?B?WEVmWFhVN2pVV0V1c3FTTGh3Ull5VUROeHF5eXRDZFBpNEg3dDU2V0tGdFpY?=
 =?utf-8?B?aHVWaWs3MmdoMWt0RDFMK0RoRUlaREVyN3YyaHA2T1N1SU4vVGZibkNQSUxT?=
 =?utf-8?B?WHlMNTlYN01xL3dtR044OEFPTG1SeER6UWhkcFphaWVCNXcrRTFVWWhBTkc5?=
 =?utf-8?B?MUNSSG1HMmgrTmFVaGlZb3I0QWhMVjFvRnl0eDV4N3UybnFaVnVicWhWaVlK?=
 =?utf-8?B?MTBXbXpONVh3OXM0dTNJZVljQjloeWt5NUo2YWxpRlIyeGlkNFRodEx3eHB5?=
 =?utf-8?B?OVlWNWhkbTNwQk9DZUF5eUFpcCtMMzZVSTNuSUhRSzlnSlRMZ3RpcFlXSTBS?=
 =?utf-8?B?dnh6V3pGOVRYK1U5Rkk1ZDFQcGE1SUtrVUVoM3FYRTZXb0dPUnc2TzFlV1Iy?=
 =?utf-8?B?VjFhRWpaNnZHQTIyU0ZlTGloMU9FVFhUaFZ2SzdoT25zL01FL2hQR1d2Qncr?=
 =?utf-8?B?aExyaHhVUXpNL05aRTRlWFZBVFMwTG1tMGF2alo0SDFTQ08rTGdDM3NUTDc0?=
 =?utf-8?B?Z0FCYTlqaHp5QlYyb0twZkJSdjB2UjFWQnBMc0tueWdaaDVQR1A3M25hMk04?=
 =?utf-8?B?c29QY2dvdHFWQmZoRzlraThDVlQ5cXZVVDd0QmQzQ1MrdUV4OWx4NEwwMG8w?=
 =?utf-8?B?MzVONlZsWHY0bExaRVhTRkErenJ6ZmMyQUY5ekYrVTkwOHVSS0V1dWlCYm14?=
 =?utf-8?B?bWt2MEdqaWk2TkdVRS9nL0E3TzZ6Zm1VU0R6MkdKUURCa0RaSlFxN0VHdDlN?=
 =?utf-8?B?dUhWeFJhWTJLdVQwNDFTVk1XdC9qd0t1bHdUaFM2VTJpVm5lNHdJWk5jbldz?=
 =?utf-8?Q?v9ds86a3cy9jqkks5RIAGwuiH?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c60271ec-6491-4a28-ca0c-08db812c6d46
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 10:00:01.6346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: utDqBAXitvIcwaciiRzVZi+dG0RhdkI1XjDPtyqr+SODSOKDsIKMVPirH+BgExGapr5WO0fBwP0XYjuf/GE1YQ==
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
 .../intel/int340x_thermal/processor_thermal_device_pci.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index 0d1e98007270..ee766904b314 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -258,13 +258,10 @@ static int proc_thermal_pci_probe(struct pci_dev *pdev, const struct pci_device_
 		irq_flag = IRQF_SHARED;
 
 	irq =  pci_irq_vector(pdev, 0);
-	ret = devm_request_threaded_irq(&pdev->dev, irq,
-					proc_thermal_irq_handler, NULL,
-					irq_flag, KBUILD_MODNAME, pci_info);
-	if (ret) {
-		dev_err(&pdev->dev, "Request IRQ %d failed\n", pdev->irq);
+	ret = devm_request_threaded_irq_probe(&pdev->dev, irq, proc_thermal_irq_handler,
+					      NULL, irq_flag, KBUILD_MODNAME, pci_info, NULL);
+	if (ret)
 		goto err_free_vectors;
-	}
 
 	ret = thermal_zone_device_enable(pci_info->tzone);
 	if (ret)
-- 
2.39.0

