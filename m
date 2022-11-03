Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789C36173D8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 02:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiKCBpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 21:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiKCBpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 21:45:09 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A718912616
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 18:45:08 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id c15so452857qtw.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 18:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Wf7K6DzyqqBjFrezQMeybffBuwbwWuOxP9c2dDDBwRA=;
        b=INoLVtvkga2hOnf6CXSVVi7qkOYjUtycEaLZOhN97m6SDyqXTmXB4AfnKKFeD9FTar
         wMDzfWicgjZyRiQMU0f7JMvKfE8CDGgy75IXPLKh5/Xa1WAcJauS7opadb3GTpAVhzzk
         KagULt7kZz+MSzr1+/1Umnz8A1C068b3SKH4MMzEzO0iY6e6nlIgti16PAMzQOgZjv0z
         pQc105MhQhS2Ukc1xrJKcNKPW2KCM4/Met1So6rs4v58FOUG56toyZrs+alPsSBNXYxx
         3m9dVPfRCjlbP8nXudsQxnSsI7vJYoVbXAn2ehpYrSya5ROpDrMbmwOs9Z+2kSZUdUdl
         OcUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wf7K6DzyqqBjFrezQMeybffBuwbwWuOxP9c2dDDBwRA=;
        b=FM1NEGVaP4o3fBzzh5RwVmBn1VxQAkcEF2qzDwqhGmLwYiOXokoaAXLubiWIzMahEx
         4/IesZs/faINK7pll46ZhI7SDDfG+fU2XMRMXo48SAVZi1HKv+0lTGajxyzTITcQD/ro
         aFhgYrwL3lLqjcCOCHOKuvCnxWfjZv/hJlzlrJwEdci39v8ziEHC4xF81jSNPJom3vyP
         ByQYZJWe962W6hNU4vKwN+P4zKmh0NLQSaEbELERGhXbEar2JglhPpAdTYuLWmHRYQPK
         Dhv1b6MH/hS1jU/xIq+b0I3jSYnS63e6uDhP6su74c1KbZ8PqS2jmtmht16pZpu6RW25
         aNxA==
X-Gm-Message-State: ACrzQf1DeO63W8/VJWc9Qy+++dWj6wAFcl6rwnqtHhvjVVJMUTsULxg/
        eIXUt3wzrsn5Wd5PX1zmOPGBYw==
X-Google-Smtp-Source: AMsMyM5fS44QwhRBsL6UbFlEOiI89VgJCALTzt6SQxOeXhsODaGtGfa8+4FGBHJaR+CDeqH38mhr0g==
X-Received: by 2002:ac8:4f57:0:b0:3a5:5191:b34b with SMTP id i23-20020ac84f57000000b003a55191b34bmr701662qtw.111.1667439907713;
        Wed, 02 Nov 2022 18:45:07 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id bk20-20020a05620a1a1400b006f3e6933bacsm9777239qkb.113.2022.11.02.18.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 18:45:06 -0700 (PDT)
Date:   Wed, 2 Nov 2022 18:44:53 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
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
        Zach O'Keefe <zokeefe@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 0/3] mm,huge,rmap: unify and speed up compound mapcounts
Message-ID: <5f52de70-975-e94f-f141-543765736181@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I had intended to send just a self-explanatory 1/2 and 2/2 against
6.1-rc3 on Monday; but checked for clashes with linux-next (mainly
mm-unstable) just before sending, and fuzz in mm_types.h revealed
not just a clash with Sidhartha's series, but also that I had missed
the hugetlb usage of tail page->private, problematic for me on 32-bit.

So that series was slightly broken; and although it would probably
have been easy to fix with a "SUBPAGE_INDEX_SUBPOOL = 2" patch,
that would not have moved us forward very well.  So this series is
against next-20221102 (and hopefully later nexts), with a preparatory
1/3 to rejig the hugetlb tail private usage, on top of Sidhartha's.

1/3 mm,hugetlb: use folio fields in second tail page
2/3 mm,thp,rmap: simplify compound page mapcount handling
3/3 mm,thp,rmap: lock_compound_mapcounts() on THP mapcounts

2/3 and 3/3 can almost be applied cleanly to 6.1-rc3 (okay when
you are on 64-bit): just a couple of easily resolved rejects.

 Documentation/mm/transhuge.rst |  34 +---
 include/linux/hugetlb.h        |  23 +--
 include/linux/hugetlb_cgroup.h |  31 +--
 include/linux/mm.h             |  85 ++++++---
 include/linux/mm_types.h       |  91 ++++++---
 include/linux/page-flags.h     |  21 --
 include/linux/rmap.h           |  12 +-
 mm/Kconfig                     |   2 +-
 mm/debug.c                     |   5 +-
 mm/folio-compat.c              |   6 -
 mm/huge_memory.c               |  37 +---
 mm/hugetlb.c                   |   2 +
 mm/khugepaged.c                |  11 +-
 mm/memory-failure.c            |   5 +-
 mm/page_alloc.c                |  27 +--
 mm/rmap.c                      | 359 ++++++++++++++++++++---------------
 mm/util.c                      |  79 --------
 17 files changed, 401 insertions(+), 429 deletions(-)

Hugh
