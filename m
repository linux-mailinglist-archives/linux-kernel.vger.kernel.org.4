Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0C66AAD74
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 00:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjCDXVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 18:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCDXVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 18:21:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48EA1113FB;
        Sat,  4 Mar 2023 15:21:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53D5BB8085C;
        Sat,  4 Mar 2023 23:21:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F0CC433EF;
        Sat,  4 Mar 2023 23:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1677972060;
        bh=YpOQ8oryHFElt6K2lv1s9uR3pjCugGSDXwduZIz+uYs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V70rQ0s2Qm2ej6zbgltA2RufuWvBRV9Ayj4zAZYVcHrdb/Bn+PW3LafZ0GC4isuxZ
         E/YE8SeNl9MOKCQg82KJJtI751TWD3J4enIggJZqGgUcPyQTkY6Y7uXzr+y1lWQTAq
         +0LGnO92BttDVnyIL9kS9MSztAzklqk3l/wwZa5E=
Date:   Sat, 4 Mar 2023 15:20:58 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Huang, Ying" <ying.huang@intel.com>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] hotfixes for 6.3-rc1
Message-Id: <20230304152058.de91bf7abf424383ce31d500@linux-foundation.org>
In-Reply-To: <CAHk-=wj9guryjifHyr26w73ta+kNeoHtGde682Z5N6OSjKu4UQ@mail.gmail.com>
References: <20230304131528.4645d19a2ab897fb7518159e@linux-foundation.org>
        <CAHk-=wj9guryjifHyr26w73ta+kNeoHtGde682Z5N6OSjKu4UQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Mar 2023 14:35:00 -0800 Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sat, Mar 4, 2023 at 1:15 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > 17 hotfixes.  Eight are for MM and seven are for other parts of the
> > kernel.  Seven are cc:stable and eight address post-6.3 issues or were
> > judged unsuitable for -stable backporting.
> 
> Hmm. Since this pull didn't fix the gcc note about playing pointer
> games that I get for my allmodconfig test build, and since I _really_
> don't want to have an rc1 release tomorrow with that (valid) warning,
> I fixed it up myself.

Ah. Ying did it this way:


From: Huang Ying <ying.huang@intel.com>
Subject: migrate_pages: silence gcc notes for mis-casting
Date: Thu, 2 Mar 2023 09:26:10 +0800

The following GCC notes was reported for commit 64c8902ed441
("migrate_pages: split unmap_and_move() to _unmap() and _move()").

    mm/migrate.c: In function `__migrate_folio_extract':
    mm/migrate.c:1050:20: note: randstruct: casting between randomized
structure pointer types (ssa): `struct anon_vma' and `struct
address_space'

     1050 |         *anon_vmap = (void *)dst->mapping;
          |         ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~

The casting itself is safe.  Because we only use dst->mapping to store the
pointer itself temporarily and dst is a newly allocated folio and not used
by anyone else during that.  But the notes should be silenced and some
comments are deserved.  So, we do that in this patch.

Link: https://lkml.kernel.org/r/20230302012610.17055-1-ying.huang@intel.com
Fixes: 64c8902ed441 ("migrate_pages: split unmap_and_move() to _unmap() and _move()")
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Xin Hao <xhao@linux.alibaba.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Bharata B Rao <bharata@amd.com>
Cc: Alistair Popple <apopple@nvidia.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---


--- a/mm/migrate.c~migrate_pages-silence-gcc-notes-for-mis-casting
+++ a/mm/migrate.c
@@ -1047,7 +1047,16 @@ static void __migrate_folio_extract(stru
 				   int *page_was_mappedp,
 				   struct anon_vma **anon_vmap)
 {
-	*anon_vmap = (void *)dst->mapping;
+	struct anon_vma *anon_vma;
+
+	/*
+	 * 2 steps assignment to silence gcc notes for mis-casting. The
+	 * casting is safe.  Because we only use dst->mapping to store
+	 * the pointer itself temporarily and dst is a newly allocated
+	 * folio and not used by anyone else during that.
+	 */
+	anon_vma = (void *)dst->mapping;
+	*anon_vmap = anon_vma;
 	*page_was_mappedp = (unsigned long)dst->private;
 	dst->mapping = NULL;
 	dst->private = NULL;
_

