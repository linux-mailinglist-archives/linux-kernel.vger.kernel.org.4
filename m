Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9E370024F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 10:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239781AbjELILe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 04:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239902AbjELIK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 04:10:58 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2132.outbound.protection.outlook.com [40.107.113.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F251156C;
        Fri, 12 May 2023 01:10:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnkVt9rCyRt9iATlqZIsEJ+Aax4yhKR8oaBTv+OHn9LSaF2AS5zqUDsS0UHoQf1AjPOd1Ov1OrC4D+r1YeADgSYsH2aoNpGKids+H1G3O3VEXZqgrlkFUXlcuUkLImyqeDPdUe79toih4LX6qbCB6iruwCvH/SzT/jpS9gK1hiLqiuKtytT6sOaSOrDpTbyMX2qZG/19fVWzVEx02T7UJv4TFkSkZQgQA/Qt9aIXCwAyRN7/Y1HcpDSLpZOcmmOJ+E+6ZHgVLvr0CSO0HsKNJ+eG/WiICBTKPP1K1nPzWfoDbL/sU1/2FIgzIU0xheascYGOLgr0EkUTpbUNTyK8QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JYzzT2Dyw/bgcEmn/be+tg2uPA4kQ28yCeCPAssDGEU=;
 b=W3lJook//xkOWvX/MtE6vVtN0bHy7X1V32Q3/rUQu18FSI7vhfiq12EtKHV54UEnffvTL9hdFwX1VdHtIwIo38POfupdfXD90KFkMBQIVM5W648sAuy54OS3fQ2hAUfZ+EHgG+xX4he9OvYh+U7241VaW3jRAVc2/gMrIlYWN0B4ANot3mNy+2O5Y38clRkYkGUIM+VXBtOjqeRZAXl716iznSpwrFYfIvQeQvkSKPhfE2WZZ55btdwqXyE3sFrB0Fhgv3UyG6HiLz2wiEyCUIaBAKWSudte57RE6LTy9rJ0AIDC1+feC7+kR/bezeqUSEsnWOVMICKynSpz/AeraA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dm.renesas.com; dmarc=pass action=none
 header.from=dm.renesas.com; dkim=pass header.d=dm.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dm.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYzzT2Dyw/bgcEmn/be+tg2uPA4kQ28yCeCPAssDGEU=;
 b=BjNXLa5BRQb4//NGufDbyWKb77tlNKPej8Hou2B+CYZAyYZqrJkZjgQezfda9js18tX4oSY8/Hksy/XAQvX63NQU2lWjCNs/Er+WswvMFfTBQowDTrVlB8kYv16ToTfIO57c9puqLBfbP6PLAfwoMiuIzJNoprYb25MzyKm49xk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dm.renesas.com;
Received: from OS3PR01MB6641.jpnprd01.prod.outlook.com (2603:1096:604:10b::11)
 by TYCPR01MB10680.jpnprd01.prod.outlook.com (2603:1096:400:294::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Fri, 12 May
 2023 08:10:51 +0000
Received: from OS3PR01MB6641.jpnprd01.prod.outlook.com
 ([fe80::2de2:b2ee:d931:157]) by OS3PR01MB6641.jpnprd01.prod.outlook.com
 ([fe80::2de2:b2ee:d931:157%6]) with mapi id 15.20.6387.023; Fri, 12 May 2023
 08:10:51 +0000
From:   David Rau <David.Rau.opensource@dm.renesas.com>
To:     broonie@kernel.org
Cc:     support.opensource@diasemi.com, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        David Rau <David.Rau.opensource@dm.renesas.com>
Subject: [PATCH] ASoC: da7219: Add Jack insertion detection polarity selection
Date:   Fri, 12 May 2023 08:10:30 +0000
Message-Id: <20230512081030.5138-1-David.Rau.opensource@dm.renesas.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0182.apcprd04.prod.outlook.com
 (2603:1096:4:14::20) To OS3PR01MB6641.jpnprd01.prod.outlook.com
 (2603:1096:604:10b::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PR01MB6641:EE_|TYCPR01MB10680:EE_
X-MS-Office365-Filtering-Correlation-Id: 06a8c278-2d62-4f90-b463-08db52c066cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Hf9aNW+5lF5aOOeyG3TFqgJIx0KOyGvJ/AtHLK0nwl3KWyhDB3aQRUZey73J48gAefCvVtAktl5uCfkZf1pldCpkn22DC8gJ/h3K+Wyra36sQb+d/DMjFskYlVS7EyzPTbI9sR/G74EBNdxXRuGEufy/S+vFFq5pLYs1IzHUi3dc2psG1U5N/wbOsBI1k6c0sONck59ECec9lQTZ/tF//ULXMffQHwINKaKnY7GB9atAUECrJr7+pwO4dzE6FvRnhzNaDeRbUFX4fc9VGcbaMHBop6eGCLw1RsLkyDHWc8xDXq6kx1GyOJofABm3EOlirIVH2n2CzudpJlFga0QSlvRICo2Nf4hiNiU90R2VtMotVBfmVqBSts6xv9uFP0OkLG/pS/WQk2wiixtc8q7+6/R8xVqxkY3+Ipf5HMbkVp8yP+f9IcMhdlpJsSJOnq2kKmWwCFmu9qYt6cnKO8cUDJ+0a6SzBuzK63vw3KKSdwJH82h98haZ0ZPMlL84smCfU02nsJnD6+p9jvOKVw7MGpEzBvREOXq37mmMCZH85sz/tKU5Bt8bPXvh1d9a4ooT1XjYx7mEaEiUytP9CpqB5ZFhw2A8O2JPJ2MBNqAFNyhL8/8qL7hUhId2HV78VjE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6641.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(376002)(396003)(346002)(451199021)(103116003)(478600001)(2616005)(1076003)(186003)(6512007)(6506007)(26005)(52116002)(107886003)(6666004)(6486002)(83380400001)(6916009)(66476007)(66946007)(38100700002)(66556008)(38350700002)(5660300002)(4326008)(41300700001)(8936002)(8676002)(316002)(2906002)(7416002)(86362001)(40140700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qx2ddfLuRUfqwgZiOUXjxtseIDShxlQXuhRGPACO7OJSnSXplCdOdgsKNmTx?=
 =?us-ascii?Q?8gVvpP5gl4emSBRyuaQ44L+xA47As6j20+EP7vBR0fBWb/+2DuyuQP6Wb44q?=
 =?us-ascii?Q?J5XLBYxRIqPX4lztqLDJ26hH6Zr+u/PIsSh8ho62aAm0hSEVkzxNJd7aAzbm?=
 =?us-ascii?Q?iGG1c+JDsJrQuLodks+drjSyPd/yOuhEQvKVDkyu6I4Q1XjkYz9dEsDfFmH/?=
 =?us-ascii?Q?XFdmu/XYb0aYPwLsUUhVjz1wl7k5GbPyeE82ps6iu99YhInhoAqyrCLj1Roo?=
 =?us-ascii?Q?yKSN8cFDcbfNe+2pcbMx8KYAM1ayWcDIEDAbecaNiSjswFJeK6D3fZ+w4BMv?=
 =?us-ascii?Q?9pFEkDVJnyIk2jsr4CebnRVwljNNMXiPAAAeiaOW5+cguAb/pZQtF1W0epaE?=
 =?us-ascii?Q?hwO8c8EYzzDZ0Rnen+BB2wyUeWxA+lcsH6uIbKAUXp41firLaPuD3CvK+MGZ?=
 =?us-ascii?Q?/5yRpdTtZN0oDVmLJNzSEAA5ArTlxhOnJh3UuOdKQRJ11+2A9Bg+o7ica9J8?=
 =?us-ascii?Q?5LAjrMEJjFuM3GNlYEzBBhQF1VMk/3etHXThcr5LU1BKqy1F5ps/gspqVClQ?=
 =?us-ascii?Q?fyXeMsLPvCuZZCSJ7LDkKl7DMrIZNyoNpoPOfjtMBgUmNJm5AVIzsBvV8z2n?=
 =?us-ascii?Q?qZx2G63sBMUN8icVsipGaqCREze2bEqmqVtZHsfUclQIUf271VYRni7PZ710?=
 =?us-ascii?Q?bREgO067X+i6i2oZtyqFEOp9kDPGoaCcksRXFiXS89S1gmLQfXbtfXc+KAwi?=
 =?us-ascii?Q?mDzw+WNWIzcpOAhudTsDjVjSYZ9gmOPSRwgEsIyNUsqu4sHvsFtE6UJm2XC9?=
 =?us-ascii?Q?+4AtpzumRmR8WwTfUCBVKEUZHUHDhTX5TL6S70PmdOI8Rs+4FbU0a5l5RZse?=
 =?us-ascii?Q?x3C39knmTBYwPJCnIcWkX+7pNC10+PdDLcb4/lQsBqD34PjT7pnmdwsYHhCY?=
 =?us-ascii?Q?G0DezNdwYlRn7Mtunop8CO2qHTie64LUZ6zUyUxcxwRhGGOZix3sdaD/i/kY?=
 =?us-ascii?Q?n/ka9osOaf6zOwvqmBjviQE1dJk8VQlIH2oGjYzrChMUS07w2hACYkvhMt3v?=
 =?us-ascii?Q?ZSit1jyAmzlUaEQkPkk/nW7sNSQ8kjNABg/sjq32j9N75gzjWSYSvMUiLTQ/?=
 =?us-ascii?Q?VZHRiHYQLMS7+TKiPQn5xmd2gEJIS8o5py66Vz9u+Ul/JiB80I/yWZS6iolf?=
 =?us-ascii?Q?+obow7auPMLtdY1IDAbsajg77wuHNXqw8rPIL0sRkMD67B0yh5j66uO3Yk/k?=
 =?us-ascii?Q?k8PSE/0PrG82r4y4UcbkodAb2dpGykxxyNZ7WAb+QskWtl0mY1Tj1GgY9x/v?=
 =?us-ascii?Q?k6G8CVoblCU3bjCl8FAbzyfm1ea7P+anIL9lKpNsQ8SWZzkhav9o089/iNfO?=
 =?us-ascii?Q?HRkqiuZs6PzqjcGShYqPaGjaa1LYaZV0nYpoylTsMc3nRcKNym3MRKbjp6HL?=
 =?us-ascii?Q?cH606rLVp6brbAPMqDOW4Ho0O/mSxP9qOIbxl/6+pN/BToJVcxTHq4JFNsQE?=
 =?us-ascii?Q?qjXI5dTwiTik1z1eoydFrdRsY4aT0tgkmfMfaLg3pW2522wriyCZfGA8yqKy?=
 =?us-ascii?Q?3UrUN/CRx8shjT1+UiA12yfEXMkLojKn4sBbVF7QaLFuXVyHIsJqCj5op9SE?=
 =?us-ascii?Q?9Q=3D=3D?=
X-OriginatorOrg: dm.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06a8c278-2d62-4f90-b463-08db52c066cb
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6641.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 08:10:51.7386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L2roCBfE/DC9oO3StffIzu95thbWOSxD61mEs2Vlxl8agODO49J9BOFRprmsSxLMTub9e5o6lX3hrf2CMpyOYdaSqD2JGDWXQPWg94WSQjs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10680
X-Spam-Status: No, score=1.0 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DA7219 can support 2 kinds of insertion detection polarity
- Default polarity (Low)
- Inverted polarity (High)

This patch adds support for selecting insertion detection
polarity to the DT binding.

Signed-off-by: David Rau <David.Rau.opensource@dm.renesas.com>
---
 .../devicetree/bindings/sound/da7219.txt      |  3 ++
 include/sound/da7219-aad.h                    |  6 ++++
 sound/soc/codecs/da7219-aad.c                 | 34 +++++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/da7219.txt b/Documentation/devicetree/bindings/sound/da7219.txt
index add1caf26ac2..357d1f61de1d 100644
--- a/Documentation/devicetree/bindings/sound/da7219.txt
+++ b/Documentation/devicetree/bindings/sound/da7219.txt
@@ -52,6 +52,8 @@ Optional properties:
 	[<200>, <500>, <750>, <1000>]
 - dlg,jack-ins-deb : Debounce time for jack insertion (ms)
 	[<5>, <10>, <20>, <50>, <100>, <200>, <500>, <1000>]
+- dlg,jack-ins-det-pty : Polarity for jack insertion detection
+	["low", "high"]
 - dlg,jack-det-rate: Jack type detection latency (3/4 pole)
 	["32ms_64ms", "64ms_128ms", "128ms_256ms", "256ms_512ms"]
 - dlg,jack-rem-deb : Debounce time for jack removal (ms)
@@ -98,6 +100,7 @@ Example:
 			dlg,btn-cfg = <50>;
 			dlg,mic-det-thr = <500>;
 			dlg,jack-ins-deb = <20>;
+			dlg,jack-ins-det-pty = "low";
 			dlg,jack-det-rate = "32ms_64ms";
 			dlg,jack-rem-deb = <1>;
 
diff --git a/include/sound/da7219-aad.h b/include/sound/da7219-aad.h
index 24ee7baa2589..41320522daa2 100644
--- a/include/sound/da7219-aad.h
+++ b/include/sound/da7219-aad.h
@@ -44,6 +44,11 @@ enum da7219_aad_jack_ins_deb {
 	DA7219_AAD_JACK_INS_DEB_1S,
 };
 
+enum da7219_aad_jack_ins_det_pty {
+	DA7219_AAD_JACK_INS_DET_PTY_LOW = 0,
+	DA7219_AAD_JACK_INS_DET_PTY_HIGH,
+};
+
 enum da7219_aad_jack_det_rate {
 	DA7219_AAD_JACK_DET_RATE_32_64MS = 0,
 	DA7219_AAD_JACK_DET_RATE_64_128MS,
@@ -80,6 +85,7 @@ struct da7219_aad_pdata {
 	enum da7219_aad_btn_cfg btn_cfg;
 	enum da7219_aad_mic_det_thr mic_det_thr;
 	enum da7219_aad_jack_ins_deb jack_ins_deb;
+	enum da7219_aad_jack_ins_det_pty jack_ins_det_pty;
 	enum da7219_aad_jack_det_rate jack_det_rate;
 	enum da7219_aad_jack_rem_deb jack_rem_deb;
 
diff --git a/sound/soc/codecs/da7219-aad.c b/sound/soc/codecs/da7219-aad.c
index 993a0d00bc48..a61dc965f4fc 100644
--- a/sound/soc/codecs/da7219-aad.c
+++ b/sound/soc/codecs/da7219-aad.c
@@ -571,6 +571,19 @@ static enum da7219_aad_jack_ins_deb
 	}
 }
 
+static enum da7219_aad_jack_ins_det_pty
+	da7219_aad_fw_jack_ins_det_pty(struct device *dev, const char *str)
+{
+	if (!strcmp(str, "low")) {
+		return DA7219_AAD_JACK_INS_DET_PTY_LOW;
+	} else if (!strcmp(str, "high")) {
+		return DA7219_AAD_JACK_INS_DET_PTY_HIGH;
+	} else {
+		dev_warn(dev, "Invalid jack insertion detection polarity");
+		return DA7219_AAD_JACK_INS_DET_PTY_LOW;
+	}
+}
+
 static enum da7219_aad_jack_det_rate
 	da7219_aad_fw_jack_det_rate(struct device *dev, const char *str)
 {
@@ -688,6 +701,12 @@ static struct da7219_aad_pdata *da7219_aad_fw_to_pdata(struct device *dev)
 	else
 		aad_pdata->jack_ins_deb = DA7219_AAD_JACK_INS_DEB_20MS;
 
+	if (!fwnode_property_read_string(aad_np, "dlg,jack-ins-det-pty", &fw_str))
+		aad_pdata->jack_ins_det_pty =
+			da7219_aad_fw_jack_ins_det_pty(dev, fw_str);
+	else
+		aad_pdata->jack_ins_det_pty = DA7219_AAD_JACK_INS_DET_PTY_LOW;
+
 	if (!fwnode_property_read_string(aad_np, "dlg,jack-det-rate", &fw_str))
 		aad_pdata->jack_det_rate =
 			da7219_aad_fw_jack_det_rate(dev, fw_str);
@@ -849,6 +868,21 @@ static void da7219_aad_handle_pdata(struct snd_soc_component *component)
 			mask |= DA7219_ADC_1_BIT_REPEAT_MASK;
 		}
 		snd_soc_component_update_bits(component, DA7219_ACCDET_CONFIG_7, mask, cfg);
+
+		switch (aad_pdata->jack_ins_det_pty) {
+		case DA7219_AAD_JACK_INS_DET_PTY_LOW:
+			snd_soc_component_write(component, 0xF0, 0x8B);
+			snd_soc_component_write(component, 0x75, 0x80);
+			snd_soc_component_write(component, 0xF0, 0x00);
+			break;
+		case DA7219_AAD_JACK_INS_DET_PTY_HIGH:
+			snd_soc_component_write(component, 0xF0, 0x8B);
+			snd_soc_component_write(component, 0x75, 0x00);
+			snd_soc_component_write(component, 0xF0, 0x00);
+			break;
+		default:
+			break;
+		}
 	}
 }
 
-- 
2.17.1

