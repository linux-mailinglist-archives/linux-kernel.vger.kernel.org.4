Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9653E72334A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 00:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjFEWls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 18:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjFEWlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 18:41:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68ADF3
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 15:41:45 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686004904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LSPALKOMgu0znVAkTZi0egalZkDuKKFX0FmKFEoVp3U=;
        b=IgFASXebsbHy0DHhjf+bWQPFvidaQRuzKyzdENs+T8rb5vFLB5bbQKAJ8XGvHnsOJz3PW6
        /zjHUbXHmOomgRUQROKDD0twpXXdUuxLCL2MwdJ+dbz0cyXZGVY7zDOsmJ4ucIiePMXjdj
        KHMkrE+zAJ2zjsGfQTmhLgCLBc2nMF4UVzIWLrGzNt8icMiA9jawB46xNPAzLWKzs4h4JI
        a/Jiq5FqteUgvX24RzrtuUyrfT58dNWkmw4B0VDAJU3GceQpJz//EbSS9vIIik4GMTPmS9
        SFSuXPYXjk25lwtvy8yAAqNdaVGgBi2NzfsuV3Om9gDdrWJRSDxzfknOJ/SYFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686004904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LSPALKOMgu0znVAkTZi0egalZkDuKKFX0FmKFEoVp3U=;
        b=U8Iu9pLnoMu12CiBh6aRsUyv7srg1+VWpBhDzRS/ttJ3r8KoRNg8JpGecuyHR5TvM87UBV
        /EJ/VWV+t8tPqsCw==
To:     Sean Christopherson <seanjc@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Ashok Raj <ashok.raj@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [patch 0/6] Cure kexec() vs. mwait_play_dead() troubles
In-Reply-To: <ZH4eNL4Bf7yPItee@google.com>
References: <20230603193439.502645149@linutronix.de>
 <ZH4eNL4Bf7yPItee@google.com>
Date:   Tue, 06 Jun 2023 00:41:43 +0200
Message-ID: <87pm694jmg.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05 2023 at 10:41, Sean Christopherson wrote:
> On Sat, Jun 03, 2023, Thomas Gleixner wrote:
>> This is only half safe because HLT can resume execution due to NMI, SMI and
>> MCE. Unfortunately there is no real safe mechanism to "park" a CPU reliably,
>
> On Intel.  On AMD, enabling EFER.SVME and doing CLGI will block everything except
> single-step #DB (lol) and RESET.  #MC handling is implementation-dependent and
> *might* cause shutdown, but at least there's a chance it will work.  And presumably
> modern CPUs do pend the #MC until GIF=1.

Abusing SVME for that is definitely in the realm of creative bonus
points, but not necessarily a general purpose solution.

>> So parking them via INIT is not completely solving the problem, but it
>> takes at least NMI and SMI out of the picture.
>
> Don't most SMM handlers rendezvous all CPUs?  I.e. won't blocking SMIs indefinitely
> potentially cause problems too?

Not that I'm aware of. If so then this would be a hideous firmware bug
as firmware must be aware of CPUs which hang around in INIT independent
of this.

> Why not carve out a page that's hidden across kexec() to hold whatever code+data
> is needed to safely execute a HLT loop indefinitely?

See below.

> E.g. doesn't the original kernel provide the e820 tables for the
> post-kexec() kernel?

Only for crash kernels if I'm not missing something.

Making this work for regular kexec() including this:

> To avoid OOM after many kexec(), reserving a page could be done iff
> the current kernel wasn't itself kexec()'d.

would be possible and I thought about it, but that needs a complete new
design of "offline", "shutdown offline" and a non-trivial amount of
backwards compatibility magic because you can't assume that the kexec()
kernel version is greater or equal to the current one. kexec() is
supposed to work both ways, downgrading and upgrading. IOW, that ship
sailed long ago.

Thanks,

        tglx



