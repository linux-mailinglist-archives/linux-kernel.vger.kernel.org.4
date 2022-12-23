Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3CA76553C8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 20:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbiLWTHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 14:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiLWTHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 14:07:22 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551411B9E5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 11:07:21 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id h21so4363619qta.12
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 11:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HGw9oRroFvPZ2dyQcKWKF0FY4soMbEIhC7lZPLQhPjY=;
        b=HmlyjN0EM9c5k+W/8twiDyNwtL4iIkEk+itfoYVQWrXjlJAflSsOolovl+8prOU0XE
         l3/x47GBmfyqzrLb1Cp1GyaQU9sS4GHbnvznDR+Yx/j6IjI+4xIgzdLttkx2R/RRrQfv
         7cm4SVHqjoc5mTYMdO646JC/I8jyHL7Ryehsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HGw9oRroFvPZ2dyQcKWKF0FY4soMbEIhC7lZPLQhPjY=;
        b=R5fYHgTH7sBYHhSHqlh9LNA+k3STDNB9owIcEGK3SaMYjHI3atnHKihiULWBf8yUs7
         v+LDVsHlxwPcaUkq8jYbXlWnacPBe4wJXVIikgsvdN1EDcpFk9hV5v2apySm+rXFCDIG
         gBL5D72nccpVkDV2wPxp6uPmn2LLr1UYtUwE849HDZapIVfVVdwd+3T2xtaxfdnpZU8h
         KS3v6eBWUO+ZygA0bTLgccRU1PiARBwZwfvLhEMJRb31f7ev8ifwcewy26W746w0WzEE
         SGeenD2yMbXgfAjDkLnsi+m9GidREANrcrQ6GMAwYsWfNWay/JWN9D0N1uUUzJbvoZox
         HmKQ==
X-Gm-Message-State: AFqh2krxfqilZ/UgJtfHWo4UoB+pf8KCUuHZeDmWCmlVlS0yK4CBv5n7
        xtTknKfwuPY4v7jIPcr1b92v3jOz7Hfqn9j2
X-Google-Smtp-Source: AMrXdXsNIJ27gcGUJjSHPi0lb0G0YSPwsQk0fh9OLEcMQo62S7lg6g/UV5lKpvrItGQljyQdmhOfSw==
X-Received: by 2002:a05:622a:991:b0:3a9:7ce2:4c53 with SMTP id bw17-20020a05622a099100b003a97ce24c53mr14558822qtb.51.1671822440106;
        Fri, 23 Dec 2022 11:07:20 -0800 (PST)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com. [209.85.222.170])
        by smtp.gmail.com with ESMTPSA id l8-20020a37f908000000b006fcab4da037sm2735000qkj.39.2022.12.23.11.07.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 11:07:19 -0800 (PST)
Received: by mail-qk1-f170.google.com with SMTP id c9so2754039qko.6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 11:07:19 -0800 (PST)
X-Received: by 2002:a05:620a:1379:b0:6fc:c48b:8eab with SMTP id
 d25-20020a05620a137900b006fcc48b8eabmr347377qkl.216.1671822438709; Fri, 23
 Dec 2022 11:07:18 -0800 (PST)
MIME-Version: 1.0
References: <Y5uprmSmSfYechX2@yury-laptop> <CAHk-=wj_4xsWxLqPvkCV6eOJt7quXS8DyXn3zWw3W94wN=6yig@mail.gmail.com>
In-Reply-To: <CAHk-=wj_4xsWxLqPvkCV6eOJt7quXS8DyXn3zWw3W94wN=6yig@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 23 Dec 2022 11:07:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgrzisX2_MCcw3Qqa0J3d7mL14aab9F0JkjGF=VfAk5Ow@mail.gmail.com>
Message-ID: <CAHk-=wgrzisX2_MCcw3Qqa0J3d7mL14aab9F0JkjGF=VfAk5Ow@mail.gmail.com>
Subject: Re: [GIT PULL] bitmap changes for v6.2-rc1
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Tariq Toukan <tariqt@nvidia.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 10:44 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Honestly, in this case, I think the logical thing to do is "check that
> the upper bits are the same". The way you do that is probably
> something like
>
>    !((off) ^ ((nbits)-1) & ~(BITS_PER_LONG-1))

Note that while the above is probably correct (but you always need to
double-check my emailed "something like this" code - I literally write
it in the MUA, and I make mistakes too), I'd never want to see that as
part of one big complex macro.

In fact, I think I am missing a set of parentheses, because '&' has a
higher precedence than '^', so the above is actually buggy.

So I'd much rather see something like this

  #define COMPILE_TIME_TRUE(x) (__builtin_constant_p(x) && (x))

  #define bits_in_same_word(x,y) \
        (!(((x)^(y))&~(BITS_PER_LONG-1)))

  #define bitmap_off_in_last_word(nbits,off) \
        bits_in_same_word((nbits)-1,off)

  #define small_const_nbits_off(nbits, off) \
        (__builtin_constant_p(nbits) && (nbits) > 0 && \
         COMPILE_TIME_TRUE(bitmap_off_in_last_word(nbits,off)))

where each step does one thing and one thing only, and you don't have
one complicated thing that is hard to read.

And again, don't take my word blindly for the above.  I *think* the
above may be correct, but there's a "think" and a "may" there.

Plus I'd still like to hear about where the above would actually
matter and make a code generation difference in real life (compared to
just the simple "optimize the single-word bitmap" case).

                Linus
