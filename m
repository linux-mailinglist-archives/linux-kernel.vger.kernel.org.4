Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32A060109B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 15:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiJQN5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 09:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiJQN5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 09:57:24 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C87543C6;
        Mon, 17 Oct 2022 06:57:22 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1okQcI-0004Li-5Q; Mon, 17 Oct 2022 15:57:18 +0200
Message-ID: <f0412b37-fac0-c3f5-9877-0460a027e109@leemhuis.info>
Date:   Mon, 17 Oct 2022 15:57:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Content-Language: en-US, de-DE
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     "Artem S. Tashkinov" <aros@gmx.com>, workflows@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "ksummit@lists.linux.dev" <ksummit@lists.linux.dev>
References: <aa876027-1038-3e4a-b16a-c144f674c0b0@leemhuis.info>
 <20221004175354.bfvg3vhfqch35ib5@meerkat.local>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
In-Reply-To: <20221004175354.bfvg3vhfqch35ib5@meerkat.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1666015042;d5375fe7;
X-HE-SMSGID: 1okQcI-0004Li-5Q
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.10.22 19:53, Konstantin Ryabitsev wrote:
> On Thu, Sep 29, 2022 at 01:19:24PM +0200, Thorsten Leemhuis wrote:
>> TLDR: Core Linux kernel developers are unhappy with the state of
>> bugzilla.kernel.org; to improve things I plan to change a few important
>> aspects of its configuration, unless somebody comes up with better ideas
>> to tackle current problems: (1) Create a catch-all product making it
>> totally obvious to submitters that likely nobody will look into the
>> ticket. (2) Remove or hide all products & components where the subsystem
>> didn't fully commit to look into newly submitted reports. (3) Change the
>> text on the front page to make it clear that most kernel bug reports
>> need to be sent by mail.

So, merge window is over. To avoid any doubt, I'd now like to get a
clarification what the outcome of this discussion actually is.

FWIW, as most of you likely know, lwn.net has a write-up of this thread:
https://lwn.net/Articles/910740/

> Here's my counter-plan, which builds on top of yours.

Is this the agreed on path forward by silent agreement? And if so: who
will actually shepherd this? I just wonder, as it sounded to me that
Konstantin would be happy to take care of the bot-related stuff, but
leave the rest to somebody else.

Or do we have two proposals on the table that are kind of deadlocked so
that nothing will happen until the next maintainers summit, where things
like this are usually discussed and a way forward agreed on? Then the
ugly situation with bugzilla.kernel.org would continue for afaics at
least 11 more months, which I'd call "unfortunate". :-/

Ciao, Thorsten

> 1. Create a Kernel/Kernel product that acts as a starting point for all bug
>    submissions.
> 2. Create and maintain a mapping from MAINTAINER subsystem entries to
>    Product/Component categories in Bugzilla (the scheme to be established).
> 3. Establish and maintain a team of designated triage people who are willing
>    to look at incoming bugs to either:
> 
>    a. quick-close them as non-actionable (tainted kernel, distro kernel, spam)
>    b. obtain missing information from the submitter as necessary
>    c. figure out the correct component to assign, to the best of their ability
>    d. set a "triaged" flag
> 
> 4. a backend monitoring bot will track all bug changes and, when it sees a bug
>    get the "triaged" state, it will:
> 
>    a. create a useful bug summary from all bug comments
>    b. figure out who to notify based on the mapping (see #2 above)
>    c. send out the email to everyone identified
> 
> 5. the same backend monitoring bot will track responses and update the bug
>    comments as needed; any comments added via the bugzilla site will be
>    similarly sent out as follow-up messages.
> 
> 6. the bot can also monitor commits and other discussions via lore.kernel.org
>    and automatically add comments/links when it sees the bug mentioned
>    elsewhere.
> 
> I'm happy to take care of everything bot-related (apparently, programming bots
> is what I do now -- I just wish it was the cool and glamorous kind).
> 
> As I have stated multiple times, the hard part will be keeping a team of
> people who are willing to do the bug triage work, but maybe we can start with
> Greg KH using his intern funds to hire someone (assuming he's not already
> using these funds for someone to help him with all the other tasks).
> 
> Does that sound like a plan for everyone?
> 
> -K
