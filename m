Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7EE86EFF48
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 04:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242745AbjD0CQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 22:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242709AbjD0CQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 22:16:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FA6359E
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 19:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WCjOcrjlJYOxhgLUXIdsOYG64BAcqHZ2Pg3VQv/GSJE=; b=Ny8EQWrLbiXzQ4jwByXSdII0hB
        61co8DyCw2dzK2vSl8n6f2cry8POyHh23X80xhGsE9WIAT4+3Rp5xvJ+xUQ6yEU3hFhVOn4QFtQji
        tuo0XZBYmTvyYc1Qql+5FJ7tVqL5AoA3P/GjIv7S/P4OhDc5Jv0qDXO3+g+U6YZqV+swWaEoGNQ5z
        TgXxxn/pS0j/v4EydDrjdI9vVxsNc+zRf52Ar7izMCzUZxYWWtu3nmLRClmfa2rRmsGy0PQD7Ufwq
        XTWoenUjs50bVfBQRak8w70IHPc2VqKxK8vajz3+Jur7nr7ng5cfe5GMWNkdvr+9iNlutSyEZo69H
        CfSRYm4w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1prrBH-0034Yd-F3; Thu, 27 Apr 2023 02:16:24 +0000
Date:   Thu, 27 Apr 2023 03:16:23 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Hillf Danton <hdanton@sina.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v2 1/4] mm/filemap: Add folio_lock_timeout()
Message-ID: <ZEna98ttFA9FF14I@casper.infradead.org>
References: <20230421151135.v2.1.I2b71e11264c5c214bc59744b9e13e4c353bc5714@changeid>
 <20230422051858.1696-1-hdanton@sina.com>
 <CAD=FV=XAJnWL8YHok8RcgR8aK5igKfvE2iD7aW7Rpr4cDVJedQ@mail.gmail.com>
 <20230425010917.1984-1-hdanton@sina.com>
 <CAD=FV=XWuQoaGZG_Tm8AqGAsqGSAa822bNw3Dp2QnmR40npURw@mail.gmail.com>
 <20230426100918.ku32k6mqoogsnijn@techsingularity.net>
 <ZEk/uVlbX2wWgagN@casper.infradead.org>
 <CAD=FV=UyLf9GLz7xJyzhW2V_JycwUppwGfe7th17f_KXmMGOqw@mail.gmail.com>
 <ZEmXH1FpOgT/u6/j@casper.infradead.org>
 <CAD=FV=Xkg6XgSL0VVVUMm+8xQ65oDgKoTgG0qHY7ALBE3xhCmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=Xkg6XgSL0VVVUMm+8xQ65oDgKoTgG0qHY7ALBE3xhCmg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 02:39:56PM -0700, Doug Anderson wrote:
> Sure, I'm happy to do it like you say. Do you have any suggestions for
> the similar lock_buffer() case, or are you OK w/ the timeout there?

I'd do that similarly, ie:

+++ b/mm/migrate.c
@@ -691,38 +691,30 @@ EXPORT_SYMBOL(migrate_folio);
 static bool buffer_migrate_lock_buffers(struct buffer_head *head,
                                                        enum migrate_mode mode)
 {
-       struct buffer_head *bh = head;
+       struct buffer_head *failed_bh, *bh = head;
 
-       /* Simple case, sync compaction */
-       if (mode != MIGRATE_ASYNC) {
-               do {
-                       lock_buffer(bh);
-                       bh = bh->b_this_page;
-
-               } while (bh != head);
-
-               return true;
-       }
-
-       /* async case, we cannot block on lock_buffer so use trylock_buffer */
        do {
                if (!trylock_buffer(bh)) {
-                       /*
-                        * We failed to lock the buffer and cannot stall in
-                        * async migration. Release the taken locks
-                        */
-                       struct buffer_head *failed_bh = bh;
-                       bh = head;
-                       while (bh != failed_bh) {
-                               unlock_buffer(bh);
-                               bh = bh->b_this_page;
-                       }
-                       return false;
+                       if (mode == MIGRATE_ASYNC)
+                               goto unlock;
+                       if (mode == MIGRATE_SYNC_LIGHT && !buffer_uptodate(bh))
+                               goto unlock;
+                       lock_buffer(bh);
                }
 
                bh = bh->b_this_page;
        } while (bh != head);
        return true;
+
+unlock:
+       /* Failed to lock the buffer and cannot stall */
+       failed_bh = bh;
+       bh = head;
+       while (bh != failed_bh) {
+               unlock_buffer(bh);
+               bh = bh->b_this_page;
+       }
+       return false;
 }
 
 static int __buffer_migrate_folio(struct address_space *mapping,

