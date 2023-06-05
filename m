Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03A672261A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 14:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbjFEMkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 08:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbjFEMkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 08:40:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1271ADA
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 05:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685968754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=loD/IvJicWPVfDfE30xF5JqbJYTs7N6XfWy0yCKcLAI=;
        b=OBbLrDGDPvadpPtlqhtKea+MddaZyUnNTe4sbVDOrLdjIGKPTtb2dYmKGCRG1M/vGeleeM
        F8gsSLhiRcyL7YW/qP99NRax/bzk5ms0uBblp3F4ipJpea3TafD9UQHtqijIIrMpa4vDi8
        lQrD1/+3my+yuR+gBmUDbMQhFjcA/Qo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-539-k8chz8YbNdy6_0epECbSSA-1; Mon, 05 Jun 2023 08:39:11 -0400
X-MC-Unique: k8chz8YbNdy6_0epECbSSA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 73A44802355;
        Mon,  5 Jun 2023 12:39:10 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.144])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6D63340CFD46;
        Mon,  5 Jun 2023 12:39:07 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon,  5 Jun 2023 14:38:49 +0200 (CEST)
Date:   Mon, 5 Jun 2023 14:38:45 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Mike Christie <michael.christie@oracle.com>, linux@leemhuis.info,
        nicolas.dichtel@6wind.com, axboe@kernel.dk,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
Subject: Re: [CFT][PATCH v3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
Message-ID: <20230605123844.GA32275@redhat.com>
References: <20230601183232.8384-1-michael.christie@oracle.com>
 <20230602192254.GD555@redhat.com>
 <87r0qt18qq.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0qt18qq.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02, Eric W. Biederman wrote:
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
> +		if (!dead && signal_pending(current)) {
> +			struct ksignal ksig;
> +			/*
> +			 * Calling get_signal can block in SIGSTOP,
> +			 * and the freezer.  Or it can clear
> +			 * fatal_signal_pending and return non-zero.
> +			 */
> +			dead = get_signal(&ksig);
> +			if (dead)
> +				set_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags);
> +		}
> +
> +		/* mb paired w/ kthread_stop */
> +		set_current_state(TASK_INTERRUPTIBLE);
> +
> +		did_work = vtsk->fn(vtsk->data);

I don't understand why do you set TASK_INTERRUPTIBLE before vtsk->fn(),
it seems that you could do this before the test_bit(FLAGS_STOP) below.
But probably I missed something and this is minor anyway...

> +		if (!did_work) {
> +			if (test_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags)) {
> +				__set_current_state(TASK_RUNNING);
> +				break;

What if VHOST_TASK_FLAGS_STOP was set by us after get_signal() above ?
We need to ensure that in this case vhost_work_queue() can't add a new work,
nobody will flush it.

In fact, unless I missed something this can even race with vhost_dev_flush().

	vhost_dev_flush:				vhost_task_fn:

	checks FLAGS_STOP, not set,
	vhost_task_flush() returns false
							gets SIGKILL, sets FLAGS_STOP

							vtsk->fn() returns false

							vhost_task_fn() exits.

	vhost_work_queue();
	wait_for_completion(&flush.wait_event);


and the last wait_for_completion() will hang forever.

Oleg.

