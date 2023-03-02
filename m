Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26C26A84AD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 15:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjCBOyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 09:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjCBOyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 09:54:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E784FAAC
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 06:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677768720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2ocr1MRMgM37lnhAgthxsVmxMsm7Y/8cuudEiaAKuwM=;
        b=e/St95EVTko1D0TfZ+QoTTx9poCD+nk0XzFg7fX5LI4drgli4ZCyluDVoNs3YB3yzlRirz
        3cRHg3Eb1wWqDyvmTrqY4q4X8fS7JsZdYVS54LW3/EzSrSdM8Hl29mxRVGWRIFbQn0CILa
        mlrhigAGwEkD8GJhls0Yfabpy9kT3eI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-519-TZV8PsbCMI23Sb8WOOhCgQ-1; Thu, 02 Mar 2023 09:48:48 -0500
X-MC-Unique: TZV8PsbCMI23Sb8WOOhCgQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 64D9338173C8;
        Thu,  2 Mar 2023 14:48:47 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B05E492C18;
        Thu,  2 Mar 2023 14:48:47 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 516A3403CFADF; Thu,  2 Mar 2023 11:47:35 -0300 (-03)
Date:   Thu, 2 Mar 2023 11:47:35 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 08/11] mm/vmstat: switch counter modification to
 cmpxchg
Message-ID: <ZAC3BxPIxAplvTzT@tpad>
References: <20230209150150.380060673@redhat.com>
 <20230209153204.846239718@redhat.com>
 <3331790c-95a1-6ab9-2667-86aae3d28d7d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3331790c-95a1-6ab9-2667-86aae3d28d7d@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 11:47:35AM +0100, David Hildenbrand wrote:
> On 09.02.23 16:01, Marcelo Tosatti wrote:
> > In preparation to switch vmstat shepherd to flush
> > per-CPU counters remotely, switch all functions that
> > modify the counters to use cmpxchg.
> > 
> > To test the performance difference, a page allocator microbenchmark:
> > https://github.com/netoptimizer/prototype-kernel/blob/master/kernel/mm/bench/page_bench01.c
> > with loops=1000000 was used, on Intel Core i7-11850H @ 2.50GHz.
> > 
> > For the single_page_alloc_free test, which does
> > 
> >          /** Loop to measure **/
> >          for (i = 0; i < rec->loops; i++) {
> >                  my_page = alloc_page(gfp_mask);
> >                  if (unlikely(my_page == NULL))
> >                          return 0;
> >                  __free_page(my_page);
> >          }
> > 
> > Unit is cycles.
> > 
> > Vanilla			Patched		Diff
> > 159			165		3.7%
> > 
> > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> > 
> > Index: linux-vmstat-remote/mm/vmstat.c
> > ===================================================================
> > --- linux-vmstat-remote.orig/mm/vmstat.c
> > +++ linux-vmstat-remote/mm/vmstat.c
> > @@ -334,6 +334,188 @@ void set_pgdat_percpu_threshold(pg_data_
> >   	}
> >   }
> 
> I wonder why we get a diff that is rather hard to review because it removes
> all existing codes and replaces it by almost-identical code. Are you maybe
> moving a bunch of code while modifying some tiny bits at the same time?

Current code has functions defined like so:

__mod_zone_page_state
__mod_node_page_state
__inc_zone_page_state
__inc_node_page_state
__dec_zone_page_state
__dec_node_page_state
#ifdef CONFIG_HAVE_CMPXCHG_LOCAL
mod_zone_page_state
inc_zone_page_state
dec_zone_page_state
mod_node_page_state
inc_node_page_state
dec_node_page_state
#else
mod_zone_page_state
inc_zone_page_state
dec_zone_page_state
mod_node_page_state
inc_node_page_state
dec_node_page_state
#endif

What this patch is doing is to define the __ versions for the
CONFIG_HAVE_CMPXCHG_LOCAL case to be their non-"__" counterparts.

So it will be:

#ifdef CONFIG_HAVE_CMPXCHG_LOCAL
mod_zone_page_state
inc_zone_page_state
dec_zone_page_state
mod_node_page_state
inc_node_page_state
dec_node_page_state
__mod_zone_page_state (new function, calls mod_zone_page_state).
__mod_node_page_state (new function, calls mod_node_page_state).
__inc_zone_page_state
__inc_node_page_state
__dec_zone_page_state
__dec_node_page_state
#else
__mod_zone_page_state (old, shared function for both CONFIG_HAVE_CMPXCHG_LOCAL and not)
__mod_node_page_state
__inc_zone_page_state
__inc_node_page_state
__dec_zone_page_state
__dec_node_page_state
mod_zone_page_state
inc_zone_page_state
dec_zone_page_state
mod_node_page_state
inc_node_page_state
dec_node_page_state
#endif

Any suggestion on how to split this into multiple patchsets for easier
reviewing? (can't think of anything obvious).

