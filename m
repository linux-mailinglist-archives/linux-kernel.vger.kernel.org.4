Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209A66D1643
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 06:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjCaEOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 00:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjCaEOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 00:14:44 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125DBD323
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 21:14:41 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id B0AFF4249E;
        Fri, 31 Mar 2023 04:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1680236079; bh=guBJ4Fv0vzGAvTdPZfEamIi2mfnfUPkj8SmoOL5FG/U=;
        h=Date:From:To:Cc:References:Subject:In-Reply-To;
        b=BmX+YCPvouXnfYHFeINYA04rVc40XkoRG2zK7IYYM9PwdOereugs9VG7xDIDCpfXU
         ONn1u94VMh5M6tcGaCpnP1tBeOOpe62Lj5cl4EUm0PFXEDvmMWkknTB9ix0NX0jRYF
         EBuYYaVrpmGDjNzLLxOTnOtuM+2IfCRa/5XoC7WsmiVmdgLft0L97wFfgMu/7OV29n
         PgZb31usSCZeMNgc6BTb8fxUCPWDBqAgAwwZ70gr7OV7guHZ+9XIJ4y23RlAsfPZPv
         UrLvQTRaU4tHYBHYr8uAn583GkVyIBuMWADiEOU/TmxNm3IrNvtuVUWJ8MFMrWxeSF
         Z6Leh+QxO45lQ==
Message-ID: <2dce2e9f-a279-ba62-9443-c863219fa27e@marcan.st>
Date:   Fri, 31 Mar 2023 13:14:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
From:   Hector Martin <marcan@marcan.st>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Janne Grunau <j@jannau.net>, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <20230328-soc-mailbox-v1-0-3953814532fd@marcan.st>
 <CABb+yY2=B2p5JhZiBE_mZLe3y16EUgVsUHK62LnRgaKa1-ptLg@mail.gmail.com>
 <f12bafa5-1589-5bcb-5f92-edb7be54efef@marcan.st>
 <CABb+yY1k9LSFb5kVe7bGhiubJ0jTDkFqYsGjobP=KjywXk_yuA@mail.gmail.com>
Content-Language: en-US
Subject: Re: [PATCH 0/5] mailbox: apple: Move driver into soc/apple and stop
 using the subsystem
In-Reply-To: <CABb+yY1k9LSFb5kVe7bGhiubJ0jTDkFqYsGjobP=KjywXk_yuA@mail.gmail.com>
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

On 31/03/2023 01.35, Jassi Brar wrote:
> On Wed, Mar 29, 2023 at 5:53 PM Hector Martin <marcan@marcan.st> wrote:
>> On 30/03/2023 01.04, Jassi Brar wrote:
> 
>>>> On top of this, the mailbox subsystem makes design
>>>>    decisions unsuitable for our use case. Its queuing implementation
>>>>    has a fixed queue size and fails sends when full instead of pushing
>>>>    back by blocking, which is completely unsuitable for high-traffic
>>>>    mailboxes with hard reliability requirements, such as ours. We've
>>>>    also run into multiple issues around using mailbox in an atomic
>>>>    context (required for SMC reboot/shutdown requests).
>>>>
>>> I don't think you ever shared the issues you were struggling with.
>>
>> I did try to send a patch clarifying/cleaning up inconsistent usage of
>> the atomic codepath in other drivers, and you rejected it. At that point
>> I gave up in trying to contribute to cleaning up the existing mess,
>> because you're clearly not interested.
>>
> You mean  https://lore.kernel.org/lkml/20220502090225.26478-6-marcan@marcan.st/
> Now I see where this code-rage comes from.
> 
> But let me clarify even more...
>  You do not kill some api just because you don't need that and/or you
> think that is "stupid" because you can't see past your own use-case.

It is general Linux kernel policy not to have internal APIs with zero
users. The Rust folks get pushback all the time for upstreaming stuff
piecewise even though in that case there are known, upcoming,
in-the-pipeline users (we do that too with rtkit but we always have
upcoming users downstream and we're small enough nobody notices and
complains :P). Having dead APIs that nobody uses and nobody can point at
an upcoming use case for is technical debt. That's why my first patch in
this series cleans up one of those on our side.

>> This issue is clearly known, and it doesn't take a lot of thinking to
>> realize that *any* queue length limit coupled with hard-fails on message
>> sends instead of pushback is just unsuitable for many use cases. Maybe
>> all existing mailbox users have intrinsically synchronous use cases that
>> keep the queue idle enough, or maybe they're just broken only in corner
>> cases that haven't come back to the mailbox subsystem yet. Either way,
>> as far as I'm concerned this is broken by design in the general case.
>>
> You may be surprised but I do understand hardcoding limits on buffer
> size is taboo.... unless benefits outweigh fingerpointing :)

Using a fixed size buffer is not the problem, having no blocking
mechanism when it gets full is the problem.

> 2) The api relies on last_tx_done() to make sure we submit data only
> when we have an all-clear ...

That's not the issue, the issue is putting stuff *into* the queue, not
taking it *out* of the queue and sending it to the hardware.

> which is a platform specific way to
> ensure signal will physically reach the remote (whether data is
> accepted or not is upto the upper layer protocol and that's why it is
> recommended to pass pointer to data, rather than data as the signal).
> The way api is recommended (not required) to be used,  the limit on
> TX_QUEUE_LEN(20), is not impactful beyond the fifo size of the
> controller. Though I am open to idea of seeing if tx failure should be
> considered a possiblity even after last_tx_done.

If I do this:

for (int i = 0; i < 30; i++) {
    mbox_send_message(...);
}

Then, unless the remote is fast enough to accept messages faster than
the CPU can send them, some of those sends will fail and refuse to send
data, once the subsystem side queue is full.

That is broken because it either loses data or forces the user to
implement retry poll loops, neither of which is appropriate. The mailbox
subsystem knows when the hardware can send data, it can properly block
the send on that signal (which is exactly what my refactor in this
series does when the hardware queue gets full).

If we instead wait for the tx completion stuff before sending, then that
defeats the point of having a queue because you'd be waiting for each
prior message before sending a new one. And then you need to keep track
of the last completion. And it requires a global serialization on the
client side anyway unless you can guarantee you have less than
QUEUE_SIZE clients. And you still have the issue of having to keep the
message data around until that completion fires, which is more code and
allocator overhead over just passing it inline, since it's a tiny amount
of data. Etc etc etc.

It is a bad API, using it properly and reliably requires basically
re-implementing part of the subsystem logic in the consumer to work
around the issues.

>  Iirc on lkml, people have reported using 1000s tx calls per second
> within this queue limit. I don't know how you tried to interpret that
> limit but would have helped to know your issue.

For reference: Our GPU benchmarks will easily hit 18000+ TX calls per
second through mailbox, even more for some corner cases (this is why I
want to implement coalescing when the HW queue already has identical
doorbells, to reduce that). More importantly, although the GPU side
firmware is usually fast at processing this (it has an IRQ handler and
its own doorbell coalescing), when GPU faults or errors happen it has
latency spikes, and then we *must* block mailbox sends until it is ready
to handle messages again. Dropping messages on the floor is not an
option. This *has* to be 100% reliable or users' machines crash.

>>
>>> But if redoing mailbox overall saves you complexity, I am ok with it.
>>
>> Is that an ack? :-)
>>
> You sound like being trapped in a bad marriage with mailbox :)    And
> I really don't want you to stay in a rewardless situation --- I have
> actually asked some platforms during RFCs if mailbox is really useful
> for them (usually SMC/HVC based useage), but they found use.

> Please make sure it is not just code-rage of your patchset being
> rejected, and indeed there are things you can't do with the api.

It isn't. There's no code rage here, that patch was a long time ago.
What that patch told me was that cleaning up mailbox to work for us was
going to be an uphill battle, and then over the course of the year+
after that it has become very evident that there is a lot of work to do
to make mailbox work for us. Hence, the conclusion that we're better off
without. Honestly, at this point, even without that rejection I'd still
want to move away because there's just so much work to do to get all the
features we need and bugs we're hitting fixed and no realistic way to
test other consumers/drivers to make sure we don't break them in the
process.

> Because the api can not have Zero impact on any platform's
> implementation and my ack here could be used as a precedent for every
> platform to implement their own tx/rx queues and dt handling and move
> into drivers/soc/.

As I said, there's a very clear sign here that this is the right move:
the overall code size goes down. After this series we have:

- Less code in total (much less actually executing)
- That works better
- And is easier to understand and debug
- And requires less maintenance effort to improve

If other platforms come to the same conclusion for their use case then
yes, they should move away from mailbox as well. I would expect that
might be the case for a subset, not all, of users. If more users follow,
that should be a sign to you that the mailbox subsystem isn't as useful
as you'd like :)

Put another way: common code should actually save you lines of code. If
it's causing you to spend more lines of code to use it properly than it
saves, it is not useful and does not actually improve the situation.

> A couple years later someone will see it doesn't> make sense every> platform is doing the same thing in driver/soc/ and
> maybe it s a good idea to have some drivers/mailbox/ to hold the
> common code.

If they are really doing the same thing, sure. And then might be a good
time to re-think mailbox and what it should do and how it should offer
this common code to drivers, in a way that works for more users and
actually saves everyone time and maintenance effort, with less burden.

> I am also aware I am just a volunteer at mailbox and can not dictate
> what you do with your platform. So, is there anything like
> Neither-acked-nor-objected-but-left-to-soc-by ?  ;)

Not really, because it's your subsystem so we do actually need you to
ack the driver deletion patch if it's going to go through our tree.
That's the rules. "Acked" doesn't mean "I am happy with this", it means
"I am okay with this" ;)

- Hector



