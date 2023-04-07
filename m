Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587676DAE7F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 15:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239910AbjDGN6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 09:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbjDGN6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 09:58:23 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2031.outbound.protection.outlook.com [40.92.98.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651329B;
        Fri,  7 Apr 2023 06:58:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PtWylB1XSExU67Z41xHH4qbTWerawkKwWrBQaQedsaXFRfmfioBJ5vbIMi4k8e6wBUhGtmq09+X1WB+DPEvvsypQGyjzA39oHqA9/rpfYod1D0mZRXDHSbRtXOwDqEsmsydgL9svDDPRfkgQDJaD0mCYEEOxn6ts4s7ALfNVryfftPCXXR9A0FvhxJefUgQqWFhbuwvPrAvqqIffc+OT5iX9KplexXDMH3zMosWC5TdyVAeIkJ6LK0TmNH5kDR9g7iu4Ql9M53v13M9bAfN8t3L0bI3JUFNyATSKo6rwrq0X9SWh3zQZsE1pDoVPVU5qW/pWG1ttqnBSPC4LurZcpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CrKf4PujbmJPhHSFgCGHii7KflE/PVCC1x+XAk3orLI=;
 b=Cr4AhyHMLCtXRjDjapOvTq1LtPr4oYHK6l5u5e4++g32kOOYpUizDBswFjT1aCTR1RpSiRrIP3057c4QCBB5OJ/Zm8/cqYUkoYiXD/eysu2Zd92O9FinriF3p9HrEt7ZyMRk6+CntDoWZ27gKiVY0ysfbWc4hmt43j8FNhQewWoPPPd0DXeeIzLh7Pq2Ivv2cB48xWN6mAAG2HB8L9K/GuhLID28sZZUwybHIVYTT5u17b3IvjLgJt6+iEQfQ7vTVxj+v01Nvu00EQ+DbtlIIaioNk6NcEC7aNGHyYrK50hS27PRYnxVd8LudTLjeFZAJ80y/p/osXYktnvx2nS4qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrKf4PujbmJPhHSFgCGHii7KflE/PVCC1x+XAk3orLI=;
 b=DElawGX/43okMmVv7wDXqGyT2smW3yProVDX05Ik02XxJ7chjH6KaoD2QFbisSO95fhd1V3b36iHSdY15rVtBPTCtN7YgXsFJlC3eGTZe26ju/G26+1Ht4IiIqjmai5uawdsrZ3IvA3nyR5qzyiEXKT97Bzpr/lzaY3qeFFgPcgTixtGB5dvx+6lB1VpWJ3VRupmGSBDfrFhAUcqEZ+24ATZ/OKdYDl3yp/No0raYd+uGZ68NIn0jCWeBBZcEh88GjM5Q9E+ei/XAfbFSsoiTCQFfXIz/cwiFfYeYgS0eHfDC/k43Osmtd8ofeBxllcrgJf2Uq8rNJZ/8gYbx00JuA==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
 by OSZP286MB2208.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:18d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Fri, 7 Apr
 2023 13:58:16 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d190:6e4d:5a1e:59a]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d190:6e4d:5a1e:59a%3]) with mapi id 15.20.6277.033; Fri, 7 Apr 2023
 13:58:16 +0000
From:   Shengyu Qu <wiagn233@outlook.com>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        lgirdwood@gmail.com, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v1 3/4] regulator: axp20x: Add AXP15060 support
Date:   Fri,  7 Apr 2023 21:57:16 +0800
Message-ID: <TY3P286MB261142BFECEC8C810C3F393A98969@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230407135717.17381-1-wiagn233@outlook.com>
References: <20230407135717.17381-1-wiagn233@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [7t6j8pVS9R2Y9n88xJJx4cfTTjqa8BWr]
X-ClientProxiedBy: SJ0PR05CA0050.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::25) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:252::12)
X-Microsoft-Original-Message-ID: <20230407135717.17381-4-wiagn233@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|OSZP286MB2208:EE_
X-MS-Office365-Filtering-Correlation-Id: 21ef9863-b671-45f0-76d5-08db377022d9
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9Xmovywdyt6JbrF6Sw9xOtJae5pVK+uvqGxEGEVNklWX8e9kfgIBfZDO8uZsYza1DSxY6oKRnHMC0+rUy4/lU5W9fhlTmI0zlRo+/u1vLRiKI+PqUGoGFegJD0BPBsWxP4HLT9sYylA8ynZJNJeG+/nWMivVX8m5Wvx4yFjg0lnKu2c2Ib+BLeYSlsE0CCkco6O7tTZw6RRB2FTb+F83k+ZwbvmyS70x+SGE3fnDpBme08U3b7Xx/VU23/mBsnKaPCkNQ2wqZcfUZhYr8hJblADCFWYoyvhJeTVUqaMiutSuXBO1p83K5XCNlBS3A6NEJ0PlDus1Khj7kFBY1/aUibGTcTAX9mwf+HX7jw9fp4DX7gI6UFfYOlNXUlWdOBnUFfc9PP8jyWqw6WYL1zjCX8wya7L+pxttSKJGhMJqJhMhTfKs8zltvR3fLbtLIjb0kHwbOVMU5uvphAvFqi0WUT1XCIdl7HIyqBTOc9+Qc2/vqwWvzyzcWWZsr4t/0eOQsMbAdzC/FEJsFfpGcF2rX/mIhNesCiLRpP0R67Mii42XnXjwnctWKR4yXcyvA9NEsbPP1wbSwHu0c5D+roR1t/VauR+yVWsnyYC7M4Zby1/tnOL1C79nU1NgFAbBg8ywkwtvN88KZtEz7FkY0Fr/WBF2pc/4koJVsowfQ+7M6xU5fEs3ZCF4h106nd+J+zzEGGyy2oRPa3KileM9/m9sRLYqWMuNp7yds+dFjPr5D4J/uPcF5iwejEIjBk6QzWRmPeGU=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bjepaX4T2SyECUQfmeQ0VI1z859meCvcBggk7sDw67ajC1mht6Vt6j+KkI+Yzomt6mNTNmroJnPus7AFw2vIZE7Lb/1hSyUPUeEktBUFrywOwLURByZtchUKgLOj2WwXMi3rp/2BnbmC84GEgPJTOZIN3Bu/E0Z7TBws2am2lvh3gfKQAnwD+45VagqP62gb7wX01762z3XwPs32XVDZh8Y0PwEVcf6ulgxKC13P7NfmCOQoOLn2nxnvGR5DGln9kCu6zydurlFTBxyu+77Z4ypNNqydge9+WLh+DJRiHC8mgduB3ndEI4YDcf0hYOkDRUdNZPiSXnaKN4WZIXrGmZzVsvJo3Gx2x901Toj3na+UineVNUjZr/SE8OruHFruvU0agLO+IIb35wtpJ6Noi/bEXQcqzb0BcWRwJdduGdYfdODSgQqc+kG+842tG5XNYWspLDvSA6j9SOyO8rBFgcWIwikLt9CfVxX/631tfXfC4twsxhYdpTeOhap94YCy4Kf45BmQKL+ON623LJS1r6SClSweWnqQCsprAcQe53nKNDYQTXwagA31PP6Dzv+uDVFiU/jPAtsW2wGrMAhjzvFymu6fNnImD7SFIm9j8OSwGljCsLKs6m6CQWyyHm1G
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DzsVovDSl2/txoQ89WzgzToeeRfs4PwuaChafEAgyU8Y9YDlD8bfFIEeajV6?=
 =?us-ascii?Q?x0+KKSeB77alkdrsv7k4M1esKpPwJQx4f3ORG0kuSzOFA5ng/kW5cEyMdAI0?=
 =?us-ascii?Q?QmjXcg5vWR2aGrrgp6I+Ex7DZO0fXQHU03seeTe/6/qYZI2Bhl1jZwMuf0Sb?=
 =?us-ascii?Q?jREumROu0j4Grftv3/1poOrXRvFHsqWMbJ5BaxRcdH5SPVQotpvDcfF6n4Oj?=
 =?us-ascii?Q?umyDRR+hzv0Uqg5DyLminKgc5ZhavLcvwdgSD7Q/kWXbUoX6CD/kUoXzA4Zw?=
 =?us-ascii?Q?TeWzKfJ4tVTJPG92Semrno7Dd2Xzj+qF3QshYc1vPq4khKRY6c3MUywogm3q?=
 =?us-ascii?Q?phbJirmmJmJ2qxKlKvr/O7hJ+RKfJg86RxWgqqiXD5KZBTFaZdOesMJLQH3T?=
 =?us-ascii?Q?sHnIhd5nKVg8ZfwHhh5gYBD2HXSFeeg//GGZ1DJb+XWGt9iZ/8elyHkp+vRV?=
 =?us-ascii?Q?YonlQQyXGWsR6REB0tmn8J6mbiPucFp5B5KzoyASV18WGPFNCUNRQk2uh+0P?=
 =?us-ascii?Q?Zq15UYZ0HjiBidaUp39EGfxpo2j2Z1W1OkSBAUOCTu5jYXrQ2W6wYIFMCpPQ?=
 =?us-ascii?Q?3lOvhlLs1YJhHBouugd/lYEm7pycYUjPrzVzQ8XGAfMGraTf/8r9tja29WfX?=
 =?us-ascii?Q?BKwRdusZJ1u9sT90lbNdjMHYTgqcetOEgwwJLGYyb8jnK1kBHP/ppXbDq2lX?=
 =?us-ascii?Q?FrVxZwFkCwQrB6gSFbrEHy9DrFWQj4moM84Y6qP0cyepccow2TENZqdHxami?=
 =?us-ascii?Q?TiuRbRTUHTMAWBg7McQWPy70zGYnsDyYKURxebj0X+2Fi/EHqDvPSwDo0AL5?=
 =?us-ascii?Q?Yskjk5//HMJ7iUoe5a3kyTqepQfv63NBXjm5rb/GjKTBs4Oik/gahip7m40z?=
 =?us-ascii?Q?geyYhuYSlPtlZs/lalYQfGg9+tH8roH6V82AM5Kc0JHcGgs26ZVQglZmNJKy?=
 =?us-ascii?Q?W3SY2+dRvM5PTRAMBzoKnbMkewS9ISVDnZTDo2ZyS+QsIuiiqodOSBY6pCF+?=
 =?us-ascii?Q?QWFFUdczv+hiTk6X+IzQyuihlc3F7+riJC039Ec/XHUZrPz1vJM+jerlT+Tk?=
 =?us-ascii?Q?+iOqIDRtRJCmJo+7RCBJlo93TrQ/cYueQiklFspBfWw3OmN1Jst0uVO5oxAo?=
 =?us-ascii?Q?plXO5DnKMdJpYEqE7LWo/aL6yAb2KehP2lWFmN3RCuOXP2Bd/giqtOuY3Q1J?=
 =?us-ascii?Q?iefNUNcN9yOF/41HPQf78qaYIPuGy+Vd70vCYQ=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ef9863-b671-45f0-76d5-08db377022d9
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2023 13:58:16.8140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB2208
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AXP15060 is a typical I2C-controlled PMIC, seen on multiple boards
with different default register value. Current driver is tested on
Starfive Visionfive 2.

The RTCLDO is fixed, and cannot even be turned on or off,. On top of
that, its voltage is customisable (either 1.8V or 3.3V). We pretend it's
a fixed 1.8V regulator since other AXP driver also do like this. Also,
BSP code ignores this regulator and it's not used according to VF2
schematic.

Describe the AXP15060's voltage settings and switch registers, how the
voltages are encoded, and connect this to the MFD device via its
regulator ID.

Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
---
 drivers/regulator/axp20x-regulator.c | 229 ++++++++++++++++++++++++++-
 1 file changed, 221 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index d260c442b788..ece4af93df7b 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -270,6 +270,74 @@
 
 #define AXP813_PWR_OUT_DCDC7_MASK	BIT_MASK(6)
 
+#define AXP15060_DCDC1_V_CTRL_MASK		GENMASK(4, 0)
+#define AXP15060_DCDC2_V_CTRL_MASK		GENMASK(6, 0)
+#define AXP15060_DCDC3_V_CTRL_MASK		GENMASK(6, 0)
+#define AXP15060_DCDC4_V_CTRL_MASK		GENMASK(6, 0)
+#define AXP15060_DCDC5_V_CTRL_MASK		GENMASK(6, 0)
+#define AXP15060_DCDC6_V_CTRL_MASK		GENMASK(4, 0)
+#define AXP15060_ALDO1_V_CTRL_MASK		GENMASK(4, 0)
+#define AXP15060_ALDO2_V_CTRL_MASK		GENMASK(4, 0)
+#define AXP15060_ALDO3_V_CTRL_MASK		GENMASK(4, 0)
+#define AXP15060_ALDO4_V_CTRL_MASK		GENMASK(4, 0)
+#define AXP15060_ALDO5_V_CTRL_MASK		GENMASK(4, 0)
+#define AXP15060_BLDO1_V_CTRL_MASK		GENMASK(4, 0)
+#define AXP15060_BLDO2_V_CTRL_MASK		GENMASK(4, 0)
+#define AXP15060_BLDO3_V_CTRL_MASK		GENMASK(4, 0)
+#define AXP15060_BLDO4_V_CTRL_MASK		GENMASK(4, 0)
+#define AXP15060_BLDO5_V_CTRL_MASK		GENMASK(4, 0)
+#define AXP15060_CLDO1_V_CTRL_MASK		GENMASK(4, 0)
+#define AXP15060_CLDO2_V_CTRL_MASK		GENMASK(4, 0)
+#define AXP15060_CLDO3_V_CTRL_MASK		GENMASK(4, 0)
+#define AXP15060_CLDO4_V_CTRL_MASK		GENMASK(5, 0)
+#define AXP15060_CPUSLDO_V_CTRL_MASK		GENMASK(3, 0)
+
+#define AXP15060_PWR_OUT_DCDC1_MASK	BIT_MASK(0)
+#define AXP15060_PWR_OUT_DCDC2_MASK	BIT_MASK(1)
+#define AXP15060_PWR_OUT_DCDC3_MASK	BIT_MASK(2)
+#define AXP15060_PWR_OUT_DCDC4_MASK	BIT_MASK(3)
+#define AXP15060_PWR_OUT_DCDC5_MASK	BIT_MASK(4)
+#define AXP15060_PWR_OUT_DCDC6_MASK	BIT_MASK(5)
+#define AXP15060_PWR_OUT_ALDO1_MASK	BIT_MASK(0)
+#define AXP15060_PWR_OUT_ALDO2_MASK	BIT_MASK(1)
+#define AXP15060_PWR_OUT_ALDO3_MASK	BIT_MASK(2)
+#define AXP15060_PWR_OUT_ALDO4_MASK	BIT_MASK(3)
+#define AXP15060_PWR_OUT_ALDO5_MASK	BIT_MASK(4)
+#define AXP15060_PWR_OUT_BLDO1_MASK	BIT_MASK(5)
+#define AXP15060_PWR_OUT_BLDO2_MASK	BIT_MASK(6)
+#define AXP15060_PWR_OUT_BLDO3_MASK	BIT_MASK(7)
+#define AXP15060_PWR_OUT_BLDO4_MASK	BIT_MASK(0)
+#define AXP15060_PWR_OUT_BLDO5_MASK	BIT_MASK(1)
+#define AXP15060_PWR_OUT_CLDO1_MASK	BIT_MASK(2)
+#define AXP15060_PWR_OUT_CLDO2_MASK	BIT_MASK(3)
+#define AXP15060_PWR_OUT_CLDO3_MASK	BIT_MASK(4)
+#define AXP15060_PWR_OUT_CLDO4_MASK	BIT_MASK(5)
+#define AXP15060_PWR_OUT_CPUSLDO_MASK	BIT_MASK(6)
+#define AXP15060_PWR_OUT_SW_MASK		BIT_MASK(7)
+
+#define AXP15060_DCDC23_POLYPHASE_DUAL_MASK		BIT_MASK(6)
+#define AXP15060_DCDC46_POLYPHASE_DUAL_MASK		BIT_MASK(7)
+
+#define AXP15060_DCDC234_500mV_START	0x00
+#define AXP15060_DCDC234_500mV_STEPS	70
+#define AXP15060_DCDC234_500mV_END		\
+	(AXP15060_DCDC234_500mV_START + AXP15060_DCDC234_500mV_STEPS)
+#define AXP15060_DCDC234_1220mV_START	0x47
+#define AXP15060_DCDC234_1220mV_STEPS	16
+#define AXP15060_DCDC234_1220mV_END		\
+	(AXP15060_DCDC234_1220mV_START + AXP15060_DCDC234_1220mV_STEPS)
+#define AXP15060_DCDC234_NUM_VOLTAGES	88
+
+#define AXP15060_DCDC5_800mV_START	0x00
+#define AXP15060_DCDC5_800mV_STEPS	32
+#define AXP15060_DCDC5_800mV_END		\
+	(AXP15060_DCDC5_800mV_START + AXP15060_DCDC5_800mV_STEPS)
+#define AXP15060_DCDC5_1140mV_START	0x21
+#define AXP15060_DCDC5_1140mV_STEPS	35
+#define AXP15060_DCDC5_1140mV_END		\
+	(AXP15060_DCDC5_1140mV_START + AXP15060_DCDC5_1140mV_STEPS)
+#define AXP15060_DCDC5_NUM_VOLTAGES	69
+
 #define AXP_DESC_IO(_family, _id, _match, _supply, _min, _max, _step, _vreg,	\
 		    _vmask, _ereg, _emask, _enable_val, _disable_val)		\
 	[_family##_##_id] = {							\
@@ -1001,6 +1069,104 @@ static const struct regulator_desc axp813_regulators[] = {
 		    AXP22X_PWR_OUT_CTRL2, AXP22X_PWR_OUT_DC1SW_MASK),
 };
 
+static const struct linear_range axp15060_dcdc234_ranges[] = {
+	REGULATOR_LINEAR_RANGE(500000,
+			       AXP15060_DCDC234_500mV_START,
+			       AXP15060_DCDC234_500mV_END,
+			       10000),
+	REGULATOR_LINEAR_RANGE(1220000,
+			       AXP15060_DCDC234_1220mV_START,
+			       AXP15060_DCDC234_1220mV_END,
+			       20000),
+};
+
+static const struct linear_range axp15060_dcdc5_ranges[] = {
+	REGULATOR_LINEAR_RANGE(800000,
+			       AXP15060_DCDC5_800mV_START,
+			       AXP15060_DCDC5_800mV_END,
+			       10000),
+	REGULATOR_LINEAR_RANGE(1140000,
+			       AXP15060_DCDC5_1140mV_START,
+			       AXP15060_DCDC5_1140mV_END,
+			       20000),
+};
+
+static const struct regulator_desc axp15060_regulators[] = {
+	AXP_DESC(AXP15060, DCDC1, "dcdc1", "vin1", 1500, 3400, 100,
+		 AXP15060_DCDC1_V_CTRL, AXP15060_DCDC1_V_CTRL_MASK,
+		 AXP15060_PWR_OUT_CTRL1, AXP15060_PWR_OUT_DCDC1_MASK),
+	AXP_DESC_RANGES(AXP15060, DCDC2, "dcdc2", "vin2",
+			axp15060_dcdc234_ranges, AXP15060_DCDC234_NUM_VOLTAGES,
+			AXP15060_DCDC2_V_CTRL, AXP15060_DCDC2_V_CTRL_MASK,
+			AXP15060_PWR_OUT_CTRL1, AXP15060_PWR_OUT_DCDC2_MASK),
+	AXP_DESC_RANGES(AXP15060, DCDC3, "dcdc3", "vin3",
+			axp15060_dcdc234_ranges, AXP15060_DCDC234_NUM_VOLTAGES,
+			AXP15060_DCDC3_V_CTRL, AXP15060_DCDC3_V_CTRL_MASK,
+			AXP15060_PWR_OUT_CTRL1, AXP15060_PWR_OUT_DCDC3_MASK),
+	AXP_DESC_RANGES(AXP15060, DCDC4, "dcdc4", "vin4",
+			axp15060_dcdc234_ranges, AXP15060_DCDC234_NUM_VOLTAGES,
+			AXP15060_DCDC4_V_CTRL, AXP15060_DCDC4_V_CTRL_MASK,
+			AXP15060_PWR_OUT_CTRL1, AXP15060_PWR_OUT_DCDC4_MASK),
+	AXP_DESC_RANGES(AXP15060, DCDC5, "dcdc5", "vin5",
+			axp15060_dcdc5_ranges, AXP15060_DCDC5_NUM_VOLTAGES,
+			AXP15060_DCDC5_V_CTRL, AXP15060_DCDC5_V_CTRL_MASK,
+			AXP15060_PWR_OUT_CTRL1, AXP15060_PWR_OUT_DCDC5_MASK),
+	AXP_DESC(AXP15060, DCDC6, "dcdc6", "vin6", 500, 3400, 100,
+		 AXP15060_DCDC6_V_CTRL, AXP15060_DCDC6_V_CTRL_MASK,
+		 AXP15060_PWR_OUT_CTRL1, AXP15060_PWR_OUT_DCDC6_MASK),
+	AXP_DESC(AXP15060, ALDO1, "aldo1", "aldoin", 700, 3300, 100,
+		 AXP15060_ALDO1_V_CTRL, AXP15060_ALDO1_V_CTRL_MASK,
+		 AXP15060_PWR_OUT_CTRL2, AXP15060_PWR_OUT_ALDO1_MASK),
+	AXP_DESC(AXP15060, ALDO2, "aldo2", "aldoin", 700, 3300, 100,
+		 AXP15060_ALDO2_V_CTRL, AXP15060_ALDO2_V_CTRL_MASK,
+		 AXP15060_PWR_OUT_CTRL2, AXP15060_PWR_OUT_ALDO2_MASK),
+	AXP_DESC(AXP15060, ALDO3, "aldo3", "aldoin", 700, 3300, 100,
+		 AXP15060_ALDO3_V_CTRL, AXP15060_ALDO3_V_CTRL_MASK,
+		 AXP15060_PWR_OUT_CTRL2, AXP15060_PWR_OUT_ALDO3_MASK),
+	AXP_DESC(AXP15060, ALDO4, "aldo4", "aldoin", 700, 3300, 100,
+		 AXP15060_ALDO4_V_CTRL, AXP15060_ALDO4_V_CTRL_MASK,
+		 AXP15060_PWR_OUT_CTRL2, AXP15060_PWR_OUT_ALDO4_MASK),
+	AXP_DESC(AXP15060, ALDO5, "aldo5", "aldoin", 700, 3300, 100,
+		 AXP15060_ALDO5_V_CTRL, AXP15060_ALDO5_V_CTRL_MASK,
+		 AXP15060_PWR_OUT_CTRL2, AXP15060_PWR_OUT_ALDO5_MASK),
+	AXP_DESC(AXP15060, BLDO1, "bldo1", "bldoin", 700, 3300, 100,
+		 AXP15060_BLDO1_V_CTRL, AXP15060_BLDO1_V_CTRL_MASK,
+		 AXP15060_PWR_OUT_CTRL2, AXP15060_PWR_OUT_BLDO1_MASK),
+	AXP_DESC(AXP15060, BLDO2, "bldo2", "bldoin", 700, 3300, 100,
+		 AXP15060_BLDO2_V_CTRL, AXP15060_BLDO2_V_CTRL_MASK,
+		 AXP15060_PWR_OUT_CTRL2, AXP15060_PWR_OUT_BLDO2_MASK),
+	AXP_DESC(AXP15060, BLDO3, "bldo3", "bldoin", 700, 3300, 100,
+		 AXP15060_BLDO3_V_CTRL, AXP15060_BLDO3_V_CTRL_MASK,
+		 AXP15060_PWR_OUT_CTRL2, AXP15060_PWR_OUT_BLDO3_MASK),
+	AXP_DESC(AXP15060, BLDO4, "bldo4", "bldoin", 700, 3300, 100,
+		 AXP15060_BLDO4_V_CTRL, AXP15060_BLDO4_V_CTRL_MASK,
+		 AXP15060_PWR_OUT_CTRL3, AXP15060_PWR_OUT_BLDO4_MASK),
+	AXP_DESC(AXP15060, BLDO5, "bldo5", "bldoin", 700, 3300, 100,
+		 AXP15060_BLDO5_V_CTRL, AXP15060_BLDO5_V_CTRL_MASK,
+		 AXP15060_PWR_OUT_CTRL3, AXP15060_PWR_OUT_BLDO5_MASK),
+	AXP_DESC(AXP15060, CLDO1, "cldo1", "cldoin", 700, 3300, 100,
+		 AXP15060_CLDO1_V_CTRL, AXP15060_CLDO1_V_CTRL_MASK,
+		 AXP15060_PWR_OUT_CTRL3, AXP15060_PWR_OUT_CLDO1_MASK),
+	AXP_DESC(AXP15060, CLDO2, "cldo2", "cldoin", 700, 3300, 100,
+		 AXP15060_CLDO2_V_CTRL, AXP15060_CLDO2_V_CTRL_MASK,
+		 AXP15060_PWR_OUT_CTRL3, AXP15060_PWR_OUT_CLDO2_MASK),
+	AXP_DESC(AXP15060, CLDO3, "cldo3", "cldoin", 700, 3300, 100,
+		 AXP15060_CLDO3_V_CTRL, AXP15060_CLDO3_V_CTRL_MASK,
+		 AXP15060_PWR_OUT_CTRL3, AXP15060_PWR_OUT_CLDO3_MASK),
+	AXP_DESC(AXP15060, CLDO4, "cldo4", "cldoin", 700, 4200, 100,
+		 AXP15060_CLDO4_V_CTRL, AXP15060_CLDO4_V_CTRL_MASK,
+		 AXP15060_PWR_OUT_CTRL3, AXP15060_PWR_OUT_CLDO4_MASK),
+	AXP_DESC(AXP15060, CPUSLDO, "cpusldo", NULL, 700, 1400, 50,
+		 AXP15060_CPUSLDO_V_CTRL, AXP15060_CPUSLDO_V_CTRL_MASK,
+		 AXP15060_PWR_OUT_CTRL3, AXP15060_PWR_OUT_CPUSLDO_MASK),
+	/* Supply comes from DCDC5 */
+	AXP_DESC_SW(AXP15060, SW, "swout", NULL,
+		    AXP15060_PWR_OUT_CTRL3, AXP15060_PWR_OUT_SW_MASK),
+	/* Supply comes from DCDC1 */
+	AXP_DESC_FIXED(AXP15060, RTC_LDO, "rtc-ldo", NULL, 1800),
+	/* Supply comes from ALDO1 */
+};
+
 static int axp20x_set_dcdc_freq(struct platform_device *pdev, u32 dcdcfreq)
 {
 	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
@@ -1145,6 +1311,15 @@ static int axp20x_set_dcdc_workmode(struct regulator_dev *rdev, int id, u32 work
 		workmode <<= id - AXP813_DCDC1;
 		break;
 
+	case AXP15060_ID:
+		reg = AXP15060_DCDC_MODE_CTRL2;
+		if (id < AXP15060_DCDC1 || id > AXP15060_DCDC6)
+			return -EINVAL;
+
+		mask = AXP22X_WORKMODE_DCDCX_MASK(id - AXP15060_DCDC1);
+		workmode <<= id - AXP15060_DCDC1;
+		break;
+
 	default:
 		/* should not happen */
 		WARN_ON(1);
@@ -1164,7 +1339,7 @@ static bool axp20x_is_polyphase_slave(struct axp20x_dev *axp20x, int id)
 
 	/*
 	 * Currently in our supported AXP variants, only AXP803, AXP806,
-	 * and AXP813 have polyphase regulators.
+	 * AXP813 and AXP15060 have polyphase regulators.
 	 */
 	switch (axp20x->variant) {
 	case AXP803_ID:
@@ -1196,6 +1371,17 @@ static bool axp20x_is_polyphase_slave(struct axp20x_dev *axp20x, int id)
 		}
 		break;
 
+	case AXP15060_ID:
+		regmap_read(axp20x->regmap, AXP15060_DCDC_MODE_CTRL1, &reg);
+
+		switch (id) {
+		case AXP15060_DCDC3:
+			return !!(reg & AXP15060_DCDC23_POLYPHASE_DUAL_MASK);
+		case AXP15060_DCDC6:
+			return !!(reg & AXP15060_DCDC46_POLYPHASE_DUAL_MASK);
+		}
+		break;
+
 	default:
 		return false;
 	}
@@ -1217,6 +1403,7 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 	u32 workmode;
 	const char *dcdc1_name = axp22x_regulators[AXP22X_DCDC1].name;
 	const char *dcdc5_name = axp22x_regulators[AXP22X_DCDC5].name;
+	const char *aldo1_name = axp15060_regulators[AXP15060_ALDO1].name;
 	bool drivevbus = false;
 
 	switch (axp20x->variant) {
@@ -1252,6 +1439,10 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 		drivevbus = of_property_read_bool(pdev->dev.parent->of_node,
 						  "x-powers,drive-vbus-en");
 		break;
+	case AXP15060_ID:
+		regulators = axp15060_regulators;
+		nregulators = AXP15060_REG_ID_MAX;
+		break;
 	default:
 		dev_err(&pdev->dev, "Unsupported AXP variant: %ld\n",
 			axp20x->variant);
@@ -1278,8 +1469,9 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 			continue;
 
 		/*
-		 * Regulators DC1SW and DC5LDO are connected internally,
-		 * so we have to handle their supply names separately.
+		 * Regulators DC1SW, DC5LDO and RTCLDO on AXP15060 are
+		 * connected internally, so we have to handle their supply
+		 * names separately.
 		 *
 		 * We always register the regulators in proper sequence,
 		 * so the supply names are correctly read. See the last
@@ -1288,7 +1480,8 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 		 */
 		if ((regulators == axp22x_regulators && i == AXP22X_DC1SW) ||
 		    (regulators == axp803_regulators && i == AXP803_DC1SW) ||
-		    (regulators == axp809_regulators && i == AXP809_DC1SW)) {
+			(regulators == axp809_regulators && i == AXP809_DC1SW) ||
+		    (regulators == axp15060_regulators && i == AXP15060_SW)) {
 			new_desc = devm_kzalloc(&pdev->dev, sizeof(*desc),
 						GFP_KERNEL);
 			if (!new_desc)
@@ -1300,7 +1493,8 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 		}
 
 		if ((regulators == axp22x_regulators && i == AXP22X_DC5LDO) ||
-		    (regulators == axp809_regulators && i == AXP809_DC5LDO)) {
+			(regulators == axp809_regulators && i == AXP809_DC5LDO) ||
+		    (regulators == axp15060_regulators && i == AXP15060_CPUSLDO)) {
 			new_desc = devm_kzalloc(&pdev->dev, sizeof(*desc),
 						GFP_KERNEL);
 			if (!new_desc)
@@ -1311,6 +1505,18 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 			desc = new_desc;
 		}
 
+
+		if (regulators == axp15060_regulators && i == AXP15060_RTC_LDO) {
+			new_desc = devm_kzalloc(&pdev->dev, sizeof(*desc),
+						GFP_KERNEL);
+			if (!new_desc)
+				return -ENOMEM;
+
+			*new_desc = regulators[i];
+			new_desc->supply_name = aldo1_name;
+			desc = new_desc;
+		}
+
 		rdev = devm_regulator_register(&pdev->dev, desc, &config);
 		if (IS_ERR(rdev)) {
 			dev_err(&pdev->dev, "Failed to register %s\n",
@@ -1329,19 +1535,26 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 		}
 
 		/*
-		 * Save AXP22X DCDC1 / DCDC5 regulator names for later.
+		 * Save AXP22X DCDC1 / DCDC5 / AXP15060 ALDO1 regulator names for later.
 		 */
 		if ((regulators == axp22x_regulators && i == AXP22X_DCDC1) ||
-		    (regulators == axp809_regulators && i == AXP809_DCDC1))
+		    (regulators == axp809_regulators && i == AXP809_DCDC1) ||
+			(regulators == axp15060_regulators && i == AXP15060_DCDC1))
 			of_property_read_string(rdev->dev.of_node,
 						"regulator-name",
 						&dcdc1_name);
 
 		if ((regulators == axp22x_regulators && i == AXP22X_DCDC5) ||
-		    (regulators == axp809_regulators && i == AXP809_DCDC5))
+		    (regulators == axp809_regulators && i == AXP809_DCDC5) ||
+			(regulators == axp15060_regulators && i == AXP15060_DCDC5))
 			of_property_read_string(rdev->dev.of_node,
 						"regulator-name",
 						&dcdc5_name);
+
+		if (regulators == axp15060_regulators && i == AXP15060_ALDO1)
+			of_property_read_string(rdev->dev.of_node,
+						"regulator-name",
+						&aldo1_name);
 	}
 
 	if (drivevbus) {
-- 
2.25.1

