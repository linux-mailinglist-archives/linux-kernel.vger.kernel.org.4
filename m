Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1FA7244AA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 15:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237342AbjFFNkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 09:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbjFFNkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 09:40:11 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E1F10D5
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 06:40:08 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5149c51fd5bso9028016a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 06:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1686058807; x=1688650807;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=TuQcZTlYuJWIJGVGPX1FYC2vSGGbheUssDv1PYTz480=;
        b=fNAefN4HvEGREq3Sj+Jyz3LnUeHV+vla1j7XQncjRwj3KoQxgJgwcceR8EXnVTNIGo
         enEfS7FH5dVqCG/WHZeS7kFfm2RmDjy48dgBeFLD4ficFOEV4vEN8vKxRm/bFtfOkCwm
         cPpJrJCvXRIO7OKqxY/nLqZ8EuFDCihAmtsQcRikp//A3TBuNNw2MSo4ot1T8BfVQM7f
         A6FEgHOiN2EtH4eRWtd4dROi//SmekC/LngGNJ1xpqr/kdUGftuiU3W9aILIDHm06ud2
         JBvA+Kphoi8+iBUFf59KYKiBPaSMSOzPWheee0FLTZplWrgLlt/nHp/Fui8qs94sBpqZ
         52Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686058807; x=1688650807;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TuQcZTlYuJWIJGVGPX1FYC2vSGGbheUssDv1PYTz480=;
        b=QCbLnE4d5ZkgzC/QYxvTsseeb9ZxMlQAYET++cu26xw0ztbqFpAneltmrADh5UTEdq
         S5RwYSW4XkOkp96qaDnaw9Ipzf40a8KM+N6UJGZolxL8CwjBG2+icKFlyEV/H47gvxqF
         gcPeTa5z87xSEgrLyle2K2eJFlkSWYx3VYynKdZvK5DBQpEo36Tm/Qduqi/I96pxsF+w
         sVF6gDFgg7H2WqUk6CIuics5vU7Hq9pW/23WyJ2qbQE1LrHtv7YX+ja90YOp7pv8H+i8
         q9b7hIWrnqvbIEl97MpL6SMCdwDpJhzdmsXlLHcm4sbLp4J9YLswTFjgv6+pSeVV8pDk
         1juQ==
X-Gm-Message-State: AC+VfDwWf7Pe8kE+EM8L4P8yuOfZC7yphl6FLlYhBNLyHZU5Cp4yCi6A
        9fX8MQ1FwHzTOFaiON6GcKeFyw==
X-Google-Smtp-Source: ACHHUZ5XLO8axA40iII673EklfhmaEB/Gj3Fapwb9AgeUHHbXZrNug2Mh9mK2Elk+NrhZljQTGl33g==
X-Received: by 2002:aa7:d716:0:b0:514:a110:6bed with SMTP id t22-20020aa7d716000000b00514a1106bedmr2040587edq.27.1686058806617;
        Tue, 06 Jun 2023 06:40:06 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id r21-20020aa7c155000000b0051421010690sm4967093edp.21.2023.06.06.06.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 06:40:06 -0700 (PDT)
References: <20230503090708.2524310-1-nmi@metaspace.dk>
 <da7b815d-3da8-38e5-9b25-b9cfb6878293@acm.org>
 <87jzxot0jk.fsf@metaspace.dk>
 <b9a1c1b2-3baa-2cad-31ae-8b14e4ee5709@acm.org>
 <ZFP+8apHunCCMmOZ@kbusch-mbp.dhcp.thefacebook.com>
 <e7bc2155-613b-8904-9942-2e9615b0dc63@kernel.dk>
User-agent: mu4e 1.10.3; emacs 28.2.50
From:   "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>, rust-for-linux@vger.kernel.org,
        linux-block@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj?= =?utf-8?Q?=C3=B6rn?= Roy Baron 
        <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
        open list <linux-kernel@vger.kernel.org>, gost.dev@samsung.com,
        Matias =?utf-8?Q?Bj=C3=B8rling?= <Matias.Bjorling@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [RFC PATCH 00/11] Rust null block driver
Date:   Tue, 06 Jun 2023 15:33:44 +0200
In-reply-to: <e7bc2155-613b-8904-9942-2e9615b0dc63@kernel.dk>
Message-ID: <87ttvkaevf.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All,

I apologize for the lengthy email, but I have a lot of things to cover.

As some of you know, a goal of mine is to make it possible to write blk-mq
device drivers in Rust. The RFC patches I have sent to this list are the first
steps of making that goal a reality. They are a sample of the work I am doing.

My current plan of action is to provide a Rust API that allows implementation of
blk-mq device drives, along with a Rust implementation of null_blk to serve as a
reference implementation. This reference implementation will demonstrate how to
use the API.

I attended LSF in Vancouver a few weeks back where I led a discussion on the
topic. My goal for that session was to obtain input from the community on how to
upstream the work as it becomes more mature.

I received a lot of feedback, both during the session, in the hallway, and on
the mailing list. Ultimately, we did not achieve consensus on a path forward. I
will try to condense the key points raised by the community here. If anyone feel
their point is not contained below, please chime in.

Please note that I am paraphrasing the points below, they are not citations.

1) "Block layer community does not speak Rust and thus cannot review Rust patches"

   This work hinges on one of two things happening. Either block layer reviewers
   and maintainers eventually becoming fluent in Rust, or they accept code in
   their tree that are maintained by the "rust people". I very much would prefer
   the first option.

   I would suggest to use this work to facilitate gradual adoption of Rust. I
   understand that this will be a multi-year effort. By giving the community
   access to a Rust bindings specifically designed or the block layer, the block
   layer community will have a helpful reference to consult when investigating
   Rust.

   While the block community is getting up to speed in Rust, the Rust for Linux
   community is ready to conduct review of patches targeting the block layer.
   Until such a time where Rust code can be reviewed by block layer experts, the
   work could be gated behind an "EXPERIMENTAL" flag.

   Selection of the null_blk driver for a reference implementation to drive the
   Rust block API was not random. The null_blk driver is relatively simple and
   thus makes for a good platform to demonstrate the Rust API without having to
   deal with actual hardware.

   The null_blk driver is a piece of testing infrastructure that is not usually
   deployed in production environments, so people who are worried about Rust in
   general will not have to worry about their production environments being
   infested with Rust.

   Finally there have been suggestions both to replace and/or complement the
   existing C null_blk driver with the Rust version. I would suggest
   (eventually, not _now_) complementing the existing driver, since it can be
   very useful to benchmark and test the two drivers side by side.

2) "Having Rust bindings for the block layer in-tree is a burden for the
   maintainers"

   I believe we can integrate the bindings in a way so that any potential
   breakage in the Rust API does not impact current maintenance work.
   Maintainers and reviewers that do not wish to bother with Rust should be able
   to opt out. All Rust parts should be gated behind a default N kconfig option.
   With this scheme there should be very little inconvenience for current
   maintainers.

   I will take necessary steps to make sure block layer Rust bindings are always
   up to date with changes to kernel C API. I would run CI against

   - for-next of https://git.kernel.dk/linux.git
   - master of https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
   - mainline releases including RCs
   - stable and longterm kernels with queues applied
   - stable and longterm releases including RCs

   Samsung will provide resources to support this CI effort. Through this effort
   I will aim to minimize any inconvenience for maintainers.

3) "How will you detect breakage in the Rust API caused by changes to C code?"

   The way we call C code from Rust in the kernel guarantees that most changes
   to C APIs that are called by Rust code will cause a compile failure when
   building the kernel with Rust enabled. This includes changing C function
   argument names or types, and struct field names or types. Thus, we do not need
   to rely on symvers CRC calculation as suggested by James Bottomley at LSF.

   However, if the semantics of a kernel C function is changed without changing
   its name or signature, potential breakage will not be detected by the build
   system. To detect breakage resulting from this kind of change, we have to
   rely _on the same mechanics_ that maintainers of kernel C code are relying on
   today:

   - kunit tests
   - blktests
   - fstests
   - staying in the loop wrt changes in general

   We also have Rust support in Intel 0-day CI, although only compile tests for
   now.

4) "How will you prevent breakage in C code resulting from changes to Rust code"

   The way the Rust API is designed, existing C code is not going to be reliant
   on Rust code. If anything breaks just disable Rust and no Rust code will be
   built. Or disable block layer Rust code if you want to keep general Rust
   support. If Rust is disabled by default, nothing in the kernel should break
   because of Rust, if not explicitly enabled.

5) "Block drivers in general are not security sensitive because they are mostly
   privileged code and have limited user visible API"

   There are probably easier ways to exploit a Linux system than to target the
   block layer, although people are plugging in potentially malicious block
   devices all the time in the form of USB Mass Storage devices or CF cards.

   While memory safety is very relevant for preventing exploitable security
   vulnerabilities, it is also incredibly useful in preventing memory safety
   bugs in general. Fewer bugs means less risk of bugs leading to data
   corruption. It means less time spent on tracking down and fixing bugs, and
   less time spent reviewing bug fixes. It also means less time required to
   review patches in general, because reviewers do not have to review for memory
   safety issues.

   So while Rust has high merit in exposed and historically exploited
   subsystems, this does not mean that it has no merit in other subsystems.

6) "Other subsystems may benefit more from adopting Rust"

   While this might be true, it does not prevent the block subsystem from
   benefiting from adopting Rust (see 5).


7) "Do not waste time re-implementing null_blk, it is test infrastructure so
   memory safety does not matter. Why don't you do loop instead?"

   I strongly believe that memory safety is also relevant in test
   infrastructure. We waste time and energy fixing memory safety issues in our
   code, no matter if the code is test infrastructure or not. I refer to the
   statistics I posted to the list at an earlier date [3].

   Further, I think it is a benefit to all if the storage community can become
   fluent in Rust before any critical infrastructure is deployed using Rust.
   This is one reason that I switched my efforts to null_block and that I am not
   pushing Rust NVMe.

8) "Why don't you wait with this work until you have a driver for a new storage
   standard"

   Let's be proactive. I think it is important to iron out the details of the
   Rust API before we implement any potential new driver. When we eventually
   need to implement a driver for a future storage standard, the choice to do so
   in Rust should be easy. By making the API available ahead of time, we will be
   able to provide future developers with a stable implementation to choose
   from.

9) "You are a new face in our community. How do we know you will not disappear?"

   I recognize this consideration and I acknowledge that the community is trust
   based. Trust takes time to build. I can do little more than state that I
   intend to stay with my team at Samsung to take care of this project for many
   years to come. Samsung is behind this particular effort. In general Google
   and Microsoft are actively contributing to the wider Rust for Linux project.
   Perhaps that can be an indication that the project in general is not going
   away.

10) "How can I learn how to build the kernel with Rust enabled?"

    We have a guide in `Documentation/rust/quick-start.rst`. If that guide does
    not get you started, please reach out to us [1] and we will help you get
    started (and fix the documentation since it must not be good enough then).

11) "What if something catches fire and you are out of office?"

    If I am for some reason not responding to pings during a merge, please
    contact the Rust subsystem maintainer and the Rust for Linux list [2]. There
    are quite a few people capable of firefighting if it should ever become
    necessary.

12) "These patches are not ready yet, we should not accept them"

    They most definitely are _not_ ready, and I would not ask for them to be
    included at all in their current state. The RFC is meant to give a sample of
    the work that I am doing and to start this conversation. I would rather have
    this conversation preemptively. I did not intend to give the impression that
    the patches are in a finalized state at all.


With all this in mind I would suggest that we treat the Rust block layer API and
associated null block driver as an experiment. I would suggest that we merge it
in when it is ready, and we gate it behind an experimental kconfig option. If it
turns out that all your worst nightmares come true and it becomes an unbearable
load for maintainers, reviewers and contributors, it will be low effort remove
it again. I very much doubt this will be the case though.

Jens, Kieth, Christoph, Ming, I would kindly ask you to comment on my suggestion
for next steps, or perhaps suggest an alternate path. In general I would
appreciate any constructive feedback from the community.

[1] https://rust-for-linux.com/contact
[2] rust-for-linux@vger.kernel.org
[3] https://lore.kernel.org/all/87y1ofj5tt.fsf@metaspace.dk/

Best regards,
Andreas Hindborg
