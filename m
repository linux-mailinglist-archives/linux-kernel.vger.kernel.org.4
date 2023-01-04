Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC0B65CB4E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 02:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbjADBSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 20:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjADBSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 20:18:21 -0500
X-Greylist: delayed 518 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 03 Jan 2023 17:18:19 PST
Received: from out-153.mta0.migadu.com (out-153.mta0.migadu.com [IPv6:2001:41d0:1004:224b::99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C16254
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 17:18:19 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1672794576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PC26Ho/6RwxF3gMRadK0bIZPfa+DG2oG9ZOGTDXD7m0=;
        b=VzH6fyc+pk4VfuQZwkkdJ+sI5RStaDfWUZC2rMCzUNYZVxTiFQrhsrPYQBb/ApO7PHD0qv
        XZ4YD6LGpYb1rXn+RXFM58580c3NL5N1ajLXuK8WYHDrDHcktbpujr/KxqmtRxOU2troij
        TnfHD6DvuzIAkaNui2I0OwAs7l6exl0=
From:   andrey.konovalov@linux.dev
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] kasan: mark kasan_kunit_executing as static
Date:   Wed,  4 Jan 2023 02:09:33 +0100
Message-Id: <f64778a4683b16a73bba72576f73bf4a2b45a82f.1672794398.git.andreyknvl@google.com>
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

Mark kasan_kunit_executing as static, as it is only used within
mm/kasan/report.c.

Fixes: c8c7016f50c8 ("kasan: fail non-kasan KUnit tests on KASAN reports")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/report.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 1d02757e90a3..22598b20c7b7 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -119,7 +119,7 @@ EXPORT_SYMBOL_GPL(kasan_restore_multi_shot);
  * Whether the KASAN KUnit test suite is currently being executed.
  * Updated in kasan_test.c.
  */
-bool kasan_kunit_executing;
+static bool kasan_kunit_executing;
 
 void kasan_kunit_test_suite_start(void)
 {
-- 
2.25.1

