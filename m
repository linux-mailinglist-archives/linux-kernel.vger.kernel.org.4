Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788BF692A3A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 23:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbjBJWfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 17:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233638AbjBJWfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 17:35:34 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F53F2D45
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 14:35:32 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id fj20so6164699edb.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 14:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sgPQEqmErKQB0wG6VWCF+VmnzkMKfRqkz/sIKfZqL68=;
        b=gQz1/9xmHREGXPA2JXH0RsK7JsUhn7vHa15D/69fCSK/vZzwlw4bq85T8mRYkpJplP
         EegJvrfeGBLxDkz18RvpvK6JB/6GDTuCoFw9pDlWGUVTnbp7FP4QCEiSxJ0txMWl8p8y
         bbKRpYKHkKD8w9mPOUGxJllCwuJhuHiNZ3ZP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sgPQEqmErKQB0wG6VWCF+VmnzkMKfRqkz/sIKfZqL68=;
        b=i2BZIrSnp79zsWXTsg/smeqS8XqcGDaByhhWkXfeKPsIHftmp/4EGtcTzfked+AxqV
         JpLkkNLn1Zt90op3XEo/UezHurPQHf5poTqsvhviNRoXDQMe9BR1dvyHezEa3bHwyE1Q
         aIfuIrBIPi916mddfN7yE2ww+5Jw/3bFeR5HzeeGb8cU2w8bOb+2qQI+9jUbvHjK8Gfj
         i+H7jUTmBRiJGIg1HoG3scL5ewZU3Yueb4BhUNYq9kHIVHuASwA2uLZ0vvYhKp7xJD1j
         sShsoLn82EyKzDgeZaIYuy8YX1en1Kefpf2//Fa41b/2YvB3BC/vbKjwjoqA7TyLhFAl
         rq7Q==
X-Gm-Message-State: AO0yUKUEaolRcwaxbWhdIKm7PYEQW2B8Nu19m1NdJ3Yn+7AEwjn27b7M
        /AYjeR+B46aUysT6BZts8Ex9I2oAyxGgpOUGetU=
X-Google-Smtp-Source: AK7set/P8k/2zHuoByYWLh+bznfyrQ+dmzkhd+LNfqsJMiHSipLcywdOuYPDzMcVDI1F8zHrRi6erA==
X-Received: by 2002:a50:9b43:0:b0:4ab:1d33:69ba with SMTP id a3-20020a509b43000000b004ab1d3369bamr7687008edj.16.1676068530338;
        Fri, 10 Feb 2023 14:35:30 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id r12-20020a50c00c000000b0049dd7eec977sm2892561edb.41.2023.02.10.14.35.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 14:35:29 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id ud5so19484886ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 14:35:29 -0800 (PST)
X-Received: by 2002:a17:906:fad2:b0:88d:d304:3424 with SMTP id
 lu18-20020a170906fad200b0088dd3043424mr1693934ejb.0.1676068528950; Fri, 10
 Feb 2023 14:35:28 -0800 (PST)
MIME-Version: 1.0
References: <0cfd9f02-dea7-90e2-e932-c8129b6013c7@samba.org>
 <CAHk-=wjQZWMeQ9OgXDNepf+TLijqj0Lm0dXWwWzDcbz6o7yy_g@mail.gmail.com>
 <CALCETrWuRHWh5XFn8M8qx5z0FXAGHH=ysb+c6J+cqbYyTAHvhw@mail.gmail.com>
 <CAHk-=wjuXvF1cA=gJod=-6k4ypbEmOczFFDKriUpOVKy9dTJWQ@mail.gmail.com>
 <CALCETrUXYts5BRZKb25MVaWPk2mz34fKSqCR++SM382kSYLnJw@mail.gmail.com>
 <CAHk-=wgA=rB=7M_Fe3n9UkoW_7dqdUT2D=yb94=6GiGXEuAHDA@mail.gmail.com>
 <1dd85095-c18c-ed3e-38b7-02f4d13d9bd6@kernel.dk> <CAHk-=wiszt6btMPeT5UFcS=0=EVr=0injTR75KsvN8WetwQwkA@mail.gmail.com>
 <fe8252bd-17bd-850d-dcd0-d799443681e9@kernel.dk> <CAHk-=wiJ0QKKiORkVr8n345sPp=aHbrLTLu6CQ-S0XqWJ-kJ1A@mail.gmail.com>
 <7a2e5b7f-c213-09ff-ef35-d6c2967b31a7@kernel.dk> <CALCETrVx4cj7KrhaevtFN19rf=A6kauFTr7UPzQVage0MsBLrg@mail.gmail.com>
 <b44783e6-3da2-85dd-a482-5d9aeb018e9c@kernel.dk> <2bb12591-9d24-6b26-178f-05e939bf3251@kernel.dk>
 <CAHk-=wjzqrD5wrfeaU390bXEEBY2JF-oKmFN4fREzgyXsbQRTQ@mail.gmail.com>
 <CAHk-=wjUjtLjLbdTz=AzvGekyU1xiSL-wAAb7_j_XoT9t4o1vQ@mail.gmail.com> <824fa356-7d6e-6733-8848-ab84d850c27a@kernel.dk>
In-Reply-To: <824fa356-7d6e-6733-8848-ab84d850c27a@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Feb 2023 14:35:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg3gLL-f6XkQo4vw42Q+ySPrMdprNL1dxNrr3RGHzhnrw@mail.gmail.com>
Message-ID: <CAHk-=wg3gLL-f6XkQo4vw42Q+ySPrMdprNL1dxNrr3RGHzhnrw@mail.gmail.com>
Subject: Re: copy on write for splice() from file to pipe?
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        Stefan Metzmacher <metze@samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API Mailing List <linux-api@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Samba Technical <samba-technical@lists.samba.org>
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

On Fri, Feb 10, 2023 at 2:26 PM Jens Axboe <axboe@kernel.dk> wrote:
> >
> > (I actually suspect that /dev/zero no longer works as a splice source,
> > since we disabled the whole "fall back to regular IO" that Christoph
> > did in 36e2c7421f02 "fs: don't allow splice read/write without
> > explicit ops").
>
> Yet another one... Since it has a read_iter, should be fixable with just
> adding the generic splice_read.

I actually very consciously did *not* want to add cases of
generic_splice_read() "just because we can".

I've been on a "let's minimize the reach of splice" thing for a while.
I really loved Christoph's patches, even if I may not have been hugely
vocal about it. His getting rid of set/get_fs() got rid of a *lot* of
splice pain.

And rather than try to make everything work with splice that used to
work just because it fell back on read/write, I was waiting for actual
regression reports.

Even when splice fails, a lot of user space then falls back on
read/write, and unless there is some really fundamental reason not to,
I think that's always the right thing to do.

So we do have a number of "add splice_write/splice_read" commits, but
they are hopefully all the result of people actually noticing
breakage.

You can do

     git log --grep=36e2c7421f02

to see at least some of them, and I really don't want to see them
without a "Reported-by" and an actual issue.

Exactly because I'm not all that enamoured with splice any more.

                 Linus
