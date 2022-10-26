Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55EDE60E6E6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 20:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbiJZSAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 14:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbiJZR77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 13:59:59 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981042C136
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 10:59:58 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id s17so11169068qkj.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 10:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FdjMq+OruUc1iTJ3+M9i/kdhcLL8+ph+4KJj2UhjBas=;
        b=H5yO0pRlMjZB19QLz9qUOfkIeAOCLmFjPQ0ClV0DxojX0NbRE511O5hXRaITBMJMri
         TGRGksDxNVLoJOvbcXdJ+aKBhN+Gb21Dit7/lt3jy+TfrUv6clTEpI8oGpmQOC9xz/xX
         5v6bfHKG18KXBxyh3IXc9EACQaeu3PqrEOoG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FdjMq+OruUc1iTJ3+M9i/kdhcLL8+ph+4KJj2UhjBas=;
        b=MKxCPO1z5+3Wj+gLYjnsc2IWi1Xgf5xXsboWukiyKjyE24nnekCP9DL/TDBD9c29EJ
         d0vREIq/205Q8UWZsUTtfPQg+oiqwmBz5Y6LCFeaw4xOR5Q7bpQYulOrBEloutZmViR0
         kAcRVdQoiPZ7EUWCT3o0xmNg4U6kC9J0bifKb+lIS57B2WiWEcY3evPu31rvQqI2wC7b
         2SSeV+/LI2YtwrNiECecm6mVMpYFly9dM7+InBkhwu3SYcPOR+tA4cR9v7rYdObctfOY
         jObqYSzVT824ZecQvj1unZmfA8oh5kwB/PMm4+cFYFvoLwsXtb/GVllR2UW/KJnqwiIX
         uNgQ==
X-Gm-Message-State: ACrzQf32dfoxwKHI/ok2OSWy7x17gjmBncSQ/XbIUIraS9I7pLBXh8gG
        iLH+82tDoY2N51r9p2XoPTzroq+edeK7OA==
X-Google-Smtp-Source: AMsMyM4gYTnfLtfJ++bTmZl+fBeESkDINVf82ziRt04+wKhwUBKNTC2D+ODQLs7WercrP19PnRhZfg==
X-Received: by 2002:ac8:5706:0:b0:39d:322:7c36 with SMTP id 6-20020ac85706000000b0039d03227c36mr32251303qtw.632.1666807187019;
        Wed, 26 Oct 2022 10:59:47 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id n12-20020a05620a294c00b006b8e63dfffbsm4374170qkp.58.2022.10.26.10.59.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 10:59:46 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id o70so19942781yba.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 10:59:46 -0700 (PDT)
X-Received: by 2002:a25:bb44:0:b0:6bb:a336:7762 with SMTP id
 b4-20020a25bb44000000b006bba3367762mr39267532ybk.501.1666807185678; Wed, 26
 Oct 2022 10:59:45 -0700 (PDT)
MIME-Version: 1.0
References: <20221025200656.951281799@infradead.org> <CAHk-=wjBn=jThQ4drqgorDQFR3i2QUi9PeOG1tH2uWVkN8+6mQ@mail.gmail.com>
 <Y1jek64pXOsougmz@hirez.programming.kicks-ass.net>
In-Reply-To: <Y1jek64pXOsougmz@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 26 Oct 2022 10:59:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjaoB+9pJ1ouLbKuqgadqDxdhyCHi0rO-u-5bOi1qUv=w@mail.gmail.com>
Message-ID: <CAHk-=wjaoB+9pJ1ouLbKuqgadqDxdhyCHi0rO-u-5bOi1qUv=w@mail.gmail.com>
Subject: Re: [PATCH 0/5] x86/ftrace: Cure boot time W+X mapping
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rostedt@goodmis.org, dave.hansen@intel.com,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        keescook@chromium.org, seanjc@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 12:15 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Right, and we have it all over the place. Something like the below
> perhaps? I'll feed it to the robots, see if something breaks.

I was nodding along with the patches like this:

> -       set_memory_ro(base, pages);
> -       set_memory_x(base, pages);
> +       set_memory_rox(base, pages);

but then I got to this part:

> +static inline int set_memory_rox(unsigned long addr, int numpages)
> +{
> +       int ret = set_memory_ro(addr, numpages);
> +       if (ret)
> +               return ret;
> +       return set_memory_x(addr, numpages);
> +}

and that's when I went "no, I really meant make it one single call".

set_memory_ro() and set_memory_x() basically end up doing the exact
same thing, just with different bits.  So it's not only silly to have
the callers do two different calls, it's silly to have the
*implementation* do two different scans of the page tables and page
merging/splitting.

I think in the case of x86, the set_memory_rox() function would
basically just be

    int set_memory_rox(unsigned long addr, int numpages)
    {
        pgprot_t clr = __pgprot(_PAGE_RW);
        pgprot_t set = { 0 };

        if (__supported_pte_mask & _PAGE_NX)
                set.pgprot |= _PAGE_NX;

        return change_page_attr_set_clr(&addr, numpages, set, clr, 0, NULL);
    }

or something close to that. (NOTE! The above was cobbled together in
the MUA, hasn't seen a compiler much less been booted, and might be
completely broken for some reason - it's meant to be the concept, not
some kind of final word).

IOW, the whole "set_rox" is really just a _single_
change_page_attr_set_clr() call.

Maybe you meant to do that, and this patch was just prep-work for the
arch code being the second stage?

                  Linus
