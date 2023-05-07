Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B7C6F9689
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 04:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjEGCEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 22:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjEGCEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 22:04:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40AC1A112
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 19:04:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79D3E61254
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 02:04:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D7DC4339B;
        Sun,  7 May 2023 02:04:37 +0000 (UTC)
Date:   Sat, 6 May 2023 22:04:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Li kunyu <kunyu@nfschina.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: core: Simplify init_sched_mm_cid()
Message-ID: <20230506220435.0d7238c8@rorschach.local.home>
In-Reply-To: <20230507023352.2784-1-kunyu@nfschina.com>
References: <20230507023352.2784-1-kunyu@nfschina.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  7 May 2023 10:33:52 +0800
Li kunyu <kunyu@nfschina.com> wrote:

> int mm_users variable definition move to variable usage location.

Why?

> 
> Signed-off-by: Li kunyu <kunyu@nfschina.com>
> ---
>  kernel/sched/core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index f341e2100304..a66960da3f5c 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -11910,10 +11910,9 @@ static void task_mm_cid_work(struct callback_head *work)
>  void init_sched_mm_cid(struct task_struct *t)
>  {
>  	struct mm_struct *mm = t->mm;
> -	int mm_users = 0;
>  
>  	if (mm) {
> -		mm_users = atomic_read(&mm->mm_users);
> +		int mm_users = atomic_read(&mm->mm_users);

This is not a requirement, and not everyone prefers this method.

If anything, a real cleanup would simply be to remove the "= 0" and
just have it be:

	int mm_users;

As there's no reason to initialize it to zero.

-- Steve

>  		if (mm_users == 1)
>  			mm->mm_cid_next_scan = jiffies + msecs_to_jiffies(MM_CID_SCAN_DELAY);
>  	}

