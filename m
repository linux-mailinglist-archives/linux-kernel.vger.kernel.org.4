Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995496B55E0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 00:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbjCJXnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 18:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjCJXnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 18:43:42 -0500
Received: from out-20.mta1.migadu.com (out-20.mta1.migadu.com [IPv6:2001:41d0:203:375::14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A47F120843
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 15:43:41 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678491819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oDcuLSEdW7dG92xT5iE2ytpvV+VW7Ad9krPNXrfRPwk=;
        b=KexIs4rR+UsVNXfzaoUthnE4Zbw7zg7FNPT1gxekp2AoL8vszqK4xiGhWr5TmHD2jr8GWb
        BcXN/UzGm+jLdtXRx5SulvVCeqYlSYgPb2IMtufbXS+i6OtCgvmlZON6FPzRzs7b1SLvyI
        KHBEnNEQalESu+M+IiALcpwFpnj1LG4=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Weizhao Ouyang <ouyangweizhao@zeku.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH 4/5] kasan, arm64: add arch_suppress_tag_checks_start/stop
Date:   Sat, 11 Mar 2023 00:43:32 +0100
Message-Id: <75a362551c3c54b70ae59a3492cabb51c105fa6b.1678491668.git.andreyknvl@google.com>
In-Reply-To: <bc919c144f8684a7fd9ba70c356ac2a75e775e29.1678491668.git.andreyknvl@google.com>
References: <bc919c144f8684a7fd9ba70c356ac2a75e775e29.1678491668.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Add two new tagging-related routines arch_suppress_tag_checks_start/stop
that suppress MTE tag checking via the TCO register.

These rouines are used in the next patch.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/include/asm/memory.h | 2 ++
 mm/kasan/kasan.h                | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index faf42bff9a60..26bd4d9aa401 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -264,6 +264,8 @@ static inline const void *__tag_set(const void *addr, u8 tag)
 #define arch_enable_tag_checks_sync()		mte_enable_kernel_sync()
 #define arch_enable_tag_checks_async()		mte_enable_kernel_async()
 #define arch_enable_tag_checks_asymm()		mte_enable_kernel_asymm()
+#define arch_suppress_tag_checks_start()	__mte_enable_tco()
+#define arch_suppress_tag_checks_stop()		__mte_disable_tco()
 #define arch_force_async_tag_fault()		mte_check_tfsr_exit()
 #define arch_get_random_tag()			mte_get_random_tag()
 #define arch_get_mem_tag(addr)			mte_get_mem_tag(addr)
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index a1613f5d7608..f5e4f5f2ba20 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -398,6 +398,8 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
 #define hw_enable_tag_checks_sync()		arch_enable_tag_checks_sync()
 #define hw_enable_tag_checks_async()		arch_enable_tag_checks_async()
 #define hw_enable_tag_checks_asymm()		arch_enable_tag_checks_asymm()
+#define hw_suppress_tag_checks_start()		arch_suppress_tag_checks_start()
+#define hw_suppress_tag_checks_stop()		arch_suppress_tag_checks_stop()
 #define hw_force_async_tag_fault()		arch_force_async_tag_fault()
 #define hw_get_random_tag()			arch_get_random_tag()
 #define hw_get_mem_tag(addr)			arch_get_mem_tag(addr)
-- 
2.25.1

