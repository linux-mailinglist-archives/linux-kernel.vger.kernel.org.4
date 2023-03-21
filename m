Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D796C3AF7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 20:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjCUTr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 15:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjCUTrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 15:47:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F20912048;
        Tue, 21 Mar 2023 12:46:55 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679427986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1Rs5/iSZ1LvCtN8GnV4DFn0gidXDMsrpb4/rO2vlH+E=;
        b=H+KM0mHvShbzhqk+uUhmOrrc7mijExoLfBKvRiWNLfFhaPLTGyqOSAYSXRp75nFB941cxq
        d69iC/mSzWRXTfmCUwjn7TBJKzzTDKnArDQIS6In9g7D6llT/rXJlxITvgBFAdOcd8xbcC
        JQs6SHh0OEsbr0f6tKlLapbYCChoUKMh2P3a/wtJg4dfMbMEOHc89GBCSwEwHPRlsEt9pq
        VGPGzGYhVinVJNqaaqlVU/4qrVU3Kp8tJBnNVm5frd1Lyg8W3AfiOO52JdJMGejSXjUuan
        DvfAJNN/jkzgem8F1E+ZCNupZLnuL2/L4p5MAnwA3wO7OSfzZfiHaZYcbNs0KQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679427986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1Rs5/iSZ1LvCtN8GnV4DFn0gidXDMsrpb4/rO2vlH+E=;
        b=qJtCcJVHQ8MUoNrry7fs1IolvCg0xw9orbio2Avz2vOYF69iMXKWKBG9J18sH6Xa4pubfH
        COO0TnQFcOBsz9Aw==
To:     Gregory Price <gregory.price@memverge.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        oleg@redhat.com, avagin@gmail.com, peterz@infradead.org,
        luto@kernel.org, krisman@collabora.com, corbet@lwn.net,
        shuah@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v13 1/3] syscall_user_dispatch: helper function to
 operate on given task
In-Reply-To: <ZBnhmtvlenY15P32@memverge.com>
References: <20230301205843.2164-1-gregory.price@memverge.com>
 <20230301205843.2164-2-gregory.price@memverge.com> <87cz529kni.ffs@tglx>
 <ZBnhmtvlenY15P32@memverge.com>
Date:   Tue, 21 Mar 2023 20:46:26 +0100
Message-ID: <87a605anvx.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21 2023 at 12:55, Gregory Price wrote:
> On Tue, Mar 21, 2023 at 04:41:37PM +0100, Thomas Gleixner wrote:
>> On Wed, Mar 01 2023 at 15:58, Gregory Price wrote:
>> > +static int task_set_syscall_user_dispatch(struct task_struct *task, unsigned long mode,
>> > +					  unsigned long offset, unsigned long len,
>> > +					  char __user *selector)
>> >  {
>> >  	switch (mode) {
>> >  	case PR_SYS_DISPATCH_OFF:
>>         ...
>> 
>> 	case PR_SYS_DISPATCH_ON:
>> 		if (selector && !access_ok(selector, sizeof(*selector)))
>> 			return -EFAULT;
>> 
>> I'm not seing how this can work on ARM64 when user pointer tagging is
>> enabled in the tracee, but not in the tracer. In such a case, if the
>> pointer is tagged, access_ok() will fail because access_ok() wont untag
>> it.
>
> I see that untagged_addr(x) is available to clear tags, I don't see an
> immediate issues with converting to:
>
> !access_ok(untagged_addr(selector), sizeof(*selector))

If this would be correct, then access_ok() on arm64 would
unconditionally untag the checked address, but it does not. Simply
because untagging is only valid if the task enabled pointer tagging. If
it didn't a tagged pointer is obviously invalid.

Why would ptrace make this suddenly valid?

Just because it's in the way of what you want to achieve is not a really
sufficient justification.

Thanks,

        tglx
