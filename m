Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67FD60C9E8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 12:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbiJYKWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 06:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbiJYKVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 06:21:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D244825F6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 03:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666693155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2HG73spb/6yEKDnuiniZI5mjP3/NK2ZeRipm0BSN9WA=;
        b=Yyt4GX+ntHqXVqPO4awSVnI/SKpQholYK8gbDbUXAQqu1IBWFTYgHFTBfAPzwTaLq2V1pH
        2t0Pfdld3fFLidw6yO+O9L7iJs+xPYvpii5W91NW4aKJGc+h6JKqPGaOZuTtb1LQoT0OPB
        fo0B48xdmF0ZgRSOmrpXhtLs5rm5nIA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-522-Szj1dSiuM0KnjlSVicR6zQ-1; Tue, 25 Oct 2022 06:19:13 -0400
X-MC-Unique: Szj1dSiuM0KnjlSVicR6zQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E86C7833A38;
        Tue, 25 Oct 2022 10:19:06 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (ovpn-194-221.brq.redhat.com [10.40.194.221])
        by smtp.corp.redhat.com (Postfix) with SMTP id 558BAC15BAB;
        Tue, 25 Oct 2022 10:19:02 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 25 Oct 2022 12:19:06 +0200 (CEST)
Date:   Tue, 25 Oct 2022 12:19:00 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     chen zhang <chenzhang@kylinos.cn>
Cc:     chenzhang_0901@163.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ptrace: disable single step in __ptrace_unlink for
 protecting init task
Message-ID: <20221025101858.GB17158@redhat.com>
References: <20221025051032.280352-1-chenzhang@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025051032.280352-1-chenzhang@kylinos.cn>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25, chen zhang wrote:
>
> Thanks for your reply. I think kernel should not panic when the
> application has a bug, or a fault operation such as ctrl+c,

	a) init is special. If it exits, the kernel panics. This is
	   by design.

	b) debugger can always crash the tracee. In particular if it
	   exits without ptrace(PTRACE_DETACH) which implies
	   user_disable_single_step().

> This patch can really prevent kernel panic on
> my x86 machine.

Really? You ignored this part of my previous email,

	Not to mention I don't understand how your patch can actually help. If nothing
	else,

		- debugger does ptrace(PTRACE_SINGLESTEP), this wakes the tracee up

		- the tracee enters force_sig_info_to_task(SIGTRAP) after single step

		- debugger exits, __ptrace_unlink() clears ptrace/TIF_SINGLESTEP

		- force_sig_info_to_task() clears SIGNAL_UNKILLABLE, the traced init
		  will be killed.

Am I wrong?

Finally,

> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -130,6 +130,8 @@ void __ptrace_unlink(struct task_struct *child)
>  	put_cred(old_cred);
>
>  	spin_lock(&child->sighand->siglock);
> +	if (unlikely(child->signal->flags & SIGNAL_UNKILLABLE))
> +		user_disable_single_step(child);
>  	child->ptrace = 0;
>  	/*

I don't understnd why do you call user_disable_single_step() with ->siglock
held, but this is minor.

user_disable_single_step(child) assumes that child is stopped and frozen,
see ptrace_freeze_traced(). This is not necessarily true if __ptrace_unlink()
is called by the exiting tracer, so the patch is wrong in any case.

Nack, sorry.

Oleg.

