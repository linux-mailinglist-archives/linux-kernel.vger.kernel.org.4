Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC166C321F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 13:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjCUM64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 08:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjCUM6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 08:58:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7716C2D48
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 05:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679403480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q2xkYNfVT5T4eh3J0pm8IWrwrBm69x41pEfwfOVdgHA=;
        b=DP6WP1h5hBRcJ/Q9ESb3YTuHGwo71rjEeo3MCcLLHbLa/esC75HxKRNWjVidGUcHEj8Z9S
        xpDQnD2Q3uGwvzNLyc43X5ICYdHNdRjLMIntTxmZg88LuN4aqbGovWC4Qbg1NoFGdL6ONG
        BJ+WYCcToGGD9UASo4olxGUZmnbVrRE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-64-8JpaL_WyOJuYFWsujIn_WA-1; Tue, 21 Mar 2023 08:57:55 -0400
X-MC-Unique: 8JpaL_WyOJuYFWsujIn_WA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9BBAE3C1712C;
        Tue, 21 Mar 2023 12:57:54 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 65A66140E960;
        Tue, 21 Mar 2023 12:57:54 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 84184400E055D; Mon, 20 Mar 2023 15:32:15 -0300 (-03)
Date:   Mon, 20 Mar 2023 15:32:15 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Russell King <linux@armlinux.org.uk>,
        Huacai Chen <chenhuacai@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v7 01/13] vmstat: allow_direct_reclaim should use
 zone_page_state_snapshot
Message-ID: <ZBimr/DeUhcf7I5D@tpad>
References: <20230320180332.102837832@redhat.com>
 <20230320180745.556821285@redhat.com>
 <ZBikEKiM3NcWOP/p@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBikEKiM3NcWOP/p@dhcp22.suse.cz>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 07:21:04PM +0100, Michal Hocko wrote:
> On Mon 20-03-23 15:03:33, Marcelo Tosatti wrote:
> > A customer provided evidence indicating that a process
> > was stalled in direct reclaim:
> > 
> >  - The process was trapped in throttle_direct_reclaim().
> >    The function wait_event_killable() was called to wait condition     
> >    allow_direct_reclaim(pgdat) for current node to be true.     
> >    The allow_direct_reclaim(pgdat) examined the number of free pages     
> >    on the node by zone_page_state() which just returns value in     
> >    zone->vm_stat[NR_FREE_PAGES].     
> >                                                 
> >  - On node #1, zone->vm_stat[NR_FREE_PAGES] was 0.            
> >    However, the freelist on this node was not empty.     
> >                            
> >  - This inconsistent of vmstat value was caused by percpu vmstat on     
> >    nohz_full cpus. Every increment/decrement of vmstat is performed     
> >    on percpu vmstat counter at first, then pooled diffs are cumulated     
> >    to the zone's vmstat counter in timely manner. However, on nohz_full     
> >    cpus (in case of this customer's system, 48 of 52 cpus) these pooled     
> >    diffs were not cumulated once the cpu had no event on it so that     
> >    the cpu started sleeping infinitely.                       
> >    I checked percpu vmstat and found there were total 69 counts not         
> >    cumulated to the zone's vmstat counter yet.     
> >                                          
> >  - In this situation, kswapd did not help the trapped process.     
> >    In pgdat_balanced(), zone_wakermark_ok_safe() examined the number     
> >    of free pages on the node by zone_page_state_snapshot() which     
> >    checks pending counts on percpu vmstat.     
> >    Therefore kswapd could know there were 69 free pages correctly.     
> >    Since zone->_watermark = {8, 20, 32}, kswapd did not work because     
> >    69 was greater than 32 as high watermark.     
> > 
> > Change allow_direct_reclaim to use zone_page_state_snapshot, which
> > allows a more precise version of the vmstat counters to be used.
> > 
> > allow_direct_reclaim will only be called from try_to_free_pages,
> > which is not a hot path.
> 
> Have you managed to test this patch to confirm it addresses the above
> issue? It should but better double check that.
> 
> > Suggested-by: Michal Hocko <mhocko@suse.com>
> > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 
> The patch makes sense regardless but a note about testing should be
> added.
> 
> Acked-by: Michal Hocko <mhocko@suse.com>

Michal,

The patch has not been tested in the original setup where the problem 
was found, however i don't think its easy to do that validation
(checking with the reporter anyway).

Perhaps one could find a synthetic reproducer.

It is pretty easy to note that, on an isolated nohz_full CPU, the 
deferrable timer that is queued on it (timer which should queue vmstat_update
on that CPU) does not execute for long periods.
This makes the global stats stale (since per-CPU free pages can become
stale for as long as the CPU has tick processing stopped).
Which matches the data available.

Thanks!

