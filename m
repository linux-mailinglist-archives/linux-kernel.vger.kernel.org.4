Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59112722BD1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235055AbjFEPrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235020AbjFEPrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:47:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAEB10F0
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 08:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685979938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fz6CKIUO/zInL0kXiLp1OqxboZ4F1Hx1Dqes19h0t8M=;
        b=dmUQdWnPnstxl5trZ5sR06K82v2cDHRadXCt2r8v090jjmJ+TpsG9uwJj+C6bcQ2aaNkOm
        T6iu9q87gHVQR4DCaPWqvmg2uMw/Mn2xTPYgSpmeRT+KRk6Dd9Do2vDYkb6PkoY3mWqYMI
        LjjY+AE2j29Cps7sh04T8nhwdNiYBkg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-297-Exj74wdqPj6lwC7-q16Ohg-1; Mon, 05 Jun 2023 11:45:35 -0400
X-MC-Unique: Exj74wdqPj6lwC7-q16Ohg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 64A0E101A53B;
        Mon,  5 Jun 2023 15:45:34 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B27AC154D1;
        Mon,  5 Jun 2023 15:45:34 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 884C140178ACF; Mon,  5 Jun 2023 12:43:24 -0300 (-03)
Date:   Mon, 5 Jun 2023 12:43:24 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 3/3] mm/vmstat: do not refresh stats for nohz_full CPUs
Message-ID: <ZH4CnJlpBMxEEwPW@tpad>
References: <20230602185757.110910188@redhat.com>
 <20230602190115.545766386@redhat.com>
 <ZH2V/QxDrq7aq5fY@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH2V/QxDrq7aq5fY@dhcp22.suse.cz>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 09:59:57AM +0200, Michal Hocko wrote:
> On Fri 02-06-23 15:58:00, Marcelo Tosatti wrote:
> > The interruption caused by queueing work on nohz_full CPUs 
> > is undesirable for certain aplications.
> 
> This is not a proper changelog. I am not going to write a changelog for
> you this time. Please explain why this is really needed and why this
> approach is desired. 
> E.g. why don't you prevent userspace from
> refreshing stats if interference is not desirable.

Michal,

Can you please check if the following looks better, as
a changelog? thanks

---

schedule_work_on API uses the workqueue mechanism to
queue a work item on a queue. A kernel thread, which
runs on the target CPU, executes those work items.

Therefore, when using the schedule_work_on API,
it is necessary for the kworker kernel thread to
be scheduled in, for the work function to be executed.

Time sensitive applications such as SoftPLCs
(https://tum-esi.github.io/publications-list/PDF/2022-ETFA-How_Real_Time_Are_Virtual_PLCs.pdf),
have their response times affected by such interruptions.

The /proc/sys/vm/stat_refresh file was originally introduced by

commit 52b6f46bc163eef17ecba4cd552beeafe2b24453
Author: Hugh Dickins <hughd@google.com>
Date:   Thu May 19 17:12:50 2016 -0700

    mm: /proc/sys/vm/stat_refresh to force vmstat update

    Provide /proc/sys/vm/stat_refresh to force an immediate update of
    per-cpu into global vmstats: useful to avoid a sleep(2) or whatever
    before checking counts when testing.  Originally added to work around a
    bug which left counts stranded indefinitely on a cpu going idle (an
    inaccuracy magnified when small below-batch numbers represent "huge"
    amounts of memory), but I believe that bug is now fixed: nonetheless,
    this is still a useful knob.

Other than the potential interruption to a time sensitive application,
if using SCHED_FIFO or SCHED_RR priority on the isolated CPU, then
system hangs can occur:

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=978688

To avoid the problems above, do not schedule the work to synchronize
per-CPU mm counters on isolated CPUs. Given the possibility for
breaking existing userspace applications, avoid changing
behaviour of access to /proc/sys/vm/stat_refresh, such as
returning errors to userspace.

---

> Also would it make some sense to reduce flushing to cpumask 
> of the calling process? (certainly a daring thought but have
> you even considered it?)

Fail to see the point here ?


