Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAD86552E1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 17:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbiLWQgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 11:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbiLWQfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 11:35:50 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6326D8FDA
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 08:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fD9AvHf31njkZOwZj8fkUsiuu/KvvsOzMtsutwzBTZs=; b=UyojPTS2gieP27lXnkM/vdNs2Y
        suglx866vkqT3+jGD3jAXcxNPmq35fYQ70evwb5sdjKftLitVLHFV7Sx9iRJ8pxRqmUhVqpB1vt6A
        BKcTo5fV17SiGgB65GukEPYCL/nkNZjDO14GYP3R+IwXZOH8TAxQP4cCbIFz7924Z7Icae7LmqXcy
        pSH56dTANV4RrlnTJsXA+EAnGPbv4qy0vsF/VX6+9LowqDkiIYT+3bAde1MT9eX35hkSnXS1Xvobr
        o03Ulb7Rm+DIWecUVDdzk0SU6UuTXCxXNw5OJu+5MgHq/eWCr5e/qyYhmEv7/sU6d5M3dxRNV7lfO
        J0vAUL3A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p8l1L-00A1Dq-IM; Fri, 23 Dec 2022 16:35:43 +0000
Date:   Fri, 23 Dec 2022 08:35:43 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Keith Busch <kbusch@meta.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Tony Battersby <tonyb@cybernetics.com>,
        Kernel Team <kernel-team@meta.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 08/11] dmapool: consolidate page initialization
Message-ID: <Y6XY35c4nBLpLpJT@infradead.org>
References: <20221216201625.2362737-1-kbusch@meta.com>
 <20221216201625.2362737-9-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221216201625.2362737-9-kbusch@meta.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	page->in_use = 0;
> +	page->offset = 0;

This move makes total sense to me.

>  		return NULL;
>  
>  	spin_lock_irqsave(&pool->lock, flags);
> -
> -	list_add(&page->page_list, &pool->page_list);
> +	pool_initialise_page(pool, page);

.. but this now moves all of pool_initialise_page inside the
pool->lock critical section.  Is that really a good idea?
