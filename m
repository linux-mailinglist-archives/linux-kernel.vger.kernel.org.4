Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859C768DC9E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 16:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbjBGPL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 10:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbjBGPLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 10:11:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246453BD83
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 07:11:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B317D60DBA
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 15:11:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 580B7C433D2;
        Tue,  7 Feb 2023 15:11:19 +0000 (UTC)
Date:   Tue, 7 Feb 2023 10:11:17 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Pietro Borrello <borrello@diag.uniroma1.it>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Phil Auld <pauld@redhat.com>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Dmitry Adamushko <dmitry.adamushko@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jkl820.git@gmail.com>,
        Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] sched: pick_next_rt_entity(): check list_entry
Message-ID: <20230207101117.6a87de53@gandalf.local.home>
In-Reply-To: <20230128-list-entry-null-check-sched-v3-1-b1a71bd1ac6b@diag.uniroma1.it>
References: <20230128-list-entry-null-check-sched-v3-1-b1a71bd1ac6b@diag.uniroma1.it>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Feb 2023 22:33:54 +0000
Pietro Borrello <borrello@diag.uniroma1.it> wrote:

> Commit 326587b84078 ("sched: fix goto retry in pick_next_task_rt()")
> removed any path which could make pick_next_rt_entity() return NULL.
> However, BUG_ON(!rt_se) in _pick_next_task_rt() (the only caller of
> pick_next_rt_entity()) still checks the error condition, which can
> never happen, since list_entry() never returns NULL.
> Remove the BUG_ON check, and instead emit a warning in the only
> possible error condition here: the queue being empty which should
> never happen.
> 
> Fixes: 326587b84078 ("sched: fix goto retry in pick_next_task_rt()")
> Signed-off-by: Pietro Borrello <borrello@diag.uniroma1.it>
> ---
> Changes in v3:
> - return NULL if the list is empty
> - Link to v2: https://lore.kernel.org/r/20230128-list-entry-null-check-sched-v2-1-d8e010cce91b@diag.uniroma1.it
> 
> Changes in v2:
> - pick_next_rt_entity(): emit warning instead of crashing
> - Link to v1: https://lore.kernel.org/r/20230128-list-entry-null-check-sched-v1-1-c93085ee0055@diag.uniroma1.it
> ---
>  kernel/sched/rt.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index ed2a47e4ddae..0a11f44adee5 100644

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
