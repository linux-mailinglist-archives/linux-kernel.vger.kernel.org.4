Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918196B598F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 09:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjCKIxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 03:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjCKIxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 03:53:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBACF1E29E
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 00:53:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E5D360A2A
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 08:53:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D428C433EF;
        Sat, 11 Mar 2023 08:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678524812;
        bh=2gSciTqDV0qKUnbX8yCeKFB0gokSATERcvQ0h/jTX60=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CFDnS2MPJ3i3oZaD9UXXaqs6DXyf0SPV6uZ8v7J8ykaoI9RiczI6n+A+2w1tlPBDk
         zLRWDPZIihlt1j4aenbz4Pze06BQK3tpd7RWZCVZ874k84r7MmPn57rzs2VLjpYeci
         cqqr4SPsiErgfsfKxtSekQbyO0dEwrZUvORMSW6JAmVqNoApg05zUYcM82ugedhAbR
         rcZv34taV/tgCe9mOoO0PXf7qiBR+x/4JgCaNjjqI5F2WXlMjTdQRqq2BHJlKh4MjX
         5kKZBUq0mK1oLC0Wp82CuML3HXwAU8a4N2DGUnK6qCGu5bSpdYHzRtug8rhyE/kYgL
         F1ikm4ZCAmo3A==
Date:   Sat, 11 Mar 2023 09:53:26 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, ebiederm@xmission.com,
        torvalds@linux-foundation.org, konrad.wilk@oracle.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/11] kthread: Pass in the thread's name during creation
Message-ID: <20230311085326.m7aub5duy76hnnam@wittgenstein>
References: <20230310220332.5309-1-michael.christie@oracle.com>
 <20230310220332.5309-4-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230310220332.5309-4-michael.christie@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 04:03:24PM -0600, Mike Christie wrote:
> This has us pass in the thread's name during creation in kernel_thread.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>  kernel/kthread.c | 35 ++++++++++++++---------------------
>  1 file changed, 14 insertions(+), 21 deletions(-)
> 
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index 63574cee925e..831a55b406d8 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -38,6 +38,7 @@ struct task_struct *kthreadd_task;
>  struct kthread_create_info
>  {
>  	/* Information passed to kthread() from kthreadd. */
> +	char *full_name;
>  	int (*threadfn)(void *data);
>  	void *data;
>  	int node;
> @@ -343,10 +344,15 @@ static int kthread(void *_create)
>  	/* Release the structure when caller killed by a fatal signal. */
>  	done = xchg(&create->done, NULL);
>  	if (!done) {
> +		kfree(create->full_name);
>  		kfree(create);
>  		kthread_exit(-EINTR);
>  	}
>  
> +	if (strlen(create->full_name) >= TASK_COMM_LEN)
> +		self->full_name = create->full_name;
> +	else
> +		kfree(create->full_name);

This is monir but wwiw, this looks suspicious when reading it without
more context. It took me a while to see that kthread->full_name is
intended to store the untruncated name only if truncation actually needs
to happen. So either we should always initialize this or we should add a
comment. You can just send a tiny patch that I can fold into this one so
you don't have to resend the whole series...
