Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F796076A3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 14:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiJUMAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 08:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbiJUMAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 08:00:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53811251F6C
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 05:00:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3FE561E6D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 12:00:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35885C433B5;
        Fri, 21 Oct 2022 12:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666353629;
        bh=LjLwcRsPZ65V3+uAZ7ZJ20ekU/4YVxIRhGPnMyc8hg4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=baCMPAuxXA5okUTpltIb1PDHRcQSWtRzcienWV3n48jfF8Q1Om+t1BddLs/7d0inO
         InEt3zCd6r9NHUbXIMY9PFstO8lNWAmBtcEUbaF1vbyc8hG/3nA2ztdGA1RGb4Wl3K
         dNwqE3PLZX5+eB8k95zqUizFUUQQ956brbMSA1LKzslbPxctl171bS9q/c2ltkthu5
         dy8p3R/F4O9pVyb0dPvn3w7+n1az8dSGvClcU7DppMM1YL2dfIuY4AvpeK3TnMfO3v
         UQCwtxdKwyeP+hKa2hfsoNROys+c5Zv1hCKnYkhNeUfO+i0nH1ALJRpxMpjAFD3yhR
         y3JUNWJ3ls7kg==
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
Subject: [PATCH 3/5] compiler-gcc: remove attribute support check for `__no_sanitize_thread__`
Date:   Fri, 21 Oct 2022 13:59:54 +0200
Message-Id: <20221021115956.9947-3-ojeda@kernel.org>
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

The attribute was added in GCC 5.1, which matches the minimum GCC version
supported by the kernel.

Therefore, remove the check.

Link: https://godbolt.org/z/vbxKejxbx
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 include/linux/compiler-gcc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index bfce7f4d0978..ba207deb77ca 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -84,7 +84,7 @@
 
 #define __no_sanitize_address __attribute__((__no_sanitize_address__))
 
-#if defined(__SANITIZE_THREAD__) && __has_attribute(__no_sanitize_thread__)
+#if defined(__SANITIZE_THREAD__)
 #define __no_sanitize_thread __attribute__((__no_sanitize_thread__))
 #else
 #define __no_sanitize_thread
-- 
2.38.1

