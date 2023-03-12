Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5CA6B6CA4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 00:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjCLXme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 19:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCLXmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 19:42:32 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623672B9DD
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 16:42:31 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id x22so1311847wmj.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 16:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678664550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L6L1zRMn7RXTj0YSorRi36CoIbvbTpqPl5G6frS5ebk=;
        b=qQg5I0l+XsWhkDyOnPm9+bat+WJLhznZxrD+/AauSstkSUaUO+3O5SNlzswUyoV3iS
         frZg8lBxQJys363RY7R2XM23j56Q+9K9YCBPNCObWsd3Kx1idDKRRx1+zyt71g+YeCza
         yvRi0TGXqt6cxRMKeBwLqSKAx1zU4aaJ5Z1RnWBWJyqwrVrKdN91fbYHn9KijJvfxySF
         2g1EUb2P80R1Oi1wS2lJaZ9VRmlfSZfDmqMok5JOasDjScVWK+Quy2ThrF3wdvZ7PlGd
         gj1yoSVo1WbbUWQj30k899w0uM9Glb4b9h82LyrHbWv1UavkbsZqU5C5vS9+o/cGSchT
         gcDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678664550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L6L1zRMn7RXTj0YSorRi36CoIbvbTpqPl5G6frS5ebk=;
        b=0v8fjaHM29ogopRBZzN2aRFThkdNmDZ+dlRIbumzDffP2o864SJKbC/uplPv7lv7ou
         Ps5+iJfOH+YLjCNcgtqJAjg18lZvgfV+0FtTKxPPnkzgx55lXTY1Bgur0ljy9AXQDhKd
         FeyTbJ6IqQYixzbPmbCKBAz3qwTJNJdurpWRpLqsytpxLco9IGHfle5siWAaSoUA4rIk
         9VwVRDFAVm4uN9LTzUzPwtWWNeunkakcqxsqrf1O64kmF1ozbZhSbPb2I1ZfOt7CuQEx
         9NWky+T9A2a0um9ZGeByf8e1jR7mWqmFgZreBS9Z1KeE0fiXE6sbXAaXS/z0SkkbnZ8H
         yIvw==
X-Gm-Message-State: AO0yUKURLXN4AvO+1YV2h46gIpB39cQMeTTFBzptrG6JqGIGnGd8n7bN
        WnyHz3nH7bWj8Hqs+o8B27c=
X-Google-Smtp-Source: AK7set9huZg1uC2jiFvA8tejOk5vnpUPfNGhGVQes4FSQiIZC2Akfq9gFzeIDZNfFBKRRWYv67YeUQ==
X-Received: by 2002:a05:600c:4fcf:b0:3eb:29fe:f911 with SMTP id o15-20020a05600c4fcf00b003eb29fef911mr8980719wmq.13.1678664549671;
        Sun, 12 Mar 2023 16:42:29 -0700 (PDT)
Received: from lucifer.home (host86-146-209-214.range86-146.btcentralplus.com. [86.146.209.214])
        by smtp.googlemail.com with ESMTPSA id iz20-20020a05600c555400b003ed201ddef2sm3698376wmb.2.2023.03.12.16.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 16:42:28 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        Christian Konig <christian.koenig@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH 0/3] Remove drm/ttm-specific mm changes
Date:   Sun, 12 Mar 2023 23:40:12 +0000
Message-Id: <cover.1678661628.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Functionality was added specifically for the DRM TTM driver to support
mapping memory for VM_MIXEDMAP VMAs with customised protection flags,
however this has now been rolled back as issues were found with this
approach.

This series removes the mm changes too, retaining some of the useful
comments.

Lorenzo Stoakes (3):
  mm: remove unused vmf_insert_mixed_prot()
  mm: Remove vmf_insert_pfn_xxx_prot() for huge page-table entries
  drm/ttm: Remove comment referencing now-removed
    vmf_insert_mixed_prot()

 drivers/gpu/drm/ttm/ttm_bo_vm.c |  2 +-
 include/linux/huge_mm.h         | 39 ++--------------------
 include/linux/mm.h              |  2 --
 include/linux/mm_types.h        |  7 +---
 mm/huge_memory.c                | 31 ++++++++----------
 mm/memory.c                     | 57 +++++++++++----------------------
 6 files changed, 35 insertions(+), 103 deletions(-)

--
2.39.2
