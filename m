Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF21F7476A5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 18:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjGDQ2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 12:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbjGDQ2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 12:28:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2E5E7A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 09:28:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB45C612F5
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 16:28:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B52AC433C9;
        Tue,  4 Jul 2023 16:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1688488122;
        bh=Gy8FgsQVK/jYScLhhq0egPzRmFR+KS5pw20GUgHA3bY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0XQ4oeyjCyautIiwSTe5EC/yMfZSt2h+C+Sbss8KdTUnR/ha0TRvc3hZybNOYhepx
         vlUOIBve68EImeRtRCQsKw8nZkpRVZ4e5L4p7t/A99AezxQBWgGawT36jTypLPp6R6
         RJupaePm4n27hfh3rK+poyA7//My622wkShIs5JI=
Date:   Tue, 4 Jul 2023 09:28:41 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH] bootmem: remove the vmemmap pages from kmemleak in
 free_bootmem_page
Message-Id: <20230704092841.2e71a21ee1149ec662c73744@linux-foundation.org>
In-Reply-To: <20230704101942.2819426-1-liushixin2@huawei.com>
References: <20230704101942.2819426-1-liushixin2@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jul 2023 18:19:42 +0800 Liu Shixin <liushixin2@huawei.com> wrote:

> commit dd0ff4d12dd2 ("bootmem: remove the vmemmap pages from kmemleak in
> put_page_bootmem") fix an overlaps existing problem of kmemleak. But the
> problem still existed when HAVE_BOOTMEM_INFO_NODE is disabled, because in
> this case, free_bootmem_page() will call free_reserved_page() directly.

So I take it that with CONFIG_HAVE_BOOTMEM_INFO_NODE=n, the issue
described in dd0ff4d12dd2 still occurs?  That kmemleak reports an error
and stops working?

So we want a cc:stable on this fix, yes?

> Fix the problem by adding kmemleak_free_part() in free_bootmem_page()
> when HAVE_BOOTMEM_INFO_NODE is disabled.
> 
> Fixes: f41f2ed43ca5 ("mm: hugetlb: free the vmemmap pages associated with each HugeTLB page")
> ...
