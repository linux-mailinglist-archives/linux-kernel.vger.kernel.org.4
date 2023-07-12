Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B65750336
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbjGLJd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbjGLJdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:33:46 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2131.outbound.protection.outlook.com [40.107.117.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B940F19B;
        Wed, 12 Jul 2023 02:33:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBE9Qk7YJGs1OBR/0XBBh1Cg7wRhiu2juLH3Mz55PgDo3FCLPkhh4DKpNUwHts1ejLbzsBt4U46ajWfec0Pol4PloWNS9ZoYahtu65xt9jCh2zaO0n9eki0H8ttUOmzyE9hu5heuHACOhrgmfi2EOJU8G2lNzXcDzZ+oXey/bdc5+IEPhsZ4kdelloso7ErUR7zowgEibiSr2b+udJlF+v6ZUs5BbYvT+5Tcqk3N0SKhlC3jDrGCQ3LE9v8eKZ6e7CiPPinWWoUDnlW2A0zDasGn149dSbeXPbTd2ABxklhVUV/6xp+tsg05uBkPbPLo2ZIumcQFB11R+7OgY+cx1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c89Uk5+QEiVyGy9EW+mO0csGCw2tVCASv9GKv0BtYaw=;
 b=GZ9njliHIQPf2BpZ3CYCAjGsk098ggsyiL7JkzdcNypCPiGtJXS9eU5MheZux1Pl5lH0h8J2iN9IcBYJCHFl835spi4SvlPRCXqNcuZvnf0xUqvmLSPWryvsma78HQAaZKtpF6bNRQPq5Iq6VRn9VmzDVb69gzQLUeq6Uxd5mNGyRgssvs3K4QbYpNNHtRsKEmWLt38pP3lLaATnSJTVezcgSz3nf2TUpnch2W9aFcLlTwqkcAorC8seMQUZFkEkhqhOeZ/MXJXHMlJ+DV38sHKEPiHyHCiT8Bcc5wuvFfqLxT7gC9BamrTVIn+hMKd1wVZ6fcpmaGzEWXLSWn0jWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c89Uk5+QEiVyGy9EW+mO0csGCw2tVCASv9GKv0BtYaw=;
 b=Tqt6qNhDZrbvGQcgOS2g7l20yU5DZhr8gklDzJyu2WYxEoS7f7PAZAV7l1lalPSL98J3Tv5uv/f0xPmdh9Z9WCvQOdJlAOzYaCc1jWUdFrtiJ7IB/P/ErYI7/0GpEuSUBK7s87Tvf/PGw+td3Ap5DalXY6x2abxCOfFP8hdktnMCvpg/gKJty2MbNgwpcokmQDlMWkb20AqIfqB4Q22Jw+9caA+KCZMiaYhAEsxL2mLwBJFlEo3C+aM4rXSXr4e9daUTotjxW+g5mn3OVipqpeEkXH89QxzC2564gDcS8TQeEAlEPxQh30jLCg7wLofUHbPCvc/Px8L2r/gxTKKn8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5985.apcprd06.prod.outlook.com (2603:1096:101:de::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 09:33:40 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 09:33:40 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 04/19] cpufreq: vexpress: Convert to platform remove callback returning void
Date:   Wed, 12 Jul 2023 17:33:07 +0800
Message-Id: <20230712093322.37322-4-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230712093322.37322-1-frank.li@vivo.com>
References: <20230712093322.37322-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0172.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::28) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB5985:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a9f5f7d-838d-4fd5-e39b-08db82bb1360
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WL71Abv15elZ7rOB1HiyIKWzdKUIQ0hT1Dlv47eHSvdhQ/2i8vYM1LR1W5Iab8VKzrVtvy95L3MazEwUOMa7ngp4pFlmzNwQVBh7GeGLtk0eZ060vILRaUFMFl7/Ru3YIXNyhRBdDUdhm/0apu7P0Dyt1GQ3KFlywcPvYLCbOpqYRvYVVeZA4wojdWzemGa3DudW3SfMHAsnsqSKl7HScHJ/7TkDmi14hDD0vVGFqHOWo/k+I7VpkegkT1bXGyccM7CSIa6Vmcmh7uz1M/S42mGNKhj5+POT17r+4sU5PiI1Dw/qG02fgh7VcmIHZbZ9q9D4TMLoc/rnYOsKrwx3MfA2Xb9EDMZR+/xYcd1FC27y4qYMhCNSAWgQM7eW3BVsF7gCGXdCntGQH9QxSAy0wdOGxqJs/SXvZ07KnfQvMChIPE3bIfjH8BmK4Ql89B6sC664mXXwXsgsAPUm+JfE+wbcgU5bsu2dLYf4pPkc/78CMs3onvDaLtOOfG6phDEpX+sUo18L3ESeACpnjQBu0pUUKKyCE9kgiz0wy0zkpqdbwqn3OTJ4Po1g7VCsJ40SWdMepF/kVjYCdJkh7XWdefe33WJoqsBj16qejkuWGRduZEUsUa7mWe91u7DdWJ+1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199021)(186003)(2616005)(110136005)(54906003)(38350700002)(38100700002)(5660300002)(8936002)(52116002)(6666004)(6486002)(86362001)(8676002)(478600001)(316002)(41300700001)(2906002)(4326008)(66476007)(66556008)(66946007)(6506007)(83380400001)(26005)(1076003)(6512007)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXNJU1Rlb0ZabFp5dXk2OFlzaHdZVmgzK3BKKzZRbmkyNzdOQ291TElzNWRX?=
 =?utf-8?B?dUJVVmszTFp5bUtnTGpMbVN1Mmkza09EL0JhcDU1VG9lbkNITGRHVDVEZHBt?=
 =?utf-8?B?eWx4WllJc0lJbFo0L29HcXBxa2JNVkZFcFp5SVRkVDA3eEU0b3BtbC83S2pz?=
 =?utf-8?B?VDc1MnlRaDRHT2Z0cUJvNTBydWQ5R2pyL0cwTGJWNWw2cFJYVExRSGU1em8y?=
 =?utf-8?B?WVo3enZ1RTJyNzZ5bmppZFhyRWVPZDBjY0pYY1N5MmNMNGgza3crSmMvOG05?=
 =?utf-8?B?NmZ0dFQ0bDNJOWRRMER5QzBBYXh2UlNnUHh4ZzVpU2RuN1RkaWUwTW9tMkh6?=
 =?utf-8?B?WC8xTFBqZkZqMFRJMHRwelppUlVxTGdGUFcydWJMY3NKVjQweUlzZ0wwcUQv?=
 =?utf-8?B?cUdOdEZiOS9sTnh2L2FhVkl0c1llUVAva0dJNmd5NXBiQVZKUnZiQ0lEalVB?=
 =?utf-8?B?ek1zZjBUMjJxaSswbzhIdkFjOWRETXNpa2k3Q0ZwWFk5MDVzQnYybTIzUkFZ?=
 =?utf-8?B?ZFE2ZC91bTNNODM2S3Q2WTNmU2kvTHdOWm9abDh3bDFCSjgzbnNESUZMQlI3?=
 =?utf-8?B?K2ttRmhxalllbWRScG9mQjlaejl2emo1YVpYSkMzaUUyUmY2Vk5HQWRJSW5Y?=
 =?utf-8?B?dHE1NGlZdmo4a0RrMGJwLzBobHJYNml4eEFGd0JEMGNGRytBV3dUNmI0S08x?=
 =?utf-8?B?Z0RxNjdLR08wMEQ2cXBzVkJDUUJoZXB1dURYd3k0L01NbmFCYmEwSkhtb1N1?=
 =?utf-8?B?aUJtWjBWWkhicnBGQXhNbDhMS2hMT2F0amlHeEpEcFpmRTZSMmVVTUY5VS9a?=
 =?utf-8?B?ZmYyYzdRQlkzK1J6ZTl6eWxENER4Q2Vkek9uaGsvRlZORXlGOFQ2eHdUTGhq?=
 =?utf-8?B?ZXZlMTgyTmZMaFBiVjdMWnU5czFvRGY0TFBwUUl0VFhLRk5SOWtDODF3Ly9a?=
 =?utf-8?B?cW5uWndmMnViVStENFZNampPWVNZNnJXajArdUZSVHlCMnNyUEJONHZaVXdQ?=
 =?utf-8?B?aTBETzZuSy9uNnZxNE4wcnJ1aFRhK09aT0hRZEYzTHlmcmFYVG1sWFhXOHVs?=
 =?utf-8?B?SUpFVEE4MGtBMjl2cWh4WlZXK0I0SkdmTnBHMGVvMnhORlhFcjNGU0ZXUWNL?=
 =?utf-8?B?eHhpSStDQ0Zyd3ZpUmtUaURZNDlUT0tXUVk1YlVpdkJMM3o0djU0OWozUW9P?=
 =?utf-8?B?TU0veE5nRVhaN1dvYzBLbGYzOTBRZmkySlVBdmpEVzE3TWJxMXJOOVpHSnEx?=
 =?utf-8?B?TmVhd1lrM0tWRWJURG9GWkhHaldpbnkyT2lhTnhmc1BNL2dGZmxjMlVqVXlZ?=
 =?utf-8?B?azZwREJWRUg4NG0wS1NvN2dBeDUyeGZPaE92MGE0UHZmZDVqUWwwUDdUcldR?=
 =?utf-8?B?Zy9raW40L2ZOb2VHVVdoTHVVMG00TmRLTDhRbjBjT0JkeTJoVUp5MzMxcDRH?=
 =?utf-8?B?T2tJdjdJVHZ2eno0aDcwZW1KWFk5M29JS1lhaWhCUDJpaWUvdk5LcUVUbktC?=
 =?utf-8?B?T1pUWVFGb1YwMlR4MnZ3OFJJZU1RQk1ZOFRRbm9pdW5MZ0tDdkdvS1lWS2kr?=
 =?utf-8?B?bUVqa2cvNWJsdTFBSDZ6R1hlemtoUHN5citGR1YwZkpmeGR4UFN4RnBoT1J5?=
 =?utf-8?B?UU5LUVhFLzdJTWxHV1BEbHBHNXQyd0hqNnhiVEMrZWpzQlpRdkVpTFlHZ2l1?=
 =?utf-8?B?UU50L2lTRmE1RUdiaWgyUVYxZjg0eUcvL3l2Y2p4OGl1Y09zcXJId0tDSFVQ?=
 =?utf-8?B?WjRoYnhxbURKTXlQTzI2aWtWYzRmVnlqakxiRjNDcmJDeEdac21keFhGNmxj?=
 =?utf-8?B?bUs2ODNVd09rWkt5NFVFa3RKM056WHdrYjNlSDF4UGJVWllCc2pSQ2xlaXRq?=
 =?utf-8?B?ZnZEN2x2VEN2bzZMTmNNOEN1dVBGTE5nZk5JMDl3Q2NRTnZBejl4dytPSVRY?=
 =?utf-8?B?VUdJZ3JOUm0xNzFhRDEza3RuVXJZQ05BVFR5Q2NtL3hUdHpLUzhKQmU4UDI2?=
 =?utf-8?B?RHp1OUowY0M0RnlwUXRnb3dqcVY1WGN1VjFZZWpiM2VTVWxDMWI3WkpOODdZ?=
 =?utf-8?B?RXhFSkNZRm9hR3Nsekc0RURHMmdFTXlhMTB2Z0ZtRXYwMkZFUkREenViVFoy?=
 =?utf-8?Q?hWN5XObzVI6pv98lsl8mWY3KR?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a9f5f7d-838d-4fd5-e39b-08db82bb1360
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 09:33:40.0136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0KuF0DSw0+Ljcr5YsJdZLpGUfVO8+quGHITZCssUCZ0KdqIz+3PL45vEwFtE990v3gMx3xZbqNmiZKJOKWu5SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5985
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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
 drivers/cpufreq/vexpress-spc-cpufreq.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/vexpress-spc-cpufreq.c b/drivers/cpufreq/vexpress-spc-cpufreq.c
index d295f405c4bb..cf33e01dfda6 100644
--- a/drivers/cpufreq/vexpress-spc-cpufreq.c
+++ b/drivers/cpufreq/vexpress-spc-cpufreq.c
@@ -552,7 +552,7 @@ static int ve_spc_cpufreq_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int ve_spc_cpufreq_remove(struct platform_device *pdev)
+static void ve_spc_cpufreq_remove(struct platform_device *pdev)
 {
 	bL_switcher_get_enabled();
 	__bLs_unregister_notifier();
@@ -560,7 +560,6 @@ static int ve_spc_cpufreq_remove(struct platform_device *pdev)
 	bL_switcher_put_enabled();
 	pr_info("%s: Un-registered platform driver: %s\n", __func__,
 		ve_spc_cpufreq_driver.name);
-	return 0;
 }
 
 static struct platform_driver ve_spc_cpufreq_platdrv = {
@@ -568,7 +567,7 @@ static struct platform_driver ve_spc_cpufreq_platdrv = {
 		.name	= "vexpress-spc-cpufreq",
 	},
 	.probe		= ve_spc_cpufreq_probe,
-	.remove		= ve_spc_cpufreq_remove,
+	.remove_new	= ve_spc_cpufreq_remove,
 };
 module_platform_driver(ve_spc_cpufreq_platdrv);
 
-- 
2.39.0

