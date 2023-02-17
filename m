Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034CB69A787
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 09:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjBQIzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 03:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjBQIzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 03:55:08 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B1A60A6B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 00:55:01 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id i9so247663pgh.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 00:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jW7jj7f6MP9PxLSksLkqYvzlSatAtLM3QwqY5I2bMTs=;
        b=AxKWq247OiMsgwdjeZG4onLqOOczVeFhigzgMW36NqP3PnTtr07pQcIC1NkUqoUybP
         Z2DyZ6zDOWze0riOIPhsGIdG+A+wTKsQIqeazKwMz6LJz9bLLXgFxCOY0AU84qR4RDZL
         xNohVtblk/uKWsKH9xK3lezjLER2Of2GPjl8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jW7jj7f6MP9PxLSksLkqYvzlSatAtLM3QwqY5I2bMTs=;
        b=cj2pO0H5Xx5kCdtuVe8KIOZHsv3IXNJbSDDvnlT8Agl1NfCjhA1GuvjxEfSw0ZVQ/I
         U9QINAVx/68E0NawXF3+X3Qsp7gEqTTejC/PgDuSyMJMY3ILJ80DTomk0ULfbSybK7ol
         4xcjcvcFCXdYGSNlW8yIY891JNrHXYEeT9oP5X2QGfLymhUOXGASgo8eXHtIYDOR06Zi
         0Gfy+Gx5uI83cIPxECKdL9UvCQqLM4/cIBbO2RlkCK36bwVbwwAFk73tzzKCDaEQXU2T
         L7r8lJYQxvfKW92QuL3PLV57Lccpw2OaTLf4MA+ThkQeaex71tN9UuVn8uTnJ0bOWz2f
         HkZQ==
X-Gm-Message-State: AO0yUKXuBbJDBO3pwco6YhX3IJe8q7u95gw50/DjbiOznSGxuygvtR6c
        s4H0zmxRwXX37dMq/ksIBcAy5g==
X-Google-Smtp-Source: AK7set8sxc3XjPtlUCSHKtLA+vXLcsVBezbuhd1RvxMP54fMig5RoihUdtXrlUEJbwQu1Tm3esJyyw==
X-Received: by 2002:aa7:96ae:0:b0:5a8:31a1:2f05 with SMTP id g14-20020aa796ae000000b005a831a12f05mr211084pfk.5.1676624101229;
        Fri, 17 Feb 2023 00:55:01 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:b7bc:8cb9:1364:30fb])
        by smtp.gmail.com with UTF8SMTPSA id s8-20020aa78288000000b005a83129caeasm2576589pfm.185.2023.02.17.00.54.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 00:55:00 -0800 (PST)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     linux-mm@kvack.org, Peter Xu <peterx@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        David Stevens <stevensd@chromium.org>
Subject: [PATCH v4 0/3] mm/khugepaged: fix khugepaged+shmem races
Date:   Fri, 17 Feb 2023 17:54:36 +0900
Message-Id: <20230217085439.2826375-1-stevensd@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Stevens <stevensd@chromium.org>

Fix two races in khugepaged+shmem that cause issues with userfaultfd and
lseek, respectively.

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
 mm/khugepaged.c                    | 263 ++++++++++++++++-------------
 2 files changed, 144 insertions(+), 122 deletions(-)

-- 
2.39.2.637.g21b0678d19-goog

