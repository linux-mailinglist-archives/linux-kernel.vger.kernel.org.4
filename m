Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12ED26C2378
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 22:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjCTVSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 17:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjCTVSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 17:18:07 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCAB25BBE
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 14:18:04 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id x33so8896559uaf.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 14:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679347083;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5IvFJkz4xXPLrE84iMMtruUbePf5QczlPra34R4OXp0=;
        b=nZYdn+Aa1fFcVsAAereOGykoJrIOYxmbLsMUG7jufA9uKW0TPVF/qLEuTuU02IqYUs
         tfUBL4xI4vOdqdeNm401TuiahWGaack/BSF9OOCAGX21cFW1SyRaZ78hh+U0CGBNpUhw
         MzHMFG6tFQt6kurKFncTc6lt7pAykvlYAPzb6NoKfJ1tSShh5qvzlZByFHmNKT8oIl9C
         Y9YiI7RkgUHyWm5Sg7QCuGtnk106x714Zs2Tf46GRz0kHA6eh7zkg5ElVWMsa7xmgeQf
         vQ7LeLgWbIqRD2KwuIsERC3n2trahGwMOG0hk2y+upq1DzG+u2a/rzAi+9HtmlF8eiJg
         1GRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679347083;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5IvFJkz4xXPLrE84iMMtruUbePf5QczlPra34R4OXp0=;
        b=70CRTB5OYyV7VKdfgML/siD5pyzTdQzJBVJPuA/DGoHU0TXGfhTHi0Q9//8b1G0ucZ
         G3/qngF4UrSwN45xG5uxw4ZUv+bG9ZmuEcYP0L2GOT10VLWC2uCfgsPuQeuFQ4Blyo3f
         pzrnfgLr0Frhn+MWma52URXYilVFjQkhzbhfhLMRfLmfbcyhz9hABJ64us1LsoQEkR7/
         83b49UJLiI5ugvkwPlH1/rPFH/8yGnHoUILr5YgfID5Dsplw6GP+Zaor7OG+MIOcD113
         sbWqEN5NKjnQbgLMfugcbzhDFH7wK+m6wUk+ISFJYLCrFQFu6Qrr7RWM/xxCkwO6jyKM
         UfgQ==
X-Gm-Message-State: AO0yUKV8W+1QeXlbq+4AWdC+E2vhdNQljY04rXGdbRse2eeq7cU2sspz
        DVGnFBrouUOKvF2Yt6CZY41uQvFd9gDCTdTV/qzohg==
X-Google-Smtp-Source: AK7set+9CDk5ojrH5wfy0FcPHc18eGX5b6uWdDnvl+XY1Ys6yHtCETtWBdu6KwJPkQ59ebm7l0N/VzvpzbDOBIJIEkk=
X-Received: by 2002:a1f:2144:0:b0:432:9a63:1696 with SMTP id
 h65-20020a1f2144000000b004329a631696mr53396vkh.1.1679347083020; Mon, 20 Mar
 2023 14:18:03 -0700 (PDT)
MIME-Version: 1.0
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 20 Mar 2023 14:17:50 -0700
Message-ID: <CANn89iLy+-rQDSKCg6g=xkNLL5SmgkB7gyMSgxCEPp13-+eLbw@mail.gmail.com>
Subject: syzbot + epoll
To:     Paolo Abeni <pabeni@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Xiumei Mu <xmu@redhat.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is about this recent syzbot report (with a C repro)

https://lore.kernel.org/lkml/000000000000c6dc0305f75b4d74@google.com/T/#u

I think this is caused by:

commit fc02a95bb6d8bf58c6efd7e362814558eea2ef28
Author: Paolo Abeni <pabeni@redhat.com>
Date:   Tue Mar 7 19:46:37 2023 +0100

    epoll: use refcount to reduce ep_mutex contention

Problem is that __ep_remove() might return early, without removing epi
from the rbtree (ep->rbr)

This happens when epi->dying has been set to true here :

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/fs/eventpoll.c?id=6f72958a49f68553f2b6ff713e8c8e51a34c1e1e#n954

So we loop, while holding the ep->mtx held, meaning that the other
thread is blocked here

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/fs/eventpoll.c?id=6f72958a49f68553f2b6ff713e8c8e51a34c1e1e#n962

So this dead locks.

Maybe fix this with:

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 25a59640748a0fd22a84a5aecb90815fbbca9cef..1db56c6175aab5af7bc637a452b68ed8bc11fd7f
100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -784,7 +784,7 @@ static void ep_remove_safe(struct eventpoll *ep,
struct epitem *epi)

 static void ep_clear_and_put(struct eventpoll *ep)
 {
-       struct rb_node *rbp;
+       struct rb_node *rbp, *next;
        struct epitem *epi;
        bool dispose;

@@ -810,7 +810,8 @@ static void ep_clear_and_put(struct eventpoll *ep)
         * Since we still own a reference to the eventpoll struct, the
loop can't
         * dispose it.
         */
-       while ((rbp = rb_first_cached(&ep->rbr)) != NULL) {
+       for (rbp = rb_first_cached(&ep->rbr); rbp; rbp = next) {
+               next = rb_next(rbp);
                epi = rb_entry(rbp, struct epitem, rbn);
                ep_remove_safe(ep, epi);
                cond_resched();
