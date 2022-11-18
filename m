Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90DDD62FFFF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 23:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbiKRWY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 17:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbiKRWYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 17:24:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196926161
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 14:23:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC8226279B
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 22:23:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F670C433C1;
        Fri, 18 Nov 2022 22:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1668810209;
        bh=/+L2NYj/ACH+jT7u7xIw5FkfzhmRB+rhl1d5bnP9ndQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WOu/knYnjG874+QGB6O6mc5DoO1bffTgpJ7knUlNeNZYm2uJpJmcH7/iJT4HSHckE
         dirOBSs+Ct5loDn2H9J9YxTOscXrpO5Y9SUqL9liqBR6Fk9CI1076Q9tHWST71XUJw
         VQcIV0zN+NPXlK/FhQ5Iik1CGlvDvasJGk1pfrOI=
Date:   Fri, 18 Nov 2022 14:23:27 -0800
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
Message-Id: <20221118142327.1744cda179ca549eeebc8629@linux-foundation.org>
In-Reply-To: <a4a1cda4-547b-8274-8645-fa6ff274e42@google.com>
References: <5f52de70-975-e94f-f141-543765736181@google.com>
        <c4b8485b-1f26-1a5f-bdf-c6c22611f610@google.com>
        <CAHk-=whmq5gHrKmD3j=7nB=n9OmmLb5j1qmoQPHw1=VSQ-V=hg@mail.gmail.com>
        <93fa81ae-d848-58c2-9f70-27446bf9baa8@google.com>
        <20221118140346.b9026301b4ba03e43e15aeca@linux-foundation.org>
        <a4a1cda4-547b-8274-8645-fa6ff274e42@google.com>
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

On Fri, 18 Nov 2022 14:10:32 -0800 (PST) Hugh Dickins <hughd@google.com> wrote:

> On Fri, 18 Nov 2022, Andrew Morton wrote:
> > On Fri, 18 Nov 2022 12:51:09 -0800 (PST) Hugh Dickins <hughd@google.com> wrote:
> > 
> > > But the first series has not yet graduated from mm-unstable,
> > > so if Andrew and/or Kirill also prefer to have them combined into one
> > > bit_spin_lock-less series, that I can do.  (And the end result should be
> > > identical, so would not complicate Johannes's lock_page_memcg() excision.)
> > 
> > I'd prefer that approach.
> 
> I think you're saying that you prefer the other approach, to keep the
> two series separate (second immediately after the first, or not, doesn't
> matter), rather than combined into one bit_spin_lock-less series.
> Please clarify! Thanks,

Yes, two separate series.   Apologies for the confuddling.
