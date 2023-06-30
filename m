Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7643A74401F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 18:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbjF3Qvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 12:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbjF3Qvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 12:51:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94E91BD0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688143850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jXsxRCKTcFnH6tZm3WnmJviu/bPYYkz5AVx2X61PXao=;
        b=i3OeKzvp7TfUW8rp41UdzsDysEZMaSqxWeJO4f/Nb82MM05hYRxn8/eC2ugHBNTwA27JG2
        +zABnHYmpzgDaTfyoXCOKCKjTZGtUI/KMSPU4B7RGSxOrAB3azDoREhgpUwWmCV0ezLMH0
        CjG/Qj4wr9djYQaUEkXroyy5IXdHJaI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-163-8Km4rewcPI-qX0YsQuwZ8Q-1; Fri, 30 Jun 2023 12:50:45 -0400
X-MC-Unique: 8Km4rewcPI-qX0YsQuwZ8Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4594E3813F2A;
        Fri, 30 Jun 2023 16:50:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2ED3D4CD0C2;
        Fri, 30 Jun 2023 16:50:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wjixHw6n_R5TQWW1r0a+GgFAPGw21KMj6obkzr3qXXbYA@mail.gmail.com>
References: <CAHk-=wjixHw6n_R5TQWW1r0a+GgFAPGw21KMj6obkzr3qXXbYA@mail.gmail.com> <20230629155433.4170837-1-dhowells@redhat.com> <CAHk-=wiDwfyj0CCupT-oEToqsNLcbsTQdcgDupF=ZETUjJQJtQ@mail.gmail.com> <4bd92932-c9d2-4cc8-b730-24c749087e39@mattwhitlock.name> <CAHk-=whYWEUU69nY6k4j1_EQnQDNPy4TqAMvpf1UA111UDdmYg@mail.gmail.com> <ZJ3OoCcSxZzzgUur@casper.infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Matt Whitlock <kernel@mattwhitlock.name>,
        netdev@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@kvack.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] splice: Fix corruption in data spliced to pipe
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <663488.1688143843.1@warthog.procyon.org.uk>
Date:   Fri, 30 Jun 2023 17:50:43 +0100
Message-ID: <663489.1688143843@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> 
> Quite the reverse. I'd be willing to *simplify* splice() by just
> saying "it was all a mistake", and just turning it into wrappers
> around read/write. But those patches would have to be radical
> simplifications, not adding yet more crud on top of the pain that is
> splice().
> 
> Because it will hurt performance. And I'm ok with that as long as it
> comes with huge simplifications. What I'm *not* ok with is "I mis-used
> splice, now I want splice to act differently, so let's make it even
> more complicated".

If we want to go down the simplification route, then the patches I posted
might be a good start.

The idea I tried to work towards is that the pipe only ever contains private
pages in it that only the pipe has a ref on and that no one else can access
until they come out the other end again.  I got rid of the ->confirm() pipe
buf op and would like to kill off all of the others too.

I simplified splice() by:

 - Making sure any candidate pages are uptodate right up front.

 - Allowing automatic stealing of pages from the pagecache if no one else is
   using them.  This should avoid losing a chunk of the performance that
   splice is supposed to gain - but if you're serving pages repeatedly in a
   webserver with this, it's going to be a problem.

   Possibly this should be contingent on SPLICE_F_MOVE - though the manpage
   says "*from* the pipe" implying it's only usable on the output side.

 - Copying in every other circumstance.

I simplified vmsplice() by:

 - If SPLICE_F_GIFT is set, attempting to steal whole pages in the buffer up
   front if not in use by anyone else.

 - Copying in every other circumstance.

That said, there are still sources that I didn't touch yet that attempt to
insert pages into a pipe: relayfs (which does some accounting stuff based on
the final consumption of the pages it inserted), sockets (which don't allow
inserted pages to be stolen) and notifications (which don't want to allocate
at notification time - but I can deal with that).  And there's tee() (which
would need to copy the data).  And pipe-to-pipe splice (which could steal
whole pages, but would otherwise have to copy).


If you would prefer to go for utter simplification, we could make sendfile()
from a buffered file just call sendmsg() directly with MSG_SPLICE_PAGES set
and ignore the pipe entirely (I'm tempted to do this anyway) and then make
splice() to a pipe just do copy_splice_read() and vmsplice() to a pipe do
writev().

I wonder how much splice() is used compared to sendfile().


I would prefer to leave splice() and vmsplice() as they are now and adjust the
documentation.  As you say, they can be considered a type of zerocopy.

David

