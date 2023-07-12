Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B423275042C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 12:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbjGLKOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 06:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjGLKOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 06:14:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68D01991
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 03:14:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7586F61725
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 10:14:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A04AAC433C8;
        Wed, 12 Jul 2023 10:14:04 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] kasan: Fix tests by removing -ffreestanding
Date:   Wed, 12 Jul 2023 18:13:44 +0800
Message-Id: <20230712101344.2714626-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX hopes -fbuiltin for memset()/
memcpy()/memmove() if instrumentation is needed. This is the default
behavior but some archs pass -ffreestanding which implies -fno-builtin,
and then causes some kasan tests fail. So we remove -ffreestanding for
kasan tests.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 mm/kasan/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
index 7634dd2a6128..edd1977a6b88 100644
--- a/mm/kasan/Makefile
+++ b/mm/kasan/Makefile
@@ -45,7 +45,9 @@ CFLAGS_KASAN_TEST += -fno-builtin
 endif
 
 CFLAGS_kasan_test.o := $(CFLAGS_KASAN_TEST)
+CFLAGS_REMOVE_kasan_test.o := -ffreestanding
 CFLAGS_kasan_test_module.o := $(CFLAGS_KASAN_TEST)
+CFLAGS_REMOVE_kasan_test_module.o := -ffreestanding
 
 obj-y := common.o report.o
 obj-$(CONFIG_KASAN_GENERIC) += init.o generic.o report_generic.o shadow.o quarantine.o
-- 
2.39.3

