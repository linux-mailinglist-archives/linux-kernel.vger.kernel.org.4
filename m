Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6949A681BE8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 21:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjA3U4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 15:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjA3U4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 15:56:14 -0500
Received: from out-164.mta1.migadu.com (out-164.mta1.migadu.com [95.215.58.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF823E609
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 12:56:10 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675111786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hkOxFb3yEq6h7w40h7f3LyAdThOsJZHxCl/P/Sxc7oQ=;
        b=IjSdtAT7mJMj0n3equLk6P0c1en/EigWievoZ84+T0WHThgYyVm1Mlt7y1eDxyh5x6w1qk
        GynjcdifilVI+8ZRAC4HGbxVI1DSaIgUk3/XoNZr6Jo4VpXVNQXVkgNW5nkvfu8ftTFyLM
        4wLznoICjyBMgYo9GjxcNHuR1Nht9lc=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH 00/18] lib/stackdepot: fixes and clean-ups
Date:   Mon, 30 Jan 2023 21:49:24 +0100
Message-Id: <cover.1675111415.git.andreyknvl@google.com>
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

The only fix that might be worth backporting to stable kernels is
in the first patch.

Andrey Konovalov (18):
  lib/stackdepot: fix setting next_slab_inited in init_stack_slab
  lib/stackdepot: put functions in logical order
  lib/stackdepot: use pr_fmt to define message format
  lib/stackdepot, mm: rename stack_depot_want_early_init
  lib/stackdepot: rename stack_depot_disable
  lib/stackdepot: annotate init and early init functions
  lib/stackdepot: lower the indentation in stack_depot_init
  lib/stackdepot: reorder and annotate global variables
  lib/stackdepot: rename hash table constants and variables
  lib/stackdepot: rename init_stack_slab
  lib/stackdepot: rename slab variables
  lib/stackdepot: rename handle and slab constants
  lib/stacktrace: drop impossible WARN_ON for depot_init_slab
  lib/stackdepot: annotate depot_init_slab and depot_alloc_stack
  lib/stacktrace, kasan, kmsan: rework extra_bits interface
  lib/stackdepot: annotate racy slab_index accesses
  lib/stackdepot: various comments clean-ups
  lib/stackdepot: move documentation comments to stackdepot.h

 include/linux/stackdepot.h | 152 +++++++--
 lib/stackdepot.c           | 628 ++++++++++++++++++-------------------
 mm/kasan/common.c          |   2 +-
 mm/kmsan/core.c            |  10 +-
 mm/page_owner.c            |   2 +-
 mm/slub.c                  |   4 +-
 6 files changed, 435 insertions(+), 363 deletions(-)

-- 
2.25.1

