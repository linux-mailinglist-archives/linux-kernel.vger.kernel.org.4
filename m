Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42EFA65E2AF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 02:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjAEBvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 20:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjAEBvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 20:51:35 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E045518B1D
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 17:51:33 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id l26so25397155wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 17:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IirUxu2i21YNeIdj8kf2wbOWwBWYoEk/wPemobzcaoI=;
        b=BrMZFdTJFtdPzXCAO90mIl+fhIExYIjx1e642jyDfsvYssWic0/opcB8mUXWwNjQAd
         KIhS/+5/IULJF3Vr0C64JxB+Utfle2LOubr+iwJQiiah4EQkiIjMWQjzb2Xx/RyQahu1
         3FbHn0P7zVJmI0hKFEzRoa4fmM5coPjTO0+VNeuphABwuXH3qsUsZkZiJnwM2f6qXRPC
         2xQB2YYo2xQDCktuQqRWejS5oFe5Jy1SemPmqeBu7bx5q/9pM56Fi6yMzBkpTevNWwb4
         tSioHhj1AXjPlKjknGPR3S5tFYpzStKkqON5C/0HjxHK1TZmuW7b8d292pjVrdKL3tiE
         5Cjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IirUxu2i21YNeIdj8kf2wbOWwBWYoEk/wPemobzcaoI=;
        b=nW2Q3H3bLRW/8kfI0aGml2jbRerTBQJsORRfhpLyfDZUMD5g2k5ASzQj4xvDm3kwSx
         W55savJG/U36TbhVdkpSPAbh5BMeNSJ+Pt+TjrRG810NMMf0t1dn/39O+k/Mx9W0a38z
         dG441hU+D4DaPLzWkgFLajxfZswtWxH9gS5t0QQFKrkKIDLwc83EBYgpIXIQ6uaqHdtE
         E13lj0EpFhNSuNNToo4b82ZCCwceUQxHdag1LTkCkU/Db6CBwjUwsG/9RktoMGWxEAov
         f+J/RRRpAy4DIi9rNxOJtMdcvcaBNjUAebTv+YL5LrgV/yB17LBGQCHJr0KoeKra3P9T
         8GRg==
X-Gm-Message-State: AFqh2krdWlyaybiyc4BlEPo4IcjyMXitCgfvuxWS1+16w4Ag3Ug2SpxX
        ljdv+2ebtJJJxFNLiZpU7LReRf/cujwvdft8y86wAg==
X-Google-Smtp-Source: AMrXdXtFdsRL0O3hQoigjYTiizqcgIalrZKLHFGxzTBi7BlZo3345hGXF1Bv1RtfC0pRosDiC+nh07UNVc6Y3iEGpMA=
X-Received: by 2002:a05:600c:3d95:b0:3d9:94fd:944f with SMTP id
 bi21-20020a05600c3d9500b003d994fd944fmr1855724wmb.38.1672883492400; Wed, 04
 Jan 2023 17:51:32 -0800 (PST)
MIME-Version: 1.0
References: <20230104225207.1066932-1-peterx@redhat.com> <20230104225207.1066932-3-peterx@redhat.com>
In-Reply-To: <20230104225207.1066932-3-peterx@redhat.com>
From:   James Houghton <jthoughton@google.com>
Date:   Thu, 5 Jan 2023 01:51:19 +0000
Message-ID: <CADrL8HUmAuez9Zighe21DVB6KxvUMUx6ONvwEyxovOq0vMHeJw@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm/mprotect: Use long for page accountings and retval
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
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

On Wed, Jan 4, 2023 at 10:52 PM Peter Xu <peterx@redhat.com> wrote:
>
> Switch to use type "long" for page accountings and retval across the whole
> procedure of change_protection().
>
> The change should have shrinked the possible maximum page number to be half
> comparing to previous (ULONG_MAX / 2), but it shouldn't overflow on any
> system either because the maximum possible pages touched by change
> protection should be ULONG_MAX / PAGE_SIZE.
>
> Two reasons to switch from "unsigned long" to "long":
>
>   1. It suites better on count_vm_numa_events(), whose 2nd parameter takes
>      a long type.
>
>   2. It paves way for returning negative (error) values in the future.
>
> Currently the only caller that consumes this retval is change_prot_numa(),
> where the unsigned long was converted to an int.  Since at it, touching up
> the numa code to also take a long, so it'll avoid any possible overflow too
> during the int-size convertion.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/linux/hugetlb.h |  4 ++--
>  include/linux/mm.h      |  2 +-
>  mm/hugetlb.c            |  4 ++--
>  mm/mempolicy.c          |  2 +-
>  mm/mprotect.c           | 26 +++++++++++++-------------
>  5 files changed, 19 insertions(+), 19 deletions(-)

Acked-by: James Houghton <jthoughton@google.com>
