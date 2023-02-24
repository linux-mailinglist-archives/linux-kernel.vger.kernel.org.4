Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9382B6A205C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 18:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjBXRQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 12:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjBXRQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 12:16:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B764F1630B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 09:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677258953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WPkHpOzfb+zV5/yZOjrh62ZdI6JAwYRbAGW5gOkT0xI=;
        b=ZDgFQwp91StHEsTdglWbeb5w8BbXiH2FUOlnQF12p0iotIdblBl4pUao+XWHZzHItCYzlv
        AUgVKDsC5RrLmPwUTlZ7SwQIWLNNIsf/gRsJbWn2jh1fov0ljd7BzGFxe8CVtuJVX7c7pn
        s5mwIYjxXtmPZHPOE4ipRLQgRGepK70=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-34zRzHVjP5yrZiL2i7p_yA-1; Fri, 24 Feb 2023 12:15:45 -0500
X-MC-Unique: 34zRzHVjP5yrZiL2i7p_yA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 66CA18432D0;
        Fri, 24 Feb 2023 17:15:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7DCEC492B07;
        Fri, 24 Feb 2023 17:15:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y/jhwuTCaOgOTLp2@casper.infradead.org>
References: <Y/jhwuTCaOgOTLp2@casper.infradead.org> <2134430.1677240738@warthog.procyon.org.uk> <2009825.1677229488@warthog.procyon.org.uk> <CAHk-=whAAOVBrzwb2uMjCmdRrtudGesYj0tuqdUgi8X_gbw1jw@mail.gmail.com> <20230220135225.91b0f28344c01d5306c31230@linux-foundation.org> <2213409.1677249075@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steve French <stfrench@microsoft.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Paulo Alcantara <pc@cjr.nz>,
        Huang Ying <ying.huang@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Xin Hao <xhao@linux.alibaba.com>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] cifs: Fix cifs_writepages_region()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2385088.1677258941.1@warthog.procyon.org.uk>
Date:   Fri, 24 Feb 2023 17:15:41 +0000
Message-ID: <2385089.1677258941@warthog.procyon.org.uk>
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

Matthew Wilcox <willy@infradead.org> wrote:

> Why are you doing it this way?  What's wrong with using
> write_cache_pages() to push all the contiguous dirty folios into a single
> I/O object, submitting it when the folios turn out not to be contiguous,
> or when we run out of a batch?
> 
> You've written an awful lot of code here and it's a different model from
> every other filesystem.  Why is it better?

Because write_cache_pages():

 (1) Takes no account of fscache.  I can't just build knowledge of PG_fscache
     into it because PG_private_2 may be used differently by other filesystems
     (btrfs, for example).  (I'm also trying to phase out the use of
     PG_private_2 and instead uses PG_writeback to cover both and the
     difference will be recorded elsewhere - but that's not there yet).

 (2) Calls ->writepage() individually for each folio - which is excessive.  In
     AFS's implementation, we locate the first folio, then race through the
     following folios without ever waiting until we hit something that's
     locked or a gap and then stop and submit.

     write_cache_pages(), otoh, calls us with the next folio already undirtied
     and set for writeback when we find out that we don't want it yet.

 (3) Skips over holes, but at some point in the future we're going to need to
     schedule adjacent clean pages (before and after) for writeback too to
     handle transport compression and fscache updates if the granule size for
     either is larger than the folio size.

It might be better to take what's in cifs, generalise it and replace
write_cache_pages() with it, then have a "->submit_write()" aop that takes an
ITER_XARRAY iterator to write from.

David

