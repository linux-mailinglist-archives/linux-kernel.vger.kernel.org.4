Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0989E6338AC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 10:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbiKVJii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 04:38:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbiKVJif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 04:38:35 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851D323147
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 01:38:34 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id k4so9821334qkj.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 01:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x38uAFscJorMy/jMt5Ffl9cD4b4+JycKmqCwz/5L1MI=;
        b=rCzaMD0KILZDbDPMG9mBCho45bW9yvf9yzT/Ocz13d9fP6zGsvRW8Wu7GtO5A3side
         5bEXjfR8WAR11jWi8xkbIp2FVLnwmSRXf8XAMsObqrDT+7peDff8sD93lnJVrd6EA5GB
         AV/x7yG1GZ9zA6lihpk3IBkAptlLLUD/IUbRlUqcNp1gtQkg6+k15xhjiLSIKJ7NCaXa
         c5+rlj+uJpx7XF0ukaVmu9soeimg8A8WYJYeg2XRQG8IEGUgMfbOCUBiQOsIyf5zXADv
         XCU42DBoC+dbdWcnKvOe4uxf5yGejJm+gB+Zrww5bgJKuraVMTqkiNKQ8n1WDYUycMQt
         uA/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x38uAFscJorMy/jMt5Ffl9cD4b4+JycKmqCwz/5L1MI=;
        b=4WdMsxAEqagHQY4i/qrv9XWrOXrO1+AZcAFOf5Esr+8MEjv6pU3kWrFro0Z/r3j0ga
         dfSA2Jx6F0aNyy2vNJ3kj1evAzCmW4Qu59KQ8ar6e9WFQ5kYn0BXCkAFD8apgeAQLwJP
         B/7wCYAzp/krba3ejezeGZ4MBvuwWz/aGJoCcfzdD+SSxGFa2Bd6I7UqlcFFA51h3J65
         M1UNZf7cQb3phvgjD3zDCAj4NOTlXBmXULSrjSkuDqzwG+63p5k/88EqKU3eQLVBIPLB
         LyVUuEEY5Ezlh5ZYwgZ5x7uRdP8B0kFF+dcsNfWbUdw1od/vpBBz1TLwavaaXXvzBvGr
         bT0w==
X-Gm-Message-State: ANoB5pkcqgQZGwzF2es6UkXed3zMP/Y2f//QHvRAn4MAWasGHpq8WQf1
        D+agwBcRmvARGkp25jJ0ezf2Bw==
X-Google-Smtp-Source: AA0mqf4XeUG0fB6cBaBGBawYLAXVq1oCYUKsukul5k6Tns4crazFs8AuP1wW+W3fBdtTbHu0U2mPGQ==
X-Received: by 2002:a37:aad6:0:b0:6fa:e0bb:cb6d with SMTP id t205-20020a37aad6000000b006fae0bbcb6dmr20436909qke.707.1669109913517;
        Tue, 22 Nov 2022 01:38:33 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id y19-20020a05620a44d300b006bbf85cad0fsm10288437qkp.20.2022.11.22.01.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 01:38:32 -0800 (PST)
Date:   Tue, 22 Nov 2022 01:38:29 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
        Zach O'Keefe <zokeefe@google.com>, Yu Zhao <yuzhao@google.com>,
        Dan Carpenter <error27@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 0/3] mm,thp,rmap: rework the use of subpages_mapcount
In-Reply-To: <c4b8485b-1f26-1a5f-bdf-c6c22611f610@google.com>
Message-ID: <a5849eca-22f1-3517-bf29-95d982242742@google.com>
References: <5f52de70-975-e94f-f141-543765736181@google.com> <c4b8485b-1f26-1a5f-bdf-c6c22611f610@google.com>
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

Andrew, please replace the 1/3, 1/3 fix, 2/3, 3/3 in mm-unstable
by these v2 three: which incorporate the uninitialized warning fix,
and adjustments according to Kirill's review comments, plus his
Acks - I couldn't quite manage them just by -fixes.
No functional change from the v1 series.

1/3 mm,thp,rmap: subpages_mapcount of PTE-mapped subpages
2/3 mm,thp,rmap: subpages_mapcount COMPOUND_MAPPED if PMD-mapped
3/3 mm,thp,rmap: clean up the end of __split_huge_pmd_locked()

 Documentation/mm/transhuge.rst |  10 +-
 include/linux/mm.h             |  67 +++++++----
 include/linux/rmap.h           |  12 +-
 mm/huge_memory.c               |  15 +--
 mm/page_alloc.c                |   2 +-
 mm/rmap.c                      | 219 ++++++++++-------------------------
 6 files changed, 124 insertions(+), 201 deletions(-)

Thanks!
Hugh
