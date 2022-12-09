Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC79647AA9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 01:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiLIATa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 19:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiLIAT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 19:19:28 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034B84E6BC
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 16:19:27 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id g20so1264441iob.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 16:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N4s1VoyFg0x8BEwYI3Jd1cHjzqF5ICTFK/Oyo6lQJXc=;
        b=HLfg81gt915lEnBH+d47rmYM9Kowq2dA5goEDSN7YGd+D1eUd7xyHyPNrmJ7abPZAB
         CCSAnRlIxlF3dHwvRaEbvSOWh7CsulOR3rPAlbcoqgj8PFjvFIpq7rXGw3Dj1zRSu4Wl
         W57b6Y5Ag86JlIc3ih6bQWMin02z8iwitmu2mnzSP5SmcWXxEedt5bSV+0yV7Ud5vt4z
         il3xyJ6yftZq9tYm6Z3pXYLQ47O/QHaHEOG5pabCga+Hnkwz1YJLvksRy2EflWXYZt+q
         gtw292VD905Xp9kp7rUPUulvpCYmJimHi1eYJ6IR6Mn9gRgxF8l7Rue6pzDkgYeybWuW
         zCtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4s1VoyFg0x8BEwYI3Jd1cHjzqF5ICTFK/Oyo6lQJXc=;
        b=qDMe/Td6+a2TVqDoIY6OcNRuFkTU45n3NY1ArGldBeHNtptHDKOXCDLj09xFzro3lX
         VyMYRxb45l8GeRKf9a4c8788Zq0gpCgyA3EUrhdpYSC2e9+esMsz4Ciu4QjT3P3HWoC2
         0Lcqxp/zE652F6weyAC49zOLyRLhya50zuu7HlE0GTf7sgjP61H9aGHWcHe76ZAnrxg+
         piQOrd/qjURElvXbnt9/9Fpg2MQHvSWl1YbhEsPrFNONVskS2AyUgIqj3g1oGP04pTuv
         SLUpJaSFrCSyzYWASK796i5A+RxbK7jTzv0Xpa7YUBhuUozx0Bu7WO6082HjSK5EQLPv
         XoKA==
X-Gm-Message-State: ANoB5pkT2P0Gk4qAhQNxAm4TMffs+r/4/lYO4WmZEpZizCWSJP97IzqF
        BjEdZ6OD5veI8HdMgMSx6KFhvchLgNU8FCTh
X-Google-Smtp-Source: AA0mqf41Z6vSml+Tcmrcl3KGTdQIVPXLe1yv8cElapZWe1zlLureUT1Uy81A5uJaDhYLKCsH0ilQ/Q==
X-Received: by 2002:a6b:4108:0:b0:6db:1092:2780 with SMTP id n8-20020a6b4108000000b006db10922780mr2386617ioa.19.1670545166003;
        Thu, 08 Dec 2022 16:19:26 -0800 (PST)
Received: from google.com ([2620:15c:183:200:4662:6e7c:28a0:dd77])
        by smtp.gmail.com with ESMTPSA id 125-20020a020a83000000b00372e2c4232asm9081779jaw.121.2022.12.08.16.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 16:19:25 -0800 (PST)
Date:   Thu, 8 Dec 2022 17:19:21 -0700
From:   Ross Zwisler <zwisler@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        paulmck@kernel.org, Joel Fernandes <joel@joelfernandes.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH v2] tracing: Add trace_trigger kernel command line option
Message-ID: <Y5J/CajlNh1gexvo@google.com>
References: <20221020210056.0d8d0a5b@gandalf.local.home>
 <CAGRrVHw2ABuBtb+6BtES0WPNpbtu3p6vfZ-pADjtYYxm9kWZ4g@mail.gmail.com>
 <20221208183945.1de18843@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208183945.1de18843@gandalf.local.home>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 06:39:45PM -0500, Steven Rostedt wrote:
> On Thu, 8 Dec 2022 15:27:07 -0700
> Ross Zwisler <zwisler@google.com> wrote:
> 
> > > +#ifdef CONFIG_HIST_TRIGGERS  
> > 
> > Can you help me understand why this is only available if
> > CONFIG_HIST_TRIGGERS is selected in the kernel config?  AFAICT this
> > code doesn't depend on the histogram code, and the run-time selection
> > of triggers is usable without CONFIG_HIST_TRIGGERS.
> 
> Good catch!
> 
> I got confused, and only saw that as "CONFIG_TRIGGERS" and wasn't thinking
> that config was just for histogram triggers :-p
> 
> Care to send a patch to fix it?

Sure, happy to.

One more question: I was playing with this code using examples from 

https://www.kernel.org/doc/html/latest/trace/events.html

and when I tried to create a command line trigger to gather a snapshot:

trace_trigger="sched_switch.snapshot:1 if prev_state == 2"

it hits an oops:

[    0.178179] traps: PANIC: double fault, error_code: 0xffffffffa0a02040
[    0.178187] BUG: unable to handle page fault for address: fffffe000000b000
[    0.178188] #PF: supervisor read access in kernel mode
[    0.178189] #PF: error_code(0x0000) - not-present page
[    0.178191] PGD 23ffc3067 P4D 23ffc3067 PUD 23ffc1067 PMD 23ffc0067 PTE 0
[    0.178193] Oops: 0000 [#1] PREEMPT SMP PTI
[    0.178195] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.1.0-rc7+ #4
[    0.178197] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
[    0.178198] RIP: 0010:__die_header+0x1e/0x7d
[    0.178204] Code: 00 00 31 c0 89 43 50 e9 30 ff 49 ff 0f 1f 44 00 00 8b 05 bf 3c 64 01 49 89 fa 85 c0 75 0e 48 c7 c7 60 f0 bc a1 b9 2a 00 01
[    0.178206] RSP: 0000:fffffe000000aec0 EFLAGS: 00010046
[    0.178207] RAX: 0000000000000000 RBX: ffffffffa0f5aaa8 RCX: 0000000000000002
[    0.178208] RDX: ffffffffa0a02040 RSI: fffffe000000b000 RDI: ffffffffa1bcf100
[    0.178209] RBP: fffffe000000af60 R08: ffffffffa125b280 R09: 6666666666666666
[    0.178209] R10: ffffffffa0f5aaa8 R11: 203a65646f635f72 R12: ffffffffa0a02040
[    0.178210] R13: ffffffffa0a02040 R14: 0000000000000000 R15: 0000000000000000
[    0.178212] FS:  0000000000000000(0000) GS:ffff93ef77c00000(0000) knlGS:0000000000000000
[    0.178213] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.178214] CR2: fffffe000000b000 CR3: 000000004500a000 CR4: 00000000000006b0
[    0.178217] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    0.178218] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    0.178219] Call Trace:
[    0.178223]  <#DF>
[    0.178224]  __die+0x17/0x29
[    0.178227]  die+0x2a/0x50
[    0.178232]  ? zen_untrain_ret+0x1/0x1
[    0.178237]  exc_double_fault+0x173/0x180
[    0.178242]  asm_exc_double_fault+0x1f/0x30
[    0.178248] WARNING: stack recursion on stack type 5
[    0.178249] WARNING: can't access registers at asm_exc_double_fault+0x1f/0x30
[    0.178253]  </#DF>
[    0.178253]  <TASK>
[    0.178254]  ? _raw_spin_unlock_irq+0x11/0x40
[    0.178256]  ? wait_for_completion+0x7e/0x160
[    0.178258]  ? ring_buffer_resize+0x320/0x450
[    0.178262]  ? resize_buffer_duplicate_size+0x38/0xe0
[    0.178264]  ? tracing_alloc_snapshot_instance+0x23/0x40
[    0.178266]  ? register_snapshot_trigger+0x16/0x40
[    0.178269]  ? event_trigger_parse+0x113/0x160
[    0.178272]  ? trigger_process_regex+0xb8/0x100
[    0.178274]  ? __trace_early_add_events+0xb8/0x140
[    0.178275]  ? trace_event_init+0xcc/0x2dd
[    0.178278]  ? start_kernel+0x4a9/0x713
[    0.178281]  ? secondary_startup_64_no_verify+0xce/0xdb
[    0.178285]  </TASK>
[    0.178285] Modules linked in:
[    0.178286] CR2: fffffe000000b000
[    0.220408] ---[ end trace 0000000000000000 ]---
[    0.220409] RIP: 0010:__die_header+0x1e/0x7d
[    0.220411] Code: 00 00 31 c0 89 43 50 e9 30 ff 49 ff 0f 1f 44 00 00 8b 05 bf 3c 64 01 49 89 fa 85 c0 75 0e 48 c7 c7 60 f0 bc a1 b9 2a 00 01
[    0.220412] RSP: 0000:fffffe000000aec0 EFLAGS: 00010046
[    0.220414] RAX: 0000000000000000 RBX: ffffffffa0f5aaa8 RCX: 0000000000000002
[    0.220414] RDX: ffffffffa0a02040 RSI: fffffe000000b000 RDI: ffffffffa1bcf100
[    0.220415] RBP: fffffe000000af60 R08: ffffffffa125b280 R09: 6666666666666666
[    0.220416] R10: ffffffffa0f5aaa8 R11: 203a65646f635f72 R12: ffffffffa0a02040
[    0.220416] R13: ffffffffa0a02040 R14: 0000000000000000 R15: 0000000000000000
[    0.220417] FS:  0000000000000000(0000) GS:ffff93ef77c00000(0000) knlGS:0000000000000000
[    0.220418] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.220419] CR2: fffffe000000b000 CR3: 000000004500a000 CR4: 00000000000006b0
[    0.220421] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    0.220422] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    0.220423] Kernel panic - not syncing: Fatal exception in interrupt

I think that this is because the code to allocate the snapshot buffer uses
workqueues (ring_buffer_resize() calls schedule_work_on() then
wait_for_completion()), but at this point during the init process the
workqueues are up enough that we can enqueue entries, but they are not yet
doing work.

start_kernel() {
...

  /*
   * Allow workqueue creation and work item queueing/cancelling
   * early.  Work item execution depends on kthreads and starts after
   * workqueue_init().
   */
  workqueue_init_early();
  ...

  /* Trace events are available after this */
  trace_init();  // here is where we try and allocate the snapshot

  ...

  arch_call_rest_init();
    rest_init()
      kernel_init()
        kernel_init_freeable()
          workqueue_init()
}

I'm guessing the best we can do here is just disallow snapshot triggers via
the command line option, so that others don't cut themselves on this sharp
corner?  Other ideas?

Thanks,
- Ross
