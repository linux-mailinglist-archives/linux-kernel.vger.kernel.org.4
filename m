Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007D26DAEC6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 16:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240378AbjDGOUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 10:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240646AbjDGOTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 10:19:13 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2055.outbound.protection.outlook.com [40.92.98.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CEF9ECB;
        Fri,  7 Apr 2023 07:19:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GpxM5wd7l38q2wjM5gV6i3rwXOfdXLr4XCinvAnwrzP2p/D6SUID/V3CSEZluZ9JqHWEzCFdHigPdegayi0vNNv9Az43O8mvci02+aIIcrOPjO0oe2XRjCPXJZPErTSAfcQ3hzAZ2SsIYhGSEb92/hIaejGAq6nJuxf2gQzAZ+nNCe7AQH/WEudH24gYEo6WCtUEwPeiOy5JjqHooTTjGeu2lfteKdinLYkgg3EhQmeK+0702CwJD/mBH8KhRPRKSyhvi404QgmRM7vvCHlApVS9YGmjTeNBG60WqW54hHA8Vd3hfegFuMJme3kCYNTGjM/z7LmMtFm8K1jUItYaKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2TdWHYke2v5W8n2jHOOiQ9APgnE0xKQjcqoJQ/2mT4=;
 b=kcvUSxAqvHMWbpG347VriM3k58U+7sslNp1x+MYFisl5P4tP5zaI8Ug7wekTdSyW9G8NMdI8/ix6tE3LSKc+SPjviTjoujFPMgKj7jFuPAZnily6+BxnBCWDYQsZC7y8m3P0/zTqHG7/xRGGi1XetKi7Unrveid3/iMA8VyIXDs+2XlMe/ydBQ5tvi8rEDqv5TpiAzRUXv3+2RvY0At87UFOmf+FG0+SA8d6QlkjxQn/gzcDqkVPQbPFT2QwvlFOx7vGZ0x2opE4Gd5WXXsIPlboqKpWlPF5XHoi46U+3Y7AS751gaXwWIgcjKBU92/MVal/PbcfhOoGDaX2c2TuWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2TdWHYke2v5W8n2jHOOiQ9APgnE0xKQjcqoJQ/2mT4=;
 b=MpbQaM/JqoABb0ppi77SZxLl+EECSpgcsxh3B43TowxCZhNjZV7bqsKAdaX3mSPs00uVWgFDbGCCR3xb9WzTfyQi+GpY3OgHd093HKh2hKhbXjqff1VktzPxj+o9jhoX0xJm4G2X/Puqm+TJSJfySI7B6KHivUpahunOJ9fXgk6njVLWKL5kXZnEBrtMQr3Ent0v2qIRXVUU5oCa9qsaxsYxdROlSf6m0YsDd+ULMInKpc0dl0cMVBeZ5+v7U9npLewLz8VDzJTo6VzmQs+HJvkEteXcLGXXYC8Ed6OEHx3rCaahw9BAvIDQ+dyVqiTXWM6sOwC1Vj3bIWwiPxAkiQ==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
 by TYCP286MB2638.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:242::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.33; Fri, 7 Apr
 2023 14:19:01 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d190:6e4d:5a1e:59a]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d190:6e4d:5a1e:59a%3]) with mapi id 15.20.6277.033; Fri, 7 Apr 2023
 14:19:01 +0000
From:   Shengyu Qu <wiagn233@outlook.com>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        lgirdwood@gmail.com, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v1 3/4] regulator: axp20x: Add AXP15060 support
Date:   Fri,  7 Apr 2023 22:18:12 +0800
Message-ID: <TY3P286MB26112CE5BB0C66F8B6CA297498969@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230407141813.89-1-wiagn233@outlook.com>
References: <20230407141813.89-1-wiagn233@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [tKyinTsYV9z01Se0oykr5pBXQHWvGpbn]
X-ClientProxiedBy: SJ0PR13CA0083.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::28) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:252::12)
X-Microsoft-Original-Message-ID: <20230407141813.89-4-wiagn233@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYCP286MB2638:EE_
X-MS-Office365-Filtering-Correlation-Id: e88b8c47-a575-4198-2312-08db37730894
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9Xmovywdyt6JbrF6Sw9xOtJae5pVK+uvqGxEGEVNklWX8e9kfgIBfZDO8uZsYza1DSxY6oKRnHMC0+rUy4/lU5W9fhlTmI0zlRo+/u1vLRiKI+PqUGoGFegJD0BPBsWxP4HLT9sYylA8ynZJNJeG+/nWMivVX8m5Wvx4yFjg0lnKu2c2Ib+BLeYSlsE0CCkco6O7tTZw6RRB2FTb+F83k+ZwbvmyS70x+SGE3fnDpBme08U3b7Xx/VU23/mBsnKaPCkNQ2wqZcfUZhYr8hJblADCFWYoyvhJeTVUqaMiutSuXBO1p83K5XCNlBS3A6NEJ0PlDus1Khj7kFBY1/aUibGTcTAX9mwf+HX7jw9fp4DX7gI6UFfYOlNXUlWdOBnUFfc9PP8jyWqw6WYL1zjCX8wya7L+pxttSKJGhMJqJhMhTfKs8zltvR3fLbtLIjb0kHwbOVMU5uvphAvFqi0WUT1XCIdl7HIyqBTOc9+Qc2/vqwWvzyzcWWZsr4t/0eOQsMbAdzC/FEJsFfpGcF2rX/mIhNesCiLRpP0R67Mii42XnXjwnctWKR4yXcyvA9NEsbPP1wbSwHu0c5D+roR1t/VauR+yVWsnyYC7M4Zby1/tnOL1C79nU1NgFAbBg8ywkwtvN88KZtEz7FkY0Fr/WBF2pc/4koJVsowfQ+7M6xU5fEs3ZCF4h106nd+J+zzEGGyy2oRPa3KileM9/m9sRLYqWMuNp7yds+dFHl72NyKOy/B/BnesUSFUY2YvBw3mB9aI=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sn/Gne3gZ0srcbFpHY4ALHKMiW47oLG6j2vTsQtB+cpiielGT7h0b8IdLed3ii91pkSNXcBWs+RIStmGlGfkVFH4ZJQPIG/ZHrqDYyoiDvH9UZ52w4a95J4RGYoCB2G4VekCRUa3iOXeXC5YhApVrCmlS6wVFA8WGIXIAKm7FYE8euJK3jAB46G3PlaGdRYN/vl81CMuiLBQ8lukcvAtjWLXKpIVJD6jGWk7gVDmfdEEpDcD9edgdCuF4FrrSbCnTNMohJgJPEWJCA1Lf28y1s29R0RKWBqH2y91mG78AHlpDFsX8cWd5u3aOU5/IHiDjN8r4xDlUjaCvOEJeb1WlB2Zmuxyx7aJbuUERBsNB5sQAbwvLCu0k3d4zuz7Gzs0kFkXhxom198m7qqOhu6XrjgOdAWxncONACjSJsGz8a/fLhiqr4HbYE7Vw8dpNGpU6kphSqD/lPpjz2XaGwx3OhR3fDbnfzBaLeiE0Fgw/uIPlb9t2Kzzoq0f5rywAaZMjrzSpM17BtkrQvEp3O1VXn/KJI0M2KDc7KhmAPfVd20Ld4MO+TetGXY/h9YKcehqy9IwsbYcbP+GCUbmS1U9nFIW4VLNugsnDEX/5GKOFGCWJieX5v8Vl1OM4Pd9OwXZ
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z2qRlCh1ADv1avt5mLfw7U69fqnJzoTxGndYwJukS+QBzpR4eceVlnh1hBff?=
 =?us-ascii?Q?iQM6b+5dvdV6renvxnXgEV531EGRDrstqAt7dLfksLBma/RQZxQm9lc43i/q?=
 =?us-ascii?Q?f/6urV10VfAJGfyKDl0J4kd1qjWFzQT82uMkzQ+j1H/LkBm5zB9P06tlaEMk?=
 =?us-ascii?Q?/hdREDuP4hfgFuHn+pGaLEWfZ0n8bPhlWllu0e4sa0kBBrxf6tgiZpN9JLac?=
 =?us-ascii?Q?lunj98oX1LXl4rsxCpycOJ4t8VyAECB95Fq0JApRepSI2Q9DVAKe+PwG01LU?=
 =?us-ascii?Q?eRk5Rx8cNUP4Y57ZTNS3jg1T5BHSHcxvTZuyS+ty7+zOqR7Tub32an4Mn7qZ?=
 =?us-ascii?Q?VSd3nodOVjLI4hTvKIGm4FDDzm+Mji5snAn13C7B3gjPYj82mukOm33KgwJ5?=
 =?us-ascii?Q?1qSgyLyQFHTxZT/s8d+Vu/KVlWvt+36XD9096wz7DHUfMhTOFKdwIyKpFqkY?=
 =?us-ascii?Q?E4uZeGkorm5Qv+AKNaRRaLCVpjVH1Rh5UMrnbbshZDHPjrXuJxzIZ+U7tCdv?=
 =?us-ascii?Q?hpSocVck8edVrcHWvA0FdjqEi0OnIYObm1SdO3Ym3Gc4t/SF9MasP61LcEq6?=
 =?us-ascii?Q?7LVBQQOz/XUwNvQ/5ThGT1lF5McAgHvAouOTH12gKq4vkxizjLpcYeFHvPD5?=
 =?us-ascii?Q?jnHWf/iebwDWIIzDRg8vYCXWHTqLGFvH4cWvlU43sWQGWkR3ve78c+n390n0?=
 =?us-ascii?Q?teKO1jnd8eoswi7i5V4G9j6RVpyBnwUm6IQqBWQJAkwCwn39NJp+UY8pbAjB?=
 =?us-ascii?Q?ZtabYDzlkvpqx84JvQnuaN/26NmeXyE7OBO7jmpN/FOF2cjwFetx/M62GHpk?=
 =?us-ascii?Q?UojYr5NALnz1c22deL4jWoxfRxwe9cOm4jck9UImbO9OzsZxfCtVoDZVtd8D?=
 =?us-ascii?Q?ML1nPiv7bDR0bgwj2YzrCsLayE2zOFrvjSXF3WWx5Wwp7iBMHLRqAeu1Nh6O?=
 =?us-ascii?Q?vuAxDb9SM32kCHXITH1zTOFyj8RvqgU+hM+fO4DATCxahKqLYWh3PNebD/Xb?=
 =?us-ascii?Q?f398P8NHLy3KmMp8OEA5Gn+1L2mQsq51Yx+x/OCOfecXpnJjZNA39nCoQGVp?=
 =?us-ascii?Q?OAzYpJjYi2RJPZIq9NJtJ3g2cMWgLHfPoulMXbdXHQU1kKA8h9g6Gp01swjH?=
 =?us-ascii?Q?t4E6ZGI4/n592kHpM01i4C0qjDsmIh6o1ZluGhdUX2E5ot1Bd84Os9pCSvTH?=
 =?us-ascii?Q?O5frRLa+9/p5S6gW6IlrSIo8DvKZy/hwOidTbQ=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e88b8c47-a575-4198-2312-08db37730894
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2023 14:19:01.0582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2638
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

The RTCLDO is fixed, and cannot even be turned on or off. On top of
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

