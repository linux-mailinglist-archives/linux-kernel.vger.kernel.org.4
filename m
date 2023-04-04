Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602836D5FCC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 14:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbjDDMB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 08:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234438AbjDDMB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 08:01:26 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1360E198C
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 05:01:25 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id q20so10148416pfs.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 05:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680609684;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JFM6Zed11abmlBVD7n880cLrXrOUp4BMMkatUFd1HS4=;
        b=C3IHbT9a4dE1N/jaGCLtN3lKrMYD4nnS5UX6sAc6hfVHSVColH2cqvozCtO13/mbsu
         juY/nqUHLi/YDIQDqQioRnAZpFo64dTqxG7SxjbkPxUMfUc2I170GQlfhNqcR8l+zudk
         lfooWs7aODyvSG5du4yamkq9tEFjfIyyLmkW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680609684;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JFM6Zed11abmlBVD7n880cLrXrOUp4BMMkatUFd1HS4=;
        b=8KS2DCGQ7GsIXkblZyJayztfahQZkVZWLNq3o+TnlKdcb5ja0GHIiKqdpQr1WE6/oU
         pSe9G+8ckEf8GACF2n8VESte16OKa38XzWbENdtsh/Le2XFO1xWrjhChw/k+d+kwACRB
         Xsx+hN+K5Gr7350DyLJo1Ll6uUxzpnsabnskJz6Qeum6lLZivn35wog2ryJlY1uOQ7eZ
         ybPVup51U5CFTwxMZ8nhHDCiZ6PuM5bt17OSz8mEbZo7cvvqsH0VQ8peg78X9nzBWSSn
         ctBdwbii4P099t4qXese5DrSe35OEIHzoBHdkAeBT7GXUNaoLC72q1iefKF4X2emN6Fl
         N59w==
X-Gm-Message-State: AAQBX9d0qaECjZDj98z1g7DJ0z/b6MWGkuL8/oAZjTZLFgfXoyGkQ50B
        oo20vXssdAof+lLSaxv+r/2Ctw==
X-Google-Smtp-Source: AKy350ZCcY3HX/mt7wXQZeGj97V6L7bBWjmnqXMIXPCVdC61pts3cVJwKCkX/w34d5NYlLxrb5OLyg==
X-Received: by 2002:aa7:9a0c:0:b0:627:e342:7f0e with SMTP id w12-20020aa79a0c000000b00627e3427f0emr2078573pfj.30.1680609684479;
        Tue, 04 Apr 2023 05:01:24 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:959b:21ea:166b:c273])
        by smtp.gmail.com with UTF8SMTPSA id a5-20020aa78645000000b00627f054a3cdsm8688028pfo.31.2023.04.04.05.01.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 05:01:24 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     linux-mm@kvack.org, Peter Xu <peterx@redhat.com>,
        Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-kernel@vger.kernel.org,
        David Stevens <stevensd@chromium.org>
Subject: [PATCH v6 0/4] mm/khugepaged: fixes for khugepaged+shmem
Date:   Tue,  4 Apr 2023 21:01:13 +0900
Message-Id: <20230404120117.2562166-1-stevensd@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Stevens <stevensd@chromium.org>

This series reworks collapse_file so that the intermediate state of the
collapse does not leak out of collapse_file. Although this makes
collapse_file a bit more complicated, it means that the rest of the
kernel doesn't have to deal with the unusual state. This directly fixes
races with both lseek and mincore.

This series also fixes the fact that khugepaged completely breaks
userfaultfd+shmem. The rework of collapse_file provides a convenient
place to check for registered userfaultfds without making the shmem
userfaultfd implementation care about khugepaged.

Finally, this series adds a lru_add_drain after swapping in shmem pages,
which makes the subsequent folio_isolate_lru significantly more likely
to succeed.

v5 -> v6:
 - Stop freezing the old pages so that we don't deadlock with
   mc_handle_file_pte and mincore.
 - Add missing locking around shmem charge rollback.
 - Rebase on mm-unstable (f01f73d64cb5). Beyond straightfoward
   conflicts, this involves adapting the fix for f520a742287e (i.e. an
   unhandled ENOMEM).
 - Fix bug with bounds used with vma_interval_tree_foreach.
 - Add a patch doing lru_add_drain after swapping in the shmem case.
 - Update/clarify some comments.
 - Drop ack on final patch
v4 -> v5:
 - Rebase on mm-unstable (9caa15b8a499)
 - Gather acks
v3 -> v4:
 - Base changes on mm-everything (fba720cb4dc0)
 - Add patch to refactor error handling control flow in collapse_file
 - Rebase userfaultfd patch with no significant logic changes
 - Different approach for fixing lseek race
v2 -> v3:
 - Use XA_RETRY_ENTRY to synchronize with reads from the page cache
   under the RCU read lock in userfaultfd fix
 - Add patch to fix lseek race
v1 -> v2:
 - Different approach for userfaultfd fix

*** BLURB HERE ***

David Stevens (4):
  mm/khugepaged: drain lru after swapping in shmem
  mm/khugepaged: refactor collapse_file control flow
  mm/khugepaged: skip shmem with userfaultfd
  mm/khugepaged: maintain page cache uptodate flag

 include/trace/events/huge_memory.h |   3 +-
 mm/khugepaged.c                    | 312 ++++++++++++++++-------------
 2 files changed, 171 insertions(+), 144 deletions(-)

-- 
2.40.0.348.gf938b09366-goog

