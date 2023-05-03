Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9321B6F5D7B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 20:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjECSEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 14:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjECSEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 14:04:33 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6420D26A0
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 11:04:32 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a8075bd7cso9484632276.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 11:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683137071; x=1685729071;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WX9b5D7rzQ77/+awqXVJW5yY30EN/bdP/BzW/WEcv4Y=;
        b=LdwlmBbdlsfaGXWQgwsVRjR/EWY38T58sSfiKFEZbOA4CQgTYko1AoCJO4k625/3iM
         ViTDM2Preuu2ZBeNcdAkUhvF3+HFiWN1DPHRkfYcbQCRa8+FL1gc7dMkqyZ7isrbDKBD
         dtkCrQbPmCuYE4+f9eNBZffM1E8qDOeCbWmpdnm35HNjLN9VnrgwgSQhIKpBryY2L8Y/
         TsR9+zdxk/w8Wc2tpa1ve9nu6rNHFw6GJTrJhsXXMTpcR9qJvMTPNWF+vrr7KfJZpq13
         vmfVBu7L+13cGlpFMLapZMacnXnh+OKaC7iUt/6FX+HbKhzBqql5LWlZF50t57n4ufzG
         sLww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683137071; x=1685729071;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WX9b5D7rzQ77/+awqXVJW5yY30EN/bdP/BzW/WEcv4Y=;
        b=LcDJLo/XJvyOPkna6VydPdAofpxctnb/tyIrUVFB6uh8a5YJujoMi/R0qZY2/PxYzT
         23d36W1OskvH1az1MeYJA8O2XWIbFYpO9NHSPr2cpq5msufSmu4Lqj0vlmbb+3IIrhOd
         /CiSep/XFpS0Z/xwaOzBzX1ur7D3yWjGXVHWY0LOAGD98G1V+4ZtXVyYZ+sn0WByRCrT
         yqjYMDUecTT0GwswBWlfrEWtty1i39VEr+Ck39K7vHaGeMbhaR6e6TptGUWzzReKnxyu
         5O8jCOaOtJiVoSIGvc00Iig6l70BmnC9RosCRjipqPBdlNq81bROJQfzRmtGrTn8fM1Z
         mGTQ==
X-Gm-Message-State: AC+VfDztiqV5uSFuwdH5cMBV2QLgAI10rDWcs8212hCpkOhZq0PZj0DJ
        a2ctoQ2OXWDhn3AXbvkMEfok0fxUKt+i0w==
X-Google-Smtp-Source: ACHHUZ75gS2CinsTSMqWseG9Yhdce5hS2/KSVhhbpmN58hBLBR2Mt3rETgJY5dRV7ts5FMoW0EG0L8iwrBcM5w==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a25:42c9:0:b0:b98:6352:be16 with SMTP id
 p192-20020a2542c9000000b00b986352be16mr8678629yba.5.1683137071660; Wed, 03
 May 2023 11:04:31 -0700 (PDT)
Date:   Wed, 3 May 2023 18:04:29 +0000
In-Reply-To: <20230428132406.2540811-3-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230428132406.2540811-1-yosryahmed@google.com> <20230428132406.2540811-3-yosryahmed@google.com>
Message-ID: <20230503180429.zxgq4h5rc6gonikm@google.com>
Subject: Re: [PATCH v2 2/2] memcg: dump memory.stat during cgroup OOM for v1
From:   Shakeel Butt <shakeelb@google.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <muchun.song@linux.dev>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>, Chris Li <chrisl@kernel.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 01:24:06PM +0000, Yosry Ahmed wrote:
> Commit c8713d0b2312 ("mm: memcontrol: dump memory.stat during cgroup
> OOM") made sure we dump all the stats in memory.stat during a cgroup
> OOM, but it also introduced a slight behavioral change. The code used to
> print the non-hierarchical v1 cgroup stats for the entire cgroup
> subtree, now it only prints the v2 cgroup stats for the cgroup under
> OOM.
> 
> For cgroup v1 users, this introduces a few problems:
> (a) The non-hierarchical stats of the memcg under OOM are no longer
> shown.
> (b) A couple of v1-only stats (e.g. pgpgin, pgpgout) are no longer
> shown.
> (c) We show the list of cgroup v2 stats, even in cgroup v1. This list of
> stats is not tracked with v1 in mind. While most of the stats seem to be
> working on v1, there may be some stats that are not fully or correctly
> tracked.
> 
> Although OOM log is not set in stone, we should not change it for no
> reason. When upgrading the kernel version to a version including
> commit c8713d0b2312 ("mm: memcontrol: dump memory.stat during cgroup
> OOM"), these behavioral changes are noticed in cgroup v1.
> 
> The fix is simple. Commit c8713d0b2312 ("mm: memcontrol: dump memory.stat
> during cgroup OOM") separated stats formatting from stats display for
> v2, to reuse the stats formatting in the OOM logs. Do the same for v1.
> 
> Move the v2 specific formatting from memory_stat_format() to
> memcg_stat_format(), add memcg1_stat_format() for v1, and make
> memory_stat_format() select between them based on cgroup version.
> Since memory_stat_show() now works for both v1 & v2, drop
> memcg_stat_show().
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Acked-by: Shakeel Butt <shakeelb@google.com>
