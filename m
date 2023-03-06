Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6366AD23D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 00:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjCFXAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 18:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjCFXAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 18:00:18 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E6251F9C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 15:00:11 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536cb268ab8so117854717b3.17
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 15:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678143611;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Eg6WHRqrr+nDg1zkB4Sv+OHD2/2VAlH0scI+mVHlbQk=;
        b=qDKEgow2LiRqBuoiJsPnDGC7d/4OEen4xB133Txa71+jK0A1BUaXRMNz3BMnfWJoC7
         lY88/3+TKc+8bvgw0IDzEEyutgPSxKBxgt5LS3+wfIt91YWXnBIEU3G2sfJnA5gXSEAh
         20+xTuhnHDMOVcplgvLifuRmNEQzsrPTdTzXtyIi9XrhpnGMuoy6Ke8cIXBCPuupdCvf
         ZtT5e7LGoXJQ0DrGdu0IOrKhzoibJ/C4w1hlJjxChq/faRLkVdzOTPb9aYm7B1rW61cs
         6/h7JnENcrotwAh90gB9tKFvZgpZWxmIi+JDAFrLNWREQkdMei++CA8pg5ANE1gROqhA
         V3PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678143611;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Eg6WHRqrr+nDg1zkB4Sv+OHD2/2VAlH0scI+mVHlbQk=;
        b=08+qnOIfyvkTbSAnRSJ/3i8wLdVkPNsAnRii7kJZJUC7TSMWMOQcwOAbKd19/AI9IR
         kCjkhTP8k9FPGUE+AdY22qHZFnp3liN4EAV4YkWnUvm40KrdObQ7niKrTFwU6RZ0xJON
         c+xSwsauo1ZExint6XFoTLhzRmhVqgiMTa0qCXYtQwoUTUoY2u52VqynPMeAOMcwG1fU
         gP5wGVCby3uAWsosTHpeIMcPm8WJ/fuWI8BG9Q7fJWhyoarY01W7b+R4r0b0gX1NWpLW
         oEexH6TgK7U6foAKUBV2yq9DwTFmIPaB56IxZ05yxlDUFtByloKCl+31d6CQe2bW3gpQ
         qvlg==
X-Gm-Message-State: AO0yUKVO8USQls40JQ8TcqqSfGR6Q1IhOhNd+RhVoe8fTP/H91IuEkGU
        E4Kr40d2joLZ5lskh1xK4n4OIKLTp3a7WJSs
X-Google-Smtp-Source: AK7set+0qK6jHYvrfOqyOBwwU7OzYF/ek6KS4Yy2ZQeKk4EZKqh86bGpn7pvR5e6UNfXH8U2eZKK8KXde4kDH3qT
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a05:6902:10e:b0:98e:6280:74ca with SMTP
 id o14-20020a056902010e00b0098e628074camr5337509ybh.1.1678143611042; Mon, 06
 Mar 2023 15:00:11 -0800 (PST)
Date:   Mon,  6 Mar 2023 23:00:02 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230306230004.1387007-1-jthoughton@google.com>
Subject: [PATCH 0/2] mm: rmap: merge HugeTLB mapcount logic with THPs
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HugeTLB pages may soon support being mapped with PTEs. To allow for this
case, merge HugeTLB's mapcount scheme with THP's.

The first patch of this series comes from the HugeTLB high-granularity
mapping series[1], though with some updates, as the original version
was buggy[2] and incomplete.

I am sending this change as part of this smaller series in hopes that it
can be more thoroughly scrutinized.

I haven't run any THP performance tests with this series applied.
HugeTLB pages don't currently support being mapped with
`compound=false`, but this mapcount scheme will make collapsing
compound=false mappings in HugeTLB pages quite slow. This can be
optimized with future patches (likely by taking advantage of HugeTLB's
alignment guarantees).

Matthew Wilcox is working on a mapcounting scheme[3] that will avoid
the use of each subpage's mapcount. If this series is applied, Matthew's
new scheme will automatically apply to HugeTLB pages.

[1]: https://lore.kernel.org/linux-mm/20230218002819.1486479-6-jthoughton@google.com/
[2]: https://lore.kernel.org/linux-mm/CACw3F538H+bYcvSY-qG4-gmrgGPRBgTScDzrX9suLyp_q+v_bQ@mail.gmail.com/
[3]: https://lore.kernel.org/linux-mm/Y9Afwds%2FJl39UjEp@casper.infradead.org/

James Houghton (2):
  mm: rmap: make hugetlb pages participate in _nr_pages_mapped
  mm: rmap: increase COMPOUND_MAPPED to support 512G HugeTLB pages

 include/linux/mm.h |  7 +------
 mm/hugetlb.c       |  4 ++--
 mm/internal.h      |  9 ++++-----
 mm/migrate.c       |  2 +-
 mm/rmap.c          | 35 ++++++++++++++++++++---------------
 5 files changed, 28 insertions(+), 29 deletions(-)


base-commit: 9caa15b8a49949342bdf495bd47660267a3bd371
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

