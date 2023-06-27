Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F71A73FA02
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 12:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbjF0KRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 06:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbjF0KQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 06:16:07 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2118.outbound.protection.outlook.com [40.107.215.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C292965;
        Tue, 27 Jun 2023 03:15:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iN3QBSGVgwI98dz/MAgIAdHSns2oRrft7O0Mwmyaq07/JNiOZlmIKWqHgd+oEoUWZFUm9mwsrkha/1suRGmIZDbI9Kq5eO+pyUCgWQkXMRSbjA4zbFxVRGGtPupn9NsJdctm3ud6ujDI2k1Vphjb4nu5ZHwpZnrEKJcEu+RkY5FGDR+Qf6kV/jSODQ1uVNjbDctrwfLd+UCMZnw8JREZSBRJdmoMU54M9jvmznTBj6tUoZ/7hD2LicUIE+sF8yaGnUyynDnsV8k42/vEGjgBOMeihWobjsUYbfHw9nnlb0g9h9BWNEwMq45yU9q+g6VbJD/0neZ6wsM1X9wi0s9LSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EicJ6c/zmRq4kaTk5EYESeIEW3wL25/O6LgVLRrMKps=;
 b=YiTqKYBv/vJLx5QjB3yYoGRr4WaW022plGPlZJN3sbtIYm/deghpwkWSeAyFcKVX9uYPtWQUJxQrkTdoFZ3lvo3Ysiq58YgYXrV3S42TOsJjhASppryAXamMN285SUjGZhIOeWMiNGh8mx1iyXkWOnytsuFXBJYhJfe929dOMANVrMwMxeid3yhWq9ABlVIIRbrYhnUTDBTL8EtJdr0x0y6DdHX9EClraHm0e2crPQ+fIQTkmG4BNi3NkOiV7tYx0MXUN1vn8xW0B5fMx9RxKbsz1OGMPy3Z77JvFc2eEYNpEZcVq91m5MJnn8CxE1jxtKCpQPgBOpiQzCPtnjG/EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EicJ6c/zmRq4kaTk5EYESeIEW3wL25/O6LgVLRrMKps=;
 b=OIYXztebsqXZOXTVIzc4bRiMFenxn3zvxHSwIcuE4IlY4AWDY4d8psip906/P7/yryMJMadJTUznomKCVoS84uPZ/iulB1ATXLalNVbLcbZjPZ1gfEyKAJ6D4gqvcwxaALZ52uxAlg3KuwOG/oVQKpmFPUlW0NZA1OLvTJatSLvbtrUXuQ/6RWXJ/WhCP2l4D9zOic6RXzWyehMP0a8WIcn4Tgf7fgoHLeBTmLtAm2MwMAEIoDzL5gfsBry3Ez/V510/K21ecxC0X6B3mC7ySPUvj2cCCpOtjQcmrnk4KjFChrUhSzZa92CzKXwkGl6XrSnvP80ZQv1DLYv11qIVRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6661.apcprd06.prod.outlook.com (2603:1096:101:168::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Tue, 27 Jun
 2023 10:13:41 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6521.023; Tue, 27 Jun 2023
 10:13:41 +0000
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
Subject: [PATCH v2 12/15] thermal/drivers/stm: remove redundant msg
Date:   Tue, 27 Jun 2023 18:12:12 +0800
Message-Id: <20230627101215.58798-12-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230627101215.58798-1-frank.li@vivo.com>
References: <20230627101215.58798-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB6661:EE_
X-MS-Office365-Filtering-Correlation-Id: c8dd42b2-ee02-42c2-8ae4-08db76f72e96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e+qmPu/uRGHCsuG3cpRd7dKM4Mb2Ty7CrHI+CQSxYqP3tB+c4jTYB3E3y/9FxuCBWlebnt3Shmn0dIV5UikAFnEVUcpc9P8laOMYaZ0/+53UTX88H5YTOGugG6Z1EOT2BWuo9KOFf5g7/eGOJ9Tl2KODSS9wJa6C8FoiXRkajX6nvGE5EADCxnIdmzGEazpYJOTWMSell9MtvUR666RsbAAT22K9nxOCWNby8RUlOQyrZIzLuKo7zXk2kJtbPc+Gtuuoy6eMGU9UK6oXf/9nbvA1vilyvfJG0dINUVgl3r7SH0dizJKYaTuo/ZSJWdnn/Qef8tmQ1k6KDizaySENJi5pQmUwrqVf8gGlH0HNe8NYVOCBn6cxcP08Mt2cy/2vTDS0tVKKL/rcwxrEF8qUvedHjlyh/0P3CLvIRj40AFsOR2DaHxlUfaXVaRumtciJT+QFYE9t79OkR8jju1ar2VbH3TiSH3+LRROJB70B8rlDGall9UBuzCagTBOysLFTY8qXR5CI3gRczsraD5qhx8YdOso5VexeTMzRFbBXesCr6duH/qdkcl+VyrSQl8XT/aI8vYGCIOUwGny0uvNtx2zY2iprVRtO1ylriNM/BH+fc+/CJkEE/ld3kEWPYV25OQfRzpOsC7/RtEBITICcHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(451199021)(7416002)(7406005)(5660300002)(66946007)(66556008)(4326008)(66476007)(478600001)(36756003)(316002)(8676002)(8936002)(2906002)(86362001)(41300700001)(6486002)(52116002)(186003)(38350700002)(6506007)(6512007)(1076003)(26005)(6666004)(921005)(38100700002)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WzQJVCZhNHe/iD4TC4F0DP5xzzQz63Vw7PMvbbl0/rOs79hSkSERc8hoWtoX?=
 =?us-ascii?Q?w+4mpNqyLzl+l//BiFTA/6Yxy1SXuo3V0oUE/E+pRpS86ALVWSCTfKDIWk7K?=
 =?us-ascii?Q?ss+goNYg7Cy+XDS62jF6CTwaPFi/DKPVC4eHiB0GUnq4SDYwI5Wq2xn/r4jJ?=
 =?us-ascii?Q?o/P65UkFduO6o7tUf0j1bAakgOzfkzNP6uwuPNkZcFwgjQvBrtzc+9bOiRwS?=
 =?us-ascii?Q?itXC38n+o72NEy12vWUUzI2gvgSaq2QFZNN75+exHlXOhiJAwjipum+LQ499?=
 =?us-ascii?Q?h5S++5V6GXeddlqVWXbnZfASGlnPym/O/R3q6ilIq2k05OhZACy95rINu6Wf?=
 =?us-ascii?Q?FW2wSTkttSmPehvfWvYhuips8faZrXz5Y4XICKIvEHwTQncu+LK0I/XiJZyk?=
 =?us-ascii?Q?ZkB7x/AWQoxdxXPyNK+VJJnKWM0t0e2CuxQEtiXBQNXPHFYthrOgLy//oa7e?=
 =?us-ascii?Q?w/8J2RdCvVy0+9WwqvWYNoQbg7qyeb8IF06YVBu8/LB6ofRr5IWsyuWhhbqp?=
 =?us-ascii?Q?6EJ38b5PXxcqLMoYIUkESWeexu1QuuQvttI1OsgbzCKCiK1S6hrmM6ug4+qO?=
 =?us-ascii?Q?WkAaRIUfQjImz9NELUDYNFYwvYgSl83Sv1aoJclAqshrORVp1xQgA3zWoqKU?=
 =?us-ascii?Q?EHdUI2ESC0lN9bt7zACdwi4ZXzEUzdCSQjHpZ737m1ynT+AcPm11pMHb2YtZ?=
 =?us-ascii?Q?mOVqwtaLG0mMqxGypWvkwfWtE2UXuUrBjKCW/rpMw1F9K3xs14nS8PbBbcE2?=
 =?us-ascii?Q?gfu3RXcwHB4I8cmIiVazSk5MRUKxX3oaGPBTGXo0aurfQfq6uODDpNMqJxXJ?=
 =?us-ascii?Q?iP4oy45lc7UAflKpyY0H4ZCOAcEI2toeRk8RTQ5gPkHnZKn6SJN6qfuJZcuB?=
 =?us-ascii?Q?r3ijr86/PsifPbVQSG1lKBZ5t9T75LglFpGEDAeIcEyPQv4cnGLBVX3QMZZX?=
 =?us-ascii?Q?Em+2EipeZRsDAsk0gGB0IVrZL14spwk2mnxzuoO7VvLEiW9x3jOaEXkFzQI6?=
 =?us-ascii?Q?vF97ZvrZA9DFOd+SWXjbGFlKRJOv5XpOYQe+BVnOYwXl8YeP4yDBldSIX14I?=
 =?us-ascii?Q?1Gn+FEmfBiByHLtjAjrrtkmhmVkuUz/GBTgsvW1hG3gQBUxfrYCO19B1FltW?=
 =?us-ascii?Q?HiB16f/+ueVS9lvwuQsMvyfoMgvldCZmK4y5P3AGkF+V7565BKk2DOuabQ5j?=
 =?us-ascii?Q?Lwyd6Nq/YRj7C6HQzfcN88wOwC5ISKDH27iYqQ9zNSQFUJG23u/1/6rpo5Yj?=
 =?us-ascii?Q?hZte3nHhHhSyV9i64lU2v/gWWN+J/tUT+0nvtR5JQl0mKYqnL3WpUcF3KKuj?=
 =?us-ascii?Q?fT32AP0mUmkbSVsam7g0pA/8jo+lw0PVOcd2wjIvGBcjIrFtP9tA5ejqfbYt?=
 =?us-ascii?Q?KYTNPwvHkYv2v+Cvx+nXbRJHSnDHRm9S21x64CeN1Stkf18kZgKlRJdDlZMi?=
 =?us-ascii?Q?vUwH2o92WJ735ItiNZfnQyC1zNPdpLT0gtD5AFj3m56Xa4n7ENGQ1ktyUCBT?=
 =?us-ascii?Q?qjuMf4k7uvsis8rewTr+x3Us3WGjDsJrOORzrI/cqh9JLzkEn0WwNRhhYI7o?=
 =?us-ascii?Q?TLJGgBb72qNmdxRIYPmC/R2SmdD+b3jdFRS/QgHO?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8dd42b2-ee02-42c2-8ae4-08db76f72e96
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 10:13:41.5174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: npDvD4ya2XVH3JC6V59bxzf2rIzVZcDBd+RfHVMlW6QWUjujEhdEfMR4S63P7y03quG0VdZp+uVexbwVdLwqxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6661
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The upper devm_request_threaded_irq() function prints directly
error message.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/thermal/st/st_thermal_memmap.c | 4 +---
 drivers/thermal/st/stm_thermal.c       | 5 +----
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/st/st_thermal_memmap.c b/drivers/thermal/st/st_thermal_memmap.c
index e8cfa83b724a..dd52e1b9d925 100644
--- a/drivers/thermal/st/st_thermal_memmap.c
+++ b/drivers/thermal/st/st_thermal_memmap.c
@@ -101,10 +101,8 @@ static int st_mmap_register_enable_irq(struct st_thermal_sensor *sensor)
 					NULL, st_mmap_thermal_trip_handler,
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
 					dev->driver->name, sensor);
-	if (ret) {
-		dev_err(dev, "failed to register IRQ %d\n", sensor->irq);
+	if (ret)
 		return ret;
-	}
 
 	return st_mmap_enable_irq(sensor);
 }
diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
index 903fcf1763f1..d72e866c0ab9 100644
--- a/drivers/thermal/st/stm_thermal.c
+++ b/drivers/thermal/st/stm_thermal.c
@@ -392,11 +392,8 @@ static int stm_register_irq(struct stm_thermal_sensor *sensor)
 					stm_thermal_irq_handler,
 					IRQF_ONESHOT,
 					dev->driver->name, sensor);
-	if (ret) {
-		dev_err(dev, "%s: Failed to register IRQ %d\n", __func__,
-			sensor->irq);
+	if (ret)
 		return ret;
-	}
 
 	dev_dbg(dev, "%s: thermal IRQ registered", __func__);
 
-- 
2.39.0

