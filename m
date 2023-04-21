Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E34D6EADC1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 17:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbjDUPJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 11:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbjDUPJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 11:09:18 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2012.outbound.protection.outlook.com [40.92.98.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259D51026E;
        Fri, 21 Apr 2023 08:09:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WRSJZBwIIYTS9tuKN31s9UbEhy2bZN2Yrk5AifporQS16XUSK7lqwvkQnk+GmnkzHsIO3xMGBQJdHDyyLCbLPNzD2e924Kwg8+L49SSF8QljvFXrfzKRfbq9Fp53/jdukI6lUj7BSCQ1BmYa5kGaYSpbdqp00RwGIGPz31qEJMqrfx7INWngmZ2uYQYRCxcLR4AZHASkePuMON647r2UWL1CN3kXw/xEjS6BKoLNbziIMCGKT4UL0wefT0z3LGP1xKSrNAlk6G0LNvm6q8otWsi36TwM3SGpNwB30NOBzz2Ace8MP07wXnypdy7vioXXmnXThufwwK1Y00L7C5Q2fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8FK0/o0BukHH5xH8dxH8DtsRSWqIjjb24jxMKUreSw=;
 b=CLvpmQm3hy4et/XlwSsxfiIltpq3YEN+PzfpiQQgabjxK0MpVKeaMUxSRTEjpv3JgD4TCQOhmhTpyOpz1d3lULBJDjhrCAt+om24O/FgETOUCmeuKH+60xt3fXeJ691U/Ul4DPe+lA5f1PTMdPNFAEmjdr4sY16QeIjOMv+l2fkTO9rKYvRD5kRnjrfjxKDjdVDfNAU/8B2aMDTMcj4YIV1reqExM6W7w/4VO1pIyOssiT7LOxA3ynaJVkEbsCDGn5QP7CVzRqN1LfU99HW7za1yE/HNLx9pwrPRbaVW3HoPM0Syc86cbjl4RN3J5NLhAcfjc60FsJUs+SsBIUpWIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8FK0/o0BukHH5xH8dxH8DtsRSWqIjjb24jxMKUreSw=;
 b=PLvTvqa35bxZena8iHPrG/T5Tyau3KqK+eXsPogjunsKewhG6jRuAMzUV2267IKZa8MfAYKtYXQPLTnA08fSRUWAqxJVxDw5Z2uouu/CyaBJpD/hQ46+ZLXtQnc/T5tUqpBpyw5+1YxjBub5wq+PqDMRnPI8K+8wALs2GIcjlAOOAQgcvIlx6uBBs1JW0QG3kIQV1f3B8bz5Vaiwpp8AYFy+xvMXXvn03qreYLjba0tL5DWKsyDQsQRm5yf1aYoJQWWn2cufASiU1EpxgdeQW1A4TJ3M0g4oiVwwjNLAQl5Htcoxcc3by1OlE4WJcxPF3ciaoqW6oYlu/75KwMSL1A==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
 by TY3P286MB3505.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3b5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.21; Fri, 21 Apr
 2023 15:09:11 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::5805:16d6:6ab7:6639]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::5805:16d6:6ab7:6639%2]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 15:09:11 +0000
From:   Shengyu Qu <wiagn233@outlook.com>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        lgirdwood@gmail.com, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     andre.przywara@arm.com, conor.dooley@microchip.com,
        Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v3 3/3] regulator: axp20x: Add AXP15060 support
Date:   Fri, 21 Apr 2023 23:08:16 +0800
Message-ID: <TY3P286MB2611DA5F918F90491A3AA02298609@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230421150816.10513-1-wiagn233@outlook.com>
References: <20230421150816.10513-1-wiagn233@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [hStA5CjFHDsjUpQCSQEIsAZ+qLtgKuGm]
X-ClientProxiedBy: SJ0PR13CA0168.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::23) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:252::12)
X-Microsoft-Original-Message-ID: <20230421150816.10513-4-wiagn233@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TY3P286MB3505:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c082256-4fa0-46b5-8746-08db427a5c51
X-MS-Exchange-SLBlob-MailProps: YfhX3sd/0TVMxuI8J5UzJ6wcIdkd2x4k4GN9QB/q6lH9gmaSl85ShCKjJOpHTVwwLur/KXi5bUKflK4CPkdBDPRoG6GwBHgIRZiaSW1MFqZGwNyEGKTfAAaTdmB2pAIm8VCMkAgmb5pOf5wK4SMTIzhSvPdBvuul1NMSKH3jy3GUouE7aHHSe0zefAwpkS5Ut/pcOe4Ew6Qb57EdkLJTfSofc0zFeuze+zNtwx7OyUEWqMRrSqG9z9MjVqFhpirBuNeqVCCzLakmKs1tPnSc+lhZPjINNuaaFvLeAS5sBEyl4rG8wfGk9BGrbY2t7PE55UlZVcgURmVUDJ6EsahAzX66SnU/v2/ajGNLvDa3C+Ynqe4JTjXj2rXIlVy0P8u8EJi5QvOBolfYqdFKn6iQXGTF9gETifpVnSqCWzucEqr8D73RNdK+hGmXfl3Bx8QrumDKfExq2/GOb7xGho1JK3nY3zOVvjvnGFOJRbf3dZ4uqZetiWMfz3tE6OPsjHQrK78iiLgr0evOqg1uT6Ap3c/7iSGykxIoe4O/qpT6IBPG5hq61gswYpHp2LGQ7a/uvzo82Pku09Ygz0uUpZJR2K1OPIcZMYB0YLQyyc4I7rYzwcldmA3AudXa4GABj3Tu/lYXlwnRf/Bw5pTzFMnJvS26SeAw79+WFlSJiCo6NjxzlVKBaiYYhaSsp599quqHqI/+hmm+dzfpkS7KYrnGgNvp0pikARsoose3YZbwxd7lUCd+QpB4EziFquEQMSEu2FHJDgv9N+fKFwvQ/cLutiCDzALwmldtU9RW7BTH1ow=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g+qEid9M/868h++aCtTOX5meEnp9iCOvqGfzKbhUFENEhFh/fDSUJEe3cmSw/c68BrLpCw3T11nJYWjjHTC2fLyaU5xC2RTLgGjEhfqllfV87MsKUlEdEIGGWn+YVZ9SDJwa9902EyCIo+rN5KpprdyvWVjQoNlLnvdxxXSF+fxAxOw2pt6CwOY85FTcxYKvgE69ERUr3eORQcBn3UNj1/AwhX0/RBvQKKpO6V4qmEgaJSpMNr0ht9qYL7KH1eIlBoT2s2C37XV+OHYm8bBD/7gnxmGyb29jTYPjN/u5O4WD2zeeKXqr3RUoMGXsOT5cv4sdbvT0t3f2fwiSZ/KmeUesd8Fm+jOGLbVd5cs6LY0bqsCkKOpFB48l/TRsdn1DEB7VuRNyt+BmDVQFMupJixx5cI9+VRF/U7jUF2udJBQoTeUNRqtTmY081RMBX6YUXP3qy1DhjqInTh5reYkT4hQ+gOcogQhqqT58yUAHWN1jpO3+guK31VF7xNVCL8KxbPG5azjpcIUXqWNpxjEYrbmr8AfzpOabsh7ZW0HsWCGTHv1RCB2QjWaDyvJnttKL15UL22krQA4VWHsFaOQZmxYg8u+sgtXio5zeZnq0lz0=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?byISEGHOOtz3ZjsDUK7dEQB2QJTHjbTYV/vKRMhA0fvtRtS87SteGvbBKe7D?=
 =?us-ascii?Q?WhHX8UxwyWlpEXlXix8IHkBVO1lNf4s93aW6FZnieVu4/r3j5ChERz0jSgl8?=
 =?us-ascii?Q?fo6VNVHwR0Yf0ib1+nXtLfO88KAjOXcrXrhVxUj5v0/skhZvuI8SwpOxL76A?=
 =?us-ascii?Q?4nJFCNGZqTVb5GRkY5QUdPVU6vkLsO1rPsJ4PF4HqC/KKrlvA4zzhbTnKtdo?=
 =?us-ascii?Q?stdcrSDHfWA6BVLU5/A1YGDu1MbRhxA5uWKg3ZO5hkrPHBs1eGLut0rGGp3N?=
 =?us-ascii?Q?Ifa9DrDhs4P3UrNZt2x7NImGdlWZT+ZhtciLomr0K42hg4v9WvzXZ2vMmKih?=
 =?us-ascii?Q?WPiSGOfJuHlPWlcKZWOgafqkVNfAezBpf8EyAlQjSJIrQSlWg61BRJdZSq4s?=
 =?us-ascii?Q?r6bnxTD+AHBrR/A+nHG0WJG676WuR/zvuOfybP/1WC2yMPSE0GioNuG0nTlz?=
 =?us-ascii?Q?02Uoc32+pKcBDA0YC1bgesINf+OPPbEYBkmUrbyz0J6226l2MCgN8RXRwebL?=
 =?us-ascii?Q?RTbg96gW9Fuhw8G3Fq6haypg6auF2nnulZsoKPiXoH1kp7p92L5J9vOk2HKg?=
 =?us-ascii?Q?6z5jO3to0xM0OvZ4EAzAZvHunwvoJYOKZ1S2pu/R5pgEfIC1A/jYOViFybG5?=
 =?us-ascii?Q?KATVpGas8gDeHBgG7XdmtGYeDcsM6C0lBnyhTeSa//MCp7Sfhldi7evMHBok?=
 =?us-ascii?Q?SRLcgUTQWK4jDlCuhLq3fJgN4/s4r4BrpWeOXTz2IzTkW81FKYZolDQUjLxK?=
 =?us-ascii?Q?QP95vWOxJ3OQUzXGrhbfobQlKgoC1OZGqAPRWwAGk1iBJ8qWRs8Y8qGwaOJo?=
 =?us-ascii?Q?oc7XnZRpNiu0F57Gz4liAs+o5lzIDtYKUu2lAZRdTJurX5cwPSpUoL0MsBWs?=
 =?us-ascii?Q?6h/7ZpEpfxOHuTDc7WnZ2Hh8Tv+obQ7w08sl2FiLfB8TzQxas4w7sJE3dzy2?=
 =?us-ascii?Q?zTbCO54JoH9UvNyNIBGXcY5D5nBL1Q/kS9kNiokrG+zQggkllZWStKtLK4n1?=
 =?us-ascii?Q?kiK32lOxuBJAtLHDzXPnU7wDiEWIFvOaeV1Qwqcn5UL5g4wvGuCodMHbof61?=
 =?us-ascii?Q?KwKPhmzwqIX1stKXiNzLt7sOr79m5cM5xu3/aFd++2e10f4Wp+45VDYKzN2w?=
 =?us-ascii?Q?HA3CCMC1G314v28EArYdFKblFL3H4JnosTh0iJ7D7fbtYTsNQ/MPDWbDAely?=
 =?us-ascii?Q?deB1JeZ88JeLPxImNGCpN93cyZo5YiJtztxUBg=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c082256-4fa0-46b5-8746-08db427a5c51
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 15:09:11.0812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB3505
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AXP15060 is a typical I2C-controlled PMIC, seen on multiple boards
with different default register value. Current driver is tested on
Starfive Visionfive 2.

The RTCLDO is fixed, and cannot even be turned on or off. On top of
that, its voltage is customisable (either 1.8V or 3.3V). We pretend it's
a fixed 1.8V regulator since other AXP driver also do like this. Also,
BSP code ignores this regulator and it's not used according to VF2
schematic.

Describe the AXP15060's voltage settings and switch registers, how the
voltages are encoded, and connect this to the MFD device via its
regulator ID.

---
Changes since v2:
 - Rebase to AXP313a series v10 [1] + newest (20230420) -next branch
 - Fix some whitespace (Andre Przywara)
 - Rename swout to sw to keep up with bindings (Andre Przywara)
 - Add check for setting DC-DC frequency (Andre Przywara)

Changes since v1:
 - Nothing

[1] https://lore.kernel.org/linux-sunxi/20230401001850.4988-1-andre.przywara@arm.com/

Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
---
 drivers/regulator/axp20x-regulator.c | 232 +++++++++++++++++++++++++--
 1 file changed, 223 insertions(+), 9 deletions(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index db77c72d39a0..810f90f3e2a1 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -275,6 +275,74 @@
 
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
@@ -1048,6 +1116,104 @@ static const struct regulator_desc axp813_regulators[] = {
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
+	/* Supply comes from DCDC5 */
+	AXP_DESC(AXP15060, CPUSLDO, "cpusldo", NULL, 700, 1400, 50,
+		 AXP15060_CPUSLDO_V_CTRL, AXP15060_CPUSLDO_V_CTRL_MASK,
+		 AXP15060_PWR_OUT_CTRL3, AXP15060_PWR_OUT_CPUSLDO_MASK),
+	/* Supply comes from DCDC1 */
+	AXP_DESC_SW(AXP15060, SW, "sw", NULL,
+		    AXP15060_PWR_OUT_CTRL3, AXP15060_PWR_OUT_SW_MASK),
+	/* Supply comes from ALDO1 */
+	AXP_DESC_FIXED(AXP15060, RTC_LDO, "rtc-ldo", NULL, 1800),
+};
+
 static int axp20x_set_dcdc_freq(struct platform_device *pdev, u32 dcdcfreq)
 {
 	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
@@ -1088,10 +1254,11 @@ static int axp20x_set_dcdc_freq(struct platform_device *pdev, u32 dcdcfreq)
 		step = 150;
 		break;
 	case AXP313A_ID:
+	case AXP15060_ID:
 		/* The DCDC PWM frequency seems to be fixed to 3 MHz. */
 		if (dcdcfreq != 0) {
 			dev_err(&pdev->dev,
-				"DCDC frequency on AXP313a is fixed to 3 MHz.\n");
+				"DCDC frequency on this PMIC is fixed to 3 MHz.\n");
 			return -EINVAL;
 		}
 
@@ -1201,6 +1368,15 @@ static int axp20x_set_dcdc_workmode(struct regulator_dev *rdev, int id, u32 work
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
@@ -1220,7 +1396,7 @@ static bool axp20x_is_polyphase_slave(struct axp20x_dev *axp20x, int id)
 
 	/*
 	 * Currently in our supported AXP variants, only AXP803, AXP806,
-	 * and AXP813 have polyphase regulators.
+	 * AXP813 and AXP15060 have polyphase regulators.
 	 */
 	switch (axp20x->variant) {
 	case AXP803_ID:
@@ -1252,6 +1428,17 @@ static bool axp20x_is_polyphase_slave(struct axp20x_dev *axp20x, int id)
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
@@ -1273,6 +1460,7 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 	u32 workmode;
 	const char *dcdc1_name = axp22x_regulators[AXP22X_DCDC1].name;
 	const char *dcdc5_name = axp22x_regulators[AXP22X_DCDC5].name;
+	const char *aldo1_name = axp15060_regulators[AXP15060_ALDO1].name;
 	bool drivevbus = false;
 
 	switch (axp20x->variant) {
@@ -1312,6 +1500,10 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
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
@@ -1338,8 +1530,9 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
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
@@ -1348,7 +1541,8 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 		 */
 		if ((regulators == axp22x_regulators && i == AXP22X_DC1SW) ||
 		    (regulators == axp803_regulators && i == AXP803_DC1SW) ||
-		    (regulators == axp809_regulators && i == AXP809_DC1SW)) {
+		    (regulators == axp809_regulators && i == AXP809_DC1SW) ||
+		    (regulators == axp15060_regulators && i == AXP15060_SW)) {
 			new_desc = devm_kzalloc(&pdev->dev, sizeof(*desc),
 						GFP_KERNEL);
 			if (!new_desc)
@@ -1360,7 +1554,8 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 		}
 
 		if ((regulators == axp22x_regulators && i == AXP22X_DC5LDO) ||
-		    (regulators == axp809_regulators && i == AXP809_DC5LDO)) {
+		    (regulators == axp809_regulators && i == AXP809_DC5LDO) ||
+		    (regulators == axp15060_regulators && i == AXP15060_CPUSLDO)) {
 			new_desc = devm_kzalloc(&pdev->dev, sizeof(*desc),
 						GFP_KERNEL);
 			if (!new_desc)
@@ -1371,6 +1566,18 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
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
@@ -1389,19 +1596,26 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 		}
 
 		/*
-		 * Save AXP22X DCDC1 / DCDC5 regulator names for later.
+		 * Save AXP22X DCDC1 / DCDC5 / AXP15060 ALDO1 regulator names for later.
 		 */
 		if ((regulators == axp22x_regulators && i == AXP22X_DCDC1) ||
-		    (regulators == axp809_regulators && i == AXP809_DCDC1))
+		    (regulators == axp809_regulators && i == AXP809_DCDC1) ||
+		    (regulators == axp15060_regulators && i == AXP15060_DCDC1))
 			of_property_read_string(rdev->dev.of_node,
 						"regulator-name",
 						&dcdc1_name);
 
 		if ((regulators == axp22x_regulators && i == AXP22X_DCDC5) ||
-		    (regulators == axp809_regulators && i == AXP809_DCDC5))
+		    (regulators == axp809_regulators && i == AXP809_DCDC5) ||
+		    (regulators == axp15060_regulators && i == AXP15060_DCDC5))
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
2.40.0

