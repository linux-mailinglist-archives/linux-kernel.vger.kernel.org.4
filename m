Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9026F7C3E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 07:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjEEFQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 01:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjEEFQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 01:16:23 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1074E9EE5
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 22:16:21 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-50bc5197d33so2527634a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 22:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1683263779; x=1685855779;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=AAGrMynGZX+aU8hvMH81rrOEjjcEKOinOwRsR06NTs4=;
        b=EbqgJ3xHqKCuRg78iZ2c/OeoviHq8cNrZ9H8S0bSB1EsCpu17oInTbDw1+nyD43HqK
         SBNE8blJjz1tGb3nE9LwzCb8JDAlp2R3KyjOws9lAfzrd0Svw+8T/glfwMnDV46EQD4I
         35GRhvm3ChZps4HvTNrcr8pXHpAEA6jonLlC+yLst14F01poDw023+rSWncTwT5wArRP
         C5Ywid72L/Jjw8MbKTAVhop9VOEnXZWgfvFaA4egHRcttfFyg9bLAWfU/k1CvtzfoTrk
         ZnPzPQ29JB0NhthI+dAXedFaABah8GXkdDfhuRUQyp6mhPNIXz9smel1zcyMtKRc7rwt
         lmWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683263779; x=1685855779;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AAGrMynGZX+aU8hvMH81rrOEjjcEKOinOwRsR06NTs4=;
        b=JD2OMu2abQR6foTwTL/gXMMpBnlSYjQp160VrNoihvtw1VJM7NHTti/+Hul0XLKIXH
         xfzVWMWo/Tsvwz5wY3n7PckaAsvQdMNgcQQ3cPd8Gp2CcS7zrf+EFNxR47g2Gk2/MycR
         Br26+oZR8hEuh0QfIhWKQEaWeYQCxKvRbaV6MC1LWMpvdK3x9kPpn8W8Rnns0LqVj2eQ
         5O5R+SX+GQo9L7K7qsztQHcz0fXkcEM5/1qam7D3MvmtpE6JxK3PxFBI/oIqbrZ0LanZ
         CK8dz9PrGkL7iAz6pS9lfG2gnxtkZsrVFnEBHIURSPvTLl/P8YOT4dwyVkknVVmRAieP
         YTlA==
X-Gm-Message-State: AC+VfDzPhDqF3kDOhAxPA0JPKYMf7OgBJ5fp9yvkREVTH5timWHn0oEc
        XgqCPxMBXaUlWVvSuD+ynpvJCQ==
X-Google-Smtp-Source: ACHHUZ7NCtOFGu5WWo/fXvEmAfqIhX4dbjPGx2RalN/a0aLFkg6paKLghKmHKm1l6JhiI+PF2L2Czw==
X-Received: by 2002:a17:907:1687:b0:92b:e1ff:be30 with SMTP id hc7-20020a170907168700b0092be1ffbe30mr77173ejc.4.1683263779529;
        Thu, 04 May 2023 22:16:19 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id n26-20020a17090673da00b0094eeea5c649sm460827ejl.114.2023.05.04.22.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 22:16:19 -0700 (PDT)
References: <20230503090708.2524310-1-nmi@metaspace.dk>
 <da7b815d-3da8-38e5-9b25-b9cfb6878293@acm.org>
 <87jzxot0jk.fsf@metaspace.dk>
 <b9a1c1b2-3baa-2cad-31ae-8b14e4ee5709@acm.org>
 <ZFP+8apHunCCMmOZ@kbusch-mbp.dhcp.thefacebook.com>
 <e7bc2155-613b-8904-9942-2e9615b0dc63@kernel.dk>
 <875y97u92z.fsf@metaspace.dk>
 <0adf4086-c624-1587-d490-9e6bb517afe0@kernel.dk>
User-agent: mu4e 1.10.3; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        lsf-pc@lists.linux-foundation.org, rust-for-linux@vger.kernel.org,
        linux-block@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj?= =?utf-8?Q?=C3=B6rn?= Roy Baron 
        <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
        open list <linux-kernel@vger.kernel.org>, gost.dev@samsung.com
Subject: Re: [RFC PATCH 00/11] Rust null block driver
Date:   Fri, 05 May 2023 07:06:55 +0200
In-reply-to: <0adf4086-c624-1587-d490-9e6bb517afe0@kernel.dk>
Message-ID: <87sfcbs6ho.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jens Axboe <axboe@kernel.dk> writes:

> On 5/4/23 1:59?PM, Andreas Hindborg wrote:
>> 
>> Jens Axboe <axboe@kernel.dk> writes:
>> 
>>> On 5/4/23 12:52?PM, Keith Busch wrote:
>>>> On Thu, May 04, 2023 at 11:36:01AM -0700, Bart Van Assche wrote:
>>>>> On 5/4/23 11:15, Andreas Hindborg wrote:
>>>>>> If it is still unclear to you why this effort was started, please do let
>>>>>> me know and I shall try to clarify further :)
>>>>>
>>>>> It seems like I was too polite in my previous email. What I meant is that
>>>>> rewriting code is useful if it provides a clear advantage to the users of
>>>>> a driver. For null_blk, the users are kernel developers. The code that has
>>>>> been posted is the start of a rewrite of the null_blk driver. The benefits
>>>>> of this rewrite (making low-level memory errors less likely) do not outweigh
>>>>> the risks that this effort will introduce functional or performance regressions.
>>>>
>>>> Instead of replacing, would co-existing be okay? Of course as long as
>>>> there's no requirement to maintain feature parity between the two.
>>>> Actually, just call it "rust_blk" and declare it has no relationship to
>>>> null_blk, despite their functional similarities: it's a developer
>>>> reference implementation for a rust block driver.
>>>
>>> To me, the big discussion point isn't really whether we're doing
>>> null_blk or not, it's more if we want to go down this path of
>>> maintaining rust bindings for the block code in general. If the answer
>>> to that is yes, then doing null_blk seems like a great choice as it's
>>> not a critical piece of infrastructure. It might even be a good idea to
>>> be able to run both, for performance purposes, as the bindings or core
>>> changes.
>>>
>>> But back to the real question... This is obviously extra burden on
>>> maintainers, and that needs to be sorted out first. Block drivers in
>>> general are not super security sensitive, as it's mostly privileged code
>>> and there's not a whole lot of user visibile API. And the stuff we do
>>> have is reasonably basic. So what's the long term win of having rust
>>> bindings? This is a legitimate question. I can see a lot of other more
>>> user exposed subsystems being of higher interest here.
>> 
>> Even though the block layer is not usually exposed in the same way
>> that something like the USB stack is, absence of memory safety bugs is
>> a very useful property. If this is attainable without sacrificing
>> performance, it seems like a nice option to offer future block device
>> driver developers. Some would argue that it is worth offering even in
>> the face of performance regression.
>> 
>> While memory safety is the primary feature that Rust brings to the
>> table, it does come with other nice features as well. The type system,
>> language support stackless coroutines and error handling language
>> support are all very useful.
>
> We're in violent agreement on this part, I don't think anyone sane would
> argue that memory safety with the same performance [1] isn't something
> you'd want. And the error handling with rust is so much better than the
> C stuff drivers do now that I can't see anyone disagreeing on that being
> a great thing as well.
>
> The discussion point here is the price being paid in terms of people
> time.
>
>> Regarding maintenance of the bindings, it _is_ an amount extra work. But
>> there is more than one way to structure that work. If Rust is accepted
>> into the block layer at some point, maintenance could be structured in
>> such a way that it does not get in the way of existing C maintenance
>> work. A "rust keeps up or it breaks" model. That could work for a while.
>
> That potentially works for null_blk, but it would not work for anything
> that people actually depend on. In other words, anything that isn't
> null_blk. And I don't believe we'd be actively discussing these bindings
> if just doing null_blk is the end goal, because that isn't useful by
> itself, and at that point we'd all just be wasting our time. In the real
> world, once we have just one actual driver using it, then we'd be
> looking at "this driver regressed because of change X/Y/Z and that needs
> to get sorted before the next release". And THAT is the real issue for
> me. So a "rust keeps up or it breaks" model is a bit naive in my
> opinion, it's just not a viable approach. In fact, even for null_blk,
> this doesn't really fly as we rely on blktests to continually vet the
> sanity of the IO stack, and null_blk is an integral part of that.

Sure, once there are actual users, this model would not work. But during
an introduction period it might be a useful model. Having Rust around
without having to take care of it might give
maintainers,reviewers,contributors a no strings attached opportunity to
dabble with the language in a domain they are familiar with.

>
> So I really don't think there's much to debate between "rust people vs
> jens" here, as we agree on the benefits, but my end of the table has to
> stomach the cons. And like I mentioned in an earlier email, that's not
> just on me, there are other regular contributors and reviewers that are
> relevant to this discussion. This is something we need to discuss.
>
> [1] We obviously need to do real numbers here, the ones posted I don't
> consider stable enough to be useful in saying "yeah it's fully on part".
> If you have an updated rust nvme driver that uses these bindings I'd
> be happy to run some testing that will definitively tell us if there's a
> performance win, loss, or parity, and how much.

I do plan to rebase the NVMe driver somewhere in the next few months.
I'll let you know when that work is done.

Best regards
Andreas
