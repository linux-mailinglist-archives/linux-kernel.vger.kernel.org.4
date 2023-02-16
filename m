Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE4A698E46
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 09:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjBPIGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 03:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjBPIF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 03:05:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D571DB90
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 00:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676534712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VPP7smI1cpshU/GMno3GoPT39TEoAepG2OWkse01iXs=;
        b=bBywNir9AYVnlOMKhxelz2Er+OAXXN9OLFMIPHXIoz6/2GDhp8w/XWN0F4NJzQkNO+8Fr8
        B8ySblgRLPNRxK4Zj49FdnsE8VGOnFFOcXsVC+9La/sOdiaqSftTdzuBbE6qYUjdUmxMMD
        eI+ujOaD7y5jSeeG4f1P8qysDndxqXM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-434-8MiVrkdFMj-kP1UFOzV6dg-1; Thu, 16 Feb 2023 03:05:08 -0500
X-MC-Unique: 8MiVrkdFMj-kP1UFOzV6dg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BDD793C0DDBB;
        Thu, 16 Feb 2023 08:05:07 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (ovpn-193-101.brq.redhat.com [10.40.193.101])
        by smtp.corp.redhat.com (Postfix) with SMTP id 94FED40C945A;
        Thu, 16 Feb 2023 08:05:04 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 16 Feb 2023 09:05:03 +0100 (CET)
Date:   Thu, 16 Feb 2023 09:04:59 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     David Vernet <void@manifault.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, kernel-team@meta.com,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tasks: Extract rcu_users out of union
Message-ID: <20230216080459.GA5200@redhat.com>
References: <20230215233033.889644-1-void@manifault.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215233033.889644-1-void@manifault.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I won't argue with this patch, but I can't understand the changelog...

On 02/15, David Vernet wrote:
>
> Similarly, in sched_ext, schedulers are using integer pids to remember
> tasks, and then looking them up with find_task_by_pid_ns(). This is
> slow, error prone, and adds complexity. It would be more convenient and
> performant if BPF schedulers could instead store tasks directly in maps,
> and then leverage RCU to ensure they can be safely accessed with low
> overhead.

To simplify, suppose we have

	int global_pid;

	void func(void)
	{
		rcu_read_lock();
		task = find_task_by_pid(global_pid);
		do_something(task);
		rcu_read_unlock();
	}

Could you explain how exactly can this patch help to turn global_pid into
"task_struct *" ? Why do you need to increment task->rcu_users ?

>    a task that's successfully looked
>    up in e.g. the pid_list with find_task_by_pid_ns(), can always have a
>    'usage' reference acquired on them, as it's guaranteed to be >
>    0 until after the next gp.

Yes. So it seems you need another key-to-task_struct map with rcu-safe
lookup/get and thus the add() method needs inc_not_zero(task->rcu_users) ?

I am just curious,

Oleg.

