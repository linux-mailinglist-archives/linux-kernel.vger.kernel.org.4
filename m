Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8B26CAB1C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 18:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbjC0Qyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 12:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjC0Qy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 12:54:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF25030F5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 09:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9O/OI0XHxRCl2GWfaF3ldaUFa5QZHQ75qR1bgkdfgB8=; b=YnkKBWNo44hWbpWIGmDz5lNiER
        NKh8h23Zty4oduxWYYDcuX3dYTwV1rwO/SLhuUE9nzO6vuBCvxdkvn9KXHJrRDeswTALYDYCrDRCx
        0wZOqCbeu8Ut1zAFbm2b3NxrBsxWR7KJBpQqagropjpYdWmpSNb0K7ABSKnVJnyHlUQ0X8yaIjgUx
        q9ipKflshOoSM2ci9kJY0N1US7UBwp6CCQcEO/RVlG+Xdr91X7v1/8JBNG7jX06icQCD+nD39zhhL
        awmWYL5x+TMrxyDTZxprHNI7K/KHeo+79QxdJMzhgrmR6Uic12q49d6Wv5fI11NA6UgfTnyVgZ6V6
        FxS8K4tg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pgq6t-007ZOU-4F; Mon, 27 Mar 2023 16:54:19 +0000
Date:   Mon, 27 Mar 2023 17:54:19 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 1/2] mm: vmalloc: Remove a global vmap_blocks xarray
Message-ID: <ZCHKO93L5MD7NWZq@casper.infradead.org>
References: <20230327165228.405045-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327165228.405045-1-urezki@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 06:52:26PM +0200, Uladzislau Rezki (Sony) wrote:
> @@ -1927,25 +1940,47 @@ struct vmap_block {
>  /* Queue of free and dirty vmap blocks, for allocation and flushing purposes */
>  static DEFINE_PER_CPU(struct vmap_block_queue, vmap_block_queue);
>  
> -/*
> - * XArray of vmap blocks, indexed by address, to quickly find a vmap block
> - * in the free path. Could get rid of this if we change the API to return a
> - * "cookie" from alloc, to be passed to free. But no big deal yet.
> +/**

This is marked for kernel-doc without being in kernel-doc format.
I'd suggest just using a single '*'.

