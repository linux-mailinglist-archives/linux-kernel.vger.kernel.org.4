Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7307E67B2B8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 13:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235347AbjAYMoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 07:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjAYMoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 07:44:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679811A498
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 04:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674650596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j9odPV+6puEiMnrNrOig8rmnxEdCUxbVvIwgsbWCFPc=;
        b=gj7j2hqwUod/jSDuxc/lO4qFn6nsPvgy1qOaxi9WEjVCCST4Zkbt9SXUeLvJRTiI9xINBQ
        f91ggh1jFTjUcuNoW682n03vqhZfFdmb47kp10aUEYtT+IgxUkT5vlKWJ0jSf2MNMvsxwk
        OwZQVjLHq9kk6huFdn8y34PN8VeNX5c=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-384-qsug1qW2MwC1g2YRCA_56g-1; Wed, 25 Jan 2023 07:43:10 -0500
X-MC-Unique: qsug1qW2MwC1g2YRCA_56g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9962C299E74E;
        Wed, 25 Jan 2023 12:43:09 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (ovpn-195-63.brq.redhat.com [10.40.195.63])
        by smtp.corp.redhat.com (Postfix) with SMTP id F04F3492B00;
        Wed, 25 Jan 2023 12:43:07 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 25 Jan 2023 13:43:07 +0100 (CET)
Date:   Wed, 25 Jan 2023 13:43:04 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marco Elver <elver@google.com>
Subject: Re: [RFC PATCH v2] posix-timers: Support delivery of signals to the
 current thread
Message-ID: <20230125124304.GA13746@redhat.com>
References: <20221216171807.760147-1-dvyukov@google.com>
 <20230112112411.813356-1-dvyukov@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112112411.813356-1-dvyukov@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12, Dmitry Vyukov wrote:
>
> --- a/kernel/time/posix-timers.c
> +++ b/kernel/time/posix-timers.c
> @@ -336,6 +336,7 @@ void posixtimer_rearm(struct kernel_siginfo *info)
>  int posix_timer_event(struct k_itimer *timr, int si_private)
>  {
>  	enum pid_type type;
> +	struct pid *pid;
>  	int ret;
>  	/*
>  	 * FIXME: if ->sigq is queued we can race with
> @@ -350,8 +351,9 @@ int posix_timer_event(struct k_itimer *timr, int si_private)
>  	 */
>  	timr->sigq->info.si_sys_private = si_private;
>
> +	pid = timr->it_pid ?: task_pid(current);
>  	type = !(timr->it_sigev_notify & SIGEV_THREAD_ID) ? PIDTYPE_TGID : PIDTYPE_PID;

can't resist... somehow the line above looks confusing to me, perhaps you
can change it to

	type = (timr->it_sigev_notify & SIGEV_THREAD_ID) ? PIDTYPE_PID : PIDTYPE_TGID;

> -static struct pid *good_sigevent(sigevent_t * event)
> +static struct pid *good_sigevent(sigevent_t *event, clockid_t which_clock)
>  {
>  	struct pid *pid = task_tgid(current);
>  	struct task_struct *rtn;
>
>  	switch (event->sigev_notify) {
>  	case SIGEV_SIGNAL | SIGEV_THREAD_ID:
> +		/* This will use the current task for signals. */
> +		if (which_clock == CLOCK_PROCESS_CPUTIME_ID &&
> +		    !event->sigev_notify_thread_id)
> +			return NULL;

this doesn't look right, this skips the "sigev_signo" check below.

Other than that I see nothing wrong in this patch, but I forgot everything
about posix timers many years ago ;)

> @@ -527,9 +534,11 @@ static int do_timer_create(clockid_t which_clock, struct sigevent *event,
>
>  	if (event) {
>  		rcu_read_lock();
> -		new_timer->it_pid = get_pid(good_sigevent(event));
> +		pid = good_sigevent(event, which_clock);
> +		if (!IS_ERR(pid))
> +			new_timer->it_pid = get_pid(pid);

Another cosmetic nit, feel free to ignore... If you change good_sigevent()

	case SIGEV_NONE:
-		return pid;
+		return get_pid(pid);

you can remove this "if (!IS_ERR(pid))" code above.

Oleg.

