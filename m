Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1FD70BE68
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 14:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbjEVMfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 08:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234413AbjEVMf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 08:35:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F96FAC
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 05:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684758655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XLKVwpsofT3fO0KfbhEhMNwUy6j+Hh9Xz3u/5JzJISE=;
        b=VrQZEWcwHaXvKGFIvkldpISREdu5SG3OLca38Ti4SRnijzGBg1peBWC2B+JScu3kW4Z9gZ
        r3H1nLuHPwvWwRIwzRvjiDWm+U3XTKimhR0n1BGWD+f7F+s4Y/lb/qqeGe6ldRgxyI6Dp1
        6tPBlBKolsf8slvyaOPQMaFGvV3Etvk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-y0yXY8u3NEe6cP21B_llfw-1; Mon, 22 May 2023 08:30:50 -0400
X-MC-Unique: y0yXY8u3NEe6cP21B_llfw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D051B185A78F;
        Mon, 22 May 2023 12:30:49 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.202])
        by smtp.corp.redhat.com (Postfix) with SMTP id BD2D7407DEC3;
        Mon, 22 May 2023 12:30:46 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 22 May 2023 14:30:33 +0200 (CEST)
Date:   Mon, 22 May 2023 14:30:29 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     linux@leemhuis.info, nicolas.dichtel@6wind.com, axboe@kernel.dk,
        ebiederm@xmission.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
Subject: Re: [PATCH 3/3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
Message-ID: <20230522123029.GA22159@redhat.com>
References: <20230522025124.5863-1-michael.christie@oracle.com>
 <20230522025124.5863-4-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522025124.5863-4-michael.christie@oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Confused, please help...

On 05/21, Mike Christie wrote:
>
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -338,6 +338,7 @@ static int vhost_worker(void *data)
>  	struct vhost_worker *worker = data;
>  	struct vhost_work *work, *work_next;
>  	struct llist_node *node;
> +	bool dead = false;
>
>  	for (;;) {
>  		/* mb paired w/ kthread_stop */
> @@ -349,8 +350,22 @@ static int vhost_worker(void *data)
>  		}
>
>  		node = llist_del_all(&worker->work_list);
> -		if (!node)
> +		if (!node) {
>  			schedule();
> +			/*
> +			 * When we get a SIGKILL our release function will
> +			 * be called. That will stop new IOs from being queued
> +			 * and check for outstanding cmd responses. It will then
> +			 * call vhost_task_stop to tell us to return and exit.
> +			 */

But who will call the release function / vhost_task_stop() and when this
will happen after this thread gets SIGKILL ?

> +			if (!dead && signal_pending(current)) {
> +				struct ksignal ksig;
> +
> +				dead = get_signal(&ksig);
> +				if (dead)
> +					clear_thread_flag(TIF_SIGPENDING);

If you do clear_thread_flag(TIF_SIGPENDING), then why do we need 1/3 ?


Also. Suppose that vhost_worker() dequeues SIGKILL and clears TIF_SIGPENDING.

SIGSTOP, PTRACE_INTERRUPT, freezer can come and set TIF_SIGPENDING again.
In this case the main for (;;) loop will spin without sleeping until
vhost_task_should_stop() becomes true?

Oleg.

