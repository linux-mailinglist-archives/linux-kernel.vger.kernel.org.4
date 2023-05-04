Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C253A6F774A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 22:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjEDUmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 16:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjEDUmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 16:42:21 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58D11209E
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 13:38:35 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9619095f479so157492866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 13:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1683232645; x=1685824645;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=Y4BDNA8x26D+gc/g54BXpX2Nts8JzomtqMRTsoUmvOM=;
        b=rrTa6+5SK1/V6QSWTSsDVvGnb1HHhkAoxNHrbJhFAGaj0cYKKd0TxvWTUwEN6yQkU6
         2LcGKU/sRUfRNl1KvLXLSa1OY6hhdOiVuFwT3t39Rb/LoFIHZLU3vObujWHorJodRIJ7
         VGBP3/svQz2Y68MP0QPx5TMKtGGAatiPH/Pu4SF9PniwcQhewWIRMgBCo3ROuJpBVOoa
         NSUFKcwYeDFBHIyGsh+D4tODRwU32EfS9ye3yCctNSht/4HLQiYWABIe41ku4ewgibun
         4vetlKPGYBa5FiT4od7XYRhUlff7Mvuv2y3PZBKIi1v3NESoXlmv3/Y9LMql663WsFpl
         BYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683232645; x=1685824645;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4BDNA8x26D+gc/g54BXpX2Nts8JzomtqMRTsoUmvOM=;
        b=T1NzoFEPv8t8zc5pj67bZi84ExM9DTzv0DqpGUKYxB5vMMEHVpw7AvGFaoByDuawNW
         3FaFk/Zxi1UWu/lEbiC3NcylopJ+bCqensMRNAPHdhHYiBvncSM3IRp0ycqRJoOevuqF
         rwUmY87x1k/EEVL6bzQuC6Garkj5/IaX2DUpdygoc+XpN2ilEf/KamQqgjbGDnbe/qma
         t6EoZFfcjM23aK0aoGohU+bjX7B8HVanwJaM9Racx46cfxPaq2qixA5qRCyUBJZGRbaw
         VV8DeglGjiYlUnH3BNcJ4NzucouvFpw7IpuATUC/sr88pL6j4DmUsxushplDd6Q8dSQH
         2hAQ==
X-Gm-Message-State: AC+VfDwkpHdfdw8WCrprK82Z5iGXuZZb4dKcX4w8SS7jyuLJgPTXW+J5
        +OnpHac4mm3Uwi40Q5nTnz0eIA==
X-Google-Smtp-Source: ACHHUZ7LMxRdUgv7ihKLYjHLVFijm/GoKWSZk2d5fk7YgzP3ozFOa7A5lw2KFJwtJFmO5XoiGrGuqw==
X-Received: by 2002:a17:906:4794:b0:94a:937a:58f1 with SMTP id cw20-20020a170906479400b0094a937a58f1mr235860ejc.1.1683232645162;
        Thu, 04 May 2023 13:37:25 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id rl12-20020a170907216c00b009599c3a019fsm7809ejb.60.2023.05.04.13.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 13:37:24 -0700 (PDT)
References: <20230503090708.2524310-1-nmi@metaspace.dk>
 <da7b815d-3da8-38e5-9b25-b9cfb6878293@acm.org>
 <87jzxot0jk.fsf@metaspace.dk>
 <b9a1c1b2-3baa-2cad-31ae-8b14e4ee5709@acm.org>
 <ZFP+8apHunCCMmOZ@kbusch-mbp.dhcp.thefacebook.com>
 <e7bc2155-613b-8904-9942-2e9615b0dc63@kernel.dk>
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
Date:   Thu, 04 May 2023 21:59:53 +0200
In-reply-to: <e7bc2155-613b-8904-9942-2e9615b0dc63@kernel.dk>
Message-ID: <875y97u92z.fsf@metaspace.dk>
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

> On 5/4/23 12:52?PM, Keith Busch wrote:
>> On Thu, May 04, 2023 at 11:36:01AM -0700, Bart Van Assche wrote:
>>> On 5/4/23 11:15, Andreas Hindborg wrote:
>>>> If it is still unclear to you why this effort was started, please do let
>>>> me know and I shall try to clarify further :)
>>>
>>> It seems like I was too polite in my previous email. What I meant is that
>>> rewriting code is useful if it provides a clear advantage to the users of
>>> a driver. For null_blk, the users are kernel developers. The code that has
>>> been posted is the start of a rewrite of the null_blk driver. The benefits
>>> of this rewrite (making low-level memory errors less likely) do not outweigh
>>> the risks that this effort will introduce functional or performance regressions.
>> 
>> Instead of replacing, would co-existing be okay? Of course as long as
>> there's no requirement to maintain feature parity between the two.
>> Actually, just call it "rust_blk" and declare it has no relationship to
>> null_blk, despite their functional similarities: it's a developer
>> reference implementation for a rust block driver.
>
> To me, the big discussion point isn't really whether we're doing
> null_blk or not, it's more if we want to go down this path of
> maintaining rust bindings for the block code in general. If the answer
> to that is yes, then doing null_blk seems like a great choice as it's
> not a critical piece of infrastructure. It might even be a good idea to
> be able to run both, for performance purposes, as the bindings or core
> changes.
>
> But back to the real question... This is obviously extra burden on
> maintainers, and that needs to be sorted out first. Block drivers in
> general are not super security sensitive, as it's mostly privileged code
> and there's not a whole lot of user visibile API. And the stuff we do
> have is reasonably basic. So what's the long term win of having rust
> bindings? This is a legitimate question. I can see a lot of other more
> user exposed subsystems being of higher interest here.

Even though the block layer is not usually exposed in the same way that
something like the USB stack is, absence of memory safety bugs is a very
useful property. If this is attainable without sacrificing performance,
it seems like a nice option to offer future block device driver
developers. Some would argue that it is worth offering even in the face
of performance regression.

While memory safety is the primary feature that Rust brings to the
table, it does come with other nice features as well. The type system,
language support stackless coroutines and error handling language
support are all very useful.

Regarding maintenance of the bindings, it _is_ an amount extra work. But
there is more than one way to structure that work. If Rust is accepted
into the block layer at some point, maintenance could be structured in
such a way that it does not get in the way of existing C maintenance
work. A "rust keeps up or it breaks" model. That could work for a while.

Best regards
Andreas
