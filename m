Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1278C6076A5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 14:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiJUMAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 08:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiJUMAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 08:00:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0D725F8C0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 05:00:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D3C1B82B1D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 12:00:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B2EC433D6;
        Fri, 21 Oct 2022 12:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666353636;
        bh=LMbm0RHnpHjF4XALs9PiF0EN08cXmWMXDuFm/StCLYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uY6civyb7kDMMqoM8kDnJuXgTvt96br4iOPCoRINeo7pN3UFMG2jZU+pbngyk4L32
         mAEA5B5nw1nn2mZ3ztnJipCUK25eHx0Vn5DcQMhwX0e3namZGj91GAHkRC38Fze3Sv
         MVO4Uny0Tp80q6nH1WfO8QZnjWHApp7P80ZG/D9JQyQiUdRBGj9eHkbVJfB2iGGK7X
         ZIQWFovF/ERwkF6hJTF9msGZXnw0qQKGvv6NgTMLXfQWeI6xi8QOe5SBrKqD/OwTUX
         t+SZfkGLXNRgJ838gDjofYl5p25Oc5nEv/Y0o37GjJvY2Z9EeIaujzLZTtVk1akrSF
         tL30aNK+edApA==
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
Subject: [PATCH 5/5] compiler-gcc: document minimum version for `__no_sanitize_coverage__`
Date:   Fri, 21 Oct 2022 13:59:56 +0200
Message-Id: <20221021115956.9947-5-ojeda@kernel.org>
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

The attribute was added in GCC 12.1.

This will simplify future cleanups, and is closer to what we do
in `compiler_attributes.h`.

Link: https://godbolt.org/z/MGbT76j6G
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 include/linux/compiler-gcc.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 7f2c2bb73815..7af9e34ec261 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -92,6 +92,9 @@
 
 #define __no_sanitize_undefined __attribute__((__no_sanitize_undefined__))
 
+/*
+ * Only supported since gcc >= 12
+ */
 #if defined(CONFIG_KCOV) && __has_attribute(__no_sanitize_coverage__)
 #define __no_sanitize_coverage __attribute__((__no_sanitize_coverage__))
 #else
-- 
2.38.1

