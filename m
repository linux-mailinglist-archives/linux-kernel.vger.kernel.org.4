Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C104666965C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240927AbjAMMG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:06:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240987AbjAMMFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:05:40 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D3584F94
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 03:55:46 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 53BCB41A42;
        Fri, 13 Jan 2023 11:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1673610944; bh=Ms0sfliAebd5roODUWfN4RK47fgidMYE4meZVKrsFxc=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To;
        b=iZ0yVGyLkBBrPUgixTqa7LMmljgi0FAls2JzpQnCwfgaD+gVhrTiCTytKGU1AovAK
         PTwxfBwX6W5YV/840sHSRPUTW5hpHKbBOBr6DpIrUOi6j2OaknEstkDD/dzKQQKkUJ
         QQV9jktSEWeIj4cmi0C5UYszcESHIaC4hORmJRYYG0mvNrqeH3Anpwpi4sAXWY9YUC
         /MtMPVVo9KWmMV9Xb2oLYjo9NQ3FaqpToAa48ehWkgqjqdiCE9RQDB8Mr3PF4lzK+y
         3fiAjsYvaw3foGjR4rxoAPaCBaRaXZxHgj6LLV7EjheYBTObybxJrS0w0x8BN5Hjys
         3OYrapggP5Viw==
Message-ID: <0919dba2-c493-710c-4d4c-cdcb36e1fa12@marcan.st>
Date:   Fri, 13 Jan 2023 20:55:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>
References: <Y7RezbPSGrO37NZZ@shell.armlinux.org.uk>
 <5333ed0e-010c-178a-beb2-e8a4338f2d43@marcan.st>
 <Y7SWgC7m4tYSU1UJ@shell.armlinux.org.uk>
 <Y72RXJqcGQ3G0gXu@shell.armlinux.org.uk>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v3 0/5] Fix a whole host of nvmem registration/cleanup
 issues
In-Reply-To: <Y72RXJqcGQ3G0gXu@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/2023 01.25, Russell King (Oracle) wrote:
> On Tue, Jan 03, 2023 at 08:56:32PM +0000, Russell King (Oracle) wrote:
>> Really not interested in your politics. Not interested in fixing this
>> problem.
>>
>> I'll use these patches to fix the problem in my tree. I don't care about
>> mainline.
> 
> Having thought this over, this was an unfair over-reaction for which
> I'd like to apologise. It was proving to be a very stressful couple
> of days.

Thank you.

> 
>>> Uhh. The series itself looks fine as far as fixing the problems, but I
>>> fail to see how this is any better than my attempt as far as backporting
>>> or commit atomicity goes. Patch #4 fixes the newer gpio leak bug *and*
>>> half fixes the race condition bug,
> 
> There are two choices for patch for:
> 
> 1. add gpiod_put().
> 2. make use of the gpiod_put() already present in the release function.
> 
> Either way, patch 5 depends on patch 4, and there's no way around that.

How so? My idea was to just add gpiod_put() as one commit, do the race
condition fix as another, and optionally clean up as a third commit
after that to unify the error paths. I just tried it and it effectively
avoids the inter-patch dependency.

Done like this, both patches apply cleanly to the 6.1 stable tree, while
the race fix applies cleanly to at least the 6.0 and 5.15 stable trees
(haven't tried going further back). No manual backports needed. It just
works with a Cc: stable@.

> However, where our patches differ is that my series fixes one problem
> in one patch, rather than trying to address multiple problems in one
> patch. As has been pointed out, this is a documented requirement in
> the submitting-patches.rst document, which has been there for a very
> long time. You had been pointed to this document already over this
> point.

I'd like to direct your attention to submitting-patches.rst:

> For example, if your changes include both bug fixes and performance
> enhancements for a single driver, separate those changes into two
> or more patches.

Note how it says *bug fixes* (plural), and asks you to separate the
changes into *two or more* patches (where one is the performance
enhancements, and the other the multiple bug fixes, in the two case).

The author of the document clearly understood that sometimes it makes
perfect sense to group related changes together, when they are of the
same type and touching closely related bits of code, and focused on the
more egregious case of making wildly unrelated changes (performance and
bugfixes, presumably in unrelated parts of the code) in one commit.
*That* is what we are trying to avoid, because when done
indiscriminately, it makes bisecting and backporting and review much harder.

Yet, there is this persistent myth among some kernel maintainers that It
Is The Rule Of The Kernel that You Do One, and Exactly One, Bug Fix Per
Commit. And this kind of applying (not even actual, in this case) rules
with an iron fist without any regard to nuance is one of the things that
contributes to the unwelcoming nature of this community.

The reality is that us engineers often notice little things to fix while
working on code doing something else, and in those cases, it often makes
little to no sense to split off the fix into another commit, especially
if it's minor enough that it doesn't need backporting or the fix ends up
getting subsumed into other changes being made.

There is room for discretion in deciding how to split up commits, and
it's not something you can make an objective, strict rule for that
actually makes sense. When it comes to programming in a large
collaborative project like this, strict rules can only be made and
enforced for things that can be fully checked and made consistent by a
machine... and the Linux kernel development process is too antiquated to
have many of those (e.g. many projects are doing fully automated code
formatting these days, while here all we have is checkpatch.pl and it's
often wrong and unsuitable as an automated gating check). Everything
else is at best a strong suggestion, but always subject to human
interpretation and nuance, because we aren't robots.

I do these kinds of drive-by fixes all the time, because sometimes it
just *makes sense*. See for example 38892ea4cef, which fixed a typo
while renaming a DT property. Or d182dc6de932, which refactored some
OF-related code and in the process also fixed a reference leak in the
original code. Those are things not worth backporting, and in those
cases there is absolutely no good reason to split out the "fix" part
from the "do" part into a tiny one-liner commit.

Ultimately, drive-by fixes like this are a gift from the contributor to
the maintainer, as they are almost always not something that is actually
causing pain for anyone (at least not significant pain), and therefore
there is very little reason to spend time on them. Thus, if maintainers
attempt to enforce a strict one-patch-per-bugfix policy, it will simply
result in (and I'm sure it already is) contributors just not doing those
fixes at all, or choosing not to describe them in the commit message
when they are "accidentally" fixed as part of a larger change. I know I
would. When the patch submission process is painful, you naturally
gravitate towards doing the least offensive thing that gets you where
you want to be, even if that isn't necessarily the best place for the
kernel to be in the end.

That all said, you *did* have a very valid point with the merged commit
being harder to backport in this case (where a backport is desirable),
and checking the blame to see if it would apply cleanly further back was
a good call - but then please appeal to that, and not to
submitting-patches.rst. And then if we'd agreed on that being the
desirable goal, I could've helped you structure the patches in a way
that cleanly backports to stable, as I already locally confirmed is
possible to do.

> Therefore, I believe my series to be a technically better approach
> which addresses several more issues while conforming to the "Solve
> only one problem per patch." requirement which can be trivially
> backported - and I truely believe that even patch 4 complies with
> the requirement in submitting-patches.rst. I certainly do not
> believe patch 4 is a kind of "partial" fix for the race condition,
> since it in no way changes the presence of the race.

It certainly fixed more things, but as I said, if this were about
backporting, we could've done better ;)

Patch 4 may not change the presence of the race, but both you and I know
it is preparatory work for that (as if the goal were just to fix the
gpiod leak, that would've just been adding the one-line gpiod_put()), so
it is somewhat disingenuous to claim that it is a stand-alone fix. I
posit that if nothing else it is harder to review as a fix for what it
purports to fix, and not the best approach for a backport (which as I
said doesn't work out of the box, but even if it did). Sure, it's
splitting off the fixes in the sense that only one thing is actually
fixed after each commit is applied, but it's not splitting them off at
the sensible point for that.

> I hope that we can continue to work to get the Apple M1 supported more
> fully in the future.

Thank you. (I still need to re-send those SMC patches... maybe next week
I'll finally find some time)

- Hector
