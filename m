Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A2E69EB7C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 00:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjBUXxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 18:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjBUXxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 18:53:05 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00619EDB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 15:53:03 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677023582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mIO1r/3ZO0mEIHPOBsExgUVNpkwixfQnURK9KwDNb6s=;
        b=f8IFJUhnwIKLQZXUSoYTYqrz5trH9We+5C9XHZOGIMlTpCjI2z8ArQG8NdDT0T7VHwseXW
        rvzczwm8G3SazKVimlp3Ly40NMK+KwcZuXJw5aBYTAepOOV6uhuH5WzDzG3xtZf6j9IV8Z
        pURQWvXv3sLhlvxaGXXAgVBcubBckCjQ4S3av6ACpvT8ffjM8TpDXQ3FDzg+ME2YqxG/WB
        NlqkEc7ZoTNYiuXEYDNwYGucpjZfk4gZqEOPZz+rJN/yqQkM9nzsfUiWF1BUBfNGR8cl+z
        qy074ydC+I3lzsEVjnXT+j+7cQbeSEWcUS4vWs5mOyV25eK057b23UR+4dF0NA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677023582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mIO1r/3ZO0mEIHPOBsExgUVNpkwixfQnURK9KwDNb6s=;
        b=tJQM1+rKZv8XNNBu/gMWEWOBSkHqPNzhHJylukMoaapJItXymlnKOI4dtfoFScLZaR3ZGi
        thyG0QeK0wyutHCQ==
To:     Rob Landley <rob@landley.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: [PATCH 4/5] Replace timeconst.bc with mktimeconst.c
In-Reply-To: <9b8ce4db-9e1b-32b6-f749-94e4decc032e@landley.net>
References: <b455394f-9faa-1f1a-f171-0b9d5e9ada35@landley.net>
 <9b8ce4db-9e1b-32b6-f749-94e4decc032e@landley.net>
Date:   Wed, 22 Feb 2023 00:53:01 +0100
Message-ID: <87ttzemv8i.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URI_DOTEDU autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob!

On Tue, Feb 21 2023 at 15:00, Rob Landley wrote:

See my previous comment about Documentation. This time you even failed
to CC the maintainer of this code.

> Update of my decade-old patch replacing timeconst.pl with mktimeconst.c,
> still removing the only user of "bc" from the build.

How is 'decade-old patch' relevant changelog information?

> All that's changed since the 2015 version at:
> https://github.com/landley/aboriginal/blob/master/sources/patches/linux-noperl-timeconst.patch

That's neither interesting.

> Is one extra iteration of the loop for nanoseconds and different
> makefile plumbing calling it. In theory this could calculate the values
> at runtime in a small _init function and eliminate the header or even
> allow HZ to change at runtime.

In theory we can also build a compiler into the decompressor which
compiles and bootstraps the kernel itself, right?

> See https://lkml.iu.edu/hypermail/linux/kernel/2211.0/02589.html

I haven't seen a changelog in a while, which provides so much useless
information and lacks any content which justifies and documents the
proposed change.

>  Kbuild                    |   7 ++-
>  kernel/time/mktimeconst.c | 111 ++++++++++++++++++++++++++++++++++++
>  kernel/time/timeconst.bc  | 117 --------------------------------------

Clearly you provided evidence that the output of both tools is identical
and because you decided to reorder the defines it's not even verifyable
with diff.

But I don't even need diff to figure out that the results are not
identical:

# grep -c '#define' orig.h
25

# grep -c '#define' patched.h
31

Which means this adds 6 more unused defines to the already 8 unused
defines of today.

You clearly spent a lot of time to make this palatable to the people who
are responsible for this code.

That said, I'm not completely opposed to get rid of the bc dependency,
but if you want to sell this, then follow the documented process and
present it in a form which is acceptable.

Thanks,

        tglx




