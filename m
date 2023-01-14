Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA4A66AA86
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 10:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjANJiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 04:38:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjANJip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 04:38:45 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF29F1BD
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 01:38:44 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id ss4so50246245ejb.11
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 01:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a2eUbr7QkjUR90eG2tmN6KeJ9NiYHA5tUZiHeksrAO8=;
        b=H4eRLPkXec1nk0yQgqaf/RTJHrY6rHHFurrzgP4nyabBxM6CSs5qXtSPDhb827oJ9x
         R60lpYqzWuTGSjRvuavkxa0m1aCX8ps4SYFm8Jnl2PkO2UqPlKUQEsXKV2PIU2ILRa/R
         Bb4oZx3augt/s0ZFSf5RrYUh8AvFiOkGJKr2HMF4TIBeSLdFo1ySK7xjMwl10G5AC4mU
         xXZ1OA1Kahog6/cJgqQ/zPPY7MRZiqiRg74KOJpChMyOf0IxnW7Gkv9mVWSQ5tb/Jd2X
         UTd+glmN8BTB8jNM6Chwn9lRST5WavvgKAwK2edz0BduSIDnKSI/Ioy3tgW0mF8lnLWW
         CRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a2eUbr7QkjUR90eG2tmN6KeJ9NiYHA5tUZiHeksrAO8=;
        b=QmnDAwQTDHYi5wrDsohVraXvjr3gcLXdW/gGBFV9LiCNcu6KKdD0ZtfERDZqginAQV
         PPLCNVs3ILDn79bybKwaEJK4l45uq8FVmY8/z9V1E4j+nAHwjYgOR0fiIDT9/sLXtEoP
         x6M+N3vCBtpXA2JbK9H85c9srgF42M8rIdVAp/mVoWAQexfGuI8M+jOSICZOJx0H3Eun
         arPhbT4FwqUQczgedEtTJDbt6o76KtG8ie+SFb/MtD0KtOcCXdGDHO8z1yOYuVrufpT5
         GSgQzC5Oi1+xMuyHRD6WGGZdnFyh0AybLqhgCpmhcbmx7p5zNmzaPrLi5I2BjrLBnNHf
         THrA==
X-Gm-Message-State: AFqh2kq6S3kV9onFksDwfIXkrmIz+Z9Z7rhXyC5M+zuX5vZ7PiwuJDwo
        AXx/3yabVsMIQ8/0rG5+fV8=
X-Google-Smtp-Source: AMrXdXt92UfC57xHzouPAZYQybu84OqKy7NZUZ4hiUnMtxH2QSGRnZwVo46BJCm1o+lmKBfYXg0uIg==
X-Received: by 2002:a17:907:2113:b0:84d:4b39:1448 with SMTP id qn19-20020a170907211300b0084d4b391448mr21679782ejb.67.1673689123295;
        Sat, 14 Jan 2023 01:38:43 -0800 (PST)
Received: from gmail.com (1F2EF2EB.nat.pool.telekom.hu. [31.46.242.235])
        by smtp.gmail.com with ESMTPSA id e20-20020a170906249400b0084d4cb00f0csm6572905ejb.99.2023.01.14.01.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 01:38:42 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 14 Jan 2023 10:38:38 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] tomoyo update and hung task update for v6.2
Message-ID: <Y8J4HuZnzsuc8Ln1@gmail.com>
References: <bc4f8b87-101b-381e-debf-6ed87bfec9f3@I-love.SAKURA.ne.jp>
 <CAHk-=wjbu9USn=hVWQ9v9t1H+8R6qXj8REkm36==w10zM0cM6g@mail.gmail.com>
 <a557d6e4-8354-f39b-32e1-b10e8a6fc04a@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a557d6e4-8354-f39b-32e1-b10e8a6fc04a@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:

> On 2023/01/13 22:28, Linus Torvalds wrote:
> > On Tue, Jan 10, 2023 at 5:07 AM Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >>
> >> A Makefile update for making it possible to remove scripts/bin2c program, and
> >> an improvement for making it easier to understand syzbot's hung task reports.
> > 
> > That hungtask change I'd _really_ like to get from the locking people,
> > not from a random - and completely unrelated tree.
> > 
> 
> OK. Then, please ignore this request.
> 
> Peter or Ingo, will you send
> "[PATCH v2 (repost)] locking/lockdep: add debug_show_all_lock_holders()" at
> https://lkml.kernel.org/r/41f43b27-d910-78e0-c0b3-f2885fe1cd22@I-love.SAKURA.ne.jp
> via your locking tree?

Thanks for the heads-up - this patch was still in my (overly long ...) 
holiday TODO list - I have replied to it now in the original thread.

[ Executive summary: I don't disagree with the functionality, but I think 
                     we can do this in a simpler/cleaner fashion. ]

Thanks,

	Ingo
