Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D081870A6DB
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 11:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjETJud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 05:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjETJu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 05:50:29 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2054.outbound.protection.outlook.com [40.107.15.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A58A1BD;
        Sat, 20 May 2023 02:50:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXnrE8J93SI8HLzsaoBAiuyChliM678sjAhtE8XoXyRSVxXR/mlfpQt8pyCElZ6jv3HQKR5DuCzPKURFlKQQLZxH6Jl0EaO0t6JrjReyGbwR6awb2E1R3pHD9mcGZP84u4qrSFcp+WpahsmzryQ1ki+8bieNB+B9aPQKzyzSFyNUJtfWeTzj+6NG480wyhajGpJkX6+y6ME2FI9+TZvaESaIKH6JXMJp/DMQUCl3+ciPpqJcek4LvCTcYhjGjdebookoIkXrsdQy0eAOxwHuYjPLgjWKjYC5T7r7pwE5UN4ISO/6RJpBEpNA9FrqAcxa0L/3haaJc4rAMtg3gnE+oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XR53Dc6mUEFbrSDyHxvoR2Zp5PV1/38Aaxb1qw4iNUs=;
 b=l+WAcJ0S4S+wal8iM9a2f/zsBBeFo5w4nJyN1EAfIGZGvcNihlPtq7eVNm1X3Gh+zuU7+LzquPh2yR+YftQusYn7qoQQf3yPls+UPWJvX9PDywlorpYhvESGX6pkVApdLGmwc4qPy/4sLiNQ/KK35/znROfyZf8W8dTmsZL1g+gsJwLURb1huUOshulb/nZfFXp5V3LKm9hVeIFfWWxHvEM/AUqrBqnV688+GkydMnNsSi6BxkZANJ0yc+Xq+sNWf/8aZRtEILF+Qo8jq9h2w/aVNTpGKW8SOHKaC2rkfNUbCuYdu9O2CIzgcghzMr8i86q0+ahsaewY1Hvx/hzWVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=santannapisa.it; dmarc=pass action=none
 header.from=santannapisa.it; dkim=pass header.d=santannapisa.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=santannapisa.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XR53Dc6mUEFbrSDyHxvoR2Zp5PV1/38Aaxb1qw4iNUs=;
 b=GCU1s0/B5tJX3m+EwSNfHq2MzSNlwU2knnHf8sM+TABwIkkkRkzwlqabnLPhU1gGMdYjGQ7ZAN2BLXcMwv8PzY+e1kANEob5QArXIoekvVSI9+0tuud/52yURCxkdbgZ+VTQylBV6FGtLhN4wlS0lq8Uc5pwsFgw5Drc2w9Nsao=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=santannapisa.it;
Received: from VI1PR03MB2880.eurprd03.prod.outlook.com (2603:10a6:802:2d::21)
 by AS8PR03MB7253.eurprd03.prod.outlook.com (2603:10a6:20b:2e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Sat, 20 May
 2023 09:50:19 +0000
Received: from VI1PR03MB2880.eurprd03.prod.outlook.com
 ([fe80::f649:8c94:52f9:3979]) by VI1PR03MB2880.eurprd03.prod.outlook.com
 ([fe80::f649:8c94:52f9:3979%7]) with mapi id 15.20.6387.030; Sat, 20 May 2023
 09:50:19 +0000
Date:   Sat, 20 May 2023 11:50:13 +0200
From:   luca abeni <luca.abeni@santannapisa.it>
To:     Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 2/5] sched/deadline: Fix reclaim inaccuracy with SMP
Message-ID: <20230520115013.55c61a00@nowhere>
In-Reply-To: <CAO7JXPhZPvzVRyL87qNT5VnaVOf=0wrRftFB-Rjx-vJc3JUMog@mail.gmail.com>
References: <20230515025716.316888-1-vineeth@bitbyteword.org>
        <20230515025716.316888-3-vineeth@bitbyteword.org>
        <20230515100616.33ba5dd9@luca64>
        <CAO7JXPgq8V5yHM6F2+iXf4XJ9cyT30Hn4ot5b2k7srjsaPc3JQ@mail.gmail.com>
        <20230516093729.0771938c@luca64>
        <CAO7JXPh5uLV4QjAEi6bJXfAGSsZ=XsnCyzrvKS8m35BGbRPYJw@mail.gmail.com>
        <20230519115621.2b3f75e2@luca64>
        <20230519121804.6c85a3ed@luca64>
        <CAO7JXPhZPvzVRyL87qNT5VnaVOf=0wrRftFB-Rjx-vJc3JUMog@mail.gmail.com>
Organization: Scuola Superiore Sant'Anna
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MR2P264CA0006.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:1::18) To VI1PR03MB2880.eurprd03.prod.outlook.com
 (2603:10a6:802:2d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR03MB2880:EE_|AS8PR03MB7253:EE_
X-MS-Office365-Filtering-Correlation-Id: cae345fc-b475-46df-7382-08db59179f0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zch4jRTAh4q2eFxfhleY51F0H6uD4Z5A+EwB+rhtrL7CRTgkMPty8+YGgUywABH09+87qGiOdr8rg7YsfpuivdoCZ4Wgq4jXYVrEqHtuFY9sAbXz8VyLQFlySegGcrj5lLNWsgM2AT+gJu/KpEQFp1+uKC8I3gD2rgjC8r7qAtMdKAyJvB87E1G+AtqanUDrvfNG9fwUCHxkZHYFvwYmDFI53p8Ell0Arw+4NYwvDwjPcP9lYK3CCR6lyWfq0KKA6w8slLDSs3nehvQ3rcvcNXlCq9ZAm23aUybMDm8x0+0dIY+/HLbcrFYBV0Rf/rM/x/DPbQYp172wAQmk0428mE5clAbPH1H8/bCsGLt2sBhidTe/HRBLAAH09ww+gRDgg4nl4NBri2M+rU+eQTXlCdpS5VHm0KgypXlXfxV7g4t7baYRPJmDgAzC2mDSm0TMZQys87rlo4E655m2CJvuXrJZUUt22EIXx/NCro/oaHYLKCEy5HbAQnwU++9d6K2jkb+QvNs/tlXyns3TsRjJnd8ESd6YyZqSKBufoFJQvA+XZVdO3zCUzGaNR1M5f7FA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB2880.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(136003)(396003)(366004)(346002)(39850400004)(376002)(451199021)(66946007)(6916009)(66556008)(4326008)(66476007)(54906003)(8676002)(8936002)(478600001)(786003)(316002)(6666004)(41300700001)(6486002)(36916002)(2906002)(86362001)(6512007)(6506007)(1076003)(9686003)(26005)(41320700001)(186003)(33716001)(7416002)(38100700002)(83380400001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wd/T//VV4+X7oQ1eCAh8KrEL9oJhd+1fdn6DkhRTB0Cgh2rl/oa1dkJ9MH5Z?=
 =?us-ascii?Q?bZyfVDAZ98PLRDMQ64nwkoAI99AnRy28YtDDCeorrlKVausPYS8nFvu2W1qj?=
 =?us-ascii?Q?r8pbBymlloIqrSqXNSTxKDExL4g4xYLN/f0WYkWu2G1LFgwlz90NYW81SWD6?=
 =?us-ascii?Q?muOUxjh3jEC/ESZFlk/YAuzo3fYNCAwCSy6Zp2mxidupEkHqwYBQyET81CQa?=
 =?us-ascii?Q?VAEn7q/Wp0UZW4wSAG5uP/9Oi4EioD/1/h+h/eJB+vtu1UcZj0u6uMN3NG0X?=
 =?us-ascii?Q?eEG0sMtbxD4WoHw6TFMu6Q/b2GjHzOdqbtDnRrwhbRiY1o5XygLiovKl02IY?=
 =?us-ascii?Q?poPobhJIazw5TpEh6uQKzdcX1bt/BHzhgC72XgrV6VbidKpmz5ByeIRuwTXk?=
 =?us-ascii?Q?POkWghVMHa0iqUkt0+GhPIdR/bynmnxqyyYyn7OhPYDakBWT5ofCsqpJsJjo?=
 =?us-ascii?Q?DkoRl+o2JI30/1jKbgkospn4OXBUjR70q5AX4tK0zB4RpkqGg5lYHT7fPXcR?=
 =?us-ascii?Q?4b2EfPgymlCoWhjPpDqwGsMrwYk5x44gI3ks6ZzQ6Bx5HoLnh1w4waTbIAp0?=
 =?us-ascii?Q?n3GBre1KKj2narP8byDLTTvSJtnx7oaAXEP0MLjiLBd/VJzlTRZOTIavYom8?=
 =?us-ascii?Q?JaOCTYeOhen040Ee0BRINsdwt0w8+/7kogDk9RxdHd1pZ+TYbiVUN5cxM7yd?=
 =?us-ascii?Q?q1wOJjfj/p+RohKeDXdmV6gfBrynv1PgEQoDA+LHso4IKTTqLx9RvxOeho/J?=
 =?us-ascii?Q?jeWf5/L+DKDgcskndZdtnqM/xG6C+cNDja1cqJe8ZLX8cat12qmPhLRT0uWr?=
 =?us-ascii?Q?cjZYu0Dutcmq3LEs4o2TXtn6lV1LiSb8w8fDpShj6ZPNGFn17cqMjiixbefu?=
 =?us-ascii?Q?8X4GH5i7lmy/cRRJr4lAPNYfoWgOZEhp1HMe4rZwFiY29cOt/BKw9Dx4LRD9?=
 =?us-ascii?Q?2BLAJgsFUHPeF/W+XMInsDyi6x2fotmYGiZCr1g4qUGVVdb9uig4AHNeNQ3H?=
 =?us-ascii?Q?zoh3Fijc5R1FqnQxyfpG3PLFH/usf71iTDrkVcQWBkwc8ACUCyziI/irp6dD?=
 =?us-ascii?Q?Ar1yd9JV/CjIMlQQwmwy/ghHR7VrkLavYSYMQcTDkgxdPICnjZ0hnUWs933P?=
 =?us-ascii?Q?L3vmDaXAubZqmbZFkjnTA6Ra+47AedMqZ/KFnOh/SuSsKqqxikK1k+0ZVv2Y?=
 =?us-ascii?Q?lXPR19b5n9jD47NU7MGVKkKrYhTD6ER1eP7mo6Q/Bu8cFr/9RaTtEDwkIEhw?=
 =?us-ascii?Q?wnvKrlFzsGPzqkhcy8K+7rSDbL00JR0ZEEoC8oA9mBX+ak4uDFI9wJfoZyMI?=
 =?us-ascii?Q?/Ne/t5H8D8LrPxPT9t5IA6sENB5y6+hc7SP63l46lNBatrHElDf5tfKXkgoS?=
 =?us-ascii?Q?fFgv7lF+JbCfFg6n1SPVlQmpGDbMj95+3mo5jKAUmOzl2KcuoTPYrXcExL7H?=
 =?us-ascii?Q?kRWN0vagpamWRfT/YBAW9M9HidifuMoyCbTVQcDfuuZtZpzDD7/mzJxJr9nE?=
 =?us-ascii?Q?jCTm+18MN8/4lGsrV1cSLKKe9taOG/1J7SZLZw26AuntnLAVzqifibHygPnK?=
 =?us-ascii?Q?5qkHkXWlTU0tCKSYrXDBRmBhmChQxzOv5QAxw4r4AeCNiGcROGYvERKCElDp?=
 =?us-ascii?Q?gw=3D=3D?=
X-OriginatorOrg: santannapisa.it
X-MS-Exchange-CrossTenant-Network-Message-Id: cae345fc-b475-46df-7382-08db59179f0a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB2880.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2023 09:50:19.3136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d97360e3-138d-4b5f-956f-a646c364a01e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t9Metc8pVwUosvW/Y29vDhGeppKwUBhcE9AZmo4X/yBlN3yR8gC7uco96IXCJ8N8nJLXHFVPgiV3KVNgDvpjdjb8aeq/NsBsJBO5DpP6Ko4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7253
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 19 May 2023 12:12:50 -0400
Vineeth Remanan Pillai <vineeth@bitbyteword.org> wrote:
[...]
> With both these equations, it doesn't solve couple of other issues we
> had discussed before:
> - tasks with different bandwidth reclaims differently even when #tasks
>   is less than #cpus.

I think I now understand this issue (see below)


> - cpu util may go to 100% when we have tasks with large bandwidth
> close to Umax

This one is still not clear to me... I'll do some more analysis.


> As an eg. for issue 1, three tasks - (7,10) (3,10) and (1,10):
> TID[590]: RECLAIM=1, (r=7ms, d=10ms, p=10ms), Util: 95.20
> TID[591]: RECLAIM=1, (r=3ms, d=10ms, p=10ms), Util: 81.94
> TID[592]: RECLAIM=1, (r=1ms, d=10ms, p=10ms), Util: 27.19

So, the issue here is that GRUB tries to assign the reclaimed
utilization proportionally to the task's utilizations... So, 591 should
execute 3 times the amount of time executed by 592, and 590 should
execute 7 times the amount of time executed by 592. Task 592 is then
supposed to execute for 95 / (1 + 3 + 7) = 95 / 11 = 8.63% of the CPU
time; task 591 is supposed to execute for 8.63 * 3 = 25.9% of the CPU
time; task 590 is supposed to execute for 8.63 * 7 = 60.64% of the CPU
time.

So, 592 executes for 8.63 * 3 = 25.9% of the time on one single CPU
(you measured 27.19, but this is nead), task 591 executes for
25.9 * 3 = 77.72% of the time on one single CPU (again, this is
close to what you measured) and task 590 should execute for...
60.64 * 3 = 181.3% of the time on one single CPU! Which is clearly not
possible... And the "max{}" rule cuts this to 95%.

So, we are wasting 181.3 - 95 = 86.3% of CPU time, which 590 cannot
reclaim (because it cannot execute simultaneously on 2 CPUs).

And this is close to the amount of CPU time not reclaimed in the test
you cite above (95 - 81 + 95 - 27)


Now that the problem is more clear to me, I am trying to understand a
possible solution (as you mention, moving some extra bandwidth from the
590's CPU will fix this problem... But I am not sure if this dynamic
extra bandwidth migration is feasible in practice without introducing
too much overhead)

I'll look better at your new proposal.


			Thanks,
				Luca
