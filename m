Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A32E72BAAD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbjFLIam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbjFLI3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:29:51 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2049.outbound.protection.outlook.com [40.107.6.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A99910F4;
        Mon, 12 Jun 2023 01:29:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihwqeKk3GchlKKxnl+jiHLmKF/YHbpkeZcqkKH3o1J7Z58Na1jNkFaJtakD/B+x0glwXCFDvATsXAfp7vNYq7lbgIIMrQKzK31NSqQvemL3HcWmFz5d4M1PRm/yxZELiIhMf56W91X8haysnWEGBezawnB2NBuv/FpKOfzF2xw0zQ+hkQp05Y1bh5ePgiwTpTeZgN8Ll5xUQgteUGgOt2IPNdQ5OHZkLVmwSaQswmOFKWz+Ipo2R7nZ168gBAnsakF0KXjqPcr8KQG0Y9Y2lwJbdkm44rQ5ISaEc4pjiMxVzS9Cs+MS+ALXoel+KWTcUciCS+CdHtGQR1BWnhOdfzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZT20YquAVRG743V/0VbcgjKU/PYU914WrSUYqYN9gNY=;
 b=m18vAYcGb6u/6pS1EAOHOvrYdZTAmkHMUA3EP83UP5PAPoGRkZZ9dUEDetcdkETXSK+xIx/qQJkkWxgq0v7+17FcZh/Du+SGQ78AoySpvNXndZeqsGtfQ5hSfDVC9bP0LcFHliRbsVTmpZJTMgJNtwseKAtkhPAKTOBPBVm6zwdAUoLO4C/LdseRvmZlHxM7FbW6CIiQzz1nvcn5mnFwUO5fFYijr00yA4vFdeAQvVZ9yraBAm1rz2HZTuS9d16A2ALmuDlTeqpDB2V6yebiYhCB9GqoGUsUwVk5HZswV2AL9u1xs/X37t7OTzk48Z9qp8Ac2Fe5RTEXnKN6f+1ZXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZT20YquAVRG743V/0VbcgjKU/PYU914WrSUYqYN9gNY=;
 b=pk2LQj8AyimR0LObYTF7O4y/QFeJnoN48xtx3Ih/y3pvG62F8MSpsH7pQlNPzTwvHzaj315DF7Bg6/zzmozgxzNOLXz5uqRli6TALz/OH3Z7ZQnOMWlC14VljcJ1VlIq3DL7MNryyCqEVCl6NP7d6MDbjMLREJA1lo6lHcjv3D8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com (2603:10a6:10:314::7)
 by AS5PR04MB9971.eurprd04.prod.outlook.com (2603:10a6:20b:67f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Mon, 12 Jun
 2023 08:29:03 +0000
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::adc3:90c7:4b37:392c]) by DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::adc3:90c7:4b37:392c%5]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 08:29:03 +0000
From:   meenakshi.aggarwal@nxp.com
To:     horia.geanta@nxp.com, V.sethi@nxp.com, pankaj.gupta@nxp.com,
        gaurav.jain@nxp.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Victoria Milhoan (b42089)" <vicki.milhoan@freescale.com>,
        Dan Douglass <dan.douglass@nxp.com>,
        Vipul Kumar <vipul_kumar@mentor.com>,
        Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Subject: [PATCH] crypto: caam - add a test for the RNG
Date:   Mon, 12 Jun 2023 10:28:42 +0200
Message-Id: <20230612082842.1256507-1-meenakshi.aggarwal@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0115.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::20) To DU0PR04MB9563.eurprd04.prod.outlook.com
 (2603:10a6:10:314::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9563:EE_|AS5PR04MB9971:EE_
X-MS-Office365-Filtering-Correlation-Id: 3991e881-7de8-45b6-6f3b-08db6b1f1410
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ow2tlIGw0Okq+Ci3ywcx18PX7w6yJhnmL281wglw5KZb6yOjTCqYk+iXlXmn6c+wQHQMLNbR3V13uQ9wwdJmNfEERTt5C4MBfDILcGFICtNLzlyJdpFbPuyIH+utB9BoPMmIGI2B59DQGAqKiO0/4E2taZlOEw2doRc+dx9fhdLioiZZbhVmN3fXg1kPwZXFuz+TdPTDlcTuJdXvR/5N8kfO3TdsrxCy7fsDayKikCRXKaoAHI9ewfgEuVfKe2zsSpXMPuTciMMl4+TKPIeSz8KgEp6LnwKuqq1tM7988vQaUK/0bcFXlk+85IAr7bcEL0H+6jzQulhrZNYPQ8f1OCEwU/atyjxaA5fr9K3N3R9DfqJzDlkGvhKAydWHpa/Li+sk/6AKquU/K+LjTaUq/MEJiSEpJgeCZsk3+KmrKvOf2E3AsMQ5a6dGDUolWdrQ0Z4Y6GRmvmzE/u5ZIpdhGFdt6Nxsl/fOKKsLQSeEVJP6HfjSSb+4Cid0Rl+J7UEMFM5DEWYtryohXSHfnJcqWYdly7w47dKQiy2pS0IBrNsWTo/t+mAV1oLEbPcQMLjxLNkR24+Mup1HNz9O6/pEv0UhFi8o3DYQgvULF8UA0tGMaKi7TnlxgZBC/K1Q8XzQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9563.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(451199021)(9686003)(26005)(6506007)(6512007)(1076003)(2616005)(83380400001)(36756003)(86362001)(38100700002)(38350700002)(186003)(54906003)(478600001)(5660300002)(2906002)(41300700001)(66946007)(8936002)(8676002)(66556008)(66476007)(4326008)(52116002)(6486002)(6666004)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmNVYWtkQVhaWXBzTnAySEE1UmVXWEtPejNJR1I4dVlyc0ZHQ2F3NGJ4Zlhy?=
 =?utf-8?B?ekdRcnpaeXM3eGd1S0x4ZHM2TmttVU45ajJZTFZ2RjFVdExSTmgzRitZNWZm?=
 =?utf-8?B?czQxOWFhQmNIdEI0RmF6cXVmcTBMUTArbkJnTjgzVHhMdTlrSVlublZ2VHRY?=
 =?utf-8?B?ejZkRWVzdGgvT0NuRHJIYytyRG9Yd2QvYnpVK1ZVS1AyODk2d1NYK1hnVU5n?=
 =?utf-8?B?TDByNjlOWmtUL25wTGluQ1BtMTc0QWdML3Iwak1QNGh3OGxCNkJNcC82a1pz?=
 =?utf-8?B?VlVzcnBmNG82L25CTW8xQU05UXZMOTZPRTloSUZkQytFdXY2d3ZGbzViYXdM?=
 =?utf-8?B?TC91RVBOU1Badm1YUTFYMUh6aEpiV01TdlJSeERzREhvbEFqYkhYLzhCL1Ju?=
 =?utf-8?B?UXFia1JLU1cySkdIbU0yeWFxMWZmNjcxNjJ0Vk1oNTNZSWhnS0ozMG53ZHdv?=
 =?utf-8?B?OElDNTV3cGF4ZDBHMDlIU3AyWnFpNjQ1Sjllc1JoSFpJQ2l6anF0WW5hSUF2?=
 =?utf-8?B?RFVuMTJCM2tyVEN4TGNQUDdGb1Myb1JNVFB4RVhrK09WZGxNVktqVldHYkth?=
 =?utf-8?B?WjdiVkxrU0ZLajFLVDdCREZWbWZvNjZST1FSYkd6WWFBL2JNNHZ0eWJOQmJ2?=
 =?utf-8?B?VE40TmU5VEN4MUpZR05FT3pjd2RMOExlaEpURVBrdTVxellKeTBWVjlkQ3VY?=
 =?utf-8?B?ZzNwVW9JbUV5czRaaW05bGQvRTRrNUdRUUdETTU2dVluOU81azViaUNYS0w1?=
 =?utf-8?B?eGV4NkJicHhqMVdxTEVpM1JjTjI5Q0QzTmxOTWtGcVZ2MExuSmVoT1BQM1VD?=
 =?utf-8?B?b3V1VUd2ekcwMEJKeFN0cmd6cUlRVG9XM2NJelFYNWlESjBUOUpTTHJmOVhs?=
 =?utf-8?B?UWpOSmlFbFBWRkIyYVJPTWVpeXd0dER6OXlIYnRWL0h1TUQxQVlLbXBnUFF0?=
 =?utf-8?B?Vk5QOWIxNDRxbGRGaWFwMTVOQTB6b0l2VWgxYy96S0pyMW5tR3YxRDFsSHNt?=
 =?utf-8?B?SjhpdEd5YjIyR1dadU90SE1KakE2SXpZajJhVmlXMkovV0FLNXl2N0NJOWxU?=
 =?utf-8?B?S0Z4aVVxTVdUSFNGQnNhaWFSMHhuckN0NW5rNzRUNmR1WVdMZndidGxFQUlQ?=
 =?utf-8?B?clVpQ1J0T20wNzZtZ2xKQ3VyWm13dTljem5sSHpHR1hBajRWeEhCTlkyYjBp?=
 =?utf-8?B?WkJVemhGTlo4SmQrZ0syTkJHSWhENWJIWmlMKzg2clYxTlNremphNERnMEpk?=
 =?utf-8?B?T2ZJVG5GUW9uY1p4YkNDZ0pIZmh0dEd0ZkczcW1GUDY3MGxGWmIrVlkrMEZp?=
 =?utf-8?B?SEwzZGdzS2xyRytLQXdGM1JCcHNBVVRTYWo3V01MZEk5cFVVQzFsVXVxdHRG?=
 =?utf-8?B?Z1p2V2Y1eHhELzVVa01tdUxNbzA3bjJWdElwZW9ybDN2cUF5S0tXQ0p4cmZH?=
 =?utf-8?B?WEVoekozWE5kZXlZcE81SUZzaS9pV0JtT3E1aWhOVW1acEtkbzNSeVVsSGRm?=
 =?utf-8?B?ZWJLRWtZM0xUZnU3Q1J5V3ZydTg2OGwzZFdxalM3dUdLcHI2eFFtWUFGcDJO?=
 =?utf-8?B?dGFFZkx5dURVU0lyRGdjdGxIaHl0UXN2a0FKSUp1am1tY2FENkI4T0VCcktx?=
 =?utf-8?B?dUlXK3VKZnE2U001ZklyZXZFVlJHM2s2NDZVVkMyMW5UQ3dESlU1ejdnaWc5?=
 =?utf-8?B?STVhK1REbVI5TUNkcHlVTU8yYXNGTjRhVkxNS1ZWUlRmdWc1T1I2aGZod2RJ?=
 =?utf-8?B?a3lIVjRVNWpRUy9zQUxFRFA1aWE0Yk83NTdJUFRPeUFtcWJoV05IRGE3ZUho?=
 =?utf-8?B?WW0vR293RXhQWDdoenhpRDVRZnNYVFNlSGNRZHRTdUZHRVMyNzlvNHpFTVds?=
 =?utf-8?B?Unl3a3pFUTg2RDM2Vm40SkpaMmZsQytMdlJaQVlFdFV0RUovTE1JZEw4bDly?=
 =?utf-8?B?UzdBSlR3LzNrM3g3ZzdSTWNkb0h1Z0dqS0VMcFMvNzlTTXZ5dnV2ZWtPSmlD?=
 =?utf-8?B?T2NOWDY3RHg3OUZobXRzdzB5QmN0YWZWK0RTWWVFcStWTlNYc2dBdHp2MHpI?=
 =?utf-8?B?T2ppL2phRTZNQlFVZy9BWXlYTW11QjAvRzRWbDJ2UXU1azQ5OXpJVXJBTlVB?=
 =?utf-8?B?djJleXFoMXpJUjVibkVRLzh4WDdJaExyWFVHTGpKN0EwRlROK0tFdm4xd043?=
 =?utf-8?B?b0E9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3991e881-7de8-45b6-6f3b-08db6b1f1410
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9563.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 08:29:02.9409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dp6W0xgr33cJEk0YwHABMmxVe5TODLqpTR0MwS5T7KRhp/8KI6owmCUJCszr2U8k+vw44cus3HZHtUHXQgwQdSlMcBN67pw10LE3TS9QUUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9971
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Victoria Milhoan (b42089)" <vicki.milhoan@freescale.com>

CAAM includes a Random Number Generator.  This change adds
a kernel configuration option to test the RNG's capabilities via the
hw_random framework.

Signed-off-by: Victoria Milhoan <vicki.milhoan@freescale.com>
Signed-off-by: Dan Douglass <dan.douglass@nxp.com>
Signed-off-by: Vipul Kumar <vipul_kumar@mentor.com>
Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
Signed-off-by: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
---
 drivers/crypto/caam/Kconfig   |  9 +++++++
 drivers/crypto/caam/caamrng.c | 48 +++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/crypto/caam/Kconfig b/drivers/crypto/caam/Kconfig
index ec6a9e6ad4d2..c631f99e415f 100644
--- a/drivers/crypto/caam/Kconfig
+++ b/drivers/crypto/caam/Kconfig
@@ -162,6 +162,15 @@ config CRYPTO_DEV_FSL_CAAM_PRNG_API
 config CRYPTO_DEV_FSL_CAAM_BLOB_GEN
 	bool
 
+config CRYPTO_DEV_FSL_CAAM_RNG_TEST
+	bool "Test caam rng"
+	select CRYPTO_DEV_FSL_CAAM_RNG_API
+	help
+	  Selecting this will enable a self-test to run for the
+	  caam RNG.
+	  This test is several minutes long and executes
+	  just before the RNG is registered with the hw_random API.
+
 endif # CRYPTO_DEV_FSL_CAAM_JR
 
 endif # CRYPTO_DEV_FSL_CAAM
diff --git a/drivers/crypto/caam/caamrng.c b/drivers/crypto/caam/caamrng.c
index 50eb55da45c2..b3d14a7f4dd1 100644
--- a/drivers/crypto/caam/caamrng.c
+++ b/drivers/crypto/caam/caamrng.c
@@ -172,6 +172,50 @@ static void caam_cleanup(struct hwrng *rng)
 	kfifo_free(&ctx->fifo);
 }
 
+#ifdef CONFIG_CRYPTO_DEV_FSL_CAAM_RNG_TEST
+static inline void test_len(struct hwrng *rng, size_t len, bool wait)
+{
+	u8 *buf;
+	int read_len;
+	struct caam_rng_ctx *ctx = to_caam_rng_ctx(rng);
+	struct device *dev = ctx->ctrldev;
+
+	buf = kcalloc(CAAM_RNG_MAX_FIFO_STORE_SIZE, sizeof(u8), GFP_KERNEL);
+
+	while (len > 0) {
+		read_len = rng->read(rng, buf, len, wait);
+
+		if (read_len < 0 || (read_len == 0 && wait)) {
+			dev_err(dev, "RNG Read FAILED received %d bytes\n",
+				read_len);
+			kfree(buf);
+			return;
+		}
+
+		print_hex_dump_debug("random bytes@: ",
+			DUMP_PREFIX_ADDRESS, 16, 4,
+			buf, read_len, 1);
+
+		len = len - read_len;
+	}
+
+	kfree(buf);
+}
+
+static inline void test_mode_once(struct hwrng *rng, bool wait)
+{
+	test_len(rng, 32, wait);
+	test_len(rng, 64, wait);
+	test_len(rng, 128, wait);
+}
+
+static void self_test(struct hwrng *rng)
+{
+	pr_info("Executing RNG SELF-TEST with wait\n");
+	test_mode_once(rng, true);
+}
+#endif
+
 static int caam_init(struct hwrng *rng)
 {
 	struct caam_rng_ctx *ctx = to_caam_rng_ctx(rng);
@@ -258,6 +302,10 @@ int caam_rng_init(struct device *ctrldev)
 		return ret;
 	}
 
+#ifdef CONFIG_CRYPTO_DEV_FSL_CAAM_RNG_TEST
+	self_test(&ctx->rng);
+#endif
+
 	devres_close_group(ctrldev, caam_rng_init);
 	return 0;
 }
-- 
2.25.1

