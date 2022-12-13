Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1557564AC02
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 01:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbiLMAL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 19:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiLMALt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 19:11:49 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F1B1C91A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 16:11:48 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id s9so10267377qtx.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 16:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CrMZuZJM45BoKHHzFYa4qAs1N5XxbYUGTJylsPnpIUU=;
        b=crPaoiwPRQNXZ9T2O/O9wocBGZRjm43O6A9DcbAK/G2iBqB04UjpiQssBz7j5FenjH
         TYuQOEIgENWaiO26ka5mjq9mqwlgSjOc2diJCQQOgUaTUYk2lBEAazpa1q5kufS6Ibxf
         MAn1GGwd65wJuq7YUE08L6IxeK2AD8hIWkht8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CrMZuZJM45BoKHHzFYa4qAs1N5XxbYUGTJylsPnpIUU=;
        b=bEo6VPQLOA8tjk6S9CE9SGbfk8/NTPEppndaCUlgPd+Dl85nMCllxgaFnWe1tdPlre
         LKo1wA7PClcE7KTEy4soYfEYJQk1Y4UVIXepnC4e4DJByUgssiyUHQxzuas1UMISPZCQ
         gBdmmHsdqSpG7aQwFPh9oYu1gmcXAG6fs+5JN3pvVR8okWfrDoiMCjZ+DTsDipB4n4t3
         BngbenCQYVPIA5hHGrTGuUIVJ05AYwul7z1voiFW8pLlBFL13s7sI1N0E3SbUc1AUVIA
         dGf9F6bhwtnhEYFMOX5sEACyEahfwl1r+W+k7ee5iu0ZeYtmiPxgxsy+usHcYtTRkF3b
         HQKQ==
X-Gm-Message-State: ANoB5pkvZ4N3lVENmEJU0Cn+scfuDp5l7KPZM/CyOCiVl4gL3xa7yo8y
        NqPsvEeX6Ql2Zxomv6pErytXwCTgceF+7kBU
X-Google-Smtp-Source: AA0mqf5YqnkU50ZlOcQAMUzFBNN3JKqgRiI2anR3w+zVdBReRKHqNRoNLACyQgh6NB1m2OgtLvrt+Q==
X-Received: by 2002:ac8:7610:0:b0:3a8:3d4:f14c with SMTP id t16-20020ac87610000000b003a803d4f14cmr22352948qtq.5.1670890307680;
        Mon, 12 Dec 2022 16:11:47 -0800 (PST)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com. [209.85.222.181])
        by smtp.gmail.com with ESMTPSA id bb12-20020a05622a1b0c00b003a530a32f67sm6567755qtb.65.2022.12.12.16.11.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 16:11:45 -0800 (PST)
Received: by mail-qk1-f181.google.com with SMTP id p18so5876225qkg.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 16:11:45 -0800 (PST)
X-Received: by 2002:ae9:ef48:0:b0:6fe:d4a6:dcef with SMTP id
 d69-20020ae9ef48000000b006fed4a6dcefmr10616129qkg.594.1670890304708; Mon, 12
 Dec 2022 16:11:44 -0800 (PST)
MIME-Version: 1.0
References: <Y5dhRrNFzNX1Z64/@fedora>
In-Reply-To: <Y5dhRrNFzNX1Z64/@fedora>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Dec 2022 16:11:28 -0800
X-Gmail-Original-Message-ID: <CAHk-=wifBA8qdHp8kySVq6=iyaYmKXfSON7=5s9aWyfpL=Yy1w@mail.gmail.com>
Message-ID: <CAHk-=wifBA8qdHp8kySVq6=iyaYmKXfSON7=5s9aWyfpL=Yy1w@mail.gmail.com>
Subject: Re: [GIT PULL] percpu changes for v6.2-rc1
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Vlastimil Babka <vbabka@suse.cz>, Baoquan He <bhe@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
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

On Mon, Dec 12, 2022 at 9:13 AM Dennis Zhou <dennis@kernel.org> wrote:
>
> Baoquan was nice enough to run some clean ups for percpu. There will be
> a minor merge conflict with Vlastimil's slab PR [1]. This is due to
> adjusting the PERCPU_DYNAMIC_EARLY_SIZE up for proper early percpu
> reservation size on arm64 with 64k pages.

Well, the merge was trivial, but...

>   git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-6.2

Argh, this is a plain branch. I was really hoping that we had all
moved on to using signed tags for pulls.

I've pulled this, because I still don't absolutely _require_ signed
tags for kernel.org accounts, but can you please try to start using
them in the future?

The plain unsigned branches (and unsigned tags) are getting rare
enough that I'm slowly starting to consider making them a hard
requirement. Not this release, probably not the next one, but...

                Linus
