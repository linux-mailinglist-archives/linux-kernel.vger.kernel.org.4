Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9C46AB6CF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 08:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjCFHMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 02:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjCFHMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 02:12:22 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 334BBAD1B;
        Sun,  5 Mar 2023 23:12:21 -0800 (PST)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 3267Bc41005636;
        Mon, 6 Mar 2023 08:11:38 +0100
Date:   Mon, 6 Mar 2023 08:11:38 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Jiri Kosina <jkosina@suse.cz>,
        Solar Designer <solar@openwall.com>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Amit Shah <aams@amazon.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Tyler Hicks <tyhicks@linux.microsoft.com>
Subject: Re: [PATCH v3 0/7] Documentation/security-bugs: overhaul
Message-ID: <ZAWSKrbaQ6nm3qNe@1wt.eu>
References: <20230305220010.20895-1-vegard.nossum@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230305220010.20895-1-vegard.nossum@oracle.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vegard,

first, thanks for doing this work.

On Sun, Mar 05, 2023 at 11:00:03PM +0100, Vegard Nossum wrote:
> Probably the easiest way to see the end result of this series is to view the
> rendered HTML which I've put here:
> https://vegard.github.io/security-v3/Documentation/output/process/security-bugs.html

I'm seeing a few points that could be improved but I don't have much to
propose right now, I'll just enumerate issues we've faced in the past or
that continue to pop up from time to time and that require extra effort
from the team:

  - I'm not seeing anywhere that the security list is *exclusively*
    for kernel issues. That might explain why about once a week or so
    we receive messages like "there's a bug in that userland tool" or
    "we've found an XSS issue on your website". It's written that kernel
    bugs should be reported to the security list but I think we should
    strengthen that by adding "This list is exclusively used for Linux
    kernel security reports, please do not report issues affecting any
    other component there".

  - we always need to be able to describe the nature of a bug in the
    commit message so that if the patch is found to cause a regression,
    its purpose can at least be understood and argumented. It happened
    at least once that we were requested not to explain the details
    because a paper was about to be issued, and that's not acceptable
    at all because it means that it becomes very complicated to have
    public discussions about possible forthcoming issues. I think that
    after the paragraph suggesting that the details of an issue or its
    exploit code might not always be published, it could be useful to
    mention something along the fact that the reporter shall not
    request the security team to withhold technical details about the
    issue as long as it doesn't represent an imminent danger.

  - it's quite frequent that reporters post from dummy addresses,
    looking like randomly generated ones (we even had one looking
    like a smiley). It doesn't help to communicate with them at all.
    I can understand how some working as consultants for a customer
    would want to avoid disclosing a particular relation between their
    finding and their customer, but at least they should indicate how
    they should be called. I.e. "call me Margarett" is not difficult
    and simplifies exchanges when the address is "69236836@example.com".
    And often we see at the end that they're willing to provide a real
    name to be credited for the finding, so most likely starting with
    this real name could be easier.

  - it's more a discussion for the list itself, but the wording continues
    to make one think that the reporter should expect the list members to
    develop a patch, while in practise the first thing that's asked is
    "since you've studied the problem well, do you happen to have a patch?".
    And it happened a few times that in response we got "oops sorry, I
    analysed it wrong, there's no issue there". I think the text should
    emphasize more on encouraging submitters to complete their work with
    a patch proposal (that's also helpful to confirm an analysis). And
    conversely I think that reports for non-immediately exploitable issues
    that are found by code analyzers (and almost always come without a
    patch) should not be sent to this list and should be discussed and
    addressed publicly instead. It's more efficient and allows more
    knowledgeable participants to have their say on the root cause of
    the problem and its possible solutions. That's of course not always
    the case, but common sense should prevail here.

Thanks,
Willy
