Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79BA6C1076
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 12:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjCTLNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 07:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjCTLN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 07:13:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F882D327
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 04:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679310609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OfUmrG9y5/ZvplO9T6vCmmlrfIFkSsUHLev6hD28Uqg=;
        b=KxXseIFQu/GNMn6sjCU+4x6oNXDHddFtjYrN6CAxYV/qVJNSWzJlJOSNCslCJdcGYgJqRZ
        DZ/Ez0IZiebNhjBwij6J8T1eJsNhUZecaIuCljp0qhDzISqdF5wVH55KtI8PXVuYGiuqST
        H8nG7NRXIN9PHtkIubBSIvbZDYkQPtc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-453-xrnWbsS3Nyq-z2HMAtD-qg-1; Mon, 20 Mar 2023 07:10:05 -0400
X-MC-Unique: xrnWbsS3Nyq-z2HMAtD-qg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 65E883806638;
        Mon, 20 Mar 2023 11:10:05 +0000 (UTC)
Received: from localhost (unknown [10.22.32.190])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1D1801121315;
        Mon, 20 Mar 2023 11:10:04 +0000 (UTC)
Date:   Mon, 20 Mar 2023 08:10:04 -0300
From:   "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To:     linux@steffen.cc
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
Subject: Re: [PATCH v5.10-rt] kernel: fork: set wake_q_sleeper.next=NULL
 again in dup_task_struct
Message-ID: <ZBg+3pGG9v+hQFYI@uudg.org>
References: <20230320080347.32434-1-linux@steffen.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320080347.32434-1-linux@steffen.cc>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 09:03:47AM +0100, linux@steffen.cc wrote:
> From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
> 
> Without this we get system hangs within a couple of days.
> It's also reproducible in minutes with "stress-ng --exec 20".
> 
> Example error in dmesg:
> INFO: task stress-ng:163916 blocked for more than 120 seconds.
>       Not tainted 5.10.168-rt83 #2
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:stress-ng       state:D stack:    0 pid:163916 ppid: 72833 flags:0x00004000
> Call Trace:
>  __schedule+0x2bd/0x940
>  preempt_schedule_lock+0x23/0x50
>  rt_spin_lock_slowlock_locked+0x117/0x2c0
>  rt_spin_lock_slowlock+0x51/0x80
>  rt_write_lock+0x1e/0x1c0
>  do_exit+0x3ac/0xb20
>  do_group_exit+0x39/0xb0
>  get_signal+0x145/0x960
>  ? wake_up_new_task+0x21f/0x3c0
>  arch_do_signal_or_restart+0xf1/0x830
>  ? __x64_sys_futex+0x146/0x1d0
>  exit_to_user_mode_prepare+0x116/0x1a0
>  syscall_exit_to_user_mode+0x28/0x190
>  entry_SYSCALL_64_after_hwframe+0x61/0xc6
> RIP: 0033:0x7f738d9074a7
> RSP: 002b:00007ffdafda3cb0 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
> RAX: fffffffffffffe00 RBX: 00000000000000ca RCX: 00007f738d9074a7
> RDX: 0000000000028051 RSI: 0000000000000000 RDI: 00007f738be949d0
> RBP: 00007ffdafda3d88 R08: 0000000000000000 R09: 00007f738be94700
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000028051
> R13: 00007f738be949d0 R14: 00007ffdafda51e0 R15: 00007f738be94700
> 
> Fixes: 1ba44dcf789d ("Merge tag 'v5.10.162' into v5.10-rt")

Thank you for spotting and investigating that!

I dropped that specific line while fixing a small merge conflict from

    788d0824269b io_uring: import 5.15-stable io_uring

Interestingly enough, I didn't see that problem while running stress-ng.
I may need to add a few more, different, systems to my test base.

Anyway, I will add this fix to the next build.

Luis


> Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
> ---
>  kernel/fork.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index c6e0d555fca9..0c4c20eb762c 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -949,6 +949,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
>  	tsk->splice_pipe = NULL;
>  	tsk->task_frag.page = NULL;
>  	tsk->wake_q.next = NULL;
> +	tsk->wake_q_sleeper.next = NULL;
>  	tsk->pf_io_worker = NULL;
>  
>  	account_kernel_stack(tsk, 1);
> -- 
> 2.40.0
> 
---end quoted text---

