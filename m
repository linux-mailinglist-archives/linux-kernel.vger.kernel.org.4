Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F50660E445
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 17:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbiJZPPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 11:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234479AbiJZPPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 11:15:03 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2076.outbound.protection.outlook.com [40.92.98.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328F133374;
        Wed, 26 Oct 2022 08:15:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mvXNKLt+szKOjJjGwp496Q9wFvv/7WEFIeN0jfoitve/6yWwZ9mx1plfZHMgZ2vhlqiEuAW5LUzDo8PKkXb3mbOBiEmitKpcZKqvZyLe+7zFUXYjP6fLa0NmspysVov3UenTvE6G5F0zKmqMuGa2/f28VEXc2BcjDNdoE4L6Z4ZurnSyD2dcXjGXExZs2Y507qxW8+D20XIA+Oi/57dvrixpsFVMAS3JAdoUlkB/tJz91NvnnOSvyDT9ceOpj94pQ5bTxAZL8o25YOXC57bpeGrYhrQTp/TM1gbp/Z/BfwXkSn90qbkymMafi6G9wPUT8RKC0rmo4glFIGi+B2fwlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ulOj1YnM6PAGnJqoucXx6hZyUUZwGh3j9S5ZMoReXfw=;
 b=PnDE+jjQG/8PaJ+2C3W3R7YiZ7boT3AXYI175GQnxD8cqgBGYPMVeapXmO4DlJGDXsWPi7ahlGnTzVQW+mNJSFzbuEmp7t1CvU8iYk3kwBUCt5O8RdTYYgIik26cbmSDwfl8GU3kuCXxt5DIh+3XIxd5hQzoyXI/9MBXXWRZ/JOATuAYJ+JxQUZ1m6fNwq3H9ymbBvchKjG9y+T4ZqfzNCN/BA5aeYwzCYrZIf4BIMOa+QiKC91+r6L70Cjhxtx80zSyOhXF5k3mlWjeYGStXI3JRmut4q6N/i58CrAwek4PypnwZvc78FqSS1D6NsYKo8vlLRT2auohWcElteIV5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulOj1YnM6PAGnJqoucXx6hZyUUZwGh3j9S5ZMoReXfw=;
 b=TwBnxMtovIlt6ABTTZMnaCswrB8WMU40GgSzMa7xn6n9Z9K7QwauqIGxVy38q05St8rXgab+qa1hYHNM9vMsqhMMJNf4bJ8E88t2OZ95K3h4LnaEKCCX23UnKtsMSClFMUqBkMslJkVSifz6ZjRYon4SakFpJvuAJoB6I/TC37+RjVLW3k22YMeiO5NdfTF6MBNjUKoBbuPAnCtaJAclSp33eh8LVNUlDUgz4CAdt8IbAWGEIiFmJhw5H1z/sWRZXm0nUq5iUw8TpQJb7My+W19VMyWLv1ButVcLXx+UZ15XC7fWQBkSKMOECkVkGZTKnHvKJoSEXzdfigsNIC4gCw==
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:152::9)
 by TYCP286MB1756.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:11d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 15:14:59 +0000
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::4722:62da:4861:9d73]) by TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::4722:62da:4861:9d73%3]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 15:14:59 +0000
From:   Dawei Li <set_pte_at@outlook.com>
To:     axboe@kernel.dk
Cc:     hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dawei Li <set_pte_at@outlook.com>
Subject: [PATCH] block: simplify blksize_bits() implementation
Date:   Wed, 26 Oct 2022 23:14:46 +0800
Message-ID: <TYCP286MB2323169D81A806A7C1F7FDF1CA309@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [TIpoowrWW5cdtGWtQp56rVRRu8UThlMfSrye1qb/IJU=]
X-ClientProxiedBy: SG2PR03CA0107.apcprd03.prod.outlook.com
 (2603:1096:4:7c::35) To TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:152::9)
X-Microsoft-Original-Message-ID: <20221026151446.700736-1-set_pte_at@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2323:EE_|TYCP286MB1756:EE_
X-MS-Office365-Filtering-Correlation-Id: a9d8ff43-52c5-402c-06d0-08dab764d8ba
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9XmqoBV1gSYdwKgf2JzaEM+p/V60CjNbcLTV/TAw8Tf6FSPBhhwm4/p3B5IjFKcJ9W0mELPqs/jnbge56L2EEygSKummp+RH4GTfruf7W718+vIyAIezOasLuFpB83nNaU9MwPPDqC7yLM51IbHn4WhOGu0djBGfKNooIV708IAB6jP840Y68KOJVFj7x+ND3koty+cpie33ZIFroifB7fkRrzf3hYRBJy4JGVR/uGkzXxp67/mx2X0Y2aafRzJD/z5+PKm4aC4PsFS17k6+f7Lh44/F1nPzBG3Umnk5nkvsCtxblLuzh3uKWg06Nv3KclhsMZyzJ4xNo4I8owpsF4tPSIKQGA+uITAxvdfyRruFK8U2QzHarEJrQtHF5iMhr5UOA4T39gmIIatdYNaPA4zSNFWRegmEne9+lLUqm/7XMRJb30g0XOEToGVWRbtvV4wm1xDKjaTn9o74pMqJsN1ku3h9My0j2fI5vLRX/n37+YMK+gv0ZTUqZxVpYXm/xPpsAPV2q08fR/AkthcIBto2bbaUwU7tjnT8fc3gjurxlqP1csOqHQQ+cTqiX1Mezbe3iJS0XaOogB7gjSmVprIRBE9L26YfG7zGJ/2F2OqQTS5jUh3JM9rYPeUHk7Nif1H1tVLyL5r76n6rdl3WhEp5igc8GXihlZVxB5XtDh+CtjyQq9/D1N6G9kShQCTQMbLSVFdWTMjesfWOeMUEcmX3oA2/ssBiRX7T/UuTjhDa6w05B5IytqGtkSdgKogROWD8=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vr9mLKRL83ATj+AemunHQvK9zf8oX4VF/yW9XjRd3sMjJLdul6HrL/RYOrZRykKbwp3Srj4FsH8PuB2Ydby1aXLZ1j8EAAEgMdhlqR1AxxVHAk5eNaAH1Wyc/hyZf9BeCYGHxvG13l3IqgoK7eVEoUwrAQN/fJsiNScoS1Jks3I8QHzzn1Cf5/9tfx1b/4FSIP+19eNNmy+tzPxuqhl9RpNB4fSYTZdrDFbYrB7FJS4f0s8uVaPkIO/r+tvw4zRcWNNoCLp/31YfS+9vu58uceMXuORfRPpbv8A9PAl0pptID8Wa2iwgadiga29HE8PBaa/mbDtdg1dzYnvqDfLFtBHzr+iEHeh/AwCSL7Os4nDi0GEPe6RrVJp9DIhf2uCeMoZHqtzTbvq2IHV1cvu7eE0I8hcoXuGmobtUhvBur+SCvbGK2nA7E7Ga4gIpVrjbzMT79Vm4fqCuy6YgTC2jFDFlNUnZsEguSGBj87kYAycJCubVQ4Ey8uzmaFnV5D65AdiRBDBKk1ug/83SkqKg6zl5kTeE72UY1okMAjox38YMIBX442vKk/zUpRxow0Cwfg2oMSYJqG4h0SheF4km/rOzatSLnsCUknOYGKtBPnS8FWfshcynAPTAfVquSdbTewLa7gnTM6R5JN+NFW1meFt9fN1oEcWJDAw0+SAqeSf6xEYk19jrfTxdl81MlxZi
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QdIllXjjEoTOcnojBIKwsUObILlroVNcHltYKKM/PZqfFCeKrWYO9rNIN4bO?=
 =?us-ascii?Q?+OIgzqBWZeLKdc4i6T6SWEPlaEWQPaxHPT9rSARsdPYmnYPw3wXjyfah7R8J?=
 =?us-ascii?Q?W75pxLO6pK0gvDVkD25s650AEGeVUuFx/3pJFGywf6gqh62u+2NzxD48zN1a?=
 =?us-ascii?Q?BO4VU4dAoUFJ/tud2kU60BRtrDOzV+mD0JlBadw6P6f+YC/QzOfFsvZxsEbc?=
 =?us-ascii?Q?LqZ+F5gN3TRZZTL1krpQh9/Lk3eIIMQ4Qbt5+MZNyOQr2qbakJC48WTVR74r?=
 =?us-ascii?Q?fBDEnF7AGLQMjvK+fsNawrArcoI6iMYCNRvyT7d/mSzn4ocr/b0mKJR4NXaK?=
 =?us-ascii?Q?Qf1Pzy+jVditUV9uvhEMZzDUHJdsFsw4iNPfO08qXTeicurYV34Q+R6gLe6j?=
 =?us-ascii?Q?rnt2uVd9hmpN6xRPT1lBeAY6dsebf4kpufLgRnbCM/+H9T/NSeHlXGeLyHoX?=
 =?us-ascii?Q?gZQ1CdxUfBH3pCA9PCaJoji8Oq8nExrwtqeWVhTph7gcTKkkxaHXaYoDbimN?=
 =?us-ascii?Q?cUWes5apGP/WOYC3Z7f1Py1YKXa2OhZP/MWlM16Y6XSy/t1G+PvDO/gA+g2T?=
 =?us-ascii?Q?THUx8CXEEQWM9ysqIfDpCzeEw7JasCqr1lwDoCCUz+34yDd3SRBvXQumu1C9?=
 =?us-ascii?Q?a2jCNo6xhfIg3cKHlh0YBy52I/htHIITmjYpLhfpfrbi0EzYGl5YLUe4ArQl?=
 =?us-ascii?Q?6iiZD0dSTBlP/z4eacDyCS8iRRH8ko7YBSMHSs67t01QKCyNxOnXkyULqbSG?=
 =?us-ascii?Q?xyOrxGe+xtiRiDAUPXosIcrgWwFoplt4eErwoBKyAYT9HyNutOMpCyF68jv7?=
 =?us-ascii?Q?6+ELKOqP61bJ2I/urZuCbTepNVeQeKuChQ05LeDIg9T+86ZXS2SWmY3Yulte?=
 =?us-ascii?Q?emjolZTUM0CPP6BfrXhaAMpdNKabWv92m2cQ+TxiipqTkxsyhxOfHVtzAGfu?=
 =?us-ascii?Q?n9sPVLY29nTCQKoectJK4eTbWa5E+SHBH0+caDiTo3cgw+WX8u+nBKH4taZ0?=
 =?us-ascii?Q?/o5Tg/j6j23z1a36zoo/rrP6BhB1DJjlilkPvUcCPYNTd0GL9oWCcHtRn22n?=
 =?us-ascii?Q?dqN33umRcZT+/WPkMsCPMlhC9rJVoTATvEtuwtRazOqHQhx4//fg6lGSA7aD?=
 =?us-ascii?Q?YAn8p3hzqUyBWqxBGW19xcFyaBwLNnaVgym32114FxbDV9UtTwd/LPZouY0T?=
 =?us-ascii?Q?cPK+pVXArqHRPFsUH2zrKdpOjYwLnofv71ds1tAm/eeWrzfZdCUMxT07myjR?=
 =?us-ascii?Q?YWYLEdwGGecO0YA/KijYbnbs9jxp/Uh908HIbvIHNw=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9d8ff43-52c5-402c-06d0-08dab764d8ba
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 15:14:59.0153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB1756
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert current looping-based implementation into bit operation,
which can bring improvement for:

1) bitops is more efficient for its arch-level optimization.

2) Given that blksize_bits() is inline, _if_ @size is compile-time
constant, it's possible that order_base_2() _may_ make output
compile-time evaluated, depending on code context and compiler behavior.

Signed-off-by: Dawei Li <set_pte_at@outlook.com>
---
 include/linux/blkdev.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 50e358a19d98..117061c8b9a1 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1349,12 +1349,7 @@ static inline int blk_rq_aligned(struct request_queue *q, unsigned long addr,
 /* assumes size > 256 */
 static inline unsigned int blksize_bits(unsigned int size)
 {
-	unsigned int bits = 8;
-	do {
-		bits++;
-		size >>= 1;
-	} while (size > 256);
-	return bits;
+	return size > 512 ? order_base_2(size) : 9;
 }
 
 static inline unsigned int block_size(struct block_device *bdev)
-- 
2.25.1

