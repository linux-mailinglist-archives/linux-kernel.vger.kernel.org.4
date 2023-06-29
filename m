Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2304A742A0E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 17:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbjF2P4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 11:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbjF2Pzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 11:55:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F1F3595
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 08:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688054111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PJTMFc9g/FcB+GfidiZQxCNWZ+z9h8cPcCOIg+nZLcc=;
        b=T1/irE/UYpM+wzs9/YQASeC5ffp/sRHsBmG6We7sxThTM9kTBpJ15h/rHFfFa6EFBLNZfp
        vhwlwIhmeXIuw+waaNWMtOCEzNhntQu8ha+MlSaCZ9+wxQYHWnmbJVZM+JjDy2m3cuHmdR
        hk5UT0tx1CUjprWQfBvzTQtE3VHiN0U=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-96-3nKpmEotMPGZC29BjvTnQw-1; Thu, 29 Jun 2023 11:55:06 -0400
X-MC-Unique: 3nKpmEotMPGZC29BjvTnQw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7A3F3382C991;
        Thu, 29 Jun 2023 15:54:37 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 457474CD0C3;
        Thu, 29 Jun 2023 15:54:36 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Matt Whitlock <kernel@mattwhitlock.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@kvack.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/4] splice: Fix corruption in data spliced to pipe
Date:   Thu, 29 Jun 2023 16:54:29 +0100
Message-ID: <20230629155433.4170837-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the way splice() and vmsplice() currently splice active pages from
the pagecache or process VM into the intermediary pipe, changes to the data
in those pages can occur whilst they're held in the pipe by such as
write(), writing through a shared-writable mmap or using fallocate() to
mangle the file[1] change the data.

Matt Whitlock, Matthew Wilcox and Dave Chinner are of the opinion that data
in the pipe must not be seen to change and that if it does, this is a bug.
Apart from in one specific instance (vmsplice() with SPLICE_F_GIFT), the
manual pages agree with them.  I'm more inclined to adjust the
documentation since the behaviour we have has been that way since 2005, I
think.

These patches attempt to fix this by stealing a page if possible and
copying the data if not before splice() or vmsplice() adds it to the pipe.

Whilst this does allow the code to be somewhat simplified, it also results
in a loss of performance: stolen pages have to be reloaded in accessed
again; more data has to be copied.

Ideally, this should result in all pages in the pipe belonging solely to
the pipe and so they can be removed from the pipe and spliced into
pagecaches or process VM immediately with no further checking required.

Note that this conversion is incomplete.  It does not simplify fuse and
virtio_console and it does not clean up the splicing into pipes from
relayfs, watch_queue and sockets.

There's also a bug in the vmsplice() page stealing.  It mostly works but
after splicing a bunch of pages, it will oops somewhere in the interval
tree's macros.

I've pushed the patches here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=splice-fix-corruption

David

Link: https://lore.kernel.org/r/ec804f26-fa76-4fbe-9b1c-8fbbd829b735@mattwhitlock.name/ [1]

David Howells (4):
  splice: Fix corruption of spliced data after splice() returns
  splice: Make vmsplice() steal or copy
  splice: Remove some now-unused bits
  splice: Record some statistics

 fs/fuse/dev.c             |  37 -----
 fs/pipe.c                 |  12 --
 fs/splice.c               | 304 ++++++++++++++++++--------------------
 include/linux/pipe_fs_i.h |  14 --
 include/linux/splice.h    |   4 +-
 mm/filemap.c              |  98 +++++++++++-
 mm/internal.h             |   4 +-
 mm/shmem.c                |   8 +-
 8 files changed, 245 insertions(+), 236 deletions(-)

