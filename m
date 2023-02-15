Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB6A697804
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 09:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbjBOITB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 03:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbjBOISy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 03:18:54 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2070.outbound.protection.outlook.com [40.107.22.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980C636442;
        Wed, 15 Feb 2023 00:18:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gEIVhec2oVaIbk2qJkCNakID9dvyDW08vfxMmJ+h9xjS8wXoimUkk30mLe7V6ow4v3YlpVWCu685EjJqQsUYBgiFqTZZ2NwJa8Gq6jv9JZqQYRVcgaw1lmKTl8RTunamTeNWUunWigmRt0euC3nRChZBvST7LxE+tNpp3eMn6nJOWylu7g7wor1RXJyaOUFdRGJfAunq0kxsJK6bM2w5kn8NcAaS24PLf0Ly5/HLCuWEUmMfZ2yY71UW5NcZ2Gs0sN8SaCZg+H3n20aRLL/OGVvOsY8nRlMFt27oB7Q1I+iDPm6ttIfQr+z4Q+4qL1KmxhMFu2GM1LJGQM0oH77WSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VdZrAV39bni52qDgW8gVM9Ny/UmpHAeL4/SinHM4BMI=;
 b=aUgJyUEs/BnlpBF/LssoqWx4BzPqCy3hARwEd2+MOw0uhNoSBYiySy9YDsVkhEZ4bSV9TSGWdpN43hpdEaMBz0zUErQkHmGz0luUT8p6NVsHXWWsrxLFSUfyYbDkRjlg3SfBr+/k4h3LbwTYtOQTABgnPErMY362grxilOzs2sCRvkcMpz8STRbJWl6g10cKYU1L3j8XJRkn0XD9Ze340IAqGt8/7/jxHKo0UdVjhWM59fybcN8p62F/V0QkAfWW2O00NqJt4FS4D2Rlrq4pt7KXeCcNq2s48hOgbIwoUeQv/IUVgK2Rox5EMKbkplM6u3Xy6bQH7OYj2U1kdlv5wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdZrAV39bni52qDgW8gVM9Ny/UmpHAeL4/SinHM4BMI=;
 b=rY1PDTYuEWJ7BPoZGX9zA6fsUe2kgAj2iB6Acoz2O7pXM1r6n0O8qYyOryqwbkrdfEtMLbVggZ/Og4o27ZUetG8pDuvB1r8wnNCTzSibtzkIvyWFOCso0D3LZrPhMp6P5ATMDuQ6rX8j3fp3gFhsuc7qTQdlfZqvRPgmGmiiLTY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by PR3PR08MB5706.eurprd08.prod.outlook.com (2603:10a6:102:80::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 08:18:49 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::93ad:a231:e2ea:d1b1]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::93ad:a231:e2ea:d1b1%5]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 08:18:49 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
To:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Javier Carrasco <javier.carrasco@wolfvision.net>
Subject: [PATCH v2 2/2] rtc: pcf85363: add support for the quartz-load-femtofarads property
Date:   Wed, 15 Feb 2023 09:18:15 +0100
Message-Id: <20230215081815.3141776-3-javier.carrasco@wolfvision.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230215081815.3141776-1-javier.carrasco@wolfvision.net>
References: <20230215081815.3141776-1-javier.carrasco@wolfvision.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0161.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::18) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|PR3PR08MB5706:EE_
X-MS-Office365-Filtering-Correlation-Id: 73d8a279-971c-42a7-cfca-08db0f2d43ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CnoT6kFr5kDlm9NcuoOU7+B7jzLPilPMEXbe52jEFvNUHbSsi8obuGm4NIdqRBYFsPfO4ak9D4WaKgw9lAMQmQQIkJuUJdmIzkhluvYhe07x2AEL5+nH0R5EjAkzLa7TCnpEJfo0EQkFK/8boZxhKEVyeO6HgA6CNqo3BPlJV/Qc3blzgf+ATRuH5IzkA3HYnGllHqB8ItpDGWpx/vvMOZaRcOuQG0NhTs5MBsQfVDWlsTszGIzrkCGgSft/87+5MgvHFfHupJYupVIYtHpxo152FIU4+K/6EZAhhQ2aJQwtEeO47S6uNwMJ7N5v7E8hInQ42eH+UAX99wTNZS2r6HG4HqPHm1B4mpCZRsz9WkPO73EaXPRGPf/FA1+IAQF9eoYeIMi6aryExY7c836bMPw2/8/Hm5DfXmk++80cHK3JAeWsz997ixttuzXJG1QPbSPtRjones4dzrysBtQ8BHEr40P7d3f1nKRXQVU8v77UqXHX20EQvTAPKPGFdoQl6PBm6CPuJvusWSo+Kyb69JwfsvTggGmMg4ieT6FFIVpWdrvViwKuvLsnH68j2zOnkX/kVxHsnLA9p3BgmBUnckitsQ0OHcvyh6VTIgjwaxzMNk1pNyIjSBpEvF6BMoXUbXawf7HskKf4XvZn0Oji/ca8eq8oue4iy5uL/0pfCRJoUwxPVrArCSrtI/wI1aKfHlOxnA3WCProDnqUt0bGMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(366004)(136003)(396003)(39850400004)(451199018)(83380400001)(316002)(54906003)(38100700002)(38350700002)(2906002)(5660300002)(36756003)(44832011)(86362001)(4326008)(8676002)(66946007)(66476007)(66556008)(8936002)(6666004)(107886003)(1076003)(2616005)(478600001)(6486002)(26005)(186003)(6512007)(6506007)(41300700001)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K+RZkDmfmQaf/8S8A6ZR7fP+yufzfePc7KWQ9vgrCKQncV5U88CbfTl5mRPT?=
 =?us-ascii?Q?PqQy98kR4Mu+ctOyDp4kmJSUhSPx7O27aVPk06kRB8CI74eQIt4p/usb+hTo?=
 =?us-ascii?Q?f0AH0iE6mWa2XtYo5mPzSo/yp/+/oE6YV3aMUOVzljBSYoODLTZ9hFfa0P7E?=
 =?us-ascii?Q?b6+PZ1oiB5X9IjLAANRD8TNtz3d13WwEk9+1d4kEl6anOWzJ3anY8gY1Q0jZ?=
 =?us-ascii?Q?BzuDOGXJx3aqJFZey0kRZbYq+Kzk3KVOZdzmsM6M14uwIYeYNoMH3WxjQsAj?=
 =?us-ascii?Q?0hhSrSIK9wF1oZnEt8zgL7hmVihhnaEkacKKIntgx44lzJm5udG+pSXRT6BA?=
 =?us-ascii?Q?GYQvid1IIpEOfo6lUHZ1d0Dwvjg5wHTAwZ1LVCfKizp9FwpWDe2E5DeKQWVD?=
 =?us-ascii?Q?WQgg2qVQKu1aILa8ljE9nMu+19erq8OfjKzdJLv7DkaHjOUX17CKty9aCWK0?=
 =?us-ascii?Q?eoI7xeoSRBiUqCfi48+19FmhbTkeOHfyPBrqIRipQW786l+IGclYMzr7P3+6?=
 =?us-ascii?Q?xpLpwm0z+SFTQ6kt3aYZjqiffS7mUMMx640OZIqnQmpQl07wx+GLMMCFmWHq?=
 =?us-ascii?Q?/MK88c3Ooo+x73BsHj5DC1vaTdwdqCwD37tJuxmnTWY+fnua7khQYhNfFm3X?=
 =?us-ascii?Q?cJANfJR82ShLf5keVZJjG9p7s26YlcwT4d+85FC19rxnrHVkETKp0+TRFPyR?=
 =?us-ascii?Q?/5/VnSYKyyxn2rlv42Kq9YSKLixL7gcnTOYkFKViY5B5h1iwCgmArhUbiApL?=
 =?us-ascii?Q?kIgLxHnSVWIsREQIIkV9+LyWREmt1BGr87L1i9Z+mghciLnpCw3fBTxnteQy?=
 =?us-ascii?Q?Yl73E4Ex/f5se1U927IesC8VToJKW8FZW1rovyCu+zoo1JT8fy32BS0LR4yy?=
 =?us-ascii?Q?ur3cMQlLVBRaFoKSz7V/zB7Rm1uEL+e4c0pHN14Vk3Vbpp+4421bzHlOFPom?=
 =?us-ascii?Q?TOa1GtfBMx+wqQVUU113Q7ypUFRnkVUJs+LPhpevylikRLbwbRuMisiNDpEu?=
 =?us-ascii?Q?Lq+Gp8zlyr3cm2fbqnzF/BcIyv0xVI7u+pTVrvEMEP5T3SbHxW61s0E6gBy/?=
 =?us-ascii?Q?Da20O1t3XmDi23dq33z9BHIGtLVYwvrYx1FR3lGDSehZUEAyFomTcvu8TQWl?=
 =?us-ascii?Q?ybG1oVO/6rIbGMBvxwnSo3s6hlzv5n5YrvKxBii/q244EFWHcX/fINqzp1y1?=
 =?us-ascii?Q?F2dvZ+PosWgwijLTHlpAW2ufCMHiLKBSGIbnT1jnr9cGcEW+ihjHg68C6zV6?=
 =?us-ascii?Q?G8pn/tFkle4J9avG8X/FHAQucYr1bUKOtJ4ehLwsmcAqF4Rh0ht21acRXHmm?=
 =?us-ascii?Q?b3HvLBtB+EYTxrzeN7Vd97G+n2Zo7gxny2rj0yZ+ltIx/rGodtLFtKordw1J?=
 =?us-ascii?Q?IIy0izfbsq9cVo4c9uZiw2CqmwS+6tZVG3Tb7LOErUK9Uh+740rqtv4QCv3b?=
 =?us-ascii?Q?axh74jMjYgvse7czD22r0+x8uBaHlywJFcfkcXBBDtubQ+9qEr1HVUqQ0byN?=
 =?us-ascii?Q?9GGv6p7NxkpM5J/8ZhelmJH2D/zpyfKLcgtaO5OJMX1Ysg8QkTzUJfPOeJ8q?=
 =?us-ascii?Q?eUz2wIdXhCAzkjC6O9fwP0BWwp/WSP/1N7/ehoQc4J0izlzUt18QlA0gmQh+?=
 =?us-ascii?Q?1TaNNoHqvJUCccbANqaZ2D0=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d8a279-971c-42a7-cfca-08db0f2d43ef
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 08:18:49.2198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1foFLZNwyK20Bf9iwf9S08gBfese+Okkh4SrWf8XSSgqk66sjLt1m8tL+S8NbeRYlnlRvz3/c0ZkOpabvi3ZBKxW6V1REC/DLWe6GBUmQeE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5706
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The quartz oscillator load capacitance of the PCF85263 and PCF85363 can
be adjusted to 6 pF, 7 pF (default) and 12.5 pF with the CL[1:0] bits in
the oscillator control register (address 25h).

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
v2:
  - simple assignment operator instead of |= for the "value" variable.

 drivers/rtc/rtc-pcf85363.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
index c05b722f0060..219fbca8c47f 100644
--- a/drivers/rtc/rtc-pcf85363.c
+++ b/drivers/rtc/rtc-pcf85363.c
@@ -101,6 +101,10 @@
 #define PIN_IO_INTA_OUT	2
 #define PIN_IO_INTA_HIZ	3
 
+#define OSC_CAP_SEL	GENMASK(1, 0)
+#define OSC_CAP_6000	0x01
+#define OSC_CAP_12500	0x02
+
 #define STOP_EN_STOP	BIT(0)
 
 #define RESET_CPR	0xa4
@@ -117,6 +121,32 @@ struct pcf85x63_config {
 	unsigned int num_nvram;
 };
 
+static int pcf85363_load_capacitance(struct pcf85363 *pcf85363, struct device_node *node)
+{
+	u32 load = 7000;
+	u8 value = 0;
+
+	of_property_read_u32(node, "quartz-load-femtofarads", &load);
+
+	switch (load) {
+	default:
+		dev_warn(&pcf85363->rtc->dev, "Unknown quartz-load-femtofarads value: %d. Assuming 7000",
+			 load);
+		fallthrough;
+	case 7000:
+		break;
+	case 6000:
+		value = OSC_CAP_6000;
+		break;
+	case 12500:
+		value = OSC_CAP_12500;
+		break;
+	}
+
+	return regmap_update_bits(pcf85363->regmap, CTRL_OSCILLATOR,
+				  OSC_CAP_SEL, value);
+}
+
 static int pcf85363_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct pcf85363 *pcf85363 = dev_get_drvdata(dev);
@@ -372,7 +402,7 @@ static int pcf85363_probe(struct i2c_client *client)
 			.reg_write = pcf85363_nvram_write,
 		},
 	};
-	int ret, i;
+	int ret, i, err;
 
 	if (data)
 		config = data;
@@ -394,6 +424,11 @@ static int pcf85363_probe(struct i2c_client *client)
 	if (IS_ERR(pcf85363->rtc))
 		return PTR_ERR(pcf85363->rtc);
 
+	err = pcf85363_load_capacitance(pcf85363, client->dev.of_node);
+	if (err < 0)
+		dev_warn(&client->dev, "failed to set xtal load capacitance: %d",
+			 err);
+
 	pcf85363->rtc->ops = &rtc_ops;
 	pcf85363->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
 	pcf85363->rtc->range_max = RTC_TIMESTAMP_END_2099;
-- 
2.37.2

