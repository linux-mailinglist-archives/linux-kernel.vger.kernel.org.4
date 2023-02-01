Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A57C686AED
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbjBAP4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjBAP4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:56:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91641BF2
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 07:56:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 86BAFB821BC
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 15:56:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B93C433D2;
        Wed,  1 Feb 2023 15:56:07 +0000 (UTC)
Date:   Wed, 1 Feb 2023 10:56:03 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Song Chen <chensong_2000@189.cn>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/sched/core: adjust rt_priority accordingly when
 prio is changed
Message-ID: <20230201105603.1d377866@gandalf.local.home>
In-Reply-To: <1675245680-2811-1-git-send-email-chensong_2000@189.cn>
References: <1675245680-2811-1-git-send-email-chensong_2000@189.cn>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  1 Feb 2023 18:01:20 +0800
Song Chen <chensong_2000@189.cn> wrote:

> When a high priority process is acquiring a rtmutex which is held by a
> low priority process, the latter's priority will be boosted up by calling
> rt_mutex_setprio->__setscheduler_prio.
> 
> However, p->prio is changed but p->rt_priority is not, as a result, the
> equation between prio and rt_priority is broken, which is:
> 
> 	prio = MAX_RT_PRIO - 1 - rt_priority
> 
> It's confusing to the user when it calls sched_getparam, which only
> returns rt_priority.

If it is boosted, then that's an internal implementation and not the real
priority of the task. It should not be exposed to a user interface. In
fact, there's discussion of implementing a "proxy" algorithm which will
make what the "priority" of a task is even more complicated when acquiring
mutexes.


> 
> This patch addresses this issue by adjusting rt_priority according to
> the new value of prio, what's more, it also returns normal_prio for
> CFS processes instead of just a zero.

The comment above sched_getparam() is:

/**
 * sys_sched_getparam - get the RT priority of a thread
 * @pid: the pid in question.
 * @param: structure containing the RT priority.
 *
 * Return: On success, 0 and the RT priority is in @param. Otherwise, an error
 * code.
 */

So returning the nice value is incorrect. If anything, perhaps it should
return -EINVAL if the task is not an RT task?

-- Steve

> 
> Signed-off-by: Song Chen <chensong_2000@189.cn>
> ---
