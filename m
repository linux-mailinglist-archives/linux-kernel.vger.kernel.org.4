Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D092474D2B8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbjGJKDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbjGJKCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:02:33 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2110.outbound.protection.outlook.com [40.107.255.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F812D61;
        Mon, 10 Jul 2023 03:00:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Crca6cIId9y58+pJ4iq1u7EVJ0rElMwpujrRzI0C13XxovCIzvWe2k8/HgdbGozfMBIlwRR+hMbiLD7CqYsGkywqxt5GPZ60U1He+gY18B84XiaE/e73ptyej39dfWY1j371/wAA7hW3ln/SAOkP0j8Qn3pkiM0g/fuKn8TKIMYiNfljCrrEPiqZBsTEsOXm7zM84vi44BXMDtjoiBIwVcf+Uw8SQoPZc7pm9V6K4P+EQvH4vxwHvtYYw4lB3mty8GjamrXk5zOyogPXzf4EwtuJl1RGdQ/kxLE3/dU2IuKe3Px94yROXGrryeiFL7gRFGuzMjSAck6cppTM9D5HOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OjfxK/rG41MW8xIM0n4h07DdTRX37piixiXYncIAkj4=;
 b=KgIpgiqVccgCBKuDFtnrayCZ7hr/Zb5PnA/Eht7dhvdcMi6SjDd/4FVeapp7GFPLmuOF7FkJK0pIEzzZw8RmF6yMZNDZFVvQK5iwujvSxxOo67dVG1ornlju25YdJviaEqNMOqTe5f2fOIu31uZD/ACXG45INWKFICQJ9AwR/2WI1mXQWH50gWl878gc12Dc8VuH7IsQxfY/A3m/LXoy6sGWkSnaRIZ9gsFS5tqSB+5wroxxHjjJwCD3p9T0eVbvGSH2v1ktveu0j+WRijLVoq0RgeIoXc9rpgtEM6KAixKHDDAW/ibWVQ0EqQ50WcEOFoY7y7eIMfIZ7WVyoMw0CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OjfxK/rG41MW8xIM0n4h07DdTRX37piixiXYncIAkj4=;
 b=f6E9ur7IA0ODnj2UASej35lO8vu+OXRjH8MkbpnNTaEtp+PE7MutNPGr/1+NLDdOJ/0793kTR/GtsSeSnefUpzy5KSUjA3ZBSkUg949V0Lp9NgXbgJG2JMdb7lyyUE/B0QP0vfpQUUJCNrlgFYMG6Zentkgwg7UWisb0/5VQdXPC9FmUmAUehVcI5Qa/MFWAeTsEB2N2X4LuOFloTMemnWlZOGg+knQ+OwQ4TQRS5QYnjXviAfOJ5q8pScbExxmJCElkUsnMWRaMlw0AzPtA/RPRflNHnx8GlgCC3YZ+CtvTrOkymxGcMHhC4czXjv03228TKJwwutJ5usKAJwEZgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB3963.apcprd06.prod.outlook.com (2603:1096:4:f2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 09:59:47 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 09:59:47 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Markus Mayer <mmayer@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 04/21] thermal/drivers/broadcom: convert to use devm_request*_irq_probe()
Date:   Mon, 10 Jul 2023 17:59:08 +0800
Message-Id: <20230710095926.15614-4-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB3963:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a995e7e-a9f8-465f-2003-08db812c64d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pUXLoIjvmuH91/Sq71eMjAJw0ggWLALZNbPz1hFfxckdK4RaXbaNquu2CpRRIC7zKiGHeaG47wH/1vK+HPMoSJTAcC+4NALCG5HWGH4RiAI8Q4dMOnjkErurH5mGpjGKjkAu02qnUhlTevAAvo7jYLJ95mKXFKS8QgrbTU5V8DxdsiI9tiYw69hfdpzt5oBm+YE8A3hAazXfc3zuIdbM4k2GUHHThZ5yxJ334gnepE+sctf5LZaChB1Hc1vri9Z/oTsUMZFlN2ILwvvVAT1k35oORy67LZZokSnIDyNKMV254SbbEUuM4cz/MZw8XahBJRxOq+OEbMxMWSyi6ctdcag+3VorTq1ydAgz5wW9OZug0jAtbC9Df/xY7YCeakiV635A5rO/fHUoCOONR11SKQHQ/2VrAzCSYUZTUZIo3+hMrn01xUMQxtAUlfW2vDRTYt7bGtG0iSb3MBwvKeFD023jOFyva4LfEqRRR5FSsLvdoRkpzF11Ytmc6IPsgj2FZxM/DZ7lqmKwxxOIpKKb8/6YkpMiPVej/jDhjQbQwTfVvgp0L0b4q8WIr1LMcsfT8I7+V5VM/RMCSRNJTOdvAj5U8I5lEE3XComVMSBl3zSfnr+aKIWWElhRY0dV/83W
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(366004)(376002)(136003)(451199021)(86362001)(38100700002)(38350700002)(36756003)(6666004)(6486002)(52116002)(110136005)(54906003)(6506007)(26005)(186003)(1076003)(6512007)(2616005)(7416002)(5660300002)(2906002)(66556008)(316002)(478600001)(66946007)(8936002)(66476007)(8676002)(66574015)(83380400001)(4326008)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnVMSDg1Q2ZwY0Q4SER2YjZYb05SdU95NFRNYy9Oc1RMM001R1gzOFNPT29R?=
 =?utf-8?B?SVkwd0JjYjIrcDdEWDhaWmlJa0NPUDZlRXpNc0dVZUNXZ1Q3TnRqbEZlR3lm?=
 =?utf-8?B?c3Z1cjlPQ2VqeUJoRkc2MEhSaTI1WnBPelFZdjZhTzJZNnkxUGVCc1JvL2Jz?=
 =?utf-8?B?R2N1YURZZlREQlc0SFBPM0VET0hmaFo0b3BDMTV0dHdZd1p6d0JUc01DMEJp?=
 =?utf-8?B?ZkpuM1VCSk9ncDBmRG5hdGFZcW5iYXpOZnFGa3k5cWlqdlEwZWNJS3FGamda?=
 =?utf-8?B?L25RRGhvcnRSNWdWNGpXOUJkb0thS3ZXeFNLM3F6QjlGaTlTN1FDYmd4N0w4?=
 =?utf-8?B?VEJHVGEzVGJYOWhnczQrUGUrOC92QXNsU3piaTJ4VXpNOTdpMno0MGhYSWNI?=
 =?utf-8?B?eXpRbWZkZWl0bE1ScnpEU2lEcHpjMjg0UG9CekpuWlZZRnNmRENBdk9zSHlo?=
 =?utf-8?B?YlMyUHAyaklibElpVlBZNDJWRDNUKzVhZktTMEdKT25lNWZYOUZzL3p5NDVo?=
 =?utf-8?B?WkVhWXpFYnM0b2hNSnQ5dFBIWU9zSUJ1ZEJzVWtybWFEZFVRUVg2VlFEck9z?=
 =?utf-8?B?L0x2VndwNTZaMUhmeUU4cjhDcFNSN2xWdTRtTThjTEtkZ2F1Mm5KVG5BWGg3?=
 =?utf-8?B?NDJETXlpb09YWVg1a003WFZEUWlLVC9OUjBRSTBtYkJOQll0RDA1RFVickNj?=
 =?utf-8?B?WDBqeUhiWFJiaHFKUXRVL0ZWVStYMkNaTFFtSHZoQXNaUWt4MVU3NzVxQ3o4?=
 =?utf-8?B?QTVBQ2o0bVlyT0VPczZmQk9OendIVUhaRjRWNmErUFRKb1MwUm1nR2pjZ3Y4?=
 =?utf-8?B?TE1hTjAvTTNDZGRZU09RV0xiRmpKWm9QK1VrZ2VCUHg0R0RSb1RUUnFrVnlI?=
 =?utf-8?B?NkVKRjE3ZXRVaXdyaU82a2xYaXN2UU9pR0RZVUY1amViWVFFdjhWYVJaTmZm?=
 =?utf-8?B?cVVELzVHcUFPaFhRK2hnZTFiK3dQOUhQRkFicmhLRDhGSlcwYlI3LzEzMkJo?=
 =?utf-8?B?bGVuaW0yMFFiMk1UOUxReGRuWXNJVVBsUXVQSnpockRaRE9BSTBHWENJWGJa?=
 =?utf-8?B?N2NIb0hDMGRzU2hjQWV0dHNQajVzWHdVR281LzZEcXlvdXlLaXNNRFR0WVdS?=
 =?utf-8?B?VHdheUk2UnNpbFYzK0pGTEJMVFc0VjIrSWVLMEtIdnNHeTJlWGpYQ2I1aVVB?=
 =?utf-8?B?Y3V0anNaUGRrcERvWjdwajhManpsRy9RNklZcG9FczJ4VC9EcWN1anRXaTQx?=
 =?utf-8?B?NFZnRGR4S3VCNzRYUzdEMk9zQncvbXRVOGdvUWlHODB4WDhKaVFhbk54S25n?=
 =?utf-8?B?R1FxOW84TFBuOEp0QlpFaTJvM0U3aVM0WnFTTkRhM0V0Y0sxUDFjeFNWM1Nv?=
 =?utf-8?B?dnR6YzlBZGNKRmpHYjNYbmVWY25kaXBFWXphYXJRZkYyR2ljTjhFdWd1TU9Y?=
 =?utf-8?B?UFpnSTFISUJNaVI2SWtFVnE4VzJ6elRmMnEwaDYwMmRSb2Z6bVBEWkppcjFh?=
 =?utf-8?B?SUJWdzB0UVhaM0s0UWNZb04zWTZ0Vzk1VjJFc2pmeERIQTVKaWhjNU43RXFv?=
 =?utf-8?B?VDlsdzQrOXk0VVQ4bGR6eThwNjg5enRUWWVZVW1sV0w2VnUxSnc3dEQ5ckNL?=
 =?utf-8?B?T1lpTmZhMVN5SWpUT2daM0ZOemxCVEJEcUFVVzRDd1dTK2lpMlpEV0kvYVpa?=
 =?utf-8?B?STNNWE1KMzhSMGROb2xrTkhWWGFMRElYNHFLOVgrUXpLay9jVzBtQTdmbTZU?=
 =?utf-8?B?VzhXckVsdWZqUytScnRuSEJCbWYyZCt1U3RFNW9kNStIUkdZOWQwNm9jTi8y?=
 =?utf-8?B?dy80c3ZtUTM5QjNsRUcyODhwcmlyWDlLVyt3N005eVBqbVRiSWFLdThxbUVO?=
 =?utf-8?B?aStKWFRWbjIxY3BKU3NsTjhGWGNqYXF2NW9TUmYwR1JSQ2xObFBmb294aVJH?=
 =?utf-8?B?NHBXMGFJTnYzb2F4Wnh1d2pJMlpvdU9pVjJRUHVVMW81S0VxaGNNMzRzOGh6?=
 =?utf-8?B?U1d0d1FoQTEzWUNXVmtZeFZFK2ZGTmRwVmw5amJKQjRUMkFWaTlRWUI1OG9z?=
 =?utf-8?B?WGd1WG50azZsRXNxVHhaQ2N1UC9sNmFmOHBXUWFCenlvOHZKM2EzdXBnazBT?=
 =?utf-8?Q?oMKj5Iw2oZUEPpmGXgjhWy/wM?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a995e7e-a9f8-465f-2003-08db812c64d7
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 09:59:47.4727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WWz7zJD5yp4APSKPpmF/Qqz+IB9EilyFUoQc8SMjVKVbpbb/0bgrEhr12CcdOiOKwqwxsJCN3o5KZvFyQBWu9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB3963
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
 drivers/thermal/broadcom/brcmstb_thermal.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
index 72d1dbe60b8f..ea37e7ee688a 100644
--- a/drivers/thermal/broadcom/brcmstb_thermal.c
+++ b/drivers/thermal/broadcom/brcmstb_thermal.c
@@ -349,14 +349,12 @@ static int brcmstb_thermal_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq_optional(pdev, 0);
 	if (irq >= 0) {
-		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
-						brcmstb_tmon_irq_thread,
-						IRQF_ONESHOT,
-						DRV_NAME, priv);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "could not request IRQ: %d\n", ret);
+		ret = devm_request_threaded_irq_probe(&pdev->dev, irq, NULL,
+						      brcmstb_tmon_irq_thread,
+						      IRQF_ONESHOT,
+						      DRV_NAME, priv, NULL);
+		if (ret < 0)
 			return ret;
-		}
 	}
 
 	dev_info(&pdev->dev, "registered AVS TMON of-sensor driver\n");
-- 
2.39.0

