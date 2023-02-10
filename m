Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834E7692629
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 20:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbjBJTS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 14:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233236AbjBJTS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 14:18:27 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C097CCBF
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 11:18:26 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id co8so2282199wrb.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 11:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rqdkVXcgxfdy1Dm/8iJj45I844hMpjNCthfme++2m+A=;
        b=HXeP/zJ0VPZo44pu1T+InLR2v6BSFVt8KQxTIxDwhqwt5QJO3Gq4TOrcF1bpZ27GKI
         Elg9+Al61hYH5yP/e3IOrLmM53/MBZegt7gZ4ga+ZMwPbD78nkcecLkPqgjH4g8cjArx
         Fz2U4FUs2ho/9WBlfzAxyolkW7zXzrMdaNn+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rqdkVXcgxfdy1Dm/8iJj45I844hMpjNCthfme++2m+A=;
        b=lvfJfOxm+3l7hhoDxSDoKP+5Rvi8M5SvTpmsmXB50uEqNT9RMGmav6aFJW7X2F+z6L
         1eGQadFNscPDUrchsxwR1/Fk/0b6XosE57h9MDvqOtBNZTxhmUZoDEoNNK3iWDl8ed4/
         t4+heBEQUjT0oK+kr2wCLrBhQ4KKW+FBobvKbYRxMzcLepQkGP9ug0C+ecg9/zjfjlhJ
         5tM57M7nhRWCyS9vav1v30KeCqUF93wpu/hDESpzX5IjT+aI8wONAJHzuCw6YWO6cJvx
         AK3dQC/vbuQOseNfoFs/1zzhonpysMZDjCU6Lx9kA8s6HK6GCViDEIdg4G4NhZh0y2kQ
         9SHg==
X-Gm-Message-State: AO0yUKXzyMSNbKxkwQyDhO7PJJgahwzK7SmEJLoVsujiWrmc/CN95b6B
        kgWOSc7iAA1KHVjRxDe5NDEGBBqoWHHMPaQCF/0=
X-Google-Smtp-Source: AK7set8knuM0KXxY+P/MDsdRMJMI3SKGa98ocyYVc2OY3tuR7FBtgVr4C0HzrJ79j8JWyr+G829Snw==
X-Received: by 2002:a5d:6206:0:b0:2c3:e868:cf54 with SMTP id y6-20020a5d6206000000b002c3e868cf54mr17518245wru.13.1676056704262;
        Fri, 10 Feb 2023 11:18:24 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id w1-20020a5d4b41000000b002c54c0a5aa9sm1596085wrs.74.2023.02.10.11.18.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 11:18:23 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id d40so4333997eda.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 11:18:23 -0800 (PST)
X-Received: by 2002:a50:f603:0:b0:49d:ec5e:1e98 with SMTP id
 c3-20020a50f603000000b0049dec5e1e98mr3187606edn.5.1676056702919; Fri, 10 Feb
 2023 11:18:22 -0800 (PST)
MIME-Version: 1.0
References: <0cfd9f02-dea7-90e2-e932-c8129b6013c7@samba.org>
 <CAHk-=wj8rthcQ9gQbvkMzeFt0iymq+CuOzmidx3Pm29Lg+W0gg@mail.gmail.com>
 <20230210021603.GA2825702@dread.disaster.area> <20230210040626.GB2825702@dread.disaster.area>
 <Y+XLuYh+kC+4wTRi@casper.infradead.org> <20230210065747.GD2825702@dread.disaster.area>
 <CALCETrWjJisipSJA7tPu+h6B2gs3m+g0yPhZ4z+Atod+WOMkZg@mail.gmail.com>
 <CAHk-=wj66F6CdJUAAjqigXMBy7gHquFMzPNAwKCgkrb2mF6U7w@mail.gmail.com>
 <CALCETrU-9Wcb_zCsVWr24V=uCA0+c6x359UkJBOBgkbq+UHAMA@mail.gmail.com>
 <CAHk-=wjQZWMeQ9OgXDNepf+TLijqj0Lm0dXWwWzDcbz6o7yy_g@mail.gmail.com> <CALCETrWuRHWh5XFn8M8qx5z0FXAGHH=ysb+c6J+cqbYyTAHvhw@mail.gmail.com>
In-Reply-To: <CALCETrWuRHWh5XFn8M8qx5z0FXAGHH=ysb+c6J+cqbYyTAHvhw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Feb 2023 11:18:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjuXvF1cA=gJod=-6k4ypbEmOczFFDKriUpOVKy9dTJWQ@mail.gmail.com>
Message-ID: <CAHk-=wjuXvF1cA=gJod=-6k4ypbEmOczFFDKriUpOVKy9dTJWQ@mail.gmail.com>
Subject: Re: copy on write for splice() from file to pipe?
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        Stefan Metzmacher <metze@samba.org>,
        Jens Axboe <axboe@kernel.dk>,
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

On Fri, Feb 10, 2023 at 11:02 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> Second, either make splice more strict or add a new "strict splice"
> variant.  Strict splice only completes when it can promise that writes
> to the source that start after strict splice's completion won't change
> what gets written to the destination.

The thing ius, I think your "strict splice" is pointless and wrong.

It's pointless, because it simply means that it won't perform well.

And since the whole point of splice was performance, it's wrong.

I really think the whole "source needs to be stable" is barking up the
wrong tree.

You are pointing fingers at splice().

And I think that's wrong.

We should point the fingers at either the _user_ of splice - as Jeremy
Allison has done a couple of times - or we should point it at the sink
that cannot deal with unstable sources.

Because that whole "source is unstable" is what allows for that higher
performance. The moment you start requiring stability, you _will_ lose
it. You will have to lock the page, you'll have to umap it from any
shared mappings, etc etc.  And even if there are no writers, or no
current mappers, all that effort to make sure that is the case is
actually fairly expensive.

So I would instead suggest a different approach entirely, with several
different steps:

 - make sure people are *aware* of this all.

   Maybe this thread raised some awareness of it for some people, but
more realistically - maybe we can really document this whole issue
somewhere much more clearly

 - it sounds like the particular user in question (samba) already very
much has a reasonable model for "I have exclusive access to this" that
just wasn't used

 - and finally, I do think it might make sense for the networking
people to look at how the networking side works with 'sendpage()'.

Because I really think that your "strict splice" model would just mean
that now the kernel would have to add not just a memcpy, but also a
new allocation for that new stable buffer for the memcpy, and that
would all just be very very pointless.

Alternatively, it would require some kind of nasty hard locking
together with other limitations on what can be done by non-splice
users.

                Linus
