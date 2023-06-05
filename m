Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0827227D9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 15:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbjFENuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 09:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbjFENuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 09:50:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806539C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 06:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685972960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IqsADGawig/9/SjdL9ZrsH0XLB6JFxW+8nvjk2vu3gw=;
        b=Z+ixv9PVGJSit40Rx6wts1rKnEGepNhSYceXnkiW6uticqq+IkoHSzQ86vGH6ohKyxYbs9
        /lf0QEUb0zINe+bvQXdOufcqWE7C6kXjBB+JwnC07Yg8+BGKrNG/sXM6GQXeHCxkgUU2rb
        B9ezE+HjN8qBxSVlv9yU66kMC0ZA5IE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-RYn07942P1G8GApkbqT0gA-1; Mon, 05 Jun 2023 09:49:12 -0400
X-MC-Unique: RYn07942P1G8GApkbqT0gA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2279328135C1;
        Mon,  5 Jun 2023 13:49:10 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.144])
        by smtp.corp.redhat.com (Postfix) with SMTP id 10A47401470;
        Mon,  5 Jun 2023 13:49:06 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon,  5 Jun 2023 15:48:48 +0200 (CEST)
Date:   Mon, 5 Jun 2023 15:48:44 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     linux@leemhuis.info, nicolas.dichtel@6wind.com, axboe@kernel.dk,
        ebiederm@xmission.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
Subject: Re: [PATCH 1/1] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
Message-ID: <20230605134844.GC32275@redhat.com>
References: <20230601183232.8384-1-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601183232.8384-1-michael.christie@oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01, Mike Christie wrote:
>
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1368,7 +1368,9 @@ int zap_other_threads(struct task_struct *p)
>  
>  	while_each_thread(p, t) {
>  		task_clear_jobctl_pending(t, JOBCTL_PENDING_MASK);
> -		count++;
> +		/* Don't require de_thread to wait for the vhost_worker */
> +		if ((t->flags & (PF_IO_WORKER | PF_USER_WORKER)) != PF_USER_WORKER)
> +			count++;

Well if you do this, then you should also change __exit_signal() to
not decrement sig->notify_count. Otherwise de_thread() can succeed
before the "normal" sub-threads exit.

But this can't be right anyway... If nothing else, suppose we have
a process with 3 threads:

	M	- the main thread, group leader
	T	- sub-thread
	V	- vhost worker

T does exec and calls de_thread().

M exits. T takes the leadership and does release_task()

V is still running but V->group_leader points to already freed M.

Or unshare_sighand() after that... If nothing else this means that
lock_task_sighand(T) and lock_task_sighand(V) will take different
locks.

Oleg.

