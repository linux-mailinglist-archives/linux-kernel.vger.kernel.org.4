Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FC66E433D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 11:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjDQJHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 05:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbjDQJHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 05:07:00 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2054.outbound.protection.outlook.com [40.92.99.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3051B5584;
        Mon, 17 Apr 2023 02:06:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WtgMcJSkT1qZ82Dl6C+mct9ZeM7igkW6nGnqLATB/7p5X4bsr/9Qc+bpyzBjHes2Ol+yWCgMYyMEgeld8VnsUJ3tNdHVynkBE3zvOhhtAbO4NrGD/5PlAJycFHpl9KTqFILIZQllykuhTBRjLtXKGi8kMZVvZZu/cl0v6JY8njw//dliQnPD7T8yU3HSCIt2dniDEw14Kr8h8wRqPRtz19w9fg5ovdgv0Nxe/T11wEv7AOZKIPsKLUrWrHhrKJRvAx47ilSEbvqsujE/kg8I1XjvtGnu9Akk7sbYqmlDtEM3miIFoGgvh3q062qFE0+yDlW/kyQWO4ACdwmJjyC0+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/22ufS/qvDUYfCceEmnslgdVpQWEsprf4PI67BIsA5I=;
 b=BnW4wN6aNw1QuzdEkZucJLnvw4CwtImWkch8H3FHikFw8osMKe/wstEhXYUWWF4+h8Wf9UQmHI3jentj0PJcTcDlGK3FHEkirX8F7rmMc4ZGNhtzNPd2pBrp2iEcXTCFT0khcFb8kw2Bu3d1TwfkJizkFCstbmqFv80+9TANZamfft64Vqvp3vT/ZUrYwhz8K3WN+JZ8tol9/SrnkSuPeyroI0BrhJOYPzDgs3rhUnWF3KjfqmiF8f41LVskHd/p9zuH5oCoJ6j/z+55UfcbItPCpn/6EQ40bk3Nz9rg3aW367rdRJlUa4kuDUZnzswk+j3aUitmgMDR/if4c1rseg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/22ufS/qvDUYfCceEmnslgdVpQWEsprf4PI67BIsA5I=;
 b=ELTbcy8XzHJhSXLHpx9QRyruBRK95RHVf+Qw5zEPHRb5dN6OweYNsWEVnR0CL0B0MF2f6ld7eV0DVhj1aBSqLIWV9eO5hMeRXhE578m/yFXLSkoOFwSSlM0QBBXF/KmE1X0xbP6h0X6RlhO1CZgCf2QBC8twDH5k+PhqEgpJB2GkzTR2oo9JTM1WnLqR/Tb4S7bl4WyF9pRuaQv4Bvdu/RSWB/j3/rEwZsXr1dQ3FwMDpAmgPg6orHYlndIfeBwD+7HkAYCMwCrPy6+v9R4qFjQs7JghUTsSqPDHumyopfFhLz52qoyxFv5TFVcElD/cbL9eFZJ33PWttZmIu0iDFg==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
 by TYWP286MB1989.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:166::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 09:06:43 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d190:6e4d:5a1e:59a]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d190:6e4d:5a1e:59a%3]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 09:06:43 +0000
From:   Shengyu Qu <wiagn233@outlook.com>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        lgirdwood@gmail.com, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v2 3/4] regulator: axp20x: Add AXP15060 support
Date:   Mon, 17 Apr 2023 17:05:37 +0800
Message-ID: <TY3P286MB2611EE20495B83FFB626F08F989C9@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230417090537.6052-1-wiagn233@outlook.com>
References: <20230417090537.6052-1-wiagn233@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [1b+leUVg6oh8ZEjOFK96CTAerfAj0NEj]
X-ClientProxiedBy: SG2PR02CA0074.apcprd02.prod.outlook.com
 (2603:1096:4:90::14) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:252::12)
X-Microsoft-Original-Message-ID: <20230417090537.6052-4-wiagn233@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYWP286MB1989:EE_
X-MS-Office365-Filtering-Correlation-Id: 97c39ab3-e475-4788-240c-08db3f230ff0
X-MS-Exchange-SLBlob-MailProps: EgT5Wr3QDKx/5wRYKwbtF7hqq2E99L18W8u+x1QHBaaSOGvd20005FDhVH//kCPEVl5qRcM39tCIe07ui8X66Fn8B/J0c58qUDF4kqdyjnHxwpE2u2bkdjCPTeha9SXDIZP1fRhuvI29m3PQ7mF+ZzJmVbS3MTcpfQOKMYG+68j4WI4KZLA0fxJ6QZPlYrI3Zp3w0fHlH37ou+OSYKm81JMD7vUziKN4Chk0xUthBJcP6FGTNUmzoILMsL2c4Zp+DwSIoUhHEmLb/FE5R+Wiggwch0aOa6MuYPfJ81Rq2Ia8BIQEOTpPQqGnElMyqK9cr3PCcxEziGJec2LUZs+9BDDCM1JmnJsuCy3vKnSmhWtnk1kGWjV+jsPUFgWI0vLIzDlWh4861EQnRub1Twq7gnGjGLzPH5Alh8q2umf4OpKNaKv1kvYDyxZvNqsd6Hw/R4hx34/u2xvheGLMtYtearqKj4cxXdLgWh7UCRw5g01+ViQvg2+JXdrILCrIDP0gojUDNsaY0Ec7NS74a6vdf9RAmc/7Tu9Q/CJPldAy6TOjLC4lg08F9IPLSfOG62KPkBfCozrSwBX1DUssnhSeswTmjNbWLAwyeG1ba2IZqa2ArA+0u4Md3G+OgHu8gCWI+SuWgIhJ5C5OuPf99uYR+fsPt7a5YsLCvUbxyO6FsivZQyEsGDw8CUF3BnwSZePhQZYk544zmGxUl04kqFMKDt/gwqIXuGOvdVhqDEwPebc=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Gvt3rkZ1kvmRedcRVZCNP1YqrGIKT1Hyk6mloxq1PT1YdG/1TDqdLua69qJoLbbbHe3eEc80TBZgWguPyoBHHY8y4NIiqIDLcUqvy77jLzSDYcBemCiOKe6rkiGbEdZhzSkqRhe7rbo1Mh5DXeMs9XNKy7RahG/zX+OYVcahK4tqEA/Nc6QCAuLO1FA5WEeHRSmX5p+z0eZtx2sA+V8znWShTzGExIFMxSQ3fDXHU/raL0cjXDi9V6pDECec12F+olPluv0GuAFhsLy+fQP6xpRhnJOT5FvEBhz0mQ6Dcv6L0OOHcKAqCwZAAmsuyURoXrKKr2nW2ZwxHCWAuiqdjfFcriYcZd8XOUPn32GN3NPtvUxWppo5bsXS/HuaGcNeEAYX4+XX6VyJfO+te6lKO4ueGWLZtFwbX7GxAT0o7C1A/hJM/g6qxyWF+/FAsb/7oLLbmWTn7Dj5VuO2imlpzJofB7Xglv5m7xEOjan7lbaBkKR8txYCuRyGPedcBp0ISGUJ/hpymZJoWO4HruztuOheV7p+8wvkKdsrs+aEjqF2E3vDIETAfuxc7RQElDmo0hh9q2goyUeNSEPjDsPkWScUKiUUuaunIa3P4fnET10zpPfkTAWqUkNei3AmZJ9
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iRVh5ORRMMwNzaZQaMs+qBTrWmAZ9asqn36Nu4A+O2o1x+d6XAZrjuERvQQ5?=
 =?us-ascii?Q?JDbP4scGGf/6KIHrXHgP+/zngCsR/7+OOSaLT6dgzYEuGCOm2DuzFL0KUVPj?=
 =?us-ascii?Q?+BSjnVDbY0dqSC86VNLrwFD4wg+7VldlO0rJrvkDKSwA+1xcQZToXQYOlbRM?=
 =?us-ascii?Q?U2x7jZ5CJPiEMDLahrp27bYaJI74gBPqjVq2Pk5MSR0CFafUTXEgCyoy11NB?=
 =?us-ascii?Q?fbjr7wIy4e7xL5tVYmGBrRotvrtvhp954Fu/lVfSW2GDvI6oFqZOEHU/4iTG?=
 =?us-ascii?Q?hXyHMoy5Q9t8UvH+V9fQ+qFsDLhwiOnY2h/9NROOr0sXLnkFO7E++pNrJUVr?=
 =?us-ascii?Q?xwyoLUM2GlBFYtYRL43ZI5xW9QT4J871MvvK9VaMnAxBchmaz5z1JrxACDYK?=
 =?us-ascii?Q?Ud4ZqovcwU2NXNs6eoLf/0P7FBU4O1JjDld4DmQ4Nh9EmQZ4xMN4Lo8/L0Qm?=
 =?us-ascii?Q?1ddRZSy/R8Sl2F0Qa3HqHmEd5aGi/alLhYB4dMPO7KlVRYUm+/rCRPJVV5t6?=
 =?us-ascii?Q?mxlZNaRq6gOBaiUagD+1H9LLIDaOkwcqFrji/KEBV2x5Umpf15jjLcn3b1gl?=
 =?us-ascii?Q?tAiQnogzpXeQpHWIR0ihCZBQjIlC+qfv5DQn8kppSsdK2Tpd5LV4u8M6W6GP?=
 =?us-ascii?Q?JZBcKf2OFtJRt8jlaTbytcrU/mbpjiSfASMc9/B2GKPFfpJaehtRo1+aM41I?=
 =?us-ascii?Q?J2FdKwYSwTRe3QZiCnVWnSfqTJ0CXfR1/TJCox/MULY0XHI7HbLiXwzJXpXl?=
 =?us-ascii?Q?o4shieoKgfyOa9YkZU5s6rFpw+LPejLHuBR/gQojpTUTh3Tb+a9nXGXgbeEV?=
 =?us-ascii?Q?FlAiIKqy5LBYiMrUPdXhccfx97HccOlJFp1dIcYx098svTHZD41Ljcv+5XVE?=
 =?us-ascii?Q?B4PZgeyfNCoGBfCso93MksUuIY5QpChZb5cIXqgK6a7nLMk4p3+XaB96NMqz?=
 =?us-ascii?Q?O4Wye9eWR5buGQThFzCzEiHdStIdCoJBBg+hv9HQjqVRq06gKRLxzO3cxw/O?=
 =?us-ascii?Q?izpRoJAdHRn5+BSnDXMMeZoF4BoXdKG4HVrqrBmD/64Lv/PQUk4LgCJbPTNQ?=
 =?us-ascii?Q?CSBbJUFUafI03bNL22ZIhtku9/ez0qkDUxB4+aCWDZqQ6gOY5hzUA5kYGSZS?=
 =?us-ascii?Q?rNc0oMeX9R0z7YOteWGgYGnlayOwYK5E+BMcUeqYjVIearY/F/6CI9KLFm6E?=
 =?us-ascii?Q?SrYYlPAyEaCL6fG10s2Og1GkpFtcpoR/YOIvDg=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c39ab3-e475-4788-240c-08db3f230ff0
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 09:06:43.0025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB1989
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

Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
---
 drivers/regulator/axp20x-regulator.c | 229 ++++++++++++++++++++++++++-
 1 file changed, 221 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 943172b19722..a4564d3590aa 100644
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

