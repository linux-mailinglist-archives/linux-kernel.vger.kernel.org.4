Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02269643F08
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 09:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234232AbiLFIub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 03:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbiLFIu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 03:50:27 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A866441
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 00:50:26 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1p2Tei-0008PG-Gw; Tue, 06 Dec 2022 09:50:24 +0100
Message-ID: <9958a748-2608-8ed2-6e8f-2f3291286271@leemhuis.info>
Date:   Tue, 6 Dec 2022 09:50:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Content-Language: en-US, de-DE
To:     Joe Perches <joe@perches.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai@dev.carbon-project.org>
References: <20221205131424.36909375d90d5a40cd028bc0@linux-foundation.org>
 <11a9fe60f5333a931b8d75f67808b6d923c16dfa.camel@perches.com>
 <25f4838b-208a-cf8c-914c-b2092665d56f@leemhuis.info>
 <23a61dd072ee1d2cc5b54281b0a9dc13e01aa0b8.camel@perches.com>
 <bba95554-19a0-d548-d63c-811b229cbca0@leemhuis.info>
 <d64338a1-e708-dd1f-4d9c-3b793754a8fa@leemhuis.info>
 <b76cd99552c135629ab8e52d3e929916c7965a14.camel@perches.com>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: Fw: [PATCH 0/2] feat: checkpatch: prohibit Buglink: and warn
 about missing Link:
In-Reply-To: <b76cd99552c135629ab8e52d3e929916c7965a14.camel@perches.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1670316626;59e58b62;
X-HE-SMSGID: 1p2Tei-0008PG-Gw
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.12.22 08:44, Joe Perches wrote:
> On Tue, 2022-12-06 at 08:17 +0100, Thorsten Leemhuis wrote:
>> On 06.12.22 07:27, Thorsten Leemhuis wrote:
>>> On 06.12.22 06:54, Joe Perches wrote:
> []
>>>> and perhaps a more
>>>> generic, "is the thing in front of a URI/URL" a known/supported entry,
>>>> instead of using an known invalid test would be a better mechanism.
>>>
>>> Are you sure about that? It's not that I disagree completely, but it
>>> sounds overly restrictive to me and makes it harder for new tags to
>>> evolve in case we might want them.
> 
> It's easy to add newly supported values to a list.
> 
>>> And what tags would be on this allow-list? Anything else then "Link" and
>>> "Patchwork"? Those are the ones that looked common and valid to me when
>>> I ran
>>>
>>> git log --grep='http' v4.0.. | grep http | grep -v '    Link: ' | less
>>>
>>> and skimmed the output. Maybe "Datasheet" should be allowed, too -- not
>>> sure.
> []
>>> But I found a few others that likely should be on the disallow list:
>>> "Closes:", "Bug:", "Gitlab issue:", "References:", "Ref:", "Bugzilla:",
>>> "RHBZ:", and "link", as "Link" should be used instead in all of these
>>> cases afaics.
> 
> Do understand please that checkpatch will never be perfect.
> At best, it's just a guidance tool.

Of course -- and that's actually a reason why I prefer a disallow list
over an allow list, as that gives guidance in the way of "don't use this
tag, use Link instead" instead of enforcing "always use Link: when
linking somewhere" (now that I've written it like that it feels even
more odd, because it's obvious that it's a link, so why bother with a
tag; but whatever).

I also think the approach with a disallow list will not bother
developers much, while the other forces them a bit to much into a scheme.

> To me most of these are in the noise level, but perhaps all should just
> use Link:
> 
> $ git log -100000 --format=email -P --grep='^\w+:[ \t]*http' | \
>   grep -Poh '^\w+:[ \t]*http' | \
>   sort | uniq -c | sort -rn
>  103889 Link: http
>     415 BugLink: http
>     372 Patchwork: http
>     270 Closes: http
>     221 Bug: http
>     121 References: http
> [...]

Ha, I considered doing something like that when I wrote my earlier mail,
but was to lazy. :-D thx!

Yeah, they are not that often, but I grew tired arguing about that,
that's why I think checkpatch is the better place and in the better
position to handle that.

Anyway, so how to move forward now? Do you insist on a allow list (IOW:
a Link: or Patchwork: before every http...)? Or is a disallow list with
the most common unwanted tags for links (that you thankfully compiled)
fine for you as well?

Ciao, Thorsten
