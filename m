Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C020F64E3EA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 23:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiLOWqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 17:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbiLOWqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 17:46:31 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DAA0220E4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 14:46:29 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id x11so1331867qtv.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 14:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yG7CWxgnmFapxSwiEWZU7V75Q9bqIEk9Q2YCrzpf+Co=;
        b=fKCR7wrtRTfy5li6KCXae77RJavCttXS7kQAVH2WO6uSBQXlpHwoLLm1Yb4uv/iyNN
         +ylEqKytU52wFa+/UglFkUZ/vVH8SJf19yx0PGj7oRoOuuFRt6W6FYQQlKBanq3dbYou
         iYiXHEeGRD8eTksmv5q3l8vqcF0m4IBsAL9Qk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yG7CWxgnmFapxSwiEWZU7V75Q9bqIEk9Q2YCrzpf+Co=;
        b=BEwOBgkjf9HldC5xQls6fhU+XZxo9r75oH2FxaEVydG3wA0szNcJ6YUiytqG0jqcti
         pThreZcSCC7QaFs18AsQCoo1TKmLiA28dnxivne4R+lCIlzXuKkVeRAZW45BQpBW9yBo
         x7GY2jOYo1OEwvsUi2wS3RVgDBaC17ShxkdRjCM8eoEdmT86UtiyWAutzTURnZsoyxnm
         5Z6gG2aPaCk4pH+/8k4xd3gdpfpLAkqNfIJH467ad9IBE6Rcch/XFIjs+kBTfIL8C4Bd
         ZzA9fjWFtw4dgkjWcG05UyqVtdBgBvXaks9C8VHq4WsiOFXmJ94eFDDnPtNEeIuyDdET
         67XA==
X-Gm-Message-State: AFqh2kr+PWPOVTF3vLwLJW0eBsfoZRiu35yjoLFrk+Vof4kLI2YpPbfY
        uO5QOeUVph+sPHI2fKFTjnboh7w1WLwkJYUW
X-Google-Smtp-Source: AMrXdXsegUacFTXWFmQb5ZPa2Qrfj/LazxdG+xhhd9KswyzBykANNDDhilelPHZs7yKbnzUMV+VTeg==
X-Received: by 2002:ac8:4b6a:0:b0:3a8:123a:b549 with SMTP id g10-20020ac84b6a000000b003a8123ab549mr961880qts.46.1671144388410;
        Thu, 15 Dec 2022 14:46:28 -0800 (PST)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com. [209.85.219.50])
        by smtp.gmail.com with ESMTPSA id b24-20020ac844d8000000b0035badb499c7sm209956qto.21.2022.12.15.14.46.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 14:46:27 -0800 (PST)
Received: by mail-qv1-f50.google.com with SMTP id h10so523618qvq.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 14:46:27 -0800 (PST)
X-Received: by 2002:a05:6214:a45:b0:4c7:20e7:a580 with SMTP id
 ee5-20020a0562140a4500b004c720e7a580mr32835774qvb.43.1671144387380; Thu, 15
 Dec 2022 14:46:27 -0800 (PST)
MIME-Version: 1.0
References: <20221213174234.688534-1-dave.hansen@linux.intel.com>
 <CAHk-=wi=TY3Kte5Z1_nvfcsEh+rcz86pYnzeASw=pbG9QtpJEQ@mail.gmail.com>
 <20221215123007.cagd7qiidehqd77k@box.shutemov.name> <CAHk-=whC_ixb3FDdMhW_wiKw7-bB700kvUyqN+_cPUNp=1hNsQ@mail.gmail.com>
 <CAHk-=wjyy3iKS0B=A-yAPqjE3xiUU_5AiXApCasuYKTNu842dQ@mail.gmail.com> <242daeb2-b96b-d0dd-5597-ebf5fb2dfeca@intel.com>
In-Reply-To: <242daeb2-b96b-d0dd-5597-ebf5fb2dfeca@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 15 Dec 2022 14:46:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=whKuB=mno0a5i9g7hPGdKhz3d5DErTZZGs3FjMW4ap4GA@mail.gmail.com>
Message-ID: <CAHk-=whKuB=mno0a5i9g7hPGdKhz3d5DErTZZGs3FjMW4ap4GA@mail.gmail.com>
Subject: Re: [GIT PULL] x86/mm for 6.2
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     kirill.shutemov@linux.intel.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
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

On Thu, Dec 15, 2022 at 1:53 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> Back in the MPX days, we had some users pop up and tell us that MPX
> wasn't working for them on certain threads.  Those threads ended up
> having been clone()'d even _before_ MPX got enabled which was via some
> pre-main() startup code that the compiler inserted.  Since these early
> threads' FPU state was copied before MPX setup was done, they never got
> MPX-enabled.

Yeah, I can see that happening, but I do think:

> Maybe we call those "early thread" folks too crazy to get LAM.

I think we should at least *start* that way.

Yes, I can imagine some early LD linkage thing deciding "this early
dynamic linking is very expensive, I will thread it".

I personally think that's a bit crazy - if your early linking is that
expensive, you have some serious design issues - but even if it does
happen, I'd rather start with very strict rules, see if that works
out, and then if we hit problems we have other alternatives.

Those other alternatives could involve relaxing the rules later and
saying "ok, we'll allow you to enable LAM even in this case, because
you only did Xyz".

But another alternative could also be to just have that LAM enabled
even earlier by adding an ELF flag, so that the address masking is
essentially set up at execve() time.

And independently of that, there's another issue: I suspect you want
separate the concept of "the kernel will mask virtual addresses in
certain system calls" from "the CPU will ignore those masked bits"

And I say that because that's basically what arm64 does.

On arm64, the 'untagged_addr()' masking is always enabled, but whether
the actual CPU hardware ignores the flags when virtually addressed is
a separate thing that you need to do the prctl() for.

Put another way: you can always pass tagged addresses to things like
mmap() and friends, *even if* those tagged addresses would cause a
fault when accessed normally, and wouldn't work for "read()" and
'write()" and friends (because read/write uses regular CPU accesses).

Now, the Intel LAM model is mode complicated, because the mask is
dynamic, and because there are people who want to use the full linear
address space with no masking.

But the whole "want to use the full linear address space" issue is
actually in some ways closer to the the "use five-level page tables"
decision - in that by *default* we don't use VA space ab9ove 47, and
you have to basically actively *ask* for that 5-level address space.

And I think the LAM model might want to take that same approach: maybe
by *default*, untagged_addr() always does the masking, and x86 takes
the arm64 approach.

And then the truly *special* apps that want unmasked addresses are the
ones who mark themselves special, kind of the same way they already
have to if they want 5-level paging.

And again: untagged_addr() doing masking does *not* necessarily mean
that the CPU does. I think arm64 does actually set the TBI bit by
default, but there's very much a prctl() to enable/disable it. But
that "BTI is disabled" doesn't actually mean that the mmap() address
masking is disabled.

I dunno. I'm really just saying "look, arm64 does this very
differently, and it seems to work fine there".

                    Linus
