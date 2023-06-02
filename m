Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33E57209C1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 21:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237203AbjFBTYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 15:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235251AbjFBTYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 15:24:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3321BE
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 12:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685733804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hl/Yio++/nUxex1lxp6/0KZZRVMOQifT21+LBrMdJ5A=;
        b=dDibgMqJfHY9EacCDw9HaMdM6UMfkAAp8zCrNvBXj9IQB+EhzjdJ5IeQsYP5h29a+qqLYg
        9UgRrvTZWwKyTeEgzxVVgNGRYFkRIfBNYB6Hf1n6IfvzyYzBwuHSE+uGjps+Gc9nVJw6US
        Cd7+Ncj1NIvl/hGEF4AtzLgAlSOcXHU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-136-s9DeVHr9PSiNgf7LjKdAhw-1; Fri, 02 Jun 2023 15:23:20 -0400
X-MC-Unique: s9DeVHr9PSiNgf7LjKdAhw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD4BD85A5BA;
        Fri,  2 Jun 2023 19:23:19 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.50])
        by smtp.corp.redhat.com (Postfix) with SMTP id B8E9CC154D7;
        Fri,  2 Jun 2023 19:23:16 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri,  2 Jun 2023 21:22:58 +0200 (CEST)
Date:   Fri, 2 Jun 2023 21:22:55 +0200
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
Message-ID: <20230602192254.GD555@redhat.com>
References: <20230601183232.8384-1-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601183232.8384-1-michael.christie@oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

sorry, but somehow I can't understand this patch...

I'll try to read it with a fresh head on Weekend, but for example,

On 06/01, Mike Christie wrote:
>
>  static int vhost_task_fn(void *data)
>  {
>  	struct vhost_task *vtsk = data;
> -	int ret;
> +	bool dead = false;
> +
> +	for (;;) {
> +		bool did_work;
> +
> +		/* mb paired w/ vhost_task_stop */
> +		if (test_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags))
> +			break;
> +
> +		if (!dead && signal_pending(current)) {
> +			struct ksignal ksig;
> +			/*
> +			 * Calling get_signal will block in SIGSTOP,
> +			 * or clear fatal_signal_pending, but remember
> +			 * what was set.
> +			 *
> +			 * This thread won't actually exit until all
> +			 * of the file descriptors are closed, and
> +			 * the release function is called.
> +			 */
> +			dead = get_signal(&ksig);
> +			if (dead)
> +				clear_thread_flag(TIF_SIGPENDING);

this can't be right or I am totally confused.

Another signal_wake_up() can come right after clear(SIGPENDING).


Again, I'll try to re-read this patch, but let me ask anyway...

Do we have a plan B? I mean... iirc you have mentioned that you can
change these code paths to do something like

	if (killed)
		tell_the_drivers_that_all_callbacks_will_fail();


so that vhost_worker() can exit after get_signal() returns SIGKILL.

Probably I misunderstood you, but it would be nice to avoid the changes
in coredump/etc code just to add a temporary (iiuc!) fix.

Oleg.

