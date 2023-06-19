Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286CD735690
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 14:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjFSMT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 08:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjFSMT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 08:19:56 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6488F11D
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 05:19:52 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qBDrK-0006sT-29; Mon, 19 Jun 2023 14:19:50 +0200
Message-ID: <97b81eab-8e09-2163-1b91-daecb8127a7c@leemhuis.info>
Date:   Mon, 19 Jun 2023 14:19:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US, de-DE
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>
References: <9e0f5378-63d8-add4-2b79-2173a4c98086@leemhuis.info>
 <24edd13e-791a-bd05-0a44-dd5475c7e200@leemhuis.info>
 <2023061955-abdominal-refute-4b5a@gregkh>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: JFYI: patches in next that might be good to mainline rather
 sooner than later?
In-Reply-To: <2023061955-abdominal-refute-4b5a@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1687177192;b6b8f2af;
X-HE-SMSGID: 1qBDrK-0006sT-29
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.06.23 10:49, Greg KH wrote:
> On Sun, Jun 18, 2023 at 03:40:15PM +0200, Thorsten Leemhuis wrote:
>> On 18.06.23 10:49, Thorsten Leemhuis wrote:
>>>
>>> I got the impression that early stable releases with a huge number of
>>> patches (like 6.3.2 with ~690 changes) seems to cause a few regressions.
>>> As you know, those releases usually contain many backports of changes
>>> merged during the merge window for the following mainline release (e.g.
>>> 6.4). That made me wonder:
>>>
>>> How many patches do we have in linux-next right now that better should
>>> be merged this cycle (e.g. ahead of the 6.4 release) instead of merging
>>> them in the merge window for 6.5 and backporting them shortly afterwards?
>>>
>>> To check I briefly set down and quickly hacked together a python
>>> script[1] that looks at linux-next for patches with tags like 'Cc:
>>> stable...' and 'Fixes: ', as all respectively some (or many?) of those
>>> will be backported. I made the script ignore a few things, like commits
>>> from the past eight days and commits that fix changes committed to
>>> mainline more that a year ago.
>>>
>>> I ran this a few minutes ago and it spilled out about 260 changes (about
>>> 80 of them with a stable tag). I put the results into a table:
>>> https://docs.google.com/spreadsheets/d/1OnMrde1e7LBMPhOPJL0Sn9rd3W32mTGls_qGMoZS8z8/edit?usp=sharing
>>
>> TWIMC, I just updated the data slightly, as I updated the script to also
>> look for commits that revert changes from the current mainline cycle.
>>
>> Did that while I was preparing this weeks regression report and noticed
>> a series of reverts[1] in next where my brain said "hmmm, Andrew merged
>> those more than a week ago to mm-hotfixes-unstable and -rc7 is due
>> today; I don't see a pr from him and wonder if these revert are
>> something that better should be in rc7 to help preventing a rc8?"
>>
>> [1] https://lore.kernel.org/all/20230609081518.3039120-1-qi.zheng@linux.dev/
>> noticed it via
>> https://lore.kernel.org/lkml/ZH6K0McWBeCjaf16@dread.disaster.area/
> 
> Having "only" 82 commits that cc: stable is a _HUGE_ decrease, so that's
> great to see.  That's a very low % overall from the number of
> non-cc-stable commits in the tree, so this feels good to me.

Yeah, from my point of view it also looks like things improved.

> Most of those are tiny stuff, dts fixes, fixes for minor
> platforms/drivers, lockdep fixes, and other tiny things that maintainers
> probably just don't think worthy of getting into -final now, as long as
> they make it into the tree "eventually".  I know it's that way for some
> of the commits in my trees that are tagged that way.

Yup. But some seem to fix regressions. a0f19091d4f5, 6a87679626b5 and
88d341716b83 for example looked suspicious to my untrained eyes during a
brief look at the first 20 changes CCed stable. But developers and
maintainers of course are in a way better position to decide how to
handle those patches.

BTW, some of those 20 changes and a off-list conversation about this
thread reminded me of something related:

Last year on the maintainers summit we discussed this "delayed stable
backport" thingy that afaik works something like this:

Cc: <stable@vger.kernel.org> # after 4 weeks

Or is it more like this?

Cc: <stable@vger.kernel.org> # 6.2 [after 4 weeks]

I think the conclusion was to add this to the documentation, but that
afaics never happened. If you tell me the format you or your scripts
expect, I'd be willing to create a patch.

> The "fixes-only" commits are a bit more interesting, we still have huge
> swaths of subsystems that refuse to actually tag commits for stable, but
> luckily developers know to at least put a "Fixes:" tag on their fixes,
> which help us out in classifying where they should go.

Various aspects contribute to this, but due to my regression tracking
efforts two of them jumped to my mind here:

* A clear statement from Linus wrt to the stable tags in changes that
fix regressions would be good. E.g. something along the lines of "always
add a CC: <stable@... tag when fixing a regression caused by change
mainlined during the past year to ensure the fix reaches the users of
stable trees quickly".

  My recent changes to handling-regressions.rst[1] touched on that bit
already and told developers to do so. But it did so without any clear
precedent from Linus (as mentioned in the patch description). Hence it
afaics would help a lot if Linus said something like that to make it
"official".

  [1] See eed892da9cd ("docs: handling-regressions: rework section about
fixing procedures") in next. To quote: ```If a regression made it into a
proper mainline release during the past twelve months, ensure to tag the
fix with "Cc: stable@vger.kernel.org", as a "Fixes:" tag alone does not
guarantee a backport. Please add the same tag, in case you know the
culprit was backported to stable or longterm kernels.```


* a (big?) part of the problem afaics is that many developers and
maintainers seem to think that a "Fixes:" tag is enough to ensure a
backport. You efforts educating them[2] at least from here look a bit
like a endless game of whac-a-mole, as you sent such mails for quite a
while already and it seems nothing much has changed. Sometimes I wonder
if we should spam everyone in MAINTAINERS (and some of the regular
developers as well?) with a short PSA trying to kill that myth. But I
don't really like that idea myself. Maybe it would help if Linus
mentions it two or three times in release announcements?

  [2] for the unaware and the record, here are two recent ones:
https://lore.kernel.org/all/2023060703-colony-shakily-3514@gregkh/
https://lore.kernel.org/all/2023061137-algorithm-almanac-1337@gregkh/

> The "reverts" look not so good to me, but it's hard to know if they are
> followed up with a "real fix" afterward, which is common at times.

Yup.

> Anyway, thanks for doing this, looks pretty sane to me.

Thx. Maybe with a bit of fine tuning this becomes more useful and
something I can run regularly.

We'll see.

Ciao, Thorsten
