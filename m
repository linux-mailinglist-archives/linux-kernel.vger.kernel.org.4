Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB0F64EF83
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 17:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbiLPQjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 11:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiLPQik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 11:38:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A8D2EF6C
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 08:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671208673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cWScWAvYep77Gyx4lnGZnuqfT5BE0PC8Gj9tWWazPyU=;
        b=anSj7N0AqrMUtbYX4umx9YKWejwDBBylzDi+BjzZZ6EA6om8Ua45gDz3Ei8qS30E6JxqNt
        B+Edjmcwpe6yOTp8rbaVwiZqWL5BGYw1DHczwqAYhrik+vcoY8Xu/0l9K7q5toRg579CIi
        4/1OBKRuZt+dlUIpGxmQWh4qJ4PvE5o=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-16-Vl2fRmUEPNytzogjf9AdJQ-1; Fri, 16 Dec 2022 11:37:48 -0500
X-MC-Unique: Vl2fRmUEPNytzogjf9AdJQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C93881C09070;
        Fri, 16 Dec 2022 16:37:47 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 55632400F5A;
        Fri, 16 Dec 2022 16:37:47 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 1E8FF401A0FD8; Fri, 16 Dec 2022 13:16:09 -0300 (-03)
Date:   Fri, 16 Dec 2022 13:16:09 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     atomlin@redhat.com, cl@linux.com, tglx@linutronix.de,
        mingo@kernel.org, peterz@infradead.org, pauld@redhat.com,
        neelx@redhat.com, oleksandr@natalenko.name,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v9 3/5] mm/vmstat: manage per-CPU stats from CPU context
 when NOHZ full
Message-ID: <Y5yZyd0gd7M3M2+j@tpad>
References: <20221206161826.698593151@redhat.com>
 <20221206162416.474800121@redhat.com>
 <20221214133302.GA1931356@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214133302.GA1931356@lothringen>
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

On Wed, Dec 14, 2022 at 02:33:02PM +0100, Frederic Weisbecker wrote:
> On Tue, Dec 06, 2022 at 01:18:29PM -0300, Marcelo Tosatti wrote:
> >  static inline void vmstat_mark_dirty(void)
> >  {
> > +	int cpu = smp_processor_id();
> > +
> > +	if (tick_nohz_full_cpu(cpu) && !this_cpu_read(vmstat_dirty)) {
> > +		struct delayed_work *dw;
> > +
> > +		dw = &per_cpu(vmstat_work, cpu);
> > +		if (!delayed_work_pending(dw)) {
> > +			unsigned long delay;
> > +
> > +			delay = round_jiffies_relative(sysctl_stat_interval);
> > +			queue_delayed_work_on(cpu, mm_percpu_wq, dw, delay);
> 
> Currently the vmstat_work is flushed on cpu_hotplug (CPUHP_AP_ONLINE_DYN).
> vmstat_shepherd makes sure to not rearm it afterward. But now it looks
> possible for the above to do that mistake?

Don't think the mistake is an issue. In case of a
queue_delayed_work_on being called after cancel_delayed_work_sync,
either vmstat_update executes on the local CPU, or on a
different CPU (after the bound kworkers have been moved).

Each case is fine (see vmstat_update).

> > +		}
> > +	}
> >  	this_cpu_write(vmstat_dirty, true);
> >  }
> > @@ -2009,6 +2028,10 @@ static void vmstat_shepherd(struct work_
> >  	for_each_online_cpu(cpu) {
> >  		struct delayed_work *dw = &per_cpu(vmstat_work, cpu);
> >  
> > +		/* NOHZ full CPUs manage their own vmstat flushing */
> > +		if (tick_nohz_full_cpu(smp_processor_id()))
> 
> It should be the remote CPU instead of the current one.

Fixed.

