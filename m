Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0493373845D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 15:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjFUNFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 09:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbjFUNFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:05:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A7519A4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 06:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=abu7SgXC0q/lTi3/xScrNE3k2kA9ARrqH3wnDSOpJC8=; b=nsZmRigCNB9ssAgmJEbmK5E3Jn
        O7SRx9AaAHoBslOR/xuGNqadiW7D1JbQS3QyALgobAtd/AUJLY7UqmXHCIDBmePe55n1w504MfutR
        HBNytbnejoDiFb4emT+N5vNaKDlZxICeXDGvBrtrVnssXQ1hH+EY5DHQuEYRMELvzdV//1aPzLQGK
        ws6SfNXMk1reYsuC1+3EP2sl10w4c8NEpmHk8Qd7DSCE4Rhc9bSSEwOEuy22i2mHMswcEEhxhxh25
        mAPSfIuyw7oXpoo8QsN5covnUQjXOlecpEH4OzLjYy8g0TGSjhHDP5epFWyQhvnkvT9Vn6htots1/
        txthh+yw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qBxVp-00ELnL-1n; Wed, 21 Jun 2023 13:04:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A84A9300274;
        Wed, 21 Jun 2023 15:04:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8689A2130B3BB; Wed, 21 Jun 2023 15:04:39 +0200 (CEST)
Date:   Wed, 21 Jun 2023 15:04:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Vernet <void@manifault.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, dietmar.eggemann@arm.com, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        joshdon@google.com, roman.gushchin@linux.dev, tj@kernel.org,
        kernel-team@meta.com
Subject: Re: [RFC PATCH 1/3] sched: Make migrate_task_to() take any task
Message-ID: <20230621130439.GF2053369@hirez.programming.kicks-ass.net>
References: <20230613052004.2836135-1-void@manifault.com>
 <20230613052004.2836135-2-void@manifault.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613052004.2836135-2-void@manifault.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 12:20:02AM -0500, David Vernet wrote:
> The migrate_task_to() function exposed from kernel/sched/core.c migrates
> the current task, which is silently assumed to also be its first
> argument, to the specified CPU. The function uses stop_one_cpu() to
> migrate the task to the target CPU, which won't work if @p is not the
> current task as the stop_one_cpu() callback isn't invoked on remote
> CPUs.
> 
> While this operation is useful for task_numa_migrate() in fair.c, it
> would be useful if __migrate_task() in core.c was given external
> linkage, as it actually can be used to migrate any task to a CPU.
> 
> This patch therefore:
> 1. Renames the existing migrate_task_to() be called
>    numa_migrate_current_task_to().
> 2. Renames __migrate_task() to migrate_task_to(), gives it global
>    linkage, and updates all callers accordingly.
> 
> A follow-on patch will call the new migrate_task_to() from fair.c when
> migrating a task in a shared wakequeue to a remote CPU.

I would suggest simply exposing move_queued_task(). You can actually do
is_cpu_allowed() before you do the whole lock dance, or even before
pull.

And then you don't have to create silly long function names either.
