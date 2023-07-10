Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0520474D299
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjGJKCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjGJKBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:01:40 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2132.outbound.protection.outlook.com [40.107.255.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57CB173C
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:59:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSVSitEbegBrfNhAiCZK7txIqe/Ni4lyxVTE1ml0iqu359k567rJoPpzhzBCYBYuJU1srLK34eZKzwmcUr/HG2mdWbz2ymT2aJH7Pc5yml8ypurmcmzRfvlyNzTmu2TPaLH5JE7M1CYN23Oz25PVKyH8KHG3ZTZYp2VQQOu5k97X3I0kRhF9JiDvgJsiOI0t/95nM0IxgwY6hImG52nNOafKGJb0hMYK8VyLc8JtbWHAl7omgLdYCn3caNL0Aki7DCJBs3RXvp0lqN522EOzvMRn3qNGjcv4iA99VS9g6rLzKrEHD1+ifm49foEhIGCX+uGBITK+YJwmBTZaSab/Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Yp+KLuutQOtTAOdW01O4bS6fxtp3Qa2Yu19BQW/o80=;
 b=CtujRGG9dMhiRwz6bWaC8yKymgcap9lKUOvmz7KxdmJWpOziPBAaYJtXb5akeILGW8tDX/rY3GQOX3mtuRP7jx67g8EOogNE1M9dEKkGcIky6y2VHzS1t23eYrpf/AxcB1NC7EkkYDYorEFE0oHByC9LR6Lx1GS+2M9LCD/5zK7dxN8euX0rxbalOS9EAWKwsznWGW99/0CTqgOoIqZuoLBQ3CAx8++iSpcODdeumttvBLqezIEV5pT7HmMwigMeK/ThkYzhG1qvOEqE6tHrk0caTnZo/syc2O4b5qRjn8fhs0hP6iKM4UWD2bDrDTewPe7z7e3au4pW5rRd9d7ZXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Yp+KLuutQOtTAOdW01O4bS6fxtp3Qa2Yu19BQW/o80=;
 b=LsnZYfdfiGAljnGPSKGwuYgvVYcLotyqmHSDL2403kOBuhyGhWFiYwiNsjrSnf2nRcVolSOyRH2nyAdpGj7sJbnHHPz2lztsgTS0J/Sth2+BSE6pctqueXXrOkriHUYuWWExoJGpHyIkrdadW6eMdy/d9FCF+ks9iCWjgsXOwasxuM2nt0eViJG3KJgS30vmazrIQRlukBNRFsG3dqLGUG9wjqdLOOENVQSqHkFPWj+crfksVFv1ClH2dLncxLTZ5Cj33FsHK3DM9pbksnYIpxdzU2/p7dsfDaZjuULO/etBMARbsWTrOtR5YoLz02o7plBCacPGCwGJOfnegE3rkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB3963.apcprd06.prod.outlook.com (2603:1096:4:f2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 09:59:38 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 09:59:38 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/21] genirq/devres: Add devm_request_threaded_irq_probe() and devm_request_irq_probe()
Date:   Mon, 10 Jul 2023 17:59:05 +0800
Message-Id: <20230710095926.15614-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0167.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::23) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB3963:EE_
X-MS-Office365-Filtering-Correlation-Id: 8451b738-553d-4182-3268-08db812c5f30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 02Q0xr6/YhKNsz+6Wk/I4cF2+MlYwWsQLNlry+8mjoi2jyrri/CYQ1VOzBAmweD+6wRPJGmJ3Sz16nS5gNekGaCOwedwUxD6HHK4OhgOi53KvNLxirHBFBhb5ctxUiVW+OdurEGkXPI6tCt1/TPLqCsFMd9sFBO0MEF2nJHum8mkBP0eCyK475jeXJDQstlWZXMTJz9yrBch4Vs1QV/sOi0a6JUVaYZFD39oQ4VWk/4xE4XF1TRu1zLL6Wd6Q2n7KzBXX1mvdqpuf8R45Nc7C55wI3Vwt8PnDHaiGIvRMQQeI+/7xlfbw2dVofLh0jVJJVQCuOuFKAMVg0h0pIYEImd2bQyM8jQwP5JMIRPLLSMWdxG9N7S/YXhsIbwchNCQxcKWAsMw8jfM6BK3AhP8bM7FZp351iUru3xC/CJtZ5I6v+c/C5ghPyTsC+StaE9GT+xAWmuV0fAwAFhD08Qad1VdQ6ukj4dyTV2s+tS4Y+9QCLdFGYk9p3akr+9FVc+WzV7VLbh+NFZMwexvg7dw7OE+vMgjy6WUgPr2Ce++m6OGJlMAIlhF9DHLxHX5e95i1w3mpDrhdzXVZSWws7xnP9h2F9eMHdWkNdbgvn4+Drt4Pr1hoHqBk0x2xhmkx+0p
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(366004)(376002)(136003)(451199021)(86362001)(38100700002)(38350700002)(36756003)(6666004)(6486002)(52116002)(54906003)(6506007)(26005)(186003)(1076003)(6512007)(2616005)(5660300002)(2906002)(66556008)(316002)(478600001)(66946007)(8936002)(66476007)(8676002)(66574015)(83380400001)(4326008)(6916009)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qk5QbFA4RFd6RWFvNDN4QTNRUzAvNzBJU0xTdFh4ZFhPekpqNmlwWGNEVWRM?=
 =?utf-8?B?NHdZQ0kyNEtIZ1dRVis4dkQwTzBuclcxdWtqZ3BnMXU5bHB5QVhWRVQrM0cw?=
 =?utf-8?B?eHk3Q2swdG9PSkxQblpsdnh0OWlVM3NrOHpYNExxOFk3TVVGc0FJSHdldGV6?=
 =?utf-8?B?akdBOVpTUzVtK3V0cHRWL3ZhWWsyWStaeEsyeEN0RmQ1VXdYdEhESCtOV1Ay?=
 =?utf-8?B?L3BqR2tuOTQyUVNvZklrSnpPdDJUNnZXYm5tSHZtTmxuaFRJWDN6TnRpU2FW?=
 =?utf-8?B?VmlVcm9HWnhZYWpIU1cxRkF0cFVxTzlwZFhWOE1JRDdQVkErYWQreTE4RS9q?=
 =?utf-8?B?bUYzSzhIamk4ZnlLeUVQMng4UklTdERFd0pDUnBydm9UR3VUQjhiRnQyaktL?=
 =?utf-8?B?bDZlcGFqWk00NitkQWhyNHZzYTFFeFFicFlrWTllaFgrWG9oVE5IR21qVFYx?=
 =?utf-8?B?Y1dacnBhVFFvanBKem9VTkVYK0NHN3VmWERxOUF6cVlNY1VsclZLYWYxcVlF?=
 =?utf-8?B?R0VsWWpiekVvMnRkd0FaSW9kenI5SExqcDRnTWRENE01MXQ5YVRZbk5scWlX?=
 =?utf-8?B?RFVXSWlvWmVLUit6dXpDOTd2L2gwSWZsekkvRmQ5VlhpV2lVd0tIS25pKzNU?=
 =?utf-8?B?dDdQdyt5VTFFOC9YeHFaOVBtdWFpZ2ZHS1k2WUp4cVRZM25sVDV0TXVtNDcz?=
 =?utf-8?B?bFhrdEl2WEVuK3dDQjdWRmMvL3VrQnVacUsrQTJGYkRrR3lOblhVRU5YY3N1?=
 =?utf-8?B?NENGRm9MaWFGM1d2M0taS1k0eENMb09VV0o3bGVHd05mNnUvSHVpQ0JRTGpt?=
 =?utf-8?B?Q3J1NDg5cHl1eXRHU3JpaXNGZzVEWDdHU053VGEzdlFCTElBSVFXSVlWbTM3?=
 =?utf-8?B?Tm9MaWtxa0dwQ054MHB4dWl0emlwMzV3S1dTcnYrSWR4VXA1bndpOTJBcStP?=
 =?utf-8?B?c0FwaWFFZmRDTXMvWjY2WlhSV3ozZGZnR1JJY2dOWGpCMXZxdXFnYmxpSDgr?=
 =?utf-8?B?UjBpSndjVkZwQ0lpaFlxczB3STdjaWJGbWdqZVpzdW81KzZSbWdZMVlESW1E?=
 =?utf-8?B?Nk0xVXpNR01YU2JhT0ZMOWRiWXpGM0hEeWs4Um1GY1VYOTRkRlBJKytLL1g4?=
 =?utf-8?B?ZUw4N2daOVVabkwrQ2VNNkhiQkppcVRuV0oybjlLNGtFYS9XRnhoVlZlYjVq?=
 =?utf-8?B?OUo3a2NLblFQbmJJbm5KWnhGMDdwTXBoN0FtVEY4WWh0cFFsc2FHRm9UL2Y2?=
 =?utf-8?B?dXl4RjMzMkxHc2NqdWlhckFPTlhLNFFKZ2Fad3JvYlVpV0JKVFphc1lWNXJJ?=
 =?utf-8?B?YjdRc3RyZUlhcS9pQUtwUm9taU5BMGo5SFcvOVVFdis0MGphK3Ava3lUUzZj?=
 =?utf-8?B?WGYwNTVzSlpweGxRWlF1Y0hhMlJYZ2hnUzN3MkFGZm5vTS8rZjJ6SXg4Z1Nj?=
 =?utf-8?B?MmpaZHg4dGVzdU9ONnRQVzRBL1hobmdsTWEzU2RYMGZwTGVQVy9MSlNsY1Zz?=
 =?utf-8?B?OHF2cTNzc2NmQ2dlWS9GcjRycG5zSm5jcWxYSTZHVnQvM3RoeVFtNnNaVVly?=
 =?utf-8?B?SzFXWld0K3dkK2tDdVI3ZDNUbzBWdHpmK3EvKzRUanNPWmJ2UDVQem5yeHBF?=
 =?utf-8?B?aXk2bE5FajhTa0FtczNDV0pWMUd2UkM4SWpMQmdDU1FzQmVHMFB5eWxqWkV1?=
 =?utf-8?B?SDlITStVZW5LNklyZ2xXenZBYkltQUR3aEQ5NHhNU3VDVW93TTZJd1paZW01?=
 =?utf-8?B?N3VkM1FRWXZUK2lTRWE4bXg5SmZpeVB0dW5BeWhMZ1h6blJ3Uy95TzUweFlD?=
 =?utf-8?B?Q0pJdGdIMkRlQzZHbDRqeVYrK0hQVTJhRGdoUVphR3UwRE13eW1RNFhwV0sz?=
 =?utf-8?B?RDZVVndiRWNXTVJuMnEreWlnT3FLS3N3SU4vRDcxS1NLWUhPTTVMZGZDQXJI?=
 =?utf-8?B?RXNWUnBITjAyblF5SlZXTEI0R203QUUwcWdDVDlCZlFDU2NCcGV3T2ViZFNp?=
 =?utf-8?B?QlRqVlRYa0ZhWHpwTDNaOGNQMnd6TVFjT2Q4cWVRNWEzbFpXdGYxZzg3M0Ru?=
 =?utf-8?B?Nml3UFZYbGpibm9PUmZtRmdFZ1BzWi83SVZtQWdBVTFLRHFENGtPbFpCZmor?=
 =?utf-8?Q?fcRVTBH4tSy9RBvZsHfNfEfo9?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8451b738-553d-4182-3268-08db812c5f30
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 09:59:37.9866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cqFgVeT0RRFjLphr7AoNFR6DKi8chTWkcsqUnwghm5T41CSkQbKoZTpm8Dv7DRPJ2p2UbzL1a9BW44cvIpnWbg==
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

So add devm_request_threaded_irq_probe() and devm_request_irq_probe(),
which ensure that all error handling branches print error information.
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
 include/linux/interrupt.h | 15 +++++++++++++++
 kernel/irq/devres.c       | 40 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index a92bce40b04b..91ab9e501b3d 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -201,6 +201,21 @@ extern void free_percpu_nmi(unsigned int irq, void __percpu *percpu_dev_id);
 
 struct device;
 
+extern int __must_check
+devm_request_threaded_irq_probe(struct device *dev, unsigned int irq,
+			      irq_handler_t handler, irq_handler_t thread_fn,
+			      unsigned long irqflags, const char *devname,
+			      void *dev_id, const char *info);
+
+static inline int __must_check
+devm_request_irq_probe(struct device *dev, unsigned int irq,
+		       irq_handler_t handler, unsigned long irqflags,
+		       const char *devname, void *dev_id, const char *info)
+{
+	return devm_request_threaded_irq_probe(dev, irq, handler, NULL, irqflags,
+					 devname, dev_id, info);
+}
+
 extern int __must_check
 devm_request_threaded_irq(struct device *dev, unsigned int irq,
 			  irq_handler_t handler, irq_handler_t thread_fn,
diff --git a/kernel/irq/devres.c b/kernel/irq/devres.c
index f6e5515ee077..43a40d6e2e0b 100644
--- a/kernel/irq/devres.c
+++ b/kernel/irq/devres.c
@@ -79,6 +79,46 @@ int devm_request_threaded_irq(struct device *dev, unsigned int irq,
 }
 EXPORT_SYMBOL(devm_request_threaded_irq);
 
+/**
+ *	devm_request_threaded_irq_probe - allocate an interrupt line for a managed device
+ *	@dev: device to request interrupt for
+ *	@irq: Interrupt line to allocate
+ *	@handler: Function to be called when the IRQ occurs
+ *	@thread_fn: function to be called in a threaded interrupt context. NULL
+ *		    for devices which handle everything in @handler
+ *	@irqflags: Interrupt type flags
+ *	@devname: An ascii name for the claiming device, dev_name(dev) if NULL
+ *	@dev_id: A cookie passed back to the handler function
+ *	@info: Optional additional error log
+ *
+ *	This is a variant of the devm_request_threaded_irq function.
+ *	It will print an error message by default when the request fails,
+ *	and the consumer can add a special error msg.
+ *
+ *	Except for the extra @dev argument, this function takes the
+ *	same arguments and performs the same function as
+ *	request_threaded_irq().  IRQs requested with this function will be
+ *	automatically freed on driver detach.
+ *
+ *	If an IRQ allocated with this function needs to be freed
+ *	separately, devm_free_irq() must be used.
+ */
+int devm_request_threaded_irq_probe(struct device *dev, unsigned int irq,
+				    irq_handler_t handler, irq_handler_t thread_fn,
+				    unsigned long irqflags, const char *devname,
+				    void *dev_id, const char *info)
+{
+	int rc;
+
+	rc = devm_request_threaded_irq(dev, irq, handler, NULL, irqflags, devname, dev_id);
+	if (rc)
+		return dev_err_probe(dev, rc, "Failed to request %sinterrupt %u %s %s\n",
+				     thread_fn ? "threaded " : "", irq, devname ? : dev_name(dev),
+				     info ? : "");
+	return 0;
+}
+EXPORT_SYMBOL(devm_request_threaded_irq_probe);
+
 /**
  *	devm_request_any_context_irq - allocate an interrupt line for a managed device
  *	@dev: device to request interrupt for
-- 
2.39.0

