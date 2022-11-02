Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E4B616A8B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 18:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbiKBRWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 13:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbiKBRWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 13:22:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2BB275C3;
        Wed,  2 Nov 2022 10:22:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D8CF9B8240C;
        Wed,  2 Nov 2022 17:22:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E11C43141;
        Wed,  2 Nov 2022 17:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667409761;
        bh=1AhYkLtqf9YhGF/slwawF+EBbzYmnHtSSL7hU6uKaKg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WeO7UeLx7Qw1vFaOTrt5JaOwVYdj6m6yF0wYVIo+f0s8UahkKYjp5cEIKGTAMm61o
         LObgdW5VvdGnqSlA50DTbhjQEbfNfDAsgAh0qHlxlXomAlviuZhARJ9/bxURTj/h3E
         ho0EXfpQTepI9a1ucGNqnuTb5twOW6DkcQlFyPNsVGyadD3p0HdNNpxsoAwf/YZvge
         8kXrkC06pAjt5+SphEildZnv3Y2/ADJQ7c3rKyzBPHImxBGDJbHVNPtj0jJMz31yEA
         OogcqUQHsTGQcg5zr+QN5QAV6SNZrnRQtL/egIlTdnnd+oYVbdtgF1HnwvS5Pv1xPQ
         EODiek7mXCD2g==
From:   Nathan Chancellor <nathan@kernel.org>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     linux-iio@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 4/4] counter: 104-quad-8: Adjust final parameter type of certain callback functions
Date:   Wed,  2 Nov 2022 10:22:17 -0700
Message-Id: <20221102172217.2860740-4-nathan@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102172217.2860740-1-nathan@kernel.org>
References: <20221102172217.2860740-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With clang's kernel control flow integrity (kCFI, CONFIG_CFI_CLANG),
indirect call targets are validated against the expected function
pointer prototype to make sure the call target is valid to help mitigate
ROP attacks. If they are not identical, there is a failure at run time,
which manifests as either a kernel panic or thread getting killed. A
proposed warning in clang aims to catch these at compile time, which
reveals:

  drivers/counter/104-quad-8.c:1041:2: error: incompatible function pointer types initializing 'int (*)(struct counter_device *, struct counter_signal *, u32 *)' (aka 'int (*)(struct counter_device *, struct counter_signal *, unsigned int *)') with an expression of type
  'int (struct counter_device *, struct counter_signal *, enum counter_signal_polarity *)' [-Werror,-Wincompatible-function-pointer-types-strict]
          COUNTER_COMP_POLARITY(quad8_polarity_read, quad8_polarity_write,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ./include/linux/counter.h:609:21: note: expanded from macro 'COUNTER_COMP_POLARITY'
          .signal_u32_read = (_read), \
                            ^~~~~~~
  drivers/counter/104-quad-8.c:1041:2: error: incompatible function pointer types initializing 'int (*)(struct counter_device *, struct counter_signal *, u32)' (aka 'int (*)(struct counter_device *, struct counter_signal *, unsigned int)') with an expression of type 'int
  (struct counter_device *, struct counter_signal *, enum counter_signal_polarity)' [-Werror,-Wincompatible-function-pointer-types-strict]
          COUNTER_COMP_POLARITY(quad8_polarity_read, quad8_polarity_write,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ./include/linux/counter.h:610:22: note: expanded from macro 'COUNTER_COMP_POLARITY'
          .signal_u32_write = (_write), \
                              ^~~~~~~~
  drivers/counter/104-quad-8.c:1129:2: error: incompatible function pointer types initializing 'int (*)(struct counter_device *, struct counter_count *, u32 *)' (aka 'int (*)(struct counter_device *, struct counter_count *, unsigned int *)') with an expression of type 'i
  nt (struct counter_device *, struct counter_count *, enum counter_count_mode *)' [-Werror,-Wincompatible-function-pointer-types-strict]
          COUNTER_COMP_COUNT_MODE(quad8_count_mode_read, quad8_count_mode_write,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ./include/linux/counter.h:587:20: note: expanded from macro 'COUNTER_COMP_COUNT_MODE'
          .count_u32_read = (_read), \
                            ^~~~~~~
  drivers/counter/104-quad-8.c:1129:2: error: incompatible function pointer types initializing 'int (*)(struct counter_device *, struct counter_count *, u32)' (aka 'int (*)(struct counter_device *, struct counter_count *, unsigned int)') with an expression of type 'int (
  struct counter_device *, struct counter_count *, enum counter_count_mode)' [-Werror,-Wincompatible-function-pointer-types-strict]
          COUNTER_COMP_COUNT_MODE(quad8_count_mode_read, quad8_count_mode_write,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ./include/linux/counter.h:588:21: note: expanded from macro 'COUNTER_COMP_COUNT_MODE'
          .count_u32_write = (_write), \
                            ^~~~~~~~
  drivers/counter/104-quad-8.c:1131:2: error: incompatible function pointer types initializing 'int (*)(struct counter_device *, struct counter_count *, u32 *)' (aka 'int (*)(struct counter_device *, struct counter_count *, unsigned int *)') with an expression of type 'i
  nt (struct counter_device *, struct counter_count *, enum counter_count_direction *)' [-Werror,-Wincompatible-function-pointer-types-strict]
          COUNTER_COMP_DIRECTION(quad8_direction_read),
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ./include/linux/counter.h:596:20: note: expanded from macro 'COUNTER_COMP_DIRECTION'
          .count_u32_read = (_read), \
                            ^~~~~~~
  5 errors generated.

->count_u32_{read,write}() and ->count_u32_{read,write}() in 'struct
counter_comp' expect a final parameter type of either 'u32' or 'u32 *',
not the enumerated types used in the implementations. Adjust the final
parameter type in the implementations to match the prototype's to
resolve the warning and CFI failures.

Link: https://github.com/ClangBuiltLinux/linux/issues/1750
Reported-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/counter/104-quad-8.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 30b40f805f88..720a88ad59db 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -337,7 +337,7 @@ static int quad8_function_write(struct counter_device *counter,
 
 static int quad8_direction_read(struct counter_device *counter,
 				struct counter_count *count,
-				enum counter_count_direction *direction)
+				u32 *direction)
 {
 	const struct quad8 *const priv = counter_priv(counter);
 	unsigned int ud_flag;
@@ -572,7 +572,7 @@ static int quad8_index_polarity_set(struct counter_device *counter,
 
 static int quad8_polarity_read(struct counter_device *counter,
 			       struct counter_signal *signal,
-			       enum counter_signal_polarity *polarity)
+			       u32 *polarity)
 {
 	int err;
 	u32 index_polarity;
@@ -589,7 +589,7 @@ static int quad8_polarity_read(struct counter_device *counter,
 
 static int quad8_polarity_write(struct counter_device *counter,
 				struct counter_signal *signal,
-				enum counter_signal_polarity polarity)
+				u32 polarity)
 {
 	const u32 pol = (polarity == COUNTER_SIGNAL_POLARITY_POSITIVE) ? 1 : 0;
 
@@ -654,7 +654,7 @@ static int quad8_count_floor_read(struct counter_device *counter,
 
 static int quad8_count_mode_read(struct counter_device *counter,
 				 struct counter_count *count,
-				 enum counter_count_mode *cnt_mode)
+				 u32 *cnt_mode)
 {
 	const struct quad8 *const priv = counter_priv(counter);
 
@@ -679,7 +679,7 @@ static int quad8_count_mode_read(struct counter_device *counter,
 
 static int quad8_count_mode_write(struct counter_device *counter,
 				  struct counter_count *count,
-				  enum counter_count_mode cnt_mode)
+				  u32 cnt_mode)
 {
 	struct quad8 *const priv = counter_priv(counter);
 	unsigned int count_mode;
-- 
2.38.1

