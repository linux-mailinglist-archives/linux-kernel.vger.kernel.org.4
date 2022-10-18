Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA61602673
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 10:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbiJRIHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 04:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiJRIHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 04:07:44 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE908983A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 01:07:41 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id l1so13068959pld.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 01:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r386XTy94I8XmKFnphrGlHjUNN4wxmg9QYVFoKxy77U=;
        b=kGS1GguWb4lC6DBAMQdrHJ/ymwsOEmeOSuLUmFZGdeWIpzsg2ztl6nj2uBt3DrPKAB
         lIrXrmD8eY63AZEe8W0aW5qQMcQCbnZj6hUBODId3M/AGs5HEk7FdGZmv/MGXv4bLHGu
         SisEUVcq0BlybPK79O8A9VJI6VrFCThzpHD84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r386XTy94I8XmKFnphrGlHjUNN4wxmg9QYVFoKxy77U=;
        b=xS1TfLwBi9ayEk0SdXoShG2Co8V37NbA0zOtPm4E5X52EQFVhYO273P5alHyW6JS65
         Z2LX0S4c2dNYIXYE8FtdRLp4wbUXlL1Fn5d+poCCsY3Y3I4un67sskVMRL0+sD+rrLdX
         Y/vlzZaAEMF+yoN2i14UzytFQMvsjVUZ402uiMEnpJqzAgP/g4BUiABUfN3zv9j9csy3
         3yK9Cs9pN2vhuvQ6pduFtwhgPAw/2kLwbyAx3eN3VmZfccPbWgI+wbnEvNbnT6luOhtX
         VQFDksG+KF6hi6tbSFla9pG4i1A4hzPTEbOUChQeYxYbFJgF7iOjCeBydWCxIw5aAwgs
         PaCQ==
X-Gm-Message-State: ACrzQf2RawS38eiX3efWDPUTW7lEb/z66wv87vIXVqpZfKLbY5O301zz
        IDLl6boZFKGe+vfSJbOL+qkPnxfWyazQcQ==
X-Google-Smtp-Source: AMsMyM5jspj+8kC7yhp4usBgy3FAOwLCNMfPWAqrfdp+mVitJn79Ooh8xEPtFvZnxqFsP/DRhUb6tQ==
X-Received: by 2002:a17:902:eccc:b0:185:4ff6:fef8 with SMTP id a12-20020a170902eccc00b001854ff6fef8mr1964168plh.93.1666080460870;
        Tue, 18 Oct 2022 01:07:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y24-20020aa79438000000b0056281da3bcbsm8800097pfo.149.2022.10.18.01.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 01:07:39 -0700 (PDT)
Date:   Tue, 18 Oct 2022 01:07:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] kunit/memcpy: Adding dynamic size and window tests
Message-ID: <202210180102.2845B66@keescook>
References: <20220929030846.1060818-1-keescook@chromium.org>
 <CAKwvOd=aCGPP54qxoO4-K8MDBB8VEmXpUdo156FiBVxkpdxirg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=aCGPP54qxoO4-K8MDBB8VEmXpUdo156FiBVxkpdxirg@mail.gmail.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 02:02:05PM -0700, Nick Desaulniers wrote:
> On Wed, Sep 28, 2022 at 8:08 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > The "side effects" memmove() test accidentally found a corner case in
> > the recent refactoring of the i386 assembly memmove(), but missed
> > another corner case. Instead of hoping to get lucky next time, implement
> > much more complete tests of memcpy() and memmove() -- especially the
> > moving window overlap for memmove() -- which catches all the issues
> > encountered and should catch anything new.
> >
> > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > Link: https://lore.kernel.org/lkml/CAKwvOdkaKTa2aiA90VzFrChNQM6O_ro+b7VWs=op70jx-DKaXA@mail.gmail.com
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Regardless of my comments, I ran this through:
> 
> $ ./tools/testing/kunit/kunit.py run --arch=i386 memcpy --make_options LLVM=1
> $ ./tools/testing/kunit/kunit.py run --arch=arm64 memcpy --make_options LLVM=1
> $ ./tools/testing/kunit/kunit.py run --arch=arm memcpy --make_options LLVM=1
> $ ./tools/testing/kunit/kunit.py run --arch=x86_64 memcpy --make_options LLVM=1
> All were green for me.
> 
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>

Thanks!

> Do you have any thoughts on the test in my v4 wrt. potential for
> conflicts in -next?
> https://lore.kernel.org/lkml/20220928210512.642594-1-ndesaulniers@google.com/

I designed this patch to avoid conflicts with your changes. (Has anyone
picked up the memmove refactor for -next yet?)

> It looks like even without this patch of yours,
> $ ./tools/testing/kunit/kunit.py run --arch=i386 memcpy --make_options LLVM=1
> demonstrates the bug in my v3.

Yeah, it got lucky, mainly. :)

> I also tested my v4 on top of this change with the above command line;
> it passes. :)

Perfecto! :)

> 
> > ---
> >  lib/memcpy_kunit.c | 187 +++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 187 insertions(+)
> >
> > diff --git a/lib/memcpy_kunit.c b/lib/memcpy_kunit.c
> > index 2b5cc70ac53f..f15daa66c6a6 100644
> > --- a/lib/memcpy_kunit.c
> > +++ b/lib/memcpy_kunit.c
> > @@ -270,6 +270,190 @@ static void memset_test(struct kunit *test)
> >  #undef TEST_OP
> >  }
> >
> > +static u8 large_src[1024];
> > +static u8 large_dst[2048];
> > +static const u8 large_zero[2048];
> > +
> > +static void init_large(struct kunit *test)
> > +{
> > +       int failed_rng = 0;
> > +
> > +       /* Get many bit patterns. */
> > +       get_random_bytes(large_src, sizeof(large_src));
> 
> I know sizeof == ARRAY_SIZE when we have an array of u8, but please
> consider using ARRAY_SIZE.

Yeah, I will break myself of this habit yet. Fixed.

> 
> > +
> > +       /* Make sure we have non-zero edges. */
> > +       while (large_src[0] == 0) {
> > +               get_random_bytes(large_src, 1);
> > +               KUNIT_ASSERT_LT_MSG(test, failed_rng++, 100,
> > +                                   "Is the RNG broken?");
> > +       }
> > +       while (large_src[sizeof(large_src) - 1] == 0) {
> > +               get_random_bytes(&large_src[sizeof(large_src) - 1], 1);
> > +               KUNIT_ASSERT_LT_MSG(test, failed_rng++, 100,
> > +                                   "Is the RNG broken?");
> > +       }
> 
> The above duplication could probably be separated out into another
> static function where you pass in the address of the array element to
> set to non-zero.

Done in v2.

> 
> > +
> > +       /* Explicitly zero the entire destination. */
> > +       memset(large_dst, 0, sizeof(large_dst));
> > +}
> > +
> > +/*
> > + * Instead of an indirect function call for "copy" or a giant macro,
> > + * use a bool to pick memcpy or memmove.
> > + */
> > +static void copy_large_test(struct kunit *test, bool use_memmove)
> > +{
> > +       init_large(test);
> > +
> > +       /* Copy a growing number of non-overlapping bytes ... */
> > +       for (int bytes = 1; bytes <= sizeof(large_src); bytes++) {
> > +               /* Over a shifting destination window ... */
> > +               for (int offset = 0; offset < sizeof(large_src); offset++) {
> > +                       int right_zero_pos = offset + bytes;
> > +                       int right_zero_size = sizeof(large_dst) - right_zero_pos;
> > +
> > +                       /* Copy! */
> > +                       if (use_memmove)
> > +                               memmove(large_dst + offset, large_src, bytes);
> > +                       else
> > +                               memcpy(large_dst + offset, large_src, bytes);
> > +
> > +                       /* Did we touch anything before the copy area? */
> > +                       KUNIT_ASSERT_EQ_MSG(test, memcmp(large_dst, large_zero, offset), 0,
> > +                                           "with size %d at offset %d", bytes, offset);
> > +                       /* Did we touch anything after the copy area? */
> > +                       KUNIT_ASSERT_EQ_MSG(test, memcmp(&large_dst[right_zero_pos], large_zero, right_zero_size), 0,
> > +                                           "with size %d at offset %d", bytes, offset);
> > +
> > +                       /* Are we byte-for-byte exact across the copy? */
> > +                       KUNIT_ASSERT_EQ_MSG(test, memcmp(large_dst + offset, large_src, bytes), 0,
> > +                                           "with size %d at offset %d", bytes, offset);
> > +
> > +                       /* Zero out what we copied for the next cycle. */
> > +                       memset(large_dst + offset, 0, bytes);
> > +               }
> > +               /* Avoid stall warnings. */
> > +               cond_resched();
> 
> I'm just curious what that is? ^
> Should it go in the inner loop?

This is to keep the soft-lockup detector from yelling about this
extremely slow test. :P I put it here because it's seems the right
balance between doing in too much (inner loop) and not at all.

> 
> > +       }
> > +}
> > +
> > +static void memcpy_large_test(struct kunit *test)
> > +{
> > +       copy_large_test(test, false);
> > +}
> > +
> > +static void memmove_large_test(struct kunit *test)
> > +{
> > +       copy_large_test(test, true);
> > +}
> > +
> > +/*
> > + * Take a single step if within "inc" of the start or end,
> > + * otherwise, take a full "inc" steps.
> 
> I still have a hard time following what this logic is doing,
> particularly the clamping to 1. Can you elaborate more in this
> comment?

Sure! I've tried to flesh this out in v2.

> 
> > + */
> > +static inline int next_step(int idx, int start, int end, int inc)
> 
> Please drop the inline keyword here.

Done.

> 
> > +{
> > +       start += inc;
> > +       end -= inc;
> > +
> > +       if (idx < start || idx + inc > end)
> > +               inc = 1;
> > +       return idx + inc;
> > +}
> > +
> > +static void memmove_overlap_test(struct kunit *test)
> > +{
> > +       /*
> > +        * Running all possible offset and overlap combinations takes a
> > +        * very long time. Instead, only check up to 128 bytes offset
> > +        * into the destintation buffer (which should result in crossing
> 
> typo: s/destintation/destination/

Fixed :)

> 
> > +        * cachelines), with a step size of 1 through 7 to try to skip some
> > +        * redundancy.
> > +        */
> > +       static const int offset_max = 128; /* sizeof(large_src); */
> 
> I thought large_src was 1024? Perhaps this comment is stale or
> contradictory to the comment in the block above the variable
> definition?

This was a left-over note about how big it actually was while I was
tuning it for sane run-times. I've updated the comment.

> 
> > +       static const int bytes_step = 7;
> > +       static const int window_step = 7;
> > +
> > +       static const int bytes_start = 1;
> > +       static const int bytes_end = sizeof(large_src) + 1;
> > +
> > +       init_large(test);
> > +
> > +       /* Copy a growing number of overlapping bytes ... */
> > +       for (int bytes = bytes_start; bytes < bytes_end;
> > +            bytes = next_step(bytes, bytes_start, bytes_end, bytes_step)) {
> > +
> > +               /* Over a shifting destination window ... */
> > +               for (int d_off = 0; d_off < offset_max; d_off++) {
> > +                       int s_start = max(d_off - bytes, 0);
> > +                       int s_end = min_t(int, d_off + bytes, sizeof(large_src));
> > +
> > +                       /* Over a shifting source window ... */
> > +                       for (int s_off = s_start; s_off < s_end;
> > +                            s_off = next_step(s_off, s_start, s_end, window_step)) {
> 
> Might a while loop with a distinct update statement look cleaner than
> a multiline for predicate?

I originally tried it either way, and I found the "while" even uglier. :)

> 
> > +                               int left_zero_pos, left_zero_size;
> > +                               int right_zero_pos, right_zero_size;
> > +                               int src_pos, src_orig_pos, src_size;
> > +                               int pos;
> > +
> > +                               /* Place the source in the destination buffer. */
> > +                               memcpy(&large_dst[s_off], large_src, bytes);
> > +
> > +                               /* Copy to destination offset. */
> > +                               memmove(&large_dst[d_off], &large_dst[s_off], bytes);
> > +
> > +                               /* Make sure destination entirely matches. */
> > +                               KUNIT_ASSERT_EQ_MSG(test, memcmp(&large_dst[d_off], large_src, bytes), 0,
> > +                                       "with size %d at src offset %d and dest offset %d",
> > +                                       bytes, s_off, d_off);
> > +
> > +                               /* Calculate the expected zero spans. */
> > +                               if (s_off < d_off) {
> > +                                       left_zero_pos = 0;
> > +                                       left_zero_size = s_off;
> > +
> > +                                       right_zero_pos = d_off + bytes;
> > +                                       right_zero_size = sizeof(large_dst) - right_zero_pos;
> > +
> > +                                       src_pos = s_off;
> > +                                       src_orig_pos = 0;
> > +                                       src_size = d_off - s_off;
> > +                               } else {
> > +                                       left_zero_pos = 0;
> > +                                       left_zero_size = d_off;
> > +
> > +                                       right_zero_pos = s_off + bytes;
> > +                                       right_zero_size = sizeof(large_dst) - right_zero_pos;
> > +
> > +                                       src_pos = d_off + bytes;
> > +                                       src_orig_pos = src_pos - s_off;
> > +                                       src_size = right_zero_pos - src_pos;
> > +                               }
> 
> Looking at the arms of these branches, I see a fair amount of
> duplication. Mind deduplicating some of the statements here? The
> assignments of left_zero_pos and right_zero_size look invariant of the
> predicate.

I did this originally too, but I found it easier to reason by keeping
all of the bounds calculations separated like this for readability. Any
duplication will get optimized away. :)

Thanks for the review!

-- 
Kees Cook
