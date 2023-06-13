Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C97172E3E7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 15:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242403AbjFMNRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 09:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238917AbjFMNRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 09:17:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF3919A7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 06:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686662221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qHvwTY0KwvYyt3gEsW8aNWhLJkoMXbxKSjXgQCSlsp0=;
        b=S/cCQho6L+L5ZpxgBouFAtL8DIkdOGx4tG2YYE3NXcPQp0kQ72W6Cca/PTclrIYiHIS67p
        w75aoROaWZHmCBHkEyZ8hZOOvVYI4s2/ThIHcja68o8Z5WEAXSMPa0lhQ5eTJZG7JvgO1U
        PmGMQjFLAI/FrywPHEnUdOY96fWKXc8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-203-Zp-gRzpZO2G9F9h24LCQig-1; Tue, 13 Jun 2023 09:16:59 -0400
X-MC-Unique: Zp-gRzpZO2G9F9h24LCQig-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E7C83101AA42;
        Tue, 13 Jun 2023 13:16:58 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.39.193.76])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 88806140E951;
        Tue, 13 Jun 2023 13:16:55 +0000 (UTC)
Date:   Tue, 13 Jun 2023 09:16:51 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/deadline: simplify dl_bw_cpus() using
 cpumask_weight_and()
Message-ID: <20230613131651.GA536267@lorien.usersys.redhat.com>
References: <20230522115605.1238227-1-linmiaohe@huawei.com>
 <7bfde912-1e15-ec1f-8a62-9cc508739cd6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bfde912-1e15-ec1f-8a62-9cc508739cd6@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 08:19:22PM +0800 Miaohe Lin wrote:
> On 2023/5/22 19:56, Miaohe Lin wrote:
> > cpumask_weight_and() can be used to count of bits both in rd->span and
> > cpu_active_mask. No functional change intended.
> > 
> > Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> 
> friendly ping... :)

This looks reasonable, and better, to me.

Reviewed-by: Phil Auld <pauld@redhat.com>

> 
> > ---
> >  kernel/sched/deadline.c | 11 +----------
> >  1 file changed, 1 insertion(+), 10 deletions(-)
> > 
> > diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> > index 166c3e6eae61..fe983ed7bb12 100644
> > --- a/kernel/sched/deadline.c
> > +++ b/kernel/sched/deadline.c
> > @@ -110,20 +110,11 @@ static inline struct dl_bw *dl_bw_of(int i)
> >  static inline int dl_bw_cpus(int i)
> >  {
> >  	struct root_domain *rd = cpu_rq(i)->rd;
> > -	int cpus;
> >  
> >  	RCU_LOCKDEP_WARN(!rcu_read_lock_sched_held(),
> >  			 "sched RCU must be held");
> >  
> > -	if (cpumask_subset(rd->span, cpu_active_mask))
> > -		return cpumask_weight(rd->span);
> > -
> > -	cpus = 0;
> > -
> > -	for_each_cpu_and(i, rd->span, cpu_active_mask)
> > -		cpus++;
> > -
> > -	return cpus;
> > +	return cpumask_weight_and(rd->span, cpu_active_mask);
> >  }
> >  
> >  static inline unsigned long __dl_bw_capacity(const struct cpumask *mask)
> > 
> 

-- 

