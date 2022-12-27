Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2F6656768
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 06:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiL0FwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 00:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiL0FwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 00:52:16 -0500
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96E62196
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 21:52:15 -0800 (PST)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-14455716674so14572534fac.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 21:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=txM5BMbA9p01PtClB7g3vamTSBTC8eTbXIe7VyrdVpw=;
        b=CY/w3MBrrIdFb7k03q/Y3m7qIfK5oqx+HPUauNsVeE5cwBMg+SCd2yNHLn7wgY+7Bn
         saniL/QZKSpnz74IjLZJ+INHbJlB/ZCdo78GD+95GrIPohVZYv8Qy4xpO6wCdTFIg7Hw
         eVmQDERgql1zx2v6Pq7Kz3J2ubdV4jiS28dGPFK/gB/sdj1xDQCAb8hzmUTm9QtvSoLR
         5GlZgIpU13y28BO4n7wP9XYABQqYU7q1vHvQFD+7CnTjSaHRtU7201URJlic/65J8GlA
         ubf2fwMUq/Hw3NEl+Wydb80N2rgXhkfiCpr+hu6D5P3FNcJasirzFvA6oL+w79CyQl6T
         JZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=txM5BMbA9p01PtClB7g3vamTSBTC8eTbXIe7VyrdVpw=;
        b=oM4W7aHMAwfkDrvpRul/jhdld+PvsW/5D1ejqF4ua3gjpLdPtuZdtX5rTg6A9Go3tl
         ONMOgB9sbFM5HZ4Ns7QpxLrvsijF7jdjUBIikiJGk7jtku8q2a4PQ1NSAw9Z4cH/fm9Q
         ov2Lw/KAqXYkNM44K5ln0zHTH7zeccyQ3ECDF7jIeX/WCy6y+rN4HMXtnfLpLUynZwxB
         OIm1EE2UB6gKCx+L0MF8cP3adsmIUqcVBOxSH7+tgp18Fh9Dm4IGtozrLJ3dyUsLNI6u
         Fu6KnqaywT1dcFHVxl7X24D/HeF9xVnk0CV5Ll8E74ITDZ2PH3HMq1xozf57U6O+cwl+
         5gpg==
X-Gm-Message-State: AFqh2kqqxqKkmwdMkzFTsP7//2u4YY3Dmjnf/sId4nB+cA66vViyJE/m
        250l8uDPOM1MvUEvpXYRjds=
X-Google-Smtp-Source: AMrXdXv1KWT94mSs93O8jsSOWuQ8T10Mte15MmLthaTm6C85zICIfrphGH1GAH3ykNMnVhn4iYAh5Q==
X-Received: by 2002:a05:6871:4595:b0:13b:2b44:e453 with SMTP id nl21-20020a056871459500b0013b2b44e453mr9710358oab.49.1672120335120;
        Mon, 26 Dec 2022 21:52:15 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z36-20020a056870462400b00144e6ffe9e5sm5707908oao.47.2022.12.26.21.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 21:52:14 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 26 Dec 2022 21:52:12 -0800
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
Message-ID: <20221227055212.GA2711289@roeck-us.net>
References: <CAHk-=wgf929uGOVpiWALPyC7pv_9KbwB2EAvQ3C4woshZZ5zqQ@mail.gmail.com>
 <20221226195206.GA2626419@roeck-us.net>
 <CAHk-=whD1zMyt4c7g6-+tWvVweyb-6oHMT_+ZVHqe1EXwtFpCQ@mail.gmail.com>
 <DA632860-284E-4923-8863-9D2745DD289E@kernel.org>
 <20221227002941.GA2691687@roeck-us.net>
 <D8BDBF66-E44C-45D4-9758-BAAA4F0C1998@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D8BDBF66-E44C-45D4-9758-BAAA4F0C1998@kernel.org>
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

On Mon, Dec 26, 2022 at 05:32:28PM -0800, Kees Cook wrote:
> On December 26, 2022 4:29:41 PM PST, Guenter Roeck <linux@roeck-us.net> wrote:
> >On Mon, Dec 26, 2022 at 01:03:59PM -0800, Kees Cook wrote:
> >> On December 26, 2022 12:56:29 PM PST, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >> >On Mon, Dec 26, 2022 at 11:52 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >> >>
> >> >> fs/f2fs/inline.c: In function 'f2fs_move_inline_dirents':
> >> >> include/linux/fortify-string.h:59:33: error: '__builtin_memset' pointer overflow between offset [28, 898293814] and size [-898293787, -1] [-Werror=array-bounds]
> >> >> fs/f2fs/inline.c:430:9: note: in expansion of macro 'memset'
> >> >>   430 |         memset(dst.bitmap + src.nr_bitmap, 0, dst.nr_bitmap - src.nr_bitmap);
> >> >>       |         ^~~~~~
> >> >
> >> >Well, that's unfortunate.
> >> 
> >> I'll look into this.
> >> 
> >
> >I did some more testing. The problem is seen with gcc 11.3.0, but not with
> >gcc 12.2.0 nor with gcc 10.3.0.
> 
> That's what I'd expect: 10 didn't have variable range tracking wired up to -Warray-bounds, 11 does, and we disable -Warray-bounds on 12 because of 3 separate 12-only GCC bugs.
> 
> > gcc bug ? Should I switch to gcc 12.2.0 for
> >powerpc when build testing the latest kernel ?
> 
> Sure? But that'll just hide it. I suspect GCC has found a way for dst.nr_bitmap to be compile-time 27, so the size is always negative.
> 
dst.nr_bitmap is initialized with SIZE_OF_DENTRY_BITMAP,
which is defined as:

#define NR_DENTRY_IN_BLOCK      214     /* the number of dentry in a block */
#define SIZE_OF_DIR_ENTRY       11      /* by byte */
#define SIZE_OF_DENTRY_BITMAP   ((NR_DENTRY_IN_BLOCK + BITS_PER_BYTE - 1) / \
                                        BITS_PER_BYTE)

((214 + 8 - 1) / 8 = 27, so dst.nr_bitmap is indeed compile-time 27.

Not sure how would know that src.nr_bitmap can be > 27, though.
Am I missing something ?

Thanks,
Guenter
