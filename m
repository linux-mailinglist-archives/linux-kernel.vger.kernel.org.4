Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5266F93B9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 21:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjEFTEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 15:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjEFTEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 15:04:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3CB1637D;
        Sat,  6 May 2023 12:04:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05D7D60FE6;
        Sat,  6 May 2023 19:04:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BACEC433EF;
        Sat,  6 May 2023 19:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1683399852;
        bh=s5rAmNl7PRvWvOwuownC2bCo8Ucqs7SYfDCXJJHVOBI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rA1bKG2h8MT+6DHFW8Neba7nVFgRp1TyA8jvJyZFjfdJ5knoHo4+h3fvDvrL+u5ij
         Mn2729tiHOUeJMWNrY7eI7OwodqFg2lWivqc8gjbR0H0jBAiY173CwJaUrS8s0Pgzg
         aaTAKRPvh/4tpMmunYlFQN2yqT7mtrKTJVAS2w+0=
Date:   Sat, 6 May 2023 12:04:11 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [GIT PULL] dmapool updates for 6.4-rc1
Message-Id: <20230506120411.588729735420b57c1e0ce9b5@linux-foundation.org>
In-Reply-To: <CAHk-=wheZHs+15jtg68=Fjf0==xvfZ5rvTE00ii+MDUhWzxfgw@mail.gmail.com>
References: <20230506105054.0155139b3d3a7f249ead37be@linux-foundation.org>
        <CAHk-=wheZHs+15jtg68=Fjf0==xvfZ5rvTE00ii+MDUhWzxfgw@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 May 2023 11:53:16 -0700 Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sat, May 6, 2023 at 10:50 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > Reinstate the dmapool changes which were accidentally removed by
> > 2d55c16c0c54 ("dmapool: create/destroy cleanup").
> 
> Hmm. So this series is exactly the same as def8574308ed..2d55c16c0c54,
> except for not having that last broken one.
> 
> Which is fine, but I'm a bit surprised. Why?
> 
> Because it's also missing the _real_ "dmapool: create/destroy cleanup"
> patch, ie this one:
> 
>    https://lore.kernel.org/linux-mm/20230126215125.4069751-13-kbusch@meta.com/
> 
> and I realize you somehow corrupted it last time, but I did expect it
> to show up (perhaps folded into another patch, but in _some_ form).
> 
> Anyway, I've pulled this, but I think the end result of all this
> confusion was still a tad broken.
> 

Yes, it's just a little cleanup so I figured I'd restore the
non-messed-up patches that make functional changes and hold this one
off for the next merge window.


From: Keith Busch <kbusch@kernel.org>
Subject: dmapool: create/destroy cleanup
Date: Thu, 26 Jan 2023 13:51:25 -0800

Set the 'empty' bool directly from the result of the function that
determines its value instead of adding additional logic.

Link: https://lkml.kernel.org/r/20230126215125.4069751-13-kbusch@meta.com
Fixes: 2d55c16c0c54 ("dmapool: create/destroy cleanup")
Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Tony Battersby <tonyb@cybernetics.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/dmapool.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

--- a/mm/dmapool.c~dmapool-create-destroy-cleanup
+++ a/mm/dmapool.c
@@ -226,7 +226,7 @@ struct dma_pool *dma_pool_create(const c
 {
 	struct dma_pool *retval;
 	size_t allocation;
-	bool empty = false;
+	bool empty;
 
 	if (!dev)
 		return NULL;
@@ -276,8 +276,7 @@ struct dma_pool *dma_pool_create(const c
 	 */
 	mutex_lock(&pools_reg_lock);
 	mutex_lock(&pools_lock);
-	if (list_empty(&dev->dma_pools))
-		empty = true;
+	empty = list_empty(&dev->dma_pools);
 	list_add(&retval->pools, &dev->dma_pools);
 	mutex_unlock(&pools_lock);
 	if (empty) {
@@ -361,7 +360,7 @@ static struct dma_page *pool_alloc_page(
 void dma_pool_destroy(struct dma_pool *pool)
 {
 	struct dma_page *page, *tmp;
-	bool empty = false, busy = false;
+	bool empty, busy = false;
 
 	if (unlikely(!pool))
 		return;
@@ -369,8 +368,7 @@ void dma_pool_destroy(struct dma_pool *p
 	mutex_lock(&pools_reg_lock);
 	mutex_lock(&pools_lock);
 	list_del(&pool->pools);
-	if (list_empty(&pool->dev->dma_pools))
-		empty = true;
+	empty = list_empty(&pool->dev->dma_pools);
 	mutex_unlock(&pools_lock);
 	if (empty)
 		device_remove_file(pool->dev, &dev_attr_pools);
_

