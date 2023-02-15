Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83EC1697C91
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 14:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbjBONBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 08:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbjBONBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 08:01:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC22127D50
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 05:01:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88D4F61BA6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 13:01:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBBA3C433EF;
        Wed, 15 Feb 2023 13:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676466073;
        bh=/ty4K/gkLsk7zw+XWjgV6xnYCwV+ng1Uvr9uV/F92FU=;
        h=From:To:Cc:Subject:Date:From;
        b=u6ljbQgAWVxr91+XjvfSLT2FE1UiKoUEQEIEz5SQnk2GWHYhI88M2/W6eA6tgnFwQ
         TBy3OOH/jBkI18gZv3DvP4UsmYI/0vHCQCAaJkEKmLh1mU8Mgpeb/A9RVZlC2e7qvm
         vMiWDAtDSbO85LRV1Ismi7bc2LmmpaHzQaMHSceZSHEsehr8mAOjNXKyhIkixndZ/O
         OHSQuahdD5jGG/yvK0Gr9vXu70HFBeRBKV9nJgfcMD3ftTS29vaCjklxaZJtx8eREg
         UdqUA03QeanFnWSgO9qULxXDBwWtq/nBDVUXX+K2lRH4eLgFMVVApB2W+FM68YUYT5
         DmXO75Kz3t/0A==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
        Marco Elver <elver@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] [v2] objtool warning fixes
Date:   Wed, 15 Feb 2023 14:00:55 +0100
Message-Id: <20230215130058.3836177-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

These are three of the easier fixes for objtool warnings around
kasan/kmsan/kcsan. I dropped one patch since Peter had come up
with a better fix, and adjusted the changelog text based on
feedback.

Link: https://lore.kernel.org/all/20230208164011.2287122-1-arnd@kernel.org/

Arnd Bergmann (3):
  [v2] kasan: mark addr_has_metadata __always_inline
  [v2] kmsan: disable ftrace in kmsan core code
  [v2] objtool: add UACCESS exceptions for __tsan_volatile_read/write

 mm/kasan/kasan.h      | 4 ++--
 mm/kmsan/Makefile     | 8 +++++++-
 tools/objtool/check.c | 2 ++
 3 files changed, 11 insertions(+), 3 deletions(-)

Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Cc: Marco Elver <elver@google.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: kasan-dev@googlegroups.com
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org

-- 
2.39.1

