Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB61659317
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 00:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbiL2XRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 18:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiL2XRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 18:17:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4775A164B6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 15:17:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A41DB818ED
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 23:17:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63EADC433D2;
        Thu, 29 Dec 2022 23:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1672355827;
        bh=ntp6Zg5YrqsIy7GSl2YlNqdgGRLR05iroF0aBVjW5fY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dGIvhk7nSSufiC2CMb6F6lPTh60ro7Wm1DhEehS8dr/MJgdBqRTJJ0NOXwFyNlEBt
         gXApnNxmt+tzZIkIbNgW4wo6ugeifDGD/UWOStD/7moKIUCzvErWNnQ5LFsg9CFKfx
         nu3toit0lkCrr1kyDtdgpFtpNsI4m2Gpr64p2sm0=
Date:   Thu, 29 Dec 2022 15:17:06 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 2/3] mm: vmalloc: Switch to find_unlink_vmap_area()
 in vm_unmap_ram()
Message-Id: <20221229151706.da16baab4cb6c2bc30e3061a@linux-foundation.org>
In-Reply-To: <Y62Mb8NtZQkTmlfV@pc636>
References: <20221222190022.134380-1-urezki@gmail.com>
        <20221222190022.134380-2-urezki@gmail.com>
        <Y6VlA8Mbbv7Ug6tW@infradead.org>
        <Y6XaTM+xSlGNjo0e@pc636>
        <20221228154707.432e8900855122712f98037c@linux-foundation.org>
        <Y62Mb8NtZQkTmlfV@pc636>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Dec 2022 13:47:43 +0100 Uladzislau Rezki <urezki@gmail.com> wrote:

> [2]
> commit 8a85ea97b35924ee39d51e00ecb3f6d07f748a36
> Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Date:   Wed Dec 21 18:44:53 2022 +0100
> 
>     mm: vmalloc: switch to find_unlink_vmap_area() in vm_unmap_ram()
> 
> [3]
> commit a7c84c673c71cdfad20fe25e5d2051ed229859f7
> Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Date:   Wed Dec 21 18:44:52 2022 +0100
> 
>     mm: vmalloc: avoid calling __find_vmap_area() twise in __vunmap()
> <snip>
> 
> It would be good if you could fold [2] into [3] making it as one
> patch. The problem is that, if we leave it as it is, the bisection
> mechanism would consider [3] as a buggy patch, because it is not
> fully accomplished and depends on [2].
> 
> Is that OK for you, i mean to squash on your own? 

I did that.  I updated the "mm: vmalloc: avoid calling
__find_vmap_area() twice in __vunmap()" accordingly, thanks.

