Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8780774D2C0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbjGJKEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbjGJKDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:03:04 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2116.outbound.protection.outlook.com [40.107.255.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0914A30ED;
        Mon, 10 Jul 2023 03:00:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kmg3uoddLgH2HqJ4Lq9wtmkTHazEPeYHk0yc60f7Zq8+YLQIbKTH1DGIwyie3W182vXBcd7FQ3F6rrLHXE1yirmTn7R++qhRPf5FeyzKVMkIezDZX7VRwLBY4SEi1AxCOkqiRoMkfVJNHdedJiWtBA+JTKs/X94K/6csnoPkmKPgbrOal6+6I4aV0c/uhLFmzHFc8xpjbtTMOqUkO71A84mUnj2FROlsTcvojAGGPrRoyHx76f9J+oEnWFU2gbtFCDWbb3RIkC+HXbQDUQyCfx2RoEutIAI6VsWtXHbMKKHVzt3KBqMu00h6W/vnVSGflQ55TuQPrx47bVw5V6X+kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2bNiGiAU1XFsAzb166a8FEiVMJJWw+3IBnh7N4SJ7M=;
 b=j3DVgwAHwNEaKMtwybnIJCQ3vVFTXCoKlCW/ElXB08pUg0+roeiJRnG26cuHnrjDBgO09FcAvLRzNfgjBuQvrJfDsACi5WScnjdveLL31xcCVfdgwRR47D0g97xTaguy0Xr07d26aICULr+JTl+3vt9fH9Xk8cp90zoPgyhZ06eqz9xDangnXsqXfVvfZHvqx4sWnnyGLyMgrleEyNs72mwBJ60+ndg3QDsKv10yD+zwj/0UtQctE/QhuGQK42NMBP8XdjYDw55/pu/rujiNgJdrQxk0sZthYKXdKel3t+HWyTWsEKLGrgdh8PJJi5al3cudI0nFd6zikQ2QATIiug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2bNiGiAU1XFsAzb166a8FEiVMJJWw+3IBnh7N4SJ7M=;
 b=OTivwJYdrPsPuKlTbRSi7SdXPMYC56kvgKem8+V7MKZFNoNjz4PnKglGg1C5XXACLz1g32ufLpTf1aiBGp4DDw/u3q80N9gmnW+26UZnYzwpwOdEVR91UsQjCFGKQW/9fyTdzV69kgyp6ztYb8SImIBWTTnY022TYv6FvUOwTfv3HB1BRaXmjSbQ1zOTC0EzZqOJpvp2yiK0+aVCQbIeHeDIlLviRx/c3tuECalcQX7B/RL+YLAAyDF7jCB2rRhhhN3jfsnFhbY0p4U+Nz6kGhVu/NGUUmss3IgDSlMPz908u7/pxO8MGmW6MkSJZt+zAz5aP3CM1gM7SShsY1TkgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB6096.apcprd06.prod.outlook.com (2603:1096:400:33e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 10:00:13 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 10:00:13 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 13/21] drivers/thermal/rcar_gen3_thermal: convert to use devm_request*_irq_probe()
Date:   Mon, 10 Jul 2023 17:59:17 +0800
Message-Id: <20230710095926.15614-13-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7f49ba53-00f4-41dd-a016-08db812c73e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FGFxXNSk8r927CST4YDqi6bWtLMal84kHb1QTmR3jv+iCCQ7r09Qx11XFZOmL1vXy/+l0yIQbWBil1C/ZiES0QLoIx1XcgkVeErhbeHF7RUikL89bxEH+jd15Cars6rLcbXRYt5pIAcq7KNyX5fdB/CEWKOOhQe/hJuuttdQWLdfi9nNIjC6UO+Gr+Po7OY5Jx0nSvU1o8GBkEwwEjizejuHOM/VjkH59evPuAGctmeOxWt/oieLFDOsa4zzzQKg6FQ0/2DGSsD9dNHGkuP/jSd8qWm7LST6AvLxujD1ylam9SacWH1VV7i10jLKdP+J959lvfUZM6QE4kIhlFRiZrhpkNBM8wauF2UVVmGxxKaQ2aFlrEKVEqfyppQG8un6eCDzXEXd//AV+yGlVNZ54aexK5TwowRGhTLj+ZIGelDuHRrBf2rQgOwzldvUosHCq44asUBt2BlpBAahkXpB7+/2HlwQgT/+GNZzIVPrcx/HFJK2VdRqTFczgmvLoPstbPS0+xiA6AaD+n3NtoTVvN0rmQdFmlv467nxLlDEVzI6yChrhzhqgR16RMGCSJy/1qSYG8WfnSpy8fLicj+XnlRpZOPnTh4BPWAZjliicVGOF39mVCUVyGOmmmOrxUTM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39850400004)(366004)(136003)(346002)(396003)(451199021)(186003)(6506007)(1076003)(2616005)(6512007)(26005)(66574015)(83380400001)(41300700001)(4326008)(66476007)(2906002)(66556008)(316002)(7416002)(5660300002)(8936002)(8676002)(478600001)(66946007)(6486002)(52116002)(110136005)(54906003)(36756003)(38350700002)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGtKUHIzWXpCY1ovV3dWK1Y2ZEdRN1d3TlZpNnVEcXJUWWVXMTBSbnZWdFVB?=
 =?utf-8?B?aTZNRFg5ZUtzNng4MHN3Mlk3M283dWt3VWJtRHpSanY4WUtIWURVd2g3RXNn?=
 =?utf-8?B?U21YNjBrQlUxSzVxazFiRWJCMy92SlE4VmtLMmtjbms5MGZFcUZrcW8wWGJZ?=
 =?utf-8?B?WVBMQWJSdWhsZ3orOTVScGNzeHV4NHFJdXJzWGFLMG1BalFTanF1aG5taFlS?=
 =?utf-8?B?cW5JeDJwYmFXdlVRenFSQWhDbGNWNzVHb2pFb085NmJTKzEyNnhqSS9WUXFO?=
 =?utf-8?B?dVF5eGJuc3pocnc4djVLYmdnKzNKR25HRzFmTkFXZ0hyTWV3bjU5dnRob0RM?=
 =?utf-8?B?L01KQTl0MlVOMHBITjBTV0h5Qm9KRlc0RVlKMjJVQko2VDZ4bmQxM1hXdnJX?=
 =?utf-8?B?K1FqZXRteFFQNzVUSlhYUGtxNWluVzFPU2FpM1M1cVBWSDIzRmk0L0p0cXVj?=
 =?utf-8?B?REVyVTNoMkU1TUJRZFFBOEd2cjFaRVJYNVdIbVVaVXVsRzhlWG5weTEzeFlE?=
 =?utf-8?B?OEFiaHBTUXBwa2ZRUmhGb09BNGp4YmV6TWcwbTgrU0NrQUpLL2VoVUhmZnR4?=
 =?utf-8?B?MVIycVF0U1pOaGY0SWRrMnNzN0lyZ0hIUGdCZ05SVUVWT1Q4eHdhYnlvUjhW?=
 =?utf-8?B?eEl5WnlOdTdXLzM2M2w4cEY5WmRVVTc4cU0wQ3ZmdkZtR3RRc3pQV016T2ZM?=
 =?utf-8?B?QnRsQ1N6UE9VeDY3TnhtTWpoV0U2c1BjdHZKbHlkVFdkUFViWC9hYTRyZWRK?=
 =?utf-8?B?SVZuZmRtWE1nSDJ0NDhSSjFjVFpaTVU1b2J4Z0o4Y1ZxQ3ZnK2FmbWpXVzlC?=
 =?utf-8?B?RDkwam5sMm1SYmNiL2lkSWthSEJlbVh3M0hhNXRvODhlSmZYNGszTmVYck40?=
 =?utf-8?B?U3ArL0hOWFN6Vk41M2JJUUpuMndxb1J2d1dDKzlxWHd5cWt5TENwTVpoRWoz?=
 =?utf-8?B?U2ZEZTlIWVErTFdEK0kxT1BQd0JYeGw2RDQwVnZJVTJJRTd1cTZ5cWl0dFBx?=
 =?utf-8?B?bGpid05reUFwWDgwcFRFL3c2M3RReTVrZ1JXV2FFVDB2N0w4WWdOalo4NUFt?=
 =?utf-8?B?RUlIa1pUN0lRVVoyeVBPNlVHRnhqWFlKNTRQNGZhcUhySmZXL2M1ZFBHSXUy?=
 =?utf-8?B?MDFNRHBHWGF4UU5hVE9VSzN4YytId0xwWk9kU0lxdWgybUx3MEpVMkN4cnJ6?=
 =?utf-8?B?ajNGT29zbnFvbVBkcWR4WjMyM0J3aEFOZjE4cUlUMkxFTzFOdzlOczJudTJh?=
 =?utf-8?B?YVIxZTdYTDZOT3lySUYxeTlDc1BWYVk2VzdtYVFQZjNzRFdHbmdOV3hBb29z?=
 =?utf-8?B?ZXVKa3lOODA3RGJFNzlFdUlEcmR5VG04WUR5K3IzeG5ibXAxVFUvUXVNalQz?=
 =?utf-8?B?bU1KOStuWm1USkQyb2lzMEhnQjZxenBCVWg0RmRxdG8rNmZWNkQvZU51MitC?=
 =?utf-8?B?OGx5OGxWcVluWTgzbXQ1RzdLOXUzSmcvT05FZ2k1QW14S01acEl6ZVUydzJs?=
 =?utf-8?B?ZmY4b0owT1JRN0FvZEthRWl2T3Q5LzRRNFA1b0pEckhxTmRZWDVXNVJRTWRY?=
 =?utf-8?B?Zzh2SEhQMVREODI5eUdUU2x5a2FIVTRKbW9GZGlzOGhJUXpuejRWamRtWFcz?=
 =?utf-8?B?SXBzRXByMllKMjRyMTloWXNwWE9KTDRGOFhRckJCT2tBM080NVVENStyMHZZ?=
 =?utf-8?B?SHpHd0hBTDFyQmpMUDAzcWtrYlNtYUVXTlpOeWhtMktkN2lZaytBcks2NlpI?=
 =?utf-8?B?QTMyT0hYeS9Tcis2MS82a3cvZndGZlp4WXJleEY2eTdlTVNZSlJLRVBwa0Iv?=
 =?utf-8?B?WjhNRUlSMmRCdnRIZzJuM00xYmd5NXJhaGUxSTlDSDdudkJVN2p6QXhLVGZr?=
 =?utf-8?B?M3VwOHd1WTRhVmp3b1RJWTB3N2hQNTBubVE1RmF4WDlmM01jR0pJR2x2Q1pk?=
 =?utf-8?B?R2dZeUNoTGswMXJ5R2tzZVpPUWZkSzIzSjVWUU5KOGl2WDJnMEM3cGxKU0Fh?=
 =?utf-8?B?dXFndktoOEdCdVBQNm5DQTNaNzB3TGlua2YxK1lFMXl0dU54cm5vWHZGbVBV?=
 =?utf-8?B?d2pvendKMlhBRHNTRnpwY3BPUHhabGJRZ3dGSnNLZytmTTM2RU1QazRENHly?=
 =?utf-8?Q?C5iBUYJ2LDe8VRCsP6H82JZHg?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f49ba53-00f4-41dd-a016-08db812c73e5
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 10:00:13.0849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jK3OZip0T5XvRxstfX7oP9M7m0NVbAiRX95lgWxXkEemUO7bVjk69ESr9BmGMecugVDNL5KhHmlQyJC5G/2+ow==
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
 drivers/thermal/rcar_gen3_thermal.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 9029d01e029b..ff9cd43e1881 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -467,9 +467,10 @@ static int rcar_gen3_thermal_request_irqs(struct rcar_gen3_thermal_priv *priv,
 		if (!irqname)
 			return -ENOMEM;
 
-		ret = devm_request_threaded_irq(dev, irq, NULL,
-						rcar_gen3_thermal_irq,
-						IRQF_ONESHOT, irqname, priv);
+		ret = devm_request_threaded_irq_probe(dev, irq, NULL,
+						      rcar_gen3_thermal_irq,
+						      IRQF_ONESHOT, irqname,
+						      priv, NULL);
 		if (ret)
 			return ret;
 	}
-- 
2.39.0

