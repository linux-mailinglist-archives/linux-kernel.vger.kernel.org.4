Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C385A6F5D54
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 19:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjECRwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 13:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjECRwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 13:52:30 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4B57A93
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 10:52:28 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-55a9614c154so41222797b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 10:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683136348; x=1685728348;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RZYSjSUR1TVNLCONU/ktPYm4b5B8g2ry+YtlqDqVDwA=;
        b=06jHQvfsD3SDUJMSu6ULA+Lqi2Rheb3urP5pez8MV1dafSxYy0/iecp7i3W9YM8kw0
         Z8sDp7LJx6LxY6887Lp9tpfA2PRnZ+5qsmf/2ne9kOhMV6oNSgGhzuXqwMC3i6HQpw8p
         D8X9p8yhzKfJ/bgSYEC5uIPGefibu0HxTKSIOIWINb3PnNySA5vrkGDdfiFHPxJVa3eg
         fzeTNSZPX/rk1YdIOuq6L93DdQc6YUPO6bt/7O5Wu9R3mWPc7MGSncLmqdQi7vfNKPNv
         eNUJWumFkZPqhtINkPq+WqdkN0g7gmfclLzeSV9JpuQEB/g+6NsZV9V3lB08IqjbYy4P
         Yf/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683136348; x=1685728348;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RZYSjSUR1TVNLCONU/ktPYm4b5B8g2ry+YtlqDqVDwA=;
        b=MxcEocSlPbaTFSzraQfaMWqAfguK792/4Hd7atEs4wrz/kg5DjlbMwaJQpGCA4EGvo
         XUUWlgoJcj7AWpgv5OUHQjEkBxq6cUfhuSeh/A+9xkClCOFT+kTlxuxqtKMADnwFwzGc
         1msMQ23/+frGip3F59jOffb9zxkZlTqRtNjHvebmricZ1mvGmsCc3PsAaClh7Zwt895a
         sh/yNjCuRWM/Aii6jRCu4hE2wXmBtOdw20ygso+y/+eo4jpBj2ruvp6Lnd9+VBdwbUV1
         8TQ7mamTqOjI9rISNrP9HEEn9AJTUx+5tV5AKOedPHGlWbrgDTOlvEScH/PdsFLrRe1Y
         AI/g==
X-Gm-Message-State: AC+VfDz6x2tTCiGwHvRBGe+W17MA+B8k4AHSmbyExC3JmmxrGvgShARV
        /QlJHMRRJGVWD/4Fy9u2PfH/8PhA3KJ/wA==
X-Google-Smtp-Source: ACHHUZ59iAxehhHtXCF+bq4Cz843yfeiUKwoHIntE4kQjpxt94wcmUOFlOiSBWPXCkx4jhERPUtGCVXYZdfeOw==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a81:4054:0:b0:534:d71f:14e6 with SMTP id
 m20-20020a814054000000b00534d71f14e6mr12118393ywn.9.1683136347929; Wed, 03
 May 2023 10:52:27 -0700 (PDT)
Date:   Wed, 3 May 2023 17:52:26 +0000
In-Reply-To: <20230428132406.2540811-2-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230428132406.2540811-1-yosryahmed@google.com> <20230428132406.2540811-2-yosryahmed@google.com>
Message-ID: <20230503175226.nyjmmbnohm6xxckd@google.com>
Subject: Re: [PATCH v2 1/2] memcg: use seq_buf_do_printk() with mem_cgroup_print_oom_meminfo()
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
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>
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

On Fri, Apr 28, 2023 at 01:24:05PM +0000, Yosry Ahmed wrote:
> Currently, we format all the memcg stats into a buffer in
> mem_cgroup_print_oom_meminfo() and use pr_info() to dump it to the logs.
> However, this buffer is large in size. Although it is currently working
> as intended, ther is a dependency between the memcg stats buffer and the
> printk record size limit.
> 
> If we add more stats in the future and the buffer becomes larger than
> the printk record size limit, or if the prink record size limit is
> reduced, the logs may be truncated.
> 
> It is safer to use seq_buf_do_printk(), which will automatically break
> up the buffer at line breaks and issue small printk() calls.
> 
> Refactor the code to move the seq_buf from memory_stat_format() to its
> callers, and use seq_buf_do_printk() to print the seq_buf in
> mem_cgroup_print_oom_meminfo().
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Acked-by: Shakeel Butt <shakeelb@google.com>
