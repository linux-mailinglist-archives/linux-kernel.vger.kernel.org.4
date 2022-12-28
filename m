Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2CFF6577FB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 15:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbiL1Oo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 09:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbiL1OoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 09:44:12 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8847711808
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 06:44:11 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id k44-20020a9d19af000000b00683e176ab01so5037959otk.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 06:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VtKWxbYob+OPT2w3feMvpl293ymRFdZrECTuIvxJpfs=;
        b=MZVzRDSCwSjVXIZD5mG38Tbmoo+jNQKhTbJqDGvPR7kHAn2EdYh/5SqyvNmj8TI2Tf
         vEnV3f0TXImATmv7WzpEIitmSJ4m3rxSUE5/ZFFzef80WIXYXxm8MNeeIpGLjmRnUg6C
         SaRXRwzc5wJ5T8V+/98dWLBL/c97oDAsuapY0dqhg+W5mDW+ogg+9XBNGf0nHv8GauzC
         0EccqvOOgWqfWYGalw3Dgp5lS0EQowRVi7K52dAgwxCUC0QiM/3+rnMTU66qJ8m7ZsHS
         wUZp9Ps+zGKuiGHBzvzWYNhnvcl/R9PRJCcSxckiJB7JLkOkqa+RmQoC6UuaMH5pzWJh
         IrfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VtKWxbYob+OPT2w3feMvpl293ymRFdZrECTuIvxJpfs=;
        b=0LJ5o0xrVTfFGcz83ihWorRpZKwDT8DRyyvf06CigRUpNjfh1HPLqBwH4V70HdUlBB
         YrSwzdJNJTCIb+zq1fSYgPgA95M3lUMKF88Llyf3xWAIGakJwQD+Ejm2Y218ZN7XyGOs
         +y5PnU2SsZLEA+u65G7Ci91mpYo7qTi9f64hyOBFKNxSqkenf6wDBXvVaYnVAYsKMRab
         QdaPQwI5r3drkdVF6B+t3yVyNKsFcMjB7RDaJWcNcNuCpBwj2WGmymry3h9ldRSnbnAg
         3tO7xeYYXIXHrZy2ZdumDMFsUrVq91fAwYeLywl2SDXrTR63cEVv77E9Q5moXs/X3hR+
         uS9w==
X-Gm-Message-State: AFqh2kqAmZjXG9G2kWO2aKcyJGqp76+76ka4ea3Ef0JmyULrC16sO4hA
        5pJKqEoCuEpoJKVRgzQdGgs=
X-Google-Smtp-Source: AMrXdXt/NQKtIkq0UcPmqzb8mPMuKqniwYsMoJXuZpcPnNOhrL303ANEvUDhfnlYU+Bqyiva6p8Jmw==
X-Received: by 2002:a9d:7497:0:b0:670:4589:eb59 with SMTP id t23-20020a9d7497000000b006704589eb59mr12343074otk.21.1672238650767;
        Wed, 28 Dec 2022 06:44:10 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x11-20020a056830114b00b00677714a440fsm7861883otq.81.2022.12.28.06.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 06:44:09 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 28 Dec 2022 06:44:08 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kees Cook <kees@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: Linux 6.2-rc1
Message-ID: <20221228144408.GA873415@roeck-us.net>
References: <CAHk-=wgf929uGOVpiWALPyC7pv_9KbwB2EAvQ3C4woshZZ5zqQ@mail.gmail.com>
 <20221226195206.GA2626419@roeck-us.net>
 <CAHk-=whD1zMyt4c7g6-+tWvVweyb-6oHMT_+ZVHqe1EXwtFpCQ@mail.gmail.com>
 <DA632860-284E-4923-8863-9D2745DD289E@kernel.org>
 <20221227002941.GA2691687@roeck-us.net>
 <D8BDBF66-E44C-45D4-9758-BAAA4F0C1998@kernel.org>
 <20221227055212.GA2711289@roeck-us.net>
 <DE30CDA1-CFF4-49FE-B653-F4CA831EAA12@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DE30CDA1-CFF4-49FE-B653-F4CA831EAA12@kernel.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 07:40:30PM -0800, Kees Cook wrote:
> On December 26, 2022 9:52:12 PM PST, Guenter Roeck <linux@roeck-us.net> wrote:
> >On Mon, Dec 26, 2022 at 05:32:28PM -0800, Kees Cook wrote:
> >> On December 26, 2022 4:29:41 PM PST, Guenter Roeck <linux@roeck-us.net> wrote:
> >> >On Mon, Dec 26, 2022 at 01:03:59PM -0800, Kees Cook wrote:
> >> >> On December 26, 2022 12:56:29 PM PST, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >> >> >On Mon, Dec 26, 2022 at 11:52 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >> >> >>
> >> >> >> fs/f2fs/inline.c: In function 'f2fs_move_inline_dirents':
> >> >> >> include/linux/fortify-string.h:59:33: error: '__builtin_memset' pointer overflow between offset [28, 898293814] and size [-898293787, -1] [-Werror=array-bounds]
> >> >> >> fs/f2fs/inline.c:430:9: note: in expansion of macro 'memset'
> >> >> >>   430 |         memset(dst.bitmap + src.nr_bitmap, 0, dst.nr_bitmap - src.nr_bitmap);
> >> >> >>       |         ^~~~~~
> >> >> >
> >> >> >Well, that's unfortunate.
> >> >> 
> >> >> I'll look into this.
> >> >> 
> >> >
> >> >I did some more testing. The problem is seen with gcc 11.3.0, but not with
> >> >gcc 12.2.0 nor with gcc 10.3.0.
> >> 
> >> That's what I'd expect: 10 didn't have variable range tracking wired up to -Warray-bounds, 11 does, and we disable -Warray-bounds on 12 because of 3 separate 12-only GCC bugs.
> >> 
> >> > gcc bug ? Should I switch to gcc 12.2.0 for
> >> >powerpc when build testing the latest kernel ?
> >> 
> >> Sure? But that'll just hide it. I suspect GCC has found a way for dst.nr_bitmap to be compile-time 27, so the size is always negative.
> >> 
> >dst.nr_bitmap is initialized with SIZE_OF_DENTRY_BITMAP,
> >which is defined as:
> >
> >#define NR_DENTRY_IN_BLOCK      214     /* the number of dentry in a block */
> >#define SIZE_OF_DIR_ENTRY       11      /* by byte */
> >#define SIZE_OF_DENTRY_BITMAP   ((NR_DENTRY_IN_BLOCK + BITS_PER_BYTE - 1) / \
> >                                        BITS_PER_BYTE)
> >
> >((214 + 8 - 1) / 8 = 27, so dst.nr_bitmap is indeed compile-time 27.
> >
> >Not sure how would know that src.nr_bitmap can be > 27, though.
> >Am I missing something ?
> 
> I think it's saying it can't rule out it being larger? I.e. there is no obvious bounds checking for it. Perhaps:
> 
> if (src.nr_bitmap > dst.nr_bitmap) {
>     err = -EFSCORRUPTED;
> 		goto out;
> }
> 

After going through all calculations, using maximum values (or minimum
values where appropriate) everywhere, I calculated that src.nr_bitmap
is always <= 24. The actual inode is sanity checked in
fs/f2fs/inode.c:sanity_check_inode().

Also, why is this only seen when I try to build powerpc test images ?

Thanks,
Guenter
