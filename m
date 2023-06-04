Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E0D721651
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 13:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjFDLQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 07:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjFDLQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 07:16:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD9CD3;
        Sun,  4 Jun 2023 04:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wV+lTMaC3z644k/Yk/InRSq/6/07bZzUxmzLJgoLbjo=; b=Dsdlr2BLmVqV3RBisOg/nK3OdP
        tOCh/wYU5HDWFk4JuckrcEaYNaH9ZMYgs3fBBh+3Ueuhz48NuCyDuFI7NfWrid4XL/85iwvzacwN9
        VjTjfiFWVHV9XQZwfhhfGzw+Orq83LawvtclvKFsi0dmqfaAoGIQAg/rYsp3LMB3VBu/J5JLhq7lg
        vxCTkzMq3QuD6IqMBt46tN+Pj0t7mU2az3i3yOJHckmSgGmCsPiUOCYu5ihoSyrCivmfZkAkNYTIO
        2iWuhVl2TdMbtsLaBOXVDhDhBf/54wGDw3khF8u0augaBLOgtGMt7pIhL3S4aUDUHRQvlmPz5hUyF
        0jpZIDyA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q5liQ-00AzJH-Ij; Sun, 04 Jun 2023 11:16:06 +0000
Date:   Sun, 4 Jun 2023 12:16:06 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     butt3rflyh4ck <butterflyhuangxx@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, akpm@linux-foundation.org,
        yi.zhang@huawei.com, trix@redhat.com, song@kernel.org,
        bvanassche@acm.org, reiserfs-devel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: A null-ptr-deref bug in reiserfs_breada in fs/reiserfs/journal.c
Message-ID: <ZHxydoL06XHR1bOx@casper.infradead.org>
References: <CAFcO6XOacq3hscbXevPQP7sXRoYFz34ZdKPYjmd6k5sZuhGFDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFcO6XOacq3hscbXevPQP7sXRoYFz34ZdKPYjmd6k5sZuhGFDw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 04, 2023 at 04:12:56PM +0800, butt3rflyh4ck wrote:
> Hi, there is a null-ptr-deref  bug in reiserfs_breada in
> fs/reiserfs/journal.c, I reproduce it in the latest kernel too.

does this fix the problem?

diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
index 4d11d60f493c..dd58e0dca5e5 100644
--- a/fs/reiserfs/journal.c
+++ b/fs/reiserfs/journal.c
@@ -2326,7 +2326,7 @@ static struct buffer_head *reiserfs_breada(struct block_device *dev,
 	int i, j;
 
 	bh = __getblk(dev, block, bufsize);
-	if (buffer_uptodate(bh))
+	if (!bh || buffer_uptodate(bh))
 		return (bh);
 
 	if (block + BUFNR > max_block) {
@@ -2336,6 +2336,8 @@ static struct buffer_head *reiserfs_breada(struct block_device *dev,
 	j = 1;
 	for (i = 1; i < blocks; i++) {
 		bh = __getblk(dev, block + i, bufsize);
+		if (!bh)
+			break;
 		if (buffer_uptodate(bh)) {
 			brelse(bh);
 			break;
