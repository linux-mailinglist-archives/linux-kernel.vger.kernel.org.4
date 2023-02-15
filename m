Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C6F697C97
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 14:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbjBONBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 08:01:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbjBONB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 08:01:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0854431E33
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 05:01:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7164B821C4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 13:01:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4813DC433EF;
        Wed, 15 Feb 2023 13:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676466083;
        bh=LCrzUXqbVxh67TyCMfdqY6tY7QeA2lgRgFNm/o1Clp0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=trjIqlwZyO+lwC6wY2BwIi2/mShc9WUDm9YrsjZ24D2fsCN/XdBERQW+gmteC8VNN
         YK4uldLchrzIGLzJ3nz93yG0XY7arZ3i4YgZ2Lc9Mu9lA7KxV1k4dey5CH+NCH8XPe
         T12gdgRSJvbK/HMFSkuKhQgI07jjONQ6YMov3TAIPRXlQM0Xh0TamEqo1+hkqCwWit
         A/HGHQ8tTFEqzT5Y7HhQ4ZkU+ePlRphqBw0io5rRVIm9/ye4Ja+OE3AAvycLdCH3OP
         m22aM8Hqp22iEmk+ci6F6qJRnjS2DdmigNWX2mZU7KKQzMWrXtKyApa/5ozRNmPlry
         yABFYRztl4azg==
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
Subject: [PATCH 3/3] [v2] objtool: add UACCESS exceptions for __tsan_volatile_read/write
Date:   Wed, 15 Feb 2023 14:00:58 +0100
Message-Id: <20230215130058.3836177-4-arnd@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230215130058.3836177-1-arnd@kernel.org>
References: <20230215130058.3836177-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

A lot of the tsan helpers are already excempt from the UACCESS warnings,
but some more functions were added that need the same thing:

kernel/kcsan/core.o: warning: objtool: __tsan_volatile_read16+0x0: call to __tsan_unaligned_read16() with UACCESS enabled
kernel/kcsan/core.o: warning: objtool: __tsan_volatile_write16+0x0: call to __tsan_unaligned_write16() with UACCESS enabled
vmlinux.o: warning: objtool: __tsan_unaligned_volatile_read16+0x4: call to __tsan_unaligned_read16() with UACCESS enabled
vmlinux.o: warning: objtool: __tsan_unaligned_volatile_write16+0x4: call to __tsan_unaligned_write16() with UACCESS enabled

As Marco points out, these functions don't even call each other
explicitly but instead gcc (but not clang) notices the functions
being identical and turns one symbol into a direct branch to the
other.

Fixes: 75d75b7a4d54 ("kcsan: Support distinguishing volatile accesses")
Acked-by: Marco Elver <elver@google.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 tools/objtool/check.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index b0b467d9608a..da52ce861cc2 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1237,6 +1237,8 @@ static const char *uaccess_safe_builtin[] = {
 	"__tsan_atomic64_compare_exchange_val",
 	"__tsan_atomic_thread_fence",
 	"__tsan_atomic_signal_fence",
+	"__tsan_unaligned_read16",
+	"__tsan_unaligned_write16",
 	/* KCOV */
 	"write_comp_data",
 	"check_kcov_mode",
-- 
2.39.1

