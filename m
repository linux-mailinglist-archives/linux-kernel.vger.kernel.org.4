Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65C46076A4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 14:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbiJUMAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 08:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiJUMAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 08:00:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECCC251F6C
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 05:00:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10A68B82B92
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 12:00:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7330C433C1;
        Fri, 21 Oct 2022 12:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666353632;
        bh=XzdFROMipXdmkMLqEBVG7r+Qq/ycFDav+ihm+nprFco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lRRUVqO3E1qBngvZkiPsbDUe43N8i1GrfX46QurdSPQ8voWfgv5owS7cY8PQ85VB/
         uAyj13Y3I3p5za42OA6G2hnIOtHOrD3xWSuiwZa0u60g3+pyWDgIYxSIyrVSPXBx/i
         1Ew1lwcs6Z7f0zL0Wy5H5SyOWFnoP6VVXEpiePRCxbwB+nPaKhKilN4t0I0IsNh8y9
         wIbdTTau6kSZ8p39Hh5vs+Q5FI03DRkAUZLfOP0knGELWSnJY9CDjbGQw7tW3EKD2n
         kQMmF/IywkBz24C7AADfw6a02EuB83ACvZBXHvryDeeSbrBp64AKTwXXsWt4eLvksJ
         KY/QwSJ5NttcQ==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Uros Bizjak <ubizjak@gmail.com>,
        Dan Li <ashimida@linux.alibaba.com>,
        Alexander Potapenko <glider@google.com>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] compiler-gcc: remove attribute support check for `__no_sanitize_undefined__`
Date:   Fri, 21 Oct 2022 13:59:55 +0200
Message-Id: <20221021115956.9947-4-ojeda@kernel.org>
In-Reply-To: <20221021115956.9947-1-ojeda@kernel.org>
References: <20221021115956.9947-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The attribute was added in GCC 4.9, while the minimum GCC version
supported by the kernel is GCC 5.1.

Therefore, remove the check.

Link: https://godbolt.org/z/GrMeo6fYr
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 include/linux/compiler-gcc.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index ba207deb77ca..7f2c2bb73815 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -90,11 +90,7 @@
 #define __no_sanitize_thread
 #endif
 
-#if __has_attribute(__no_sanitize_undefined__)
 #define __no_sanitize_undefined __attribute__((__no_sanitize_undefined__))
-#else
-#define __no_sanitize_undefined
-#endif
 
 #if defined(CONFIG_KCOV) && __has_attribute(__no_sanitize_coverage__)
 #define __no_sanitize_coverage __attribute__((__no_sanitize_coverage__))
-- 
2.38.1

