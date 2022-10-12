Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2685FBEB5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 02:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiJLAgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 20:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJLAga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 20:36:30 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2045.outbound.protection.outlook.com [40.92.98.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A379A9C3;
        Tue, 11 Oct 2022 17:36:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IxjsjFA7MfhGBzT5tMLsh7aBDeYHTSf9mSh0eYpDVxBTUoIb5OoPzDqeSuoJ4B9fLJoyqjYrgLvw07pgiCLZAzKnMlpj937HIAZxPp9+DMivBmrr1XP4n+mt1DDKBKYzgRJFOVR57D760y8bSA+pWC43IwL+NiKRlITg3DczusxcXEYW4eMe9IoPxaPoduhndRfFQPG+LZnPXARojTKO38Pf8Zy1IXJDktg55a3G/X47fXdqitzMKiP+Jkimk44gBDdZApzRklOWu9BafsVhRlPBrIHv6q1V8drw/tFEjzBvm8a1G5x9kK7vZTxEPcak48kd/bhlp38BlKM6AaZtiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jx9FA+WoXMtNSV3K+HBNqY2Wft4THkLwlGkzpOaGR/Y=;
 b=MqgMnuZHkl+PswmT6r+EntZ2YdZ0ttewVQgIE+oYEMUp37Nk6DQzgnrho6ncj6D6rJO5gTasxmiTlR3PKrpuajpbH+TNO4NVMyypZFBpgJL3wK0WlOs+gpEmzBqr+s/yFoY+xkLDQdqKR0dVHP4Un2T4nIcHmKJLfG5YGyg+ztaxpJ4ZjEIUcjGu2a3osNGkJcwdIET/CO1WLx9To4D1jnjSCIsRMJCfRXRVPS2Xs7mVKhEx9yZAqnhdNQSj1LgrAwK3aHUzHsaanpes/SRfdTSs8/nNPEK0TBDFCN8WBWJHLQ0/UK/4FF1KmOzPvsZ/nIE/jRCWlo+caPBQQ00J6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jx9FA+WoXMtNSV3K+HBNqY2Wft4THkLwlGkzpOaGR/Y=;
 b=tt/6kMZhegRZWgrdx4wPXFeFmWrIWRor0g7Ze6cZn7jNdirDdW+QwYqrzzR1J8/lSQSbKlTyu26xi5hVWkzrk6gUHwZaECFyWB+4gHxncgKzgtcjA4Ul8iIrZGWjNHEURqHWaJgoUhMGEArsV/Y5UA9EM+VA3FLh5P3aANDCg8CY/lOytq+kqv0Lyosz/e5gKYhulk7xbG7AwgBAxuMbcrwem6su8JuQNQayJ8K7fiN5FxGb4Cf5LX6KO7CFfaNnZgXitnGOShy/iYKQ7PBlBpuivCYkKan64larXg4YnzZNPktdDOogQcxYMIFhzsbT48tWEHFV8hxIKZeNnm+WKQ==
Received: from OS0P286MB0338.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:a7::12)
 by TYWP286MB2716.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.19; Wed, 12 Oct
 2022 00:36:27 +0000
Received: from OS0P286MB0338.JPNP286.PROD.OUTLOOK.COM
 ([fe80::e524:f983:290d:369d]) by OS0P286MB0338.JPNP286.PROD.OUTLOOK.COM
 ([fe80::e524:f983:290d:369d%5]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 00:36:27 +0000
From:   Jinlong Chen <chenjinlong2016@outlook.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jinlong Chen <chenjinlong2016@outlook.com>
Subject: [PATCH v2] blk-mq: put the reference of the io scheduler module after switching back
Date:   Wed, 12 Oct 2022 08:35:12 +0800
Message-ID: <OS0P286MB0338E8D41770BFDE7B3A4EBBBE229@OS0P286MB0338.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [S1aWfX6Y9kXL2/TZ+w9BK1gFCBJwX3iP]
X-ClientProxiedBy: SGXP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::18)
 To OS0P286MB0338.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:a7::12)
X-Microsoft-Original-Message-ID: <20221012003512.3484-1-chenjinlong2016@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS0P286MB0338:EE_|TYWP286MB2716:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dd9f642-ed48-4b10-67a8-08daabe9cc1b
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9XmrX3tRgoAVQMyDKQX5RWPdL4scVAKAetnYTKBtkxhDW0DdmtPWp967ZPEGgAT4GZqCr3uj2TSLsFFvZLqpLoH3eJy+rrM6JugjNSELJH2QpDClxnTXIP/uQEWTebSMMIfoF0KXNwTwULoSNLT2Wb8z80ZgsSvt0+Or9Dys64HuszvNaOFFlUNLvEyq0a8vbDy1ddj4mZ7twSRnfIbaaPXwDwGZqCdIPOa4xIGNqaq4EJT7cuAMlXPLRonpErr3LWLWlRbUEFFx6RQDxLwtg1C7ndU63AXgXySm4IWbN/bhT1iz3i61JFFuoKqNwJiI6FHHR3z6u0VSmG0NwwRkqnWi7l/8duI+Y3I/v4GJRxb+8MQCSwMRoKUBOrdl1jiZrBEtxxqUOURsvj1eiXNrrd1SFHvEpNJQEtTGdRTOMrAn94MUw26JYtbTA8YM+l1xdwjCs1nhCoyvgC1MENPFuUwmqKxzxZzpVbAq18BhDM/nxn8CKVOimZ/EJwqPvVCz99qJpa9l5qN1g57o9jO1SpxJhFw38aiWsxnsMDFahWsenGiPhkQu3v6ggPakP3MsLKVhuTAR7/RFrZfsOD2rP3vZtORTU5llhu/7f2XJWY7SNQrbHqB7u+IgC0SCoej+HHzmIFIG/LEDNCjtJverdznF9RUQ9Ehvs8PIQ9ZEYst/ZfxwcJ3/gIcPQ8yJSm2PmZcGblcp7D9700qepkGBMNdpqJjpgWr2csGSSiwF7fNmbjWCs9V3/QZ2ak9QIghrE29U=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z/MGeeUgK6bFStMQPROpuspHaIf8K+nXpGi2CulE5py6PcSOz+5Oy0R0bofYoulTXrKydM1633952rBBRe+pOcQMTt3mYFchTHgqT4wzrYRW481nNPGtD4MshFLThDof1PWFgBoo/3mrzvu/0ic5FDM5my/KVztFGLmrns2RCXyDh1o9Fs0sfsZ0O9YTBYQZ2uxcBz5U3MxSzSWao8c02qgZ7Pj2xVkWdLLHIuD1iVrZkLNRIXZXpq56+p5HQx7cfzEarxJr5c2zqd1TX4cIXc+MLL8PJrHOFNz+6NNx7pTkeCHImCtDjntxvA1xL2+FupiZxhkfBEha+N/VGNQ8BV+beWFQYDIurVUUxi1RR4VyhLyK1QIo1JFvjDIc7LUhb12ypUWDUDxob0FwOH28iAzdy7l5M6H4Ce8S5bQZdJ5SVXQVlgCtoOAXdq6k9TVjaBYDHlUOiBaybgn3vmLkINT3+0ZP7Gw5Jn/9D9UKDxjUBbnTFtB6RDusAMj5E0AwAJrBTcDzgli3BM0lWUEJOcL+vQrvG7EF5eSKD+9o36B6yL5mqExSpHKkK84Kd03rkX4RiwKHCbB345XiVhuZYWymA56ceHyKDeLcTvxdGaPuKW74SQUo3L3PEa79nH8lwRc3tITgF5TVxg0F25/UeNxBikk/8Mpo3jRAuPwSOOwzR+jxax2j50/ywrtUNLsK
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jgvR+smJCwh0RBxnQl8slA7F0Wk+6zH4CfCvWf7McNUvdQ4nkMiPTLKi3JBG?=
 =?us-ascii?Q?ehWU9pxVcbWKs4dEQpGerOHS1ZQf4Wie/Wwb2/JjXJs+V8r9Df7Nu/GBI6GK?=
 =?us-ascii?Q?yZeRlcLtxxBrEDE8GMR/c6xdpj1YI5P9lh4FvtSd9BlJ5xyoGo0IqmDHvYh6?=
 =?us-ascii?Q?O0e8RKz/QVsmpYyGmwf63Jnrg6XauL8LFkeI07oAUkK/mLe+4Il1aRrn7/RN?=
 =?us-ascii?Q?vqIFeV96hwsSUdYwVo6MjuRdJQhNmIzxVw1UQhkSCYdYUwkIY0apTZwnyHwY?=
 =?us-ascii?Q?/VGJHEfiaw6GL3kHwAmEtks90pD1Y/MjGHTq2zWS1HKZo9yLLxF77ZcAkkCG?=
 =?us-ascii?Q?sV5YhAyLHFsNE8sdG0MbxT5b94upDlbkS6sNYOX0qKw/yvuE5HpQSRRPXMUl?=
 =?us-ascii?Q?VTOCpT9iCRQ7SceOUwZwdGgClLEQJIie88rR37hF4nBJ71tGePZRdA6DH2+b?=
 =?us-ascii?Q?TdQ2HNRRbmXcvmLM5GMg16o8FfXhA0I/FC6qeN7kibLbmsixbjRrzF68Jfuj?=
 =?us-ascii?Q?g5TTDzcxTDmuRAALlR6iGP3YcAiKIqj/xPQfYuOOmdLivwxsO7EXcBYfna2k?=
 =?us-ascii?Q?n+thl9aszGyf6uWp3IUosfAI6jyNWjuomHHlmdEuxmPLSaHv2dW6bej2OIVs?=
 =?us-ascii?Q?EfyLa1TI1vzgWsdqAszDDeIKGMsTIPMP3f0SS2eEPxwGNwvCLgtoxvluC4IV?=
 =?us-ascii?Q?t5usdhwPPSjamYCdzC2nFVJHZZ7tjm+hxVf+rt7bqHuw8/5+SXtQnNOby9DB?=
 =?us-ascii?Q?QcouDofM+s8Y5tzA3hYheIpicQSEjjLTWTk5ikz5hdTgiWGDifsm8fJX3Ml/?=
 =?us-ascii?Q?4TuWFPk+2DqqHAbZnmRHw3jk4c3wCtdMkdJmSYSWhvF6Gj0+unVqcr7liZLc?=
 =?us-ascii?Q?64whVmT08mwwl39rctT9bIhbWImrS+r2EwgvWgx3XCkeamOeqF5kX0GF0F9y?=
 =?us-ascii?Q?nS/Kou85AY/ERqfbogA9Rvd++nHbKTtnf6mFNL3Wmo8f+jTF5qf8BJzgDQI9?=
 =?us-ascii?Q?2BheXhgiQWrfpGct1CrY8LnX+PJ02NAY2p1vo2pD5gAnhLChOlZKP5yUoKvU?=
 =?us-ascii?Q?vssgrrQmCVEur5YM4XKT4gogfURKy/o7mplnozh6+lxldq5jRJZn1HaD0iwi?=
 =?us-ascii?Q?e5xrbIBJRMndXz3KOsbTfszz/ZYS4COc9ZkhtdFMmlo3ba1TOWlbhFybBUmB?=
 =?us-ascii?Q?YzaiKFVk4BeX08nF1tE2hjKWY0mHDuDsVxYg8mdYyZI0/xgan2ZLC3Clazrk?=
 =?us-ascii?Q?/Eq6UiramhKJxbMzw8qBs2z36StnNpOTmLce5zAqssVOTYyykwt1vg9PElgN?=
 =?us-ascii?Q?PX0=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd9f642-ed48-4b10-67a8-08daabe9cc1b
X-MS-Exchange-CrossTenant-AuthSource: OS0P286MB0338.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 00:36:27.2386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2716
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
---
Changes in v2:
 - reword the commit message because the patch is for blk-mq precisely 

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

