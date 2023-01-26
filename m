Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2AC67C445
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 06:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235867AbjAZF0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 00:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjAZF0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 00:26:47 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E282C47ED3;
        Wed, 25 Jan 2023 21:26:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IqiggCEBk3lrbteY/ejgNPQ7Y86OT+Ii+sL+GvUgqS9IFl9x+Fx1ak/ZzJpQ+sx9hUvZeP7z38C7o1Xl5+tmTd+AInLtZ76qRhxBoUfCrdxRCFkS9Eib7tu7VJ8ywoTn4UuZ6eVf+Mge94h5OYjoD7cEkrdsg8u/Wvb+5RaTp8gbB/LEkSTqhek1GZdQlIplthAP6Vw4LFI5hm8esU9lVwkLxs/QnCpI2pnToqxJ8foZ4WM5Rd70fjUz6YFoKvQysMv61jzFt/AgdyeMzXqUxAm3lGYy6pM3jUZXclZpT4E5BpWWlie8wavo1x7PRo55Rj3Jx1J/0c72LRRgFeQfvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8ZlkILZIj+KB2gAECZWByhWYn588uav07lw1bl7z+4=;
 b=oegAikyeWDYxZ/Z2hNGbABe2D6tDkLNoBEcwj7NbmOPWlNG3AukQMQJGGv2SC27XQliRgcCUvzopLzrxn01rs66w03enYs1ANYp9v+VN1LI1C+azYThfMO0Go1UbV+tVIrHi4MrHpKIH9q4k5kdon1FZNSNrnZ/2HrAmdgTaAUSjwTMBINKYAjagzT8LF6H51hvHPeA6cwYk34t2/vAUxkV+5m4D+b7k7WYhldip+fmxMF7Y9AHOk+1AU0I2lTJCkad0pZyOb0bMYnIY9roeT/Bs7FJFzQCCxUB4MIrKksyh9AXTlPEzwb9/BX/i/EzSg8xYSeJP5ioeTGU7IbqxBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8ZlkILZIj+KB2gAECZWByhWYn588uav07lw1bl7z+4=;
 b=OmTEYH0BlwZjLVZZ8xtyTVnGtpOw1u4Yz0nbBKa+AI1Rp894CEI7pT5q+/O9gHVfDOnPUHdh67Mq77iraoNxqxcWDddFJYDtZuaba7aBU8k5Zq7zFMASZ0BAkeiyPsgDHimBd7jWvNW9CrDoDq04e1P4vsZ3Uiy1TVlSKlt2vU0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by DM4PR17MB6293.namprd17.prod.outlook.com (2603:10b6:8:10b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Thu, 26 Jan
 2023 05:26:44 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.6002.033; Thu, 26 Jan 2023
 05:26:44 +0000
Date:   Thu, 26 Jan 2023 00:26:34 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v6 1/2] ptrace,syscall_user_dispatch: Implement Syscall
 User Dispatch Suspension
Message-ID: <Y9IPCpYzfGb6k0sF@memverge.com>
References: <20230125025126.787431-1-gregory.price@memverge.com>
 <20230125025126.787431-2-gregory.price@memverge.com>
 <20230126003008.GA31684@redhat.com>
 <CANaxB-xn0wW5xA_CT7bA5=jig+td__EDKPBWSpZdfgMgVOezCg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANaxB-xn0wW5xA_CT7bA5=jig+td__EDKPBWSpZdfgMgVOezCg@mail.gmail.com>
X-ClientProxiedBy: SJ0PR05CA0066.namprd05.prod.outlook.com
 (2603:10b6:a03:332::11) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|DM4PR17MB6293:EE_
X-MS-Office365-Filtering-Correlation-Id: e0ebfad0-a32c-44bc-82e9-08daff5de9b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WDEzS88L1drG9WC8pZ0AJOBt0Mpf+etGbzbOnWGGx2k2BM9rh5Fg+2aZy7vopPYzJnUXhKgcRA9TZUP0H+uW8QOqJfemhYxZRfJtZ3k6rcg0A9vKK5ExgFJBTohBbQq8jNtObd/LT1N+im5pxJVImVJrQUlfIgu1UUvEvD2PVQHm1PsEtx6uHEFsI39Jtkj7ZuYh4JVXphueH8+Vs8ycuMJugysvKeX2Yh7g3Bu880b+Q4HaFHkgPgCbyN3eMNlV/xhmj02pssEBMY2DsmE/R9S/iMvLnz5CuuVLzxSm9nc1IKzHxeD+96d5KTKjJm7jFo2jPLMqOBlB46gxHKk9wM+KPZTVOnJ1Gk0BJzKfTdlQGg6LyaXz7CT3Z5eu692WVXUOOHzJEITtS+QVgRSY75x+vhA08b3NhLliWtDks5ifqjubdf59wudscTT9cDuhNPjH0LyDASBuVihLMoUWwbxOap9gIjXQx8KF1djp/UVwYeabZsvn0GnB6GekQqTfXNHUJooTiOBuXSoMXhaAKiK9DrxecEIh4KCxtASh51N5dtFd2GXz7EAAxftNwxivz6K9RRU0vGj+oUSwxE1VnlYhMbAb/AkTVn5m3x0T7SEpI865vdgAv4ccliZJ0mCu3LEyk9oHjxiSx3dXMWUhuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(39840400004)(396003)(376002)(136003)(451199018)(66476007)(41300700001)(316002)(54906003)(4326008)(8676002)(86362001)(66946007)(53546011)(186003)(6486002)(478600001)(66556008)(26005)(83380400001)(6666004)(36756003)(6916009)(6512007)(2616005)(44832011)(5660300002)(7416002)(6506007)(2906002)(8936002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z/hjbs3fkubdBa8BsHUUOeoS9ztjcLpNGiVIWmztw4Mp+M0IHewpfDlMXG7r?=
 =?us-ascii?Q?9kQLVtsmXTy/wMbsdtqY6d8WYEqFBwstGG3LYXs7opDz4boHY8cY9gcNgfdp?=
 =?us-ascii?Q?dY3PVaS/BOFX7zS/32NKmW8LOFpziObgqsII5sGxFowYWiFek8B3pUhxzYBZ?=
 =?us-ascii?Q?UMZzFT9cKSQ1uAYQPAo1Uho5EvY/GnIRcmgWMSqsl5JuDw1qp7+DkFHs2X34?=
 =?us-ascii?Q?D4FBKCODA2TLGfCs3q8wS7HkCA4c7nLK8TrZUAFVDu4J5wvQojU3AG2BGYzU?=
 =?us-ascii?Q?BVEaFqxKaL//WPPNWtbnWb61VptWszFn9pMby/7iaslRYN+gj8W74N/gaKHF?=
 =?us-ascii?Q?LEsYiiDjDIwvTKIoLvnBjdmwQ/rWZ3x+t66LjYlAQh3PCTnJm7rg14PeXlh5?=
 =?us-ascii?Q?ITqUUIE2W4dcZYTJMACovoHhyHG5cVfjOXp7ZAq9sSqF9pv4VHEBZbyx+GBE?=
 =?us-ascii?Q?aJ9g0qMylgKGaModNIDIIZ8+dm23RZ1dAHo1zNXdWyG+ux88forJylgfMlpy?=
 =?us-ascii?Q?9/w3dBBG4cZrQxDfaXosMOFeRMN3qUwlo3HlxGf/Gb1g5/G/RqGdrx9/w4u4?=
 =?us-ascii?Q?2ZcoMPdNBMQHm94HpqRgashq0HJCFx0FViStLLHw2Hy3xuGv4BUuIXml1Rsl?=
 =?us-ascii?Q?BlhAeCO+lIE5CCR1x89MDaV1grcmUohTdV/6TQzD2vZRlziuLGm4fWo16449?=
 =?us-ascii?Q?eOFyopYA3MeWtNt8p5275aJ6JLaBjOtiVxLRur8ggtNrWsLc1tAwvvaC3XZ5?=
 =?us-ascii?Q?Qh/eF8GNh42+jCrGNcme4XCmuO+pTr41qzLHmiMlLZHcj2I17w6fuYkCnB8u?=
 =?us-ascii?Q?czCGve7N6i+5EBrCsf0YKBnGJBPCeVNyzD/tSxpiqBO5i0eolvlbQMGtTTCF?=
 =?us-ascii?Q?2Cge9GREpTxXME/1cwdtzkcnS601NWSDbPfRAtnjqHEHRlwasXiHAjnw6HHl?=
 =?us-ascii?Q?s/kI4estu4vW9hCAAI//w6rowDpt4ejMwvB0L1DDRiSxZLtUJe7qhQ/yWO+R?=
 =?us-ascii?Q?I05mp3kuzp94JyLWd9xxIFR9ZpoBz1TL08m4HSzpO5hyFGKEYtlsstCOaTIz?=
 =?us-ascii?Q?toD+FiwUpUO+dCog4E6gW7dWIrYYBeC8HN89BLEri2O1ov5oBDYYNRVnmKpP?=
 =?us-ascii?Q?u4bbTnt+0p4M/mRyuUo73wKdCHqt3xF1mwiXX86IMrIGqHgBbWcXjLZQDaNu?=
 =?us-ascii?Q?DiliJT6Tvx834NSJH6xKmWgJz7H7DImEpOE/QTNJ3Y3AotYBfPEZbRqT+JCf?=
 =?us-ascii?Q?RhRpfZATkeQWk+uJlPqJwn66z7dlM7JVGq5uHY19Az9PNJ45edHsAkRdc7O4?=
 =?us-ascii?Q?ciUtEih9J8zJ1lOznsmcRAIVrJJ6PiPzZDp14aaOfnaJTfAhiHH6RyXqU2KI?=
 =?us-ascii?Q?mHbVP9RWnE+HzB9uKwE+bakh5SX4MqceN2lb7P1e5AVgolgw7uyo5yzWvA4k?=
 =?us-ascii?Q?TSQ0pUQfOMT2qBoJull2QBBK3qOy+WLk4wAHp8S9A18zBaqVHXqSlChVOfHB?=
 =?us-ascii?Q?hboj+H6kHoSb80Yp6xMamRQjaxSV0ZCq7fkWHR9JMGNlw07NXGA9En/yu6Oj?=
 =?us-ascii?Q?3NdxeVN/c4SLki5XK9gRE9J14s8SLRIwHASSF+woV8PfyJz8n3ePXrlRd7yT?=
 =?us-ascii?Q?zA=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ebfad0-a32c-44bc-82e9-08daff5de9b8
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 05:26:44.6758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mOoW7lHaU//OXlhfR/nzSMAx7ADeFJDzpS/KromKoGMQqcr665pRMifFkpNOGQZ1xiFCSsqL66L5HEzNAO53XaU2XYzlYDQbkFewixgvZIo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR17MB6293
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 08:54:48PM -0800, Andrei Vagin wrote:
> On Wed, Jan 25, 2023 at 4:30 PM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > On 01/24, Gregory Price wrote:
> > >
> > > Adds PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH to ptrace options, and
> > > modify Syscall User Dispatch to suspend interception when enabled.
> > >
> > > This is modeled after the SUSPEND_SECCOMP feature, which suspends
> > > SECCOMP interposition.  Without doing this, software like CRIU will
> > > inject system calls into a process and be intercepted by Syscall
> > > User Dispatch, either causing a crash (due to blocked signals) or
> > > the delivery of those signals to a ptracer (not the intended behavior).
> >
> > Cough... Gregory, I am sorry ;)
> >
> > but can't we drop this patch to ?
> >
> > CRIU needs to do PTRACE_SET_SYSCALL_USER_DISPATCH_CONFIG and check
> > config->mode anyway as we discussed.
> >
> > Then it can simply set *config->selector = SYSCALL_DISPATCH_FILTER_ALLOW
> > with the same effect, no?
> 
> Oleg,
> 
> PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH is automatically cleared when
> a tracer detaches. It is critical when tracers detach due to unexpected
> reasons
> (crashes, killed by oom, etc). In such cases, we want to be sure that a
> tracee will continue
> running from the point where it has been trapped.
> 
> Thanks,
> Andrei

There might be a better place for the full C/R discussion, but it's worth
the extra context to hash out the SUSPEND flag.

The relevant kernel code i'm concerned about:

static long syscall_trace_enter(struct pt_regs *regs, long syscall,
        unsigned long work)
{
  long ret = 0;
  /* ... snip ... do syscall user dispatch */
  if (work & SYSCALL_WORK_SYSCALL_USER_DISPATCH) {
    if (syscall_user_dispatch(regs))
      return -1L;
   }
 
  /* Handle ptrace */
  if (work & (SYSCALL_WORK_SYSCALL_TRACE | SYSCALL_WORK_SYSCALL_EMU)) {
    ret = ptrace_report_syscall_entry(regs);
    if (ret || (work & SYSCALL_WORK_SYSCALL_EMU))
      return -1L;
  }

  /* Do seccomp after ptrace, to catch any tracer changes. */
  if (work & SYSCALL_WORK_SECCOMP) {
    ret = __secure_computing(NULL);
  }
	/* ... snip ... */
}

The problem i'm seeing with PTRACE_O_SUSPEND_SUD is that SUD comes before
ptrace, while Seccomp comes after.

CRIU seems to use a few different methods to quiesce:
* ptrace syscall entry traps
* breakpoints (on sigreturn it seems)
* masking everything but SIGSTOP and waiting for a STOP

SUD represent an issue in all three cases
* syscall dispatch preempts ptrace traps (though syscalls may come
  from the exclusion area, so it should hit eventually)
* sigreturn can be changed (glibc prevents this, but the raw sigaction
  syscall will take whatever address you give it)
* masking SIGSYS crashes a program on next dispatch if SUD is enabled

Most of this can be worked around.

My concern is whether there is any injection occuring during the quiesce
phase.  If there is no injection - this SUSPEND isn't needed during
quiesce (and in fact, it's dangerous).  If there is injection, then
the current CRIU quiesce method is incompatible with SUD anyway and this
would take more investigation to determine a solution.

Once quiesced, however, SUD has to be disabled to allow injections. And
I think auto-clearing of the PTRACE Options on detach is a good reason
to keep it.


So basic questions are:
1) Andrei do you think any injection occurs during quiesce that can't be
   worked around?

2) Oleg is the auto-clearing nature of the flag sufficient justification
   for keeping SUSPEND?

~Gregory
