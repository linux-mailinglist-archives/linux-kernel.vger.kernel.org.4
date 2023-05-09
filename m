Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC326FCF82
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 22:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbjEIUa5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 9 May 2023 16:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234959AbjEIUa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 16:30:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443FE40F7;
        Tue,  9 May 2023 13:30:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5AE16170B;
        Tue,  9 May 2023 20:30:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C990AC433EF;
        Tue,  9 May 2023 20:30:52 +0000 (UTC)
Date:   Tue, 9 May 2023 16:30:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Beau Belgrave <beaub@linux.microsoft.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        David Vernet <void@manifault.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] tracing/user_events: Run BPF program if attached
Message-ID: <20230509163050.127d5123@rorschach.local.home>
In-Reply-To: <20230509130111.62d587f1@rorschach.local.home>
References: <20230508163751.841-1-beaub@linux.microsoft.com>
        <CAADnVQLYL-ZaP_2vViaktw0G4UKkmpOK2q4ZXBa+f=M7cC25Rg@mail.gmail.com>
        <20230509130111.62d587f1@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 May 2023 13:01:11 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > I see no practical use case for bpf progs to be connected to user events.  
> 
> That's not a technical reason. Obviously they have a use case.

Alexei,

It was great having a chat with you during lunch at LSFMM/BPF!

Looking forward to your technical response that I believe are
legitimate requests. I'm replying here, as during our conversation, you
had the misperception that the user events had a system call when the
event was disabled. I told you I will point out the code that shows
that the kernel sets the bit, and that user space does not do a system
call when the event is disable.

From the user space side, which does:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/samples/user_events/example.c#n60

	/* Check if anyone is listening */
	if (enabled) {
		/* Yep, trace out our data */
		writev(data_fd, (const struct iovec *)io, 2);

		/* Increase the count */
		count++;

		printf("Something was attached, wrote data\n");
	}


Where it told the kernel about that "enabled" variable:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/samples/user_events/example.c#n47

	if (event_reg(data_fd, "test u32 count", &write, &enabled) == -1)
		return errno;

static int event_reg(int fd, const char *command, int *write, int *enabled)
{
	struct user_reg reg = {0};

	reg.size = sizeof(reg);
	reg.enable_bit = 31;
	reg.enable_size = sizeof(*enabled);
	reg.enable_addr = (__u64)enabled;
	reg.name_args = (__u64)command;

	if (ioctl(fd, DIAG_IOCSREG, &reg) == -1)
		return -1;

	*write = reg.write_index;

	return 0;
}

The above will add a trace event into tracefs. When someone does:

 # echo 1 > /sys/kernel/tracing/user_events/test/enable

The kernel will trigger the class->reg function, defined by:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/trace/trace_events_user.c#n1804

	user->class.reg = user_event_reg;

Which calls: 

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/trace/trace_events_user.c#n1555

	update_enable_bit_for(user);

Which does:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/trace/trace_events_user.c#n1465

update_enable_bit_for() { 
	[..]
	user_event_enabler_update(user);


https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/trace/trace_events_user.c#n451

user_event_enabler_update() {
	[..]
	user_event_enabler_write(mm, enabler, true, &attempt);

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/trace/trace_events_user.c#n385

static int user_event_enabler_write(struct user_event_mm *mm,
				    struct user_event_enabler *enabler,
				    bool fixup_fault, int *attempt)
{
	unsigned long uaddr = enabler->addr;
	unsigned long *ptr;
	struct page *page;
	void *kaddr;
	int ret;

	lockdep_assert_held(&event_mutex);
	mmap_assert_locked(mm->mm);

	*attempt += 1;

	/* Ensure MM has tasks, cannot use after exit_mm() */
	if (refcount_read(&mm->tasks) == 0)
		return -ENOENT;

	if (unlikely(test_bit(ENABLE_VAL_FAULTING_BIT, ENABLE_BITOPS(enabler)) ||
		     test_bit(ENABLE_VAL_FREEING_BIT, ENABLE_BITOPS(enabler))))
		return -EBUSY;

	ret = pin_user_pages_remote(mm->mm, uaddr, 1, FOLL_WRITE | FOLL_NOFAULT,
				    &page, NULL, NULL);

	if (unlikely(ret <= 0)) {
		if (!fixup_fault)
			return -EFAULT;

		if (!user_event_enabler_queue_fault(mm, enabler, *attempt))
			pr_warn("user_events: Unable to queue fault handler\n");

		return -EFAULT;
	}

	kaddr = kmap_local_page(page);
	ptr = kaddr + (uaddr & ~PAGE_MASK);

	/* Update bit atomically, user tracers must be atomic as well */
	if (enabler->event && enabler->event->status)
		set_bit(enabler->values & ENABLE_VAL_BIT_MASK, ptr);
	else
		clear_bit(enabler->values & ENABLE_VAL_BIT_MASK, ptr);

	kunmap_local(kaddr);
	unpin_user_pages_dirty_lock(&page, 1, true);

	return 0;
}

The above maps the user space address and then sets the bit that was
registered.

That is, it changes "enabled" to true, and the if statement:

	if (enabled) {
		/* Yep, trace out our data */
		writev(data_fd, (const struct iovec *)io, 2);

		/* Increase the count */
		count++;

		printf("Something was attached, wrote data\n");
	}

Is now executed.

-- Steve

