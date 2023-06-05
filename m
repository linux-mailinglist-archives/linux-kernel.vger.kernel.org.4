Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A1172275A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 15:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbjFEN1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 09:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjFEN12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 09:27:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089B0D2
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 06:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685971606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fE6eT97yzH12os5SZGHmyPIjNlvh5xRQLosLvxOHz80=;
        b=M754T/bQLZjMJBqyLGzsiLBsIuS6hG+QcCPmjrJQTRWZ2Zs7WaLc3D3TjnBzBeUM84mCPC
        57sUDX+BWgFzTEapkB1z9T5d4Ah9GQuZlFns65MFwVqEVm0inM1uEUOl3bXOFCGmNHxM4G
        Xp6RWjEbFm+75xVd4Moofh6b1/8fOUw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-NUiRjT3UM7GVO2knb6Tq8Q-1; Mon, 05 Jun 2023 09:26:43 -0400
X-MC-Unique: NUiRjT3UM7GVO2knb6Tq8Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 686E91C05EAA;
        Mon,  5 Jun 2023 13:26:42 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.144])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1D7D81121314;
        Mon,  5 Jun 2023 13:26:33 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon,  5 Jun 2023 15:26:20 +0200 (CEST)
Date:   Mon, 5 Jun 2023 15:26:11 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Mike Christie <michael.christie@oracle.com>, linux@leemhuis.info,
        nicolas.dichtel@6wind.com, axboe@kernel.dk,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
Subject: Re: [PATCH 1/1] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
Message-ID: <20230605132611.GB32275@redhat.com>
References: <20230601183232.8384-1-michael.christie@oracle.com>
 <20230602192254.GD555@redhat.com>
 <87wn0l2or4.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wn0l2or4.fsf@email.froward.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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
> Oleg Nesterov <oleg@redhat.com> writes:
>
> > Hi Mike,
> >
> > sorry, but somehow I can't understand this patch...
> >
> > I'll try to read it with a fresh head on Weekend, but for example,
> >
> > On 06/01, Mike Christie wrote:
> >>
> >>  static int vhost_task_fn(void *data)
> >>  {
> >>  	struct vhost_task *vtsk = data;
> >> -	int ret;
> >> +	bool dead = false;
> >> +
> >> +	for (;;) {
> >> +		bool did_work;
> >> +
> >> +		/* mb paired w/ vhost_task_stop */
> >> +		if (test_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags))
> >> +			break;
> >> +
> >> +		if (!dead && signal_pending(current)) {
> >> +			struct ksignal ksig;
> >> +			/*
> >> +			 * Calling get_signal will block in SIGSTOP,
> >> +			 * or clear fatal_signal_pending, but remember
> >> +			 * what was set.
> >> +			 *
> >> +			 * This thread won't actually exit until all
> >> +			 * of the file descriptors are closed, and
> >> +			 * the release function is called.
> >> +			 */
> >> +			dead = get_signal(&ksig);
> >> +			if (dead)
> >> +				clear_thread_flag(TIF_SIGPENDING);
> >
> > this can't be right or I am totally confused.
> >
> > Another signal_wake_up() can come right after clear(SIGPENDING).
>
> Technically yes.

...

> Beyond that clearing TIF_SIGPENDING is just an optimization so
> the thread can sleep in schedule and not spin.

Yes. So if another signal_wake_up() comes after clear(SIGPENDING)
this code will spin in busy-wait loop waiting VHOST_TASK_FLAGS_STOP.
Obviously not good and even deadlockable on UP && !PREEMPT.

Oleg.

