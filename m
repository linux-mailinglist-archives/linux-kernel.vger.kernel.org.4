Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A8573C4CE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 01:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjFWXc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 19:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjFWXcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 19:32:24 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91EE2696
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 16:32:23 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b4636bb22eso19729111fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 16:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687563142; x=1690155142;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Apfq7AhNdXkzjdfdSdVi+dqQ3I5tsUXwD6FmqXc0zjI=;
        b=GhxuHOMtbdUcSShbDvNYafl9pfOfd6C8va282O3ywbZvR+t/p39SBpkbaPQBjAxbR3
         ECY1FdMZKen56LNaIkVkSoUdZbup6/JW+3+b2jAohLrBxRhHDuGmhXCEETCdDAigSwGb
         Q9k48RVeA5YcZnEYsMV42MaqtCmnXtKLebNsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687563142; x=1690155142;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Apfq7AhNdXkzjdfdSdVi+dqQ3I5tsUXwD6FmqXc0zjI=;
        b=XP3KOmGHdaZyUtjK7nNiSChg1OABaCHYrRrJmYQYNxW2MEPOiXWtY8MIunKRTKEC9R
         WyRVMg5QiwKMV2amaXg54/Fy14jaNp2Vibq3h1lClh2ohKMA7KNkZBwRkWqMth2Qwl33
         ffrn07u8H1PnhMtn7D3vwwJy9N7P6eysRsmbnZNtBUOnUtM3D5SUgDMd69wh21UJW//v
         210dk0pbvvIXlYjpi5AkHj0q7hX24whQ8Bc5A3jl9kb4grBZRgVxMmOO1j5WLfzmWKyp
         HYh6l3+CVAfrkJdgn1btRGffzjpRvwekHw8hsSAauCZ2Ny66kw3Bt7DyRH1aOteLOU9e
         DDxw==
X-Gm-Message-State: AC+VfDzhpgjaUQL4kwOL+4t8ti63aPXYR99cf/9yc6253hLu5hiBvGGZ
        HjrDEnAtHcyMH3cc9MWWM+zrBtKwp53ExgwklqpC7jsa
X-Google-Smtp-Source: ACHHUZ4OU9DWgCvY2yuFn6YGeztEVy3KSMXOYegbyZW/m5vVavB28fd8vuB4hhAZ91drwmdAR1YOWw==
X-Received: by 2002:a2e:904f:0:b0:2b4:94ec:e8 with SMTP id n15-20020a2e904f000000b002b494ec00e8mr8808879ljg.39.1687563141683;
        Fri, 23 Jun 2023 16:32:21 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id re3-20020a170906d8c300b00977ca5de275sm213158ejb.13.2023.06.23.16.32.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 16:32:21 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-51bdf83a513so1220711a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 16:32:20 -0700 (PDT)
X-Received: by 2002:a05:6402:1344:b0:51b:e5d7:98eb with SMTP id
 y4-20020a056402134400b0051be5d798ebmr4390582edw.41.1687563140463; Fri, 23 Jun
 2023 16:32:20 -0700 (PDT)
MIME-Version: 1.0
References: <2730511.1687559668@warthog.procyon.org.uk> <CAHk-=wiXr2WTDFZi6y8c4TjZXfTnw28BkLF9Fpe=SyvmSCvP2Q@mail.gmail.com>
 <CAHk-=wjjNErGaMCepX-2q_3kuZV_aNoqB5SE-LLR_eLk2+OHJA@mail.gmail.com>
In-Reply-To: <CAHk-=wjjNErGaMCepX-2q_3kuZV_aNoqB5SE-LLR_eLk2+OHJA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 23 Jun 2023 16:32:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjrsPMko==NyQ1Y=Cta-ATshCwzSn9OwCq6KAx8Gh8RLA@mail.gmail.com>
Message-ID: <CAHk-=wjrsPMko==NyQ1Y=Cta-ATshCwzSn9OwCq6KAx8Gh8RLA@mail.gmail.com>
Subject: Re: [PATCH] pipe: Make a partially-satisfied blocking read wait for more
To:     David Howells <dhowells@redhat.com>
Cc:     Franck Grosjean <fgrosjea@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, 23 Jun 2023 at 16:08, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> In fact, I'd expect that patch to fail immediately on a perfectly
> normal program that passes a token around by doing a small write to a
> pipe, and have the "token reader" do a bigger write.

Bigger _read_, of course.

This might be hidden by such programs typically doing a single byte
write and a single byte read, but I could easily imagine situations
where people actually depend on the POSIX atomicity guarantees, ie you
write a "token packet" that might be variable-sized, and the reader
then just does a maximally sized read, knowing that it will get a full
packet or nothing.

So a read() of a pipe absolutely has to return when it has gotten
*any* data. Except if it can know that there is a writer that is still
busy and still in the process of writing more data.

Which was that old 'pipe->waiting_writers' logic - it basically
counted "there are <N> active writers that still have more data to
write, but the buffer filled up".

That logic went back to ancient times, when our pipe buffer was just a
single page - so it helped throughput immensely if we had writers that
did big writes, and readers would continue to read even when the small
buffer was completely used up (rather than return data just one page
at a time for each read() system call).

               Linus
