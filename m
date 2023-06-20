Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9567737339
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 19:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjFTRuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 13:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjFTRuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 13:50:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA4A1728
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 10:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687283358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hWQlynuRt1Gl0mrdrJdeyjqzsyOsoIOcGlKrs4rJzEo=;
        b=IQxHIQ45zk3ST41oIypIi3DitmJkhaO5nuDyObQEkJqUvMZTFkgMbrBDt/K4Z6gk7Z9ILC
        8Z3u0l8LCBZoneOxq98lDCkMzKI2m1J95WHq+laV6jO9z2oPaz9iRRMmRUhlv/wdZK6PMV
        M6PGxoSrbYp1P4wnVfamRglu+torSRQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-120-WFuT7F1LPBOxWDEpBBGB8A-1; Tue, 20 Jun 2023 13:49:14 -0400
X-MC-Unique: WFuT7F1LPBOxWDEpBBGB8A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 08FB21C0512B;
        Tue, 20 Jun 2023 17:49:13 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.18.138])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 55E39C1ED97;
        Tue, 20 Jun 2023 17:49:12 +0000 (UTC)
Date:   Tue, 20 Jun 2023 13:49:09 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Use recent_used_cpu to test p->cpus_ptr
Message-ID: <20230620174909.GA678839@lorien.usersys.redhat.com>
References: <20230620080747.359122-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620080747.359122-1-linmiaohe@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 04:07:47PM +0800 Miaohe Lin wrote:
> When checking whether a recently used CPU can be a potential idle
> candidate, recent_used_cpu should be used to test p->cpus_ptr as
> p->recent_used_cpu is not equal to recent_used_cpu and candidate
> decision is made based on recent_used_cpu here.
> 
> Fixes: 89aafd67f28c ("sched/fair: Use prev instead of new target as recent_used_cpu")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 7666dbc2b788..3cc06cfca350 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7156,7 +7156,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>  	    recent_used_cpu != target &&
>  	    cpus_share_cache(recent_used_cpu, target) &&
>  	    (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
> -	    cpumask_test_cpu(p->recent_used_cpu, p->cpus_ptr) &&
> +	    cpumask_test_cpu(recent_used_cpu, p->cpus_ptr) &&
>  	    asym_fits_cpu(task_util, util_min, util_max, recent_used_cpu)) {
>  		return recent_used_cpu;
>  	}
> -- 
> 2.27.0
> 

This looks correct to me.

Reviewed-by: Phil Auld <pauld@redhat.com>


-- 

