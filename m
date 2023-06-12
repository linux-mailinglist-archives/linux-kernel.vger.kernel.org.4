Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D45272BA7C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbjFLI1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233236AbjFLI0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:26:45 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2074.outbound.protection.outlook.com [40.107.105.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED4CE64;
        Mon, 12 Jun 2023 01:26:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wka54C072L8Mzsi4FOpqq4GrL+krtB5/TeJeE/thcG2fjJIw5jbF6edD2gcjETAT7CrwUAqGr5foGT7mY6HuDa+4VGVAwoSTN2qFHkBI6qhORG3ONU8BSPc5rHiD/NTsP3no+Kkmox/IoN9npxIfCrQh+kjEdNHtUWjue2RmtjIG4HWEN3N/y9eJ4j6lCfJK/VLqmZAB4MQQyCbSL29Sf9/KCpPf4GVFNXJf6mtdfNc4e9tbQtCTTd1spWByrJpDN3+s10UYIyXv7mntOJZMPLd2C68CFWWKq8tEhglUrQKdEhOV91GFJefvNUlEjRhJ5iID46r2s2L1t9TObJTwIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2GUfq4DfF02m81H3rwkS5ZRgC/qEvG0Gr9SdoU6yEVc=;
 b=iGTBtnQ1Hng6rCM1NcZq4zSTpkMnGiwWwbHVlm0uQ56uY2bXXzkD5FeSg2XWr8XnPdDKk27G5PffswypDIltr9njWeRx4alafuiqOnuwrqeuYTfW0MboN1dr1x+8hYNTx+CqzXtEcc3yKm9fkY/T+GtdqqKLuabGth0wdk88TynFWhOs1B4+DAJhHmXyqKOdL9ii78fX/wlidA3uzmH0xl5F8hnI19S+YZhAZdy5by1+BEb33q9g1DF3GDMhdzmU4kTXu9hqDfXbiVNcHG+DNhuxF7ZkabSIxpaeJgPd2JgPu/zAgWJbIOcrstXfxT7OmZOKL7qP4WIsf4a76l0kwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2GUfq4DfF02m81H3rwkS5ZRgC/qEvG0Gr9SdoU6yEVc=;
 b=a3IpqrWZvO3DyUsgzoaxSKqfClWqEZy0YS8kDXXBvFRVJoF9fd1MVXSn/qPCeI0CdWLtUox4khqMxYkCrbVQnHkS9XLZNv6Lk85jrK5v1j7yv8+LCBxgmm0hTvaEvrSoDyXXdN0b7WZdFHKurTXR1KBWCplN0ITymEw72eAVe9s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com (2603:10a6:10:314::7)
 by AS1PR04MB9429.eurprd04.prod.outlook.com (2603:10a6:20b:4db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 12 Jun
 2023 08:26:40 +0000
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::adc3:90c7:4b37:392c]) by DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::adc3:90c7:4b37:392c%5]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 08:26:40 +0000
From:   meenakshi.aggarwal@nxp.com
To:     horia.geanta@nxp.com, V.sethi@nxp.com, pankaj.gupta@nxp.com,
        gaurav.jain@nxp.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Victoria Milhoan <vicki.milhoan@freescale.com>,
        Dan Douglass <dan.douglass@nxp.com>,
        Vipul Kumar <vipul_kumar@mentor.com>
Subject: [PATCH] crypto: caam - adjust RNG timing to support more devices
Date:   Mon, 12 Jun 2023 10:26:15 +0200
Message-Id: <20230612082615.1255357-1-meenakshi.aggarwal@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0014.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::18) To DU0PR04MB9563.eurprd04.prod.outlook.com
 (2603:10a6:10:314::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9563:EE_|AS1PR04MB9429:EE_
X-MS-Office365-Filtering-Correlation-Id: a316acff-5381-4344-3828-08db6b1ebf52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A08OUa4vPrUOCDWI3XmkvuGiQdAeFwHdV1b3QIkmcTvShg8ymQJipZ/2MPAu1pq8JGC1ygpAyPBjr9fBdqJc3JgbgcKYsHWx0KAo+bblGZgcQdtmPTyiW7OP2xXrgPXZV1d3YMwT92ks7AMgB3wEr/VS3ASSyk9NIM/PaznKM6VBxhE4P8/nkpqCvpCwq2jIwUrq+npg226M4Z6R8DUNXfXMmlvDUWn44utwDI98+SDhN8YIKkgeuyFeNSvepgQ4qg3T8JASPP/qUBfifU7ZzWjXozBzkbJxJfp8B1nnUfli1dQUBAF0bk9LR3owPwc/XQLkq4YKqCCmP9i6Csm3DyhdjHOQRvgWR4G1zaapUYas619bY3PgbBsvW3SW7U+V0W4fUD+07twvMddBSO+ZMSfsBbGLPYg27ti36g24vZmPQ3180vD75BiEfSX2HnLpUkwtf7Ks3MkcHCOyFLND6Iyhw2WKFCR9JksDZsqCihinMSTK67hRX2UzXc7XTsuXhfML698RtY5uwYWsxu2d14duW1AzDj+l+Gk++LuqwxVR5HZ8lvkpj5GtSltvcvCrS/pR4F8f8SaYBm6xsXsp492BwyTq7MhG7EXi+dm2lokEXADR8XVG8ac5P8xFcs2i
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9563.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(451199021)(36756003)(86362001)(6666004)(66556008)(54906003)(478600001)(4326008)(316002)(66946007)(66476007)(52116002)(6486002)(8936002)(8676002)(41300700001)(5660300002)(2906002)(38350700002)(38100700002)(2616005)(9686003)(6512007)(6506007)(1076003)(26005)(186003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDhuZXFZZjVxUCt0V3hYUzQrVk5MdXRXbUNaTnBLVU5QQitwUmM5Wk5nZmFQ?=
 =?utf-8?B?bnZzRTFaVmdWeWlWNmhGaW91U3o4bjNES0dUcGdnd0tmMEdlTXZnQTY3Wi9J?=
 =?utf-8?B?QTloVnJPT3dmMGtjQkRpWmptdzVFVlZjcWdMUmdNa0tBSzVJM0QzWmJjN2w4?=
 =?utf-8?B?TnNhV0xJd1FETkozUDRKcGZjKy9vUUZVVElaTWxIOVlrVS9oT1pzNkQxM2h5?=
 =?utf-8?B?WVJVeU5hMjJXRkpHTGpKQTVNb1VNc3hqQjN4WlBMRW9DWk95amtCUnZvdXNX?=
 =?utf-8?B?UXlsdWNSeUlyT1RMM21TK1Z0cHZsLzR1dS9wTDA0Q3E1NzB3SXFVcllPUVgr?=
 =?utf-8?B?UHZ1WXExOXB6MlhhK3RMa3pGeURUVFdFYzRyRjN1YllVMUNmKzUzU3lTWWZi?=
 =?utf-8?B?YUpvTnFNcktKMTFEUHcrZ2RRbS9uVWdIcWE1eTVjV3NnektoMXA2WWdEZXll?=
 =?utf-8?B?NEtlTU93amxnQ1ltNlpFVTRMR2lIVFFoU2p0M3FacU94TXl3NHZxanJFcXg5?=
 =?utf-8?B?YmJCN0FKMlNCNnFLV213Y3l1ZjlISFFldVVUQ0ppcHFOd0VPYy8ySS83SDR4?=
 =?utf-8?B?cS80azk0UkduNEdXYVlpbDNnd25DSnhocXczZlJYdkR3WXR5WkRBN3RPem5P?=
 =?utf-8?B?T0lVWXRnT2UzSm1aSkliVGNCWmIvQXZHQTc1WmRkQkhSRGRBOW5GS1hUcnlo?=
 =?utf-8?B?dmRrUElaZHQzY1ppVi91N3pmQk5lY0lTQW4yWnVSd2c3VG9UTGFxT1dvTFJh?=
 =?utf-8?B?bDVyVDZaRXVFcHNEUklXRUNsMEpOYTBkR3AwdDBTbmFuajRpclJ3K0J5N3c1?=
 =?utf-8?B?ZGhYR2JZYmhDcHl6YnFyU2ZMS1BzWW1jRm5HcFJjRXVOYjhwSHVFbERZMDYz?=
 =?utf-8?B?RnROWEZBOWwwbWNoM3AraUlQWHQ2ZVlsbDdwUHZiZENjK3laR0cza01NMTh0?=
 =?utf-8?B?Qm85Nk9nZjlFOTdsblVIYURRaytmNWtINEkwMFlBNjN4R0dvRnUxekMvZFdC?=
 =?utf-8?B?WGNybnNRVXdyK0dPYXdvUU44RWplcFlrTVhBTFQ0QlUwZFBybTVvcThJWDZ5?=
 =?utf-8?B?SEw2N2NpUklkb3ZxUm9Ra1Y1RnJWYmdLUFU1a3NRYXlXNmhULzI0WXRMUGhG?=
 =?utf-8?B?Q2JyUVpESGx0QnV4d2ZjeTM0eDZYYlc4dEZ3VGl3Vk0wZjFsMksyN0k4bFRR?=
 =?utf-8?B?YktkNi9SZzB6c0NKVUtBWEdLbmRka2xjRUM0M2hmZmVDYkRWcUxJamRzV2Na?=
 =?utf-8?B?YmJVU1Q2TzRQK0o4MWtGU3A1NFgvUjB3RDREWnp0K21LWEVxSCtjUGdEZ1dn?=
 =?utf-8?B?bk9UeDBwUUR3YnBVSWk2WFRsM0lTNFFaSmJiMWRSQUtZUkR1WjNlUk1DSTIz?=
 =?utf-8?B?YTFnMm50dzBjRDN0Wkp5ZUhjalBycVVKdE5kK21BWVE5MUJMZ05HbGhER1U3?=
 =?utf-8?B?Kzl1KzhXZFlmdjNOck4xN3V3bmE5cEFiVkVQVmpWNUpHbGpNMm9QckxDUXRx?=
 =?utf-8?B?bWZzOC9FRkk2enkrNS93c1ZZWWZFR3p2VkorOEh5RDZGbzZmdkx1eFBuZU5u?=
 =?utf-8?B?d2lGUExhQ0tWVjFvRnl3cHpoVS9vNVY3OEpseE1UYk5OVW1XcXJRbjlRbnZ5?=
 =?utf-8?B?RitBTmw2RHE3YnFGdlJRMlc5bVN6L0ZqZE1qc29XNDc1RDZvcnhHV0NTS1dX?=
 =?utf-8?B?SS9mUkFDMytKMGR1TGI2R1ZybnE2b0lhYllwSHdBendYU2FXS3A5bzdXdnA2?=
 =?utf-8?B?TkVyeFhYTUw5aWMxS1A3TzBNT2pCajZKMGprazkwNWFWNU9mMy8yc0l1M2xW?=
 =?utf-8?B?dDIyZUZIUldMcHdmMXdPNkVTaSt6TmdUcXB6cW5xcFpMM0ZHdUwwRUthRkxY?=
 =?utf-8?B?bEN6TUdRbkpYQXgvNVJnMWJuWEhVTUIvRnRZR3dVQklOK0NieDQveXdMUDE2?=
 =?utf-8?B?NHM3WWRsOWt0NGsxM3R5RlBOSldhdVhEYVZRQy9Td1BTcUNUaVFvRGJKUFBV?=
 =?utf-8?B?SWZIVVMxc1E4UHJNRWkrWlM3MEdlSUl1TkU1ZGJGd0QxcFE4d2xSUXlJR0dO?=
 =?utf-8?B?WGpXWUxrTHdnTTZTTXJMMEpzaU5QRi93VkI4bWtnRHV2VFppYzA5SS9FWTRV?=
 =?utf-8?B?WXo2b0lIU3ovNDhXaU9OMktxak90WjNHZ1YwSGRBUHA1NkJKWXRPL2FMU1Vi?=
 =?utf-8?B?aFE9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a316acff-5381-4344-3828-08db6b1ebf52
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9563.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 08:26:40.7811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sFAQJ6fwvfcHK3ZggkZE+kvPbr/mOfoPqH03rr5aiiJ8yPBdq7ECcw478Up/MW87cWa/tHecg9SetpZ1wRnh1+W4wJ1IEi60AHMm1Spr6Ok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Victoria Milhoan <vicki.milhoan@freescale.com>

Adjust RNG timing parameters to support more i.MX6 devices.

Signed-off-by: Victoria Milhoan <vicki.milhoan@freescale.com>
Signed-off-by: Dan Douglass <dan.douglass@nxp.com>
Signed-off-by: Vipul Kumar <vipul_kumar@mentor.com>
Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
---
 drivers/crypto/caam/ctrl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
index 5fed3cf354c0..62dd069942e4 100644
--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -383,8 +383,8 @@ static void kick_trng(struct device *dev, int ent_delay)
 	wr_reg32(&r4tst->rtsdctl, val);
 	/* min. freq. count, equal to 1/4 of the entropy sample length */
 	wr_reg32(&r4tst->rtfrqmin, ent_delay >> 2);
-	/* disable maximum frequency count */
-	wr_reg32(&r4tst->rtfrqmax, RTFRQMAX_DISABLE);
+	/* max. freq. count, equal to 16 times the entropy sample length */
+	wr_reg32(&r4tst->rtfrqmax, ent_delay << 4);
 	/* read the control register */
 	val = rd_reg32(&r4tst->rtmctl);
 start_rng:
-- 
2.25.1

