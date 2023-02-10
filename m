Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4914692904
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 22:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbjBJVQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 16:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbjBJVQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 16:16:13 -0500
Received: from out-234.mta0.migadu.com (out-234.mta0.migadu.com [IPv6:2001:41d0:1004:224b::ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B973F7536E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 13:16:11 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676063769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SVXQhPxtDUlvcBHu0yCHUaIQvvsOva2Wy+xT1T1B0xM=;
        b=g4VXUY+C4aROZALZ/m0wYHFweJzqrsxkZpLJojP2JcL0petnwLSwd/Z80ClP+ddd1SJZoh
        pnPHpajSdtcvCOUCkJOlkWBGMudWmAo3OcCBtXiNOl6VhIkZijYh9/JJCDTrn4TmdQFaFl
        guDvrD9WiNbSsMPxQiXhHHsigN0sBeI=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v2 00/18] lib/stackdepot: fixes and clean-ups
Date:   Fri, 10 Feb 2023 22:15:48 +0100
Message-Id: <cover.1676063693.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

A set of fixes, comments, and clean-ups I came up with while reading
the stack depot code.

Changes v1->v2:
- Drop "lib/stackdepot: fix setting next_slab_inited in init_stack_slab",
  as there is no bug to fix.
- Use "pool" instead of "slab" for memory regions that store stack traces.
- Rename next_slab/pool_inited to next_slab/pool_required and annotate its
  uses with comments, see new patch #13.
- Use STACK_HASH_TABLE_SCALE as a new name for STACK_HASH_SCALE.
- Mark stack_depot_set_extra_bits as __must_check.
- Only assign extra bits in stack_depot_set_extra_bits for non-empty
  handles.
- Minor comment fixes.

Andrey Konovalov (18):
  lib/stackdepot: put functions in logical order
  lib/stackdepot: use pr_fmt to define message format
  lib/stackdepot, mm: rename stack_depot_want_early_init
  lib/stackdepot: rename stack_depot_disable
  lib/stackdepot: annotate init and early init functions
  lib/stackdepot: lower the indentation in stack_depot_init
  lib/stackdepot: reorder and annotate global variables
  lib/stackdepot: rename hash table constants and variables
  lib/stackdepot: rename slab to pool
  lib/stackdepot: rename handle and pool constants
  lib/stackdepot: rename init_stack_pool
  lib/stacktrace: drop impossible WARN_ON for depot_init_pool
  lib/stackdepot: annotate depot_init_pool and depot_alloc_stack
  lib/stackdepot: rename next_pool_inited to next_pool_required
  lib/stacktrace, kasan, kmsan: rework extra_bits interface
  lib/stackdepot: annotate racy pool_index accesses
  lib/stackdepot: various comments clean-ups
  lib/stackdepot: move documentation comments to stackdepot.h

 include/linux/stackdepot.h | 152 +++++++--
 lib/stackdepot.c           | 654 ++++++++++++++++++-------------------
 mm/kasan/common.c          |   2 +-
 mm/kmsan/core.c            |  10 +-
 mm/page_owner.c            |   2 +-
 mm/slub.c                  |   4 +-
 6 files changed, 457 insertions(+), 367 deletions(-)

-- 
2.25.1

