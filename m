Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509156BF0C8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 19:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjCQShg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 14:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjCQShe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 14:37:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F42B4BE85
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 11:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679078207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EZUL8o0Hxspjf9WQhOGBGAxIyrZGEUO1SIJiRh0pxXY=;
        b=LvEJ+OH4FxSOgttu6B2dyxayILn+YxjXNnQOTFZ75iLN/DXDv7YuLl5WCcbJxzGai+15aa
        7YsbOTz80JPfpL6RYGIvKTSBsdDK9iKWqbFjy2GRDDsioqaju1nSdE2lEwK9PfYuiPwKZR
        +KPPu0cXrk/FtKLrIBF6x+DX/GQSg6k=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-267-SJzpPHoxMUWtA7JC4hI7EA-1; Fri, 17 Mar 2023 14:36:41 -0400
X-MC-Unique: SJzpPHoxMUWtA7JC4hI7EA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 50F361C12989;
        Fri, 17 Mar 2023 18:36:40 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 03D39483EC1;
        Fri, 17 Mar 2023 18:36:39 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id EE2C0403B5BB3; Fri, 17 Mar 2023 15:33:13 -0300 (-03)
Date:   Fri, 17 Mar 2023 15:33:13 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Leonardo Bras <leobras@redhat.com>,
        Frederic Weisbecker <fweisbecker@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 1/2] sched/isolation: Add cpu_is_isolated() API
Message-ID: <ZBSyaVk919Fi07Wv@tpad>
References: <20230317134448.11082-1-mhocko@kernel.org>
 <20230317134448.11082-2-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230317134448.11082-2-mhocko@kernel.org>
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

On Fri, Mar 17, 2023 at 02:44:47PM +0100, Michal Hocko wrote:
> From: Frederic Weisbecker <frederic@kernel.org>
> 
> Provide this new API to check if a CPU has been isolated either through
> isolcpus= or nohz_full= kernel parameter.
> 
> It aims at avoiding kernel load deemed to be safely spared on CPUs
> running sensitive workload that can't bear any disturbance, such as
> pcp cache draining.

Hi Michal,

This makes no sense to me.

HK_TYPE_DOMAIN is set when isolcpus=domain is configured.
HK_TYPE_TICK is set when nohz_full= is configured.

The use-cases i am aware of use either:

isolcpus=managed_irq,... nohz_full=
OR
isolcpus=domain,managed_irq,... nohz_full=

So what is the point of this function again?

Perhaps it made sense along with, but now does not make sense
anymore:

Subject: [PATCH 1/2] sched/isolation: Merge individual nohz_full features into a common housekeeping flag

The individual isolation features turned on by nohz_full were initially
split in order for each of them to be tunable through cpusets. However
plans have changed in favour of an interface (be it cpusets or sysctl)
grouping all these features to be turned on/off altogether. Then should
the need ever arise, the interface can still be expanded to handle the
individual isolation features.

But Michal can just use housekeeping_test_cpu(cpu, HK_TYPE_TICK) and
the convertion of nohz_full features into a common housekeeping flag
can convert that to something else later?



> 
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  include/linux/sched/isolation.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> index 8c15abd67aed..fe1a46f30d24 100644
> --- a/include/linux/sched/isolation.h
> +++ b/include/linux/sched/isolation.h
> @@ -46,6 +46,12 @@ static inline bool housekeeping_enabled(enum hk_type type)
>  
>  static inline void housekeeping_affine(struct task_struct *t,
>  				       enum hk_type type) { }
> +
> +static inline bool housekeeping_test_cpu(int cpu, enum hk_type type)
> +{
> +	return true;
> +}
> +
>  static inline void housekeeping_init(void) { }
>  #endif /* CONFIG_CPU_ISOLATION */
>  
> @@ -58,4 +64,10 @@ static inline bool housekeeping_cpu(int cpu, enum hk_type type)
>  	return true;
>  }
>  
> +static inline bool cpu_is_isolated(int cpu)
> +{
> +	return !housekeeping_test_cpu(cpu, HK_TYPE_DOMAIN) ||
> +		 !housekeeping_test_cpu(cpu, HK_TYPE_TICK);
> +}
> +
>  #endif /* _LINUX_SCHED_ISOLATION_H */
> -- 
> 2.30.2
> 
> 

