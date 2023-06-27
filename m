Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70BFA73F537
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 09:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjF0HSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 03:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjF0HS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 03:18:28 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2103.outbound.protection.outlook.com [40.107.255.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D911BEC;
        Tue, 27 Jun 2023 00:18:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ORJciElWF5fC9RgbH9QjiEKrZ4vImoiL+neQbIJUFe78FO0QbJYkdiAbcusMEDh7M904zaC89864XrlmHdcpGPyxMcMHT7i5FK3Y/g4U5dOUpLyPXllKB9D6lY890LcnBYL8rpBqUAsWmX8RaZnMkEMTFXuwTHfK1VkLlmlFgshEWBPPaLulFIRog3IGik1s8DhItQCAiNys/JI2YV60VVaJQdyl56ahny9/1DCxW1bILNYVUUybNYYwGP2busTWFJhsVnOn7iJw1ucadpaaEQrnNIFDfsTLybNIlmwNv14XYMGXp87kPqXQ7av6YXyJnSzgycz/6TtOCIxb0ph7fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51TqBSHuDXoJXJu/QRggDkPtKMVIjd+MxWJJWwhPeEY=;
 b=neMprW9P7ckOmO7clUlJkWtvbbJZW1IIBvB/OL8r6uAJtFoEFvdg/X8TR/AGJnDmWIkIa0VdSzrKgX2EC+9KJEhd7SyoUiP8LG+Wdn7tytmMZwWJ4I0M6aBUzsW0fsU58LgiS5crTs2mcdVIfa/1cMdJ5cS7VYZA9bLnE27ShuOuGL6jYcBXth3KbSxr7UTrT0F8w/pYcoQclvr5mg0L82NXDOm8h2MImir0m6TCsTMk8J9SenDx2xYw7cGGKDafKX5Jss/kVB2Cpm41+HvbzHxDivDFHMUWnUW2AWADtzBnPi+Mt4/ESAqpvJw6FNVBIBDwkeuB3XeiknEYu9SYkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51TqBSHuDXoJXJu/QRggDkPtKMVIjd+MxWJJWwhPeEY=;
 b=NuKi8+9aCEPG7NoMyiAlPkABJXEUTT+8+1V+Sgmh1CCZ6bjeb8+kmvvumxqVU5vOHHxiCaxWIKSxRDhUTJMA5kCOW6ag5ld4vcCqh71AkCcpsSR04P5yxxrvv4QONO+J9fMY7HFtSocxwqajiEmw17u4Vkqp+8e4HmlWeZgmjBwYrfl1UWiVCwmPQhSR2CfG9fTHocG5ccCqxCPMQ/ghgHi4DB0fdLZ7xPBNTCTTI5LwYTkm5cz/Kjs0QNwvrxVN7vBWCI4vqIt1jw2jGcNxVf9bBMfRDdFbd0ewjVAXwjcb5C5k9FVc1dFi/oJCWBOFXQ50U0IEPGyjF5wx/5639Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB5137.apcprd06.prod.outlook.com (2603:1096:4:1ac::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Tue, 27 Jun
 2023 07:18:19 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6521.023; Tue, 27 Jun 2023
 07:18:19 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     miquel.raynal@bootlin.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        mmayer@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        florian.fainelli@broadcom.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, thara.gopinath@gmail.com,
        heiko@sntech.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, tglx@linutronix.de, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        srinivas.pandruvada@linux.intel.com,
        DLG-Adam.Ward.opensource@dm.renesas.com, frank.li@vivo.com,
        shangxiaojing@huawei.com, bchihi@baylibre.com, wenst@chromium.org,
        u.kleine-koenig@pengutronix.de, hayashi.kunihiko@socionext.com,
        niklas.soderlund+renesas@ragnatech.se, chi.minghao@zte.com.cn,
        johan+linaro@kernel.org, jernej.skrabec@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH 01/15] genirq/devres: Add error information printing for devm_request_threaded_irq()
Date:   Tue, 27 Jun 2023 15:16:52 +0800
Message-Id: <20230627071707.77659-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0098.apcprd02.prod.outlook.com
 (2603:1096:4:92::14) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB5137:EE_
X-MS-Office365-Filtering-Correlation-Id: 59c7243b-d573-4ca7-edd4-08db76deae7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BMuimp7YIXmbJcYdHfRwr0mPIB2kRS4bhtcjhs/CyvMe0GTjViBkRrquU/ldbzyBK+HnNvjG74mPYHA7gOPwr46+22R7KOnix0VL3botXy1F4QxzV+Ka/U5m+CqpQMlfo4I3orc6DLfyY4Od89C3U1yjfPRj4Bqk7np7Ipr827wLH+AtcYZNwuQh6fDdP/saWyuQsh45FbrpXuG8D0VPA6Nk5zypVBr0JXeU7Ki72kyR8H2l4VWYVhWzpXmCRTzhvhIEcClzgm9mnYlMesGIno/e525i2jT9IbN3BBzzufMakYmkLLdR2noql9bsf+5GsxccEw7MoKfezEXspnJ7qDZxGdxOo7nt+b5XZFDwVIgH9hO+arI1E8RQnj125U7T4N3x+MUTCMXc05hSYgn5yWIhCmCHyD7U1qr7YOr1GPJe3HrAi53uR9NvHF3Qiwk3HvLHN1U1tVhkaB4Br1oQ0lIsBcEBtMe9/oKEAQgwDl58zuH4t58lnCw9j2ZfDaVAjw22sgxSnQj9GDvJfdmCixMhYhv4xmAfPGN37MB0FFxA58TMPM5iXOnG8inwe1GbJuYu1tsROlEtqDUBD0d0W41YNHgAgP9vxVbFYuX9ucdymkaHFA9Kp5PGlZbp/hQfCJqsMj7+3uRTzLmnu+N9WA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(451199021)(52116002)(478600001)(6666004)(6486002)(1076003)(6506007)(2906002)(26005)(186003)(66476007)(6512007)(66556008)(5660300002)(66946007)(4326008)(7416002)(38350700002)(41300700001)(316002)(8676002)(8936002)(38100700002)(921005)(36756003)(7406005)(2616005)(86362001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qLWCLn6Atkpmn4V9QXQofQM/y+zY3+Phjs3YQpk8roZYbbWC3DlUoMEmBWqM?=
 =?us-ascii?Q?+jGwprheKz+OyWrabLR4aw04cB3MXmAFKKRsTpo9f5BCCjX2iIAAiAewFdrJ?=
 =?us-ascii?Q?nV998ifonD4+nImmQW+nbvXGLnS5s3hyMfTLhnF+vFxjBEvsUEdKXbTOm/Lf?=
 =?us-ascii?Q?FruuwO2D6CrMxjG9ahvJr95TwNXegMCardugJRZ+cX74MOO8oe5fWg+YMWHq?=
 =?us-ascii?Q?/PmKNpI0P0rXpOVjwIcXa+IIebo538LXlwqGcHuip7a9srJ8pbjQSi1Rwxq1?=
 =?us-ascii?Q?pTtfo2EgcXLysymu01NiBWqCuHGFLD7fvtGh8gBbthbQiMQKA6KGStfeGBqr?=
 =?us-ascii?Q?UzXQ+PcTbhVTrjxpa3AFhJ1QlByYnpIjgv4VdAT19KsX4nqmjUF7RBdIEbuF?=
 =?us-ascii?Q?lUz2whbz7kwmgufCRP3BjfZRmq/QkgRlzDMcp1AdVoK12UjixOWcv0AI6tnc?=
 =?us-ascii?Q?DKwZeSk7W0Ln5zgu4NPNYOYCw4ncIF0NzwoVEYzMR4YdPLvvWvKi8eYMW21J?=
 =?us-ascii?Q?ofJ2KvylWWtEyimwnqvn92n2JIXtQKxsQywpVfQl+k4q+eoeonk0cmkfaKa9?=
 =?us-ascii?Q?mG7cozugKy/wooUJu4MelO8Gk6HiWc0pJAwaTKdwjK7FDx68fh7bMneneI6/?=
 =?us-ascii?Q?gvzAOdQujeub1011MK+45NsYlvpZhMWVd3PMkAEPFIO9H/8Zge65DhATHKlg?=
 =?us-ascii?Q?vxHEIlY5t5ZmMhMAwIC4E2nCZcPGrOYl4rrjHNgy5qWWFnvyeZPZIdDdtggT?=
 =?us-ascii?Q?B609QEz6pK99/uM8D+mOd9flqgOYPVumR3Z3umKRc9crxs5NNZBnWNRAKdQw?=
 =?us-ascii?Q?AFvyiKmJK/Q7089lP+6xMj49sv93HTqGxfjKg9Ujm2UJ8hw6FIoBpq24QhQo?=
 =?us-ascii?Q?Fo16ESPjpYbcKk5Z9rkxJkCpgWPwU6ru8DMT3+1eqSkQl/RIj73HPFwIp5Aq?=
 =?us-ascii?Q?IqJC7KYAfeH7WqgdKnt0IE/cBEOxz8ywuMWMftAQyErgpcrFasDLJYiNxL+l?=
 =?us-ascii?Q?s5Ls6gpE+FlQLuDXM5YnSxGR5wbtCfSp5Csxg8urLGlGYkpDUUOeRysxmWbA?=
 =?us-ascii?Q?d0bXk/ea6ctY2bgixjDDhfj744zRnaqyzYNi8Ur1JRNZHnGyCs6hwU+QKKhP?=
 =?us-ascii?Q?FIyrRX1KYXhkZ3cXjOl6WAJbOrvl4ZoGXdG3MO2ChXyqmls8A5bm3qNVqEgl?=
 =?us-ascii?Q?RH3Oj13FVJmZ+JcXYR4eceUXXAzeoWOlALn/HB3nAAGddDRnAoyVk1GQohq7?=
 =?us-ascii?Q?28vArmijHFjHJ9fH2qT2PPk9tFtYydQbKUUWQY4SBx8yYQNpKaLf2+XNEo7R?=
 =?us-ascii?Q?FOA2t7V5JnL8TdtwvXr7pNS+I6rpsFCy+VTUd37OKB+wELA5Z5y3PkHfOsVA?=
 =?us-ascii?Q?ZrDM3pcy168VV8ubp40i3/OKc2H+JgtcOUDugBMqD5dBgRfiP8Vgy5M8COOm?=
 =?us-ascii?Q?d3TqIgx4WPV8THB5CoAuDnTGh9dX2XKiMJ2lCWFWblHrOb3/+8+U0PO7P9S0?=
 =?us-ascii?Q?qVHEJUedN0dRpT4SunS+af0JPuN4LpKQs2HfpQshvp5kTGJTyCUd4nPYQld6?=
 =?us-ascii?Q?FFmmrJXX8bgl6SjtXfzXq76MEB3U0eGVQeNuC2Ui?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c7243b-d573-4ca7-edd4-08db76deae7b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 07:18:18.7400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GBm1nYiZe272EoTZzTUHqEZ8CHM0QqaA1Yu+Dhzxv9kiYwTs3Ns106LEgm3MVXcwuPZdcjOFYIT1p5E2uaff5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5137
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure that all error handling branches print error information. In this
way, when this function fails, the upper-layer functions can directly
return an error code without missing debugging information. Otherwise,
the error message will be printed redundantly or missing.

There are more than 700 calls to the devm_request_threaded_irq method.
If error messages are printed everywhere, more than 1000 lines of code
can be saved by removing the msg in the driver.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 kernel/irq/devres.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/devres.c b/kernel/irq/devres.c
index f6e5515ee077..94039a915218 100644
--- a/kernel/irq/devres.c
+++ b/kernel/irq/devres.c
@@ -58,8 +58,10 @@ int devm_request_threaded_irq(struct device *dev, unsigned int irq,
 
 	dr = devres_alloc(devm_irq_release, sizeof(struct irq_devres),
 			  GFP_KERNEL);
-	if (!dr)
+	if (!dr) {
+		dev_err(dev, "Failed to allocate device resource data\n");
 		return -ENOMEM;
+	}
 
 	if (!devname)
 		devname = dev_name(dev);
@@ -67,6 +69,7 @@ int devm_request_threaded_irq(struct device *dev, unsigned int irq,
 	rc = request_threaded_irq(irq, handler, thread_fn, irqflags, devname,
 				  dev_id);
 	if (rc) {
+		dev_err(dev, "Failed to request threaded irq\n");
 		devres_free(dr);
 		return rc;
 	}
-- 
2.39.0

