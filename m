Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A373F66A5C5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 23:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjAMWQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 17:16:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjAMWQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 17:16:13 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCD412AAB
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 14:16:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 67CCECE21AB
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 22:16:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D95C433EF;
        Fri, 13 Jan 2023 22:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673648168;
        bh=jNFq9DR9fflrZIbqu8UmHOJl+ac80dvlW2mJLqpUET4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oqxOPvncCYYsHc2zoO8qCejMi3nRQFIbfpDIa0vowBMc1z+WNsSPyP1juY/HY3PRP
         ZPjbfPYCVLMJm4bRRMCDuw0cFUjCjZkPmEDFaSlXOJNM/vAtzA19kLuI3qGD2wFU4i
         hUzXOMeH8J7AlDK6lMa7w5L4/Aczug++BKLkPBczDxZ8G8oz0e+oNHY7DbR3cUyEtS
         TM+EHsdsOIQ1ma5J5zGc3Oqzx5CMWZPosWDsHjak8H75aKgX3sG+heb83p9SQ7yY2/
         97PJjRCcUKoUdqnUFfK2B2nCg0lGT0dblNd0aCA+BCp87j5T/N5cCdoCFEQF83T92J
         6uGeJENIJXqoA==
From:   SeongJae Park <sj@kernel.org>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        akpm@linux-foundation.org, willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH -next 5/7] mm: memory: convert wp_page_copy() to use folios
Date:   Fri, 13 Jan 2023 22:16:06 +0000
Message-Id: <20230113221606.1370-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <Y8GrLtwBYSAoxhQl@lucifer>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, 13 Jan 2023 19:04:14 +0000 Lorenzo Stoakes <lstoakes@gmail.com> wrote:

> On Fri, Jan 13, 2023 at 02:08:36PM +0100, David Hildenbrand wrote:
> > On 13.01.23 14:01, Marek Szyprowski wrote:
> > > Hi
> > >
> > > On 12.01.2023 09:30, Kefeng Wang wrote:
> > > > The old_page/new_page are converted to old_folio/new_folio in
> > > > wp_page_copy(), then replaced related page functions to folio
> > > > functions.
> > > >
> > > > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> > >
> > > This patch, merged into today's linux-next as commit 9ebae00c8e30 ("mm:
> > > memory: convert wp_page_copy() to use folios"), causes serious stability
> > > issues on my ARM based test boards. Here is the example of such crash:
> >
> > syzbot is also not happy:
> >
> > https://lkml.kernel.org/r/000000000000807c7805f2205df1@google.com
> >
> > --
> > Thanks,
> >
> > David / dhildenb
> >
> 
> This also completely broke my qemu environment.

Same to me.

> 
> In that thread Willy points out that the issue stems from blindly assigning
> page_folio(old_page) to old_folio without checking whether it is NULL first,
> therefore triggering a NULL pointer deref.
> 
> A quick fix would be to put in a check (as shown below) which fixes the issue,
> but as Willy said, I think we should drop this until it can be fixed in a
> respin.
> 
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3044,7 +3044,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
>         struct vm_area_struct *vma = vmf->vma;
>         struct mm_struct *mm = vma->vm_mm;
>         struct page *old_page = vmf->page;
> -       struct folio *old_folio = page_folio(old_page);
> +       struct folio *old_folio = old_page ? page_folio(old_page) : NULL;

Tested-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ
