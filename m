Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF5272312C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 22:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbjFEUWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 16:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjFEUWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 16:22:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048C0F3
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 13:22:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4DAB221B04;
        Mon,  5 Jun 2023 20:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685996534; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rKl9iLYldfYK1lxFgzZKWf0MT5fL7rmsmdcIHLkI1gs=;
        b=nhmZMRH0gfY8FI9kY/E4iziTF9+J3GxmAEnp4+nY86+jda1mhlIl76QbLzXa+8RBCc6Kko
        F65k3YD4u+iXQb9POzvt3zGns704005cK73/g2/TUaNApFY7XCkHzTyhlhSZWPvql5nyaz
        wQ4htr3fH/riIEdbqgXBjJI2zuUT8PQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 28551139C7;
        Mon,  5 Jun 2023 20:22:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VHtMBvZDfmRQAgAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 05 Jun 2023 20:22:14 +0000
Date:   Mon, 5 Jun 2023 22:22:13 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v3 3/3] mm/vmstat: do not refresh stats for isolated CPUs
Message-ID: <ZH5D9cqJnPJ27OY8@dhcp22.suse.cz>
References: <20230605185627.923698377@redhat.com>
 <20230605190132.087124739@redhat.com>
 <ZH41bFWrc0LWae/U@dhcp22.suse.cz>
 <ZH49Tx4kbOG1zESS@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH49Tx4kbOG1zESS@tpad>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 05-06-23 16:53:51, Marcelo Tosatti wrote:
> On Mon, Jun 05, 2023 at 09:20:12PM +0200, Michal Hocko wrote:
> > On Mon 05-06-23 15:56:30, Marcelo Tosatti wrote:
> > > schedule_work_on API uses the workqueue mechanism to
> > > queue a work item on a queue. A kernel thread, which
> > > runs on the target CPU, executes those work items.
> > > 
> > > Therefore, when using the schedule_work_on API,
> > > it is necessary for the kworker kernel thread to
> > > be scheduled in, for the work function to be executed.
> > > 
> > > Time sensitive applications such as SoftPLCs
> > > (https://tum-esi.github.io/publications-list/PDF/2022-ETFA-How_Real_Time_Are_Virtual_PLCs.pdf),
> > > have their response times affected by such interruptions.
> > > 
> > > The /proc/sys/vm/stat_refresh file was originally introduced
> > > with the goal to:
> > > 
> > > "Provide /proc/sys/vm/stat_refresh to force an immediate update of
> > >  per-cpu into global vmstats: useful to avoid a sleep(2) or whatever
> > >  before checking counts when testing.  Originally added to work around a
> > >  bug which left counts stranded indefinitely on a cpu going idle (an
> > >  inaccuracy magnified when small below-batch numbers represent "huge"
> > >  amounts of memory), but I believe that bug is now fixed: nonetheless,
> > >  this is still a useful knob."
> > > 
> > > Other than the potential interruption to a time sensitive application,
> > > if using SCHED_FIFO or SCHED_RR priority on the isolated CPU, then
> > > system hangs can occur:
> > 
> > The same thing can happen without isolated CPUs and this patch doesn't
> > help at all.
> > 
> > > https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=978688
> > 
> > And this is an example of that...
> > 
> > > To avoid the problems above, do not schedule the work to synchronize
> > > per-CPU mm counters on isolated CPUs. Given the possibility for
> > > breaking existing userspace applications, avoid returning
> > > errors from access to /proc/sys/vm/stat_refresh.
> > > 
> > > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> > 
> > It would be really helpful to not post new versions while discussion of
> > the previous one is still not done.
> > 
> > Anyway
> > Nacked-by: Michal Hocko <mhocko@suse.com>
> > 
> > This is silently changing semantic and I do not think you have actually
> > shown this is a real life problem. 
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=1921601

Yet anothe new reference. Is the story complete now?

> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=978688

Again, nothing isolcpu related. Simple RR/realtime cpu hoggers that this
patch has not way to deal with. Why do you keep referencing it?

> > To me it sounds like a theoretical
> > issue 
> 
> Its not (see data above).

No it't not. Either your sosreport need precise counters and
stat_refresh is exactly what it should be doing or it can live with
imprecision and then it should avoid it. Full stop. There is no reason
to tweak the existing semantic to half bake isolcpu case while the
fundamental problem is still there.
-- 
Michal Hocko
SUSE Labs
