Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A6C6EA63C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 10:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjDUIut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 04:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjDUIuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 04:50:32 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9D49ED7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 01:50:29 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1ppmTJ-0003x6-Gm; Fri, 21 Apr 2023 10:50:25 +0200
Message-ID: <8a182d08-d09c-14ed-3075-c40d264916e6@leemhuis.info>
Date:   Fri, 21 Apr 2023 10:50:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Subject: Re: Linux regressions report for mainline [2023-04-16]
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
To:     dsterba@suse.cz,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Neal Gompa <neal@gompa.dev>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Sterba <dsterba@suse.com>, linux-kernel@vger.kernel.org,
        Rafael Wysocki <rafael@kernel.org>, Chris Mason <clm@meta.com>,
        Boris Burkov <boris@bur.io>
References: <CAHk-=wjL7GG9s9Y2+u2725M+Ru=bUXnzOnXRwoSktY0fVdhhzw@mail.gmail.com>
 <20230418213228.1273218-1-neal@gompa.dev>
 <d1b7b62d-bec8-e290-d12c-0b641ab382dd@leemhuis.info>
 <20230420192156.GY19619@suse.cz>
Content-Language: en-US, de-DE
In-Reply-To: <20230420192156.GY19619@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1682067030;b37b32c7;
X-HE-SMSGID: 1ppmTJ-0003x6-Gm
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.04.23 21:21, David Sterba wrote:
> On Wed, Apr 19, 2023 at 07:03:31AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
>> On 18.04.23 23:32, Neal Gompa wrote:
>>>
>>> I'm the guy that sort of kickstarted this whole thing a year ago.
>>> >From my perspective in Fedora-land, we've been running automatic
>>> weekly fstrim on every Fedora system for three years now[1] and
>>> have not received any complaints about SSDs pushing daises from
>>> that.
>>>
>>> When we started discussing btrfs discard=async within Fedora
>>> two years ago[2], I started soliciting feedback and information
>>> from the Btrfs developers I was regularly working with at the time.
>>>
>>> Last year, I had a face-to-face with Chris Mason and we discussed
>>> the idea in depth and decided to go for this, based on both Fedora's
>>> data with consumer disks and Facebook's data with their datacenters.
>>>
>>> The only real surprise we had was the so-called "discard storm",
>>> which Boris Burkov made adjustments to resolve a couple weeks ago[3].
>>> [...]
>>> [3]: https://lore.kernel.org/linux-btrfs/cover.1680723651.git.boris@bur.io/T/#t
>>
>> Wait, what? Argh. Sorry, if I had seen that patch, I wouldn't have
>> brought this up in my report at all. I missed it, as I wasn't CCed; and
>> regzbot missed it, because the patch uses a odd format for the lore link
>> (but not totally uncommon, will change regzbot to ensure that doesn't
>> happen again).

[for the record: I noticed the odd format was not the real problem; see
below]

> I'd need pay more attention when the regression tracking process is
> involved in case there are more patch versions floating around. People
> usually don't "CC enough" so that you have the regzbot in place helps
> to track the state.

First off: Sorry again for the trouble I caused.

Yes, a CC would have prevent it, as then I (aka the "human fallback")
would have seen the patch and noticed that regzbot missed something.

But normally it should have worked fine without the CC. In this case it
just didn't due to a bug in regzbot: the msg-id of the tracked report
contains slashes and it seems something in the url en/decoding within
regzbot went wrong somewhere. IOW: the fix in next (2e55571fddf ("btrfs:
set default discard iops_limit to 1000")) is fine the way it is from
regzbot point of view and I have to fix regzbot.

>> P.S.: /me meanwhile yet again wonders if we should tell people to add a
>> "CC: <regressions@lists.linux.dev>" on patches fixing regressions. Then
>> in this case I would have become aware of the patch. And it makes it
>> obvious for anybody handling patches that the patch is fixing a
>> regression. But whatever, might not be worth it.
> 
> I'm not sure if it would fit how regzbot workflow works, but syzbot
> provides links with the reports and then changes the state when the
> patch is committed containing the links.

You can't see it on the lists and only it regzbot web-ui, but regzbot
works similarly: it marks a regression as "fix incoming" when it notices
the fix hit linux-next.

> I don't see anything similar in
> the process/handling-regression document. If the "Link: <report>" is
> sufficient

It is, but maybe handling-regressions should point that out more
clearly. It currently is more implicit: "These tags are also crucial for
tools and scripts used by other kernel developers or Linux
distributions; one of these tools is regzbot, which heavily relies on
the “Link:” tags to associate reports for regression with changes
resolving them."

> then it should work already but there's no guarantee that the
> submitted patches would contain that. I add links to the committed
> versions

Thx for that, as the one Boris initially used[1] in the submission[2] is
not easily to resolve.

[1]
https://lore.kernel.org/linux-btrfs/ZCxKc5ZzP3Np71IC@infradead.org/T/#m6ebdeb475809ed7714b21b8143103fb7e5a966da
[2]
https://lore.kernel.org/linux-btrfs/cover.1680723651.git.boris@bur.io/T/#me406ebc5dc35e7fdbb59aece2158ac1a86b0c11b

> but then you'd need to scan at least linux-next. In any case
> with the regzbot it's fixable.

Ciao, Thorsten
