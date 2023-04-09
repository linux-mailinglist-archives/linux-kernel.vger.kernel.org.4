Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E41D6DC04B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 16:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjDIOKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 10:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjDIOKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 10:10:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53703AA0;
        Sun,  9 Apr 2023 07:10:45 -0700 (PDT)
Received: from [IPv6:2804:14d:72b4:8284:32a8:8167:f815:2895] (unknown [IPv6:2804:14d:72b4:8284:32a8:8167:f815:2895])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dwlsalmeida)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9437E66020BC;
        Sun,  9 Apr 2023 15:10:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681049443;
        bh=0txPfh3mQOMDuJ+08xBvWsHJQq1bTzoilqnXMcIVR0w=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=EliufXZ0A0w2pwwFVoxncNEmmXebULH7xwC8CHk2LysxJsUrHC5qgh5IewIO+b2P4
         ICt0YISBFxn7DihYreR5+Fd4cvs119AjCJU61tUuCys5+5toIyZx0U7uHv13jxnDPe
         WjTlkHqyUxPfQxwjqBcv8ZhGA9japTg5xzwO+/iDtkBhGHi+Ke4Bf0szC9/WZeVYoL
         ZFaVLY0knzS/QImddsiSZwhybA6WTPm4fPARSi3vHQhwFlz/loRmB8499de6Bgt48A
         EzHHks9QUaZcos89WSzQBO32/HIceghnL0iWXzD9LJ72fCVW4g2h6pzX0CXE7i4DoY
         GsEX+ObcibCBw==
Message-ID: <0ec4becd05c49e8f0bf214fbd62208ea67c2b4c3.camel@collabora.com>
Subject: Re: [PATCH 0/6] Initial Rust V4L2 support
From:   Daniel Almeida <daniel.almeida@collabora.com>
To:     Hans Petter Selasky <hps@selasky.org>, wedsonaf@gmail.com,
        ojeda@kernel.org, mchehab@kernel.org, hverkuil@xs4all.nl
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, kernel@collabora.com
Date:   Sun, 09 Apr 2023 11:10:28 -0300
In-Reply-To: <441a96cb-7dd1-0885-df64-933ebdb55e9e@selasky.org>
References: <20230406215615.122099-1-daniel.almeida@collabora.com>
         <441a96cb-7dd1-0885-df64-933ebdb55e9e@selasky.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans! Thank you for chiming in!

There's a few things in your email that I disagree with and that I'd
like to
address.

> I think V4L2 should be written in primarily one language.

It is, in C. This series is about adding *bindings* to write *drivers*
in Rust
*for those interested*. The v4l2 core remains untouched, and I don't
think there
are any plans to introduce Rust outside of drivers in the kernel at
all, last I
heard.

> You assume that all code is running inside the kernel and needs to be
perfect.

No I do not assume that. In fact, Rust code is absolutely not
guaranteed to be
bug free and definitely not "perfect".

On the other hand, I would take Rust over C any day. Thus I am
contributing some
of the infrastructure to make this possible for me and for others.

IMHO I think you're approaching this from the wrong angle. It isn't
that Linux
*needs* Rust. It's more about providing a new and safer choice with
modern ergonomics for developers, is all.

> I would rather like more drive on that, than flowing down the Rust
stream.

These two things are not mutually exclusive :)

> Rust is cool, Java is cool, VM's are cool.

I don't see why Java and virtual machines are being brought into the
discussion
for this patchset here. And compilation times are a part of life,
sadly. Also,
can you substantiate your claim that Rust is slow?

> Engineering energy would be much more focused, if hardware vendors
could agree
more about what binary formats to use for their device protocols,

I understand, but my patchset is not to blame here. In fact, I have no
say at
all over these things.

> than changing the coding language

This simply is not what is happening here. Again this is about giving
kernel
developers another *option* of programming language, not about ditching
C.

> that now anyone can be let loose to program in the Linux kernel
without
risking any damage

Who's "anyone"? Plus the review process stays in place, so hardly any
changes to
code quality here.

> I'm glad if not everyone out there can do my job writing C-code for
device
drivers. We don't need more people to mess around there  simply.

Ok we differ strongly here. In particular, I am totally neutral to your
first
statement.

The reality is that it isn't up to anyone to say who should or
shouldn't become
a kernel developer. The resources are out there for anyone to try, and
if
maintainers take in their patches, then that's the end of the story.

-- Daniel
