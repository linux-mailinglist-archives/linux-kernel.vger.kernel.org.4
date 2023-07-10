Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15CD874D2C1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbjGJKE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjGJKDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:03:08 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2133.outbound.protection.outlook.com [40.107.255.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635C735AA;
        Mon, 10 Jul 2023 03:01:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UHlh3F2d2mWI3n2sy5wIysjPajXFy4M0OPyUIlClGx6nM2X1bnPR9Z1L9sL0RN7sOVPdnc1ay78NUINxSBIdLrEfOj517WzhPPqXZ3XHutyPpNPjysJ0wnltFq14QjkVBgf+UcQxRhg5Q89XK8TfgUoQ+wjyn/bry5zI+pHd24rYGXxExry/N9D/patpt6Oqgs3US910yjQC7yT0xMPZa9sHD6KR8R1sc6ScpGRLaCuqL8Fnr5UlpA2bpl7zlB49bUNWVUn2PCpSmTHcIpY8Yzn6d/P2w5j7diUhu7KtJ5LL7XiMNfeNjWA2TuTEvC2Vr1pt0a6YPOQxmJVA4TaCcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xYCHd8IQ6ji4sShp4rRPeQ8MYVrT/eJGfgORNUxt/lQ=;
 b=j2TLsjH6dDvDpE5fs1EupHQNAcHKfNtzSbmgFubA1M0KQFylAclhNSGTz8V4QyMmQZRoK7v5p1YK+j/M25ZEVYsQLTM2JBDS3PxMx+9UUSLFy5EZWqTaVWpTlRArTJ/wHCy100dKjg3RJVztMVpaMnVBQWI6SmsJC6boD8zKCQw/W6jfGO1lqkxBEevrpwq6BeHRJ878vPU+s5cogOhdOTBW0tmc4JTOJJWXOdDKF4D61Xtkq9j0KbdhTBnpA4YYNzkfl1+SMwqEpi2Ufz6L/kcGgYwXa8daZsbH3EcHEOx1HOMk3dQEP82di+6BX3uUJteMFfPb/7kmwxB0yCJDEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYCHd8IQ6ji4sShp4rRPeQ8MYVrT/eJGfgORNUxt/lQ=;
 b=CYOjDyK4zJvCSWnxEJoCH73n3o/OMhhv3lHyTm1QrEGmdJ4CYRZgE5417ImnUA7wmaix+bNWczZxNG8X7F0nqLGdMeDUsULHJ//6Dbo2SRr1NeA+JW7qdKgxAjUMDVnWoKGLP0sprY5WR72TAWOxYFH6bpsio4gIYFUxmStV3ZMJ5ewChA9Leb3K8T5lrZAbND6WDCBdwdYhH1bXDGol6S08g+FSIZPznuUy694RY0ftmf2g1v+EQ4l8YbFq2h0VDqGglPPd6vdm0c9pIusXoqYyKGpRHjz23S0LH5OGVrufmoNMYJFhhX0Zpe2a61edWKlY35rUFD6msECE0TOhsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB6096.apcprd06.prod.outlook.com (2603:1096:400:33e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 10:00:16 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 10:00:15 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v4 14/21] thermal/drivers/mediatek/lvts_thermal: convert to use devm_request*_irq_probe()
Date:   Mon, 10 Jul 2023 17:59:18 +0800
Message-Id: <20230710095926.15614-14-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: dabc6000-72aa-41cb-9ad6-08db812c75bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pt6T58Av4KKL9huoJbnq/G8G1iCARwp0uT+7zDjbdWtxbHiVaCU8l/Ub5qECyOdyFiPrf7M2EFyNGYj5M0SC+QbRrukQhzm01zXvHY/nHXw4GTkvhj6077EuxemT8mPVV9LY841++/bnsh0p50/XNsQVy/8wcgmylmYseulWifLAD9J8wyKruptR1/F0riFonn4X2Hz5gawXEDLYDQVzWzWtuZEImTX7v8BMLbxLeFjyZ2MA9GCLLxdT9Vs9a5vE3jJFFgXs6jGneuOsXgY5Ot1eBWsarsz1y+ftxiUzfFp164VmU2fbrGM7Isi6YafmbgOMwDFtjHuLDdPkXMFKpLN7QFk4C1H0yx9XzoVbEQ9aGzMcwuEHx2qcwEPptroXojJLoRIryde1psvppQAm7ogKOFDg1JdLo4W4Cwaykf9pahiieOn8nAwbpoAk9mq/cA09My4GoE4dQqcSSvOO/qcqYTYz8+h44Vw/z/4Zksi+lsFopGUbHKwY1OxNAiHGegp2fN3Dcp9BjJfTskP7yCpw4JyfRmTpO8UciCMfIRackte+MqNy5nMiw5iRseATx4oXHvkOETh0+D3t3AefsXTjGBpnbCUGSUBNONhDs+IZTY1xmY9mfzZwum+z2w8r
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39850400004)(366004)(136003)(346002)(396003)(451199021)(186003)(6506007)(1076003)(2616005)(6512007)(26005)(66574015)(83380400001)(41300700001)(4326008)(66476007)(2906002)(66556008)(316002)(7416002)(5660300002)(8936002)(8676002)(478600001)(66946007)(6486002)(52116002)(110136005)(54906003)(36756003)(38350700002)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2prZ2NncldzT0JXZlNDRUVyVzdTY0Q1NVFWNndkREVQWWYza2I0QXpIN2wy?=
 =?utf-8?B?ZDd2Sk9ZOEY1U09abEtMbDdBS0U1UlEvUlowWFdBdjRDWVhDQlpCUVNwZTdV?=
 =?utf-8?B?c3EzMFJUdWVEaWFpZENhYkN4TXVGaXRjeXF0MzR5ajV6azFMN3hKaFhXQnAv?=
 =?utf-8?B?ZHJkWWl0cVRPRHlWdjNsMmtQdEJkcHdZYzZlc2QwaXZ0UWdNb1liclhNWGIz?=
 =?utf-8?B?N2lZd0FKRWl2THhySVZWamkxUTFGRmVNemV3UTV1R1pIT2pMRHhkRmpVc215?=
 =?utf-8?B?bkJ5MGxnZHB3OWJaOUJYYWR2SVVETnBTaCt0bHRhVWRBazVuVC9sUlMzRGpI?=
 =?utf-8?B?WGp0dGRWZjNGNFhvVnhmYStrREtaWnhpTlRueGoxanFFOU5XSHZjNEFiNmkv?=
 =?utf-8?B?VFIwZW1mK0E0Yi9LdXpRZjVHZytlY2tFRTQweDdYY2I4RnhkL2JEZ1UxYWRT?=
 =?utf-8?B?VDIwMkdueWQvYTRQdE5raVJkRUJYWVhVMzFCUG9zcjcwZnVobC9ZcmdsRU1I?=
 =?utf-8?B?OFQrUzcxVDRPWEdmRzluN1hKcklKUDNsYXM5b01pbmcxdlJ6NEhhdDZ4d08v?=
 =?utf-8?B?VnNwU0Q4amEwZkpLWHkyTDdjWkpnTlpGZEFldE8zb1owUGdtS2pmRWJONzdh?=
 =?utf-8?B?WTRraTJHUkZGL1JvR2dPNGJ5c2hKSG16d0RTN1FXd2J5bnVlRVdLSEt0cjRR?=
 =?utf-8?B?aVBXenh1Y01wWTRZRkNncnhzaUdlUHVTK29HWWwzYS9jR0pvblVzSGE1MTV4?=
 =?utf-8?B?MjgrQXY1RkxmYmxNYnp6UE5FSmwrdEtXalJEMS81YjN4K3ZXVW1QR25rc0o4?=
 =?utf-8?B?S0s0M3QwT29uajNXQmFIMG5RUXFWZmtqeS93Z0RwRTlEUG1yNGFRU3RqTVpj?=
 =?utf-8?B?VGd1dWUweGZsRmJIcFlNeUxaL3hiWUlwTVJSTFE1NEo0MzMwYk1jTUMwanNQ?=
 =?utf-8?B?M0o2NUZEb3pFaVdNM3czMFdzdTJIRzBIcnI1Z29MU0ladjZpNU1YY1l5clhV?=
 =?utf-8?B?VmRaMWw3UmpqRmdEODVyUWNSeFM2QmR3dWxNdDNkU0VyU3VTSGZqMDcwOFJO?=
 =?utf-8?B?cEVKTFoya28yTkNpYzNtSldjNXZHRmdXQWNQUWp1UUxLZ3VSV2xDMWIvV0NO?=
 =?utf-8?B?dzJHcUYvaHRPVEdoRlByd3ZwM0tta2hxWW84ZHBaNFZrTUpteDNCL3dGdGFl?=
 =?utf-8?B?N3dWMTFSVVRkU3J2OEpLNkVneitGMldKMW5yajU5dndHNUt1cjVpN2xEblNS?=
 =?utf-8?B?dlpMcTA1Wmt3ejRJWFAySGRiWHYwSm0vN3gvWnBpTHdxS3FoQnNITHhjMU9p?=
 =?utf-8?B?VW9zUHVzc1A3WWlUWUhGKy8rWVFYZ1dZd2E1R0dkdnE3NEhzZEl3ZnpUVzRD?=
 =?utf-8?B?V3lEcmU2M1Q2RjFOMHFjVWNhN1pDZmdpS3RqbTVhNkp2QjZQdzZMRlk1dDZS?=
 =?utf-8?B?cnBCZjVkOXRWZHhCK2hTLzVOczZLc2xXWmt4aUI2bjBkaXUrZFVYM2h2UlZm?=
 =?utf-8?B?Tm5hWEF2c2xVUWVuOWJwa3NqVlZVTDdPa05UOFVPUmY5UnpxQjFqbFllK3py?=
 =?utf-8?B?aTlwVWpCMElzb21DL1Q1MUVhQkh6WGwybUpubUNlS251UTZPdGZ0d3JJQWIy?=
 =?utf-8?B?NGQrM3ppTzEyTGhmMUtvOXZkNS9CZ1NKcTVtZUdueE1MeGx4MlRCRE9Zc3Bp?=
 =?utf-8?B?Um5OUERFLytJazdlTHBtY2tyd0xEYk81YjhHTUlvbFZNQWp6dyttV2VUbllp?=
 =?utf-8?B?UGVMbEcvU3JudzVJVm52REhDMmUyUUViMFVqS3VKOGNaKzR4YUFCaFRZWVNB?=
 =?utf-8?B?WUYrdjFSU2N3VllITldjS3pVemprM2U0WTNwMzQzTFhFMFlyQ1RQdWdjWXRs?=
 =?utf-8?B?a1kwQ0dJOStTRXRsK2UvakErRlJSMFJuT1A4YXFQRjFSSUd3bnFkc2tjUVo3?=
 =?utf-8?B?UHpySndwZFBGNHJXNmQzSVBpNXFUVnA1d1R2V1FudWd0OEd3cnZxbEQ3eVpi?=
 =?utf-8?B?aEQ0bE1RSFZMbEdOL0VjS1BqU2d6MnBmQW41Y1FkejdMemJ1K3B4UWtvMW9Y?=
 =?utf-8?B?OTZ4YnpkWkcwWEk2R281RzU1Z0FwclFNRFZyZzJzREQyMmYzVnZ4MXdmemp2?=
 =?utf-8?Q?ivtwhBeoEVM8bYHa9sRfT+GHr?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dabc6000-72aa-41cb-9ad6-08db812c75bd
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 10:00:15.8590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zVr78NVIyAsuTOyshiMsFUjYUbXCU68PPIV0eIjFRB13JBlEXwV1sCWqsg0oMK1GX6BgZqzu2+oshyy5sCHDgQ==
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
 drivers/thermal/mediatek/lvts_thermal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index b693fac2d677..1e12410820df 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -1148,10 +1148,10 @@ static int lvts_probe(struct platform_device *pdev)
 	 * At this point the LVTS is initialized and enabled. We can
 	 * safely enable the interrupt.
 	 */
-	ret = devm_request_threaded_irq(dev, irq, NULL, lvts_irq_handler,
-					IRQF_ONESHOT, dev_name(dev), lvts_td);
+	ret = devm_request_threaded_irq_probe(dev, irq, NULL, lvts_irq_handler,
+					      IRQF_ONESHOT, dev_name(dev), lvts_td, NULL);
 	if (ret)
-		return dev_err_probe(dev, ret, "Failed to request interrupt\n");
+		return ret;
 
 	platform_set_drvdata(pdev, lvts_td);
 
-- 
2.39.0

