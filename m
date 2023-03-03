Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C576A9BE3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 17:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjCCQkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 11:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjCCQkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 11:40:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49042222D5
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 08:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677861588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uNLJgT9zFMcxnSv0JH7AOr2H78zkUJl6YhKMbytbkDk=;
        b=Cvlw8rgxGfZG2mb2BUsauPWRojeAyWwGJlg469IR0Lb2KYSqFDpKgFTjRXgAnXikRW4oWe
        8stFtAe8C/PsY9HDjI+GQquik0QClRDqFEb9gJIsLc7BpLH1uFIumB5jFvEHbOhjyc0DcX
        /URsJwtsCZdQAJJ96r1FYxmxXfaMNZU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-28-6pV58CicMEa2r-BADiOSDQ-1; Fri, 03 Mar 2023 11:39:45 -0500
X-MC-Unique: 6pV58CicMEa2r-BADiOSDQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D2E50101A521;
        Fri,  3 Mar 2023 16:39:44 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A5D64024B7C;
        Fri,  3 Mar 2023 16:39:44 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id E98A8403E3A21; Fri,  3 Mar 2023 12:17:12 -0300 (-03)
Date:   Fri, 3 Mar 2023 12:17:12 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 09/11] mm/vmstat: use cmpxchg loop in cpu_vm_stats_fold
Message-ID: <ZAIPeDL9FjjD7ngw@tpad>
References: <20230209150150.380060673@redhat.com>
 <20230209153204.873999366@redhat.com>
 <Y//YREMSErJjiSzh@x1n>
 <ZACqvbnYAKumb+8O@tpad>
 <ZAES9hPHJGGgCBfc@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAES9hPHJGGgCBfc@x1n>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,TRACKER_ID autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 04:19:50PM -0500, Peter Xu wrote:
> On Thu, Mar 02, 2023 at 10:55:09AM -0300, Marcelo Tosatti wrote:
> > >   (2) If someone can modify the dead cpu's vm_stat_diff,
> > 
> > The only context that can modify the cpu's vm_stat_diff are:
> > 
> > 1) The CPU itself (increases the counter).
> > 2) cpu_vm_stats_fold (from vmstat_shepherd kernel thread), from 
> > x -> 0 only.
> 
> I think I didn't continue reading so I didn't see cpu_vm_stats_fold() will
> be reused when commenting, sorry.
> 
> Now with a reworked (and SMP-safe) cpu_vm_stats_fold() and vmstats, I'm
> wondering the possibility of merging it with refresh_cpu_vm_stats() since
> they really look similar.

Seems like a possibility. However that might require replacing

v = this_cpu_xchg(pzstats->vm_stat_diff[i], 0);

with

pzstats = per_cpu_ptr(zone->per_cpu_zonestats, cpu);

Which would drop the this_cpu optimization described at 

7340a0b15280c9d902c7dd0608b8e751b5a7c403

Also you would not want the unified function to sync NUMA events 
(as it would be called from NOHZ entry and exit).

See f19298b9516c1a031b34b4147773457e3efe743b

> IIUC the new refresh_cpu_vm_stats() logically doesn't need the small
> preempt disabled sections, not anymore, 

What preempt disabled sections you refer to?

> if with a cpu_id passed over to
> cpu_vm_stats_fold(), which seems to be even a good side effect. But not
> sure I missed something.
> 
> -- 
> Peter Xu
> 
> 

