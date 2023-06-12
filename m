Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5082A72BABA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbjFLIcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbjFLIcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:32:06 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2089.outbound.protection.outlook.com [40.107.13.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8A8420E;
        Mon, 12 Jun 2023 01:31:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKSRcY1S7K8BaZ8qCsuxC3yR2a2p40azwfSNpjGIcswFarm5cjECp/qNymJtFyWPUX27bUa/WhxKm0YHaYHmsg1CwCaJTRycgWELVgeaNxOapM0lQqabjzobsX0G4Yax1nToFn8pF/qIqTFJJmoM2YKaStaDqEPHGajx4n2rxRmQhjcPTvMXaJ5umUqnZ2OhsNoDFkXXuGWWBKYhgdO3+ibGiLSTs2O47YRz2TY6380/hEZ0Lqj2MVEul8UN4tqUAUKLq5O7lqjR2sJwsK+jk3jOTaZNcwV1mFBGd6qVJ10+2CovcNpO8APsM9MGUuxcYC3n4Zz6oGs2EePY9FIkng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7LDj2rBEp5/c/c79dm6qOhCqF/RIWGMuy0fqzBVNyBY=;
 b=dy2YQW90ZXkVGJFF0uv4sXbY0he1+1BzRqp/b2h9cXO0NM8WNxOzeTZINjcOqYit1DSiF9YOzjxi7tSx9dbkdf0a1xIm/svEJxo6ClQwLQ/MyavEptk5/TfbAqzbdJEAYWep48+qy6eDIs3A0vCVtiJEGhnZebIFgjVI332tOnH/aoLPhBvgcvWRcXDoWeW7Nb6LH9GMx+cUBJzD2xDTWgi2V04Ni+OUgcaCcNm68ktJ+RhuMebT8cmuhfyJVEsKg19+dKrP7Lv6HzZdrxuk9d8lOmY6OrVEPE6ha1NM+GD/5yDZgyfyQVC/N8VFFwfSPri8LI1mfaQWLP5oBEl7Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LDj2rBEp5/c/c79dm6qOhCqF/RIWGMuy0fqzBVNyBY=;
 b=svWNpLRAEaWjre5YYa8hZdRwj5AtD5c4B+CdQm2BE7IMG5XN09ZbI007UPIvWxOVo5bhedzfnVkV4ZuO0BghZk0ok5vPwb60RZodxno30jChgYKQ29pINe5PQiM2t7aChQ+8w6Fylxzndik8xWJdSVIVimz/ktSDjNdzK5TXthk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com (2603:10a6:10:314::7)
 by AS8PR04MB8930.eurprd04.prod.outlook.com (2603:10a6:20b:42d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Mon, 12 Jun
 2023 08:31:01 +0000
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::adc3:90c7:4b37:392c]) by DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::adc3:90c7:4b37:392c%5]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 08:31:01 +0000
From:   meenakshi.aggarwal@nxp.com
To:     horia.geanta@nxp.com, V.sethi@nxp.com, pankaj.gupta@nxp.com,
        gaurav.jain@nxp.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Subject: [PATCH] crypto: caam - optimize RNG sample size
Date:   Mon, 12 Jun 2023 10:30:42 +0200
Message-Id: <20230612083042.1256966-1-meenakshi.aggarwal@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P251CA0022.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d3::14) To DU0PR04MB9563.eurprd04.prod.outlook.com
 (2603:10a6:10:314::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9563:EE_|AS8PR04MB8930:EE_
X-MS-Office365-Filtering-Correlation-Id: da55d51b-f565-49ca-8969-08db6b1f5aae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: un3re87PFLck/Il8s0rrEDBGL8M90FZrumukPtvCeyaml9jqhF7opsheYIB+qtAQY+hr97T9bQc9RYGTvEl9+iSAqm+zUZWSmfXxujhTF6gpgOsUczzhhRZ7gDIAUzDdQRWiEuwTdPTZppg2VFPyaS4BUj6VvaAZnB4TZEY/7MdFZoRkJ1KOf4Q8XUTqVyZfOy3bX6UsqXnFzCDu/U0UHXy1YY//tN+i96+nKl2YGcssvZCf+LGcMe5JFBgpbemXB2yEutpZ3VjPICr1VLEpoBGgrv+S5JlYLwC6r/Iut4MHtOQwJtcF+/oaOrCqkf6Vwga2TxgFAF+pqYgZwDdcvbWkVYg6T4HAOG2GjnpO7k2ap9vVdEoWmKomA25UDFlUjHRQN2Jsb7jso+NkOGBXFzgKq2vO3/xfma2ZN/vmgr6232abt4zi9i0bv5SsSB6DtIX+dKzxyIl+/TOQ/NCFUNUMe1YJfNBxd/zjZeVG+RFWTIAhvB29T9z3zbYQ3fsmX12fLvJPadvYVFnmP85eIJ1pWmlt+fkTRgJ0DE7O+V1EPlt5mN7C2opZCIWO5JkdLJi7rhsuV/d7tl9mx/IBoOaYs5+J08s4zT/9PAY0ByC5U0R1Jvu9izCWWxSSvlEq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9563.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(451199021)(83380400001)(66946007)(26005)(52116002)(6506007)(6666004)(6486002)(9686003)(6512007)(1076003)(478600001)(186003)(2616005)(86362001)(2906002)(8936002)(8676002)(5660300002)(36756003)(4326008)(41300700001)(38350700002)(38100700002)(316002)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjFzUGpxUkd4R0hjQkc2ajhYK3JaSHN5ckxDazU3RnVDWEQ5V21XNno1ajYy?=
 =?utf-8?B?dWdtYzlWS0FXcjJFdmxRdXdpbHo5UklsSGFzZ3NBcHN6cjdqbTBOTnRvSUdr?=
 =?utf-8?B?SHZmY2xWbFdhcDlyZGVoWnBKTGltYUJzZDRNODRPQWRqTE1sVDVwSEZBRE1M?=
 =?utf-8?B?Qk9sb2l5OEwwYVEvQy9qWXl5SWxYcjlnZVZFSlpoalVCNU9TaUxqNzJOTzQz?=
 =?utf-8?B?eDFVbTEvVlZ0a2RMMHBKS0drcmZhOU9nc0JQcXc0OFpvUVBMeW9jRmdsMnd5?=
 =?utf-8?B?NjhVMjFRRk5aT0gxdHNaYlNtRWxpSWpJY0VWb1pNa2JMOHBaaHhtbVNGbjVp?=
 =?utf-8?B?WWpFeTRuR2xNdEl3TE4rbk9FRGFCMXZrYWFwbkJtZHRqd2FKRnlHbzlVdTB3?=
 =?utf-8?B?Nm9yd250dS9tUy9Iak5kSGd1RXNleThyYk1USFdBZWhHV0Z6dUNmbW1LRWdr?=
 =?utf-8?B?ekRweWRNL1M4azJEQ1JwdVZLWUY3MFBMMGtnd0IvTWlEa3dRVTQ1QlVzL2lw?=
 =?utf-8?B?SXpJMkk2Wlo2eGYzTVd4enhKUVcxOUM4bERuWWVyMFovNWtpUHN2NHBMTWFC?=
 =?utf-8?B?VC9WejlZL3VlR2NpY2dFS3RsTmRCT3R2QzRxbEVTa1dNR1NMZFBRN01tMFlY?=
 =?utf-8?B?K3k4ZEJ5WDVhNE02T1hzRWIrWk9jUmc2bWs3dWt0UmpxQStzaStXKzNXYUlz?=
 =?utf-8?B?Q0hDdVUzVTNyNVhHNFBxRE9NR2F5YTBNNlpsME9WVFZqaGlxNlViSDc1bFJL?=
 =?utf-8?B?MUxqMlVVaHZwVi8yMGw5MGtic0ZxYTlxSDNUZmhqSjVWSWlnNlFETFFLN1lR?=
 =?utf-8?B?VFltYUVMNHdyMkJ4Y1hUNW1NVjZLTGNuL2N5dTIvbjNmcjd1REk0cnlwT3Zn?=
 =?utf-8?B?ZnMwdjJmSFBTdTBiK1dFWFowdnpmRlp5RVlLNTNKc0Ezb29qcEsvaU0rSEZp?=
 =?utf-8?B?M3E4RXo4RUV3YnN6U3owMTh3cWdqNTNRaWFQUUZ3TDcwaG0xcHdHVVg5SlVH?=
 =?utf-8?B?RGpaV2ZYZHlTVHFNdUR1WHBqS3N2VlhBaC95MEdPMVBnM2dQVE5XZjV1eE9t?=
 =?utf-8?B?WFFhTU5EQlE4QXIzWW5XdlVwdllvbExhOVNVaEJ6R1l5SzFMOFc0UkxwVmlX?=
 =?utf-8?B?VzgrcTJ0SFltU3FETFlRRlg3NXdCczZtTWFxcnY1OVhmb25WSHFtcjlFTGs0?=
 =?utf-8?B?ZmlLMUJYZ0EwYVc0eVRUNFJnMUpROC9BbDhOWGV3V2t3OS8wa0d2dmpWSzBv?=
 =?utf-8?B?ek1wZWpONWQ3WGRNdnNreHJlSkZwc2R0TmZOZ093bWRNZVNUV2xSa3hqVTFK?=
 =?utf-8?B?enRBQVlLWEVLQnhNOHdLMjZyMnAyT09rVGtRc1M5NmVKU0J2d1l2M0dqK0xU?=
 =?utf-8?B?RzVoNS82MS9ST0tGaEc2OGdqNHRDcEE1ZnA3TE1GTFpXdnp4WXBoNkc2TGdF?=
 =?utf-8?B?SE5iZGYzSGFWdDY0VllVU2JMUE5wT1k4dEZsdFV1R0tKZTVYSWVXWTBJOHpa?=
 =?utf-8?B?NEZmcDZLTkV3ZitvcDB6bUVROUJEc0NVaUNBSW40V0VaWHhrai9ya1BTNFl4?=
 =?utf-8?B?QS9yclVBeHhnTnVEY3lVb1BNZlhib2ZwVTdrdTJwdzBzakg2UktzeUIxT2ht?=
 =?utf-8?B?SkNrRTJhVzVheEdQRWdqSWNXUDhmcVJqV2VIVHoyTWxmS1FrdW1yMytVdWZX?=
 =?utf-8?B?YW1COVNBdVNBRWFnYm45cEVodlV1Uk1ibFlvZzBJaGpkdmVxVFAvRnBIMzBZ?=
 =?utf-8?B?YjkrZ3hDWGFudkJHQlAvOWhPeHJyTm9JQWpnRFVWRXhvbERZTEZkZ2RZTENu?=
 =?utf-8?B?Y2FBZ21NNExoZ01XQy9jVk1IWkdwNDVYNWF2Z0prVjNnOGZqRjlUTnFOWjBX?=
 =?utf-8?B?Q282ejA1cUplYktTTVFPUkw3YWRpVGVkMklLK25ONy9TV2l1MnpHMDd0eGFi?=
 =?utf-8?B?WFVBTmdIeUdhTlJCV1IyVmx6M2Rtc3RRZTBiOVR5UW5hcDFsaEs0TG9uc0w3?=
 =?utf-8?B?Y0dkTFJ2YTcxUTNIK3FWSVhyTmxUd1k2MFN3dkJXUDh5M3Yzc2RjN0lqSHp0?=
 =?utf-8?B?a2F4b1B1eC9sSXliM0pxNlFFaG1nZkozdWs3L1JtT3NjcFpGaGpNT0ZMMnhC?=
 =?utf-8?B?RjVMSjJBRGIxczhabXA2NWVDZW1VbVFCbmFYUW9BZjlwTEhTeklyejRib2p2?=
 =?utf-8?B?M1E9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da55d51b-f565-49ca-8969-08db6b1f5aae
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9563.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 08:31:01.3910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UpJIR0VVqL3493v/NMd5XaV+ClC+yVetAwEdPxR3Y78GCZj+k6NqKPbuD/MwbYL8XCLIduNpBL6vUBZpwjb9xw0n3ZirzoLTRbg+WZjAB8k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8930
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>

TRNG "sample size" (the total number of entropy samples that will be taken
during entropy generation) default / POR value is very conservatively
set to 2500.

Let's set it to 512, the same as the caam driver in U-boot
(drivers/crypto/fsl_caam.c) does.

This solves the issue of RNG performance dropping after a suspend/resume
cycle on parts where caam loses power, since the initial U-boot setttings
are lost and kernel does not restore them when resuming.

Note: when changing the sample size, the self-test parameters need to be
updated accordingly.

Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
Signed-off-by: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
---
 drivers/crypto/caam/ctrl.c | 52 +++++++++++++++++++++++---------------
 drivers/crypto/caam/regs.h | 14 ++++++++--
 2 files changed, 44 insertions(+), 22 deletions(-)

diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
index 62dd069942e4..b06bb64c6c23 100644
--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -352,7 +352,7 @@ static void kick_trng(struct device *dev, int ent_delay)
 	struct caam_drv_private *ctrlpriv = dev_get_drvdata(dev);
 	struct caam_ctrl __iomem *ctrl;
 	struct rng4tst __iomem *r4tst;
-	u32 val;
+	u32 val, rtsdctl;
 
 	ctrl = (struct caam_ctrl __iomem *)ctrlpriv->ctrl;
 	r4tst = &ctrl->r4tst[0];
@@ -368,26 +368,38 @@ static void kick_trng(struct device *dev, int ent_delay)
 	 * Performance-wise, it does not make sense to
 	 * set the delay to a value that is lower
 	 * than the last one that worked (i.e. the state handles
-	 * were instantiated properly. Thus, instead of wasting
-	 * time trying to set the values controlling the sample
-	 * frequency, the function simply returns.
+	 * were instantiated properly).
 	 */
-	val = (rd_reg32(&r4tst->rtsdctl) & RTSDCTL_ENT_DLY_MASK)
-	      >> RTSDCTL_ENT_DLY_SHIFT;
-	if (ent_delay <= val)
-		goto start_rng;
-
-	val = rd_reg32(&r4tst->rtsdctl);
-	val = (val & ~RTSDCTL_ENT_DLY_MASK) |
-	      (ent_delay << RTSDCTL_ENT_DLY_SHIFT);
-	wr_reg32(&r4tst->rtsdctl, val);
-	/* min. freq. count, equal to 1/4 of the entropy sample length */
-	wr_reg32(&r4tst->rtfrqmin, ent_delay >> 2);
-	/* max. freq. count, equal to 16 times the entropy sample length */
-	wr_reg32(&r4tst->rtfrqmax, ent_delay << 4);
-	/* read the control register */
-	val = rd_reg32(&r4tst->rtmctl);
-start_rng:
+	rtsdctl = rd_reg32(&r4tst->rtsdctl);
+	val = (rtsdctl & RTSDCTL_ENT_DLY_MASK) >> RTSDCTL_ENT_DLY_SHIFT;
+	if (ent_delay > val) {
+		val = ent_delay;
+		/* min. freq. count, equal to 1/4 of the entropy sample length */
+		wr_reg32(&r4tst->rtfrqmin, val >> 2);
+		/* max. freq. count, equal to 16 times the entropy sample length */
+		wr_reg32(&r4tst->rtfrqmax, val << 4);
+	}
+
+	wr_reg32(&r4tst->rtsdctl, (val << RTSDCTL_ENT_DLY_SHIFT) |
+		 RTSDCTL_SAMP_SIZE_VAL);
+
+	/*
+	 * To avoid reprogramming the self-test parameters over and over again,
+	 * use RTSDCTL[SAMP_SIZE] as an indicator.
+	 */
+	if ((rtsdctl & RTSDCTL_SAMP_SIZE_MASK) != RTSDCTL_SAMP_SIZE_VAL) {
+		wr_reg32(&r4tst->rtscmisc, (2 << 16) | 32);
+		wr_reg32(&r4tst->rtpkrrng, 570);
+		wr_reg32(&r4tst->rtpkrmax, 1600);
+		wr_reg32(&r4tst->rtscml, (122 << 16) | 317);
+		wr_reg32(&r4tst->rtscrl[0], (80 << 16) | 107);
+		wr_reg32(&r4tst->rtscrl[1], (57 << 16) | 62);
+		wr_reg32(&r4tst->rtscrl[2], (39 << 16) | 39);
+		wr_reg32(&r4tst->rtscrl[3], (27 << 16) | 26);
+		wr_reg32(&r4tst->rtscrl[4], (19 << 16) | 18);
+		wr_reg32(&r4tst->rtscrl[5], (18 << 16) | 17);
+	}
+
 	/*
 	 * select raw sampling in both entropy shifter
 	 * and statistical checker; ; put RNG4 into run mode
diff --git a/drivers/crypto/caam/regs.h b/drivers/crypto/caam/regs.h
index 66928f8a0c4b..189e74c21f0c 100644
--- a/drivers/crypto/caam/regs.h
+++ b/drivers/crypto/caam/regs.h
@@ -3,7 +3,7 @@
  * CAAM hardware register-level view
  *
  * Copyright 2008-2011 Freescale Semiconductor, Inc.
- * Copyright 2018 NXP
+ * Copyright 2018, 2023 NXP
  */
 
 #ifndef REGS_H
@@ -523,6 +523,8 @@ struct rng4tst {
 #define RTSDCTL_ENT_DLY_MASK (0xffff << RTSDCTL_ENT_DLY_SHIFT)
 #define RTSDCTL_ENT_DLY_MIN 3200
 #define RTSDCTL_ENT_DLY_MAX 12800
+#define RTSDCTL_SAMP_SIZE_MASK 0xffff
+#define RTSDCTL_SAMP_SIZE_VAL 512
 	u32 rtsdctl;		/* seed control register */
 	union {
 		u32 rtsblim;	/* PRGM=1: sparse bit limit register */
@@ -534,7 +536,15 @@ struct rng4tst {
 		u32 rtfrqmax;	/* PRGM=1: freq. count max. limit register */
 		u32 rtfrqcnt;	/* PRGM=0: freq. count register */
 	};
-	u32 rsvd1[40];
+	union {
+		u32 rtscmc;	/* statistical check run monobit count */
+		u32 rtscml;	/* statistical check run monobit limit */
+	};
+	union {
+		u32 rtscrc[6];	/* statistical check run length count */
+		u32 rtscrl[6];	/* statistical check run length limit */
+	};
+	u32 rsvd1[33];
 #define RDSTA_SKVT 0x80000000
 #define RDSTA_SKVN 0x40000000
 #define RDSTA_PR0 BIT(4)
-- 
2.25.1

