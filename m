Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C55690E6C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 17:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjBIQgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 11:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjBIQgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 11:36:39 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BB860BB7
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 08:36:28 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id m2so3426328plg.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 08:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iY3uRKwhFfCWuwUwhi+08QCo3PpICPwRsioQ65qL5sg=;
        b=VI20u5uoBpf9UK7HeP3X9PWxRHyYcNmwbb70VwajQqkf4A/TbhP6zN+pvbSViyerKA
         Yr9iXGCl7HIacfWhBmqh2+4DF8/Ynp80GNmeuI8c+OQLWyp7l8FJO1Wj/+yOEgHd8tvy
         k6eMTzJRNmQ6iIt+i8IZUyQ2im7k/0F+EqUio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iY3uRKwhFfCWuwUwhi+08QCo3PpICPwRsioQ65qL5sg=;
        b=xoou8j0BQ/Z65jB5qw/lcW81V1ttjEaIWsKF4ro0a3GuOvT1/NimM+sFZwhn+33jgD
         Sc4t/BIT0uaMo4oLC60/HmLqtWc0b1TYsAc1940rmRw/A3fw38OFX6X7S8F0KZqtMSlE
         WX/5MxCm7yU39qwze6ADvMEXwEAW1QD4+pkJwOenINL0oDbmIrCjqpm9KxH/Du6PkZRb
         /dNhJH0Xj08dYZCFFesrNoRUGXqsp70sbqW6l0D5L2juqtwu1EY/ZKHs2dJqikWKc2ch
         me5FQx8lfRa6sVegaLWsj/GKRC5NxXbjLtF6GO/SHTPva84nqBPN+TIZBnl/5pO1ObHm
         cUeA==
X-Gm-Message-State: AO0yUKVHol6BWehato93pgqzO16hQBVdy5wjie2R6BlLCJpvuNmMGxjM
        jAx5GmhPbaoSyFTuvNKXJk2tKg==
X-Google-Smtp-Source: AK7set8ois8OCnNC4k8umzsF3UAu3C8IbTzhjMPobTuOdqwAaSOkMwrUfCZEAH0rWkAprUP6HYjgIA==
X-Received: by 2002:a17:90b:3ece:b0:22c:5241:b8e with SMTP id rm14-20020a17090b3ece00b0022c52410b8emr13839260pjb.25.1675960588110;
        Thu, 09 Feb 2023 08:36:28 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i10-20020a63bf4a000000b004fadb547d0csm1498660pgo.61.2023.02.09.08.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 08:36:27 -0800 (PST)
Message-ID: <63e5210b.630a0220.c17be.27ff@mx.google.com>
X-Google-Original-Message-ID: <202302090821.@keescook>
Date:   Thu, 9 Feb 2023 08:36:27 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Haowen Bai <baihaowen@meizu.com>, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] bpf: Replace bpf_lpm_trie_key 0-length array with
 flexible array
References: <20230204183241.never.481-kees@kernel.org>
 <CAKH8qBvqLeR3Wsbpb-v=EUY=Bw0jCP2OAaBn4tOqGmA1AqBZbA@mail.gmail.com>
 <63e14abb.170a0220.ca425.b7bc@mx.google.com>
 <CAKH8qBtX0HU4_YtnZ3hU4NhGHSQ9VU70niXFFoqf3k67a1+6aA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKH8qBtX0HU4_YtnZ3hU4NhGHSQ9VU70niXFFoqf3k67a1+6aA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 11:17:06AM -0800, Stanislav Fomichev wrote:
> It's my understanding that it's the intended use-case. Users are
> expected to use this struct as a header; at least we've been using it
> that way :-)
> 
> For me, both return the same:
> sizeof(struct { __u32 prefix; __u8 data[0]; })
> sizeof(struct { __u32 prefix; __u8 data[]; })
> 
> So let's do s/data[0]/data[]/ in the UAPI only? What's wrong with
> using this struct as a header?

For the whole struct, yup, the above sizeof()s are correct. However:

sizeof(foo->data) == 0             // when data[0]
sizeof(foo->data) == compile error // when data[]

The [0]-array GNU extension doesn't have consistent behavior, so it's
being removed from the kernel in favor of the proper C99 [] flexible
arrays, so we can enable -fstrict-flex-arrays=3 to remove all the
ambiguities with array bounds:
https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays
https://people.kernel.org/kees/bounded-flexible-arrays-in-c

As a header, this kind of overlap isn't well supported. Clang already
warns, and GCC is going to be removing support for overlapping composite
structs with a flex array in the middle (and also warns under -pedantic):
https://godbolt.org/z/vWzqs41h6

I talk about dealing with these specific cases in my recent write-up
on array bounds checking -- see "Overlapping composite structure members"
in the people.kernel.org post above.

> > Perhaps better might be:
> >
> > struct bpf_lpm_trie_key {
> >     __u32   prefixlen;      /* up to 32 for AF_INET, 128 for AF_INET6 */
> > };
> >
> > struct bpf_lpm_trie_key_raw {
> >     struct bpf_lpm_trie_key_prefix prefix;
> >     u8 data[];
> > };
> >
> > struct my_key {
> >     struct bpf_lpm_trie_key_prefix prefix;
> >     int a, b, c;
> > };

This approach is, perhaps, the best way to go? Besides the selftest,
what things in userspace consumes struct bpf_lpm_trie_key?

-- 
Kees Cook
