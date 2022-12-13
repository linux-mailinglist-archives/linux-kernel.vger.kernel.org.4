Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C48E64BCB9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 20:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236785AbiLMTHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 14:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236758AbiLMTHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 14:07:33 -0500
X-Greylist: delayed 97796 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 13 Dec 2022 11:07:32 PST
Received: from cheetah.elm.relay.mailchannels.net (cheetah.elm.relay.mailchannels.net [23.83.212.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B265FD6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 11:07:32 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id D11AA5C0E60
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 18:58:45 +0000 (UTC)
Received: from pdx1-sub0-mail-a304.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 5DA7F5C1737
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 18:58:45 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1670957925; a=rsa-sha256;
        cv=none;
        b=cqLHPD9FfJxDeZIrsPH72C9d0ZS2CzwUXZRbeLDqfbsIqmWxZnQiNvInOrK2mFGQtxufHM
        R9jMJWt4URp4SIwzGuJBB7Ci1DagmDE50oOwVrHzk/k+PoQcs3G3/z5Wy980KW5XVifBur
        o9EwYvhC/psNr4G4NvQ8Y4YZr1qh32jEElnsn1tNZhstZmAudWYPioKXuUdzREewehrqx9
        MBy9JIUoA2S7Oxv7/quuPj855+1gJD1qUi5QV9fhwP6hqXXOikoPuW10P3cC4s/8Zr/+aB
        8Ym1Xm+y1ZNx6pX3n+JgeZ3uxTJcsHiUNTVvrLTn17u9u62XJIEtaQqckmrBsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1670957925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=E0qUk9TTQJ05tyym3+Ykvnx/NywduTmX7ZoBw4ir51k=;
        b=NXSLQcRbT2saxtsgmEjKwf1sWyth/k73W2naGvnIqY+VdOZCauVYSIk9fsDLEISu7B4IDD
        Bmn+NlUxU3tKxi3Zc4Zp2h+XkogU3S08Irl8iIX/Q2EMeccsabaVKeLRWhli5tNNu/iQow
        LOeNWZgCMk0dwz1gCmzpwSbuRBlsknUviddq1Ipw0Vs6sO+1+Ti/VG7ShIHoRL83a3YEB3
        HxNVU4HWt64YupEtazTQVbTlnGp+a500CZ8XtXaOssb6D0KbH2QuNgrCqBAME197j0LglT
        uPBWtz9jOZ6mdJO+jkyIyGCOExvVBPHV/IBjXk76Il1AJbyCNPZcVQz0cRNeXg==
ARC-Authentication-Results: i=1;
        rspamd-d48c5ddb-vld7f;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Good
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Versed-Tank: 5d1e112157ecdc64_1670957925654_3624609171
X-MC-Loop-Signature: 1670957925654:3485384674
X-MC-Ingress-Time: 1670957925654
Received: from pdx1-sub0-mail-a304.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.103.24.30 (trex/6.7.1);
        Tue, 13 Dec 2022 18:58:45 +0000
Received: from kmjvbox (c-73-70-108-208.hsd1.ca.comcast.net [73.70.108.208])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a304.dreamhost.com (Postfix) with ESMTPSA id 4NWnpD1F8TzMF
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 10:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1670957924;
        bh=E0qUk9TTQJ05tyym3+Ykvnx/NywduTmX7ZoBw4ir51k=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=HDlQsT9u0YLBXZPEfKIFYcff6girmqTtncfGBUnOmGwWXI8rggk9jNK67G3PGTWu9
         ZA5nMtDJs5WyZ9/CSfZTiuoR1IPMmnkmhbYXgmL8zt9VQ3CFzueXSSGvUkUMrAQvXm
         LYX/C+ss6rRjla0ibnVwKS78ieA28c89hHxwgV+w=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e0106
        by kmjvbox (DragonFly Mail Agent v0.12);
        Tue, 13 Dec 2022 10:58:42 -0800
Date:   Tue, 13 Dec 2022 10:58:42 -0800
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Jan Beulich <jbeulich@suse.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Anthony Liguori <aliguori@amazon.com>,
        David Reaver <me@davidreaver.com>,
        Brendan Gregg <brendan@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH linux-next v2] x86/xen/time: prefer tsc as clocksource
 when it is invariant
Message-ID: <20221213185842.GA1987@templeofstupid.com>
References: <20221208163650.GA3225@templeofstupid.com>
 <1e6c1b08-d573-fba9-61fd-d40a74427d46@oracle.com>
 <20221212155730.GA1973@templeofstupid.com>
 <20221212160524.GB1973@templeofstupid.com>
 <1eb6048b-bf23-78a0-9c3c-54bbd12c3864@suse.com>
 <20221212220519.GA1935@templeofstupid.com>
 <60582b25-4fb9-a2c8-9db3-9b5593f039c1@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60582b25-4fb9-a2c8-9db3-9b5593f039c1@suse.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 08:23:29AM +0100, Jan Beulich wrote:
> On 12.12.2022 23:05, Krister Johansen wrote:
> > On Mon, Dec 12, 2022 at 05:46:29PM +0100, Jan Beulich wrote:
> >> On 12.12.2022 17:05, Krister Johansen wrote:
> >>> Both the Intel SDM[4] and the Xen tsc documentation explain that marking
> >>> a tsc as invariant means that it should be considered stable by the OS
> >>> and is elibile to be used as a wall clock source.  The Xen documentation
> >>> further clarifies that this is only reliable on HVM and PVH because PV
> >>> cannot intercept a cpuid instruction.
> >>
> >> Without meaning to express a view on the argumentation as a whole, this
> >> PV aspect is suspicious. Unless you open-code a use of the CPUID insn
> >> in the kernel, all uses of CPUID are going to be processed by Xen by
> >> virtue of the respective pvops hook. Documentation says what it says
> >> for environments where this might not be the case.
> > 
> > Thanks, appreciate the clarification here. Just restating this for my
> > own understanding: your advice would be to drop this check below?
> 
> No, I'm unconvinced of if/where this transformation is really appropriate.

Ah, I see.  You're saying that you're not convinced that this code
should ever lower the priority of xen clocksource in favor of the tsc?
If so, are you willing to say a bit more about what you find to be
unconvincing?

In as much detail as I can muster: the impetus for the patch was that I
had a variety of different systems running as both kvm and xen guests.
Some of these guests had clocksource tunings in place as a result of
consulting the documentation linked in the patch.  But others didn't.
On kvm they had somehow done the "right" (?) thing.  Some systems had
tuning in place for xen, despite no longer being a xen guests.  Other
systems were running on xen and didn't have the recommended tuning
applied.  That's all sorted now, but it seemed like it might be nice to
eliminate the need for others to do this in future. With kvm doing
something similar, I thought there might be enough precedent to consider
this for xen guests.

> My comment was merely to indicate that the justification for ...
> 
> >>> +	if (!(xen_hvm_domain() || xen_pvh_domain()))
> >>> +		return 0;
> 
> ... this isn't really correct.

The rationale for this bit of code was the justification that turns
out to be incorrect.  That sounds to me like I have unnessary code,
unless I was right by mistake?

> > And then update the commit message to dispense with the distinction
> > between HVM, PV, and PVH?
> > 
> >>> +	cpuid(xen_cpuid_base() + 3, &eax, &ebx, &ecx, &edx);
> >>
> >> Xen leaf 3 has sub-leaves, so I think you need to set ecx to zero before
> >> this call.
> > 
> > The cpuid() inline in arch/x86/include/asm/processor.h assigns zero to
> > ecx prior to calling __cpuid.  In arch/x86/boot/cpuflags.c the macros
> > are a little different, but it looks like there too, the macro passes 0
> > as an input argument to cpuid_count which ends up being %ecx.  Happy to
> > fix this up if I'm looking at the wrong cpuid functions, though.
> 
> Oh, I didn't expect cpuid() to be more than a trivial wrapper around the
> the pvops hook, and I merely looked at native_cpuid() and xen_cpuid().
> I'm sorry for the noise then. Yet still, with there being sub-leaves, I'd
> recommend switching to cpuid_count() just for clarity.

No apology necessary.  I'm happy to modify this to use cpuid_count() for
clarity.

-K
