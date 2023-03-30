Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8F96D0D4A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 20:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjC3SDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 14:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjC3SDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 14:03:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166A0CA1D
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 11:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1Aa7UYbp3NZ+5Vx0LEPR8MqsdlgGFeZ4MOxoVkSDaxY=; b=ZmZhfNUm4wQbR8zStejmdtqI3P
        O3Bl/BlqUbMGfIaar03ALiOL4NtAwTF3Dk5QjbsmMgYucNmufEB4bKVVUO7ngPAXfj8itxj1dG4Qz
        N2NHsoSxEbFObLnwzsx4oXmS8X5uNnrIHNF7n/3IUMB6TtJRcOcJM/MgpU6hu3Bqc5n1ylHUJPMUD
        n938UPYykb/muMv+CVr52UVX/WjwTpC1juSHVgOYXsIDzXTN9itl7XUyl4tfBpJXuheH2LXrFHyY4
        bUNCsu0MiqEep+0V0IVf/3qOSCcmcF/dQxAFLAJhjm9RG7BPUNskE8KBuMlAg6S9o2XbcXc0/pHVI
        t3OrDFyw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1phwbf-00AdP9-JM; Thu, 30 Mar 2023 18:02:39 +0000
Date:   Thu, 30 Mar 2023 19:02:39 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     Peng Zhang <zhangpeng362@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, vishal.moola@gmail.com,
        muchun.song@linux.dev, wangkefeng.wang@huawei.com,
        sunnanyong@huawei.com
Subject: Re: [PATCH v4 1/6] userfaultfd: convert mfill_atomic_pte_copy() to
 use a folio
Message-ID: <ZCXOv9rz8GCrpbMk@casper.infradead.org>
References: <20230330134045.375163-1-zhangpeng362@huawei.com>
 <20230330134045.375163-2-zhangpeng362@huawei.com>
 <765d450c-2ff6-1420-b94f-528d56bffee4@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <765d450c-2ff6-1420-b94f-528d56bffee4@oracle.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 10:02:52AM -0700, Sidhartha Kumar wrote:
> On 3/30/23 6:40 AM, Peng Zhang wrote:
> > From: ZhangPeng <zhangpeng362@huawei.com>
> > 
> > Call vma_alloc_folio() directly instead of alloc_page_vma(). Add an
> > assertion that this is a single-page folio and removes several calls to
> > compound_head().

There's no added assertion in this patch any more, so I'd drop that
part of the description.

> >   	if (!*pagep) {
> >   		ret = -ENOMEM;
> > -		page = alloc_page_vma(GFP_HIGHUSER_MOVABLE, dst_vma, dst_addr);
> > -		if (!page)
> > +		folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, dst_vma, dst_addr, false);
> > +		if (!folio)
> >   			goto out;
> > -		page_kaddr = kmap_local_page(page);
> > +		page_kaddr = kmap_local_folio(folio, 0);
> 
> Should this variable name be kept as page_kaddr or should it be changed to
> something like folio_kaddr? kmap_local_folio() returns page_address(), so
> maybe page_kaddr is better.

I'd just call it 'kaddr'.  Or 'addr'.
