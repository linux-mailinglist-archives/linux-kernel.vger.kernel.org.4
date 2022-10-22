Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43725608ED4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 19:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiJVRnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 13:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiJVRnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 13:43:11 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55154157887
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 10:43:10 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id a24so3494671qto.10
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 10:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ggRUxmsdZOOzgw1Zwl6/0LRL1kTKORpaVp7I2DpyJaE=;
        b=H9T+ruoZRgK7WvGUjeF1TVnIMaTvyPzcA/EkWhQBCOJZGB8V4ssjnSk5uYbiItgQrs
         IhsjMLT7cjpct4QV0cH8MJdPoMI1iufoI0TRxoo4jkGWRNeQVBmZqWHCaNsWHayOc0B4
         XbvRHcHsDiWs45kvz+CvQnWIIM5AIAEjrx0Xs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ggRUxmsdZOOzgw1Zwl6/0LRL1kTKORpaVp7I2DpyJaE=;
        b=PXPayhb48htub3z+glTJEmwOeDnUxpA2FEACSk6L4zNz3ZqLBcGfZZ8egXIAJ79p8M
         0kb5JZhHczOk24tQDz8eVmcXwj5rML3Dn+X33aO+RylrC+Uk6p5nf4r4czJ+/R3+SPag
         tQiZSX012Q4z12Sg0EIVaL3C5ERId0XHYIxZXHW9OZ7cjmzUacS9xilyhK8tqJ08NU5m
         O9WxsiErufxg9py4Nd98rQyilDOT5LxC2bR9bss7sG5wUxI3UYKlF9LVgabjn8wngwrh
         dDd2c2PPJHfyIXwbYf6eKQXnLbRb91r6B60bMjvl4OEcKHx1Xhjv4JcL7cBzmYbMSs4I
         Tyxg==
X-Gm-Message-State: ACrzQf2rXy0Wx1lLsyxylnqv1oNd2F25CdO2Z8zqE0g1huywLz9ueNMu
        RwvWWue8EVMfTgCtcMxzhcfBvVosA1tbFA==
X-Google-Smtp-Source: AMsMyM7pvRIv6Spb3SB3ZW5a9bJ03GGMBujoIDclotiCOtiMAljo+O+kqF9W7oxc3+sGyY9xCDSLRA==
X-Received: by 2002:ac8:5850:0:b0:39a:8ebf:5474 with SMTP id h16-20020ac85850000000b0039a8ebf5474mr21667986qth.466.1666460589026;
        Sat, 22 Oct 2022 10:43:09 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id q28-20020a05620a2a5c00b006eed14045f4sm12393168qkp.48.2022.10.22.10.43.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Oct 2022 10:43:08 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id l145so6847485ybl.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 10:43:08 -0700 (PDT)
X-Received: by 2002:a05:6902:702:b0:6ca:a588:2904 with SMTP id
 k2-20020a056902070200b006caa5882904mr2521306ybt.571.1666460588095; Sat, 22
 Oct 2022 10:43:08 -0700 (PDT)
MIME-Version: 1.0
References: <20221022111403.531902164@infradead.org> <20221022114425.038102604@infradead.org>
In-Reply-To: <20221022114425.038102604@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 22 Oct 2022 10:42:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=whVRHVJAOOc=+1eQMSuWSoRAp+yGkb3Kob2=7r05M+oXw@mail.gmail.com>
Message-ID: <CAHk-=whVRHVJAOOc=+1eQMSuWSoRAp+yGkb3Kob2=7r05M+oXw@mail.gmail.com>
Subject: Re: [PATCH 09/13] x86/mm/pae: Use WRITE_ONCE()
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
>  static inline void native_set_pte(pte_t *ptep, pte_t pte)
>  {
> -       ptep->pte_high = pte.pte_high;
> +       WRITE_ONCE(ptep->pte_high, pte.pte_high);
>         smp_wmb();
> -       ptep->pte_low = pte.pte_low;
> +       WRITE_ONCE(ptep->pte_low, pte.pte_low);

With this, the smp_wmb() should just go away too. It was really only
ever there as a compiler barrier.

Two WRITE_ONCE() statements are inherently ordered for the compiler
(due to volatile rules), and x86 doesn't re-order writes.

It's not a big deal, since smp_wmb() is just a barrier() on x86-64
anyway, but it might make some improvement to code generation to
remove it, and the smp_wmb() really isn't adding anything.

If somebody likes the smp_wmb() as a comment, I think it would be
better to actually _make_ it a comment, and have these functions turn
into just

  /* Force ordered word-sized writes, set low word with present bit last */
  static inline void native_set_pte(pte_t *ptep, pte_t pte)
  {
        WRITE_ONCE(ptep->pte_high, pte.pte_high);
        WRITE_ONCE(ptep->pte_low, pte.pte_low);
  }

or similar. I think that kind of one-liner comment is much more
informative than a "smp_wmb()".

Or do we already have a comment elsewhere about why the ordering is
important (and how *clearing* clears the low word with the present bit
first, but setting a *new* entry sets the high word first so that the
64-bit entry is complete when the present bit is set?)

                 Linus
