Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8D774D2CA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbjGJKE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232873AbjGJKDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:03:20 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2116.outbound.protection.outlook.com [40.107.255.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB5C271D;
        Mon, 10 Jul 2023 03:01:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CU/xUBIrmiYVFP7bgPZ2LW3bbFPsozhh2NbnL57lGNKbptyIFePeaheEwBAxN/AKR2OtXDR3iGkrbLQxxF1cWFphnfbB5Hn/hz60K4cZ+0/yxBhBOyTi3Rw35T1CePbGeWoWHhhkJYRRH81s9qI1w5OLGWklBa9RdX8vn2fxlCjDZP8Yr8pUkIGmrxX/cBHKvTS/A3Q9M5XfumYLRNLuG+HaU7oW2+s1j6M2jnueLU73ruCPvN3XFObOszsIfOnmF2/LRgS58DDkG7M4nZtTl0jdWDxszZlL8ozZmITDhY2J012Tci8vvl7JiuwJrAig9kE4QGnRFR9/ko4hDqKhpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKc+TavFd7Ci1xyoSggA9UVGFRc6ndR0B+ijlcDKBLQ=;
 b=IL6SwD0W6dXt2Iz//EACJwD3Kv44EXzw6mZV4Lkezy6lAkLkH8aNAPRGHCVRoDNcX3/DZR0Bjvg/FdyEVfGHUjZzosyD3ofo7VA2UC8kJve8f9Foux/6js27YphYPYZUPKT+WQn+8YgwdgoRSl6OVUGgXlaOoRvmMgrsui6e2IwBr8JibjRxjNjUdcAgGOxbfGmZ/QzcSNZpZ9GdjGj2AgS68LY0vqgiPsHd7veQQaGXH7bzUqko2wUYq3AGAy0VzEsDQ5yWQ3HxHXxIB2GBcSxAyz60/5clGvxQeWnmvF97p57FWTxNQ4PX0jGR5V8wCqwppfH6M4UEPL3IcRhhbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKc+TavFd7Ci1xyoSggA9UVGFRc6ndR0B+ijlcDKBLQ=;
 b=m2VWPRu5jhlFSB0j9z2ZhN9ulwoolNRRd5mRgVRgzPk1n9/D/UXj5/Nqo3JPc00XXzZ0uvbxFmxpOJ+tda71E9mocktm/XzqMulaAY04BRdLY1iEix1I7bfannNR4Cfqxoo1GK4pJe/1me63tuqNGr8v967Sre1tbV4SMjr6IUdK8OCBVv1QGpBubmKGeWeRJjyA1v1uH2/fWDd+YfWdnggM5fBk/PyZhwW1ksE4BIvlPGsWml0e1LUDOSXDqzJGwO+qbTpXFwBORDRUjoS30Qn5mdanV7us5r5ojgc49OHNS2WnOVaIp5Jr4sRXhk9TfuEBXB1lrd74yYchbpIvkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB6096.apcprd06.prod.outlook.com (2603:1096:400:33e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 10:00:20 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 10:00:20 +0000
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
Subject: [PATCH v4 16/21] thermal/drivers/intel/bxt_pmic: convert to use devm_request*_irq_probe()
Date:   Mon, 10 Jul 2023 17:59:20 +0800
Message-Id: <20230710095926.15614-16-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 12835003-c01c-4d4b-1919-08db812c78aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qKLOWuVt7NVUGJ+zyAMoyvLNtP/Oq4SGxS9ACJqWjKF3WNuWSkQI/KMbRGcONQ8/A+DqudaGrkPNq5cF5OxUDCiNJtjN7QJvxGfh5dqfjNWIbxFDabfjWOMThZQUfZKhtGhC06+i5jHgcPhTCcQ7+9b48swCPaar8x+2D4Yt0CQQ2ZQzNp3pACx+3TyP6y7W4QN7M5YHNjzeKWqwB9LglGTG1Wckz5IB+RKLs8ZSTj1PmP1mKE7k3A1vrcgI8Px3c8CNlAOWr5Pimo44vFpsy3ex7YrV7ClDxQISAWYbYSRMKTR+YMSxijULhdJfU9tdgiL/Wu/Uu3qsC4EixBvJ+ZVKzPPGHwgxXUxku+hyFlM5UMokaJ3+1dQ4BymTUbn30AKMk14xUzxjcd3+wFWZhH364ncqo7ezT9ZPfeSsyz5dCqvvTtqEy4COxcfvqYsj1F/mU30Cp8IwmFZUyCeM811O+/PhfPBQJs//EIObmcHvIRqcjNc4zUVF/xjh+ZO2IXV9YL1lwC6nMxChz1c/PM0BuRoJdLfxMK2eEUlIjOc7SRy4htERlAp2SqaBD+Pf+7+KycA87l5eiDRQSvo+UsxdVtN08JMUN6KSXWtvJEtynrXJA9MA7f0oHHFpMlRD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39850400004)(366004)(136003)(346002)(396003)(451199021)(186003)(6506007)(1076003)(2616005)(6512007)(26005)(66574015)(83380400001)(41300700001)(4326008)(66476007)(2906002)(66556008)(316002)(7416002)(5660300002)(8936002)(8676002)(478600001)(66946007)(6486002)(52116002)(110136005)(54906003)(36756003)(38350700002)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c05aNXdGT3J3YXBjT3hCczVGMVlWaStFQmQ4SXVKWnQ0bjRaUHpLTVhDb0F0?=
 =?utf-8?B?QUk0dXZqdjZOVnBoekRXaTVaS29JYnpESldlMkQrbnlnWWVxSW5SU2RxY2Z3?=
 =?utf-8?B?YzhKdjFvcGxsdWlXS1B5ZEFRWDEybVpZc2xsOHFwY3VjOTZrN2RWMVREcGVs?=
 =?utf-8?B?dWt1MVJRTWUxb21sNVZjOEJ2WkY3TEd6V28yWGp1Mm9zbVpDL3p3VXhzV3h0?=
 =?utf-8?B?Z2lwYUR5OW5VNGNxbnc1ak44YjBnd3J4ek44Y1RRUWdoeCtka1NJa0QzZmJa?=
 =?utf-8?B?RjVhTzh0RWdxTm1wR2JMTmEvdFJraUZiYkE3MFJPOTZuT3h1cENYcTR0b0p0?=
 =?utf-8?B?YVVxMzV5RHA1WXZheStHZEMzSllDY2pFNms2bDVuTmRVa2liOVg4VHo1T1hQ?=
 =?utf-8?B?OUNkcUxMVUlDLzdKYWpuN0lCNWxxcG4wZlNsMzlXTHEvMjBwMG9IQlh2eEda?=
 =?utf-8?B?a29va3hSRmZWcGk3dkNUaHU4b3dZdjlPMVVYdlR6ZEY2Z2hYZlFyek4vb0NN?=
 =?utf-8?B?U1ZJK2xxbEtFWTFtTU4vakJZekZXSm5JMlQ4Qi9FaldtU0pWajhRQmRqK3p6?=
 =?utf-8?B?c1Vzalp3QzV1bDkrcFF4bkpQYmRNRFVKN0VoZGh3QlU0OXdCa0o4RGJERUNi?=
 =?utf-8?B?N3cwcENjdVQ3SjJsZm93OGNjb3poMnE0bGh4U3hVQVpsYnZCTDgxb3l1d3pp?=
 =?utf-8?B?T0VEZ0xrK3BjbEJwSXlqRitnYnRQd2xIZ0h1SFJETXdGQjV2LzFaNE1SM2dv?=
 =?utf-8?B?ekJ6VWNndXFKbkpvYUZUYjlpdWpXQzVWcGw0cGJucERvazhaUmlUVlFhS3hB?=
 =?utf-8?B?UHU3SGlNL3NOeDBRUjdwbnF0WFFNSlBWOEJLRWZPQXBjQ2hEekFiLzBqYURi?=
 =?utf-8?B?TXpPdXhicW9zbFlGVTUrdGdQSTVuVVNXZlVmQ1J0YklvSkJyclpxcjhsY3Fr?=
 =?utf-8?B?Z2lTQ0xsOHpSUWNFK0JKZ1V6VUxDNi8xd0JKMHdxT3M4Y3pMNnkydElxUjhu?=
 =?utf-8?B?bVVBZTFNR0J0L0p5YzMwVmRQbzdKR2htQzlkZm9uYzc3aXV2QUwwUWJrZG8v?=
 =?utf-8?B?ZDlGWXYyS1E1eHd6dzBqR2VkSjNhL0dFbk55U29zUXFEdFI4U2xwd0RpdkRH?=
 =?utf-8?B?TUk2bnZhQUgrR1pUL3M2Sm1UY2FjQVNDOFJ0ZUJ0c0Q2eDdleVVhSVBIM1g2?=
 =?utf-8?B?WTI0UUpnNE4rQlc5aUVqSEJiVEhNZUtOT3BDdXBTMVpkc3F2VXl3bzNQNmdO?=
 =?utf-8?B?azBrZ0x6MnlCS05IUlBpK3J0enhCK0lOYXNPMTFiNFVsNVMrZHdYN2JJWGxS?=
 =?utf-8?B?eHZmbnM3c3ZlTW1HM0FxeCt3b09nUzdPaE10L05sV3Y3aFhHYWtabGQwRnht?=
 =?utf-8?B?anc3ZlhKbjFHdGJpRERnWUJvOGNLRkgrZmJyN2taWFhVaG9JcS9CT2pUOEsr?=
 =?utf-8?B?M3hha3I4amdSTlIvNzFhcGcxeFRucktGcjhNclhXZG9pZ0tYdk4rUzJ5MXRi?=
 =?utf-8?B?ZVdHTVNrdVJKRk1mdWxJS3NhOHRTbnEwYlFIY0tkTWZJaWk0OHNYbVVaTWFm?=
 =?utf-8?B?czRBbXpNZ2puY1ZZQkhsMGdMNjJ0b0JMUjIwT3gzUFlzZnVMTjZjaW1LQWxT?=
 =?utf-8?B?SnBuM1h3RlBrQXhWQkkzMVdZV3ZnNGZBKytrVkNKb2pGZUF4UDY3UWtiSG1K?=
 =?utf-8?B?OHdUUHQybUxKQTd1MlYrbWI1WFgvSzg2emp2ZUNiSnFFdWh2djllZjdBR0Jr?=
 =?utf-8?B?SFcrSlJ5Q0kzZjVObzhVSy9ZNVFxNEd2YnNEQVUxcG8zTmVxbmlSWFErL0to?=
 =?utf-8?B?d0w0YjEzVDViM05FTGc0QXkyK0NHWkE3S20xR2VHc3RQcStMOW1lQjcrMVgy?=
 =?utf-8?B?a2RLcmZRbElncTZYbmxXczUyWU81VDV2OXBUd3pXVnlZbVNEcnlrMW5oc0tR?=
 =?utf-8?B?U1hzMkc3dDNmWHlTSy9zYlRxMzU2b3V5dnpBRklSekFtbGhwdTN0OW4yWkFE?=
 =?utf-8?B?ak52cThGb1g5NHVkbUVBVExEZEE4QlFSZXBtSHBJNlFHKytCOU5vczVTWG81?=
 =?utf-8?B?T3lJTDJmN2ZNU090WEZJbmJNMng1bzlaQk1EZmxoZkR3UWpFcnRwb240NkUr?=
 =?utf-8?Q?WBBb8AN2Q6y0DFDV2fN3Tid4H?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12835003-c01c-4d4b-1919-08db812c78aa
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 10:00:20.7622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bDz1uEb2s9sSD0k0Xq+WcNcfzmef94oxdkH170q5DQYGv9avtCw+a8NsQB2oumwXl+nBc0Cy2HX8pcC4/VXy/g==
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
 drivers/thermal/intel/intel_bxt_pmic_thermal.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/intel/intel_bxt_pmic_thermal.c b/drivers/thermal/intel/intel_bxt_pmic_thermal.c
index 6312c6ba081f..1bf3e6bf8052 100644
--- a/drivers/thermal/intel/intel_bxt_pmic_thermal.c
+++ b/drivers/thermal/intel/intel_bxt_pmic_thermal.c
@@ -241,14 +241,11 @@ static int pmic_thermal_probe(struct platform_device *pdev)
 			return virq;
 		}
 
-		ret = devm_request_threaded_irq(&pdev->dev, virq,
-				NULL, pmic_thermal_irq_handler,
-				IRQF_ONESHOT, "pmic_thermal", pdev);
-
-		if (ret) {
-			dev_err(dev, "request irq(%d) failed: %d\n", virq, ret);
+		ret = devm_request_threaded_irq_probe(&pdev->dev, virq, NULL,
+						      pmic_thermal_irq_handler, IRQF_ONESHOT,
+						      "pmic_thermal", pdev, NULL);
+		if (ret)
 			return ret;
-		}
 		pmic_irq_count++;
 	}
 
-- 
2.39.0

