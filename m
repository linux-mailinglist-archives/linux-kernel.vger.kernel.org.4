Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A38775010F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbjGLIQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjGLIQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:16:08 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2090.outbound.protection.outlook.com [40.107.215.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE691BF1;
        Wed, 12 Jul 2023 01:14:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YC7wBwA3UKuCTu1l5W0RmXaPYjRlKEq3olLBX6FrzPkKyvKoZ9evKe+6LabQ4W6l3IFjGrbFMl/emt66ieQ0PFzny6dQqfjq0CyvG43D5f8h2lj3Rhsn8lZgmRBpQwiFTsWY0LQ5Bm9Ybz1fgLhcC6Kd7rVkWpopQh7Z7q+lXh1WaUYsjU/jZqkypizwKt7vVLEFrAcSB2AAX+wg3cJ5t57kDhMQH1wbmFE0mo9J12tH4E7Cm3BD/1eOP8rQEES+UKBw8fgAqlp5KCb5z45YiXiKAKakuVhVlgIiogdVy7W+UwYFEh3CPfE/MTzjYebTfS8ZmkYHq87ayGu+JvbpzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tq0HW8yWGfsTAj1AUMyJGhWa45HMaun/D7Tu7/SM/go=;
 b=e6OaUrLaF2N/taRBo15FXpLx0BMneur/n+UVa41+aLEGeNN49tbvMLSUCyA08qkw16ToUZikP+6LMj7atZ5XI8TuHYGuUeGgYG4RCs77190ZDKL0LQEO7H3LQleeypu83shIO9+GbI22ansrfyGHf4XakvNzQj3DYEY34sUMA+7l+56qqQByz7nY48J0nlsvDd5XtSchS3BUsy+baMa966QmWPNp307kKyhwOhuRF+AOGI2pbLn7y7sD2UTa0Iun2QNXrC+wEJ5eDPhcTAuHYGkcUU0CxfVBLl7gtXZ3ly3y3hkSB0j12Xpo9JOW6hDZ4lr0j8dQOZx4KhhPdh4Lcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tq0HW8yWGfsTAj1AUMyJGhWa45HMaun/D7Tu7/SM/go=;
 b=FVVIYQE6jL/jEsuBPx7KaNRfncMepozXZGaJH6w0VLrLa3X42JYDSCIFS5F83UtMULGtkrkPiJSoGl3atDCky+jvqamxwD6Z1tYG3NNme2ZUITPxTBeuQc8exyfpXbmnT37BichnbLjE0KLrExWIHMhTNj1uHSsisBOaRf+p4WkYfnayH8shijO0yeebpAB/cmb62vrxblo7DhA+cwYjG6C/h249s6I2Wx31dqFsMnphbpo/zmb0sPGXOpRiCZNfhR3Ied01kdm4sP8usGNA0X1J7QgiTBIVRNqnYfSDi8gFiRfO/ABHJ6q2soyLV6EzfWF2mCIVt8LbQN4a/grA1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6524.apcprd06.prod.outlook.com (2603:1096:101:171::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Wed, 12 Jul
 2023 08:14:22 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 08:14:22 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 17/27] thermal/drivers/broadcom: Convert to platform remove callback returning void
Date:   Wed, 12 Jul 2023 16:12:48 +0800
Message-Id: <20230712081258.29254-17-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230712081258.29254-1-frank.li@vivo.com>
References: <20230712081258.29254-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0208.apcprd04.prod.outlook.com
 (2603:1096:4:187::10) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB6524:EE_
X-MS-Office365-Filtering-Correlation-Id: dfe06b0e-7eef-4766-26ad-08db82afff60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QgwLnGrajoAY/UW2PkzMGwcMbt+dMSoKv1X0AijOR7ZvdpvHeGfvm7w8J+EdxJez3PQ0lCDc2FJk90qncuH+f/kqGDcnvm/UnN+5BUC47jndNISnD4+YFvbY0olxL/wsyZv1VG3KyokE8ZVccjX2fI1RnXzU9YcrvlioGllIpHfRsuWwHV/urD9Pon2Ti/rm/P/oZszPoguflJjUKv97BOqP7eg1yWDVoEBoFPbimBwhLYts3AYsgOvFfutNxMSAkU1qI+yAdEJ963uCU2LbpTJN1MWCcIAwl2D7JOQeADHZ0FsfKSKBBDAsq6j3r6AgRDOthWDDq6l7dQpKES9t4Hji0sNC9Bnf3Qlrviu7l+EYH9NQFAvJgq7igV95dPoydBhxcKM50EE1vBXl8J833P2lMRtMAPlp3cRWDcwuWiaex/Eo8+OC2HN+wJ3SoWvEuCp0rCZKe6zV4OcQduh9AYtyBngHYNfZ2q2P1jic649zM6ynRE7stx+PGLuQ7hOcf760X/zLl2+FFnphetttqbcIp4Xx0/aKgCZWUQnjtp3J/tjtLGs53C013ea3oR+SHuKF36F5PAgFcmmcYliOtMpyp4CZLws8C+4b/SAxTfxDveoJtH6Z17kXWnKyAyYG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(451199021)(8676002)(8936002)(5660300002)(186003)(2616005)(83380400001)(6506007)(26005)(86362001)(41300700001)(1076003)(6666004)(6486002)(52116002)(316002)(6512007)(66476007)(36756003)(2906002)(66946007)(66556008)(54906003)(478600001)(110136005)(4326008)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVVXSFhENllIRXM2TWx1UExLc3o2WnJHei9ISzNtZisyekhtYTJCRzQzZlQw?=
 =?utf-8?B?MDlFWHIrTEZQTzVjbEx6RmQvUklubmJlb0EzM1JtcWlkNDVrcW5vZmJQRkMz?=
 =?utf-8?B?eUs5UUNTSDFkN05LNFhyYTZGakE0ak42L0hjcDhBTlhKenhiWUxZdVZoWEZh?=
 =?utf-8?B?Y2ZSemlsTUMvYkViRmh1Qnk0UXNYRUhLSHN0dUw1OExuTUprQlk0UmJ2LzJU?=
 =?utf-8?B?QXMwY1lXN1N3b2NrajhXcGZYZUpTSkY4eitFanMrNlhNRDJhZDFRNTlRdmRR?=
 =?utf-8?B?NjFKUkxnbjBqWW15dENwNEJRYWd3MEFmY0tFMDRCYVJzSmhidHBranpxc1du?=
 =?utf-8?B?WVBxa0JqcnE0dTE3ZjdQenhMaWdlQjJoMHFUeERQcUhrS0xZclgrdy9tVE9K?=
 =?utf-8?B?ZWRoSy9YdGJSQlk3L1dDRlZ3T3J5dENUVDEzV1Q2QnprSjJYZm15V2VIcERO?=
 =?utf-8?B?OGpvZ1EwS2l1TSt5V2dRR3p3MGVjeTR1Z3NhTmdTQXdCcmNBSDJFaTluMjFR?=
 =?utf-8?B?NkFMd3VwWUwzc0Uyckx4YzMvTmh2K0NoMUh2V2hMVkEzQmd6QjZOYVpZN3Fn?=
 =?utf-8?B?MHFyQW1yTGRtbjRvYmwxTUhUemZ6Vzh6SjlsQ2NtcVAzRHg1MjIwV1dobDgw?=
 =?utf-8?B?T09WenQ4akd0eDlSK0cwZG04RVZOcElZdnc0K2E4TFlKMWpvVzVHQWlrR2p2?=
 =?utf-8?B?aHd3SEUzYXRURnBEMm1HelgrRmJCOVdocGpLZDFKRDU1YXE4OVZvYUlBLy81?=
 =?utf-8?B?YTNBOE5tT09BMWlEQnYzSFZSa0ljK2twSVVTc3ptOFo3cFJMQWcxeGhQOHRR?=
 =?utf-8?B?bkdQRE8vZmo1VThYd2haQjdjN2JodkI4NHdQc0loUSt6V3djdEdDR3crRTNz?=
 =?utf-8?B?cHhYS1JzZ0dKYkFJWUk1aHJQdzN6UXBBUkJ0WVdVMDdibWZOZEtKUTZBWE14?=
 =?utf-8?B?UkVxS01TNkE2U2VjMlYyUmoxSWtwTWd5MmJwa1RWZFhFNjJyUHRucDJwQm5u?=
 =?utf-8?B?c2I3TTIyVXY3enpOMHI4UDE4YnFGWU8wMi9jMjg1bk1EcXhDamE1MEk1Z0xk?=
 =?utf-8?B?TUwwQVJsWlFBMU9mTlZ4aXdURnd5SzFEOUpEL1NvSFZYYVVrYnJrS1FPejA2?=
 =?utf-8?B?MmdGcDlVU3d3ZWtIMzQzNjFKN082aHRoeHdDaUdCMFN4RUdmUUFKUStPNm9p?=
 =?utf-8?B?WFlMOVdsM3lJaDZTMHVSc2tEcWo1YnBKcDRHMzVUMWlsUmlXUGR6NnQwTWZm?=
 =?utf-8?B?MzNuSjVoY2JXWmZTUjlGK3RRanNTTzJaYWxZdzh6YkNsdEdYOGtkdnFkbEg3?=
 =?utf-8?B?UDdNeTV6NnlkWUZxa20yb1l0QmJuOUhMZzQweXJoSmNsSVc5QitDTEhrN2Iy?=
 =?utf-8?B?TWwyWXU0UVJzV1VIdWZ1N0dnOVZYVjUzbEFvN2NMaFhhUnF1bUIzU2dsNFd6?=
 =?utf-8?B?clMyMlY4dkZIY21LV01yUUlXeFFUOGU2OG9zWkZSQ3g2QndWdUFwWlVteGsv?=
 =?utf-8?B?bXk1bC9uNFNhWXMvVzZpaHg4SUJCS2FSYWIrQzh6VzVPZE0zMEhVZ0MrSFI0?=
 =?utf-8?B?NlQ4dlFFeUkyQmdmTmVGdUJDdUY2dUV6aDFkMEJPM3FWSWUxdUtwTVNZZlRV?=
 =?utf-8?B?VThSUzhTT3NDRitrVElMLythRkRNdDN4N0R4b2t6S3hOeGJGVG5LVlNwd1hN?=
 =?utf-8?B?OTFrL3F4WnNScXljSjkvTE1lY0xxVk5wQXBmQmdEek1CalpLVWFrMGpaQjBG?=
 =?utf-8?B?OERFd2JMK2M1VHlEUkNpY01COVBTaEkwMEJ5bE5sNENFTllTWmtBSWFqOFVE?=
 =?utf-8?B?VVk3Ly8vRitYVURpQWFRTmFzNmpsZzlkS2g3ejBsaXBRdGt5ajBDbk9PdnUv?=
 =?utf-8?B?WUc1VFpBVkMwM01GQUVmS1ZZajdVSWhKRjBaTFFaYzFCQUczeGNtUXlPUkRL?=
 =?utf-8?B?dEptT3B1WGlCSVd2T01XdnFMcFFVZjNwU0owVDcyWU0xTmZXSzlKR2I5dklw?=
 =?utf-8?B?dnpuNVBSNWxxN2NnNVpCK2J0YUg0VDdMS1JDSng2V0xjU2d0L0RKYy9pTEd5?=
 =?utf-8?B?enNkaW9NT05rZmE1cUFkTHp3ZGtOeWlBZXZTK0RLMzQrZEtEVStndnhDaTJE?=
 =?utf-8?Q?6XUj/uG5vJwok+tbpYQla2ARs?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfe06b0e-7eef-4766-26ad-08db82afff60
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 08:14:22.0092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4I8b9lLPU/TWt2/2XlGP+0G2Ktv4fC0Egwbiomm8WJwbP4cYoLjN9NUA8+pzqry0g9m64VerKzDlW+TxYwxOlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6524
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void. In the first step of this
quest all drivers are converted to .remove_new() which already returns
void.

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/thermal/broadcom/ns-thermal.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/broadcom/ns-thermal.c b/drivers/thermal/broadcom/ns-thermal.c
index d255aa879fc0..5eaf79c490f0 100644
--- a/drivers/thermal/broadcom/ns-thermal.c
+++ b/drivers/thermal/broadcom/ns-thermal.c
@@ -65,13 +65,11 @@ static int ns_thermal_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int ns_thermal_remove(struct platform_device *pdev)
+static void ns_thermal_remove(struct platform_device *pdev)
 {
 	void __iomem *pvtmon = platform_get_drvdata(pdev);
 
 	iounmap(pvtmon);
-
-	return 0;
 }
 
 static const struct of_device_id ns_thermal_of_match[] = {
@@ -82,7 +80,7 @@ MODULE_DEVICE_TABLE(of, ns_thermal_of_match);
 
 static struct platform_driver ns_thermal_driver = {
 	.probe		= ns_thermal_probe,
-	.remove		= ns_thermal_remove,
+	.remove_new	= ns_thermal_remove,
 	.driver = {
 		.name = "ns-thermal",
 		.of_match_table = ns_thermal_of_match,
-- 
2.39.0

