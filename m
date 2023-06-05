Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA9B723085
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236015AbjFETzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235469AbjFETzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:55:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E77F4
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 12:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685994861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fhotjoqtlTKm+Ky5u6YN7fnyK5g1HzY5C6hXhYwr86s=;
        b=cou1Vv5iXE7z0dk1FroXcEsiZJBbJs4eC6HbjegufWS8XSZs1f0xlGVBq5sJquP7T+QlAd
        8O01ZRd1zQ+I+0Tu10S63LSKEn10egteMsbHWrklfIZ5Fl360G6uQ1N3hk8UCNdZRzW7gg
        iGDj3s1Dd9GkchMN7jgc3/X0l3zrlIU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-324-4mCY2ZSYPGyTBc46UN_-JA-1; Mon, 05 Jun 2023 15:54:17 -0400
X-MC-Unique: 4mCY2ZSYPGyTBc46UN_-JA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 62AA9802E58;
        Mon,  5 Jun 2023 19:54:17 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 14C9240317D;
        Mon,  5 Jun 2023 19:54:17 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 881F340CAC207; Mon,  5 Jun 2023 16:53:51 -0300 (-03)
Date:   Mon, 5 Jun 2023 16:53:51 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v3 3/3] mm/vmstat: do not refresh stats for isolated CPUs
Message-ID: <ZH49Tx4kbOG1zESS@tpad>
References: <20230605185627.923698377@redhat.com>
 <20230605190132.087124739@redhat.com>
 <ZH41bFWrc0LWae/U@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH41bFWrc0LWae/U@dhcp22.suse.cz>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 09:20:12PM +0200, Michal Hocko wrote:
> On Mon 05-06-23 15:56:30, Marcelo Tosatti wrote:
> > schedule_work_on API uses the workqueue mechanism to
> > queue a work item on a queue. A kernel thread, which
> > runs on the target CPU, executes those work items.
> > 
> > Therefore, when using the schedule_work_on API,
> > it is necessary for the kworker kernel thread to
> > be scheduled in, for the work function to be executed.
> > 
> > Time sensitive applications such as SoftPLCs
> > (https://tum-esi.github.io/publications-list/PDF/2022-ETFA-How_Real_Time_Are_Virtual_PLCs.pdf),
> > have their response times affected by such interruptions.
> > 
> > The /proc/sys/vm/stat_refresh file was originally introduced
> > with the goal to:
> > 
> > "Provide /proc/sys/vm/stat_refresh to force an immediate update of
> >  per-cpu into global vmstats: useful to avoid a sleep(2) or whatever
> >  before checking counts when testing.  Originally added to work around a
> >  bug which left counts stranded indefinitely on a cpu going idle (an
> >  inaccuracy magnified when small below-batch numbers represent "huge"
> >  amounts of memory), but I believe that bug is now fixed: nonetheless,
> >  this is still a useful knob."
> > 
> > Other than the potential interruption to a time sensitive application,
> > if using SCHED_FIFO or SCHED_RR priority on the isolated CPU, then
> > system hangs can occur:
> 
> The same thing can happen without isolated CPUs and this patch doesn't
> help at all.
> 
> > https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=978688
> 
> And this is an example of that...
> 
> > To avoid the problems above, do not schedule the work to synchronize
> > per-CPU mm counters on isolated CPUs. Given the possibility for
> > breaking existing userspace applications, avoid returning
> > errors from access to /proc/sys/vm/stat_refresh.
> > 
> > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 
> It would be really helpful to not post new versions while discussion of
> the previous one is still not done.
> 
> Anyway
> Nacked-by: Michal Hocko <mhocko@suse.com>
> 
> This is silently changing semantic and I do not think you have actually
> shown this is a real life problem. 

https://bugzilla.redhat.com/show_bug.cgi?id=1921601

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=978688

> To me it sounds like a theoretical
> issue 

Its not (see data above).

> at most and it can be worked around by disalowing to use this
> interface from userspace. stat_refresh is mostly for debugging purposes
> and I strongly doubt it is ever used in environments you refer to in
> this series.

Based on experience, I strongly believe people will run latency
sensitive apps and end up reading/writing this file.

