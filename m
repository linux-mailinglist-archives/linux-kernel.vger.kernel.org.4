Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF2B669CBE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjAMPrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjAMPpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:45:53 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1726991511
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 07:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ggOkbzb2S7+qH5Fcr8YUMXOVLwxMkbp5ZnrWSch+hlc=; b=ePzihjjYQFkujbVarL4raFGxs2
        2UFLjM04Ah+XzR8ZuLRPlWN2Fs4IjxXJJ0yW2Zq0dwQ+kPF+wZU9x0oRYYpJ38TesS81D4VTimdwf
        CyqMwNHs+NI4SpnV53MQ9WOTwa8NHYCGaucO51bmvIFDNVE+XDP5ykWsRD1e+Izkpr/sIeGGwmP/5
        edSt4V7qEkn6kRGljjV8yFI4xxuROSQqqznydbnbISO7Mw+XgovQZkPgcAwH9g42vWrdzIezH9Cl8
        6hfi+E/NGo9na1oftamdOjHL0OJPc5EoxYEkO4AXvT+2PVPJfcl12m7AsCgSISAhNYv/rKfHNcFOP
        5FSBS9yg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGM79-006D9n-IQ; Fri, 13 Jan 2023 15:37:07 +0000
Date:   Fri, 13 Jan 2023 15:37:07 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 3/7] mm: memory: convert do_cow_fault to use folios
Message-ID: <Y8F6ozvZPPlewmC/@casper.infradead.org>
References: <20230112083006.163393-1-wangkefeng.wang@huawei.com>
 <20230112083006.163393-4-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112083006.163393-4-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 04:30:02PM +0800, Kefeng Wang wrote:
> -	vmf->cow_page = alloc_page_vma(GFP_HIGHUSER_MOVABLE, vma, vmf->address);
> -	if (!vmf->cow_page)
> +	cow_folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, vmf->address,
> +				    false);
> +	if (!cow_folio)

I have a patch I've been sitting on that converts vmf->cow_page to be
a folio.  I think this series is well and truly wrecked at this point,
so let me go back and dig it out; see if it still makes sense.

I'm a bit unsure about it because maybe we want to allocate
high(ish)-order folios on COW fault, and if we do, then maybe we want
to align them in some way with the virtual addresses, or the other
folios in the VMA.  And then we might want to indicate the precise
page for this page fault rather than have this page fault be the
start of a multi-order folio.

