Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9BB772F9B2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 11:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243644AbjFNJqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 05:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243895AbjFNJqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:46:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633F1DF
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 02:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686735925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UjCyqPxmCD9vxBVN8OqdZcSx2BohbRjUAgubXHv/O0A=;
        b=IMuzfPgHZMFTGj3cxlS3KJKBUYNnXGl5mmtFrV044yYy+sSDSngJWrUHhaaafeiyXX/987
        pE5uk+xtO2uAAlp3SzkSYc61r8ktBxGdvWyhI9G6fUQ3pEEX6/q5WgEh4W6iQzs6sHPzDQ
        V05syYWM2nZAVKlCdtu0bIDbM1lXL1E=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-277-fxmB5WdTOdS9wVER1wEvgA-1; Wed, 14 Jun 2023 05:45:23 -0400
X-MC-Unique: fxmB5WdTOdS9wVER1wEvgA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 69E271C0A587;
        Wed, 14 Jun 2023 09:45:23 +0000 (UTC)
Received: from localhost (unknown [10.39.192.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2C820492CA6;
        Wed, 14 Jun 2023 09:45:23 +0000 (UTC)
Date:   Wed, 14 Jun 2023 10:45:22 +0100
From:   "Richard W.M. Jones" <rjones@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Aaron Thompson <dev@aaront.org>, linux-kernel@vger.kernel.org
Subject: Re: printk.time causes rare kernel boot hangs
Message-ID: <20230614094522.GA7636@redhat.com>
References: <20230613134105.GA10301@redhat.com>
 <20230614092158.GF1639749@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614092158.GF1639749@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 11:21:58AM +0200, Peter Zijlstra wrote:
> On Tue, Jun 13, 2023 at 02:41:05PM +0100, Richard W.M. Jones wrote:
> > [Being tracked in this bug which contains much more detail:
> > https://gitlab.com/qemu-project/qemu/-/issues/1696 ]
> 
> Can I please just get the detail in mail instead of having to go look at
> random websites?

Sure, the kernel hangs after printing:

[    0.070120] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.070120] Last level iTLB entries: 4KB 512, 2MB 255, 4MB 127
[    0.070120] Last level dTLB entries: 4KB 512, 2MB 255, 4MB 127, 1GB 0
[    0.070120] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.070120] Spectre V2 : Mitigation: Retpolines
[    0.070120] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.070120] Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
[    0.070120] Spectre V2 : Enabling Speculation Barrier for firmware calls
[    0.070120] RETBleed: Mitigation: untrained return thunk
[    0.070120] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.070120] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    0.070120] Freeing SMP alternatives memory: 48K

The next message we'd expect here would be:

[    0.070794] smpboot: CPU0: AMD Ryzen 9 3900X 12-Core Processor (family: 0x17, model: 0x71, stepping: 0x0)

I believe this bug would affect baremetal too, basically any kernel
compiled with CONFIG_PRINTK_TIME.  However the hang is very rare.

> > Recent kernels hang rarely when booted on qemu.  Usually you need to
> > boot 100s or 1,000s of times to see the hang, compared to 292,612 [sic]
> > successful boots which I was able to do before the problematic commit.
> > 
> > A reproducer (you'll probably need to use Fedora) is:
> 
> Debian only shop here... in fact, I still have machines without systemd.

Debian should work too actually, just run the following command until
it hangs:

> >   $ while guestfish -a /dev/null -v run >& /tmp/log; do echo -n . ; done
> > 
> > You will need to leave it running for probably several hours, and
> > examine the /tmp/log file at the end.
> > 
> > I tracked this down to the following commit:
> > 
> >   commit f31dcb152a3d0816e2f1deab4e64572336da197d
> >   Author: Aaron Thompson <dev@aaront.org>
> >   Date:   Thu Apr 13 17:50:12 2023 +0000
> > 
> >     sched/clock: Fix local_clock() before sched_clock_init()
> >     
> >     Have local_clock() return sched_clock() if sched_clock_init() has not
> >     yet run. sched_clock_cpu() has this check but it was not included in the
> >     new noinstr implementation of local_clock().
> > 
> >   (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f31dcb152a3d0816e2f1deab4e64572336da197d)
> > 
> > Reverting this commit fixes the problem.
> > 
> > I don't know _why_ this commit is wrong, but can we revert it as it
> > causes serious problems with libguestfs hanging randomly.
> > 
> > Or if there's anything you want me to try out then let me know,
> > because I can reproduce the problem locally quite easily.
> 
> Well, since it's virt and all, can you attach gdb to the gdb-stub and
> see where it's at? Any clue is better than no clue.

I'll see if this is possible, but I didn't have much luck with gdb on
qemu guests in the past.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org

