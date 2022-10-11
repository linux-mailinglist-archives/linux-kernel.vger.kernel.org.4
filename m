Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B9A5FB05A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 12:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiJKKWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 06:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiJKKWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 06:22:10 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2083.outbound.protection.outlook.com [40.92.99.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AF7796A3;
        Tue, 11 Oct 2022 03:22:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ltSp637app2QmSXMjknUZyG6d4nnL3RDPdniO5j6SDH+X5KyYVbG3k3ojiOXFZiY9BFcEYNBes1rLcJla7UuzVGfzJVBEQARmx1XibrZqx4HkV74+wt+OgkW+eyrTADRQbRqxBXEUoK/U7QFAMD5HzqhraGN6xp8CL33zftwr1afuwoE0B5bwg0I4wOdHLcHv8YRXVrqD2ZhCS+Cz6UxvXcn9xNO5K1rYXT7fsGt0lLbct2o0QqZ0RTNoLGizGjAbihej+AnaSQ8kl3dOEpTyh+k9TbD2l+18epXS66heU1XUD4J9PIEJbhHU5EVOjnUBl6LbyYhifiIdkdJbG4SOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aILd9A6zjzGYuKbdO3E/Ag0eBSxrkM8YVC2lNNELa+8=;
 b=lgdZg/jYm0BrRXX630SGiX6iHUnYwQTxIiENXtcddrDhi2/5qlbkglmgkPS2mAj2foixkdkDLTYuBdUsrYY4DdMJNy6A3e5+ymM7m7SWZUsk/3beDgRBLGK+BPxp50VRLPqb+E7My3xRyymsH7kzKWIRhB64XTTu6555VLsMBA15YNVucNllYl9vjAx2IdIp/e/G7+X+ZjNyjtDcgSOST68R1IQ+JiHF1MoH5/zK82vqsQwPzlF8KJ08v9mWFrN/47eTHQ3dHcuzd8vaLjFB+OLGv7VEh+sFbpX0JivpJOJDsgi7Tl+QnFhRxaM30ONHBcXSLMfGyswkOx58PZRsQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aILd9A6zjzGYuKbdO3E/Ag0eBSxrkM8YVC2lNNELa+8=;
 b=k69RXTq1z6bH1WolmlYRaX1GsmKKyJqJBkqsMpsli2OeVFcWdK21YlVCMi7RLVW4dgtQTKbZlk1H0HhqG56rBppamPOlTlqh/URh6HP9hTbC4+HyUUHPhhApf6zknAA7d4iWioZ1DvDAKclMiLLq9y8OzQWoeg81j09z3RHhnOSgE/J4otCSK1B5Dto75hJt4t7YQGzZyILzhLpbLsG3Mo7WL1AkX4kw9BSs54RcRyO5Y4cXonMxG7pQFtogS/h33BtC0DrzEKzDLS6+ZeRLP693YaBsQ2r2b3IDgmbNRPseLzqhRBDWD23XLlB/dJiXNbHW/xhhiz+r+wmx5x9Rrg==
Received: from OS0P286MB0338.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:a7::12)
 by OS3P286MB2042.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:191::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 10:22:06 +0000
Received: from OS0P286MB0338.JPNP286.PROD.OUTLOOK.COM
 ([fe80::e524:f983:290d:369d]) by OS0P286MB0338.JPNP286.PROD.OUTLOOK.COM
 ([fe80::e524:f983:290d:369d%4]) with mapi id 15.20.5709.019; Tue, 11 Oct 2022
 10:22:06 +0000
From:   Jinlong Chen <chenjinlong2016@outlook.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jinlong Chen <chenjinlong2016@outlook.com>
Subject: [PATCH] block: put the reference of the io scheduler module after switching back
Date:   Tue, 11 Oct 2022 18:21:18 +0800
Message-ID: <OS0P286MB0338069A20BA87C2C9B2F2E0BE239@OS0P286MB0338.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [PhEznOojveRU/8SO7xIzbq5TNieAlGJW]
X-ClientProxiedBy: SG2PR02CA0057.apcprd02.prod.outlook.com
 (2603:1096:4:54::21) To OS0P286MB0338.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:a7::12)
X-Microsoft-Original-Message-ID: <20221011102118.18637-1-chenjinlong2016@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS0P286MB0338:EE_|OS3P286MB2042:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ec2f145-7a9c-4b0d-c12a-08daab72727d
X-MS-Exchange-SLBlob-MailProps: EgT5Wr3QDKyUDEYghf57N1sv3Zj7JNC8wz7UiltgwuWtYWQPh7ozH5nZxy3rXgVJGQCAGoYK4KSRyfo0aO8boHsmZhjx/XmlzoXbZ+8UXaA3yo2rEbug8nn+2g4nMYm1ihF76MIGxK2gwDrFjD9DPqXAlpD+0kdejVafCxmBa1GuE90VuJ2huLQbdmMVR9AKZDJ23qjqMELhnx1f6wbwZtWYwcN/4We843XKoOISwKQmeDbSkViCXHJV9xqX8bSfAuzD/RhwQUAuxCpy2jAk1Lhj1Bwsgkl5YHRCxLKJ51elBkIzVQQoabW72de2ZJwt2PS7fJ4PbATDFLhnJ4OFzEEruXJXYufsyy5QJ9BXj0mZBCntsix+2nd2ta2sECW4K6ckh7+f1NNQ1MFFSMLbgQlpZ+LOqWS2q1QP8lRGaOcmkWZ6B0iz3A4MdYA9h9vpcf3drmWj08/4oKj4vtWbRB/MG1BIy0xQHvAWhLAHv5vhBO6ZYTJuZYwERaSk0S6TSCJgTsWSbJNd5AlHVWhrSUf2eUhD6XpFipI4A6jHmvDn1EPjh7XmY06W2XXwH9f2yGDzTmSFtKPEi0cgmH1qMxszSiNDdW0d9AFqU/a+ZYUbnCjqDEvg+Dl/IGY+4tPUEVlB4Yiui9t6XutDoydyQxNnbrjbqRPxbd9lhCPcnRkYyPV1eeEO6Gxf1Moj5JujfsuY54YHdGlBp0kFTntqbGu395vpiCZiJit8/8/Lav8=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5yPh2TipcyylewpQ/17BWnrsTBmpBk/ibUe71medB8Hadn5Qvx/5jk1yH2SK7DwI8bE6jrqyVbUlBvF/z9fVN5Qfpeq14RFmdE0vltVB5ZngB633B9IlzT6pr6p1hMdW0AijJGccGQFzPhY+S1JeaNWLCF6Nw4eHNE5FrHeI9Dx09pA0zLUXP8s+i6FxmueJHsn035uN+KuzLvV5NC1y92Z9psN9Z8zPcQGt2U8ETBf5eizEgFNJYVN3Qg/PabEQC2Ps0gdPF6NrB2fCLOXBVZy20oMF83Js0QcjLhkFXVvqPWkyF9ZwXuguZ2M3ICiPNNz8SSlPO31lBqNH1qy+trHhCi55HqsDh0YY6XbDY9jgYcmIhpu11sbNhZv0/S5pth0hUogibfqYvdAJeD80BDzqg67LqGzI4QRJPZmK2p+kOxH3wZw15p/1aWa0Rutj8F7drQ++7XlaG3M/KwecdQtnTkbZlqZWCi8e1iKa8Sj8e9GVooA9Sm+QQjclS/MbTtOB3G+ZQaAOYmUR5G0yytbfRBo/7CYZeqe5GYCheNMFjtL7DjRSC5OfL2qmuKvpilD3SjhBfvcUNpQaBuEgmAfb6CfLzCggugzrIT5b+7lhbsyCOkt68yHUJaKyhLTmxblJChJKhoTAdZV49n99SgcyrySej7p0N/KzHhNON8YYiAkHhDJ4HkvYABorVxTo
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LDmtGiuqz8NKeOotYHhrRSDyGlUJDnGuw9QdjV6l+mQWaVebeYzgTmbwsau7?=
 =?us-ascii?Q?zRERXipuIUB/ci7rDtDhkoO4PTtXVeiCylIecvwHmz0UL7NUyItBhC96XZ8K?=
 =?us-ascii?Q?6S8uJL0Ihy5AZKxG+ZNaI59LNE2n3XB7mG3T76TJKHQnhjihV2Xn+r5oDnh3?=
 =?us-ascii?Q?kOb54GHrtf3ghCEOQoUpyTTuwSLktXT0x5bWFA6MTvsUdcRsaiNG4fsrq4Oc?=
 =?us-ascii?Q?ilxNRMC0/2xVSOvGqRTujBTdsQlMZSKw40LT+MkIzL2OMXA7ee2z4oSeBX0A?=
 =?us-ascii?Q?87ZR39TuC65YIFX2rmz90R6kHIogLXXBzXhv0yl2Gv40wXQbCGHYoipH/6Qk?=
 =?us-ascii?Q?M7v/JXLtQG7FJORcqrGr/8cfxjITFMHNBwY3V+HpTwPva6u97wLCdJhaOJey?=
 =?us-ascii?Q?fVNLhpF1AG7GU+Pj0+kn/6WW1KYO2adDpjFambHAcXc9tzAbw32oXjA1ahYC?=
 =?us-ascii?Q?SJdPzVsitrD0xKMTc1Da2GiYk6RghlD3VeVeslCoZnYrv+eTocOsoRxUCAig?=
 =?us-ascii?Q?pxwxEEH50hb6LULzP/1EqmCefR0mlPk/Ve72OzyzziDDImrJHdFKao9+erGJ?=
 =?us-ascii?Q?IDGUPBAj2OpZZTd/wuwRuVvXHlxIR7SfCNUMStrGAyzMnbT/uRaM13GxOMuZ?=
 =?us-ascii?Q?u9qRQ+WdJIbq609IfRnEoXnpQjdSvgD/5ow7OO5gWeLLu/NIJ3jU/r3P3Ki8?=
 =?us-ascii?Q?Bhdh8m8eS1v1PSwCjuX9gfjJ/Iq4Yb8krqtDp/dbk8+AXvHuemSMOeRK8AUH?=
 =?us-ascii?Q?KT2G/Ti7xXx+zUPxmz1jGAD91fSrp/2shPl948lPlbzuTYY8edRcO770AvfV?=
 =?us-ascii?Q?8uXxuKwu8c/ZzGhx6aRsA0Kudg/HF1ZRjQSvNv+6EoTaiccw/2z3eHJ/e2V0?=
 =?us-ascii?Q?AAPSK5o8FAgnqO9tYNWs7QrUDlawqesd158p3HFpkrPn9EtugKU7w+br5ZSk?=
 =?us-ascii?Q?3kSC9gbE1TDCK0f/XzeuWd1/LtY9XMjE5Bex9++KMCvog/ts3nRQs9wVde+v?=
 =?us-ascii?Q?ps1thSJXI4qP/17bXEVzn3jZtqdQE6xNtJWAa9dpe+FtpwjKTGOBpe9cMFJV?=
 =?us-ascii?Q?3714gH7SMfrLCMNMpZj4Q3ACOJhseLdUImwfagMh88nE3CzWosAQl+bUev5+?=
 =?us-ascii?Q?m2SogwMc0yZk11BMfjQ2Sw/YsLou8u/e/G6klMxJwRCkyc8CMeJn5eDRwSwm?=
 =?us-ascii?Q?JehvDCDBJK993JfuTjRbOY3QytiNpK313WwdZn5ChuYDvL5lLBW3701/Mufd?=
 =?us-ascii?Q?kP/zCX8/NwCjnxaoEhXK+nd1uzKDQuOnzQQXGVme+u+0WEA+UeCeiTGI+vsx?=
 =?us-ascii?Q?wTo=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec2f145-7a9c-4b0d-c12a-08daab72727d
X-MS-Exchange-CrossTenant-AuthSource: OS0P286MB0338.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 10:22:06.6654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2042
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We got a reference of the io scheduler module in
blk_mq_elv_switch_none to prevent the module from
being removed. We need to put that reference back
once we are done.

Signed-off-by: Jinlong Chen <chenjinlong2016@outlook.com>
---
 block/blk-mq.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8070b6c10e8d..8dfe3bf3e599 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4595,6 +4595,13 @@ static void blk_mq_elv_switch_back(struct list_head *head,
 
 	mutex_lock(&q->sysfs_lock);
 	elevator_switch(q, t);
+	/**
+	 * We got a reference of the io scheduler module in
+	 * blk_mq_elv_switch_none to prevent the module from
+	 * being removed. We need to put that reference back
+	 * once we are done.
+	 */
+	module_put(t->elevator_owner);
 	mutex_unlock(&q->sysfs_lock);
 }
 
-- 
2.34.1

