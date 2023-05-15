Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26FFA703DC6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 21:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245186AbjEOTfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 15:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244201AbjEOTfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 15:35:42 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 139D226AC;
        Mon, 15 May 2023 12:35:41 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id 42A012044710;
        Mon, 15 May 2023 12:35:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 42A012044710
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1684179340;
        bh=PcFG+iIa/PA7p0IIgskPb1ruV+sX7mzcczF0a582zuI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dZC0Y1cjSTLSoaHgLlbLJz9qTrQZ3hbcf9ZlQOPGYVMVbbgOQUi309o/v++fIOct8
         LHS6+lCLPr2yc32sNNHeyQ5P/wGZYLepluAC+iqSDagyJ+z/heZVKg/h/vy+tMLiRH
         PuNPVhL0D1XkdrY1gEUA1LyM//Mw+1f+cCn7ln4U=
Date:   Mon, 15 May 2023 12:35:32 -0700
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
Message-ID: <20230515193532.GA153@W11-BEAU-MD.localdomain>
References: <20230508163751.841-1-beaub@linux.microsoft.com>
 <CAADnVQLYL-ZaP_2vViaktw0G4UKkmpOK2q4ZXBa+f=M7cC25Rg@mail.gmail.com>
 <20230509130111.62d587f1@rorschach.local.home>
 <20230509163050.127d5123@rorschach.local.home>
 <20230515165707.hv65ekwp2djkjj5i@MacBook-Pro-8.local>
 <20230515143305.4f731fa9@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515143305.4f731fa9@gandalf.local.home>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 02:33:05PM -0400, Steven Rostedt wrote:
> On Mon, 15 May 2023 09:57:07 -0700
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> 
> > Thank you for these details. Answer below...
> 
> Thanks for this well thought out reply!
> 
> 

[...]

> > 
> > > 	if (unlikely(ret <= 0)) {
> > > 		if (!fixup_fault)
> > > 			return -EFAULT;
> > > 
> > > 		if (!user_event_enabler_queue_fault(mm, enabler, *attempt))
> > > 			pr_warn("user_events: Unable to queue fault handler\n");  
> > 
> > This part looks questionable.
> > 
> > The only users of fixup_user_fault() were futex and KVM.
> > Now user_events are calling it too from user_event_mm_fault_in() where
> > "bool unlocked;" is uninitialized and state of this flag is not checked
> > after fixup_user_fault() call.
> > Not an MM expert, but this is suspicious.
> 
> Hmm, yeah, this should be:
> 
> static int user_event_mm_fault_in()
> {
> 	bool unlocked = false;
> 
> 	[..]
> 
> out:
> 	if (!unlocked)
> 		mmap_read_unlock(mm->mm);
> }
> 
> Good catch!
> 

I don't believe that's correct. fixup_user_fault() re-acquires the
mmap lock, and when it does, it lets you know via unlocked getting set
to true. IE: Something COULD have changed in the mmap during this call,
but the lock is still held.

See comments here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/gup.c#n1287

Thanks,
-Beau

> 
> Thank you Alexei for asking these. The above are all valid concerns.
> 
> -- Steve
> 
