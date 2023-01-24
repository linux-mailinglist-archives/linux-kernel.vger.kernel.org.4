Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEAF679F53
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 17:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbjAXQ6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 11:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234190AbjAXQ6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 11:58:51 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D48E46081
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 08:58:46 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id i12so12095652qvs.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 08:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LbOONuw6RPWIgaQHwfPrvs8O97aYKf4cLTPS9ZXxpgE=;
        b=hEFovQF5/8q23sY2/vqlJvUP+rO0V+gvh48kiryIs2DQT9QUrZ5XzxWmJTGkw/3twg
         w+3ZO4FbOU3wuCQb5JF57jAR07cjcSpXvAcSUxrL8kUHIJnH+Gb3KePJBRtOWSf4O4lj
         eEIsPj6sTNERTJjqLpYpL9Wm88t32OpeM7H4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LbOONuw6RPWIgaQHwfPrvs8O97aYKf4cLTPS9ZXxpgE=;
        b=sbx0OuZUfgZdJ5837p0n2WuZWe7TKGe9duMrMak4NHpLRnf1NEtE1I6xkXmWEX7y+T
         8vXrbRtJJtHfwMnmSFRmj22H0BfmwZmpL+GyPSxkfaYfnr+wLRcOjio2daFnF3RUzoP8
         FnCNmIS+qY2Cm4/K5YGIBnVr//N1szVGJ/vq8L7d4qClGN+gQquHD74x8I3bCus/sbuZ
         iA3H/zQM3Pbsy5R+aDBKZVFZ3jMdAghZUE6ec07j6nDOqcCagpAYuRPeZUvjGHFNI13+
         6JqKJTsBFItL2xQ8Mjm9mF+5V/vkJsMYptvOYVGdW90eIS71J9gkYH1lwA06RB6kgial
         WEog==
X-Gm-Message-State: AFqh2koJSf3eGhn6QzwA4Hz8/lppMNzamTFeZAIuKLTPn5wYav9XHGry
        GwWgjJJNGa6GYy/fKTZPgHWsxcaZJ8yampyl
X-Google-Smtp-Source: AMrXdXvUi0NPhtatxG9odJG6Yf4T+P6IUxxg/IQvczapLbpXGgVx5QRFX5X8dD5dRfslxcRHdaDv0g==
X-Received: by 2002:ad4:4d07:0:b0:535:3029:9516 with SMTP id l7-20020ad44d07000000b0053530299516mr39519657qvl.27.1674579525388;
        Tue, 24 Jan 2023 08:58:45 -0800 (PST)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com. [209.85.222.171])
        by smtp.gmail.com with ESMTPSA id a131-20020ae9e889000000b007090cad77c1sm1790405qkg.3.2023.01.24.08.58.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 08:58:44 -0800 (PST)
Received: by mail-qk1-f171.google.com with SMTP id f23so6096429qkg.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 08:58:44 -0800 (PST)
X-Received: by 2002:a05:620a:144a:b0:6ff:cbda:a128 with SMTP id
 i10-20020a05620a144a00b006ffcbdaa128mr1505201qkl.697.1674579524545; Tue, 24
 Jan 2023 08:58:44 -0800 (PST)
MIME-Version: 1.0
References: <20230118150703.4024-1-ubizjak@gmail.com> <20230118131825.c6daea81ea1e2dc6aa014f38@linux-foundation.org>
 <CAFULd4ZQGG+N3f7xDuoiNG1jY128pqaH0F4eLKO+fhvSNAbKfA@mail.gmail.com>
 <CAFULd4b5szcTHTVbGJ9WiciG_+8kANiPZYP_pkEZUhnz_HHy-g@mail.gmail.com>
 <913c01d41f824fa8b3400384437fa0d8@AcuMS.aculab.com> <CAFULd4aDORSrq7zf_LcAZRP8HOHcrq2-rGMaroKyG2zQDHNpOA@mail.gmail.com>
 <CAGudoHF6zbyzza6xysuCjcxjHAUgeAVvgW0sqxDAFQNwz9u7wg@mail.gmail.com>
 <CAHk-=whUSZk1dZrJuhxeb4qB3POstVRwOZCN8PXd3W7ztbqQBg@mail.gmail.com>
 <CAGudoHH+SmRoyXvppjBEoK=dvVdy1jvKNHDLEVf9mLnzsEds6Q@mail.gmail.com> <7d506ede564d425db116ff646f267f4f@AcuMS.aculab.com>
In-Reply-To: <7d506ede564d425db116ff646f267f4f@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Jan 2023 08:58:28 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiqpD6F0ript8y29X_ijwsBmK_ZDVy_bOBMPr2zb09B5A@mail.gmail.com>
Message-ID: <CAHk-=wiqpD6F0ript8y29X_ijwsBmK_ZDVy_bOBMPr2zb09B5A@mail.gmail.com>
Subject: Re: [PATCH] lib/genalloc: use try_cmpxchg in {set,clear}_bits_ll
To:     David Laight <David.Laight@aculab.com>
Cc:     Mateusz Guzik <mjguzik@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Uros Bizjak <ubizjak@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Tue, Jan 24, 2023 at 12:54 AM David Laight <David.Laight@aculab.com> wrote:
>
> I remember looking at syscall counts during a (NetBSD) build
> and deciding that the dominant system call was actually failed
> opens from the compiler searching long -I paths looking for
> headers.

For some loads, yes.

> You can speed things up by copying all the .h files from the
> fixed -I path list into a single directory.

Or, better yet, do a proper pathname cache that has negative entries
in it too. Like Linux does.

Because it's a common pattern, not just for include paths. You find it
for the regular PATH handling, and for various "look up my config file
in these directories" kind of thing.

So caching not just successful pathname lookups, but the failed ones
too, is actually important.

(Obviously it's still faster to not have to even search at all, and
put everything in one directory and not have a search path at all, but
it does have its own serious downsides, notably the whole "now we have
to keep that union directory in sync with all the source directories")

               Linus
