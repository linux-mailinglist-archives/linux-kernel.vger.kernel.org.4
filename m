Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703D66076A2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 14:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiJUMAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 08:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiJUMA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 08:00:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE7E24E42B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 05:00:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4812361E67
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 12:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC641C43470;
        Fri, 21 Oct 2022 12:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666353625;
        bh=wLiSsLCBvUemVPUmA7PVLvUAvaGVpUx35Yr4C7U15XA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oLdIZz3lKKkdU27FrbVGeSE2xW3GDlfWRHpAsKzY9gP9Jnv7umrhBCq3LbH/H7kf9
         uCSueC8OBTd5ZBZU0YrD11bBheye3DDGBljEnh7o8I9LsuEXY8JDAJhhaQE/0GNznI
         XeqOeVn8rLwPKHUFc7ht/KjgoaTInYvnVYRPTK7yl0FY+8nk4Czzw1axmOioSo8pUv
         S4bT2Osu8sQaWSk193hDIJlHo71Uit0mZQ1+A+Hoa1Os3yS/3U/9+YkaIdvyc1a39a
         rU75eLuRQK2T4umxzqtkevP8lKTbVAV4mR7OHfkeqDg3nMM6rwP0asUEk5orrUAqmn
         jjBlBWx7TpJCw==
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
Subject: [PATCH 2/5] compiler-gcc: remove attribute support check for `__no_sanitize_address__`
Date:   Fri, 21 Oct 2022 13:59:53 +0200
Message-Id: <20221021115956.9947-2-ojeda@kernel.org>
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

The attribute was added in GCC 4.8, while the minimum GCC version
supported by the kernel is GCC 5.1.

Therefore, remove the check.

Link: https://godbolt.org/z/84v56vcn8
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 include/linux/compiler-gcc.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index b9530d3515ac..bfce7f4d0978 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -82,11 +82,7 @@
 #define __noscs __attribute__((__no_sanitize__("shadow-call-stack")))
 #endif
 
-#if __has_attribute(__no_sanitize_address__)
 #define __no_sanitize_address __attribute__((__no_sanitize_address__))
-#else
-#define __no_sanitize_address
-#endif
 
 #if defined(__SANITIZE_THREAD__) && __has_attribute(__no_sanitize_thread__)
 #define __no_sanitize_thread __attribute__((__no_sanitize_thread__))
-- 
2.38.1

