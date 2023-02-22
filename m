Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC4769FB73
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 19:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjBVSnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 13:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbjBVSmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 13:42:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC494392B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 10:42:15 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677091261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H0VTKN6T0UwFH1USSmI0T4Ad9FccppuXBMTlEk4+X8Q=;
        b=cf8swPm20xf+SvOPXi4pLHcXw0SxXyH1Qbmy8KUxpDsTiL1F3FY56UDIyvVT/En4+wvyWG
        4WlsQsEHH7RZRHEG8zORyZxwd4gbjK4wLT1T9ji9l/bPpFRmuWBgDqSsWCwc9fOscr06Ra
        t21NYSovr+bbxeg7iMJOCi+/OIDJThI2VzodFe2wv7jqunXWS0U/tMXfx6c5j5v++pbwFL
        6r/PXZcmenY7KF+AwvntyIs+LtzKFEiG0YZZM45dtyNmXJc6gXJa1Spzj4b0+NJmX22kLx
        dzLmXf7if4zCWD3Uy1NjQzJql84kpGpKF6DyJOWYp1H2Bwf6/PCOdf0kh1rOrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677091261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H0VTKN6T0UwFH1USSmI0T4Ad9FccppuXBMTlEk4+X8Q=;
        b=eoN3Fl55nHrwDvdAkcXcSq/8eWUhlt97ZXpy91tJOVbb6Ra/2mOchQgKEm8VVqufWgX/Zk
        sJeOu8WHVPRqKlDw==
To:     Rob Landley <rob@landley.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH 2/5] X86-64 should not uniquely require a third ELF
 package to build.
In-Reply-To: <aee2c147-2993-c35e-436e-0d89a0e5aa8b@landley.net>
References: <b455394f-9faa-1f1a-f171-0b9d5e9ada35@landley.net>
 <e184ece9-2779-675e-0c84-f0a62413c7fd@landley.net> <87wn4amx45.ffs@tglx>
 <aee2c147-2993-c35e-436e-0d89a0e5aa8b@landley.net>
Date:   Wed, 22 Feb 2023 19:41:00 +0100
Message-ID: <875ybtmtkz.ffs@tglx>
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

Rob!

On Wed, Feb 22 2023 at 12:14, Rob Landley wrote:
> On 2/21/23 17:12, Thomas Gleixner wrote:
>> The subject line is not compliant to documentation. Please read and
>> follow Documentation/process/* especially submitting-patches.rst and
>> maintainer-tip.rst
>
> I've read them multiple times over the years, but I'm not good at remembering
> extensive bureaucracy over long periods. Let's see...
>
> Are you complaining it doesn't have "RESEND"? These apply to 6.2, not 6.1, and a
> couple things got tweaked. What's the "RESEND" threshold?
>
> Or is this a "subsystem:" prefix thing where I have to guess what subsystem the
> top level makefile or mktimeconst fall under? Is "init" a subsystem?
>
> $ grep -i subsystem MAINTAINERS  | wc
>      85     286    2216
> $ grep -i subsystem MAINTAINERS  | grep -i init
> $

What has a patch against arch/x86 to do with init? I gave you two files
which extensively describe what we ask people to do.

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#patch-subject

Do you need some more explicit links?

These rules have been set in place to make the maintainer work
scalable. If you ignore them, then you are wasting other peoples
time. The logical consequence is that those people will ignore you too.

> Apparently not. I would have thought get_maintainer.pl would emit this sort of
> info if it's important, but I guess I'm remembering back when Linux had
> hobbyists who worked on things that didn't require justifying the time on a
> spreadsheet to their boss in a budget allocation meeting before modifying any
> code...

Your unrelated and non-sensical rants are not getting you anywhere.

>>> x86-64 is the only architecture that can't compile without an extra
>>> ELF library installed on the host. (The kernel already has multiple ELF
>>> parse implementations built-in, so requiring another one is questionable
>>> at best.)
>> 
>> How are ELF parsers in the kernel itself related to a build requirement
>> for a tool, which is part of the kernel build process?
>
> The project already has multiple instances of code that traverses ELF data
> structures. A definition of "code reuse" that pulls in an additional build
> dependency which the project was not already using is just "code use" without a
> "re".

Feel free to send patches against objtool to make use of those multiple
instances, which you gracefully omit to name.

> My response was "this doesn't need to be done at all, it's just being used for
> an optional stack unwinder, and even if you _want_ a stack unwinder there are
> multiple other implementations without this dependency".

Care to figure out what objtool really does and why it is required to
enable certain features? You might not care, but most people do for very
good reasons.

>> Just to be clear: objtool is mandatory for x86_64 builds.
>
> Because without this patch it's forced on, yes. Works fine without it
> in my testing?

Works for me does not cut it and you know that.

>> git grep 'select HAVE_OBJTOOL' will tell you that your claim about
>> x86_64 being the only architecture is slightly wrong.
>
> There's two hits, and the other is PPC32, which was building fine for me without
> this patch last I checked?

Select the right options on PPC32 or PPC64 and it requires objtool.

Just accept it. Your patch _is_ broken and it's not my problem to come
up with a solution which causes regressions for people who care and
depend on the features. It's just more work than removing a single line
in a Kconfig file and claiming that uncomprehensible word salad
qualifies as change log.

Please stop this right here and come back when you have something which
is worth to look at. I gave you enough pointers by now and I'm not going
to waste another second of my time on reading your rants.

Thanks,

        tglx


