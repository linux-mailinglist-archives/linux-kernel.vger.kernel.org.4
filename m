Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84AED699C7A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 19:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjBPSkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 13:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjBPSj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 13:39:57 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEAE5505EF
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 10:39:51 -0800 (PST)
Received: by mail-qt1-f178.google.com with SMTP id q13so3203665qtx.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 10:39:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UMKP2tyKrELc6iWOwIP17quVI583QJelbVG08LEWE34=;
        b=bUEQhuNy4/pwPgc+6qxP2eDO1mMXdlrSLD9TTpjIwxHQMIrE3KvHhUdsxetywhNSQq
         Klq2sZxjmPVhnWz9B+qKPbkr2b5PVStKeY9unCUdMUp+B9aWuCm1HCBMygmWFDRVTBiB
         xqkjv/ygjzg3alIbnHw/Ojc7pyONWanKWIc9muwYxpwGxjcCJ6KHS3HWPzt55KXf/fQw
         RWLEqg4ELENx6pwoPJAdQLPPqxC83lrhD4FW6hA1StRvwGhWe6HwBwxukh2dsoJKcDV/
         pKWfnUkul7C+YRliWbdXvRV8rmPhw550hKhVCIczCvGMyPpAUQ0BiLQJrO8oK5QXD8ca
         YSFQ==
X-Gm-Message-State: AO0yUKU/UlsxNFOGyNA3Nw4Ndk6UrGgawy2GYd4B7c8EfeEn0hsqDZA4
        2PgIFuLP3M0vC6QXfRwizd8=
X-Google-Smtp-Source: AK7set8XmccVCJcTdMMegLQWr2OkFFnhtI2iQPRB8CbYCh93fbrl+WJukPnozkBYXm0fjytAI6HOKg==
X-Received: by 2002:a05:622a:4c8:b0:3b9:bc8c:c1ff with SMTP id q8-20020a05622a04c800b003b9bc8cc1ffmr6056912qtx.10.1676572790785;
        Thu, 16 Feb 2023 10:39:50 -0800 (PST)
Received: from maniforge ([2620:10d:c091:480::1:834f])
        by smtp.gmail.com with ESMTPSA id a138-20020ae9e890000000b0072396cb73cdsm1718458qkg.13.2023.02.16.10.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 10:39:50 -0800 (PST)
Date:   Thu, 16 Feb 2023 12:39:47 -0600
From:   David Vernet <void@manifault.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, kernel-team@meta.com,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tasks: Extract rcu_users out of union
Message-ID: <Y+54c0YvXcMIFva4@maniforge>
References: <20230215233033.889644-1-void@manifault.com>
 <20230216080459.GA5200@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216080459.GA5200@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 09:04:59AM +0100, Oleg Nesterov wrote:
> I won't argue with this patch, but I can't understand the changelog...
> 
> On 02/15, David Vernet wrote:
> >
> > Similarly, in sched_ext, schedulers are using integer pids to remember
> > tasks, and then looking them up with find_task_by_pid_ns(). This is
> > slow, error prone, and adds complexity. It would be more convenient and
> > performant if BPF schedulers could instead store tasks directly in maps,
> > and then leverage RCU to ensure they can be safely accessed with low
> > overhead.
> 
> To simplify, suppose we have
> 
> 	int global_pid;
> 
> 	void func(void)
> 	{
> 		rcu_read_lock();
> 		task = find_task_by_pid(global_pid);
> 		do_something(task);
> 		rcu_read_unlock();
> 	}
> 
> Could you explain how exactly can this patch help to turn global_pid into
> "task_struct *" ? Why do you need to increment task->rcu_users ?

If you're not persisting the task in a map / data structure, then I
agree that find_task_by_pid_ns() is likely sufficient. What we want to
be able to do is something like this:

void func(void)
{
	rcu_read_lock();
	task = peek_next_task();
	if (task)
		do_something(task);
	rcu_read_unlock();
}

In such an example, we could be peeking into a statically allocated
circular queue, and want to be able to ensure that a task we look at
from the top is protected with rcu. The general mechanics would be that
a task is inserted with a refcount_inc_not_zero(), and when it's
removed, we do a put_task_struct_rcu_user().

Does that make sense?

> 
> >    a task that's successfully looked
> >    up in e.g. the pid_list with find_task_by_pid_ns(), can always have a
> >    'usage' reference acquired on them, as it's guaranteed to be >
> >    0 until after the next gp.
> 
> Yes. So it seems you need another key-to-task_struct map with rcu-safe
> lookup/get and thus the add() method needs inc_not_zero(task->rcu_users) ?

Yes, exactly.

Thanks for taking a look at the patch.

- David
