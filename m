Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A3F62FFAA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 23:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbiKRWDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 17:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiKRWDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 17:03:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83F1A47E
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 14:03:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EA1862795
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 22:03:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16EA4C433D7;
        Fri, 18 Nov 2022 22:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1668809027;
        bh=Pco2YjgEBDyx9sLHVv3YyKsE4hBsiTHYZPbSeBfoGyQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cWzvVesP4m48eul00BhFVUlNrLgvvD5C8+iW4OwhJugeFob+SxC2SG8+SYDjix3NC
         Xl6rTkHcRu/Klbh4vCLQY1+fuqsG5mzXbtWTKkVFRzws0MGR5k6nolS9xB7Ikz3cWh
         1LNODQ5qGAc5b6wkCmRfQwwJd26A+WHwWjMzm7wM=
Date:   Fri, 18 Nov 2022 14:03:46 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, Peter Xu <peterx@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Mina Almasry <almasrymina@google.com>,
        James Houghton <jthoughton@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 0/3] mm,thp,rmap: rework the use of subpages_mapcount
Message-Id: <20221118140346.b9026301b4ba03e43e15aeca@linux-foundation.org>
In-Reply-To: <93fa81ae-d848-58c2-9f70-27446bf9baa8@google.com>
References: <5f52de70-975-e94f-f141-543765736181@google.com>
        <c4b8485b-1f26-1a5f-bdf-c6c22611f610@google.com>
        <CAHk-=whmq5gHrKmD3j=7nB=n9OmmLb5j1qmoQPHw1=VSQ-V=hg@mail.gmail.com>
        <93fa81ae-d848-58c2-9f70-27446bf9baa8@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Nov 2022 12:51:09 -0800 (PST) Hugh Dickins <hughd@google.com> wrote:

> But the first series has not yet graduated from mm-unstable,
> so if Andrew and/or Kirill also prefer to have them combined into one
> bit_spin_lock-less series, that I can do.  (And the end result should be
> identical, so would not complicate Johannes's lock_page_memcg() excision.)

I'd prefer that approach.  It's -rc5 and the earlier "mm,huge,rmap:
unify and speed up compound mapcounts" series has had some testing. 
I'd prefer not to toss it all out and start again.

