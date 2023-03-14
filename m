Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29AA06B9613
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbjCNN0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 09:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbjCNN0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:26:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22BF62DAA
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 06:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Lbfu5hsFdjJNQ2BcOkd2Ni80XTMP3EUdmJmeyIEDzTQ=; b=i1kilWR4cBokymritd2FC6xZ3h
        E8+hYXkd2phG11jdPl6Q5ALHtqIsEQE8cmyXpIL6PKPSjBq/+UGigifKi97Ix6CnUQoOGUm9Dk6Su
        RvNARmReK6/Oo1SMeuUlGea35+uvMUWD/Qx0o8twYspe5xA/VYIhwszGBbJvEZyjAYG2x8HynEyzz
        T+vR8cGtbSZTWSVVHSV8M80kHUvvfkb6uOcyRrvSszoYQ/JOnEZNpo6O8Jt9XIT49qczjn3HWHEHF
        PL0Jsil5vCjVj7rNnR94vyeULfDiCstL6AKf/uBCMKhA0z7bNMA7DZRwg+C/eYmY4r27wfIdkO3wX
        j/3Yx/QQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pc3wo-00Cu7b-HS; Tue, 14 Mar 2023 12:40:10 +0000
Date:   Tue, 14 Mar 2023 12:40:10 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: remove redundant check in handle_mm_fault
Message-ID: <ZBBrKl3R7YXOqUfj@casper.infradead.org>
References: <20230306024959.131468-1-haifeng.xu@shopee.com>
 <df3997ed-a844-597b-fbb1-154caad78543@redhat.com>
 <354360d5-dce6-a11c-ee61-d41e615bfa05@shopee.com>
 <ZAamFX/hq6Y/iNJb@casper.infradead.org>
 <6df72872-2829-47ab-552c-7ef8a6470e6f@shopee.com>
 <562e9cc3-d0aa-23e9-bd19-266b5aef2ae7@redhat.com>
 <b07c5e99-b251-2509-dfac-0f8e571d39d7@shopee.com>
 <70abf872-99d1-6ff4-3332-d86d320abff2@redhat.com>
 <1b21ee01-116d-d432-7308-8515510c89f2@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b21ee01-116d-d432-7308-8515510c89f2@shopee.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 06:29:24PM +0800, Haifeng Xu wrote:
> 
> 
> On 2023/3/14 17:09, David Hildenbrand wrote:
> > On 14.03.23 09:05, Haifeng Xu wrote:
> >>
> >>
> >> On 2023/3/8 17:13, David Hildenbrand wrote:
> >>> On 08.03.23 10:03, Haifeng Xu wrote:
> >>>>
> >>>>
> >>>> On 2023/3/7 10:48, Matthew Wilcox wrote:
> >>>>> On Tue, Mar 07, 2023 at 10:36:55AM +0800, Haifeng Xu wrote:
> >>>>>> On 2023/3/6 21:49, David Hildenbrand wrote:
> >>>>>>> On 06.03.23 03:49, Haifeng Xu wrote:
> >>>>>>>> mem_cgroup_oom_synchronize() has checked whether current memcg_in_oom is
> >>>>>>>> set or not, so remove the check in handle_mm_fault().
> >>>>>>>
> >>>>>>> "mem_cgroup_oom_synchronize() will returned immediately if memcg_in_oom is not set, so remove the check from handle_mm_fault()".
> >>>>>>>
> >>>>>>> However, that requires now always an indirect function call -- do we care about dropping that optimization?
> >>>>>>>
> >>>>>>>
> >>>>>>
> >>>>>> If memcg_in_oom is set, we will check it twice, one is from handle_mm_fault(), the other is from mem_cgroup_oom_synchronize(). That seems a bit redundant.
> >>>>>>
> >>>>>> if memcg_in_oom is not set, mem_cgroup_oom_synchronize() returns directly. Though it's an indirect function call, but the time spent can be negligible
> >>>>>> compare to the whole mm user falut preocess. And that won't cause stack overflow error.
> >>>>>
> >>>>> I suggest you measure it.
> >>>>
> >>>> test steps:
> >>>> 1) Run command: ./mmap_anon_test(global alloc, so the memcg_in_oom is not set)
> >>>> 2) Calculate the quotient of cost time and page-fault counts, run 10 rounds and average the results.
> >>>>
> >>>> The test result shows that whether using indirect function call or not, the time spent in user fault
> >>>> is almost the same, about 2.3ms.
> >>>
> >>> I guess most of the benchmark time is consumed by allocating fresh pages in your test (also, why exactly do you use MAP_SHARED?).
> >>>
> >>> Is 2.3ms the total time for writing to that 1GiB of memory or how did you derive that number? Posting both results would be cleaner (with more digits ;) ).
> >>>
> >>
> >> Hi Daivd, the details of test result were posted last week. Do you have any suggestions or more concerns about this change?
> > 
> > No, I guess it really doesn't matter performance wise.
> > 
> > One valid question would be: why perform this change at all? The redundancy doesn't seem to harm performance either.
> > 
> > If the change would obviously improve code readability it would be easy to justify. I'm not convinced, that is the case, but maybe for others.
> 
> Yes, this change doesn't optimize performance, just improve the code readability. 
> It seems that nobody ack this change, should I change the commit message and resend this patch?

I don't see the point of this patch.  Just drop it.
