Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDA96AD501
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 03:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjCGCtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 21:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjCGCtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 21:49:06 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60DF2E81F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 18:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BH9IghDLzLA4qbQqyeD/U80w35wn2Jax/dRS99/xVtQ=; b=Mle+349cJ33oi5H+LZQSEV9z3m
        uQJvo+OBg/AXMc+gjNdeFct9BQxvHc5wqIjXTq0hg/gOJHlzRZTEZHuy9Wylku9Js5eWh5bnFmRQs
        cdWGRbaR1CBt/9HL0qzx8P7772m9hRlWA3qIlyHsMBCFbtB8CF0JLYyXyrhCF/hrS3MtGecod5B2h
        z/5omwY/YBBlw9CxUT5jbIenyqBCEC3bNOeYTPYG0vnCy4ew8sej+eMqc3GbwzEy2bBl5XBXr3+Xd
        RE2DpVixxnxJSY4kvtFd7dIBlBcbB3755F86EPnL+UWTe2u3baFuCGpOGmYaE/Twaql0LXk5UdbJe
        pNbnMl/g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pZNNl-005weh-Rv; Tue, 07 Mar 2023 02:48:54 +0000
Date:   Tue, 7 Mar 2023 02:48:53 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: remove redundant check in handle_mm_fault
Message-ID: <ZAamFX/hq6Y/iNJb@casper.infradead.org>
References: <20230306024959.131468-1-haifeng.xu@shopee.com>
 <df3997ed-a844-597b-fbb1-154caad78543@redhat.com>
 <354360d5-dce6-a11c-ee61-d41e615bfa05@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <354360d5-dce6-a11c-ee61-d41e615bfa05@shopee.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 10:36:55AM +0800, Haifeng Xu wrote:
> On 2023/3/6 21:49, David Hildenbrand wrote:
> > On 06.03.23 03:49, Haifeng Xu wrote:
> >> mem_cgroup_oom_synchronize() has checked whether current memcg_in_oom is
> >> set or not, so remove the check in handle_mm_fault().
> > 
> > "mem_cgroup_oom_synchronize() will returned immediately if memcg_in_oom is not set, so remove the check from handle_mm_fault()".
> > 
> > However, that requires now always an indirect function call -- do we care about dropping that optimization?
> > 
> > 
> 
> If memcg_in_oom is set, we will check it twice, one is from handle_mm_fault(), the other is from mem_cgroup_oom_synchronize(). That seems a bit redundant.
> 
> if memcg_in_oom is not set, mem_cgroup_oom_synchronize() returns directly. Though it's an indirect function call, but the time spent can be negligible 
> compare to the whole mm user falut preocess. And that won't cause stack overflow error.

I suggest you measure it.
