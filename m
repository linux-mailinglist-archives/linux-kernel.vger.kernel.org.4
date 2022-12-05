Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDF06430E4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbiLES5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbiLES5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:57:43 -0500
X-Greylist: delayed 3018 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 05 Dec 2022 10:57:37 PST
Received: from mail.cybernetics.com (mail.cybernetics.com [173.71.130.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280D4F62
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 10:57:35 -0800 (PST)
X-ASG-Debug-ID: 1670263636-1cf43916c221f840001-xx1T2L
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with ESMTP id BowDeQFtfcmWyUgM; Mon, 05 Dec 2022 13:07:16 -0500 (EST)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cybernetics.com; s=mail;
        bh=RpLG6FuUPyOMHlETTijxTvENKLCXTVEl0Lq8W8zjYLQ=;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
        Content-Language:Subject:MIME-Version:Date:Message-ID; b=RKqDLauSxncfqo0oPaW8
        hTFWjoaPEZSKJp25k2V2a5MkhjSuOv3zbSOGKYEI4P/ZIUCZuX3ba9F2u0aEVAcwqqWwvXAQjmqRq
        Hw+ZN6ctq5ADesMMtzdj5uUrIZ6iuPl/5t62o89MDa8WW1OmFCFJTWMJw/7OjEdvev4hOHO8Dk=
Received: from [10.157.2.224] (HELO [192.168.200.1])
  by cybernetics.com (CommuniGate Pro SMTP 7.1.1)
  with ESMTPS id 12356546; Mon, 05 Dec 2022 13:07:16 -0500
Message-ID: <8fc56daf-7f8d-b62b-b6bf-4da4ca87ea20@cybernetics.com>
Date:   Mon, 5 Dec 2022 13:07:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 11/11] dmapool: link blocks across pages
Content-Language: en-US
X-ASG-Orig-Subj: Re: [PATCH 11/11] dmapool: link blocks across pages
To:     Keith Busch <kbusch@meta.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>
References: <20221205145937.54367-1-kbusch@meta.com>
 <20221205145937.54367-12-kbusch@meta.com>
From:   Tony Battersby <tonyb@cybernetics.com>
In-Reply-To: <20221205145937.54367-12-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1670263636
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 2390
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/22 09:59, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
>
> The allocated dmapool pages are never freed for the lifetime of the
> pool. There is no need for the two level list+stack lookup for finding a
> free block since nothing is ever removed from the list. Just use a
> simple stack, reducing time complexity to constant.
>
> The implementation inserts the stack linking elements and the dma handle
> of the block within itself when freed. This means the smallest possible
> dmapool block is increased to at most 16 bytes to accomodate these
> fields, but there are no exisiting users requesting a dma pool smaller
> than that anyway.

Great work!

I notice that the comment at the top of dmapool.c describes the old
design ("Free blocks are tracked in an unsorted singly-linked
list of free blocks within the page."), so you need to delete or update
that part of the comment.

>  struct dma_pool {		/* the pool */
>  	struct list_head page_list;
>  	spinlock_t lock;
>  	struct device *dev;
> +	struct dma_block *next_block;
>  	unsigned int size;
>  	unsigned int allocation;
>  	unsigned int boundary;
> +	unsigned int nr_blocks;
> +	unsigned int nr_active;
> +	unsigned int nr_pages;

I think nr_blocks, nr_active, and nr_pages should be size_t rather than
unsigned int since they count the number of objects in the entire pool,
and it would be theoretically possible to allocate more than 2^32 objects.


> @@ -199,22 +217,24 @@ EXPORT_SYMBOL(dma_pool_create);
>  
>  static void pool_initialise_page(struct dma_pool *pool, struct dma_page *page)
>  {
> -	unsigned int offset = 0;
> -	unsigned int next_boundary = pool->boundary;
> -
> -	page->in_use = 0;
> -	page->offset = 0;
> -	do {
> -		unsigned int next = offset + pool->size;
> -		if (unlikely((next + pool->size) >= next_boundary)) {
> -			next = next_boundary;
> +	unsigned int next_boundary = pool->boundary, offset = 0;
> +	struct dma_block *block;
> +
> +	while (offset < pool->allocation) {
> +		if (offset > next_boundary) {

This is incorrect.  I believe the correct comparison should be:

+    while (offset + pool->size <= pool->allocation) {
+        if (offset + pool->size > next_boundary) {

That should handle all the weird possible combinations of size,
boundary, and allocation.

Tony Battersby
Cybernetics

