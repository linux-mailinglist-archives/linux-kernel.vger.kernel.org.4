Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE036EF599
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 15:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240958AbjDZNj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 09:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240627AbjDZNjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 09:39:24 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A33B199
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 06:39:23 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-2479c766e91so4201359a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 06:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682516362; x=1685108362;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FB4DXeiyaGWRGpg1RZJs4YrYQeUFxP8q5oC/iiUzgWk=;
        b=emGe3v+hKdvQrvjl4a2uL61Vidypm6iAFv9LSm15rGZal80ihx30dhzmaX4DR2L5FI
         tzvhVTsOh4fiIVKvw8+UJCzuQDaHqPwEDZnDfNM9fcc/5zhQ7ZE02esGSLVrOacFGa2w
         PbUcgEDLQnqqBYxN8oTZvoL/7EkcSB7Fmoc93quhvb+ktB1bnrmZe3xDyxBjM3c6j1rK
         SAP7DHJ7DGgrwr66cJZRVAOm37uuP+EvleqsdnJUlRGJOdNwzmWm5u2YBeR8mCuVrKsp
         +4dbdz//BxR2iJejLqq+0lkxEiAE1VA6eocg/jtU4SCC2xkrltYe/xm1xPFS9I+qR8OR
         Tllw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682516362; x=1685108362;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FB4DXeiyaGWRGpg1RZJs4YrYQeUFxP8q5oC/iiUzgWk=;
        b=VS7Y2zfEm0nW+eJxolhp+0fe3Wx0PNyU5w6gHUe5qFb/W/ckMg8hpJTMF+AbQbFs0q
         IwYPQJ/2Zd2DJRkew23oxkxAfhGFUIcuXs900bA4VD6gje2qgeEk3q+t9lQBQbYB7lLe
         QwdjqZXXdR354MkPZfboU1h2dKqEC8tBDZF6YSnDVKzB6LCbGpWovueaBVxzOrUZfcmD
         I5csquzC5UbwwixBuc7qXeP5g6efhF4vn34Nt7TBfURQ4hKpHJsXHS/PdSp0gQWqfG7a
         ThKEzckdIAFvL7lP4Qbuektq/epAHxKrmNmE4TIrwYy/JN9NLkKXSuBzeDVfu1Lg++hq
         jxOQ==
X-Gm-Message-State: AAQBX9eFG3gVh+c7uyS097fV2zMDk4eeA0T7Qe0A/BZaHlJBkuXROnN+
        i5vPDLZUTuMO/qp7z5cMKh9V3MB5m4+G4+Jc
X-Google-Smtp-Source: AKy350ZjfZ+BIfyJNqEXcvm2T/R2eUKq4ijsukzf0jNghkcUNvTJFaoDf4KZq6ppxB2RiGelh8+DxoA0H1jlZhsC
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:90a:748e:b0:247:101f:954e with SMTP
 id p14-20020a17090a748e00b00247101f954emr4760228pjk.9.1682516362678; Wed, 26
 Apr 2023 06:39:22 -0700 (PDT)
Date:   Wed, 26 Apr 2023 13:39:17 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230426133919.1342942-1-yosryahmed@google.com>
Subject: [PATCH 0/2] memcg: OOM log improvements
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Muchun Song <muchun.song@linux.dev>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>, Chris Li <chrisl@kernel.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This short patch series brings back some cgroup v1 stats in OOM logs,
and it makes memcg OOM logging less reliant on printk() internals.

The series uses seq_buf_do_printk() which was only recently introduced
[1]. It did not land in Linus's tree yet, but ideally it will land this
merge window. I thought I would share the patches meanwhile for
feedback.

[1]https://lore.kernel.org/lkml/20230415100110.1419872-1-senozhatsky@chromium.org/

Yosry Ahmed (2):
  memcg: use seq_buf_do_printk() with mem_cgroup_print_oom_meminfo()
  memcg: dump memory.stat during cgroup OOM for v1

 mm/memcontrol.c | 85 ++++++++++++++++++++++++++++---------------------
 1 file changed, 48 insertions(+), 37 deletions(-)

-- 
2.40.1.495.gc816e09b53d-goog

