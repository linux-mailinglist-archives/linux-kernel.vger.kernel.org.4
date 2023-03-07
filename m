Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F576AD6B8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 06:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjCGFUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 00:20:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjCGFUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 00:20:50 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D57D39B88
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 21:20:44 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id c10so7292310pfv.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 21:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678166444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=20CEHgBZB/knq/v8u1dqent5tn2IhUU6G+2xPJmjJ6k=;
        b=LrljpWa64w/OvxKgj7tq2aRMAPKskK+arq0+8oZuMtFp6/+4iMBYkokTvHm5bASffo
         BUNfBUPE0w+bDoaIk6EfXbE1vXE0u/VM9TMfzgcGXuP36HYKNHZkXLljqwkkUlNbybYw
         qnPLqtY8IzMsTjn+UG1nrFrPgx7yUaKBAI3Ac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678166444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=20CEHgBZB/knq/v8u1dqent5tn2IhUU6G+2xPJmjJ6k=;
        b=CBXbWEFXKqOP7h907r2mxmHRU+GARLgDkzLzr3Bco/GkMAnZwly7Aap5xgxqq6SEc+
         A5hH+Ob6ZVN+tSALh5TCJHvrjkb5Saz08Pc4Tkr3IGBSipqCqV9ZWR3vqoni4XkR+eY4
         drYFjkmNuj/qQw3Obazq/Q+8vnAioLxPd6RSLQDyG3jTyRR8muXdjbsm92O9fWvlA+jl
         o90rgVqG0FvpRBU8p/M7FfYLgyBx70s9HQH9RwctXxTAzrbrZdaxIxAPXU+pmo0c9EJ4
         g8uFcGafinn1cDUxz5flnksO1c1VZTeYKbpfiN8813p7UpxCIBpRrG6Kwb5eezQosbLB
         9rqw==
X-Gm-Message-State: AO0yUKWKaQ2zODijWBELAD/+DODDG0DQ08kpEv4M5YfcIttDUizkifpZ
        Bb4Tuskq9CxU46Q0Ulx72HKQoQ==
X-Google-Smtp-Source: AK7set+QPVgc7195ffL/2bqmra2B4t+KPYNOjqUJ+WyPG0pIrD5U2xmSZpX7ihZmyKeQ8jBDSXcJLQ==
X-Received: by 2002:aa7:956b:0:b0:619:d5c2:e97 with SMTP id x11-20020aa7956b000000b00619d5c20e97mr8067843pfq.2.1678166443789;
        Mon, 06 Mar 2023 21:20:43 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:1f73:9034:ce28:4421])
        by smtp.gmail.com with UTF8SMTPSA id 1-20020aa79241000000b005a7ae8b3a09sm7146849pfp.32.2023.03.06.21.20.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 21:20:43 -0800 (PST)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-kernel@vger.kernel.org,
        David Stevens <stevensd@chromium.org>
Subject: [PATCH v5 0/3] mm/khugepaged: fix khugepaged+shmem races
Date:   Tue,  7 Mar 2023 14:20:33 +0900
Message-Id: <20230307052036.1520708-1-stevensd@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Stevens <stevensd@chromium.org>

Fix two races in khugepaged+shmem that cause issues with userfaultfd and
lseek, respectively.

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

David Stevens (3):
  mm/khugepaged: refactor collapse_file control flow
  mm/khugepaged: skip shmem with userfaultfd
  mm/khugepaged: maintain page cache uptodate flag

 include/trace/events/huge_memory.h |   3 +-
 mm/khugepaged.c                    | 259 ++++++++++++++++-------------
 2 files changed, 142 insertions(+), 120 deletions(-)

-- 
2.40.0.rc0.216.gc4246ad0f0-goog

