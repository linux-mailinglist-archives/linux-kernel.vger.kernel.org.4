Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284D56CF69A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 00:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjC2Wxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 18:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjC2Wxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 18:53:52 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CF935A5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 15:53:50 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 68095424D0;
        Wed, 29 Mar 2023 22:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1680130428; bh=CvYbW7aDTRxlcODREyD9GWXuEEvSn+ml1u4/ZC9PgBA=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To;
        b=DBWF70kUVAh5YXhbo1ZBBtFMwz0ZQ4E8or+K578gqke6vfjLVV7eYYBcdAmhnO39G
         zFsFVcZAOHEVRXjgW/bkvxZ3RpDv8YRqCD31DTBclkeZ9HqvL9AT/ZUjXehpZcEQ3H
         w3epj7rSVyGLesLki3w03lNECsgexJklG70DrxEZ44NUCJetC5Wlow4A/GJHsq2jZ8
         gy00nVadZSSWnv2T3KKe9IHsuVsVPfU8wcyJHfbitkGYy4uBqFysRjt/PfaRFGsFrC
         TNWiBLMd1+w/yHhE+8ndEIUaNMDJMNDYh5JKCI4wcPWgHikaLcaRzsjzRLgj1gIqPJ
         u1e5M8m0HreSg==
Message-ID: <f12bafa5-1589-5bcb-5f92-edb7be54efef@marcan.st>
Date:   Thu, 30 Mar 2023 07:53:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Janne Grunau <j@jannau.net>, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <20230328-soc-mailbox-v1-0-3953814532fd@marcan.st>
 <CABb+yY2=B2p5JhZiBE_mZLe3y16EUgVsUHK62LnRgaKa1-ptLg@mail.gmail.com>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH 0/5] mailbox: apple: Move driver into soc/apple and stop
 using the subsystem
In-Reply-To: <CABb+yY2=B2p5JhZiBE_mZLe3y16EUgVsUHK62LnRgaKa1-ptLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/03/2023 01.04, Jassi Brar wrote:
> On Tue, Mar 28, 2023 at 8:14 AM Hector Martin <marcan@marcan.st> wrote:
>>
>> Once upon a time, Apple machines had some mailbox hardware, and we had
>> to write a driver for it. And since it was a mailbox, it felt natural to
>> use the Linux mailbox subsystem.
>>
>> More than a year later, it has become evident that was not the right
>> decision.
>>
>> Linux driver class subsystems generally exist for a few purposes:
>> 1. To allow mixing and matching generic producers and consumers.
>> 2. To implement common code that is likely to be shared across drivers,
>>    and do so correctly so correct code only has to be written once.
>> 3. To force drivers into a "correct" design, such that driver authors
>>    avoid common pitfalls.
>>
> The Mailbox subsystem is meant to serve (2) and possibly (3).
> We never aimed for (1), we can't... because the firmware on the remote
> end is also a part of "local hardware" -- keeping every bit of
> hardware the same, if just the f/w changes you may have to change the
> linux side driver.

Right, I'm just explaining why this isn't like i2c/spi and similar
subsystems. The value proposition is significantly weaker with mailbox
for this reason.

>> 2. The mailbox subsystem implements a bunch of common code for queuing,
>>    but we don't need that because our hardware has hardware queues. It
>>    also implements a bunch of common code for supporting multiple
>>    channels, but we don't need that because our hardware only has one
>>    channel (it has "endpoints" but those are just tags that are part of
>>    the message).
>>
> In note-1, you complain it is not standard/flexible enough, and here
> its support for features, that you don't need, become a problem?

It has features we don't need that introduce bugs and complexity, while
missing features we *do* need. So yes, it's doubly a problem.

>> On top of this, the mailbox subsystem makes design
>>    decisions unsuitable for our use case. Its queuing implementation
>>    has a fixed queue size and fails sends when full instead of pushing
>>    back by blocking, which is completely unsuitable for high-traffic
>>    mailboxes with hard reliability requirements, such as ours. We've
>>    also run into multiple issues around using mailbox in an atomic
>>    context (required for SMC reboot/shutdown requests).
>>
> I don't think you ever shared the issues you were struggling with.

I did try to send a patch clarifying/cleaning up inconsistent usage of
the atomic codepath in other drivers, and you rejected it. At that point
I gave up in trying to contribute to cleaning up the existing mess,
because you're clearly not interested. I have some downstream fixes for
the atomic codepath and I don't think they even fix all the problems,
because we still run into issues. The design of the mailbox core is just
bizarre and makes it very hard to reason about the corner cases through
the whole queuing business.

It's a big chunk of complexity and bug-prone design and it just doesn't
make any sense for us to spend time on this if cleaning things up is
going to be an uphill battle *and* in the end the subsystem still does
nothing useful for us. It's just using the subsystem for the sake of
using it at that point. It makes no sense.

As for the other issue, there's a giant comment around the queue length
define:

> /*
>  * The length of circular buffer for queuing messages from a client.
>  * 'msg_count' tracks the number of buffered messages while 'msg_free'
>  * is the index where the next message would be buffered.
>  * We shouldn't need it too big because every transfer is interrupt
>  * triggered and if we have lots of data to transfer, the interrupt
>  * latencies are going to be the bottleneck, not the buffer length.
>  * Besides, mbox_send_message could be called from atomic context and
>  * the client could also queue another message from the notifier 'tx_done'
>  * of the last transfer done.
>  * REVISIT: If too many platforms see the "Try increasing MBOX_TX_QUEUE_LEN"
>  * print, it needs to be taken from config option or somesuch.
>  */
> #define MBOX_TX_QUEUE_LEN       20

This issue is clearly known, and it doesn't take a lot of thinking to
realize that *any* queue length limit coupled with hard-fails on message
sends instead of pushback is just unsuitable for many use cases. Maybe
all existing mailbox users have intrinsically synchronous use cases that
keep the queue idle enough, or maybe they're just broken only in corner
cases that haven't come back to the mailbox subsystem yet. Either way,
as far as I'm concerned this is broken by design in the general case.

> Not to mean there can be no limitation but I knew a platform that ran
> a virtual block-device and custom filesystem over the mailbox, and it
> was good for a camera product that needs high bandwidth image
> transfer.

I guess it worked for them, but it's been breaking our GPU use case. So
if it's working for other people, I guess that's fine. But it's
definitely not working for us, and I'm not inclined to try to fix the
issues if nobody else has a problem.

Working on common code has the inherent risk that any changes can break
other users and I have no way to test every other mailbox user. There
are real *costs* associated with having common code, especially for
boutique things like mailbox which are highly heterogeneous and used on
all kinds of weird systems no single developer can hope to have access to.

So if you say it's working well for other people, all the more reason
for us to move away and leave them alone instead of trying to make major
changes to fix everything that isn't working for us and risk breaking
others.

>> Jassi: Ideally I'd like to get an ack on this and merge it all through
>> asahi-soc, so we don't have to play things patch-by-patch across
>> multiple merge cycles to avoid potentially broken intermediate states.
>>
> Instead of every platform implementing their own message queuing and
> handling mechanism and parsing producer-comsumer links from the DT,
> there is a reusable code in drivers/mailbox.

As I said, we don't need nor want message queuing (yes, this is the bulk
of the complexity of the subsystem and really the source of a lot of the
pain, especially once you start throwing atomic into the mix). Other
mailbox hardware might, and that's fine. It's just not for us.
Especially not if it falls over when the queue gets full like it does.

I'm not saying the mailbox subsystem shouldn't exist, I'm saying it
might be a good idea as it stands for *some* mailbox
producers/consumers/use cases, but not *all*, and in this case, not ours.

As for the DT links, that's ~25 lines of code.

> And there is a reason the reduction in code with this patchset is
> meager -- you anyway have to implement your platform specific stuff.

Think about it for a second. We are ceasing use of the subsystem, which
under any reasonable expectation would require us to *add* code to
duplicate functionality. Indeed there's one new small function to deal
with the OF phandle lookup. And there's also a whole new header file
with prototypes that are a facsimile of the core mailbox API too. But
overall the total LOC is down, because we more than make that up by
removing overhead caused by having to bend to the wills of the subsystem
and work around its issues (and we'd be removing even more if the
upstream driver already had the new features like runtime-PM and
workarounds for more issues).

> But if redoing mailbox overall saves you complexity, I am ok with it.

Is that an ack? :-)

- Hector

