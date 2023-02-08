Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB96B68F022
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 14:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjBHNtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 08:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjBHNtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 08:49:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC3FD52F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 05:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675864142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JbZ7LeeQIDp6jPae+Tix48tv2Fam/0AHZFSTOrUdCrw=;
        b=ZN8iUJ/4CkUCxsjivW5jq/m/0ZVxhxnjfAbnQYH86n+GJmAkZZ8kuYNN8Wr/IxoPc+/tbQ
        NEyRzw8bYLd3bJ+NIfIui+7D62QZfiibOvSeBbafoI5DWi4c+fVz1SWPPx8MoI0QV5k1/V
        0SVm23Qto9ZXIIXx6po2gcW/nP+1knc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-434-9yjN5tT0O1yuDuyBvJhSgQ-1; Wed, 08 Feb 2023 08:49:00 -0500
X-MC-Unique: 9yjN5tT0O1yuDuyBvJhSgQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 243011C05AF0;
        Wed,  8 Feb 2023 13:49:00 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.32.232])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F6551121314;
        Wed,  8 Feb 2023 13:48:59 +0000 (UTC)
Date:   Wed, 8 Feb 2023 08:48:58 -0500
From:   Phil Auld <pauld@redhat.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [RFC] sched: show cpu number when sched_show_task
Message-ID: <Y+OoSsB27e2LDc3E@lorien.usersys.redhat.com>
References: <20230208124655.2592560-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208124655.2592560-1-peng.fan@oss.nxp.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 08:46:55PM +0800 Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> It would be helpful to show cpu number when dump task. Such as
> when doing system suspend, we could know the failed freezing
> process run on which cpu.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  kernel/sched/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index daff72f00385..0c7a1b2f7baf 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8876,7 +8876,7 @@ void sched_show_task(struct task_struct *p)
>  	if (!try_get_task_stack(p))
>  		return;
>  
> -	pr_info("task:%-15.15s state:%c", p->comm, task_state_to_char(p));
> +	pr_info("task:%-15.15s state:%c cpu:0x%x", p->comm, task_state_to_char(p), task_cpu(p));
>  
>  	if (task_is_running(p))
>  		pr_cont("  running task    ");
> -- 
> 2.37.1
> 

Looks useful, thanks.

Reviewed-by: Phil Auld <pauld@redhat.com>


-- 

