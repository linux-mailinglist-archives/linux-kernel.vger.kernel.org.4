Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF7861ECD0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 09:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbiKGIYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 03:24:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiKGIYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 03:24:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C44910CD
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 00:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667809426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4NlaTcXgAoZxfJFwezekk0EZPDhmSaS61HBI7QDfTXU=;
        b=NzZQk7hhwYl4Iq0F3fB/7fYul6ZurE5AEq21l3sp8MUSvkxk1WHV9cfPM/+N8VHVJm+1j3
        MQ5RfwkbsQ7wSqy54jTb/num9bpiwlKezI/4RI5S/IPUZb2Gp9JE508ktd8noZTl5pZVw7
        dL3fudaZHUdcojjxQWBmzN5Kf8aGZ1k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-1Nt4XhUGOTaLNHEo_-iX9A-1; Mon, 07 Nov 2022 03:23:43 -0500
X-MC-Unique: 1Nt4XhUGOTaLNHEo_-iX9A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C343C86F130;
        Mon,  7 Nov 2022 08:23:42 +0000 (UTC)
Received: from localhost (ovpn-13-134.pek2.redhat.com [10.72.13.134])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 770B940C6FA1;
        Mon,  7 Nov 2022 08:23:41 +0000 (UTC)
Date:   Mon, 7 Nov 2022 16:23:37 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: Re: [PATCH 8/8] mm/slub, percpu: correct the calculation of early
 percpu allocation size
Message-ID: <Y2jAiWmVAgrzWyPh@MiWiFi-R3L-srv>
References: <20221024081435.204970-1-bhe@redhat.com>
 <20221024081435.204970-9-bhe@redhat.com>
 <b3776af5-65c7-62b4-7624-184420d0da63@suse.cz>
 <Y2iLLIL/jBL4dftJ@MiWiFi-R3L-srv>
 <Y2ixuDbcQgtqE1Ox@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2ixuDbcQgtqE1Ox@fedora>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/22 at 11:20pm, Dennis Zhou wrote:
> Hi Baoquan,
> 
> On Mon, Nov 07, 2022 at 12:35:56PM +0800, Baoquan He wrote:
> > On 11/06/22 at 09:56pm, Vlastimil Babka wrote:
> > > On 10/24/22 10:14, Baoquan He wrote:
> > > > SLUB allocator relies on percpu allocator to initialize its ->cpu_slab
> > > > during early boot. For that, the dynamic chunk of percpu which serves
> > > > the early allocation need be large enough to satisfy the kmalloc
> > > > creation.
> > > > 
> > > > However, the current BUILD_BUG_ON() in alloc_kmem_cache_cpus() doesn't
> > > > consider the kmalloc array with NR_KMALLOC_TYPES length. Fix that
> > > > with correct calculation.
> > > > 
> > > > Signed-off-by: Baoquan He <bhe@redhat.com>
> > > > Cc: Christoph Lameter <cl@linux.com>
> > > > Cc: Pekka Enberg <penberg@kernel.org>
> > > > Cc: David Rientjes <rientjes@google.com>
> > > > Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > Cc: Vlastimil Babka <vbabka@suse.cz>
> > > > Cc: Roman Gushchin <roman.gushchin@linux.dev>
> > > > Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > > > ---
> > > >  mm/slub.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > As only slub is touched and there's no prerequsities in the previous
> > > patches, I took this to the slab tree, branch
> > > slab/for-6.2/cleanups
> > 
> > Yes, it only changes slub code. Thanks for taking it.
> > 
> > I will resend v2 with the left 7 percpu only patches with update.
> > 
> > 
> 
> Don't worry about resending them, I'll pick them up tomorrow morning.

That's great. Thanks a lot, Dennis.

