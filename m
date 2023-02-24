Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946ED6A1878
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 10:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjBXJFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 04:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjBXJFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 04:05:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F74C14EAA
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 01:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677229495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6+0eD77pSON4ctupQ+Q2sz1nh9boGw6I9xn8BCA/uFs=;
        b=Iwkxb2SLlsUYLC3kWF0OuJO0nBL5DriUsV/SvfeCCKKrc3M+sAqn2XCQ/JLy/p/hxZLoIB
        f3Tdh8iwUrQeV5f07z8eUU8cij+QPdBJBQMb+ejCDy23y29c3S7Q7rLvHOpipQAbaLvoPn
        c/lyL1wAho0wreI7+T/ncWkVQUx3LdQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-244-GcPkmjlFMVeXtquMioak-g-1; Fri, 24 Feb 2023 04:04:51 -0500
X-MC-Unique: GcPkmjlFMVeXtquMioak-g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3637E38012E8;
        Fri, 24 Feb 2023 09:04:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 43BF4C15BA0;
        Fri, 24 Feb 2023 09:04:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=whAAOVBrzwb2uMjCmdRrtudGesYj0tuqdUgi8X_gbw1jw@mail.gmail.com>
References: <CAHk-=whAAOVBrzwb2uMjCmdRrtudGesYj0tuqdUgi8X_gbw1jw@mail.gmail.com> <20230220135225.91b0f28344c01d5306c31230@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vishal Moola <vishal.moola@gmail.com>,
        Steve French <stfrench@microsoft.com>
Cc:     dhowells@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Paulo Alcantara <pc@cjr.nz>,
        Matthew Wilcox <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Xin Hao <xhao@linux.alibaba.com>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] MM updates for 6.3-rc1
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2009824.1677229488.1@warthog.procyon.org.uk>
Date:   Fri, 24 Feb 2023 09:04:48 +0000
Message-ID: <2009825.1677229488@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

>    Yes, I saw David Howells resolution suggestion. I think that one
> was buggy. It would wait for a page under writeback, and then go on to
> the *next* one without writing it back. I don't thin kthat was right.

You're right.  Vishal's patch introduced it into afs and I copied it across
and didn't notice it either then or on review of Vishal's patch.  He inserted
the extra for-loop as he's now extracting a batch, but kept the continue that
used to repeat the extraction - except now it continues the wrong loop.

So afs will need fixing too.  The simplest ways I think are to just decrement
the loop counter before continuing or to stick a goto in back to the beginning
of the loop (which is what you did in cifs).  But I'm not sure that's the
correct thing to do.  The previous code dropped the found folio and then
repeated the search in case the folio got truncated, migrated or punched.  I
suspect that's probably what we should do.


Also, thinking about it again, I'm not sure whether fetching a batch with
filemap_get_folios_tag() like this in {afs,cifs}_writepages_region() is
necessarily the right thing to do.  There are three cases I'm thinking of:

 (1) A single folio is returned.  This is trivial.

 (2) A run of contiguous folios are returned - {afs,cifs}_extend_writeback()
     is likely to write them back, in which case the batch is probably not
     useful.  Note that *_extend_writeback() walks the xarray directly itself
     as it wants contiguous folios and doesn't want to extract any folio it's
     not going to use.

 (3) A list of scattered folios is returned.  Granted this is more efficient
     if nothing else interferes - but there could be other writes in the gaps
     that we then skip over, other flushes that render some of our list clean
     or page invalidations.  This is a change in behaviour, but I'm not sure
     that matters too much since a flush/sync can only be expected to write
     back what's modified at the time it is initiated.

     Further, processing each entry in the list is potentially very slow
     because we're doing a write across the network for each one (cifs might
     bump this into the background, but it might also have to (re)open a file
     handle on the server and wait for credits first to even begin the
     transaction).

     Which means all of the folios in the batch may then get pinned for a long
     period of time - up to 14x for the last folio in the batch - which could
     prevent things like page migration.

Further, we might not get to write out all the folios in the batch as
*_extend_writeback() might hit the wbc limit first.

>    That said, I'm not at all convinced my version is right either. I
> can't test it, and that means I probably messed up. It looked sane to
> me when I did it, and it builds cleanly, but I honestly doubt myself.

It doesn't seem to work.  A write seems to end in lots of:

	CIFS: VFS: No writable handle in writepages rc=-9

being emitted.  I'll poke further into it - there's always the possibility
that some other patch is interfering.

David

