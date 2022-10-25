Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698EF60C259
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 05:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiJYDsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 23:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiJYDsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 23:48:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A064D18E1F
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 20:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666669681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PYgidL+/ri8mEQCVHJ40l8Y7OFSEYg6EaOK4xr7Faag=;
        b=ZbgzqJQi2mXpWCE8BIqnFDh/TRa4J9ZBxiUeoGIz5/QIHGKwIT101mp8skgvPi6FD2yAbu
        Qw/xEg2teJcbIEqC85A1kKyhNYZ+A8vcLS0H9Bf/Wh3vMXLZxHz+vb8tMdi1+MUIgEJDoC
        KUeRyvtg9aKFc8bSjuvEKyZnj9P5JAU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-58-03pYwOQ6MRWC0gtGzitq9A-1; Mon, 24 Oct 2022 23:47:56 -0400
X-MC-Unique: 03pYwOQ6MRWC0gtGzitq9A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AFA241C05AFA;
        Tue, 25 Oct 2022 03:47:55 +0000 (UTC)
Received: from localhost (ovpn-12-35.pek2.redhat.com [10.72.12.35])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B474111F3B6;
        Tue, 25 Oct 2022 03:47:54 +0000 (UTC)
Date:   Tue, 25 Oct 2022 11:47:51 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: [PATCH 4/8] mm/percpu: add comment to state the empty populated
 pages accounting
Message-ID: <Y1dcZ2ESiv6usZFn@MiWiFi-R3L-srv>
References: <20221024081435.204970-1-bhe@redhat.com>
 <20221024081435.204970-5-bhe@redhat.com>
 <Y1bDtmfCee+V32Ml@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1bDtmfCee+V32Ml@fedora>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/22 at 09:56am, Dennis Zhou wrote:
> On Mon, Oct 24, 2022 at 04:14:31PM +0800, Baoquan He wrote:
> > When allocating an area from a chunk, pcpu_block_update_hint_alloc()
> > is called to update chunk metadata, including chunk's and global
> > nr_empty_pop_pages. However, if the allocation is not atomic, some
> > blocks may not be populated with pages yet, while we still account it
> > here. The number of pages will be subtracted with pcpu_chunk_populated()
> > when populating pages.
> > 
> > Adding code comment to make that more understandable.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  mm/percpu.c | 14 +++++++++++---
> >  1 file changed, 11 insertions(+), 3 deletions(-)
> > 
> > diff --git a/mm/percpu.c b/mm/percpu.c
> > index a8121302a79c..09e407338573 100644
> > --- a/mm/percpu.c
> > +++ b/mm/percpu.c
> > @@ -831,13 +831,15 @@ static void pcpu_block_update_hint_alloc(struct pcpu_chunk *chunk, int bit_off,
> >  
> >  	/*
> >  	 * Update s_block.
> > -	 * block->first_free must be updated if the allocation takes its place.
> > -	 * If the allocation breaks the contig_hint, a scan is required to
> > -	 * restore this hint.
> >  	 */
> >  	if (s_block->contig_hint == PCPU_BITMAP_BLOCK_BITS)
> >  		nr_empty_pages++;
> >  
> > +	/*
> > +	 * block->first_free must be updated if the allocation takes its place.
> > +	 * If the allocation breaks the contig_hint, a scan is required to
> > +	 * restore this hint.
> > +	 */
> >  	if (s_off == s_block->first_free)
> >  		s_block->first_free = find_next_zero_bit(
> >  					pcpu_index_alloc_map(chunk, s_index),
> > @@ -912,6 +914,12 @@ static void pcpu_block_update_hint_alloc(struct pcpu_chunk *chunk, int bit_off,
> >  		}
> >  	}
> >  
> > +	/*
> > +	 * If the allocation is not atomic, some blocks may not
> > +	 * be populated with pages, while we account it here.
> > +	 * The number of pages will be subtracted with
> > +	 * pcpu_chunk_populated() when populating pages.
> > +	 */
> >  	if (nr_empty_pages)
> >  		pcpu_update_empty_pages(chunk, -nr_empty_pages);
> >  
> > -- 
> > 2.34.1
> > 
> 
> Heh, that's a little more subtle than I remember it being.
> 
> Acked-by: Dennis Zhou <dennis@kernel.org>

Thanks for reviewing, Dennis.

When I rechecked the code comment, I realized I had said the opposite in
v1 about the newly added code comment. It subtracts the nr_empty_pop_pages
in pcpu_block_update_hint_alloc() whether it's atomic allocation or not.
If non atomic case, the number will be added back in pcpu_chunk_populated()
when populating pages.

I have updated and resent v2, sorry for the mistake.

Thanks
Baoquan

