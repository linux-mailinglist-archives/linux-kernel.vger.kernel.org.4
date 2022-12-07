Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BE6644FFA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 01:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiLGAEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 19:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiLGAEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 19:04:08 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD23864C2
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 16:04:06 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-3b48b139b46so169444207b3.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 16:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XnTgKg0UKBuUXCDS87fs4ThlofePgHVyLSIXWjERYso=;
        b=XrKy6coLfblQF02e3gM/AreF7bPpcfKkj30gZ0BhpESnFNZhQXBj/1CzMypZxtTnGR
         pbY/A/7RzNHkPzaMcpiNPbFf6ZpHCRK7eY5eQR1kJ1lswapS6MX5WK2mHkk9ltic1sHY
         tXyB+96tOJdcoZ1EpjuOQDi+VSUYqt98XsfwE1NbwUL8SHEuuoUwaPrzGHwQ3peCx1sL
         wDWpsKc4QIwYNyI6YRdi3/hZg4OMKbyKHNf6k7ZmGLW9pQZEkCt8yutE+CjIewQOQKAP
         aYba8W+HEW9996FyuVrK0OAFQVKqn32hG6hYDHTErCiQxFPrvisnRJXBAJ7DhsWLBhlz
         c61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XnTgKg0UKBuUXCDS87fs4ThlofePgHVyLSIXWjERYso=;
        b=wC2GuWvj5en4/MaAgu36fBuiwsUOcTWEDpldTAUB+/oUbRCg+qaxQG6g3G47BMium7
         eLwMlSWfcIXFI4+WWV4xIcU1QteteEGoQxMe8FhJghPJJGt+21tu00DM0aY8a6Ndvgt5
         2336QXuMDrNx5VqpOHW6v99UAbyWcQ6yWMIiviu00NWi2dogtSSV/exSGo/muVgEyPmt
         gLrwTyIuM/Wc4seCKT2GLIwHG7YVGe7+crxOzJ5LLF6LR1Mfe+oVmlGZisy7j4tRawLZ
         F5FOeKKDVQDHBD9Y2MznXvyOAGV7F4opuJFTdROCFip8BEuMoUkKQieJ3o1AUbFHkZhp
         yJKg==
X-Gm-Message-State: ANoB5pkiPn1zu2HWI4Gi+XDEL5vm08KW5Oy6MB17PoZfWDn+iGPqaUhr
        LYS70yFqX3kazquQNCnJtsfwFs+YmcoTfGZTEfPY4A==
X-Google-Smtp-Source: AA0mqf7+mQ2HzSsiOUnt2yepW4ZOc0QKPbLU/FYyjl8gV8gnkERQwvOrB3JYfDa+Tm1HnvZ8u+dQS4ZEv8h0ypB3Bic=
X-Received: by 2002:a0d:d80c:0:b0:3ca:b34:9ce1 with SMTP id
 a12-20020a0dd80c000000b003ca0b349ce1mr39254464ywe.466.1670371445945; Tue, 06
 Dec 2022 16:04:05 -0800 (PST)
MIME-Version: 1.0
References: <20221206171340.139790-1-hannes@cmpxchg.org> <20221206171340.139790-4-hannes@cmpxchg.org>
In-Reply-To: <20221206171340.139790-4-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 6 Dec 2022 16:03:54 -0800
Message-ID: <CALvZod6WcBifeWJYG_QLr9Uy5aSbpLoCVyOp+FVx0ca1gzq4fA@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm: memcontrol: deprecate charge moving
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 6, 2022 at 9:14 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> Charge moving mode in cgroup1 allows memory to follow tasks as they
> migrate between cgroups. This is, and always has been, a questionable
> thing to do - for several reasons.
>
> First, it's expensive. Pages need to be identified, locked and
> isolated from various MM operations, and reassigned, one by one.
>
> Second, it's unreliable. Once pages are charged to a cgroup, there
> isn't always a clear owner task anymore. Cache isn't moved at all, for
> example. Mapped memory is moved - but if trylocking or isolating a
> page fails, it's arbitrarily left behind. Frequent moving between
> domains may leave a task's memory scattered all over the place.
>
> Third, it isn't really needed. Launcher tasks can kick off workload
> tasks directly in their target cgroup. Using dedicated per-workload
> groups allows fine-grained policy adjustments - no need to move tasks
> and their physical pages between control domains. The feature was
> never forward-ported to cgroup2, and it hasn't been missed.
>
> Despite it being a niche usecase, the maintenance overhead of
> supporting it is enormous. Because pages are moved while they are live
> and subject to various MM operations, the synchronization rules are
> complicated. There are lock_page_memcg() in MM and FS code, which
> non-cgroup people don't understand. In some cases we've been able to
> shift code and cgroup API calls around such that we can rely on native
> locking as much as possible. But that's fragile, and sometimes we need
> to hold MM locks for longer than we otherwise would (pte lock e.g.).
>
> Mark the feature deprecated. Hopefully we can remove it soon.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Shakeel Butt <shakeelb@google.com>

I would request this patch to be backported to stable kernels as well
for early warnings to users which update to newer kernels very late.
