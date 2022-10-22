Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E19608EDC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 19:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiJVRyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 13:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiJVRyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 13:54:06 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318E9193EED
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 10:54:01 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id a5so3934094qkl.6
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 10:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rgLpFIIE2aPgmTNZinvyigEE7kGZEoRibGl5oSMNQ84=;
        b=J/lkd67149Vhqhufch337lcLPNf/88EFFoIaF3DdnYH/DQ8/ECfW2s1cw1jdx5SpAX
         HCvYU0u+W4Nwm/zpNIufOTFsC3jTxdqLQ3psztUzbTW7+mpUqP/ChqUYt2lO/YDsE4ly
         WYlFFNbWB+KMXFaWZgL7KKZiKQa7z06LxPjnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rgLpFIIE2aPgmTNZinvyigEE7kGZEoRibGl5oSMNQ84=;
        b=JO4otMV70H14RSlY4NLkdRdhuha06BJ7O7MJwoQjiGOoi78HJUqOILZlf4vaL64IX+
         cDxNJW+m+KOcjGtKBszsq9g/vC0UHe+ULqaTxEZkeB5q2ht2Yj2aItMX4r2/Dwqz0LKU
         njLQ1VR0U2wtuwtg9DHCSiEGsio+6Nfb0jhdSYHHlm2VfKlhFxXnTyVvQnGPEjnGjpT7
         gY8OhqCxG9ZiFOItFO1QE+/VviVIUjFK49DQy6tOXWelasFUL1xCsFWfjbzKMug+YVHB
         Y+qAy0flfcbIVzPXOoqjBD8aiu6wqPnEUaqY67IHFzSjjr+0NLrtk3qthwFdbKF9YrUr
         I+xA==
X-Gm-Message-State: ACrzQf0wILmO3EqqIFvn9AfrLVWlS+raO5+WKnCpL6l+xtmAjikTYfpB
        WlY3Jz27Nq0wpeC98aHc8tk3rysp+5MEvA==
X-Google-Smtp-Source: AMsMyM4xEOjGj+fdzAmxx1C7fZkn4mxpxQwLbnY77cBli2kGeRLP/r2DXx6nv6J/Xf4ej6kezo3CXQ==
X-Received: by 2002:a05:620a:2697:b0:6cf:33cd:2bd2 with SMTP id c23-20020a05620a269700b006cf33cd2bd2mr17917321qkp.341.1666461239916;
        Sat, 22 Oct 2022 10:53:59 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id bj41-20020a05620a192900b006bb29d932e1sm11745825qkb.105.2022.10.22.10.53.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Oct 2022 10:53:58 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-367b8adf788so51881557b3.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 10:53:58 -0700 (PDT)
X-Received: by 2002:a81:555:0:b0:36b:2d71:5861 with SMTP id
 82-20020a810555000000b0036b2d715861mr3070116ywf.340.1666461237942; Sat, 22
 Oct 2022 10:53:57 -0700 (PDT)
MIME-Version: 1.0
References: <20221022111403.531902164@infradead.org> <20221022114425.103392961@infradead.org>
In-Reply-To: <20221022114425.103392961@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 22 Oct 2022 10:53:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh6ip4AVqGx6kB9aHN07pR3M4htTTq1n=M7skPaudpM-Q@mail.gmail.com>
Message-ID: <CAHk-=wh6ip4AVqGx6kB9aHN07pR3M4htTTq1n=M7skPaudpM-Q@mail.gmail.com>
Subject: Re: [PATCH 10/13] x86/mm/pae: Be consistent with pXXp_get_and_clear()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, willy@infradead.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        aarcange@redhat.com, kirill.shutemov@linux.intel.com,
        jroedel@suse.de, ubizjak@gmail.com
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

On Sat, Oct 22, 2022 at 4:48 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> +
> +#define pxx_xchg64(_pxx, _ptr, _val) ({                                        \
> +       _pxx##val_t *_p = (_pxx##val_t *)_ptr;                          \
> +       _pxx##val_t _o = *_p;                                           \
> +       do { } while (!try_cmpxchg64(_p, &_o, (_val)));                 \
> +       native_make_##_pxx(_o);                                         \
> +})

I think this could just be a "xchp64()", but if the pte/pmd code is
the only thing that actually wants this on 32-bit architectures, I'm
certainly ok with making it be specific to just this code, and calling
it "pxx_xchg()".

I wonder if there's some driver somewhere that wanted to use it, but
just made it be

        depends on CONFIG_64BIT

instead, or made it use a cmpxchg64() loop because a plain xchg() didn't work.

I guess it really doesn't matter, with 32-bit being relegated to
legacy status anyway. No need to try to expand usage.

                 Linus
