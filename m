Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5846743F9A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 18:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbjF3QT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 12:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbjF3QTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 12:19:51 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2723C06
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:19:50 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b69ff54321so33349221fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688141988; x=1690733988;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j3I7zANFd6QAuWoZlCVaHAW7HE1PeX5cogAMvb+4P44=;
        b=GrJQAo/99ujxjtCM9Fh85YRwlV1iYIFAmoj36GFuJhWYbEHO6kt62yYldyzOplG+A7
         dgUFTFrKwfPsDGKGHZpAZ56sfXF1+WAICLcuQ+b4bXOg2MMP9Yps/1ZcET1dqppLaKUw
         16ek9zvj1YHAcMVJangXNUpiystZ/wz8Fj5Yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688141988; x=1690733988;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j3I7zANFd6QAuWoZlCVaHAW7HE1PeX5cogAMvb+4P44=;
        b=Riwzr7XjuveJdYSSiLpYzQZ/E6rwMf/hPrzmBkf8kLBwjYGhafdQZ264fRkQGLt1rP
         XoNjbSJPzlD1LWu/s4CSsCG82elb9AgRqIMlXtnif/pHkitNpcTVFALKj1xDGsZY2IDb
         WX7hOTb1N132iWCh/1jKN/4RdyuvDOPSldvyJ1HrmvnsCG4xni9EJdGTjtlJLl65nUQV
         I92LRmWOniITH3HtYLV+YE6I+WpQENR+JN0S9iyXwTLtuI7kEuSNQeq7TIoHQZN2iGDQ
         fTK36m2znT/RjN5De6/XL6Tuik8jpSctGRE3FUkqEhvxPsemXt4B4FG0GMnowlmEy4Cz
         ceNg==
X-Gm-Message-State: ABy/qLaDSvF0Vg3L/cuEBKPs4WNgkUtzvn9GRid9O6fmwaFMz3O3SO9P
        e6hnc7hJcZMeJoWPvxawI50iX5Pv5Fd4MYJmQsBLrsJh
X-Google-Smtp-Source: APBJJlFxNtRxWCIGqCw7zhj5tfwj3smbA3Hrw1Ux8bjYUK6rBqOoxhudXXLbl4MFjIXFD+5uIULbAQ==
X-Received: by 2002:a2e:86c3:0:b0:2b6:a65f:729d with SMTP id n3-20020a2e86c3000000b002b6a65f729dmr2352292ljj.13.1688141988257;
        Fri, 30 Jun 2023 09:19:48 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id t26-20020a2e781a000000b002b6cde9f325sm537085ljc.105.2023.06.30.09.19.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jun 2023 09:19:47 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-4fba86f069bso169463e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:19:47 -0700 (PDT)
X-Received: by 2002:a05:6512:3994:b0:4f9:58bd:9e5a with SMTP id
 j20-20020a056512399400b004f958bd9e5amr2835506lfu.27.1688141987079; Fri, 30
 Jun 2023 09:19:47 -0700 (PDT)
MIME-Version: 1.0
References: <wiuXi4KmjgTocOZMpHTZuZP+y8r5wYynvvT_ZPXyG+TYA@mail.gmail.com> <20230630160519.3869505-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230630160519.3869505-1-Liam.Howlett@oracle.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 30 Jun 2023 09:19:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg=DGSsA+=rr3bMDKrGNgy4C+PGM_w2PtpK4+Sx9qFF8w@mail.gmail.com>
Message-ID: <CAHk-=wg=DGSsA+=rr3bMDKrGNgy4C+PGM_w2PtpK4+Sx9qFF8w@mail.gmail.com>
Subject: Re: [PATCH] mm: Update do_vmi_align_munmap() return semantics
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
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

On Fri, 30 Jun 2023 at 09:06, Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
>
> Update do_vmi_align_munmap() to return 0 for success.  Clean up the
> callers and comments to always expect the lock downgrade to be honored
> on the success path.  The error path will always leave the lock
> untouched.

Thanks for doing this, but with this cleanup, it becomes clear that
some of the callers that asked for a downgrade didn't actually want
that at all...

For example:

> +               if (do_vma_munmap(&vmi, brkvma, newbrk, oldbrk, &uf, true))
> +                       goto out;
> +
> +               mmap_read_unlock(mm);
> +               goto success_unlocked;

this clearly wanted the lock to be dropped entirely.

As did this one:

>         ret = do_vmi_munmap(&vmi, mm, start, len, &uf, downgrade);
>         /*
> -        * Returning 1 indicates mmap_lock is downgraded.
> -        * But 1 is not legal return value of vm_munmap() and munmap(), reset
> -        * it to 0 before return.
> +        * Returning 0 is successful, but the lock status depends what was
> +        * passed in.
>          */
> -       if (ret == 1) {
> +       if (!ret && downgrade)
>                 mmap_read_unlock(mm);
> -               ret = 0;
> -       } else
> +       else
>                 mmap_write_unlock(mm);

And this one:

> +               ret = do_vmi_munmap(&vmi, mm, addr + new_len, old_len - new_len,
> +                                   &uf_unmap, true);
> +               if (ret)
> +                       goto out;
> +
> +               mmap_read_unlock(current->mm);

I didn't look at what all the indirect callers here were doing, but it
really looked to me like *most* callers wanted the lock dropped
entirely at the end.

In fact, looking at that patch, it looks like *all* of the callers
that asked for downgrading actually really wanted the lock dropped
entirely.

But I may well be missing some context.  So take this not as a NAK,
but as a "you looked at all this code, could it perhaps be simplified
a bit more still?"

               Linus
