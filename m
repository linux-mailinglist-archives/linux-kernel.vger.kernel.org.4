Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17F86139EF
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 16:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbiJaPW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 11:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbiJaPWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 11:22:53 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493BD11828
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 08:22:52 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id 17so6707652pfv.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 08:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1dA0Bpm+EerGxQeSwdhCiLJP6Ims7gljy+o1neN8bH8=;
        b=gjPYLPBI8i200feYZ0JN7kv2xudySLuBdbVovx/88OFxLGQQTOQWlxUGIvUnQ1sIhW
         r3QH48FVEHI29WRQkXmuX2eostBHqqet+VmrrFCrL6byOPZ0NS1Z5PjnsjyvPJQ1GyvO
         YF/8OVMsGxxEgVOrDjqyfq/nkRGstOx/8Bci0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1dA0Bpm+EerGxQeSwdhCiLJP6Ims7gljy+o1neN8bH8=;
        b=fcUB14Yr8a72oDSi+xORq1BaRouKuys0jdzzvBQD/zPNODTeQT4LPNV+C3A7ISDfsJ
         P0DPmI4coAUgbGzhEJ2WcowCihQcE5l8W36vC7AgzE4kMycdTZkHEe6iUBUV2DUIhUgA
         zTq5Evr4x+k9+9LB3crqQVCmy/7Rjg0Jx/qC76WYU7ATHqRuIU64yVkMHqXZ27okjnnm
         RDIjMwTGtpPRnW7CkceNoecwor9MvMeFMTXCF63ppBC2Rd5SnrsbXqZ604moQyYdCYq5
         Ox23JKkWIb7yj8cEinN6/wMEJPGO3gN887aFy79hktFv0Rz/6IPQoUIYbhceMo89Xymt
         kkMg==
X-Gm-Message-State: ACrzQf3esTxmiwbMWB5/Jmbqp0pyvGwM4fqIBpP+3GAQGIzbCj00gZke
        4zkHIloQlCx9YhTfpiFlZMML/A==
X-Google-Smtp-Source: AMsMyM50aXJ7r3X1z4lItzTdn18aYnYoL2XL75pwhE733EavEAKX8Wh7vM2fmh4Pg1j/uaWxqzL6Hw==
X-Received: by 2002:a05:6a00:15c3:b0:56c:e8d0:aaf1 with SMTP id o3-20020a056a0015c300b0056ce8d0aaf1mr14868603pfu.75.1667229771778;
        Mon, 31 Oct 2022 08:22:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ix2-20020a170902f80200b001869efb722csm4585853plb.215.2022.10.31.08.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 08:22:51 -0700 (PDT)
Date:   Mon, 31 Oct 2022 08:22:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Anders Roxell <anders.roxell@linaro.org>,
        kernel test robot <oliver.sang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Marco Elver <elver@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-mm@kvack.org, Andrey Konovalov <andreyknvl@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4] mempool: Do not use ksize() for poisoning
Message-ID: <202210310821.9F7AA27D12@keescook>
References: <20221028154823.you.615-kees@kernel.org>
 <20221031105514.GB69385@mutt>
 <13c4bd6e-09d3-efce-43a5-5a99be8bc96b@suse.cz>
 <Y1/l4Tacaw738UaX@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1/l4Tacaw738UaX@casper.infradead.org>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 03:12:33PM +0000, Matthew Wilcox wrote:
> On Mon, Oct 31, 2022 at 04:00:25PM +0100, Vlastimil Babka wrote:
> > +++ b/mm/mempool.c
> > @@ -57,8 +57,10 @@ static void __check_element(mempool_t *pool, void *element, size_t size)
> >  static void check_element(mempool_t *pool, void *element)
> >  {
> >  	/* Mempools backed by slab allocator */
> > -	if (pool->free == mempool_free_slab || pool->free == mempool_kfree) {
> > +	if (pool->free == mempool_kfree) {
> >  		__check_element(pool, element, (size_t)pool->pool_data);
> > +	} else if (pool->free == mempool_free_slab) {
> > +		__check_element(pool, element, kmem_cache_size(pool->pool_data));
> >  	} else if (pool->free == mempool_free_pages) {
> >  		/* Mempools backed by page allocator */
> >  		int order = (int)(long)pool->pool_data;
> 
> I had a quick look at this to be sure I understood what was going on,
> and I found a grotesque bug that has been with us since the introduction
> of check_element() in 2015.
> 
> +       if (pool->free == mempool_free_pages) {
> +               int order = (int)(long)pool->pool_data;
> +               void *addr = kmap_atomic((struct page *)element);
> +
> +               __check_element(pool, addr, 1UL << (PAGE_SHIFT + order));
> +               kunmap_atomic(addr);
> 
> kmap_atomic() and friends only map a single page.  So this is all
> nonsense for HIGHMEM kernels, GFP_HIGHMEM allocations and order > 0.
> The consequence of doing that will be calling memset(POISON_INUSE)
> on random pages that we don't own.

Ah-ha! Thank you both! Seems like the first fix should be squashed and
the latter one is separate? Or just put it all together?

-- 
Kees Cook
