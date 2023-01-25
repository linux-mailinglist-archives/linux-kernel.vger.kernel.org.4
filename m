Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F7367BDF3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 22:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236386AbjAYVRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 16:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236270AbjAYVR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 16:17:27 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9336EA1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 13:17:26 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id y8so70396vsq.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 13:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xhEj0ecjM7cSjnvuBd79LLiX+26nUJXEiUiAKz61nJk=;
        b=fV0SYXNjzoEPh1a7N4K904crx99hLBfEDspge7oX9PjvzXpz9Wx8O45jJCvo0vDSMv
         BzPRtSEVeTYNGDSxgZo9FeJJU8Iguk2INlZ8CyAYmw8IdrJ6KY3B6hrlpKMeMM4Sh4Um
         uLtYI4tKj1A94feQPW6qAX34vqxW7GMGrFW8Y7JwoJVhutC42W51T8oDTJw7ZDQ+XOjO
         au+4E/M4iJHFNMU2wkQJHtZ3FapN8GFkjVZpT3xDo7YEmDO4AO34h2tVrPmRl1EfJcO7
         Y3u7evWqtaTWI5Zx0V6XXd543l6DOA2KFlXeJVuHycOo5dei2EhDvQAm8raOfEgvwLiD
         rb2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xhEj0ecjM7cSjnvuBd79LLiX+26nUJXEiUiAKz61nJk=;
        b=OKkUVSSwe8MbmEPi+fxFCkywDcBguoCxZxY557KJVU77KqWeEig/gpnJkBEY1g0F91
         xAIi5bcg57qCqn3+cF5rEYJikvtCbO8OvBavbwS29g+/gh0Xo48fWYbbG1SuSZX+iDnF
         lY2NQicLQ777Z00n4OH35lLtPVwRc9J3I51pm/4uQS/LRtvCJ3G0mA4odbSDkLsNjEVJ
         uEOWZ1552E2vTzELqrp0bIbcRfLQn9kGSKLd/bqY1zEGnIVKytwXuX6JCWa0A/hz4i1S
         2DO14lbvnaey7FTkuOBIzumSMLBqlxVGYW4oBaRwPf3/VDZboN8D0C2rEHH9tntSw/35
         x1ig==
X-Gm-Message-State: AO0yUKVfQ0PvuEIhCcB56kfw6nTFDXPvIiPLIocccmkxX5Zk1T3AoIYu
        zC1zjMmRD85PjCU/+aY3rZRRqaXbA+d7aC8ZO0o5jg==
X-Google-Smtp-Source: AK7set9k+ns7ffiIMvA46ncdnPa9tHOlZ/nAfySxrqWx33QwS1ix68C+QfLDiUOHPWxPO74DhvjFBXOy4surByJM778=
X-Received: by 2002:a67:d092:0:b0:3e8:43d8:9a47 with SMTP id
 s18-20020a67d092000000b003e843d89a47mr534352vsi.15.1674681445592; Wed, 25 Jan
 2023 13:17:25 -0800 (PST)
MIME-Version: 1.0
References: <20230118001827.1040870-1-talumbau@google.com>
In-Reply-To: <20230118001827.1040870-1-talumbau@google.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 25 Jan 2023 14:16:49 -0700
Message-ID: <CAOUHufYS+wPjgdFsnR0YG=tdTXDdayWFaA-WBVmrbiWsvn1YwQ@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v1 0/7] mm: multi-gen LRU: improve
To:     "T.J. Alumbaugh" <talumbau@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-mm@google.com
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

On Tue, Jan 17, 2023 at 5:18 PM T.J. Alumbaugh <talumbau@google.com> wrote:
>
> This patch series improves a few MGLRU functions, collects related
> functions, and adds additional documentation.
>
> T.J. Alumbaugh (7):
>   mm: multi-gen LRU: section for working set protection
>   mm: multi-gen LRU: section for rmap/PT walk feedback
>   mm: multi-gen LRU: section for Bloom filters
>   mm: multi-gen LRU: section for memcg LRU
>   mm: multi-gen LRU: improve lru_gen_exit_memcg()
>   mm: multi-gen LRU: improve walk_pmd_range()
>   mm: multi-gen LRU: simplify lru_gen_look_around()
>
>  Documentation/mm/multigen_lru.rst |  78 ++++-
>  include/linux/mm_inline.h         |  17 -
>  include/linux/mmzone.h            |  13 +-
>  mm/memcontrol.c                   |   8 +-
>  mm/vmscan.c                       | 534 ++++++++++++++++--------------
>  5 files changed, 360 insertions(+), 290 deletions(-)

LGTM, thanks.

The design doc is still missing two sections (PID and mm_struct list),
and someone from our team will follow up on that.
