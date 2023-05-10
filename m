Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15BDF6FD516
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 06:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235221AbjEJEhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 00:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjEJEg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 00:36:58 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2113.outbound.protection.outlook.com [40.107.8.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D90A3C3A
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 21:36:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gbsEtb2uUesdXAZe2ch+uAWNiRKzwI1oEbYxbvlYkNFj6wymcKJvu7NjSUobJsrvAreBiX7me1bqMHKikmnIxllZSX9zQqwnFADiHw22P/9inDPG3JALezbH9VF2uVYT05p0bYEYu5mL+S+bMygNTS3OEaPRvLjGukbn6TjvnYO/ZlYWHIQJQ90+cnLKzYgZP9g6IUI/NzI3j0AxTGKY1K+Y5G6ps7eW9LBmsKHvKZ1drGiGWLsbcVTn1/ALXZwZ3p3ghIvZJ0WO4balFJ+D2qf6Hw0mKB5M6pYIk/55YWHW9abltdST+W+Cbrhgp+/+bEaO06h/pXh/OyRZhCZZyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwWVTyOVOeurwD6m4U5VTzYmhZzq7Tjb892awsqAN20=;
 b=MoadMR8Ua054NCU54T/mfBHemQ/r+luvbMaksVng3ken5qlpvFq99JC+qnGQkM5ucOyhAXhV5rUHBNve+K9ec9/xjRU0a1uigO88qrKOL0JSsGYeMzauAVCz3DKfbQjU1xxkdKlXvV/xHkDDXowgio74db5haytOctMdSQ3PO9wvF9uV6YGcqMvAG0/yGBgVqBo7UAIJZhnhXIYfOsb5Y51OILUgshpvL75YeZORrpMdf9qBIreaYhUZqsuhXgZqK7WvnOrcU6EE/8nKv5vlb99KqgSmBe30Gj4WpkHlMI1PQbZarlOnrnzZ+StbspTVwHP4XujSSCr0apYuKXJqHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwWVTyOVOeurwD6m4U5VTzYmhZzq7Tjb892awsqAN20=;
 b=yYFOULrdBEDCk4ngqOE/1mb/adR4ZF/yA+JpEkLU9/+Glp2BMY+vcV9vtyVgvfUgR86HVVB+LoPdcX4i8qNy4nxRuvOLcqZkEKD0+PgtyVmOGPPxG1arMcih+5Skd+Jr9fYk3Pc1q09zxBQaR7vR4YtxY6Uu0KzjyL0zEjgbqXk/51OJAV5LF8mRLvnslAY7Qcmha2UNn0VTZw273KEmLgxR9TSf//yXiPVynuFje+UcxcTKLoeGzIsIcTKgkY8/fjBBKRxjH215k96BXPkBW7CfX+RfI9Wi6skPpfgm3HKeBoAkzmUl7Db8EMm73CsbLbFM51xPTBitJfieISz2lQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DB8PR08MB4987.eurprd08.prod.outlook.com (2603:10a6:10:e2::16)
 by AS8PR08MB6120.eurprd08.prod.outlook.com (2603:10a6:20b:299::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.19; Wed, 10 May
 2023 04:36:54 +0000
Received: from DB8PR08MB4987.eurprd08.prod.outlook.com
 ([fe80::3f06:86a7:109f:43a9]) by DB8PR08MB4987.eurprd08.prod.outlook.com
 ([fe80::3f06:86a7:109f:43a9%6]) with mapi id 15.20.6363.033; Wed, 10 May 2023
 04:36:54 +0000
Message-ID: <009e7658-1377-cc79-7a42-4dda8fec5af0@virtuozzo.com>
Date:   Wed, 10 May 2023 12:36:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFD] posix-timers: CRIU woes
To:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andrei Vagin <avagin@openvz.org>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Pavel Emelyanov <xemul@openvz.org>
References: <20230425181827.219128101@linutronix.de>
 <20230425183312.932345089@linutronix.de> <ZFUXrCZtWyNG3Esi@lothringen>
 <87zg6i2xn3.ffs@tglx> <87v8h62vwp.ffs@tglx> <878rdy32ri.ffs@tglx>
 <87v8h126p2.ffs@tglx> <875y911xeg.ffs@tglx> <87ednpyyeo.ffs@tglx>
Content-Language: en-US
From:   Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
In-Reply-To: <87ednpyyeo.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0070.apcprd01.prod.exchangelabs.com
 (2603:1096:820:5::34) To DB8PR08MB4987.eurprd08.prod.outlook.com
 (2603:10a6:10:e2::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB4987:EE_|AS8PR08MB6120:EE_
X-MS-Office365-Filtering-Correlation-Id: c2a43ccc-9163-48e7-ce2f-08db51102e17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D+JA0q7qvzZh0uJ7Rfbk/MNukMKlVRJGWeoqSnNcSQFdKeII9S/JCMG6zdRoXxJTa6x2ukOcaLlNn6EzV7x7nwY+eSEEQ5KiEsx9TXNmkvAWh2UElEJStFWDhNEwzUYlxB9KNA4avIB7qWdOPpXTvPO0ymirDd5RJo0iPCDOycMB4GOkk/aq5g1TYKd6HWJzywPy1PCGKBC1/bCC+O2Telp12J+8pw2Nu4w2Kjy2wPSip/3OSG/7wriegldu9U/kGPfOyxtY7h0X5lJoK6TWiEUS95H75HIXNboJKO/k+HO6ybf/orQz7kQBPz2cZJ+aF4IwwQIovw7+SJ0OfRW+jhsfZieXGOtkoav4zgYP1+WYKdepS0MmEqNLa1vfMdQyzWLus2Bv1O0IW1B1GsU1DoMTTjJmn0aYTVt4Y6yJTnjmOk0AN5PUiRiIhwLQo2JaR3HRBgL6S3i0YyiJW+YPSFZuesk9MpVf7DYEv/krt2KdzlKAG1DGdIRo/vO+C7XPet6jHtZ5V5N01I+uycZXqeVOn1mCiEPlM6GsoesV+4VCO79ciIbEGAk8oeEW1BaYAe2QC+gZnKEgmPSQrnj92iWAQebroQlqpqOpO/M2GYA6zfRHCIp0JkqHp4UIfisjegNDdTGHyEd4mkBm6/EgvYvCXJxe/LZMalwzYjIrXXmHXqduQfDb9nntsWqDrqNA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB4987.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(39850400004)(396003)(376002)(451199021)(31696002)(8936002)(8676002)(41300700001)(5660300002)(7416002)(31686004)(86362001)(66946007)(66556008)(66476007)(2906002)(316002)(4326008)(54906003)(478600001)(110136005)(38100700002)(966005)(6486002)(6666004)(2616005)(107886003)(6512007)(53546011)(6506007)(186003)(36756003)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWFXRVkvdlcrc2VzZ0FyVWVCSE5tNEpodnNzV3Z1a3dVOElWMXVwMTg4TGtP?=
 =?utf-8?B?K1BrazlLd1M0US9wUExmSDhCVHBNcmNuWFFubnY5U0RuczRyUmxwaXcvZ2tT?=
 =?utf-8?B?eG9xTGt3amg1Q0VJOFpaVXVPdG5qU0NVSU9oL2JCdjR1eFRIUGdjallQQ1RF?=
 =?utf-8?B?M3ZNdEFMaTJEbExRN2dOZGMxKzlzemdZQjZKZ3J2UjE2LzRXM1kveEttQTZx?=
 =?utf-8?B?M0lmbklpc1o2ZFQ3aTBkSmJsaUI3UXdDMXF5WGNPMzNxOWxIRFRrYmFvUHJB?=
 =?utf-8?B?NUNJWU5ManREY1dRclRHNmZ5Qm1JdEFNL1BYYS90SDA3ZGRYTkZObExEUlJZ?=
 =?utf-8?B?ZzNKdjVWbE1zbGNYMUZ3NUErQ1FtTFlZTUNFUmtNb09hN0cwY2ZYbytiSTJm?=
 =?utf-8?B?MHp1TjM4N1V5aTBUeE9lNVZnK2NQM2FDYWhBRFBsUk5CdEZDbkhqQmIvN3Fl?=
 =?utf-8?B?dWV5ajJ4NE5wOTZiOW15OG1jUjFCdTI4NEtBSXk5dkZtRmhrdXJEelNCQVF6?=
 =?utf-8?B?Q3NvT0ZrQUtxdmg0Z1lZa1MySjRYZFdIS3ZEMVJPTC96K0NiaGJ4c1gvTHJk?=
 =?utf-8?B?cFgveVcxTTd4a1hEM0pLUmN5R211djEvM0t0V0tsYkRIME9rQnV4dzhXREJn?=
 =?utf-8?B?OEVramUwNDRsT0FBUnV4VWZpVDFPR0Z0UHErZGFTc3FtaHM4VkVmYXBTc0dV?=
 =?utf-8?B?UVBNeFcxN1FLRXUrRFdUazRESWlZcVFyTlhXQjR5QmtTMTdjNGZaSzc3Skdh?=
 =?utf-8?B?VThBSG5STFBwbXR6T09pbk45YzdjNUNqaXpldVo3d0VKbEdOMktVUnI5VlhY?=
 =?utf-8?B?NlhIMGR4Qzh6RzUxeGg3K2lwWDNXLzU1RUtSWG1Hd1FMejd4djNvUTFaSkEy?=
 =?utf-8?B?Tzl5WGRQSUtkTVA3YXNtV3A5MEVnRml0V083MnF6dVZkK2s3Qno2TDU2TkJn?=
 =?utf-8?B?bVB3cUxZR25SYm05SGRQemRpWWFKcmRTSVZvRExKUDA0RG1MUjJtM1FwOHhE?=
 =?utf-8?B?ZGlKa2hzMWxDcDBsR00xZUdPRlVaeHZNRngwWDM3UXRBZnJ4Tlg2TU40R0pC?=
 =?utf-8?B?OWxKSmd6ZnRIZnN5U0h0ZmllY3J6Ylg1UjhQQklrNGhLN3hsNmxIQTF5ajNh?=
 =?utf-8?B?U29SZnl0QndHdTRFMTc5bStYb0dJVnIwaFpZSWkvYXhjOGNoMkxZd2FpTElQ?=
 =?utf-8?B?YWVLelE0SlhkVDhYTDE4K0svL3FmUG01NXJNdnlaUVZkcHk2WTFiQlBjZWFv?=
 =?utf-8?B?Q0htOURKQUhJK1g0dEwxV2x3d0RacHI4S1FjRDV4ditaZGpxM2xSRjg2MDNW?=
 =?utf-8?B?YVRsQlo3bTdqM0h3UGRqVzBKTXU4Q0trUldoSnZSWWYrRkt0emFGbURPVGwy?=
 =?utf-8?B?ZE1uSENNOVEzWnplYTFiQmV4U212SDZtL1BMbWtNMUEyN3l3dDRGM0lhUkIv?=
 =?utf-8?B?MEQxODJZWVlaWnhZRU5uZHpQbWFPTjB3amRQS1VSQmgwMnM4LzE1Y0dka2h4?=
 =?utf-8?B?RmNXUlMyVzgvMytrR1ZnZzk3VlEyT2dQVk1jV3dHWFpoRGUyYWdBTklIZjRx?=
 =?utf-8?B?b2YybWs0bkFLMi96RlgyR01ISU5id3E2QnN4RHlHYnc5VWZ6MHMvaTJtZEE2?=
 =?utf-8?B?OU85VzNySzVjbi9zVFhESlNOa01YTVdLK3NCZlc2TlF0MFdQdnBHYUZJbkZ3?=
 =?utf-8?B?NjlEQ3luWFlPVk9pVWJDeVJ1Z2hBNEwyZkQ3bUh6TEhRb0wrNnRJM1pIT2ZE?=
 =?utf-8?B?Tm5VVVBRN3JYTngrMmVlNjh1SmcrZHpnMzVXZ0RvaDBpOWRlelFzNEhsSXNo?=
 =?utf-8?B?YlhFZUV1Q2UyNkp3dGw2dFc3L0lyejQwWFpsVGhJNUc1bm1hbk1DL0wxZEpk?=
 =?utf-8?B?Q0hYZFJ1L0xuMGpJR2xYQ0JVbTNJZkFtNmx1clB0L3BpK3l4dnZMQkVIcGZH?=
 =?utf-8?B?TC9DSVRiTHl0eXBLSWxBUkYzL25nYUxPbDBvck5mbHU4Y2FhT3k0YXptcVZ5?=
 =?utf-8?B?cW9KdlB2Rmh0aHpxK0ErdENLUGR3QnJBblBLaXVzdnAvalZaUzFrYWVWbWhH?=
 =?utf-8?B?cWh2QzJKS2trZmwvQ1hhWEtIQ3JDVzltY3FBTmF2bjZlU3hBNlFteTJtaTND?=
 =?utf-8?B?TWpLSVR4RGZYeXpTcnBmV1VUbVorMk1EazhpTk1aVzJKYjMybi9Sam55eG95?=
 =?utf-8?B?Y0xCK0w1SXNMVjE1a0ZuWmg2Q1VFdzBidHB2eTNpaU5PckcwWjJuUHQ4ampm?=
 =?utf-8?B?OUJvU2lyV3B2NWF4akVONzVIZEd3PT0=?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a43ccc-9163-48e7-ce2f-08db51102e17
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB4987.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 04:36:54.1868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cn+b1FsTi06YTvKk5tKSLKW2+6LF8MgQjLQMuNN/9j0wVu7Kjf+a7yDfPn1dxGWk74pxC3nNsCX2Sng7ZzYA1Tm0hIZ8RfBXMCaUkbDPFsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6120
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10.05.2023 05:42, Thomas Gleixner wrote:
> Hi!
> 
> This is a summary of several mails so that the CRIU people have the full
> picture.
> 
> A recent syzbot report made me look at the timer ID management, which
> was modified 7 years ago to accomodate CRIU:
> 
>      5ed67f05f66c ("posix timers: Allocate timer id per process (v2)")
> 
> and introduced that reported issue along with a bogus loop termination
> problem. See
> 
>      https://lore.kernel.org/lkml/000000000000a3723305f9d98fc3@google.com/
>      https://lore.kernel.org/lkml/20230425183312.932345089@linutronix.de
> 
> for details.
> 
> The intent to make the timer IDs per process is definitely correct, but
> the implementation is beyond suboptimal. I really regret that I did not
> catch this back then when picking those changes up.
> 
> The way it works is that each process keeps a 'next_timer_id' which it
> uses to allocate the next timer. That allows CRIU to reconstruct timers
> with the same ID by walking the ID space via
> 
>    do {
>       timer_create(&timer, ...., &id);
>       if (id == original_id)
>          goto success;
>       timer_delete(&timer);
>    } while (idspace_not_exhausted());
> 
> That works by some definition of works, but it is problematic in two ways:
> 
>   1) As the timer ID space is up to INT_MAX, a process which creates and
>      deletes timers frequently, can easily move up close to the INT_MAX
>      id space over time.
> 
>      If such a process is checkpointed and restored, then the above loop
>      will run for at least an hour to restore a single timer.
> 
>      And no, this is not only a hypothetical issue. There are legitimate
>      scenarios where threads are created and the control thread arms a
>      posix CPU timer on them. Such threads can be torn down on a regular
>      base due to thread pool consolidations. As CRIU does not happen
>      every 5 minutes it's not completely unlikely that such a process
>      surives quite some time on a particular host and thereby approaches
>      the ID space limit.
> 
>      Sure we can restrict the ID space to a way smaller number so the
>      search wraps around earlier, but what's a sensible limit?
> 
>      Though restricting the ID space has its own issue vs. backwards
>      compability. A process which created a timer on an older kernel with
>      an ID larger than the newer kernels ID limit cannot longer be
>      restored on that newer kernel.
> 
>      Aside of that it does not solve the other problem this created:
> 
>   2) That change created an user space ABI, which means that the kernel
>      side has to stick with this next ID search mechanism forever.
> 
>      That prevents to get rid of that global lock and hash table by
>      sticking an xarray into task::signal which makes a lot of sense in
>      terms of cache locality and gets rid of the extra timer list
>      management in task::signal. Making this change would be very useful
>      to address some other issues in the posix-timer code without
>      creating yet more duct tape horrors.
> 
>      Such a change obviously has to aim for a dense ID space to keep the
>      memory overhead low, but that breaks existing CRIU userspace because
>      dense ID space and next ID search does not fit together.
> 
>      Next ID search is obviously creating non-recoverable holes in the
>      case that timers are deleted afterwards.
> 
>      A dense ID space approach can create holes too, but they are
>      recoverable and well within the resource limits, because the process
>      has to be able to create enough timers in the first place in order
>      to release those in the middle.
> 
>      With the next ID search brute force recovery is not possible on a
>      kernel with dense ID as there is no way to create all intermediate
>      timers first before reaching the one at the far end due to resource
>      limits.
> 
> So because of that half thought out user space ABI we are now up the
> regression creek without a paddle, unless CRIU can accomodate to a
> different restore mechanism to lift this restriction from the kernel.
> 
> Thoughts?

Maybe we can do something similar to /proc/sys/kernel/ns_last_pid? 
Switch to per-(process->signal) idr based approach with idr_set_cursor 
to set next id for next posix timer from new sysctl?

> 
> Thanks,
> 
>          tglx
> 
> 

-- 
Best regards, Tikhomirov Pavel
Senior Software Developer, Virtuozzo.
