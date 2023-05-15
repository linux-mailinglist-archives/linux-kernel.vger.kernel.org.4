Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50795703CB8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 20:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243503AbjEOSdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 14:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244251AbjEOSdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 14:33:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0DC16092;
        Mon, 15 May 2023 11:33:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4575B6223A;
        Mon, 15 May 2023 18:33:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B2CC433EF;
        Mon, 15 May 2023 18:33:07 +0000 (UTC)
Date:   Mon, 15 May 2023 14:33:05 -0400
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
        Linus Torvalds <torvalds@linux-foundation.org>,
        dthaler@microsoft.com, brauner@kernel.org, hch@infradead.org
Subject: Re: [PATCH] tracing/user_events: Run BPF program if attached
Message-ID: <20230515143305.4f731fa9@gandalf.local.home>
In-Reply-To: <20230515165707.hv65ekwp2djkjj5i@MacBook-Pro-8.local>
References: <20230508163751.841-1-beaub@linux.microsoft.com>
        <CAADnVQLYL-ZaP_2vViaktw0G4UKkmpOK2q4ZXBa+f=M7cC25Rg@mail.gmail.com>
        <20230509130111.62d587f1@rorschach.local.home>
        <20230509163050.127d5123@rorschach.local.home>
        <20230515165707.hv65ekwp2djkjj5i@MacBook-Pro-8.local>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 May 2023 09:57:07 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> Thank you for these details. Answer below...

Thanks for this well thought out reply!


> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/trace/trace_events_user.c#n451
> > 
> > user_event_enabler_update() {
> > 	[..]
> > 	user_event_enabler_write(mm, enabler, true, &attempt);  
> 
> Which will do
> rcu_read_lock()
> and then call user_event_enabler_write() under lock...
> 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/trace/trace_events_user.c#n385
> > 
> > static int user_event_enabler_write(struct user_event_mm *mm,
> > 				    struct user_event_enabler *enabler,
> > 				    bool fixup_fault, int *attempt)
> > {
> > 	unsigned long uaddr = enabler->addr;
> > 	unsigned long *ptr;
> > 	struct page *page;
> > 	void *kaddr;
> > 	int ret;
> > 
> > 	lockdep_assert_held(&event_mutex);
> > 	mmap_assert_locked(mm->mm);
> > 
> > 	*attempt += 1;
> > 
> > 	/* Ensure MM has tasks, cannot use after exit_mm() */
> > 	if (refcount_read(&mm->tasks) == 0)
> > 		return -ENOENT;
> > 
> > 	if (unlikely(test_bit(ENABLE_VAL_FAULTING_BIT, ENABLE_BITOPS(enabler)) ||
> > 		     test_bit(ENABLE_VAL_FREEING_BIT, ENABLE_BITOPS(enabler))))
> > 		return -EBUSY;
> > 
> > 	ret = pin_user_pages_remote(mm->mm, uaddr, 1, FOLL_WRITE | FOLL_NOFAULT,
> > 				    &page, NULL, NULL);  
> 
> ... which will call pin_user_pages_remote() in RCU CS.
> This looks buggy, since pin_user_pages_remote() may schedule.


Hmm, if that's the case, we should add might_sleep() to that call.

> 
> > 	if (unlikely(ret <= 0)) {
> > 		if (!fixup_fault)
> > 			return -EFAULT;
> > 
> > 		if (!user_event_enabler_queue_fault(mm, enabler, *attempt))
> > 			pr_warn("user_events: Unable to queue fault handler\n");  
> 
> This part looks questionable.
> 
> The only users of fixup_user_fault() were futex and KVM.
> Now user_events are calling it too from user_event_mm_fault_in() where
> "bool unlocked;" is uninitialized and state of this flag is not checked
> after fixup_user_fault() call.
> Not an MM expert, but this is suspicious.

Hmm, yeah, this should be:

static int user_event_mm_fault_in()
{
	bool unlocked = false;

	[..]

out:
	if (!unlocked)
		mmap_read_unlock(mm->mm);
}

Good catch!

> 
> > 
> > 		return -EFAULT;
> > 	}
> > 
> > 	kaddr = kmap_local_page(page);
> > 	ptr = kaddr + (uaddr & ~PAGE_MASK);
> > 
> > 	/* Update bit atomically, user tracers must be atomic as well */
> > 	if (enabler->event && enabler->event->status)
> > 		set_bit(enabler->values & ENABLE_VAL_BIT_MASK, ptr);
> > 	else
> > 		clear_bit(enabler->values & ENABLE_VAL_BIT_MASK, ptr);  
> 
> Furthermore.
> Here the kernel writes bits in user pages.
> It's missing user_access_begin/end.
> Early on there was an access_ok() check during user_event registration,
> but it's not enough.
> I believe user_access_begin() has to be done before the actual access,
> since it does __uaccess_begin_nospec().

But it actually mapped the address to kernel. The ptr is pointing to a
kernel page, not the user space page, but the memory is shared between both.

> 
> Another issue is that the user space could have supplied any address as
> enabler->addr including addr in a huge page or a file backed mmaped address.
> I don't know whether above code can handle it.
> 
> I'm not a GUP expert either, but direct use of pin_user_pages_remote() looks
> suspicious too.
> I think ptrace_may_access() is missing.
> I guess it has to be a root user to do 
> echo 1 > /sys/kernel/tracing/user_events/test/enable
> 
> to trigger the kernel writes into various MM of user processes, but still.
> There are security/LSM checks in many paths that accesses user memory.
> These checks are bypassed here.

I'm happy to audit this further. I'll just have to add that to my TODO list
  :-p

> 
> > 	kunmap_local(kaddr);
> > 	unpin_user_pages_dirty_lock(&page, 1, true);
> > 
> > 	return 0;
> > }
> > 
> > The above maps the user space address and then sets the bit that was
> > registered.
> > 
> > That is, it changes "enabled" to true, and the if statement:
> > 
> > 	if (enabled) {  
> 
> and not just 'volatile' is missing, but this is buggy in general.
> The kernel only wrote one bit into 'enabled' variable.
> The user space should be checking that one bit only.
> Since samples/user_events/example.c registering with reg.enable_bit = 31;
> it probably should be
>   if (READ_ONCE(enabled) & (1u << 31))

The other bits are actually for other tracers. Yeah, it's missing the
de-multiplexing below, and the comment should mention that.

That is, what we decided was to have the API keep bit 31 for the kernel,
but other tracers could map other bits, and we would have the tracing logic
in a place that would allow something like LTTng hook into it and call its
code. Say LTTng is bit 1, then it would set it when it wants a trace.

The if statement is still correct, but the calling into the kernel should
only be done if bit 31 is set.

> 
> > 		/* Yep, trace out our data */
> > 		writev(data_fd, (const struct iovec *)io, 2);
> > 
> > 		/* Increase the count */
> > 		count++;
> > 
> > 		printf("Something was attached, wrote data\n");  
> 
> Another misleading example. The writev() could have failed,
> but the message will say "success".
> And it's easy to make mistake here.
> The iovec[0] should be write_index that was received by user space
> after registration via ioctl.

Yeah, that should be cleaned up.

> 
> If my understanding of user_events design is correct, various user
> process (all running as root) will open /sys/kernel/tracing/user_events_data

Actually, we can change the permissions of user_events_data to allow any
task. Or set the group permission and only allow certain groups access.
tracefs allows changing of ownerships of the files.

> then will do multiple ioctl(fd, DIAG_IOCSREG) for various events and
> remember write_index-es and enabled's addresses.
> Then in various places in the code they will do
> if (READ_ONCE(enabled_X) & (1u << correct_bit)) {
>     io[0].iov_base = &write_index_X;
>     io[1].iov_base = data_to_send_to_kernel;
> 
> and write_index has to match with the format of data.
> During the writev() the kernel will validate user_event_validate(),
> but this is expensive.
> The design of user events looks fragile to me. One user process can write
> into user_event of another process by supplying wrong 'write_index' and the
> kernel won't catch it if data formats are compatible.

But the kernel tracing also includes the pid, so filtering or analysis
could catch that as well.

> 
> All such processes have to be root to access /sys/kernel/tracing/user_events_data,
> so not a security issue, but use cases for user_events seems to be very limited.
> During LSFMMBPF, Steven, you've mentioned that you want to use user_event in chrome.
> I think you didn't imply that chrome browser will be running as root.
> You probably meant something else.

Again, it is easy to change ownership permissions of that file. We can make
allow the chrome group to have write access to it, and everything still
"just works".

> 
> Now as far as this particular patch.
> 
> s/perf_trace_buf_submit/perf_trace_run_bpf_submit/
> 
> may look trivial, but there is a lot to unpack here.
> 
> How bpf prog was attached to user event?
> What is the life time of bpf prog?
> What happens when user process crashes?
> What happens when user event is unregistered ?
> What is bpf prog context? Like, what helpers are allowed to be called?
> Does libbpf need updating?
> etc etc
> 
> No selftests were provided with this patch, so impossible to answer.
> 
> In general we don't want bpf to be called in various parts of the kernel
> just because bpf was used in similar parts elsewhere.
> bpf needs to provide real value for a particular kernel subsystem.
> 
> For user events it's still not clear to me what bpf can bring to the table.
> 
> The commit log of this proposed patch says:
> "When BPF programs are attached to tracepoints created by user_events
> the BPF programs do not get run even though the attach succeeds."
> 
> It looks to me that it's a bug in attaching.
> The kernel shouldn't have allowed attaching bpf prog to user events,
> since they cannot be run.
> 
> Then the commit log says:
> "This keeps user_events consistent
> with how other kernel, modules, and probes expose tracepoint data to allow
> attachment of a BPF program."
> 
> "keep consistent" is not a reason to use bpf with user_events.

Thank you Alexei for asking these. The above are all valid concerns.

-- Steve

> 
> Beau,
> please provide a detailed explanation of your use case and how bpf helps.
> 
> Also please explain why uprobe/USDT and bpf don't achieve your goals.
> Various user space applications have USDTs in them.
> This is an existing mechanism that was proven to be useful to many projects
> including glibc, python, mysql.
> 
> Comparing to user_events the USDTs work fine in unprivileged applications
> and have zero overhead when not turned on. USDT is a single 'nop' instruction
> while user events need if(enabled & bit) check plus iov prep and write.
> 
> When enabled the write() is probably faster than USDT trap, but all the extra
> overhead in tracepoint and user_event_validate() probably makes it the same speed.
> So why not USDT ?

