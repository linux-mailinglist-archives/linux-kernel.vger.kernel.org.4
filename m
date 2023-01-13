Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE10669903
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 14:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241622AbjAMNtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 08:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241885AbjAMNss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 08:48:48 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940F7249
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 05:43:58 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5FAF26B3B1;
        Fri, 13 Jan 2023 13:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673617436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S6nF7/THmOUUOTsAB+4DblfEjyDDT4H7PFp1Q1Ojth0=;
        b=qaXXrxrqCb0du8W/JmeBZQs4oVpsTF2eZG5QJgf+mZ52SuLF8Xdxjr2ALZzJ+iMk6H0wk/
        KWH4u3ABOJVnGg06jGUYA1JGaq6XzgdYoEyzoz5CvJL0emE+BK47rpSZF+n1uMDwtZC3Vl
        3LBuIwptXukKs9fNtSW/Qg51nniJqoU=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 407052C141;
        Fri, 13 Jan 2023 13:43:56 +0000 (UTC)
Date:   Fri, 13 Jan 2023 14:43:53 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     akpm@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, zwp10758@gmail.com
Subject: Re: [RFC PATCH] hung_task: show sysctl_hung_task_warnings
Message-ID: <Y8FgGev2HPX/ksUS@alley>
References: <Y7/QOZYvOFjbP3wu@zwp-5820-Tower>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7/QOZYvOFjbP3wu@zwp-5820-Tower>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2023-01-12 17:17:45, Weiping Zhang wrote:
> This patch try to add more debug info to detect lost kernel log or no
> hung task was detected.
> 
> The user set 10 to the hung_task_timeout_secs, the kernel log:
> 
> [ 3942.642220] INFO: task mount:19066 blocked for more than 10 seconds.
> [ 3952.876768] INFO: task kworker/u81:0:7 blocked for more than 10 seconds.
> [ 3952.877088] INFO: task scsi_eh_0:506 blocked for more than 10 seconds.
> [ 3952.878212] INFO: task mount:19066 blocked for more than 10 seconds.
> [ 3963.116805] INFO: task kworker/u81:0:7 blocked for more than 10 seconds.
> [ 3963.117137] INFO: task scsi_eh_0:506 blocked for more than 10 seconds.
> [ 3963.118275] INFO: task mount:19066 blocked for more than 10 seconds.
> [ 3973.356837] INFO: task kworker/u81:0:7 blocked for more than 10 seconds.
> [ 3973.357148] INFO: task scsi_eh_0:506 blocked for more than 10 seconds.
> [ 3973.358247] INFO: task mount:19066 blocked for more than 10 seconds.
> [ 3993.836899] INFO: task kworker/u81:0:7 blocked for more than 10 seconds.
> [ 3993.837238] INFO: task scsi_eh_0:506 blocked for more than 10 seconds.
> [ 3993.838356] INFO: task mount:19066 blocked for more than 10 seconds.
> 
> There is no any log at about 3983, it's hard to know if kernel log was
> lost or there is no hung task was detected at that moment. So this patch
> print sysctl_hung_task_warnings to distinguish the above two cases.
> 
> Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
> ---
>  kernel/hung_task.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index c71889f3f3fc..ca917931473d 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -127,8 +127,11 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
>  	 * complain:
>  	 */
>  	if (sysctl_hung_task_warnings) {
> -		if (sysctl_hung_task_warnings > 0)
> +		if (sysctl_hung_task_warnings > 0) {
>  			sysctl_hung_task_warnings--;
> +			pr_err("sysctl_hung_task_warnings: %d\n",
> +				sysctl_hung_task_warnings);
> +		}

It is too much noise. But it might make sense to report it when
the counter gets down to zero. Something like:

		if (sysctl_hung_task_warnings)
			pr_info("Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings\n");

and move this down after printing all the details for this hung task report.

>  		pr_err("INFO: task %s:%d blocked for more than %ld seconds.\n",
>  		       t->comm, t->pid, (jiffies - t->last_switch_time) / HZ);
>  		pr_err("      %s %s %.*s\n",

Best Regards,
Petr
