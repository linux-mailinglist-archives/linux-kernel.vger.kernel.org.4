Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573FC74D2BC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbjGJKEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbjGJKC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:02:58 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2110.outbound.protection.outlook.com [40.107.255.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BB730CA;
        Mon, 10 Jul 2023 03:00:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZyw6G2pNefYS17jxRwKTPn0Jd98FFnNpo5p7eHBal41/vmvsUcJ/V9JkpDawzCKKZJVvQEEMLG4Jz66U/lB//12wc53F5Sao7Z8KJ20SO9DZriU8UUebugV0hw5xwdp0QAhaKbGpXwcWde0UFZop1IZj71Cv2NojqpNfpgLDUp9H/gtntVg81nxUvsl6gU1UmOLprdcFRzqYUEgoi/zfyN+vCEiYyqcOKp04HFb7cgIQxg2DGFaYS7ImVKH72oh+2vx4oFM2CZOv8XEK6gMOMMmS5GXSDFxhK2C7oFGaYxassyHEz6OjXN26u5OLV9ZBfPnZEG0JlCSCJAwOFXykQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/w//BqtE6H8wecTg1zc6Yupf+C+wlKTV4AmMFCwu/Q=;
 b=V/q0Fa/2a4jGnoEG/XGEOiheHyhMI314shHB6xUQbSlROTasRjewUqRXAcPzzJGKNp5B6ZwcChe4FYq6tJ+TOy9sUbZnYZzle8E9HJhEHwzeR5xPvkbbAw9xvL/3ISrcjM6/XWJJZBoC5RcAe18y2bncinDEL28bP6O/MGithSZGXCI/DPRHp37AcTbjbUz8m7zAjQhKzI6bakrAR19leHvaaH6s0BFgEWXKKNPz6oLVEdP/klYBHTBuJ/sZFe5PgtFIGx/ugtz4PX+m5Ao4I/2UTnWF/vsVJ0SfaYMAQp/A7K8alL2Nvy1Q/Hu+ZYQHZ2PEo47/6v7fu0SANaBAyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/w//BqtE6H8wecTg1zc6Yupf+C+wlKTV4AmMFCwu/Q=;
 b=BxBRDJ5fVlRSh4qy3BnkFuDzI2NGLrQdk9Ce/fdo4qdDX/Pl9QABLOy4z85XWgLbxvoSA/gAyGIm7e/n8h6ODjLx4Pf6g254VFXhKtQXDh2mi5YND0sRRnlqyi4U+73ZuVCqmKRZZxA15IfZJIRXmpxNTp9vP1QEboQ7D+e/VW7/nrwmNcH6RAl3KEfZ71kJbj6Kvo72gX4+9WBluZuS0G11PnLU0wQnlh0RNPt8Od0ARVXxxHicGevnXyKaCN7C1UNowRMMwGaSKPKgKajYV5xeCo3X/HQ6kRBnvfD6EGrRTDyxw6DM0M3fFz8u0Ha18kpXse5DAI6FJBccgKxoCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB3963.apcprd06.prod.outlook.com (2603:1096:4:f2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 10:00:30 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 10:00:30 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 19/21] thermal: qcom-spmi-adc-tm5: convert to use devm_request*_irq_probe()
Date:   Mon, 10 Jul 2023 17:59:23 +0800
Message-Id: <20230710095926.15614-19-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 081ffad6-8613-4e7d-77e5-08db812c7e85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iOhfQAv3U+V78sVR3FD3jZXUpwShDL4Zi/P5AbI22p7bpTNuVd3J1XyFZFUtXqHa+OqaKPkx5emMkCGAluv2TVKKH7+cw4L44Gg6lI7sBrCIrqtWYhvqZj8yCoNKFhtugCNYTZSQ6cTlipkNzuZSjDc+VERzxB0ZyRFPBaCxLOHW8RT4sEi4n3WlCGcDYR2hY3qGVUgQVeOSqiP8wbkOAZMnk45dHWhXZyiz3ZP82ZhkdNWi88JypKp+Kjmo9bP+3IQit0Qq4fKM0Zf2joze2LncyzytxwGDNjnW+4lBfsR+KSz5FbXamHS5A9iFgmYiscmgr1Hb73SrNY50ps26oKVuEXzWaFG3Moae0iTwuOqvnOPV7Q+PeP1xzQkQPlIb+rzk9R7/pPublvMX9SKy8WjH5oMIMeUk5rG0l8mOY7BsWH8sgHMyZRlfBVRF7l+QLIOS1Oip3oao3GF0P47sKkiNb2EoCnO7ERlgWJehXHQ372RMEoFAeA8UotyPsMOOVETtFugYqi5lC4Jl1jc9ANKCv+25XkaYgeJ2IMHlH/E7KdI8Olk7SGWT3IAA/rbqY1YWprbyaZKIUOUNe3ySiJDUKpwWMgcNID5BFsZCTWmHP9OfolqqFUEeqocwtoCT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(366004)(376002)(136003)(451199021)(86362001)(38100700002)(38350700002)(36756003)(6666004)(6486002)(52116002)(110136005)(54906003)(6506007)(26005)(186003)(1076003)(6512007)(2616005)(7416002)(5660300002)(2906002)(66556008)(316002)(478600001)(66946007)(8936002)(66476007)(8676002)(66574015)(83380400001)(4326008)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFVFdGtQWlhnUGtRN2o4VExLRzllbERqelhaVExpeld6NElQeWlCejM5dUp5?=
 =?utf-8?B?bkRuV3lDdWlWTjVYNlRtbHZ0enBFRlltZ08xU0VZMjErMEcrOUhpQU85cXF0?=
 =?utf-8?B?MG1BcGo0WWs4YzYzeXZvTG0wWDNRYzgvcnBraGd2T2hKekZCUUJVTTM1bXdy?=
 =?utf-8?B?YmY5cmtGYysvNFJlYkdMMkJ2VDFmaFhITC9Fa3V5aDhGd2hDM3B1N3VSU0xr?=
 =?utf-8?B?d1pZNEtVYU9aQUpNclBmbDdKdys4ejF6WDg1Z0dBR0xBSWNqZ0JWUXp4OTM4?=
 =?utf-8?B?QUJoRDhraXBLLzhpeEJSM2JHaGpTWUZOdzhCUFFSNlk5V1lNbTh4MVIrODJW?=
 =?utf-8?B?Z0dmU0kzaHB3SGRmeG9PS2FoU0d2M2R4aERlNWxUR1Rsa1hxNUt4dWlIVXcv?=
 =?utf-8?B?QTlOVG9JbDlzRGxVSUxxbVFaUGpZUXB1SHo4Q251QXArR1RqbU9oRGtQMVhS?=
 =?utf-8?B?OXozM0pTbEJueXZ6eEs3WUNuSmlQWmVuTWwrWWQrQUhEMkJrRjA3OWhpVUsy?=
 =?utf-8?B?WkFoRjJqeXlWOTRlV2hPbm16UUpQa2wvWG50amJZLzlqckNoSHlBM0JrQ2xV?=
 =?utf-8?B?TlZQV2kwaGVYa0tCVGlPZ2VXZDVvMHkyWFI0bnYzWXlydFNFdnRaQXVnaVFr?=
 =?utf-8?B?cXpiMml3REt1Y092V2dJTzdKMXN0TkMvY0VkNkwvZTdzVU4rQ1o4bVpoMkJV?=
 =?utf-8?B?MTRiUDhUcmpHOUJOdG5uSytIYmlKT0M0MEppcG5ROWpCT1gvYUZSNEU0dmU2?=
 =?utf-8?B?OUJDcTE2U1E4UFNPc2JPbFpTTDF0NVBjblpxRGJPYjFwRHRqdVpvb2tpSVNH?=
 =?utf-8?B?VXZ1dzJGeEhjUDVWV3g4c1NMNm1sTE9WN2hwQmYwVzRiTXMvbWdtSWUxQVVL?=
 =?utf-8?B?NzczQVlKR2VIc1k5VSs5VjhBRGVsdFR0YVhYdmM2a0RJRllkQ2hnVC8wQVRT?=
 =?utf-8?B?bGNJcGxseWkyQlFBTmhzYlJhSDBKSDZkdmNoWEg1QUZXTktvODQ2c3R1aVdy?=
 =?utf-8?B?TzU2ZVRKRVJjZk9qcm1vVzRLbWV0eUZjdjJhZS80eUxEOG1BNEhPWU1SS0VX?=
 =?utf-8?B?VmUzVzNxZE5BditkVEtpM0NGQzUvbEc0TlJSQmVOUHN2VkJTOXQ5MEh5blQ0?=
 =?utf-8?B?Qm9YZ05aZEJEaXlNVzFWKzRmd2tJNXowaXNNdGEzcVFuZlF4a2Nyd2Urbmo2?=
 =?utf-8?B?TXJiUzBYSWhnKytMTjJza2JxdTNlN0VUb3kwK1ljbmljRmc2cy9EeFpZdEJZ?=
 =?utf-8?B?RTFrNy9DaU9LWWhUNS9HVlY2NDNXNE5ISlhQZS9Fc1FOalhOd0V5MGZIU2J6?=
 =?utf-8?B?dzJWS0tOaklEMnoyWmU2ZlpQV3NqUDk2N0VmOXpVaUZrV0x5OVNFUTByWFFT?=
 =?utf-8?B?TzU4ZG5pUG0zOTlPeEJoUE0zV0hQYXZURGQrUTk5NDlnZWEyQnpUTlJTMnRi?=
 =?utf-8?B?b2swdmlWR1hyOE1Pdk96dFFnV3lzRlplclo0WFpqTUE2SEpEOHA0QmI2MXpw?=
 =?utf-8?B?RXJLSHo0MnZyd25ESFB5Q2pkaEdJeEJpYWRQUmFoWmVvTnc3bnJMU2ttV2pY?=
 =?utf-8?B?RkxWNTRXSFI3c2Frb3Nwbk9wQ2VndTIzaFlzYVMzbkg0WXF6Vm9PenZ4ZUc3?=
 =?utf-8?B?N2Z0WWUwZ1pickszYkdPYVRueTZTejQzenFpK0orUGxCTEFHRy9lckx3Rmsr?=
 =?utf-8?B?VWp0aDVWWDdLMFVtajlwSjRCam9rdGt1dUdVeTRJS09VT3NVUWxiVHhYejNs?=
 =?utf-8?B?eWhMZVlabEJHRXZnYjh4a1B3OXVYRG1pUk9scHlZa0dWVGpnRFo4eHQxNFB1?=
 =?utf-8?B?SG1qSFJxeFQwY3pTbkRjeE9LL3MyS0gzc2hpcHkrR0lNMWJDVk93TUFNZlFG?=
 =?utf-8?B?UmNYR1FJZlY3aU9tUEJDbjMvL0pwYWVLaFRTSjUxdkF4WUJsd0J1REoyQ1RW?=
 =?utf-8?B?cWgzK29XYnpYa0ZLaFcrTERVTWJ3c3V1bjVvZ1JiK1N6RGt6YXpSUkVYa1BO?=
 =?utf-8?B?ZTUvUmVMNWk1VFpxWCtWU2pnZXZ1a01YeVZmZFpveFFiSUo0OFB5NllGMllN?=
 =?utf-8?B?K281WlR2aHp0TE9JRWFyS3o2VzJEcFlQYlpHeEJxb2N2KysrdEI0UzRpN3hr?=
 =?utf-8?Q?n5xiWXMtbWwY1xsmAjI+OpmXZ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 081ffad6-8613-4e7d-77e5-08db812c7e85
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 10:00:30.5281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ip65RVVM/spuJ8GTIiT+V7pdCgYdnRMxl/WSlp5p8LbXj5qZNLgFzz77GTMjcyJGBSsF2u4lqz/vXgEjnMZGoQ==
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
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
index 5ddc39b2be32..90d46dc60806 100644
--- a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
+++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
@@ -1044,8 +1044,9 @@ static int adc_tm5_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	return devm_request_threaded_irq(dev, irq, NULL, adc_tm->data->isr,
-			IRQF_ONESHOT, adc_tm->data->irq_name, adc_tm);
+	return devm_request_threaded_irq_probe(dev, irq, NULL, adc_tm->data->isr,
+					       IRQF_ONESHOT, adc_tm->data->irq_name,
+					       adc_tm, NULL);
 }
 
 static const struct of_device_id adc_tm5_match_table[] = {
-- 
2.39.0

