Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90AF65D2DA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 13:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239232AbjADMg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 07:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239171AbjADMf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 07:35:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCF21AA1B
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 04:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672835716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5hE0oddOlBOQnUMB6h9tuFwq5zrgy0C3MFSswKsR7tU=;
        b=RXJOEQ5aC3Q1QQWY1sj/g2VbWdauWadQ0d6jIfQLMCrYuR50GjLyok+CNlFf9W1S14fUnh
        lKL3RkHNzf7XeDN33cUO0E9ywVhDTgu9jDfCI9S/flfR8hkqbwqAbE5RiYoMhpk4xQ30cj
        vrFw7bMr87Pc6tLpAJFNVcglp7m/tqc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-634-Y0jQp5o0PgWBlBJf02lrsQ-1; Wed, 04 Jan 2023 07:35:15 -0500
X-MC-Unique: Y0jQp5o0PgWBlBJf02lrsQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 41451101A52E;
        Wed,  4 Jan 2023 12:35:15 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CCD8949BB6A;
        Wed,  4 Jan 2023 12:35:14 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id DF24C400E5705; Sat, 31 Dec 2022 21:38:04 -0300 (-03)
Date:   Sat, 31 Dec 2022 21:38:04 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     atomlin@atomlin.com, cl@linux.com, tglx@linutronix.de,
        mingo@kernel.org, peterz@infradead.org, pauld@redhat.com,
        neelx@redhat.com, oleksandr@natalenko.name,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v12 2/6] mm/vmstat: Use vmstat_dirty to track
 CPU-specific vmstat discrepancies
Message-ID: <Y7DV7A9GDTbYIDZB@tpad>
References: <20221227121137.102497574@redhat.com>
 <20221227121341.981235373@redhat.com>
 <20221230132132.GA186035@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221230132132.GA186035@lothringen>
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

On Fri, Dec 30, 2022 at 02:21:32PM +0100, Frederic Weisbecker wrote:
> On Tue, Dec 27, 2022 at 09:11:39AM -0300, Marcelo Tosatti wrote:
> > @@ -606,6 +608,7 @@ static inline void mod_zone_state(struct
> >  
> >  	if (z)
> >  		zone_page_state_add(z, zone, item);
> > +	vmstat_mark_dirty();
> >  }
> >  
> >  void mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
> > @@ -674,6 +677,7 @@ static inline void mod_node_state(struct
> >  
> >  	if (z)
> >  		node_page_state_add(z, pgdat, item);
> > +	vmstat_mark_dirty();
> 
> Looking at this further, about the two above chunks, there is a risk to
> mark the wrong CPU dirty because those functions are preemptible and rely
> on this_cpu_cmpxchg() to deal with preemption.
> 
> Thanks.

Hi Frederic,

Yes, good catch: if the CPU is preempted after this_cpu_cmpxchg(),
but before vmstat_mark_dirty, then one ends up with a CPU with
per-CPU vm counters dirty and the per-CPU vmstat dirty bit unset.

This could cause a CPU to remain with the per-CPU vm counters dirty
for longer than sysctl_stat_interval.

Should move vmstat_mark_dirty() above "if (z)", then do
preempt_disable() on function entry and preempt_enable()
after vmstat_mark_dirty. Luckily preempt_disable()/preempt_enable()
is much cheaper than local_irq_disable()/local_irq_enable().

