Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551926A896A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 20:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjCBTTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 14:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCBTTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 14:19:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A8E126F7
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 11:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677784703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NE0DZXa/zvRZJ6eaL4Afj3nXFIuAOckIe9J5zIxESJk=;
        b=DEXBpX32/biE5g+dT54evxBlN6mOfIEIojEkKvN3JXygdFbU7JOPYChtuX8+6B4aMcauG8
        j9qCUORq5g9KDJ5C0qQGeTzSo2HtnpQxfC0aAr14wPhq21lit0NR+EluvM8VHxHceBHRzb
        0d9zU1D6SRW5Wjd820OGNGcWqBKkDoo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-_vBAMve-Phi6lQUXRGFG-A-1; Thu, 02 Mar 2023 14:18:19 -0500
X-MC-Unique: _vBAMve-Phi6lQUXRGFG-A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 39D93811E9C;
        Thu,  2 Mar 2023 19:18:19 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E7FF9440D8;
        Thu,  2 Mar 2023 19:18:18 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id B93BA403F7F24; Thu,  2 Mar 2023 16:11:32 -0300 (-03)
Date:   Thu, 2 Mar 2023 16:11:32 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 08/11] mm/vmstat: switch counter modification to
 cmpxchg
Message-ID: <ZAD05KayfUwZQ4Vh@tpad>
References: <20230209150150.380060673@redhat.com>
 <20230209153204.846239718@redhat.com>
 <3331790c-95a1-6ab9-2667-86aae3d28d7d@redhat.com>
 <ZAC3BxPIxAplvTzT@tpad>
 <ZADM4U49g+g4S5Xf@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZADM4U49g+g4S5Xf@x1n>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 11:20:49AM -0500, Peter Xu wrote:
> On Thu, Mar 02, 2023 at 11:47:35AM -0300, Marcelo Tosatti wrote:
> > So it will be:
> > 
> > #ifdef CONFIG_HAVE_CMPXCHG_LOCAL
> > mod_zone_page_state
> > inc_zone_page_state
> > dec_zone_page_state
> > mod_node_page_state
> > inc_node_page_state
> > dec_node_page_state
> > __mod_zone_page_state (new function, calls mod_zone_page_state).
> > __mod_node_page_state (new function, calls mod_node_page_state).
> > __inc_zone_page_state
> > __inc_node_page_state
> > __dec_zone_page_state
> > __dec_node_page_state
> > #else
> > __mod_zone_page_state (old, shared function for both CONFIG_HAVE_CMPXCHG_LOCAL and not)
> > __mod_node_page_state
> > __inc_zone_page_state
> > __inc_node_page_state
> > __dec_zone_page_state
> > __dec_node_page_state
> > mod_zone_page_state
> > inc_zone_page_state
> > dec_zone_page_state
> > mod_node_page_state
> > inc_node_page_state
> > dec_node_page_state
> > #endif
> > 
> > Any suggestion on how to split this into multiple patchsets for easier
> > reviewing? (can't think of anything obvious).
> 
> I figured this out before saw this, but it did take me some time to read
> carefully into the code base..  maybe it'll be a good idea to mention
> something like above in the commit message to ease future reviewers (and
> more likelyhood to attract the experts to start chim in)?
> 
> One fundamental (but maybe another naive.. :) question on this code piece
> (so not directly related to the changeset but maybe it is still..):
> 
> AFAICT CONFIG_HAVE_CMPXCHG_LOCAL only means we can do cmpxchg() without
> locking memory bus, 

CONFIG_HAVE_CMPXCHG_LOCAL means cmpxchg_local is implemented (that is
cmpxchg which is atomic with respect to local CPU).

LOCK cmpxchg is necessary for cmpxchg to be atomic on SMP.

> however when !CONFIG_HAVE_CMPXCHG_LOCAL here we're not
> using non-local version but using preempt_disable_nested() to make sure the
> read is atomic.  Does it really worth it?  What happens if we use cmpxchg()
> unconditionally, but just use local (e.g. no "LOCK" prefix) version when
> CONFIG_HAVE_CMPXCHG_LOCAL?

Can't use local version of cmpxchg because the vmstat counters are supposed
to be accessed from different CPUs simultaneously (this is the objective
of the patchset):

CPU-0					CPU-1

vmstat_shepherd				mod_zone_page_state
xchg location				LOCK cmpxchg location

xchg locks memory bus implicitly.

Is this what you are thinking about or did i misunderstood what you
mean?

