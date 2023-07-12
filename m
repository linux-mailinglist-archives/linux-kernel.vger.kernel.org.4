Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E16775032C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbjGLJdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbjGLJdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:33:43 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2131.outbound.protection.outlook.com [40.107.117.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6961A8;
        Wed, 12 Jul 2023 02:33:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMaDwF6zuBpo4jRJhBwbCFCTOfsai/v+FF7rAIBemdBxhIuxSNIQx6JNbg7fZj+NRJyO31uwc6+130jFcMypgORESvLVzcdiaI34NMNll958BOHly7jC+xXNavliVA3JsaMYzj2ynjmdRzo6TS9Dku1KQNAi97iOCEypMWH5Uh34GBc1+lKTC5l0DBYOzmGy6tnGFtOqQYLkm1t4LtfOKs+D5D/MXYs30ZjGEQROTnFblr5owGMfsvqJDgY+1GMMZLcBFUdXGJ+A7j47aj/e5WfmvsomIh9/jxS1L2R6KZohdDJheOHeANdzQu5Moso1LDSB9W/3N8SOWMH2t5SjPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ak98kmAGr6XZnzVxmln7NE4l/h9RPLwOijqtez/4hDE=;
 b=ORHWNk3gY+dJULB5K5ueL7x6uQ3dlkvTX/rfZ0OGkRnfjUeXn5Yu//3cq6W3B838qJgsPxwbzfuW9SwOpz26yOqsmPyp+D1WJ172T0V2VTeXnKTTJJqOvD8nTH9Y+rc4iSeT9KwPZdarSEyk9BkgnDDzwg6On1fWPZkkCvxXUzz418wTPKgbLTJmqncHVLJ+FActxFPBwT+tJiOCTTI7LKfkLfstH5Ur4Mk8xTDOTOTPPaRkV61IxNpohCtbCm0QLrY79Idlz3sB3KUQgogP7FZyt27EW8jASAuyLaUxdu7vO78j530kTr2LMtPl/vlPcubgc/p8CdZqeTIONSS8sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ak98kmAGr6XZnzVxmln7NE4l/h9RPLwOijqtez/4hDE=;
 b=OuHa5+FwZcMfO2PYKvZNYlqdT2G2JQt6y/cFFD6B7XMwh4vVnymNa3oGYBMijACz3R9BNYHHYn3DbThsKF8/HLGTdUwMu6m9ViXCQguxCemUZJudWQ3xzNCyuS8KcHzGwjFdqtl8s+dDXEZWJEl5Tbgj1OOfNJ2j90ekr81xP9Vm/UgQ2IO8L5r96FsqDzmAXAS91MfKuTHvxmMOVgvPb0E/fn4HHe4/LDiKhf/wo6+2cdpc/D1yZrVI8lsf4IxaSjZHMvcHKCfKTxi/ap1XzVmy9vbbFcvVLsOO2o75NQJlM26AhhOVjJk5eSyL/eXL2S56pcQ16vHau0I9d2C/UQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5985.apcprd06.prod.outlook.com (2603:1096:101:de::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 09:33:36 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 09:33:36 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/19] cpufreq: dt: Convert to platform remove callback returning void
Date:   Wed, 12 Jul 2023 17:33:05 +0800
Message-Id: <20230712093322.37322-2-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 79aff72f-4776-4fb8-0300-08db82bb1120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9GMveKNTE9I2XSG5SDWGjIWWwmyPm0Ha7HE0YKudvOPc/N8Ob45xtrTL0xOuwmsrQnY/mzVeI1RScuXfuxha1xTKRmKJ/vKvDt38sXNOwb4KMeZwjdOkTIqYVhZZ0io7ekqJzvE+nZMX/M4g+khbjcxh6Fw+rwJzaTPdJzkeNPYM/7bdY7NXofVoigr2744bvsENuNGJD6uCfFdYCZB7wbDAtbA2zyKMoAj8HmhsG3vPgNO+jf+sjwHIwzNqXGft4a0qhLGHR7Hyv+UztREaStOZN0fcywDD1hal16myvb9RExaz5sVom7aiaS5uikolQVrOnjyG+KprQPmi+/YeSySyntw/vFA3rdrjIdfRrkeJ3ohpy69uocr8fNeeQzvy/OJO/j/1SRG5t4oCWCGp6qLNSz7NzFOJjNX8lREuwLnzrxaQaxa4mRFBjwemyb7l+OLuNJ6kXEqfP0Wq6ECSxMQI86M/0Bq9a++QFOXN2Gsjc0+9d9T+PYbB+lacGIMEhiRA2iqyzWF/bvcFrr431ifbnJl1+P12SNiHgR0I34LNGFnm6g8wQUrU7VZTULsxeb42NoDbEVn/rk/jnieS4CRauM32/QDZAbApPi1kVDhCB6CAg9K+W8OyD5JN/Eh/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199021)(186003)(2616005)(110136005)(54906003)(38350700002)(38100700002)(5660300002)(8936002)(52116002)(6666004)(6486002)(86362001)(8676002)(478600001)(316002)(41300700001)(2906002)(4326008)(66476007)(66556008)(66946007)(6506007)(83380400001)(26005)(1076003)(6512007)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVZzNmFtbVpLWGJkUDdFOWd3ZmdnbS9kdUU0MDJzVkpKaFlWbXF2cWcwZjFS?=
 =?utf-8?B?L3FtL0VOUU50bnUvSG5EY2VRTlV1a0gwNjhYTzZ0RWs2akNnc3JVbHk3T2Vq?=
 =?utf-8?B?dnBleVp5OFJRa3BkNHd2Vk14cUtRV3YvQkYvSmhiQWVJMlJyb2UySVhqM2Ur?=
 =?utf-8?B?Q2NCNEZITllIQUo0M1R6TDBIQTJEOHdnWjA5SlFwUURVTjZQV05acmV4a0Ir?=
 =?utf-8?B?ajNuVUpBN3hLbTNIUlYyQUZGeWhtaVphMktvaDZ1YzlwbXEzZzAvQmhUOUNB?=
 =?utf-8?B?UUxFR3pmaU9KY0xJdVh0c1N2aE9RSDFyTXd5djFUZ1RHc3dST0daM29UR3A4?=
 =?utf-8?B?Q1Z5MGVRRi9lb2trcUI2UDcxM1EzQjB2bWxLSzNKcUpCZm9WaVQ4VW93Q0hI?=
 =?utf-8?B?bjdzOWVTRmRvWTB3UUZucTVpUzlIV2swa2pDUk5iTkU1cGhGSCt6dERCd0w0?=
 =?utf-8?B?cmVyS1pXWHk3V1ZuQ1VxLzVVZjUvWE5jRjRTUDV6NXpWRHo2ajVaVTBabFhH?=
 =?utf-8?B?a2NpMmttRWlsN2xxWHhISXBFYmZLWXFWbW5mZS9mLy82RDhIa2xlV0VKakU2?=
 =?utf-8?B?MTFFWXdwYmpRSVlFNlhJRThBR1hLRDRpcG8vWkxIZ3FBR3lOOXV1K3pqNEIv?=
 =?utf-8?B?SHc2L1J4d2hJblBSTDhqb0R5V0Vub2FQbjYrVTQwWXVLS3hqcElDUmM2OGVH?=
 =?utf-8?B?Mk55VWZvcDRrTUs5cmY3aU1JY0psdGpiSURjc0ZlKzRlN2k1azNKSWZkWVJK?=
 =?utf-8?B?Q1pZYnNWMFJXWVlibC9aems0b0dMK1ZmcjEwWFBJSEQ4MVpMTjhObFAxNGZr?=
 =?utf-8?B?dThHdDV3S2ZMWks5bHF3TTEzNktRNzA4MzF0NGQyQWluUmpZblJJdzBMa2tJ?=
 =?utf-8?B?ang0dU1ldnl3eEVoald1bHM5NkZTaUhjd3NDUjJzbWZ1cWNuNzFHTWNMYm1O?=
 =?utf-8?B?Q0JJWFlxTXNRdktkTnRKVktLbWtoMXNLS2dGWHVwV1BtQmdoTHF2em5hVVpM?=
 =?utf-8?B?K3RoN0txZGVOaVFJNUhIQXpiWGJRTWtCVEJVZHNJYkVvbmFXd2VNaituT0dW?=
 =?utf-8?B?V0srK3FpTTdTOEo2TDBtMlM4OVJFUHZydm5acis4ckN6S1FKenR4K0NoNlN0?=
 =?utf-8?B?b1pqNHhvZVFlWHVnc1ZJVFJyOXVzN3g1S1o1RXlQOUkyN1hOc0hZcHlGNTVI?=
 =?utf-8?B?R3dFN2ljelYwTzlwTjMxR0x4VzRhRDE5NmlWNGxIU1BNaGpBczJpV3B2dXpY?=
 =?utf-8?B?MEN2QmtQV2hJMTA4SU9oVjU3MTdhNjhFUnhwbG1nNGdYVjk3dU0zY2t5VWE5?=
 =?utf-8?B?UE1NWitlSUtNUkdidnJNRlZ0ZkZsV3YyL2l0bFZldjZrSDQ4MUhkL2hrSzZz?=
 =?utf-8?B?VzQ2cDl2eG92SFBJNnk0Q3NtK0t5U09pTU44YjBXYWJVcUs0cHFJa0RkaG5R?=
 =?utf-8?B?YmpwVk9nZXV2bFA3MGpWdllxVUF5a3E3SkpudEhXSFE1NzAxbllZbHRxSFZv?=
 =?utf-8?B?UUVkN21CV1RGd2NTbXdHeHNUbFNZRmlOSnZGZStMSEIxcHlLdTk5eVlZZzNN?=
 =?utf-8?B?U1Nsb1doZkwvYVZpU2JZL3ZKWmdHU09vZnI5ZWFTZTZyelROclFkSmZ6bTh6?=
 =?utf-8?B?NTBzVmd1UnlWSDVpQkxnVGNhZ0tQeUhyMnlWZ3ZvRE1WK1Jzc08wWWRrVjNO?=
 =?utf-8?B?WHhjd0F5bTlTSFZLTlZiTHlLU2RXRitaR1BteVVGZ01kL2dwZWNTamdydElL?=
 =?utf-8?B?V01ub21zeXpiSFRudER3YUtJeUd4azNZQ0JTY3U5NUR5ZWlKOXBNenlmcTBu?=
 =?utf-8?B?VDdWaEpWNG4wRzlEV2xnV2g4ZmtjWnU2aXNtdnlWM3l0TXU5eGJXcWVaVWky?=
 =?utf-8?B?ckFSTTlyaFdqYUk1clR3RWpKVE43VGR1QUwwbFE3NjBVaEVDelZEbU1kNDNw?=
 =?utf-8?B?b2NxWVlPbHhKRHQveFIrOXEzM1hsZXZDSVM1Mi9SQ1g3M0thTDhQSE5WR1Bu?=
 =?utf-8?B?elhxdktMSk1ab3BpZ2xOZldhN1BLMkFsY2ZONEhsQjFzR1BuTFlPNFo1RzZU?=
 =?utf-8?B?Q1BXVVBUc0ZMTWpXL2xIOXZIRGQ1dlg3cFFONVlZRzN6YWNNcGh3OGN3MFZY?=
 =?utf-8?Q?1oWeYZ9S/4LnbOZ9t15QRKjsA?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79aff72f-4776-4fb8-0300-08db82bb1120
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 09:33:36.2379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mRkz4CFqBRwWhl8LhznczDLMg4WQ2t5X6TDl07+nPejFDqHBThqVsecG/7RBKzBVGbCjhcchsSiv8QEIio6xjw==
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
 drivers/cpufreq/cpufreq-dt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 4aec4b2a5225..8bd6e5e8f121 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -349,11 +349,10 @@ static int dt_cpufreq_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int dt_cpufreq_remove(struct platform_device *pdev)
+static void dt_cpufreq_remove(struct platform_device *pdev)
 {
 	cpufreq_unregister_driver(&dt_cpufreq_driver);
 	dt_cpufreq_release();
-	return 0;
 }
 
 static struct platform_driver dt_cpufreq_platdrv = {
@@ -361,7 +360,7 @@ static struct platform_driver dt_cpufreq_platdrv = {
 		.name	= "cpufreq-dt",
 	},
 	.probe		= dt_cpufreq_probe,
-	.remove		= dt_cpufreq_remove,
+	.remove_new	= dt_cpufreq_remove,
 };
 module_platform_driver(dt_cpufreq_platdrv);
 
-- 
2.39.0

