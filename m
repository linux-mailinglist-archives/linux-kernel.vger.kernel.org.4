Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692BA66CE8F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 19:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbjAPSPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 13:15:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234108AbjAPSO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 13:14:29 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E03122A36
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 10:01:15 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id q15so1374757qtn.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 10:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vc4Nv1UCPS28NNVDYePaLaV2Wpsm+mIPEHiAzrTw9MM=;
        b=hC8rifHiuHXCPgttcmOOf/xO+1ZeeDOeIZfW9Ym8Ory+CkzNJPkrfO/C3JXy2EE1LL
         2kTaAysayLbTpr+7RDLLrKq0FCECx/EKRPZa3mKY+K67nyLJZ8f7PA4gCRWG73mV4Yn4
         5cdNgXBpvhk8M9iRXw8+R8fW3tOu/c3Ashp10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vc4Nv1UCPS28NNVDYePaLaV2Wpsm+mIPEHiAzrTw9MM=;
        b=QQpHFO1ZN3pbm+zaYJUorAfPAOM0pMU1mO97f/dq1efEVlFriFOWHwR/JLFTaBWYis
         sNuFEdVIWVtLT4xH//uz7RbjUNvxChR+w6+8sQlUGf/OeKy1AdSqWw6/DSlohhoDcluo
         Dkyc40QCpUFSQgjqNfO6cl6t/V0GuzS82OsmuyQp+X3/Q+B5oVhku5iDkT57uWBWn2k1
         1pEwl0B3szvFBoEjCF+rr/6GDTSR0wGQN1nlWIApO5XEzHHX8Vssq2u5N01QUZy+NhzR
         c08IZgI+Jc0Rgcmgx/rHI75KbGmLLyGCRvHsher/X90x9vCS5xTPZXoWadEJZYas9Jqr
         8mnQ==
X-Gm-Message-State: AFqh2kqGOPQoCEoJkMkZg83W7diKtXNzAR0bOzXfcWb8EYV+aH0dlN97
        7/lHhn0rKiElXnLh45W/MBaPqoB0V8/ot3qq
X-Google-Smtp-Source: AMrXdXvI8b3BXT71lCUrE4HSG+Gj5j1Wp/oInpCCm4B+P3G7kIMjczklQyM1Tn0P1iQ9MVkoHO8JIw==
X-Received: by 2002:ac8:4818:0:b0:3b6:2bb3:fb53 with SMTP id g24-20020ac84818000000b003b62bb3fb53mr9949079qtq.16.1673892074216;
        Mon, 16 Jan 2023 10:01:14 -0800 (PST)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com. [209.85.160.175])
        by smtp.gmail.com with ESMTPSA id u2-20020a05620a0c4200b006f9f3c0c63csm18724183qki.32.2023.01.16.10.01.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 10:01:09 -0800 (PST)
Received: by mail-qt1-f175.google.com with SMTP id jr10so17952441qtb.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 10:01:09 -0800 (PST)
X-Received: by 2002:a05:622a:250f:b0:3b2:d164:a89b with SMTP id
 cm15-20020a05622a250f00b003b2d164a89bmr364175qtb.452.1673892068650; Mon, 16
 Jan 2023 10:01:08 -0800 (PST)
MIME-Version: 1.0
References: <1673235231-30302-1-git-send-email-byungchul.park@lge.com>
In-Reply-To: <1673235231-30302-1-git-send-email-byungchul.park@lge.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 Jan 2023 10:00:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=whpkWbdeZE1zask8YPzVYevJU2xOXqOposBujxZsa2-tQ@mail.gmail.com>
Message-ID: <CAHk-=whpkWbdeZE1zask8YPzVYevJU2xOXqOposBujxZsa2-tQ@mail.gmail.com>
Subject: Re: [PATCH RFC v7 00/23] DEPT(Dependency Tracker)
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     linux-kernel@vger.kernel.org, damien.lemoal@opensource.wdc.com,
        linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
        will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
        joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
        duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org,
        tytso@mit.edu, willy@infradead.org, david@fromorbit.com,
        amir73il@gmail.com, gregkh@linuxfoundation.org,
        kernel-team@lge.com, linux-mm@kvack.org, akpm@linux-foundation.org,
        mhocko@kernel.org, minchan@kernel.org, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, sj@kernel.org, jglisse@redhat.com,
        dennis@kernel.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, vbabka@suse.cz, ngupta@vflare.org,
        linux-block@vger.kernel.org, paolo.valente@linaro.org,
        josef@toxicpanda.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com,
        42.hyeyoo@gmail.com, chris.p.wilson@intel.com,
        gwan-gyeong.mun@intel.com
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

[ Back from travel, so trying to make sense of this series.. ]

On Sun, Jan 8, 2023 at 7:33 PM Byungchul Park <byungchul.park@lge.com> wrote:
>
> I've been developing a tool for detecting deadlock possibilities by
> tracking wait/event rather than lock(?) acquisition order to try to
> cover all synchonization machanisms. It's done on v6.2-rc2.

Ugh. I hate how this adds random patterns like

        if (timeout == MAX_SCHEDULE_TIMEOUT)
                sdt_might_sleep_strong(NULL);
        else
                sdt_might_sleep_strong_timeout(NULL);
   ...
        sdt_might_sleep_finish();

to various places, it seems so very odd and unmaintainable.

I also recall this giving a fair amount of false positives, are they all fixed?

Anyway, I'd really like the lockdep people to comment and be involved.
We did have a fairly recent case of "lockdep doesn't track page lock
dependencies because it fundamentally cannot" issue, so DEPT might fix
those kinds of missing dependency analysis. See

    https://lore.kernel.org/lkml/00000000000060d41f05f139aa44@google.com/

for some context to that one, but at teh same time I would *really*
want the lockdep people more involved and acking this work.

Maybe I missed the email where you reported on things DEPT has found
(and on the lack of false positives)?

               Linus
