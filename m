Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9467238CD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 09:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235316AbjFFHUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 03:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbjFFHUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 03:20:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E0010C6
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 00:20:13 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686036011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hcH0p6GtYxhwJ3jFV3SLOHqV0XZLVIEjOJwUqsEDyuo=;
        b=WogWd3ixstQWWMVXyfjiFQy80J/8rApsTkUnvqchmPVLswIf1pL9kxz3EhNDxbEKIvxwc0
        TfHSi1sR18ibzib6dCHD7MiIvh1Kv7izhn29KHEzHjTds8t2sB+lqWUFg83NjAa+yyXgTw
        /YAaN8UyI5hGLLmIx9hQXad1G9Tu3c8IiPqHq+MF8sADaaANJWcrNuhSrl8YKdkX+1iUt/
        vFaiZ82V6WoIh/7o28ZeGaBT9VqJTlN016R5pxWCIbbetEJfYQDSO7zdGd+1WuWDTIsfqv
        PFQLzLFSFD7zQ6IobmsoY9nFH40ZBRlewLK6Dg7sagltE2+B5AayYL1BIRYDvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686036011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hcH0p6GtYxhwJ3jFV3SLOHqV0XZLVIEjOJwUqsEDyuo=;
        b=57QaDNv8lBgc1OIJq+Qa/D/s0UkQTD6eUA7yNRYQ9pmADozTL11ZbKVALNemtueU5t983k
        hA+aJ1f3t9un8sCw==
To:     Sean Christopherson <seanjc@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Ashok Raj <ashok.raj@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [patch 0/6] Cure kexec() vs. mwait_play_dead() troubles
In-Reply-To: <ZH5rCySnEr0KmATT@google.com>
References: <20230603193439.502645149@linutronix.de>
 <ZH4eNL4Bf7yPItee@google.com> <87pm694jmg.ffs@tglx>
 <ZH5rCySnEr0KmATT@google.com>
Date:   Tue, 06 Jun 2023 09:20:10 +0200
Message-ID: <87mt1d3vmd.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05 2023 at 16:08, Sean Christopherson wrote:
> On Tue, Jun 06, 2023, Thomas Gleixner wrote:
>> On Mon, Jun 05 2023 at 10:41, Sean Christopherson wrote:
>> > On Sat, Jun 03, 2023, Thomas Gleixner wrote:
>> >> This is only half safe because HLT can resume execution due to NMI, SMI and
>> >> MCE. Unfortunately there is no real safe mechanism to "park" a CPU reliably,
>> >
>> > On Intel.  On AMD, enabling EFER.SVME and doing CLGI will block everything except
>> > single-step #DB (lol) and RESET.  #MC handling is implementation-dependent and
>> > *might* cause shutdown, but at least there's a chance it will work.  And presumably
>> > modern CPUs do pend the #MC until GIF=1.
>> 
>> Abusing SVME for that is definitely in the realm of creative bonus
>> points, but not necessarily a general purpose solution.
>
> Heh, my follow-up ideas for Intel are to abuse XuCode or SEAM ;-)

I feared that :)

>> >> So parking them via INIT is not completely solving the problem, but it
>> >> takes at least NMI and SMI out of the picture.
>> >
>> > Don't most SMM handlers rendezvous all CPUs?  I.e. won't blocking SMIs indefinitely
>> > potentially cause problems too?
>> 
>> Not that I'm aware of. If so then this would be a hideous firmware bug
>> as firmware must be aware of CPUs which hang around in INIT independent
>> of this.
>
> I was thinking of the EDKII code in UefiCpuPkg/PiSmmCpuDxeSmm/MpService.c, e.g.
> SmmWaitForApArrival().  I've never dug deeply into how EDKII uses SMM, what its
> timeouts are, etc., I just remember coming across that code when poking around
> EDKII for other stuff.

There is a comment:

  Note the SMI Handlers must ALWAYS take into account the cases that not
  all APs are available in an SMI run.

Also not all SMIs required global synchronization. But it's all an
inpenetrable mess...

>> Making this work for regular kexec() including this:
>> 
>> > To avoid OOM after many kexec(), reserving a page could be done iff
>> > the current kernel wasn't itself kexec()'d.
>> 
>> would be possible and I thought about it, but that needs a complete new
>> design of "offline", "shutdown offline" and a non-trivial amount of
>> backwards compatibility magic because you can't assume that the kexec()
>> kernel version is greater or equal to the current one. kexec() is
>> supposed to work both ways, downgrading and upgrading. IOW, that ship
>> sailed long ago.
>
> Right, but doesn't gaining "full" protection require ruling out unenlightened
> downgrades?  E.g. if someone downgrades to an old kernel, doesn't hide the "offline"
> CPUs from the kexec() kernel, and boots the old kernel with -nosmt or whatever,
> then that old kernel will do the naive MWAIT or unprotected HLT and
> it's hosed again.

Of course.

> If we're relying on the admin to hide the offline CPUs, could we usurp
> an existing kernel param to hide a small chunk of memory instead?

The only "safe" place is below 1M I think. Not sure whether we have
some existing command line option to "hide" a range there. Neither am I
sure that this would be always the same range.

More questions than answers :)

Thanks

        tglx




