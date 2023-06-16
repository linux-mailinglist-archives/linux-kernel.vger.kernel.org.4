Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09CF7335E9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjFPQXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345076AbjFPQWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:22:45 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F1930DF
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:22:43 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f611ac39c5so1252437e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686932561; x=1689524561;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qhUl1VIhfZQaJDYnetNsPXU5vB3Svk2rc3A44KOv0VU=;
        b=HLC/7M8l9s257xUNcuoEGFWyzTASlm4Eo1xvZuY2eRjwSUUelC7rm6b70Mq/K7COAR
         7sPzAJefTU6Mse9rmsIZg3syD2AI22i6sTwkpFXwfsslXJW1vZG3i/PMoV80QV4HSrKO
         dYGmSglk5zTnRoDh6l3jnVrtR1bWZMSBUZa9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686932561; x=1689524561;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qhUl1VIhfZQaJDYnetNsPXU5vB3Svk2rc3A44KOv0VU=;
        b=egXk5vgprQHZHO3z/Tk/OV1b7ytTw1CQ0xWGHtICxDumb/443X/8NYRgfZJUAgy3Zh
         BYny6bw+Ztc++4AYzgHC7aF0SIJx82iQI9wzpModhWXiKEx8uHSvamy5SZHkm/dL1wn9
         BBak0ydDXolUcti6/7p5y1Ys6+V2avmmejbB9JyI4HrskFYTkMiPB6efRWWrmnpCol14
         gELMZqcua4vUcgyNnq9s2e/z8AK0VI1IaUzfIIj1mBsSxOfQV1NRx25EijFFGsy330dG
         ger00eCVpxJx4hzIkc8grzCvRlmRvnbsD0NZ3ifutZcZ3I3sKDsHwk21f5qyCaCbvXfx
         KhjA==
X-Gm-Message-State: AC+VfDy5uHNRWMsez6r3GnX5rfJakVWqrWw51L+3lj+9Tm2i45iRQBzq
        za1N/hZ85YeXU8rPMA+fqSTzrVY/cH88z9W8X9aoWyYI
X-Google-Smtp-Source: ACHHUZ4TYHYxwFWd6NX/bOZpYlblTlQQH0YRigm0YedIA1inMg+hfvNrhyAsehA8Q9Mj9oW2QghBBg==
X-Received: by 2002:a05:6512:ea7:b0:4f5:bc59:6f21 with SMTP id bi39-20020a0565120ea700b004f5bc596f21mr1675911lfb.12.1686932561315;
        Fri, 16 Jun 2023 09:22:41 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id r16-20020ac24d10000000b004f3afa1767dsm3061947lfi.197.2023.06.16.09.22.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 09:22:40 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-4f611ac39c5so1252392e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:22:40 -0700 (PDT)
X-Received: by 2002:a19:f246:0:b0:4f7:4170:a5c9 with SMTP id
 d6-20020a19f246000000b004f74170a5c9mr1626358lfk.66.1686932560231; Fri, 16 Jun
 2023 09:22:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgrdOm8RwO+u8bydrbgs0wXJV_9mBYAtzX9d9hEY7a25A@mail.gmail.com>
 <20230616084715.2140984-1-glider@google.com>
In-Reply-To: <20230616084715.2140984-1-glider@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 16 Jun 2023 09:22:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg3qG_FzSwAnj8X22_aF6_Jm7wpjA4kXrCe8-C0vsUsLA@mail.gmail.com>
Message-ID: <CAHk-=wg3qG_FzSwAnj8X22_aF6_Jm7wpjA4kXrCe8-C0vsUsLA@mail.gmail.com>
Subject: Re: [GIT PULL] x86/mm for 6.4
To:     Alexander Potapenko <glider@google.com>
Cc:     dave.hansen@linux.intel.com, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jun 2023 at 01:47, Alexander Potapenko <glider@google.com> wrote:
>
> Shouldn't ex_handler_copy() be fixed in the same way?

I don't think ex_handler_copy() is actually reachable any more.

The only thing ex_handler_copy() did was to set %ax to the fault type.

It was used by the strange copy_user_generic_unrolled() that had
special machine check case for "don't do the tail if we get
X86_TRAP_MC".

But that was always bogus. The MC case in question was for the
__copy_user_nocache function, and the machine check case was for the
*destination*, which wasn't in user space at all.

So instead of looking at "what was the trap number", the code should
have just noticed "trapped on the destination", and stopped for *that*
reason.

See commit 034ff37d3407 ("x86: rewrite '__copy_user_nocache'
function") and in particular, see the comment there about writes on
the destination:

  * An exception on a write means that we're
  * done, but we need to update the count
  * depending on where in the unrolled loop
  * we were.

but yeah, I never removed the actual now unused _ASM_EXTABLE_CPY case.

Honestly, I had no way of even testing the code. I doubt anybody does.
There are a couple of users:

 - rdma mis-uses it for regular kernel-to-kernel copies that don't
fault (because rdma wants the "nocache" case). So it can't fault at
all.

 - a couple of GPU drivers mis-use it similarly to rdma, but at least
with a user source in the form of __copy_from_user_inatomic_nocache()

 - _copy_from_iter_flushcache uses it for pmem and dax, because it
wants that machine check handling for non-volatile memory

So two of three users don't actually *have* the MC case at all on the
destination.

And the third case - the actual "copy using uncached accesses in order
to get errors on the destination" case - depends on hardware that I'm
not convinced really exists any more.

Oh, I think there's some odd ntb mis-use too.

I'd love for somebody to actually test the machine check case, but the
old code was completely insane with odd "we handle _one_ case of
4-byte alignment, but not actually the general case", so I wonder if
the MC case ever really worked in reality. And as mentioned, I am not
convinced the hardware is available.

                 Linus
