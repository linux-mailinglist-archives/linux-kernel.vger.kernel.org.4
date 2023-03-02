Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A766A84A4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 15:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjCBOvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 09:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjCBOvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 09:51:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB1A58B60
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 06:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677768532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MS5VgBYAjiu1GtS1Hz9hknenkB/L3zfoqR0xXE1AVFY=;
        b=Sbc5xau8yizsgHgn68m3z979xWBAJWgPNQOR6Q0RFOHFo2GKxQvXUj/Ru8YdT7w/H2TIGm
        IAabrIXhcNwT+QEQyKsaxH543Gd7KkKpnYOSCqb9llMsh17PhjGxDlv/rci3p/bclk8lQ6
        u4GxOMPaBlEXzxdXmkJ7lBUrg0JUnyw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-199-CcJVn-9SM7eNka9q6e28rA-1; Thu, 02 Mar 2023 09:48:48 -0500
X-MC-Unique: CcJVn-9SM7eNka9q6e28rA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6A43F2800490;
        Thu,  2 Mar 2023 14:48:47 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E2931121315;
        Thu,  2 Mar 2023 14:48:47 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 6C139400E71AF; Thu,  2 Mar 2023 10:55:09 -0300 (-03)
Date:   Thu, 2 Mar 2023 10:55:09 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 09/11] mm/vmstat: use cmpxchg loop in cpu_vm_stats_fold
Message-ID: <ZACqvbnYAKumb+8O@tpad>
References: <20230209150150.380060673@redhat.com>
 <20230209153204.873999366@redhat.com>
 <Y//YREMSErJjiSzh@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y//YREMSErJjiSzh@x1n>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 05:57:08PM -0500, Peter Xu wrote:
> On Thu, Feb 09, 2023 at 12:01:59PM -0300, Marcelo Tosatti wrote:
> >  /*
> > - * Fold the data for an offline cpu into the global array.
> > + * Fold the data for a cpu into the global array.
> >   * There cannot be any access by the offline cpu and therefore
> >   * synchronization is simplified.
> >   */
> > @@ -906,8 +906,9 @@ void cpu_vm_stats_fold(int cpu)
> >  			if (pzstats->vm_stat_diff[i]) {
> >  				int v;
> >  
> > -				v = pzstats->vm_stat_diff[i];
> > -				pzstats->vm_stat_diff[i] = 0;
> > +				do {
> > +					v = pzstats->vm_stat_diff[i];
> > +				} while (!try_cmpxchg(&pzstats->vm_stat_diff[i], &v, 0));
> 
> IIUC try_cmpxchg will update "v" already, so I'd assume this'll work the
> same:
> 
>         while (!try_cmpxchg(&pzstats->vm_stat_diff[i], &v, 0));
> 
> Then I figured, maybe it's easier to use xchg()?

Yes, fixed.

> I've no knowledge at all on cpu offline code, so sorry if this will be a
> naive question.  But from what I understand this should not be touched by
> anyone else.  Reasons:
> 
>   (1) cpu_vm_stats_fold() is only called in page_alloc_cpu_dead(), and the
>       comment says:
>   
> 	/*
> 	 * Zero the differential counters of the dead processor
> 	 * so that the vm statistics are consistent.
> 	 *
> 	 * This is only okay since the processor is dead and cannot
> 	 * race with what we are doing.
> 	 */
> 	cpu_vm_stats_fold(cpu);
> 
>       so.. I think that's what it says..

This refers to the use of this_cpu operations being performed by the
counter updates.

If both the updater and reader use atomic accesses (which is the case after patch 8:
"mm/vmstat: switch counter modification to cmpxchg"), and
CONFIG_HAVE_CMPXCHG_LOCAL is set, then the comment is stale.

Removed it.

>   (2) If someone can modify the dead cpu's vm_stat_diff,

The only context that can modify the cpu's vm_stat_diff are:

1) The CPU itself (increases the counter).
2) cpu_vm_stats_fold (from vmstat_shepherd kernel thread), from 
x -> 0 only.

So you should not be able to increase the counter after this point. 
I suppose this is what this comment refers to.

>       what guarantees it
>       won't be e.g. boosted again right after try_cmpxchg() / xchg()
>       returns?  What to do with the left-overs?

If any code runs on the CPU that is being hotunplugged,
after cpu_vm_stats_fold (from page_alloc_cpu_dead), then there will 
be left-overs. But such bugs would exist today as well.

Or, if that bug exists, you could replace "for_each_online_cpu" to 
"for_each_cpu" here:

static void vmstat_shepherd(struct work_struct *w)
{
        int cpu;

        cpus_read_lock();
        /* Check processors whose vmstat worker threads have been disabled */
        for_each_online_cpu(cpu) {

