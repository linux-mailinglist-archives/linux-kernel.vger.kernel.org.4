Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A19D623427
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 21:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbiKIUCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 15:02:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbiKIUCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 15:02:42 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F1A13D40
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 12:02:41 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id f8so11641525qkg.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 12:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qUjjqGTtbizHcI9BkjA1bbaQvyi03Kds77EtaxwAMOc=;
        b=caxpXABKham28jkRCMVuppOgRUUTkdtrw/2Am/kpSQX8vfCvcXgzA5tN5BoA0/JAdW
         RQqEyP4SktRgMiJ//9sDtYoMQ/Uslxp/xDgXlr2MwLR5rtDgZT49zoYs4/0hN920RUSF
         VNg6OJoPEnT7C9VR5W1COo9N6mwZrZvszwL/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qUjjqGTtbizHcI9BkjA1bbaQvyi03Kds77EtaxwAMOc=;
        b=3SuMQoK/VBbha+MRtLj0n4PldwdM/Jffvn1rqj5MywcIFaXZy8wl0lKvvnJ6QIgRFH
         dGd57yXs9sivDsFp6b+mTkynVtcM8J+yX3cNMoGaHcYf76mCQzszSCxcjKtgPRiLQAox
         iaVA8gMoKq5vdi8cok2zsNtI8HQ3D201I7OyPtPqnXrbo9Ka5D+YDL78dU+hNj1OMP0z
         j5MbV4CCu1egSpKAuuhH4m5zV2fK/QU0oOdb2WklhDmnyitRRKB60uMiUCFpShi49wQ9
         iT3Ihj6D7/h+1HXUjuItFq+Su747oJuhjAjAslqpE2QIxbR4FPUcgwLAdQ2jEXFFikn2
         ZRCQ==
X-Gm-Message-State: ACrzQf3R9g63QSRgBXB5ugWHCcfVcxfkQXkid53v0g95hOzWDobFieee
        fAEqn9servEHotUw6B4FiTFYyRIITkMFkg==
X-Google-Smtp-Source: AMsMyM4vRlB2A8CWZtTmgZnS4eIhMBADf4bj7NmAXDGUf/DK56wjUJ9ClrUY/LsFKNEUJB5IP+nCWg==
X-Received: by 2002:a05:620a:4505:b0:6cf:9668:f274 with SMTP id t5-20020a05620a450500b006cf9668f274mr44625410qkp.603.1668024160138;
        Wed, 09 Nov 2022 12:02:40 -0800 (PST)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id 81-20020a370b54000000b006e702033b15sm2891145qkl.66.2022.11.09.12.02.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 12:02:37 -0800 (PST)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-370547b8ca0so172759127b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 12:02:34 -0800 (PST)
X-Received: by 2002:a81:8241:0:b0:370:5fad:47f0 with SMTP id
 s62-20020a818241000000b003705fad47f0mr51636729ywf.441.1668024154055; Wed, 09
 Nov 2022 12:02:34 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wh6MxaCA4pXpt1F5Bn2__6MxCq0Dr-rES4i=MOL9ibjpg@mail.gmail.com>
 <20221108194139.57604-1-torvalds@linux-foundation.org> <Y2tKixpO4RO6DgW5@tuxmaker.boeblingen.de.ibm.com>
 <CAHk-=wiqUpnAzD74H7wCvJ+L9jK+wY=H=8BiFFNkWP21r9uoUQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiqUpnAzD74H7wCvJ+L9jK+wY=H=8BiFFNkWP21r9uoUQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Nov 2022 12:02:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh_tRPHZus6Y8AcRci=tRBT4BdvW_WfPjxK1Za42VO5kQ@mail.gmail.com>
Message-ID: <CAHk-=wh_tRPHZus6Y8AcRci=tRBT4BdvW_WfPjxK1Za42VO5kQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm: introduce 'encoded' page pointers with embedded
 extra bits
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
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

On Wed, Nov 9, 2022 at 10:00 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But while I think a BUILD_BUG_ON() would be the right thing to do
> here, I do not feel confident enough to really put that to the test.

Oh, what the hell.

Just writing that whole explanation out made me just go "let's try to
re-organize it a bit so that we *can* inline everything, and see how
well it works".

And it does actually work to use BUILD_BUG_ON(), both with gcc and clang.

At least that's the case with the versions of gcc and clang _I_ use,
and in the configurations I tested.

So now I have a slightly massaged version of the patches (I did have
to move the 'encode_page()' around a bit), which has that
BUILD_BUG_ON() in it, and it passes for me.

And I find that I really like seeing that whole page pointer encoding
be so obviously much stricter. That was obviously the point of the
whole separate type system checking, now it does bit value validity
checking too.

So I'll walk through my patches one more time to check for it, but
I'll post it as a git branch and send out a new series (and do it in a
separate thread with a cover letter, to not confuse the little mind of
'b4' again).

If it turns out that some other compiler version or configuration
doesn't deal with the BUILD_BUG_ON() gracefully, it's easy enough to
remove, and it will hopefully show up in linux-next when Andrew picks
it up.

                  Linus
