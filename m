Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18E8652A01
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 00:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbiLTXri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 18:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiLTXrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 18:47:36 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2070.outbound.protection.outlook.com [40.92.41.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076E8DEBC;
        Tue, 20 Dec 2022 15:47:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDH3g6Xc697FD9Q8PPCYkQuP2+vmyz4bFZPBUx1CypYDBXviF5CY89QxkBJompyyD117ykM+KwzjP+CKnYRsqOZYtNawdXtAqo+oFWcB6wfai4aitCQUs8vbbQbBd6+2SJiDswZuEzgoTZAnr4knge4oqXglErvs5GPn9ldL9dM5XRLdnfhnulCQsLlUd+2JyU1eY2gazqsti0tFOu06XzbVc0Sps4pw69WaudeHoUTfQeycZnyS9QT2vOIe3AUI2Hd1wC+dHDyJNg1QHwNQ/VEb+mlIe5FAbLBEokfCqPgQpRceL3ZgtIv7BSnQNX6b0LywRgQRqINBS2hE9ZaOxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6tXobqkAB9DPegrO16W6V79cW/BqgqBwv4ooVUziamQ=;
 b=SIH23OaXeARNNpq+5e7a6v77AsCglyfgfja/DhGr8oG0y5mlyzBAzRPJWybq0t2VbJRq4K+0U7W8YXtHE1tT04RrDpD/Dyf+QZUskdvrmD//Lq4Fk7xRm5z34Upb0lsnYBbbYuVFLZyY+lTehNfO17eO93drRuLyoUW6L+r58Gx4C5CFVHr8v3Zy3bYtvIJ1lMmRlGJt6qghbwbry9Slvbsk1ptlJLlJcZTFxRE9xvB3x9hU8UstJo0Sq5xo2DjUKkWnW9s1WnVl++cJQS2fXID4+pwi113JvYGyme3WkX9mNVgQOuvBsnp3Y083LWkxIOvfs0JOf2+P8hsG88CRdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tXobqkAB9DPegrO16W6V79cW/BqgqBwv4ooVUziamQ=;
 b=WruxLYDHrUlc4onrmarYVrhvh5d9oxxakSuNarbQ1SBZoD+qRBBPt1oslJ6a0Rko9cV6En+JsGs0s7WDOLeb7AfDmuC2XdzdAz68dlH3xM62X7VxYqLuNd888zK8Up5+aGmf09viOXDNXCX6yKDTcHrpTWwC+qc6qSmWlJnoZGk/nh06fUmN8mezShejFeB5S5g7OwdqGj76DhA2LJUBgGzNldqq5G3T8SPMJi27Ka7UcwIdGKFmOEgNd9JluyCMnXYgLgqw0AHWu8jzj0Sma1N3xvt3rSilWrYo0nhUDdRCcN7EZKIid5ZCXGfUVY42BAki5m1JQQt/ISs7F8KJpQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by BN0PR20MB3830.namprd20.prod.outlook.com (2603:10b6:408:12e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 23:47:34 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::b0b2:2ad8:2409:fd50]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::b0b2:2ad8:2409:fd50%4]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 23:47:34 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Inochi Amaoto <inochiama@outlook.com>
Subject: Re: [PATCH] HID: uclogic: Add support for recent Huion tablets
Date:   Wed, 21 Dec 2022 07:47:50 +0800
Message-ID: <IA1PR20MB4953704646AA47DCD3F1DF52BBEA9@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221219095622.255134-1-jose.exposito89@gmail.com>
References: <20221219095622.255134-1-jose.exposito89@gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [DaHjP9gzkTh4YlcTbHhfLkstLA37ENmqbneqME/tqIDtjaCeiAnxJzKwV9s9z73n]
X-ClientProxiedBy: SGXP274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::28)
 To IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20221220234750.11145-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|BN0PR20MB3830:EE_
X-MS-Office365-Filtering-Correlation-Id: e611c44d-198d-483f-9bc7-08dae2e490e4
X-MS-Exchange-SLBlob-MailProps: 5fu/r660v9Og3lQ5TRNKiydK7hugT9Bdxro2z9zqVK1oIpwVojpUC/mdQYt4/s5AqUC2jRfUvb11Zp9mH53pmmw644Ev5OBMoRJmDq+8Kze6S5BoyGtQfFLEpQVCJJnEVtorXKTPGaa1Xp2TvZ8amOeGb2hZqCIiwfO+LhR+auREkdm7icE8tTzWg1NSh6vBeHtmFK7W/qp3/b0vUOTvE8bmps55XzO81+uqTi/NKVG/dITD4Dh02DjLy9vgnRF9trR+djDo0wrAJLYjDYWtpgyCRfXDEsmqpt0zLZZ8Gg7pSTObgvRuSure3k4Xl8jUGUgeMfNqMPCfXDXIXsjdE0TlR6ASS0Fm3gEjQ8y89ykzX/+G9MOzj5dKG+D7YYffbzcxs9SjIaGE8yS8EqkYgsvQc/smevPEFbaMbptO70C5xxdUiw4vL1TTc8mMMQEwBu62k9eCVatwHXWZiNjZghtnXHtMgI9LnzAZTaVFsq3y5GR2ur0K+D7s9LkQL4locbPrFpb1CtqQ1xfKi6kG8+bVt18cx3+Kbf4M8z5emSY/pZkEEZIjrhSZyJK7FL2bXeBIMWZt9jQUS+kMUCmMZqCIDRT1laNzx7auQ7vpjEaN8GvIh2IW04YMg5A4ZFYBh3zBXOjayPZcfOV3QQkSbO+HuOtVr+/0QpJc+pGOrainWTj32enntNeO2LVG2Ukg/9a7Yo4rVQf0F1a+ji1hX4H+JB6M5HJP0CQfpmGFziI=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hds/52uhiog1/d/pjHghNve3kYHrzMuoT2QiDU/mXK5ZfgOwInGSAo6ZOb7ZJ3+J2WfHmB6ZBiBSn4JJuq/y6Uu17hFMGP2+YYpaqas1xZT89ZXmocuS6gwSkFlkHngmtPDKbNYhH/RY97B8Tw6IhITHnUm/F+UYhnGAmq62DEkWBfySRWwb47wZTNUJ5PfIXRLT6UI+aLGAIowfngq8DjxWiF+GFBrHo6UluxU+3erpOvk9vxqQYt8IAb9nJWOrsY/+LRzm1Lo0kAPk2SsL4kLYpq6VvWXNeebXgiwumjC/E0wwYIvFmgBGU2Kmb77W9klDS/A1Sbw1jiEcUK28JEgNX+RMizevln10vAU/lCUNZPFjM7SenSHW1FVpEf6SLR0dcgNfidWkQ7fIwHN3byKpG9vQ6tbeAFvTnUE1DI8S3uD3tAQFTiqIk28HO1afaYx52Zd6WmRByK9aycuN5MIfU1m14O21Aogn10jKIa+7dZFrON3WzNYnhBfvz3R/z8B7bPp12dP6arRxB2fkPlPyN9IVx3AeKsj6dCG+Fonb0kOboOrLJkU35RZIdaN/5Pn6leKfCQr63unCrS2jBF02gndPRZNwe/V3ggYFCU2GqgIblIXOUeGLkKnHQ5F9bqaObStTkmmv/ol2rSFbmq+nKsuA8y3dwAm7/Hh1bLrEz1YDuTfJxZ/wWCLjc1RZ8tb9bf4IjnMdIPyhRQWE+g==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hWsPqJOO03Oet4yCFdwbGlAUqQVSCxemOPSgn2S1UN6Vq8bGYIbdUHmM5Qch?=
 =?us-ascii?Q?3KjiKSlhvJS8Mn3D3TY4Iy9ow6sVOIhrFhsLujZ8P1RImS7MtgSCjBkcvUlm?=
 =?us-ascii?Q?JOGes6aTqWDk8n15m8tFYAEdXpzLL4ErVRHmXQh0kUZLfg8ivo7nae6Mph0u?=
 =?us-ascii?Q?jPofTXAfltdfBEho1dSCJQrzv0xfVOg/ibotMMPv6T0tg1YdjRJ149woWt9V?=
 =?us-ascii?Q?bP1MU4jHmC/wU50wUC1WxbPYXrMkwNxviadqsFeXXl3sd/GAXVirpg/DJJfK?=
 =?us-ascii?Q?ui2BY1x4TlZBNzXkVsAawMkAuDP9fDoU99gfZ6vEXOALkdljLeaF6bRpjOJ2?=
 =?us-ascii?Q?YNfhcoVGZonXO6dffqpWdxTBZcCssNKwZ3ROGPcV600cB7uJq/1UF8Fja082?=
 =?us-ascii?Q?lA10+ldeNFZYBpnEiuzJT/IBX9G1hWXyfaXJcqdGiFFVqmDC93kDZTlC1Vxu?=
 =?us-ascii?Q?lEmqhUWohhbIEmQh7V8GAEMKveP+aVKMignDP7OtGWAiasKd/LK3hIGtRfHR?=
 =?us-ascii?Q?wincPoCdCQuo6EKdBqrUl2Nmp3krfnTkDjha4V5gqVEED+eHjQWXwpp/ANRu?=
 =?us-ascii?Q?o3gpEFEvpX81W39am+09oKALucRpEkoDQQPX9pnn9vhAlpWRMgXQJQqfWhVt?=
 =?us-ascii?Q?Zj5EWBItnlggf3Wy2ViaUcz/Uvm2i474xMkuIOpO4AuBUgTnHP7ql0fixksw?=
 =?us-ascii?Q?aaKOLewL51jM8NGDn7pDIMC5PMuAtzdUsPjp7nKWzN04g7xyP5v0x7X+Rrli?=
 =?us-ascii?Q?Fm271WoyD12PdLq30vbPlrpJnYBti3It01bhBUzFCy/ktLvVVwMOvn1U54Qd?=
 =?us-ascii?Q?tg5R6Feg/X3xbWXHt/l8mUsF/UYCJITaJXXgUqUblSJqFkgSGH4XyMptEbCh?=
 =?us-ascii?Q?FsK2iD38UNcvmmxJTphoIFl4D7I5jLXD8zQrdlMukJO+p6t9GMEUHM9ZXuyI?=
 =?us-ascii?Q?Bwy3o0QjblHKfsJ9mwXle4Gv566IkkqDNUVdmbXEPXR/aaDaSwrrqa4vSW7c?=
 =?us-ascii?Q?NIRR1eJJpGwQuzFV/P2aNz0X/HcW81L/cRcw5vUv0PA/raOKmN9dsfT/8M7/?=
 =?us-ascii?Q?RTU2iw6uttSaBXSuNdwCcgsRS/kkmWibgdRDyn/hrRYDvuiOXhukZKyGrVPC?=
 =?us-ascii?Q?SvANpKwfjxGB7kwF3I0pXShvXiEWUSrBoanqXWelv0oBSU+Y0qrI6JcmabGF?=
 =?us-ascii?Q?qNKjVhhFWX6SSDjLpg5nK34prd5pAxQDn2iWRQpKY1xRFwRW+DyAjsP1tcyG?=
 =?us-ascii?Q?ioC5SawdML7VkzJYtVylbyKI7vBhEUYw+aZ9Ra4+191QWUPKys8nFa7talY+?=
 =?us-ascii?Q?2lXd8LCcq0r4bXKM3gAALBsWMMoe62wLpt+HpWIVn+wrNA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e611c44d-198d-483f-9bc7-08dae2e490e4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 23:47:33.9543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR20MB3830
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> While this patch is correct, HUION always reuse the same vendor/product 
> IDs, meaning that it'll affect a fairly big number of devices.

Yes, I agree. Not only recent devices are affected, but old devices with 
new firmware are also affected. [1] shows a firmware update can cause a 
new device id. It seems that HUION just uses new device id for new 
firmware, with nothing changed.

> Checking some comments in DIGImend's issue tracker [1], users report
> that their tablet works applying a similar patch. However, I think that 
> it could be a good idea if you could build a version of the driver
> including your patch and request them to test it.
> 
> I'm pretty sure it'll work, but it might be a good idea to test it on
> more devices before merging it.

That's sure. I have checked DIGImend's issue before submitting this patch.
There is also a pull request to provide the same functionality [2]. And 
the [2] says at least Gaomon M6 and Gaomon 1060pro worked. issue [3] and 
[4] seems to show that H580X and H1161 also works.

Nowadays I am working on my KD200, which is a typical devices of recent 
Huion tablets. This tablets has 3 usbif, so it is not fully recognized in 
the init process of the huion tablets in the kernel. This problem is also 
present in the 0x006d device (with invalid interface) [5]. I think it's OK
to delay this patch and do more test until the invalid interface problem 
is mitigated or solved.  

[1] https://github.com/DIGImend/digimend-kernel-drivers/issues/613
[2] https://github.com/DIGImend/digimend-kernel-drivers/pull/623
[3] https://github.com/DIGImend/digimend-kernel-drivers/issues/600
[4] https://github.com/DIGImend/digimend-kernel-drivers/issues/640
[5] https://github.com/DIGImend/digimend-kernel-drivers/issues?q=interface+is+invalid%2C+ignoring
