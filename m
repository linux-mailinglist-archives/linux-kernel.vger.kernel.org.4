Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911D769904B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 10:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjBPJnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 04:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjBPJnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 04:43:25 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EDDBDC9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 01:43:20 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2CED52098F;
        Thu, 16 Feb 2023 09:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676540599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N5U6IrVwCsueztAcTutfhEgyuA7eyIVe2k7iIPG0pCI=;
        b=se+bNvjTSByWvU29J6oW0TuWh2xsyMYlq4FEFx0+MTB/G71QwrQS3SGKaRJv24HMeBBcK1
        FV+oiQZqFX5Udy6o30Zdh/PReTmngMVNg6A4zVi+3Bkkr1K8Vc9vbBdtXsDnDTZ2HlQSFa
        H31wCb3wAyvdF1o0eRNvMhzj5oBMBgc=
Received: from suse.cz (unknown [10.163.25.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0BD9B2C141;
        Thu, 16 Feb 2023 09:43:18 +0000 (UTC)
Date:   Thu, 16 Feb 2023 10:43:13 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 2/5] workqueue: Warn when a new worker could not be created
Message-ID: <Y+36sT088JAEwUCe@alley>
References: <20230201134543.13687-1-pmladek@suse.com>
 <20230201134543.13687-3-pmladek@suse.com>
 <20230215180204.GP1757@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230215180204.GP1757@blackbody.suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2023-02-15 19:02:04, Michal Koutný wrote:
> Hello.
> 
> On Wed, Feb 01, 2023 at 02:45:40PM +0100, Petr Mladek <pmladek@suse.com> wrote:
> >    + the system reached PID limit
> or threads-max limit.
> 
> FTR, I was once considering something like
> 
> --->8---
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 867b46d6fd0a..bba05ecc3765 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1684,8 +1684,10 @@ static __latent_entropy struct task_struct *copy_process(
>          * to stop root fork bombs.
>          */
>         retval = -EAGAIN;
> -       if (nr_threads >= max_threads)
> +       if (nr_threads >= max_threads) {
> +               printk_once(KERN_INFO "clone failed due to threads-max limit\n");
>                 goto bad_fork_cleanup_count;
> +       }
> 
>         delayacct_tsk_init(p);  /* Must remain after dup_task_struct() */
>         p->flags &= ~(PF_SUPERPRIV | PF_WQ_WORKER | PF_IDLE);
> @@ -1816,6 +1818,7 @@ static __latent_entropy struct task_struct *copy_process(
>         if (pid != &init_struct_pid) {
>                 pid = alloc_pid(p->nsproxy->pid_ns_for_children);
>                 if (IS_ERR(pid)) {
> +                       printk_once(KERN_INFO "fork failed to find pid\n");
>                         retval = PTR_ERR(pid);
>                         goto bad_fork_cleanup_thread;
>                 }
> --->8---
> 
> Effects of the global limits on anything but kthreads should be much less
> important and easier to troubleshoot anyway.
> Covering kworkers with your changes should be useful and substitute my idea
> above.

I was not brave enough to touch kernel/fork.c.

> Take that as my support for this patch (from my perspective reporting
> *_once would be enough to guide a troubleshooter).

My experience is that users often send logs with many stall reports and
the earlier messages are missing/lost. This is why I wanted to repeat
them.

Anyway, thanks for the support. I am going to send v2 when time permits.

Best Regards,
Petr
