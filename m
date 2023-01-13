Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CA8669CA2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjAMPmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjAMPli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:41:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09397D261
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 07:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zRXwQ9oqAVYSWzO7WrEZgPVvSq/p+4hxA2jZXOARcaA=; b=IKHZjnz4pPCOfgTft+0liESi2f
        kKsDMVi9+ddi0BQxyoKLBdrKMKLTpQ3UFyYHdysj91Vidl0LsX6Vtc9cvXCV7v4NvXCp8KDGmzdOp
        xeokBIMpny4z6sCyjZlabpSSos0apHc5VCgr7VUsya6qepDL8kN1H26sQnSjDZ6eCrm1XC9AW96t+
        n/eqEysqbghxeJhivzSZuCaVoVatsTv7HCVrx4iSeBnBtJhaaCUuB6kQbB9jGl6vE3inaQziDKi5U
        NSQKzgKntPuWHy7ScL/fEaQskGlqAksBg0FBVqfarlEyXsStguWuw8fwqGsi183l+3QS1IPuBjNSG
        YZmtB/bw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGM3O-006Cyp-EH; Fri, 13 Jan 2023 15:33:14 +0000
Date:   Fri, 13 Jan 2023 15:33:14 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 2/7] mm: memory: convert do_anonymous_page() to use
 a folio
Message-ID: <Y8F5ulAWxiv8T97r@casper.infradead.org>
References: <20230112083006.163393-1-wangkefeng.wang@huawei.com>
 <20230112083006.163393-3-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112083006.163393-3-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 04:30:01PM +0800, Kefeng Wang wrote:
> Convert do_anonymous_page() to use a folio and replace related functions
> to folio functions.

I think this patch has a prerequisite of sorting out
alloc_zeroed_user_highpage_movable().  That way we can get rid of
the 'page' variable inside this function altogether.

>  	inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
>  	page_add_new_anon_rmap(page, vma, vmf->address);

folio_add_new_anon-rmap().

> -	lru_cache_add_inactive_or_unevictable(page, vma);
> +	folio_add_lru_vma(folio, vma);
