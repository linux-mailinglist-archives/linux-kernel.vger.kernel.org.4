Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044866D585B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 08:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbjDDGCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 02:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbjDDGCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 02:02:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092D71BC3
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 23:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680588092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cEjburEshfupS59FzIzY20KcgCn+Z0OofnnG6gTk1R4=;
        b=ggf+G/rx5zU52A1H0r99zNu4y8TDoipL1qxeO2LjCqXWGvNCa8CYVx1XVAl9DnLDvaUmcz
        ti8ujf84LmUjWl69SxoietD3Zb1ZTeZgfF79rWxE7RX9Hp85Ax4pT3DWlmAB1W0YU/CZUa
        eKc20xqyu4QmAaqhIai8EgwaS4m6a6o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-73-RAYnqle7O1KjYBt4-em6lQ-1; Tue, 04 Apr 2023 02:01:26 -0400
X-MC-Unique: RAYnqle7O1KjYBt4-em6lQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C9D9811E7C;
        Tue,  4 Apr 2023 06:01:25 +0000 (UTC)
Received: from rh (vpn2-52-18.bne.redhat.com [10.64.52.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 257DE2027061;
        Tue,  4 Apr 2023 06:01:23 +0000 (UTC)
Received: from localhost ([::1] helo=rh)
        by rh with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <dchinner@redhat.com>)
        id 1pjZjM-002uhf-0s;
        Tue, 04 Apr 2023 16:01:20 +1000
Date:   Tue, 4 Apr 2023 16:01:18 +1000
From:   Dave Chinner <dchinner@redhat.com>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     dennis@kernel.org, tj@kernel.org, cl@linux.com, linux-mm@kvack.org,
        yury.norov@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
        yebin10@huawei.com
Subject: Re: [PATCH 2/2] lib/percpu_counter: fix dying cpu compare race
Message-ID: <ZCu9LtdA+NMrfG9x@rh>
References: <20230404014206.3752945-1-yebin@huaweicloud.com>
 <20230404014206.3752945-3-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404014206.3752945-3-yebin@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 09:42:06AM +0800, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> In commit 8b57b11cca88 ("pcpcntrs: fix dying cpu summation race") a race
> condition between a cpu dying and percpu_counter_sum() iterating online CPUs
> was identified.
> Acctually, there's the same race condition between a cpu dying and
> __percpu_counter_compare(). Here, use 'num_online_cpus()' for quick judgment.
> But 'num_online_cpus()' will be decreased before call 'percpu_counter_cpu_dead()',
> then maybe return incorrect result.
> To solve above issue, also need to add dying CPUs count when do quick judgment
> in __percpu_counter_compare().
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  lib/percpu_counter.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
> index 5004463c4f9f..399840cb0012 100644
> --- a/lib/percpu_counter.c
> +++ b/lib/percpu_counter.c
> @@ -227,6 +227,15 @@ static int percpu_counter_cpu_dead(unsigned int cpu)
>  	return 0;
>  }
>  
> +static __always_inline unsigned int num_count_cpus(void)
> +{
> +#ifdef CONFIG_HOTPLUG_CPU
> +	return (num_online_cpus() + num_dying_cpus());
> +#else
> +	return num_online_cpus();
> +#endif
> +}
> +
>  /*
>   * Compare counter against given value.
>   * Return 1 if greater, 0 if equal and -1 if less
> @@ -237,7 +246,7 @@ int __percpu_counter_compare(struct percpu_counter *fbc, s64 rhs, s32 batch)
>  
>  	count = percpu_counter_read(fbc);
>  	/* Check to see if rough count will be sufficient for comparison */
> -	if (abs(count - rhs) > (batch * num_online_cpus())) {
> +	if (abs(count - rhs) > (batch * num_count_cpus())) {

What problem is this actually fixing? You haven't explained how the
problem you are fixing manifests in the commit message or the cover
letter.

We generally don't care about the accuracy of the comparison here
because we've used percpu_counter_read() which is completely racy
against on-going updates. e.g. we can get preempted between
percpu_counter_read() and the check and so the value can be
completely wrong by the time we actually check it. Hence checking
online vs online+dying really doesn't fix any of the common race
conditions that occur here.

Even if we fall through to using percpu_counter_sum() for the
comparison value, that is still not accurate in the face of racing
updates to the counter because percpu_counter_sum only prevents
the percpu counter from being folded back into the global sum
while it is running. The comparison is still not precise or accurate.

IOWs, the result of this whole function is not guaranteed to be
precise or accurate; percpu counters cannot ever be relied on for
exact threshold detection unless there is some form of external
global counter synchronisation being used for those comparisons
(e.g. a global spinlock held around all the percpu_counter_add()
modifications as well as the __percpu_counter_compare() call).

That's always been the issue with unsynchronised percpu counters -
cpus dying just don't matter here because there are many other more
common race conditions that prevent accurate, race free comparison
of per-cpu counters.

Cheers,

Dave.
-- 
Dave Chinner
dchinner@redhat.com

