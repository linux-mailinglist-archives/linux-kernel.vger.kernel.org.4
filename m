Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73CE46FC9AC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 16:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235975AbjEIO5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 10:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjEIO5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 10:57:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68C835A3
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 07:57:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52F4D64702
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 14:57:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E47EC433D2;
        Tue,  9 May 2023 14:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683644264;
        bh=8kpzffon4c7U76Nx4fRs+z+9nZ2f5EaWU4V5dVQ6n0Q=;
        h=From:To:Cc:Subject:Date:From;
        b=dFY7jYTxkQy1d+Wx7GQyxgjoLx5KR+hJo7zg/bSri2X5OiKl5IW9MWmOaTrXNBYIg
         0Kc4YMwQkOxlpcfph8P0/BWy2Js9N5c9yClZcW5PyxEIAzhUmQqyW9U8n2LFtlglSI
         J0v3yNvOkhWEZbkoTUh6LjU3h5S4R4EeZbWaaXH1ZUQkmUfNwFh4eScSC98tFq6hbl
         REMLiZOS3AwgVri27469BI6aS9fVQFt2GrzUkERQnR7mu6VU7iHuijefB02PHBKlXZ
         k78UDiPbmlh0nJUzcLgK1fSmyrj1LeA1wa18MLmTANs+H+vNhRHhXiS6GUUh7gSQOK
         Ex2cruxneCCfg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Marco Elver <elver@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] kasan: add kasan_tag_mismatch prototype
Date:   Tue,  9 May 2023 16:57:20 +0200
Message-Id: <20230509145735.9263-1-arnd@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The kasan sw-tags implementation contains one function that is only
called from assembler and has no prototype in a header. This causes
a W=1 warning:

mm/kasan/sw_tags.c:171:6: warning: no previous prototype for 'kasan_tag_mismatch' [-Wmissing-prototypes]
  171 | void kasan_tag_mismatch(unsigned long addr, unsigned long access_info,

Add a prototype in the local header to get a clean build.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/kasan/kasan.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index f5e4f5f2ba20..cd846ca34f44 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -646,4 +646,7 @@ void *__hwasan_memset(void *addr, int c, size_t len);
 void *__hwasan_memmove(void *dest, const void *src, size_t len);
 void *__hwasan_memcpy(void *dest, const void *src, size_t len);
 
+void kasan_tag_mismatch(unsigned long addr, unsigned long access_info,
+			unsigned long ret_ip);
+
 #endif /* __MM_KASAN_KASAN_H */
-- 
2.35.1

