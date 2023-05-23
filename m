Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B91970E1A9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 18:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237712AbjEWQTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237684AbjEWQTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:19:06 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2135.outbound.protection.outlook.com [40.107.114.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F651A4;
        Tue, 23 May 2023 09:19:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DAuSz4Ieaj8UvJrBCi94H8Hj4bkKMsmZLOTx2hwl3MUaurytLRQJi9bD4Wom9WnS9YdptLTDzwEvFu78dSu/fTFMvkH5a/z6wWBYPtP5ye/oHG8SuuzmJWpXNzzi8txTPtH4+vUcR2Slirb4b8NOVpk7munkU6nfjHcgZL9t3VdeFXrJ9Du0n8+n+Tse1/w7PqD3tYhbJWpu/OgYJTxW7oRqOrwstXNfT72NssQWBGdLjuYUTCmuzMdlYeW5GQ3Rnk9OWibBes/Td7854h2Q5o5DOPiwH1oyd2ctfFvwsI87gLAfxcuwIdoHKUySM0+Z5hBfycCMxttgGjQQpJA1ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3t2reTTqqnQSu1LOumEyNdOOZhGTyfOqioxlYS2fmE=;
 b=MSPnG1n/Fbl1CjuB5MWRigYvu3jl5/GdBegGTK6WkbhPDNc7Vp2z7iGQP8Liqt/qBoX7B1L1Fc7lKhO9LZOmRHNc6QfUMy4CHHc8JRS2lxCHP3j5WwFmezL0Axff6szXmdb1EdKrUGvBOW6ZN+BFJemZsWi6JIj9g/Vg4b/Zpl9VGCJ6xVavHtPNY2mj058vp1sQqOJLlDlcGZPO5EdLN0jLK3ub9obJFvxyHsgqOqnm1mYl61RdnNrSEt7QADDAKIf0A8RwUd5uZ5ZOGWstKEIJfDVX54FRoI02vMQZn2HBn6KfrbsdNldWeqeEjpLu4I7iRjGfn9U7JVw700uqTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dm.renesas.com; dmarc=pass action=none
 header.from=dm.renesas.com; dkim=pass header.d=dm.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dm.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3t2reTTqqnQSu1LOumEyNdOOZhGTyfOqioxlYS2fmE=;
 b=frGbeLDNcEfJLiR+p1YiKsHCOPAQaaH5V7sSPCgidee+G9LNU4w9utwYIvL3HVa1iuy2EegasXgcvgmO924X9NRA2H2rsSW/knSQa5DQw7FktCg/PftXhXwuqpfQIoqIZHW/vrvOWSjhwiMF7BOFNi4QhxAoXNSRT7piTVSDM78=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dm.renesas.com;
Received: from OS3PR01MB6641.jpnprd01.prod.outlook.com (2603:1096:604:10b::11)
 by OS3PR01MB6040.jpnprd01.prod.outlook.com (2603:1096:604:d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Tue, 23 May
 2023 16:19:00 +0000
Received: from OS3PR01MB6641.jpnprd01.prod.outlook.com
 ([fe80::2de2:b2ee:d931:157]) by OS3PR01MB6641.jpnprd01.prod.outlook.com
 ([fe80::2de2:b2ee:d931:157%6]) with mapi id 15.20.6411.029; Tue, 23 May 2023
 16:19:00 +0000
From:   David Rau <David.Rau.opensource@dm.renesas.com>
To:     conor+dt@kernel.org, broonie@kernel.org
Cc:     support.opensource@diasemi.com, lgirdwood@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        David Rau <David.Rau.opensource@dm.renesas.com>
Subject: [PATCH 3/3] ASoC: da7219: Add Jack insertion detection polarity
Date:   Tue, 23 May 2023 16:18:21 +0000
Message-Id: <20230523161821.4260-4-David.Rau.opensource@dm.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230523161821.4260-1-David.Rau.opensource@dm.renesas.com>
References: <20230523161821.4260-1-David.Rau.opensource@dm.renesas.com>
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0165.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::18) To OS3PR01MB6641.jpnprd01.prod.outlook.com
 (2603:1096:604:10b::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PR01MB6641:EE_|OS3PR01MB6040:EE_
X-MS-Office365-Filtering-Correlation-Id: d46530b3-cbc9-4b15-b90c-08db5ba96af4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b15jGHM5jeKreBrd1fpFbNrPLEEng0cnPF5CxwCTv+sVAHysnVIEmrclz/p96W5ABfyskuF4SfbD/dunTarwRTXqLn6lfgNrqqiPqnzS8sFPOHolVhAGvA4okR2gTEDZ4qvEkvj51FvxdLCH84LihTkZFTIe54howxT10nGtWw5jtbf7eb6hMvClYlehUnPUnQmY+WB1JaYEcevEfogfD3P+4HfNVkwacBhMfF6MyUoOzs+sq7Iy8c/H1EZftnRV9T921IiWrf+HMQg6XPmeG1Q4swrEhrBUaKflWDDw6aS2ADzfvliLXa0xcoNi1NbnppbUgicV3VWdUrG+a+jQafIchOc0AphI41ttGo/78BusVxuqcsiAsVhCZ4C2K+lYLvL1+48Atj4Gyzf8wQ3gQnUFeBUjP5VcgnAFsrMPiv2bJIJOp6y6yTyTHrKQCPVqLgehj4c2R7e2TzsEFPs7PpO08dUporvXisATUTNhqOnz30bW3KTsyd56UuMqqeC0Si+8gpILl/Sn6j3OJ9Tb7bLQxIYBfu4Fb+KbNjZtkgD91PFaOK/eqAxUotijI3urFMbLF9dUlUgpE6kVAjqDwU/L88FmtG+qCUMvmgsY5CioFoeijVI3rpDafIehlnlR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6641.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(366004)(136003)(451199021)(107886003)(6512007)(8676002)(7416002)(8936002)(83380400001)(103116003)(38100700002)(38350700002)(86362001)(6506007)(2616005)(2906002)(52116002)(41300700001)(66476007)(66946007)(66556008)(4326008)(316002)(6666004)(6486002)(5660300002)(186003)(1076003)(26005)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dMn6a83wjbXCy5nZkHp2SdtybL0q150/8tjG64mRX58WucB8RJ7twQoEzKGo?=
 =?us-ascii?Q?h0kaQQ4WUDhH6T0UmZSL1lpYimJhSEJVFx5As2zaStmu/IQNUZOcpqhEXzGr?=
 =?us-ascii?Q?o2UVU0Mjg9lX3MVDNjokavF+C39C5FlMi22E6Th84Att/aAa6Pj9dn4H5Nbd?=
 =?us-ascii?Q?+q9z0o43CAouY7gEJJIbgwskmu9fWaXQO+IinAka1qBmPR9phcBrbnFv3DTq?=
 =?us-ascii?Q?0A/gUbxkVR2gU8PgxXgD8HsV3e59aR7jvUypNhHk6IKyo6gmfzlz1635WFqM?=
 =?us-ascii?Q?yrA1GIJMHfXH7WjyVrj0FXTpW2kUj1tRSkqT3i/B90DRFy6uWLW9ZwrRvK5o?=
 =?us-ascii?Q?W/7wszGCCsRmALzeT7ANIdwBKtmzHCT4CvvF3OgSOIvNzMHui+5sfYkw2s4o?=
 =?us-ascii?Q?YZTlGNE8doSwD3YnCGkRkNiAwF6lHGgQjm82ih/bo8i0wDLs7fYVeS8Vb6fw?=
 =?us-ascii?Q?Q8Q7rosUeJYlqqhxvLvb+3gpiePJMRdsUFeHQn9JAx6uZGZqQ+gQPvcOWQew?=
 =?us-ascii?Q?NssBQOOih30wT5uFsrp1OgbJ9VzEM62epPi8fB9TfU1GPnFNwXJLYc7WmSKO?=
 =?us-ascii?Q?q9/NuJbex8rGPSF9Rfuz8L0KKncg9yzg2NGNSoMqSEYe7MIw6D851MVK9Bue?=
 =?us-ascii?Q?QCB/TQF4DcpMV+z5zAWU1pcI/iHJkcdMpgik/gpjHVkqdSVerV1Hh6jV1A69?=
 =?us-ascii?Q?RJgi78TWjfwnvYiixcJRIs0KNXVYbnL7e4ix1QOsLbkWBlqUaeYdaBGu0tpy?=
 =?us-ascii?Q?wHjQBYei5XggF+LqdaLJ8KHbDhPeZik+ChHbjx4QcrOXfMVORLpuEnUn1FdJ?=
 =?us-ascii?Q?I3pGnS70/2gUkY2UEDRRbx0xwCRGjUAlvMGQvCZAAM025XXVAgUHdyt40sln?=
 =?us-ascii?Q?mXCBYRaX7OFxc1gdML9nvweOGZjjAgMkTLe4qgpSMHhXa2dOgyo6SncFiJNE?=
 =?us-ascii?Q?rvspNrHqZQXX/49SArVu9dqlf5WvHU1UvR3B/+hhu5ronynhvttBGaMSI75l?=
 =?us-ascii?Q?5vi9Yu9wephtLYKyh9Lj3gnTq0UP8OsboB5ej6A0XVo+W55IKIhtA7ccXywC?=
 =?us-ascii?Q?zgvb5ehdqBUA8WCnsF5UjQ8bFJ3wlo4T1fAxHPS0yY0mawhoayiAjDGCZigD?=
 =?us-ascii?Q?baZYH20P1DUsu/BJAsguIQofxnxriDnrnB1miQU3UWcYWdUiQ3Z1t6+6elV1?=
 =?us-ascii?Q?hynoS+3cv3ymkSGw57ovr9L70BaZdrh3njWtI37Sj/BqsbwygtiEo3V4Xl25?=
 =?us-ascii?Q?zeDky9E6fYGvw8tshN4SE6Zn8tLoUzq2SSdBA3z62JQgt+J0spjuGm3RI25B?=
 =?us-ascii?Q?/lZqCo5VDl95VBpl0Tk7H3CRYAjh3IFOJAJ+p4/MwOgLygiCG5d9Bc5z7dmS?=
 =?us-ascii?Q?85UdD+VyLyl3x/hzBWhdOXesq92fgtapkQYb55x+EYCwd/m/IQBbgkyymc+E?=
 =?us-ascii?Q?UHrIZraWlnbNw4hIEAxEFiv1JlLFKWmm98Y8TA7W9vl4sGPIXC8pSvGGznWo?=
 =?us-ascii?Q?G5EDKHCP/TDWt6cg/CsC5t2GdWR6PwPTBnwkpNUupaCAAb4yi3qEIyqg13Wa?=
 =?us-ascii?Q?WWt+cevpqKBvMRa3wC3w5/l6xRQT8c8CrNvXWjWeze/gYQbyfLfr4g1tW8dq?=
 =?us-ascii?Q?KA=3D=3D?=
X-OriginatorOrg: dm.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d46530b3-cbc9-4b15-b90c-08db5ba96af4
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6641.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 16:19:00.6410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q4K6UKn3QwWggSLEzDb7l4iwqrvC27kKq77oSXBZSjp67gcRh4HwuImvs9fMtFPDHMUdp5UOMTTdyN6B47Ql3/AzwgOt1RUtG74g+Q7chwA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6040
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support of selecting insertion detection polarity
- Default polarity (Low)
- Inverted polarity (High)

Correct the keywords of parsing `dlg,jack-det-rate`
bases on the new DT binding.

Signed-off-by: David Rau <David.Rau.opensource@dm.renesas.com>
---
 include/sound/da7219-aad.h    |  6 +++++
 sound/soc/codecs/da7219-aad.c | 42 +++++++++++++++++++++++++++++++----
 2 files changed, 44 insertions(+), 4 deletions(-)

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
index 993a0d00bc48..c65256bd526d 100644
--- a/sound/soc/codecs/da7219-aad.c
+++ b/sound/soc/codecs/da7219-aad.c
@@ -571,16 +571,29 @@ static enum da7219_aad_jack_ins_deb
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
-	if (!strcmp(str, "32ms_64ms")) {
+	if (!strcmp(str, "32_64")) {
 		return DA7219_AAD_JACK_DET_RATE_32_64MS;
-	} else if (!strcmp(str, "64ms_128ms")) {
+	} else if (!strcmp(str, "64_128")) {
 		return DA7219_AAD_JACK_DET_RATE_64_128MS;
-	} else if (!strcmp(str, "128ms_256ms")) {
+	} else if (!strcmp(str, "128_256")) {
 		return DA7219_AAD_JACK_DET_RATE_128_256MS;
-	} else if (!strcmp(str, "256ms_512ms")) {
+	} else if (!strcmp(str, "256_512")) {
 		return DA7219_AAD_JACK_DET_RATE_256_512MS;
 	} else {
 		dev_warn(dev, "Invalid jack detect rate");
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

