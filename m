Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72EE6F7083
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 19:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjEDRKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 13:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjEDRKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 13:10:39 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7569655BF
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 10:10:26 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-96598a7c5e0so124168366b.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 10:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683220224; x=1685812224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/3LXkllH51M477WCMg3uSfjiWcdYxBBntiHz8fBQu3Y=;
        b=FY6Ok1vpintUDhzMy5CBfwRFaqQH0Y71z9MeGxtNkXQX6HdLd9TEdBtVoeJpHf4GCU
         bcxTwP7uDCROKbmv4ZpBpScAYeMRIZmXpkDYtkEmpvp1vftR7TFYm0v9oQcNrG7y27c6
         bYhjEDjfLElcIoyYKNwt1suEnkubdFTLrnej4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683220224; x=1685812224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/3LXkllH51M477WCMg3uSfjiWcdYxBBntiHz8fBQu3Y=;
        b=VEcn9/qLW5hohvZE7uTIfkRXHvNjscxOOZTO9iof3oBeSVcwsYCqXF2MguhPvrUjsM
         GBHQQAZURBV/KYQceO++E0ZjwJOf9JAL596WeSG39+wjqGPttL4mfusBVo+xq/hSd6PE
         GfKQ/5az88/O5uHe4Bzp9/YnfieXY3bzq6bmfaQQ+mE2li4x5wkIL/9UGk5S3ShBQqYl
         iv/d8Xn2OmDyBXjI72W9TwpHjaSsyKSLbuQF7MNI8CGrVIi+ztzVkzMHOXILT50S5mxp
         GETetR6aDi3O/8GlRTfwZQGqqhT35tcfjeGOvUoDDINzmA3zAD5cPlfXQ2YyFFNZNQe5
         k5gQ==
X-Gm-Message-State: AC+VfDyiCUQsZJE8EOY3C+mSZXK0GJCUsNxWnJMA00OSKwNjJAp9s9ur
        PYdPhEqhCqFKwRy5lNXHCJW/whREl2iDP/1W6Lp5VJ1y
X-Google-Smtp-Source: ACHHUZ78cQ+hzSYiVZJPu4vxfzzog0DDqpcXepFotakLSc/scyxpZToGPfxSKADOMDcplW3ssUCZJA==
X-Received: by 2002:a17:907:a08a:b0:94f:e98:4e94 with SMTP id hu10-20020a170907a08a00b0094f0e984e94mr8758093ejc.47.1683220223858;
        Thu, 04 May 2023 10:10:23 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id my24-20020a1709065a5800b0094a8115e148sm18963153ejc.87.2023.05.04.10.10.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 10:10:23 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5083bd8e226so1120135a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 10:10:23 -0700 (PDT)
X-Received: by 2002:a17:907:d22:b0:959:8575:2635 with SMTP id
 gn34-20020a1709070d2200b0095985752635mr8136293ejc.17.1683220222679; Thu, 04
 May 2023 10:10:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230427225647.1101172-1-dave.hansen@linux.intel.com>
 <CAHk-=wgrdOm8RwO+u8bydrbgs0wXJV_9mBYAtzX9d9hEY7a25A@mail.gmail.com>
 <CAHk-=wiHvdgbLxayyCsRU45JnKCZkCOpEJPfOvE3eYCnGjVcSA@mail.gmail.com>
 <20230429003822.n3mglslg666j3npp@box.shutemov.name> <641a9348-a052-6bb5-e6c7-64acb6405328@intel.com>
 <CAHk-=wgnGoj8qZg3SRh1Z1-mU=b3ryydXZykUuarnrAn6LuHBw@mail.gmail.com>
 <CAHk-=wgN=GY2A0htYQQRmPaLCorWnFatY_XO0X2w_m9xXQDcPA@mail.gmail.com>
 <f5983c42-82a5-1cd8-c717-67bfd72377dc@intel.com> <CAHk-=wgpOqujY210W9-KJPEfD42W_bvUdLwF-PAvyxJQ92tzDg@mail.gmail.com>
 <CAHk-=wj7q6Ng5uemZtrDnhtcfrgkzX5Z18eKZj94FY5d2quP6A@mail.gmail.com> <20230504062827.algltnmlddtzmfz5@box.shutemov.name>
In-Reply-To: <20230504062827.algltnmlddtzmfz5@box.shutemov.name>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 4 May 2023 10:10:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjvmZhMU=R_H4t6y7-kUxu7B-ceM=wssJ=EyjcubtzpoQ@mail.gmail.com>
Message-ID: <CAHk-=wjvmZhMU=R_H4t6y7-kUxu7B-ceM=wssJ=EyjcubtzpoQ@mail.gmail.com>
Subject: Re: [GIT PULL] x86/mm for 6.4
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 3, 2023 at 11:28=E2=80=AFPM Kirill A. Shutemov <kirill@shutemov=
.name> wrote:
>
> On Wed, May 03, 2023 at 09:38:03AM -0700, Linus Torvalds wrote:
> > > Why does it do that "shift-by-63" game there, instead of making
> > > tlbstate_untag_mask just have bit #63 always set?
> >
> > And it turns out that bit #63 really _is_ always set, so I think the
> > solution to this all is to remove the sign games in untag_addr()
> > entirely.
>
> Untagging kernel pointer with LAM enabled will land it in the canonical
> hole which is safe as it leads to #GP on dereference.

You are entirely missing the point.

The GP fault does *NOT MATTER*.

Think of 'untagged_addr()' as a companion to - but absolutely *NOT* a
replacement for - 'access_ok()'.

You have three distinct cases:

 (a) user-supplied valid user address

 (b) user-supplied invalid user address (it high bit set)

 (c) actual kernel address

and 'untagged_addr()' and 'access_ok()' work on the same basic input
domain: cases (a) and (b).

And the important thing for 'untagged_addr()' is that in case (a) it
needs to remove the tab bits, and in case (b) needs to *keep* the
address as an invalid user address.

Note that it does not need to keep the value the *same*. Nobody cares.

And also note that the resulting pointer may or may not GP-fault. Nobody ca=
res.

Just to hit this home with a very explicit example, think of the case
where the kernel config for address masking isn't even enabled, and
'untagged_addr()' is a 1:1 map with no changes.

Doing 'untagged_addr()' on a valid user address results in a valid
user address. And doing it on an invalid user address results in an
invalid user address. GOOD.

Note that doing 'untagged_addr()' on an invalid user access does NOT
IN ANY WAY make that invalid address somehow "safe" and cause a GP
fault. Sure, it _might_ GP-fault. Or it might not. It might point to
random kernel data.

Verification of the address is simply not the job of
'untagged_addr()'. Never has been, never will be, and fundamentally
*cannot* be, since for the forseeable future 'untagged_addr()' is a
no-op for every single user outside of Intel.

Verification is separate. The verification is never "let's randomly
just access this pointer and see if it gets a GP-fault". No. We have a
user pointer, it needs *checking*. It needs to have something like
"use lookup_vma() to look up the vma that is associated with that
address". But it could also be something like "just do the range check
in GUP".

And that's why "keep an invalid user address as an invalid address",
because that *separate* stage of verifying the address needs to still
show that it's invalid.

Now, sometimes the "verification" might actually be "access_ok()"
itself, but honestly, if the address is used for an actual access,
then it shouldn't have gone through the 'untagged_addr()' thing at
all. It should just have been used as-is for the access. So normally
'untagged_addr()' does not get used *together* with 'access_ok()',
although that should obviously also work.

End result: all that really matters on x86-64 is that
'untagged_addr()' must keep the high bit as-is. That's the "this is
not a valid user address" bit. That's very much explicit in my current
series, of course, but even without my current series it was
implicitly the truth with those LAM patches (particularly considering
that 'untagged_addr()' didn't actually do the "keep kernel addresses
as-is" that it *thought* it did due to the signed type confusion).

So what about that (c) case? It doesn't matter. It's simply
fundamentally wrong for the kernel to pass an actual kernel address to
'untagged_addr()' and expect something useful back. It's a nonsensical
thing to do, and it's a huge bug.

So for the (c) case, the fact that the result would be useless and
*usually* GP-fault on access is a good thing. But it's not a
requirement, it's more of a "oh, cool, it's good that the nonsensical
operation causes quick failures".

So in that case, the GP fault is a "feature", but not a requirement.
Again, the normal 'untagged_addr()' case (of not changing the pointer
at all), obviously does *not* cause the kernel pointer corruption, but
maybe we could even have a debug mode. We could literally make
'untagged_addr()' do something like

   #ifdef CONFIG_DEBUG_NONLAM
   // Make sure nobody tries to use untagged_addr() on non-user addresses
   #define untagged_addr(x) ((x) | (long)(x)>>63)
   #endif

except obviously with the "get the types right and use 'x' only once"
thing (so the above #define is buggy, and puresly for conceptual
documentation purposes).

See?

Side note: one day, maybe we want to use address tagging *inside* the
kernel. However, that will not use 'untagged_addr()'. That would use
some *other* model for cleaning up kernel pointers when necessary.

Even on x86-64, the tagging rules for kernel and user space is
entirely different, in that user-space LAM rules are "U48" or "U57",
while kernel LAM rules depend on the paging mode, and the two are
*not* tied together.

But more importantly from a kernel perspective: regardless of hardware
implementations like that, the notion of masking bits off a untrusted
user pointer is simply completely *different* from the notion of
masking off bits of our own kernel pointers. You can see this in the
kernel everywhere: user pointers should be statically always user
pointers, and should look something like

   struct iocb __user *user_iocb

which is very very different from a kernel pointer that doesn't have
that "__user" thing. Again, on some architectures, the *EXACT*SAME*
bit pattern pointer value may point to different things, because user
accesses are simply in a different address space entirely.

So if/when KASAN starts using LAM inside the kernel, it will do its
own things. It had better not use "untagged_addr()".

           Linus
