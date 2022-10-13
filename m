Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7342A5FD2AD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 03:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiJMBhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 21:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiJMBg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 21:36:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64571127BE2;
        Wed, 12 Oct 2022 18:36:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 005216166F;
        Thu, 13 Oct 2022 01:36:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED071C433C1;
        Thu, 13 Oct 2022 01:36:54 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="OvC9QjQ3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1665625013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=CdJNHtmpZMNfTRWGpsUKx/dxqK7UGMQPCI1rVsE6I7s=;
        b=OvC9QjQ3eMXC1bp5TmJ450iqLPVm3LyQhBpt7HOiZZPlH6xL3QkXRR6zSCF4S1yx4hNo2+
        mMYK2YPXvUbeqVHec5fXzr5JoNruYlL+IbYzwaMDSYP+rAZXkAu1AAsnbZudd+/a6vgEMj
        t7GWHjdRlFQfuGQ14tdfI3MqYxaiBxk=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6f9987c8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 13 Oct 2022 01:36:53 +0000 (UTC)
Received: by mail-ua1-f46.google.com with SMTP id x20so238201ual.6;
        Wed, 12 Oct 2022 18:36:53 -0700 (PDT)
X-Gm-Message-State: ACrzQf31etQBqMuCfp3YA4+4O9kwNAFpz6l303gnY94QRaxfmKhpH76A
        qoEczDJqxCHfesVxng93czFSC9lmJAY2xpwb9SM=
X-Google-Smtp-Source: AMsMyM7ribEkLBQ9TJMxAiZGfVq5iMGx98cCy/+nya4OvvDKV6noD1SKxwLBTXN4tvI33pdHAjxnKgRyuBfsn+zPU30=
X-Received: by 2002:ab0:6413:0:b0:3e1:b113:2dfa with SMTP id
 x19-20020ab06413000000b003e1b1132dfamr12353897uao.102.1665625011875; Wed, 12
 Oct 2022 18:36:51 -0700 (PDT)
MIME-Version: 1.0
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 12 Oct 2022 19:36:40 -0600
X-Gmail-Original-Message-ID: <CAHmME9prBJHmo9Bw6aobuGLjtxLsjxKJ9wopOv5+BY6ZtuKaNg@mail.gmail.com>
Message-ID: <CAHmME9prBJHmo9Bw6aobuGLjtxLsjxKJ9wopOv5+BY6ZtuKaNg@mail.gmail.com>
Subject: gcc 5 & 6 & others already out of date?
To:     linux-toolchains@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been working on a (still in development) patch that tries to
apply a few compile-time constant folding tricks to a widely used
library function, so I wanted to make sure my trickery worked across
all supported gcc versions for as many call sites as possible.
Naturally, this means allyesconfig builds on the monster box.

So all went well with a recent gcc and with clang. Then I tried gcc 5
and gcc 6, and it wasn't fine. But it wasn't not fine because of my
new code -- that all compiled just fine. Rather, it wasn't fine
because of a modicum of other odd errors and fatal warnings
throughout. I tried this with gcc 5 and gcc 6 and then got bored. I
could test more versions need be. And I guess I could submit bug
reports or write patches or work on fixing all those, if I actually
cared about it. But I don't really care about it, and apparently
neither does anybody else, because this isn't brand new breakage. And
this all got me thinking...

Linus merged Rust for 6.1, and this relies on unstable features. We're
in for a world of pain, I'm sure, and who knows where this is going to
lead. But what seems clear is that as we figure out how to make Rust
work with the kernel (if we can manage to figure that out, that is),
we're going to likely be bumping the minimum compiler version as the
upstream Rust people implement things we need. And while Rust is used
for nothing today, soon it'll be used for things not exactly optional
for certain segments of users - for example, that Apple GPU driver.
The slow stable days of C are coming to an end, it would seem.

But also, it's not just Rust. Clang support has been an incremental
thing, and the kernel has dropped old Clang versions as they no longer
make sense. Heck, the new KCFI implementation requires bleeding edge
Clang, and the kernel dropped support for the old implementation. So
clearly, the people that use Clang want to use new Clang, not crusty
Clang, and that's sort of the whole point of that being there.

And then there's old trusty gcc. Gcc also improves according to a nice
cadence, and we know people are using later gccs because nobody is
catching the build errors from old gccs. So let's stop pretending we
support old compilers. We clearly don't. Maybe some subset of code
does, but by and large, I doubt many developers are actually daily
driving gcc 5.1 and doing allyesconfig builds with it. Yes, many are
rightfully cautious of gcc 12 and stick with gcc 11 still, and that's
reasonable, but 11 or even 10 is still way larger than 5.1.

The truth is, people tend to use more recent toolchains. And if Clang
hasn't broken the will of the stranglers, then surely Rust will.

So, what are your thoughts on just abandoning this charade all
together, and saying that we support the last 2 or 3 releases of a
compiler (and related toolchain - binutils and such) at the time of
the kernel's release, and admit that our C is a moving target, just as
our Rust inevitably will be. Then we don't have to have these tortured
conversations every few years about 4.9 or 5.1 or 6.3 or whatever
enterprise [il-]logic has tended to dictate how things have worked
until now.

As usual, feel free to chase me off with pitchforks. I'm sure some
RHEL folks hate this. But I think it's at least worth consideration.

Jason
