Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0952F6A8BA1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 23:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjCBWT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 17:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjCBWTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 17:19:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4267D17CC0
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 14:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677795541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jlr3DPbhmz+YnZeWV0ifc3qyeasTfNTJ9iJvKosFhgg=;
        b=TmsSCSD3mQUKNYDUEy0a91nU2CceiPhVlKTC0xO43XrcrQTvAbVd3CoJc9XOtWTrDwCD7e
        sNxB7RY9U/Jr6PwvnxRoIlZtATDP6rStvlEoWYHI4JfGujhdW8+8FGzrgx787TYUaZksoA
        z0mR+ym3lUguHFaTgGXUu+rEo2SAgmQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-367-egb84iHhOmOmmjwdOe72nQ-1; Thu, 02 Mar 2023 16:17:19 -0500
X-MC-Unique: egb84iHhOmOmmjwdOe72nQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 26F70101A52E;
        Thu,  2 Mar 2023 21:17:19 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DE2422026D4B;
        Thu,  2 Mar 2023 21:17:18 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 7442440135051; Thu,  2 Mar 2023 18:16:42 -0300 (-03)
Date:   Thu, 2 Mar 2023 18:16:42 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 10/11] mm/vmstat: switch vmstat shepherd to flush
 per-CPU counters remotely
Message-ID: <ZAESOs/EeMCNp7YX@tpad>
References: <20230209150150.380060673@redhat.com>
 <20230209153204.901518530@redhat.com>
 <ZAEOk7GdJ0c8NS+y@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAEOk7GdJ0c8NS+y@x1n>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 04:01:07PM -0500, Peter Xu wrote:
> On Thu, Feb 09, 2023 at 12:02:00PM -0300, Marcelo Tosatti wrote:
> > +#ifdef CONFIG_HAVE_CMPXCHG_LOCAL
> > +/* Flush counters remotely if CPU uses cmpxchg to update its per-CPU counters */
> > +static void vmstat_shepherd(struct work_struct *w)
> > +{
> > +	int cpu;
> > +
> > +	cpus_read_lock();
> > +	for_each_online_cpu(cpu) {
> > +		cpu_vm_stats_fold(cpu);
> 
> Nitpick: IIUC this line is the only change with CONFIG_HAVE_CMPXCHG_LOCAL
> to replace the queuing.  Would it be cleaner to move the ifdef into
> vmstat_shepherd, then, and keep the common logic?

https://lore.kernel.org/lkml/20221223144150.GA79369@lothringen/

Could have

#ifdef CONFIG_HAVE_CMPXCHG_LOCAL
int cpu_flush_vm_stats(int cpu)
{
	return cpu_vm_stats_fold(cpu);
}
#else
int cpu_flush_vm_stats(int cpu)
{
	struct delayed_work *dw = &per_cpu(vmstat_work, cpu);

	if (!delayed_work_pending(dw) && need_update(cpu))
		queue_delayed_work_on(cpu, mm_percpu_wq, dw, 0);
}
#endif

static void vmstat_shepherd(struct work_struct *w)
{
       int cpu;

       cpus_read_lock();
       for_each_online_cpu(cpu) {
	       cpu_flush_vm_stats(cpu);
               cond_resched();
       }
       cpus_read_unlock();

       schedule_delayed_work(&shepherd,
               round_jiffies_relative(sysctl_stat_interval));
}

This looks really awkward to me. But then, we don't want
schedule_delayed_work if !CONFIG_HAVE_CMPXCHG_LOCAL.
The common part would be the cpus_read_lock and for_each_online_cpu
loop.

So it seems the current separation is quite readable
(unless you have a suggestion).

> > +		cond_resched();
> > +	}
> > +	cpus_read_unlock();
> > +
> > +	schedule_delayed_work(&shepherd,
> > +		round_jiffies_relative(sysctl_stat_interval));
> > +}
> > +#else
> >  static void vmstat_shepherd(struct work_struct *w)
> >  {
> >  	int cpu;
> > @@ -2026,6 +2043,7 @@ static void vmstat_shepherd(struct work_
> >  	schedule_delayed_work(&shepherd,
> >  		round_jiffies_relative(sysctl_stat_interval));
> >  }
> > +#endif
> >  
> >  static void __init start_shepherd_timer(void)
> >  {
> > 
> > 
> > 
> 
> -- 
> Peter Xu
> 
> 

