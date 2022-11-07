Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96FA61EB1B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 07:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbiKGGjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 01:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbiKGGi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 01:38:57 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2056.outbound.protection.outlook.com [40.107.21.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C6965D5
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 22:38:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GrwlqpTteRBKZKnFCVVf0ZjXgVChj1Uz3xNL/zY87AQtmH1ziPuhgMqU7f4SwNkEWt/pOq+eNqo5A65wllXDY1D7fLC1jrMM+IEELURRfeUnULLAQo1BnOSvQLMSrJUQCzyP5ioObbvH5hiuwUupme+j1ytC8wevkPBRtabhHd+E5bHNHqLqkzyhhFqub4LzbCnRq6vUeQEgJc6bUHKi8FpHgfTVOJTUBEj82VG224CB3+0cIP/tBr/p5ro8yMwf3agk9hFp20yfdeIaODfgogPi8m6isBl1xnFD/DD6m5LBnX+fhjLCg44wnAIXoD/ha8fEb8Qm1jNrENdcufbHwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P4SadKCAqgvuBKkkSvglHFkKVXfNVQ4H25m63L/FRc0=;
 b=io8Apm34vpsCK2nTqdqD/kFSROm5st/jW66un7zS6yUTE8cYv3b/j0Klvj2xuwe5fusdiXJGUu/ZH+x3fZAybVHlqRxVIMwpsH0mNDCU8vVk8RWSfneGD/rSF8AQf+XSMaFK4UZdATkjsTdjQwI0LP0VUsid7Cwqrd+aiXbslih1Mn7bMR42O+BtHg3RbTFhHszb9inhOEpDcqGnDoHJfd/am9B01sD2aEwB6E+gjqB6TmJYmP6c5dPhEtfr9Uf+rJgz74FWmY081dqrWYbLfjPR7qmIoAmL5U3lGHQLz0Ed+4qsaZsaNsTMbgzDCFxJkICdYBbX/CtF965u7jgnRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P4SadKCAqgvuBKkkSvglHFkKVXfNVQ4H25m63L/FRc0=;
 b=ZdV/jjkS27rtpGtsUxNtIjuElJMwe3c6cuo0sMyJWdzzv+tBZpU3RleoDE1zyRJnDA9ZynfR7r8T/KQg13f3DZPb+JbRtRUZyJnMJ63nipmJudtARytkfD2z/idNabCpS11ctR67scL7Qg6x79A1pbe058nlvGWldH0s/rM9/90=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com (2603:10a6:803:46::19)
 by DBBPR04MB8010.eurprd04.prod.outlook.com (2603:10a6:10:1f1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Mon, 7 Nov
 2022 06:38:53 +0000
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::d09d:ac92:bd65:c390]) by VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::d09d:ac92:bd65:c390%7]) with mapi id 15.20.5791.025; Mon, 7 Nov 2022
 06:38:53 +0000
From:   Chancel Liu <chancel.liu@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, ckeepax@opensource.cirrus.com,
        luca.ceresoli@bootlin.com, ojeda@kernel.org, cmo@melexis.com,
        u.kleine-koenig@pengutronix.de, xiaolei.wang@windriver.com,
        steve@sk2.org, chi.minghao@zte.com.cn,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     shengjiu.wang@nxp.com, Chancel Liu <chancel.liu@nxp.com>
Subject: [PATCH] ASoC: wm8962: Wait for updated value of WM8962_CLOCKING1 register
Date:   Mon,  7 Nov 2022 14:38:18 +0800
Message-Id: <20221107063818.2468193-1-chancel.liu@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0238.apcprd06.prod.outlook.com
 (2603:1096:4:ac::22) To VI1PR04MB4222.eurprd04.prod.outlook.com
 (2603:10a6:803:46::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB4222:EE_|DBBPR04MB8010:EE_
X-MS-Office365-Filtering-Correlation-Id: 898f5662-35c6-43c5-a78d-08dac08abcfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2sF8f9niR8wmPL5GO4mDrmMbypiumiIgTfKEosD/oRAruyte+kK9DS/v1bXXyOqWGOGjB4r3f5AGfvxaztplbWZQbjlUlm7GOoTjoNYzjdNqrxPak1gd8mc7X12jA9rX8WJiMfuecqUfQrwYDKWZpXDpmg3c95bfWYE4/25tjiG8pxql2jzlHPqb5a69sC2hPt5VV4kwxBGDo1Ss5w6fXUNsLBCeCEU5hjKCTMp0tcozxmzpnDFTlH16tkKsQSyxA+EqjHfE8n7lnUEL/g8l6mGzPJm6pP8xTezHNiA4gWyDbbW8An2eQ/FbccZWa9IpUzYQ8qglC3+hbjTgiuWnxlNxGpMvsQDW+y01j5TG8r+UE0fnajFMxv0QfL3YKBpUiLWSjlhx0mSR/v+nik2WX9RU7By0ySC9axg0LmSoi/HqCw/20uBCMUqATKta9RP9drIbpcG+cmzgnj7iIBpEc0lQIr9uA1Cu7M14HZP5/hOEQhbbIxx7++bLbIi9V7kC454QfVyzBkRWnif8m4GDOxeOtHDyYfr8WXPwo/bNmmDqIsItsJc+biDh0gkt+Q3Kpqn1gCW06qj/RSak/He75YxtM1xKTbbRvlNTfVxOvpfy9xaoaewSnzwo97cC1l+lMsARZTIoBTakcKuc9DrJXx04a0S7lcuVlLiiGQuGScxtw+niqC9OfGfNW8g7NfJnfD5yKs0JJiODw0yB2LK3GD0WF7MiE7an4BH4Mh8qKSkoejoJEFeZTXgjApnyGcd+Llgun9NHcKMMqpRtYRtS41Fh4WBdXrccFMsrgZ9uXkk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4222.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(346002)(376002)(136003)(366004)(451199015)(36756003)(2906002)(38350700002)(41300700001)(5660300002)(6506007)(66556008)(6666004)(7416002)(38100700002)(8936002)(66476007)(4326008)(8676002)(66946007)(6486002)(15650500001)(44832011)(316002)(86362001)(921005)(26005)(52116002)(83380400001)(186003)(1076003)(478600001)(6512007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IeVAXVW3mtJvvsE5OVxu83r9XdFl4xweNWe/pB19eZF/unxrpi/hrb4jb2lj?=
 =?us-ascii?Q?1inQJtxGHqL07ymLSESAlZsb5tOQvk7z60al4VIDijAX7DmYEvAvhRMxZkZR?=
 =?us-ascii?Q?sRoXygHbVSYh2XBa5EPTg1hu0AP8Bm4eKhNuMT/H8/eH46NqYFCKb4J9FByx?=
 =?us-ascii?Q?9utgts9kTl7q12zepPRcYR8MXV/LkumYHxuizNjzxvqtFWTPsI1t07h9hTwJ?=
 =?us-ascii?Q?7D1KVOvw/KvNjHhsH6LVHOEJiDKirhvZ7bc/EE0yg2objnfS6NnJ7haoZFul?=
 =?us-ascii?Q?31rKQcxLEdQBXoVGsNuTggWOQBqS7xXeWVbeqeM2TFVqYlTQDnf+13phMhh3?=
 =?us-ascii?Q?cZhMv8nPuv0fN14c13F0wzz+iXkItckCRao1+4SNQrZaAhykDM28m52qps2R?=
 =?us-ascii?Q?eqcuN3IrjD4i4ZCWBm6PAFWp96NdHjjLGCSs76DVYIPdURiTFTmtWseBwDl5?=
 =?us-ascii?Q?JMzt2jDS3jyiefbOypLkzAdOy85O3HrjgqkfA4WgG/c+3nQfumbss0j1+ViZ?=
 =?us-ascii?Q?ZwAIcnvHWAqZ3l0AWi2VlpkiLdAiiDGMbGi1501fagTWPgrNbPIh9V0vyDxo?=
 =?us-ascii?Q?vRUbl/73VK7MjgX8Yo78PYWW9Cz+pk1SRkFOvsn9ZHXMXbMBAdBifg9J6XmB?=
 =?us-ascii?Q?8euxKZnUAUjukfAzWoFegTOPr8daqbw1vXuMtTv4QbEXWuBZ0u1i8DOr2Ac+?=
 =?us-ascii?Q?PIbuU+S878+xzj+SXqeNI9YBJ7zioDcAw8TfqGB3a3A7UCobARRL5MfcTu6v?=
 =?us-ascii?Q?PBMC/yz8FKCbudXUNy1L7z1QSyACXpf6DD8fyEvAtTEPYxvq0lJc/Gsw0Pmx?=
 =?us-ascii?Q?n3c1chMAhML2gj+6snoytVmBv7zP5is2YqGcS7qGCdlCS/MZdV3y6jBxxBK+?=
 =?us-ascii?Q?DNLoh4X9ncSdDCfbd8+e5t/Cz0HN65bhp6jiIUCCOWSmPmAWoB+bhYXBjpWc?=
 =?us-ascii?Q?X9yJ/fP3cWvSLemf+VKXTFGbqsVF/A6ksqwJtR1+Sk+C113LnAHdWWjq9MF9?=
 =?us-ascii?Q?DWLRvPcDotCw1zHckJtZBDfaSEXxBRYBEkFEaQWhJsp4F3BSjBqKy0IkQWhp?=
 =?us-ascii?Q?Jik0YhxgulzZaqlnM929a/rcaFmj6424xUeV2KHPqNMt5Ne2AswUV2SGAb8U?=
 =?us-ascii?Q?KASNCJvpLOIL31lLx+SZZvlFAXDa79FmTnyKKLitlvTxTDwa4ESzizblvUT1?=
 =?us-ascii?Q?CWWXkhGt3TxbfTTDpvlAf3SGmZz433Zp0C3YheuhMkh4CYp+cs/Aa67mirLc?=
 =?us-ascii?Q?EjrjJZraX1GKj1PJIMt3M0HWZjS2vSlIa+yfXlqo48vFNv7MjXY07vfiJa9/?=
 =?us-ascii?Q?haG/0Edu/fwXniGrJLpOuLBMDfYIMi8vXn+AvhXD3tXw6xZiKt4OksVcZIWH?=
 =?us-ascii?Q?VYFFsKQC57xh2JyuXEy7cAvXzQ4ytMtLUEni6feYRYbeogh6L7/WCzZKUPdx?=
 =?us-ascii?Q?63yzt3S75O8H0KBc4Ctz1khPll1PaBZR0mnBNklKgzMXRFQ2vfO0842NAAel?=
 =?us-ascii?Q?SoXHsHkTxz3dWlXmr6X5wsItnBj0SHmauCOpHZ4iBtZoifMwZCZR5N7Ul07j?=
 =?us-ascii?Q?vhM/HEtPvYZTOqrj3pAzU0AdVtWtXoTq0YcjuhIE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 898f5662-35c6-43c5-a78d-08dac08abcfc
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4222.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 06:38:53.6759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eNmRQ64Xt3s93fnAHO7N2HvQYlknFlDvYH9mJaMife8f0FKGKoQ0U6D+5HXjgpv5PjjHZg9a1APpw66Syes5hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8010
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DSPCLK_DIV field in WM8962_CLOCKING1 register is used to generate
correct frequency of LRCLK and BCLK. Sometimes the read-only value
can't be updated timely after enabling SYSCLK. This results in wrong
calculation values. Delay is introduced here to wait for newest value
from register. The time of the delay should be at least 500~1000us
according to test.

Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
---
 sound/soc/codecs/wm8962.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index b4b4355c6728..563843565f68 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2503,6 +2503,14 @@ static void wm8962_configure_bclk(struct snd_soc_component *component)
 		snd_soc_component_update_bits(component, WM8962_CLOCKING2,
 				WM8962_SYSCLK_ENA_MASK, WM8962_SYSCLK_ENA);
 
+	/* DSPCLK_DIV field in WM8962_CLOCKING1 register is used to generate
+	 * correct frequency of LRCLK and BCLK. Sometimes the read-only value
+	 * can't be updated timely after enabling SYSCLK. This results in wrong
+	 * calculation values. Delay is introduced here to wait for newest
+	 * value from register. The time of the delay should be at least
+	 * 500~1000us according to test.
+	 */
+	msleep(1);
 	dspclk = snd_soc_component_read(component, WM8962_CLOCKING1);
 
 	if (snd_soc_component_get_bias_level(component) != SND_SOC_BIAS_ON)
-- 
2.25.1

