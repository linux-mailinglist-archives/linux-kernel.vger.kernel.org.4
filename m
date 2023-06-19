Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850CE7359CF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 16:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjFSOix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 10:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjFSOiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 10:38:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7812E5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 07:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687185484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n81+s1XEobkyuHvPUCbHGRBITPBL/Ux61aHB9fOgZks=;
        b=hXEEZcZt9N8OZKfZl+GVxNz6a+mVf/OxIlq9vRWJgMGXJ58pUACweiweGNLvwRrwiDW1fM
        xaNBaNAQSZz4Rn1GoqfM+RrQOkT/y9fx4jiQbZPHu3+1YI6cslTH0lrcDK1HLV7RZFRbKz
        Et0bFh46MmCxQdtp2juoOLIGQA0qhPw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-526-cxEHApTfMDOSqW_QX_PlZg-1; Mon, 19 Jun 2023 10:37:58 -0400
X-MC-Unique: cxEHApTfMDOSqW_QX_PlZg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 74C391C04B64;
        Mon, 19 Jun 2023 14:37:58 +0000 (UTC)
Received: from [10.22.32.69] (unknown [10.22.32.69])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D0C96112132C;
        Mon, 19 Jun 2023 14:37:57 +0000 (UTC)
Message-ID: <c32a0bad-b20f-e53b-a38a-5da687b8a205@redhat.com>
Date:   Mon, 19 Jun 2023 10:37:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] cgroup/cpuset: remove unneeded nodes_or() in
 cpuset_change_task_nodemask()
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, tj@kernel.org,
        hannes@cmpxchg.org, lizefan.x@bytedance.com
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230617083043.2065556-1-linmiaohe@huawei.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230617083043.2065556-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/23 04:30, Miaohe Lin wrote:
> The tsk->mems_allowed is changed before calling mpol_rebind_task() and
> being reassigned right after it. But tsk->mems_allowed is not needed
> inside mpol_rebind_task(). So remove unneeded tsk->mems_allowed modify
> via nodes_or() here.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 58e6f18f01c1..33a429c1179f 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1941,7 +1941,6 @@ static void cpuset_change_task_nodemask(struct task_struct *tsk,
>   	local_irq_disable();
>   	write_seqcount_begin(&tsk->mems_allowed_seq);
>   
> -	nodes_or(tsk->mems_allowed, tsk->mems_allowed, *newmems);
>   	mpol_rebind_task(tsk, newmems);
>   	tsk->mems_allowed = *newmems;
>   

That line was inserted by commit cc9a6c8776615 ("cpuset: mm: reduce 
large amounts of memory barrier related damage v3"). At first glance, it 
does looks like it is not necessary. However, I am not sure if a race is 
possible that will produce a false failure because of missing this line.

My 2 cents.

Cheers,
Longman

