Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F166974DC1F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 19:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjGJRSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 13:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbjGJRSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 13:18:47 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE6C1A7;
        Mon, 10 Jul 2023 10:18:45 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qIuX5-0007fb-Nh; Mon, 10 Jul 2023 19:18:43 +0200
Message-ID: <29fb398b-a81c-70f9-f67c-21daaa42e4f7@leemhuis.info>
Date:   Mon, 10 Jul 2023 19:18:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <cover.1689008220.git.linux@leemhuis.info>
Subject: Re: [RFC PATCH v1 0/3] docs: stable-kernel-rules: add delayed
 backporting option and a few tweaks
In-Reply-To: <cover.1689008220.git.linux@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1689009525;da50ff4b;
X-HE-SMSGID: 1qIuX5-0007fb-Nh
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.07.23 19:10, Thorsten Leemhuis wrote:
> This is a RFC and a bit rough for now. I only set down to create the
> first of the three patches. But while doing so I noticed a few things
> that seemed odd for me with my background on writing and editing texts.
> So I just quickly performed a few additional changes to fix those to see
> if the stable team would appreciate them, as this document is clearly
> their domain.
> 
> If those changes or even the initial patch are not welcomed, I'll simply
> drop them. I'd totally understand this, as texts like these are delicate
> and it's easy to accidentlly change the intent or the meaning while
> adjusting things in good faith.
> 
> At the same time I might be willing to do a few more changes, if people
> like the direction this takes and want a bit more fine tuning.

FWIW, in case anyone wonders what other changes I'd do, let me quote the
text as it looks after these changes and give a few examples inline:

> ```
> .. _stable_kernel_rules:
> 
> Everything you ever wanted to know about Linux -stable releases
> ===============================================================
> 
> Rules on what kind of patches are accepted, and which ones are not, into the
> "-stable" tree:
> 
>  - It or an equivalent fix must already exist in Linus' tree (upstream).

s/Linus' tree/mainline/g (just a detail, but I think that is the term
more commonly used and known)

>  - It must be obviously correct and tested.
>  - It cannot be bigger than 100 lines, with context.
>  - It must follow the
>    :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
>    rules.
>  - It must either fix a real bug that bothers people or just add a device ID.
>    To elaborate on the former:
> 
>    - It fixes a problem like an oops, a hang, data corruption, a real security
>      issue, a hardware quirk, a build error (but not for things marked
>      CONFIG_BROKEN), or some "oh, that's not good" issue. In short, something
>      critical.

s/ In short, something critical.//

Contradicts the "real bug that bothers people" somewhat and IMHO does
not add anything. But maybe that's just me.

>    - Serious issues as reported by a user of a distribution kernel may also
>      be considered if they fix a notable performance or interactivity issue.
>      As these fixes are not as obvious and have a higher risk of a subtle
>      regression they should only be submitted by a distribution kernel
>      maintainer and include an addendum linking to a bugzilla entry if it
>      exists and additional information on the user-visible impact.

/me wonders if that is really providing additional insight and if this s
setting the bar a bit higher than it's really in practice

>    - No "This could be a problem..." type of things like a "theoretical race
>      condition", unless an explanation of how the bug can be exploited is also
>      provided.
>    - No "trivial" fixes without benefit for users (spelling changes, whitespace
>      cleanups, etc).
> 
> Procedure for submitting patches to the -stable tree
> ----------------------------------------------------
> 
> .. note::
> 
>    Security patches should not be handled (solely) by the -stable review
>    process but should follow the procedures in
>    :ref:`Documentation/process/security-bugs.rst <securitybugs>`.
> 
> There are three options to submit a change to -stable trees:
> 
>  1. Add a 'stable tag' to the description of a patch you want to mainline.
>  2. Ask the stable team to pick up a patch already mainlined.
>  3. Submit a patch to the stable team that is equivalent to a mainlined patch.
> 
> The sections below describe each of the options in more detail.
> 
> :ref:`option_1` is **strongly** preferred, it is the easiest and most common.
> :ref:`option_2` and :ref:`option_3` are more useful if the patch isn't deemed
> worthy at the time it is submitted for mainline inclusion (for instance, because
> it deserves more regression testing first). :ref:`option_3` is especially
> useful if the original upstream patch needs to be adjusted to be included in
> older series (for example the backport needs some special handling due to e.g.
> API changes).


Tweaked para:

:ref:`option_1` is **strongly** preferred, it is the easiest and most
common. :ref:`option_2` is meant for changes that were not deemed wort
including in stable at the time it was submitted for mainline inclusion
(for instance, because the full scale of the problem was not yet known).
:ref:`option_3` is an alternative to the two earlier options for cases
where a mainlined patch needs adjustments to apply in older series (for
example due to API changes).

>  .. _option_1:
> 
> Option 1
> ********
> 
> To have a patch you submit for mainline inclusion automatically picked up for
> the stable tree later, add the tag
> 
> .. code-block:: none
> 
>      Cc: stable@vger.kernel.org
> 
> in the sign-off area. Once the patch is mainlined it will be applied to the
> stable tree without anything else needing to be done by the author or
> subsystem maintainer.
> 
> You can add a note with additional instructions using a shell-style inline
> comment:
> 
>  * To specify any additional patch prerequisites for cherry picking use the
>    following format in the sign-off area:
> 
>    .. code-block:: none
> 
>      Cc: <stable@vger.kernel.org> # 3.3.x: a1f84a3: sched: Check for idle
>      Cc: <stable@vger.kernel.org> # 3.3.x: 1b9508f: sched: Rate-limit newidle
>      Cc: <stable@vger.kernel.org> # 3.3.x: fd21073: sched: Fix affinity logic
>      Cc: <stable@vger.kernel.org> # 3.3.x
>      Signed-off-by: Ingo Molnar <mingo@elte.hu>
> 
>    The tag sequence has the meaning of:
> 
>    .. code-block:: none
> 
>      git cherry-pick a1f84a3
>      git cherry-pick 1b9508f
>      git cherry-pick fd21073
>      git cherry-pick <this commit>
> 
>  * For patches that may have kernel version prerequisites specify them using
>    the following format in the sign-off area:
> 
>    .. code-block:: none
> 
>      Cc: <stable@vger.kernel.org> # 3.3.x
> 
>    The tag has the meaning of:
> 
>    .. code-block:: none
> 
>      git cherry-pick <this commit>
> 
>    For each "-stable" tree starting with the specified version.

/me wonders if something like a "note, such tagging is unnecessary if
the appropriate version can be derived from a Fixes: tag" would be
appropriate and worth it here

>  * To delay pick up of patches, use the following format:
> 
>    .. code-block:: none
> 
>      Cc: <stable@vger.kernel.org> # after 4 weeks in mainline
> 
>  * For any other requests, just add a note to the stable tag. This for example
>    can be used to point out known problems:
> 
>   .. code-block:: none
> 
>      Cc: <stable@vger.kernel.org> # see patch description, needs adjustments for >= 6.3
> 
> .. _option_2:
> 
> Option 2
> ********
> 
> If the patch already has been merged to Linus' tree, send an email to
> stable@vger.kernel.org containing the subject of the patch, the commit ID,
> why you think it should be applied, and what kernel version you wish it to
> be applied to.
> 
> .. _option_3:
> 
> Option 3
> ********
> 
> Send the patch, after verifying that it follows the above rules, to
> stable@vger.kernel.org and mention the kernel version you wish it to be applied
> to.
> 
> When doing so, you must note the upstream commit ID in the changelog of your
> submission with a separate line above the commit text, like this:
> 
> .. code-block:: none
> 
>     commit <sha1> upstream.
> 
> or alternatively:
> 
> .. code-block:: none
> 
>     [ Upstream commit <sha1> ]
> 
> If the patch submitted using this option deviates from the original upstream
> patch (for example because it had to be adjusted for the older API), this must
> be very clearly documented and justified in the patch description.
> 
> Following the submission
> ------------------------
> 
> The sender will receive an ACK when the patch has been accepted into the queue,
> or a NAK if the patch is rejected.  This response might take a few days,
> according to the developer's schedules.

s/developer's schedules/schedules of the stable team members/

> If accepted, the patch will be added to the -stable queue, for review by other
> developers and by the relevant subsystem maintainer.
> [...]
> ```

That's it. Ciao, Thorsten
