Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7152070D394
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 08:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234834AbjEWGGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 02:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234893AbjEWGGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 02:06:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C51188
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 23:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qCSqRU4a/AsmBcdv6iFySShWfg8XjHUWfeGXvA0y1bo=; b=c+Zpz1LY9LjeY59YL09M41TiAD
        Johlulku37xPjx21Je0nBNT4hTLy0GVlvzREcICEC9Ay0b9XMgFEpLT/5qEhgZl8WwDb07aSxxSGm
        XN8NCq/Qs5n8fANb+AWvcekDppF0HtwpOnJmS7epKKWKD6yPgNkKezXsSHqauzvs/rQyFEjipBqQo
        tJZTZ/L2EUqit8LES+1ArPDYX5c1vhlmiQUkMrO5Psk716PS/swRG3D+/N3A5RUz/jcVkilGd64Qz
        qkTTMvfuSJSjQ1JZrL/sq9FhHWcdoTHNWnYDEYbZumxDfJUZXRjZJfUc863GeIcpXwcamCf0PfH01
        QM6pR9Nw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q1L9h-0092MO-2U;
        Tue, 23 May 2023 06:05:57 +0000
Date:   Mon, 22 May 2023 23:05:57 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 1/9] mm: vmalloc: Add va_alloc() helper
Message-ID: <ZGxXxcQ1FOvJY/73@infradead.org>
References: <20230522110849.2921-1-urezki@gmail.com>
 <20230522110849.2921-2-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522110849.2921-2-urezki@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 01:08:41PM +0200, Uladzislau Rezki (Sony) wrote:
> Currently __alloc_vmap_area() function contains an open codded
> logic that finds and adjusts a VA based on allocation request.
> 
> Introduce a va_alloc() helper that adjusts found VA only. It
> will be used later at least in two places.
> 
> There is no a functional change as a result of this patch.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 41 ++++++++++++++++++++++++++++-------------
>  1 file changed, 28 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 31ff782d368b..409285b68a67 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1482,6 +1482,32 @@ adjust_va_to_fit_type(struct rb_root *root, struct list_head *head,
>  	return 0;
>  }
>  
> +static unsigned long
> +va_alloc(struct vmap_area *va,
> +	struct rb_root *root, struct list_head *head,
> +	unsigned long size, unsigned long align,
> +	unsigned long vstart, unsigned long vend)

Prototype continuations don't use a single tab indent.  Either two
tabs (my preference) or after the opening brace.  I.e.:

static unsigned long
va_alloc(struct vmap_area *va, struct rb_root *root, struct list_head *head,
		unsigned long size, unsigned long align, unsigned long vstart,
		unsigned long vend)


Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
