Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7C169EB4A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 00:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjBUXhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 18:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjBUXhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 18:37:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040CF311F8;
        Tue, 21 Feb 2023 15:36:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92F41B81038;
        Tue, 21 Feb 2023 23:36:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F719C433EF;
        Tue, 21 Feb 2023 23:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1677022615;
        bh=t9PflTmR8D8YpQ5iwtxgUyd2ZjSOHE0PBJApANbv1Hw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AjKPkSRnCSyp+sS6avbhycvr5Ly2ovZWDFCYyGwPf6Crq/8V00WZagu16v+WARNT1
         SeYQKAYfdg0WTmA5MCXCmMF8D7yIi+N4+EWuu4Njkn15wuf/RPQRmtU89Oxsunq3XS
         KiRqRxXJQLolCosvGV/jCOWHJy6eivudMVoJsTxs=
Date:   Tue, 21 Feb 2023 15:36:54 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, mm-commits@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: [GIT PULL] MM updates for 6.3-rc1
Message-Id: <20230221153654.093d16a9ebe455644fd805ca@linux-foundation.org>
In-Reply-To: <20230220135225.91b0f28344c01d5306c31230@linux-foundation.org>
References: <20230220135225.91b0f28344c01d5306c31230@linux-foundation.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Feb 2023 13:52:25 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:

> There are a lot of conflicts in your future, mainly because of the
> ongoing folio conversion work.  This will hopefully come to an end
> fairly soon.  Forthcoming conflicts which are known about, along with
> Stephen's fixes are:
> ...

And...  I failed to mention a conflict which didn't generate a reject,
thanks to a post-6.2-rc4 gfs2 patch.

Stephen's fix for this is at
https://lkml.kernel.org/r/20230127173638.1efbe423@canb.auug.org.au

Or,

From: Andrew Morton <akpm@linux-foundation.org>
Subject: fs/gfs2/log.c: fix build in  __gfs2_writepage()
Date: Tue Feb 21 03:23:08 PM PST 2023

mm-stable was based on 6.2-rc4 and hence its patch d585bdbeb79a ("fs:
convert writepage_t callback to pass a folio") didn't know about the
post-rc4 95ecbd0f162f ("Revert "gfs2: stop using generic_writepages in
gfs2_ail1_start_one"").

Net result is that d585bdbeb79a failed to convert fs/gfs2/log.c.  The fix
is from Andreas.

Fixes: d585bdbeb79a ("fs: convert writepage_t callback to pass a folio")
Reported-by: Andreas Gruenbacher <agruenba@redhat.com>
  Link: https://lkml.kernel.org/r/20230203105401.3362277-1-agruenba@redhat.com
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---


--- a/fs/gfs2/log.c~fs-gfs2-logc-fix-build-in-__gfs2_writepage
+++ a/fs/gfs2/log.c
@@ -80,11 +80,11 @@ void gfs2_remove_from_ail(struct gfs2_bu
 	brelse(bd->bd_bh);
 }
 
-static int __gfs2_writepage(struct page *page, struct writeback_control *wbc,
-		       void *data)
+static int __gfs2_writepage(struct folio *folio, struct writeback_control *wbc,
+			    void *data)
 {
 	struct address_space *mapping = data;
-	int ret = mapping->a_ops->writepage(page, wbc);
+	int ret = mapping->a_ops->writepage(&folio->page, wbc);
 	mapping_set_error(mapping, ret);
 	return ret;
 }
_

