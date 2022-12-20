Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEA0652277
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbiLTO0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbiLTO0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:26:11 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BA1323
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 06:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1671546341; bh=ocdMdN7aEukCgNOvKCL1W/7c1n4xooH9oWX7X7O+9ak=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=l1PgyQg/4arUTt0mAgJ10WbsIiwWHvd0ZrJHsbXkcIB0xKLObamq1xsuAGDc75zbP
         lIZXuTZfP/mfc7rC6G13Kc4g9Flw11LORFK6l9+oj6l6MYkxMcB8tNXqaUti1lfLT9
         ndCZVUIew/ZK4W7KyopKYQRP5et/oIvjvCSeIwKE=
Received: by b-5.in.mailobj.net [192.168.90.15] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Tue, 20 Dec 2022 15:25:41 +0100 (CET)
X-EA-Auth: LE+8xCnx1iNwbhLYvZp7EU7RNbGwdu2L+4eniJiGWquz5sL9G98+IX8GwLepM7zVR20NCngc7VtGoFwZFxWZjewJfBbtndOl
Date:   Tue, 20 Dec 2022 19:55:36 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Julia Lawall <julia.lawall@inria.fr>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: kvzalloc vs kvcalloc
Message-ID: <Y6HF4BVXaTPpNmBs@qemulion>
References: <Y6FJhxO8R6W0ykaB@qemulion>
 <alpine.DEB.2.22.394.2212200707250.3070@hadrien>
 <Y6FTDAHxw6ws42Cf@qemulion>
 <da83b74f-7f77-b267-6b12-7afce3ee761e@inria.fr>
 <Y6FoAOXAkrr4n7Mp@qemulion>
 <26b8353-dd33-1a57-d7b5-dc6a8583219@inria.fr>
 <dbf47e34-9d28-439c-e4fe-34aa9cc41ee3@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbf47e34-9d28-439c-e4fe-34aa9cc41ee3@embeddedor.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 08:13:19AM -0600, Gustavo A. R. Silva wrote:
>
>
> On 12/20/22 01:48, Julia Lawall wrote:
> >
> >
> > On Tue, 20 Dec 2022, Deepak R Varma wrote:
> >
> > > On Tue, Dec 20, 2022 at 08:39:09AM +0100, Julia Lawall wrote:
> > > >
> > > >
> > > > On Tue, 20 Dec 2022, Deepak R Varma wrote:
> > > >
> > > > > On Tue, Dec 20, 2022 at 07:08:24AM +0100, Julia Lawall wrote:
> > > > > >
> > > > > >
> > > > > > On Tue, 20 Dec 2022, Deepak R Varma wrote:
> > > > > >
> > > > > > > Hello Gustavo and Julia,
> > > > > > > I was working on building a patch proposal using the kvmalloc.cocci file for a
> > > > > > > driver. The recommendation from the semantic patch is to use kvzalloc instead of
> > > > > > > a fallback memory allocation model. Please see my patch submitted here [1].
> > > > > > >
> > > > > > > I also found another patch submitted by Gustavo [2] which suggests using
> > > > > > > kvcalloc instead of kvzalloc. Unfortunately, I was not able to understand the
> > > > > > > reasons/advantages using kvcalloc over kvzalloc.
>
> Look for the definitions of those functions and try to understand their differences.
> In many cases you have go down the rabbit hole, but you should be able to get a good
> grasp of the thing in question before hitting the bottom. :)
>
> Look for a couple of instances in the codebase where those functions are being used
> and try to understand a bit of the context around them. In some cases reading the
> commit logs is necessary.

Hello Gustavo,
Thank you very much for the suggestion here. I will get deeper into the codebase
and try to self learn. Your advise on reading the past commit logs is useful as
well.

Thank you again!

./drv

>
> > > > > >
> > > > > > The calloc variants are for zeroed arrays.  zalloc variants just zero.
> > > > >
> > > > > Thank you Julia and sorry to have missed the references in my email:
> > > >
> > > > In Gustavo's case, the array has a certain number of elements of a certain
> > > > size.  I don't know if you have both pieces of information in your case.
> > > > calloc functions take them in separately, and do the multiplication in a
> > > > way that checks for overflows.
> > >
> > > That is correct and I do have both the pieces, the size and number. This
> > > actually further optimizes the code. We can eliminate the array_size variable
> > > with the kvcalloc implementation. It is not used beyond the memory allocation.
> > >
> > > Please this code snip:
> > >
> > > 	853          int count = size >> PAGE_SHIFT;
> > > 	   1         int array_size = count * sizeof(struct page *);
> > > 	   2         int i = 0;
> > > 	   3         int order_idx = 0;
> > > 	   4
> > > 	   5         pages = kvzalloc(array_size, GFP_KERNEL);
> > > 	   6         if (!pages)
> > > 	   7                 return NULL;
> > >
> > > Thank you for your advise. I will wait to see Gustavo has any further guidance.
> > > I will send in a revision to my patch accordingly.
> >
> > Great.  A calloc function definitely looks like a good choice here.
>
> As Julia suggested, and as you may had realized already, the calloc function is the
> way to go, in this case.
>
> --
> Gustavo
>
>


