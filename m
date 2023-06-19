Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCDE735C36
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 18:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbjFSQd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 12:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjFSQd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 12:33:26 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24391A6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 09:33:24 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qBHoh-0003gl-87; Mon, 19 Jun 2023 18:33:23 +0200
Message-ID: <fafb977c-954c-af1d-327d-539cdaaab8a8@leemhuis.info>
Date:   Mon, 19 Jun 2023 18:33:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To:     Greg KH <gregkh@linuxfoundation.org>
References: <9e0f5378-63d8-add4-2b79-2173a4c98086@leemhuis.info>
 <24edd13e-791a-bd05-0a44-dd5475c7e200@leemhuis.info>
 <2023061955-abdominal-refute-4b5a@gregkh>
 <97b81eab-8e09-2163-1b91-daecb8127a7c@leemhuis.info>
 <2023061936-eatable-grumbling-f3c1@gregkh>
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: JFYI: patches in next that might be good to mainline rather
 sooner than later?
In-Reply-To: <2023061936-eatable-grumbling-f3c1@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1687192404;2004eb89;
X-HE-SMSGID: 1qBHoh-0003gl-87
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.06.23 15:58, Greg KH wrote:
> On Mon, Jun 19, 2023 at 02:19:49PM +0200, Thorsten Leemhuis wrote:
>> Last year on the maintainers summit we discussed this "delayed stable
>> backport" thingy that afaik works something like this:
>>
>> Cc: <stable@vger.kernel.org> # after 4 weeks
>>
>> Or is it more like this?
>>
>> Cc: <stable@vger.kernel.org> # 6.2 [after 4 weeks]
>>
>> I think the conclusion was to add this to the documentation, but that
>> afaics never happened. If you tell me the format you or your scripts
>> expect, I'd be willing to create a patch.
> 
> Either of them will work, as my "script" is me reviewing each patch :)
> 
> It's rare that I see this, [...]

I guess that partially because many people are not aware of this option. :-D

>>> The "fixes-only" commits are a bit more interesting, we still have huge
>>> swaths of subsystems that refuse to actually tag commits for stable, but
>>> luckily developers know to at least put a "Fixes:" tag on their fixes,
>>> which help us out in classifying where they should go.
>>
>> Various aspects contribute to this, but due to my regression tracking
>> efforts two of them jumped to my mind here:
>>
>> * A clear statement from Linus wrt to the stable tags in changes that
>> fix regressions would be good. E.g. something along the lines of "always
>> add a CC: <stable@... tag when fixing a regression caused by change
>> mainlined during the past year to ensure the fix reaches the users of
>> stable trees quickly".
> 
> Sounds good to me for you to say that!  It should happen, but remember
> many maintainers still don't want to, or feel they need to, tag anything
> for stable.  And that's fine, I can't tell people what to do and the
> stable tree stuff was ALWAYS designed to never require maintainers to do
> more work than they wanted to.

Yeah, I know and that's totally fine with me. The problem is that the
tag is overloaded with two meanings ("I want to backport this" and "I'm
willing to help with backporting in case of trouble"). Something along
the lines of

Cc: <stable@vger.kernel.org> # notmyjob

could help for this case, so people can indicate "this really should be
backported, but I won't help with that".

> So while we can ask, we can never require.

Well, we IMHO could require to tag them to ensure they are not missed
and quickly picked up.

>> * a (big?) part of the problem afaics is that many developers and
>> maintainers seem to think that a "Fixes:" tag is enough to ensure a
>> backport. You efforts educating them[2] at least from here look a bit
>> like a endless game of whac-a-mole, as you sent such mails for quite a
>> while already and it seems nothing much has changed. Sometimes I wonder
>> if we should spam everyone in MAINTAINERS (and some of the regular
>> developers as well?) with a short PSA trying to kill that myth. But I
>> don't really like that idea myself. Maybe it would help if Linus
>> mentions it two or three times in release announcements?
>>
>>   [2] for the unaware and the record, here are two recent ones:
>> https://lore.kernel.org/all/2023060703-colony-shakily-3514@gregkh/
>> https://lore.kernel.org/all/2023061137-algorithm-almanac-1337@gregkh/
> 
> Given that the cc: stable predates the Fixes: tag by years, it's funny
> that people don't realize this.
> 
> BUT it's the fixes tag that we have been using for those subsystems that
> do NOT tag stuff for stable, so I guess when people saw patches flow in,
> they just "assumed" that this was the normal process.

Guess so.

> So yes, I'll keep reminding people, and Sasha does a great job in
> sweeping up the Fixes: only patches, it is never guaranteed that this
> will get into a stable release.
> 
> Except for a yearly "here is how stable works" email like you say to all
> MAINTAINERS, I don't know how it would be any more explicit than what we
> have documented today.  Maybe I should do that yearly type of an email,
> consider it a christmas card update or something :)

How about "10 myths Linux developers believe about kernels development
process; number 6 will astound you".

/me runs and hides

Ciao, Thorsten
