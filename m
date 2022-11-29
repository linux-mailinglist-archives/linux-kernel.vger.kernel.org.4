Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5DB63CA78
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 22:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237054AbiK2V0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 16:26:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236072AbiK2V0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 16:26:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3D52873C
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 13:26:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59D5A6193C
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 21:26:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F43C433C1;
        Tue, 29 Nov 2022 21:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1669757180;
        bh=6ALCXb/pWvuaPqQbiW6kDLBf8N7JSNk2pLYAG27FG00=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EAQhfAtlgmpzYOMolrZDszRgzQkfuSrbi4HidyAWyZd8JUBq3EgRk9XzxH8xx6xCY
         8NQl2KvQiG39KDECQsim0NJ5h9TQTh+XgCVzxWOJ/kb6Ek9zZ79sAOMzsyfM3c3E3W
         gX9/OAPT369m8Vpe+d/Kww1WyJaL3l2Wl8oqD/Xo=
Date:   Tue, 29 Nov 2022 13:26:19 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 00/10] mm/hugetlb: Make huge_pte_offset() thread-safe
 for pmd unshare
Message-Id: <20221129132619.f982806393c607fc20c9cb34@linux-foundation.org>
In-Reply-To: <Y4Z3eKU/hYFOyGnU@x1n>
References: <20221129193526.3588187-1-peterx@redhat.com>
        <20221129124944.8eff54cda65d0f5a8a089e22@linux-foundation.org>
        <Y4Z3eKU/hYFOyGnU@x1n>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Nov 2022 16:19:52 -0500 Peter Xu <peterx@redhat.com> wrote:

> On Tue, Nov 29, 2022 at 12:49:44PM -0800, Andrew Morton wrote:
> > On Tue, 29 Nov 2022 14:35:16 -0500 Peter Xu <peterx@redhat.com> wrote:
> > 
> > > Based on latest mm-unstable (9ed079378408).
> > > 
> > > This can be seen as a follow-up series to Mike's recent hugetlb vma lock
> > > series for pmd unsharing, but majorly covering safe use of huge_pte_offset.
> > 
> > We're at -rc7 (a -rc8 appears probable this time) and I'm looking to
> > settle down and stabilize things...
> 
> I targeted this series for the next release not current, because there's no
> known report for it per my knowledge.
> 
> The reproducer needs explicit kernel delays to trigger as mentioned in the
> cover letter.  So far I didn't try to reproduce with a generic kernel yet
> but just to verify the existance of the problem.

OK, thanks, I missed that.

I'll give the series a run in -next for a couple of days then I'll pull
it out until after the next Linus merge window, so it can't invalidate
testing heading into that merge window.
