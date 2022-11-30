Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C5863CC36
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 01:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiK3AHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 19:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiK3AHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 19:07:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E06210CC
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 16:07:40 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669766858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5SiIziV2QvgfgWy4Sra39N19zHYZdg3yjH/6YkkoY70=;
        b=dR14Xtp6esMbAQrAii7xeIiVEfSQm0RDd3HVtwIR9PCOFih5+eCi/J2GnGG0lKPGyIv8lD
        u1Dw6ZoweVqLEVR5cIDaKtXJFjCx9aSEeCFjh0+FlF6w0N4RFZBqfIgU/V+l/5/Q2rHp3d
        AV8emDpu1AS4x2tBEMvsOZvRtxplISqLl3pmisswtnYzwjYrU69IORthfb0wBpLAUTBbvb
        hSjQTzhpuK2q3SQU5udlonxNETZW4SrgReUgcZQnxpUe8GOH+8umBolLPAWWuRLq3GWCm5
        KE50KgE61neLmUcwcS0NYHjsnaYR2sqiQBV1hlTqW0l+bdlj3b9oVxGsWYA6ow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669766858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5SiIziV2QvgfgWy4Sra39N19zHYZdg3yjH/6YkkoY70=;
        b=ZGTtwUuaLjW/reabBaeefnObjYXel7/uzUNHvxXzyRakUVdAeLKNX1mhnM9h3IWuvm3tPg
        PEe+iAVvZJqrbtCA==
To:     Jann Horn <jannh@google.com>
Cc:     Andrei Vagin <avagin@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] time/namespace: Forbid timens page faults under
 kthread_use_mm()
In-Reply-To: <CAG48ez3UBb3Aq7+AFSmRj5a9czmew5b0PEdhWQ9qvQdeejnJZg@mail.gmail.com>
References: <20221129191839.2471308-1-jannh@google.com>
 <20221129191839.2471308-2-jannh@google.com> <87fse1v4rf.ffs@tglx>
 <CAG48ez3UBb3Aq7+AFSmRj5a9czmew5b0PEdhWQ9qvQdeejnJZg@mail.gmail.com>
Date:   Wed, 30 Nov 2022 01:07:37 +0100
Message-ID: <87y1rttid2.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29 2022 at 23:28, Jann Horn wrote:
> On Tue, Nov 29, 2022 at 10:18 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>> But the way more interesting question is:
>>
>> >  struct page *find_timens_vvar_page(struct vm_area_struct *vma)
>> >  {
>> > +     /*
>> > +      * We can't handle faults where current's timens does not match the
>> > +      * timens associated with the mm_struct. This can happen if a page fault
>> > +      * occurs in a kthread that is using kthread_use_mm().
>> > +      */
>>
>> How does a kthread, which obvioulsy did kthread_use_mm(), end up trying to
>> fault in the time namespace vvar page?
>
> By doing copy_from_user()? That's what kthread_use_mm() is for, right?
> If you look through the users of kthread_use_mm(), most of them use it
> to be able to use the normal usercopy functions. See the users in usb
> gadget code, and the VFIO code, and the AMD GPU code. And if you're
> doing usercopy on userspace addresses, then you can basically always
> hit a vvar page - even if you had somehow checked beforehand what the
> address points to, userspace could have moved a vvar region in that
> spot in the meantime.
>
> That said, I haven't actually tried it. But I don't think there's
> anything in the page fault handling path that distinguishes between
> copy_from_user() faults in kthread context and other userspace faults
> in a relevant way?

True.

>> It neither answers the obvious question why this is a problem of the
>> time namespace vvar page and not a general issue versus a kthread, which
>> borrowed a user mm, ending up in vdso_fault() in the first place?
>
> Is it a problem if a kthread ends up in the other parts of
> vdso_fault() or vvar_fault()? From what I can tell, nothing in there
> except for the timens stuff is going to care whether it's hit from a
> userspace fault or from a kthread.
>
> Though, looking at it again now, I guess the `sym_offset ==
> image->sym_vvar_page` path is also going to misbehave, so I guess we
> could try to instead make the vdso/vvar fault handlers bail out in
> kthread context for all the architectures, since we're only going to
> hit that if userspace is deliberately doing something bad...

Deliberately or stupdily, does not matter. But squashing the problem
right at the entry point is definitely the better than making it a
special case of timens.

>> None of those VDSO (user space) addresses are subject to be faulted in
>> by anything else than the associated user space task(s).
>
> Are you saying that it's not possible or that it doesn't happen when
> userspace is well-behaved?

My subconcious self told me that a kthread won't do that unless it's
buggered which makes the vdso fault path the least of our problems, but
thinking more about it: You are right, that there are ways that the
kthread ends up with a vdso page address.... Bah!

Still my point stands that this is not a timens VDSO issue, but an issue
of: kthread tries to fault in a VDSO page of whatever nature.

Thanks,

        tglx


