Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26CEA5F20C7
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 02:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiJBAqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 20:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJBAqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 20:46:52 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7522CC86
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 17:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Gv2YDk3wxAsM+5p/ZBBVyhFLL1BUSQ3HyXzRKnGGrEc=; b=FnKwGfG2xXw4ocWfZMTeVdtmYG
        9V8riq5kooZ10uSNGvJEL3wEe+RqTgIQxoM5ERPH32yo0ovp15w2++1q6bdEP78csVtx++ZYT7M70
        /XeVtyp2j2u65FyoCUHCHB7bFTvYlSs0iTBcAQj8PPrrsQ+3U/mlEjCO+Grv2PgCu9CBBiix48IoS
        c6HDlm0FwPqXwKd4558daO9fA62Fy7OuMFV/TbPXD+60s6RzhcsehSfmiv8wSsMs77FxKUszGGmXV
        1Y/H1AYgdwOTtHx73zMLJcuVGhXh3xRy7FD2CmvL6xpCef4O8SmycjvdajjIjfzxGX6ecctz8ueGr
        Dsr7gTEw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oen7x-005osN-1u;
        Sun, 02 Oct 2022 00:46:41 +0000
Date:   Sun, 2 Oct 2022 01:46:41 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     ira.weiny@intel.com
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 3/4] tee: Remove call to get_kernel_pages()
Message-ID: <YzjfcW6OGcPP075q@ZenIV>
References: <20221002002326.946620-1-ira.weiny@intel.com>
 <20221002002326.946620-4-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221002002326.946620-4-ira.weiny@intel.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 01, 2022 at 05:23:25PM -0700, ira.weiny@intel.com wrote:

>  	kiov = kcalloc(page_count, sizeof(*kiov), GFP_KERNEL);
> @@ -38,12 +39,12 @@ static int shm_get_kernel_pages(unsigned long start, size_t page_count,
>  	for (n = 0; n < page_count; n++) {
>  		kiov[n].iov_base = (void *)(start + n * PAGE_SIZE);
>  		kiov[n].iov_len = PAGE_SIZE;
> +		pages[n] = virt_to_page(kiov[n].iov_base);
> +		get_page(pages[n]);
>  	}
> -
> -	rc = get_kernel_pages(kiov, page_count, 0, pages);
>  	kfree(kiov);

IDGI.  The only thing in kiov[...] you are every reading is
->iov_base.  And you fetch it once, right after the assignment.

Why bother with allocating the array at all?
		pages[n] = virt_to_page((void *)start + n * PAGE_SIZE);
would do just as well, not to mention the fact that since you reject
vmalloc and kmap, you might simply do

	page = virt_to_page(start);
	for (int n = 0; n < page_count; n++)
		get_page(pages[n] = page + n);

instead...
