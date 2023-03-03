Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36986AA4CB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 23:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjCCWyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 17:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbjCCWx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 17:53:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414C3CA1E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 14:53:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8DA98B81928
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 22:53:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D071CC433D2;
        Fri,  3 Mar 2023 22:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1677883979;
        bh=MaBBLQHFLpcwWDV9KeH/SPbJ3duagmQxqkkADuevkSw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wMOpck3M+IldQq9RC0s8DweCBKhwjBcQh3A3LTHWGvMAel9o2UxQVdzCjiQP8CLyy
         nEXMKTW8YkpfEm4DFrXkRKPg6r3mo6GXVD7Eb3uzseyAADZT5oPbJkyvKg5xmNMErC
         ccRabcn/xohdH4FMPkYkTuuTRhGwVgRiD1PasIdk=
Date:   Fri, 3 Mar 2023 14:52:58 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     David Stevens <stevensd@chromium.org>, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        Zach O'Keefe <zokeefe@google.com>
Subject: Re: [PATCH v4 0/3] mm/khugepaged: fix khugepaged+shmem races
Message-Id: <20230303145258.866b985b21b3ccd9bc41bc4b@linux-foundation.org>
In-Reply-To: <ZAIT2YI4WrzZK5NK@x1n>
References: <20230217085439.2826375-1-stevensd@google.com>
        <ZAIT2YI4WrzZK5NK@x1n>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Mar 2023 10:35:53 -0500 Peter Xu <peterx@redhat.com> wrote:

> On Fri, Feb 17, 2023 at 05:54:36PM +0900, David Stevens wrote:
> > From: David Stevens <stevensd@chromium.org>
> > 
> > Fix two races in khugepaged+shmem that cause issues with userfaultfd and
> > lseek, respectively.
> > 
> > v3 -> v4:
> >  - Base changes on mm-everything (fba720cb4dc0)
> >  - Add patch to refactor error handling control flow in collapse_file
> >  - Rebase userfaultfd patch with no significant logic changes
> >  - Different approach for fixing lseek race
> 
> I just noticed this one hasn't landed unstable, so I guess I just posted a
> trivial cleanup that can conflict with this so it won't apply cleanly..
> 
> https://lore.kernel.org/r/20230303151218.311015-1-peterx@redhat.com
> 
> The resolution will be fairly straightforward though, and I'm happy to
> rebase that one to this since this targets a real bug so should have higher
> priority.

Even without the above patch ("mm/khugepaged: Cleanup memcg uncharge
for failure path") I'm seeing a big reject in khugepaged.c.  Might be
easily fixed, didn't look.

> I guess it's possible Andrew thought the series has unsettled comment so
> Andrew could just have ignored that whole set in the mark ups.  A repost
> could possibly clarify that.

Yes please.  Lets gather the acks thus far, rebase on
git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm's mm-unstable
branch and resend?

> Again, it'll always great to get another eye on this slightly involved
> series. Matthew / Yang were already on the list, also copying Zach for his
> recent works on khugepaged just in case he spots anything wrong.

