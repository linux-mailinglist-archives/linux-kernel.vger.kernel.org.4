Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784795F9BC4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 11:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbiJJJVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 05:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbiJJJVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 05:21:50 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BAC422FA
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 02:21:47 -0700 (PDT)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.5) with ESMTP id 29A7v6FF005531;
        Mon, 10 Oct 2022 09:20:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=kZ+/a3dZgBVRFPLezszNRFiX+SUtvvzdLqeHNh19s48=;
 b=bfnMOnEGEz2s1m9Cg0qv+nNRmN7978S3jKa2SXij1JYjAzpgdnRy+CYR/X3WsxXI4hz+
 hzT9xMZRfYYFn43NrHs6U+S4oBMh/Moi+wknZHibQKDEMO4k+R1X9LXsbliI5fw2vGE9
 9jJQv77bQzePtmHMy+LlfpuH7rf3SwYXO4hH5mTncpfyzX4DIkZTmoLE+yhF7QQ6Zmev
 NZMyUN1Qmjs0ZElw5ofYDHTLZP1vgIzEBv7+8fSsbIgHfSG70Eh4O+URY6jqNUO+0jo3
 B5nQB/lJvx9EuKUSYiFllDxOlb3ozv4AgFRo7kKEud5ftihW6SwVz3v7VaXrqsWXfXna FQ== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3k4feug21u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Oct 2022 09:20:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZkRn19bfquejDttNV7QT1vudmlwQiwjoHhPJ5djo4g2bsckaINDWy1T/nsxeflv1gjOlQg+agwSC6PH46fBLpPK32yG4jUbW+2/rsw9an0kxWKGEKT+wJUM8i7tPDobK3tWceHJFiwliQscRqClH2UvonZxSzGe8JCILwEt77Kx1tE54NRHgxee4+gCLyCV+dd/hnMeT41g9dG2xh0gFq73cX4VWyNx/AvGlZS1fVfyewA4EN3cnD1Sq+SpQLMeIxJJ3ZYLpM2i7a7bgS7o2c7sw960AUaxG0ZB32R8cYBCpduME0INbRhD60jQodhdroA64EyhSJUHtf343jeL/Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZ+/a3dZgBVRFPLezszNRFiX+SUtvvzdLqeHNh19s48=;
 b=aNYygT79MshAQW1W/N6vqeE6URkNsPNvbajUIruGLv2MwV4h06zspALqIe5qGNrZjfwI0lXNLXWbqPb8xELTkLyBS6lIga841YpzRsnVejIX4ZMh34nvMN58x9czmEeDPD3BT1LWNJC18mwq8vpSWdqLlZg4iuSmKxLxEqFn6djmrKmD0gx8ClyoEsLhQ2gdLGYzhUPoxFDybZNbJwEfeYf5UyNtKrXa98QlJy4F4oDR05sIgVSP9r3hsFAF59T3+VTh49xXPur6OC0p81RI1Lc49s0oYLTHqaTRdJqqyrs/WgPIZLv68HNNkNo0qYpJCIlJp74074y8tiXBm+EYew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by SA2PR11MB4844.namprd11.prod.outlook.com (2603:10b6:806:f9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Mon, 10 Oct
 2022 09:20:30 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::25b1:ccb:b06c:ee86]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::25b1:ccb:b06c:ee86%4]) with mapi id 15.20.5676.024; Mon, 10 Oct 2022
 09:20:30 +0000
From:   Xiaolei Wang <xiaolei.wang@windriver.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, ckeepax@opensource.cirrus.com, steve@sk2.org,
        geert+renesas@glider.be, chi.minghao@zte.com.cn, aford173@gmail.com
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: wm8962: Add an event handler for TEMP_HP and TEMP_SPK
Date:   Mon, 10 Oct 2022 17:20:14 +0800
Message-Id: <20221010092014.2229246-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0159.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:35::10) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|SA2PR11MB4844:EE_
X-MS-Office365-Filtering-Correlation-Id: e1121cc9-d45b-4b48-cd6b-08daaaa0ad25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z/dv80mAIDGzwpmg5h8e1e5p+a+nL0xTuMo1xQwpGX7pFjzSrzlm9W4cIwjPHg76pAOGtnz3KgBO9/CqJVFZOBJyOwH7Qa6z8kSkiaS+jXlmaX9LN2m16fIa8TalDy6Uev8yZ6slSU/BQ2bEDi4S9E3WXzQZuGKBvI4ZAR665ZAVqEFYTAq5HQjJWAJ3MFBGHotLrfKuHt/OyKOQ38iPmSmvw7M185yWaWM7uASfitUFqZtTdTpqk/UXGi4p1QUPhKmqIStob630kEi1B+OYnBjg6viH+Y8g68XYO1/D17MGNM+aYWelCFe4bjFY4M2KudeZgc8BI+IyTFhpIZ7C3VyGmN4VKotj7gmgHTkm/XhwgUHHTw4Raj/eSHZ1Bqliv5ESilebFjUsgwfe2hKKcXRNHpwrxfqnBHOYQa6LBmKyM1g1NtjjQNzY3f4Vefoj8IDfrGNsqprD431ve9b299Z18zwVhnsrpvSIwSDbnEm9MAb7ZLt0pbNt8hMq2mj+KBZ1R+KYVlm1euxt1q7kbOUxAP2FVjm6dx/aVWV1XG7yDWLXzeoLk7pCfRYpJLQ8OUSCRNhVhyDtwrScSfqWEYvplvJdfizWr1rnZQwMkqbb6FMkz+nsSvMlvzBqGwN/gHoRGwxp/6uuGHc1w4UlRHCoEhI6/Wv1aCaWA5oVGm7ib5quW0vWdkJaiUWRaTmNOFA7fzCrWmZxCcn9p82Ktde9ENKBqJMLSKQ9ZSVv8n85gQCQco8me+GHpt7v6adiHI1W2HHFJHGh8KAyl/ZN8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39840400004)(136003)(376002)(396003)(346002)(366004)(451199015)(2616005)(2906002)(316002)(6512007)(26005)(52116002)(36756003)(38350700002)(38100700002)(8936002)(41300700001)(6506007)(86362001)(6666004)(66556008)(66476007)(7416002)(4326008)(8676002)(44832011)(66946007)(6486002)(5660300002)(478600001)(83380400001)(186003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1IatmRPpN6iDCcrGRHglv9iOaKzfGyfYevqykM8kfY1/iVRrUzPhGqGsQOHW?=
 =?us-ascii?Q?0rVnbjBHbjp8DaGZ/WRLP/CYugdzg88NQta4wcohMQZFH0sufs+8nY2xhcfU?=
 =?us-ascii?Q?nCUVXzkxQB9HXEBdmc/DdhLa8MtpIPXjJC7hPUaBpQRSVneu1wWdegK5WOej?=
 =?us-ascii?Q?7kAXyBXUblYB30ZqcvtXM313GL9fHccUrnDSd9j/2z4tpVBgDmdBw+XdE0qw?=
 =?us-ascii?Q?BsXbdxPHWFcOAnqseC/mS+dZWb/VO2RuThZrG8adz15yeWifGOebnN22Bhcn?=
 =?us-ascii?Q?xy2FOCVH/eodRs43lWgO93eoaE7IhYcjH06+PLz/iAZWwr8ptN5yThuxfLO5?=
 =?us-ascii?Q?NhRHZ9fnS/Ms8+xZs4gtQ7DRoqgP3fZhdSZ3YMIfBRZN1AahSiQ77Pn66ElN?=
 =?us-ascii?Q?toGj11rsx7v+v6tp9nCUSeDEdCgaW+Mp938e9T0OENffwd53OlXKe8yx4zPz?=
 =?us-ascii?Q?emGi71YUeVIPQ9bEtSwYKSCKqlQbsGDo08WCQMrxoJIL+qMmQbqjIu0IAUmG?=
 =?us-ascii?Q?krxh2Lo0YAT7Zg9ldcgvxGQNCWbpehquCC0XtEzQK03ttX1JVd+R7YNfc+Rk?=
 =?us-ascii?Q?qCAyY05X7+SQhuX1eLQ5tOMZScMxTDFRhJ3vcwpObL7es+4qoQNnq+HxRMgz?=
 =?us-ascii?Q?/1eZ1IgylacRxHlHoc+m4eZa53mVl8s31QuoOZMz80l6EVSAeopGVMZWZnza?=
 =?us-ascii?Q?0XYlJ/nOiZ8+MWaMHgM2u1oXNmAj9YOoEZCw0gQTg2zUW3jmcza0urk0viG4?=
 =?us-ascii?Q?b25cgn3xYU5Zem/pHalJoI5VhAm+4ylUs5w930XPdbObkCMV9gO6dD1XG7BT?=
 =?us-ascii?Q?mbq/fV7EEK3rQZ5bcNkx3QfJ+wW1y/eyjym6XaZw1ge25BkhkiC+7dS1ya2t?=
 =?us-ascii?Q?VwU+ugwz/usXXx9LGUKyuIy2vU1+S3QKD4R63K3EzREPMLd+lUip1s7kwgXP?=
 =?us-ascii?Q?aTKvU/NRwIrde4BZyMAizFdWij31qIkUXAUIMUhhTtB2mio8CJELGZKQdFTV?=
 =?us-ascii?Q?PB+dU1v1GCjTUI2Hy/uxns7/Nq+izOr9VS2jt64wJkCdhPPYMOv5imxBbRIF?=
 =?us-ascii?Q?ph03SKirzZzZcpcpG/CwP+uuUK1TlL5csvrHe8AFJZlHp2lHrLV1rci2I3xr?=
 =?us-ascii?Q?44dnZrtSmcnr+L8fbSrCrAj+b6KjbxjQMgnSWUoGTZLwShTlwq6QqKvZqYlR?=
 =?us-ascii?Q?cOoWWiMxLXOhjVNBeJ1Im2JM03bcmfixWSENXw9PkApzw83KIWE0yUyEjs1b?=
 =?us-ascii?Q?+TYnl7hehpuOAIRp5f8szZjzEup7dyUO6tIx9AEl1ZC/V+MD2cv8YP4PT1iy?=
 =?us-ascii?Q?TM8RgN0VgG/YuC2M/1a0ydB2C1pwS97yMCtz1n5XdL1ZYoLkN7jy3AHw+Kq/?=
 =?us-ascii?Q?kd31g+BfnapB2SyBvOC/WNiHTyx1gnL8eRBxX7vEzqNODbZypGKoMnB9oQp+?=
 =?us-ascii?Q?pSCG1MbKgaaCGpH+rSSqN27/Nvat7pet0PD8YTp6pZGkGJI3sM6G58V/rYzP?=
 =?us-ascii?Q?oifNU6g5Zdwzy83O4aeql0nIeppDeTsk3iI2KsS+PfTDK7pdbr+VbRKTFg5X?=
 =?us-ascii?Q?wmuKtdh+F3RdeXzmQvWUlEpXQzbOMedti+aoe4zf5hVYoXiRJz/jXPYPOXz0?=
 =?us-ascii?Q?IA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1121cc9-d45b-4b48-cd6b-08daaaa0ad25
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 09:20:30.4489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tewZnQOOulh/TJoCplv3HlhRaMb1DqUaf88WAomItVzModDzx3pu4w56eSkwBMRJDi/AKiPTD37n/3ycDPonq+APEAsLCz4aruJMhFj2obs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4844
X-Proofpoint-GUID: ZngNdduJcbt3nucQt9cJzW5ZWFsPzz-e
X-Proofpoint-ORIG-GUID: ZngNdduJcbt3nucQt9cJzW5ZWFsPzz-e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-07_04,2022-10-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 spamscore=0 clxscore=1011 priorityscore=1501 mlxlogscore=999
 mlxscore=0 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210100056
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In wm8962 driver, the WM8962_ADDITIONAL_CONTROL_4 is used as a volatile
register, but this register mixes a bunch of volatile status bits and a
bunch of non-volatile control bits. The dapm widgets TEMP_HP and
TEMP_SPK leverages the control bits in this register. After the wm8962
probe, the regmap will bet set to cache only mode, then a read error
like below would be triggered when trying to read the initial power
state of the dapm widgets TEMP_HP and TEMP_SPK.
  wm8962 0-001a: ASoC: error at soc_component_read_no_lock
  on wm8962.0-001a: -16

In order to fix this issue, we add event handler to actually power
up/down these widgets. With this change, we also need to explicitly
power off these widgets in the wm8962 probe since they are enabled
by default.

Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
---
 sound/soc/codecs/wm8962.c | 54 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 398c448ea854..6df06fba4377 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -1840,6 +1840,49 @@ SOC_SINGLE_TLV("SPKOUTR Mixer DACR Volume", WM8962_SPEAKER_MIXER_5,
 	       4, 1, 0, inmix_tlv),
 };
 
+static int tp_event(struct snd_soc_dapm_widget *w,
+		    struct snd_kcontrol *kcontrol, int event)
+{
+	int ret, reg, val, mask;
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+
+	ret = pm_runtime_resume_and_get(component->dev);
+	if (ret < 0) {
+		dev_err(component->dev, "Failed to resume device: %d\n", ret);
+		return ret;
+	}
+
+	reg = WM8962_ADDITIONAL_CONTROL_4;
+
+	if (!strcmp(w->name, "TEMP_HP")) {
+		mask = WM8962_TEMP_ENA_HP_MASK;
+		val = WM8962_TEMP_ENA_HP;
+	} else if (!strcmp(w->name, "TEMP_SPK")) {
+		mask = WM8962_TEMP_ENA_SPK_MASK;
+		val = WM8962_TEMP_ENA_SPK;
+	} else {
+		pm_runtime_put(component->dev);
+		return -EINVAL;
+	}
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMD:
+		val = 0;
+		fallthrough;
+	case SND_SOC_DAPM_POST_PMU:
+		ret = snd_soc_component_update_bits(component, reg, mask, val);
+		break;
+	default:
+		WARN(1, "Invalid event %d\n", event);
+		pm_runtime_put(component->dev);
+		return -EINVAL;
+	}
+
+	pm_runtime_put(component->dev);
+
+	return 0;
+}
+
 static int cp_event(struct snd_soc_dapm_widget *w,
 		    struct snd_kcontrol *kcontrol, int event)
 {
@@ -2140,8 +2183,10 @@ SND_SOC_DAPM_SUPPLY("TOCLK", WM8962_ADDITIONAL_CONTROL_1, 0, 0, NULL, 0),
 SND_SOC_DAPM_SUPPLY_S("DSP2", 1, WM8962_DSP2_POWER_MANAGEMENT,
 		      WM8962_DSP2_ENA_SHIFT, 0, dsp2_event,
 		      SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
-SND_SOC_DAPM_SUPPLY("TEMP_HP", WM8962_ADDITIONAL_CONTROL_4, 2, 0, NULL, 0),
-SND_SOC_DAPM_SUPPLY("TEMP_SPK", WM8962_ADDITIONAL_CONTROL_4, 1, 0, NULL, 0),
+SND_SOC_DAPM_SUPPLY("TEMP_HP", SND_SOC_NOPM, 0, 0, tp_event,
+		SND_SOC_DAPM_POST_PMU|SND_SOC_DAPM_POST_PMD),
+SND_SOC_DAPM_SUPPLY("TEMP_SPK", SND_SOC_NOPM, 0, 0, tp_event,
+		SND_SOC_DAPM_POST_PMU|SND_SOC_DAPM_POST_PMD),
 
 SND_SOC_DAPM_MIXER("INPGAL", WM8962_LEFT_INPUT_PGA_CONTROL, 4, 0,
 		   inpgal, ARRAY_SIZE(inpgal)),
@@ -3763,6 +3808,11 @@ static int wm8962_i2c_probe(struct i2c_client *i2c)
 	if (ret < 0)
 		goto err_pm_runtime;
 
+	regmap_update_bits(wm8962->regmap, WM8962_ADDITIONAL_CONTROL_4,
+			    WM8962_TEMP_ENA_HP_MASK, 0);
+	regmap_update_bits(wm8962->regmap, WM8962_ADDITIONAL_CONTROL_4,
+			    WM8962_TEMP_ENA_SPK_MASK, 0);
+
 	regcache_cache_only(wm8962->regmap, true);
 
 	/* The drivers should power up as needed */
-- 
2.25.1

