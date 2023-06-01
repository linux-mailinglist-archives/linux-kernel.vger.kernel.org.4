Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA87571A259
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 17:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbjFAPT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234915AbjFAPTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:19:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C626DB3;
        Thu,  1 Jun 2023 08:18:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F85664675;
        Thu,  1 Jun 2023 15:18:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C525FC4339C;
        Thu,  1 Jun 2023 15:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685632727;
        bh=zt7KZMmx/oJBYdfFdtNG8ZQh916ADU8eGaXVMVWxHLE=;
        h=From:To:Cc:Subject:Date:From;
        b=lOsYcDeZ6FDbxshIu7kdv+ump9fNlSvRpNRm6K6kLV3mxZKqoX7/SeZaOn5gv9gYd
         jUGbk6YWUoRlA6uXYqUPeKRY+B/G7Gtt6DRjGqb/rofNXy1cgD4lv6tend69ihuddC
         /Xs5cKYacjSj7o/Ch3PcbC+S5wqM/cwEt5cNvibv8wmRxcg74v43euAPEUPlY7fG5a
         I0xFlAuT7pGfRRlcmRdc3Ln/9JyPCzJ1R8eqd4eYbhqcuvyFxOQPjvsczQhU1vqyNd
         nWIyEt9HR0ur9SlpXBuqSzw77gRjWK2aT6fdvn0eK1AeOTk3eXPGF0sk7UpCqBMB8s
         Un4YXvEvE8kcg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     kasan-dev@googlegroups.com, ryabinin.a.a@gmail.com
Cc:     glider@google.com, andreyknvl@gmail.com, dvyukov@google.com,
        vincenzo.frascino@arm.com, elver@google.com,
        linux-media@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, ardb@kernel.org, mchehab@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, llvm@lists.linux.dev
Subject: [PATCH] [RFC] ubsan: disallow bounds checking with gcov on broken gcc
Date:   Thu,  1 Jun 2023 17:18:11 +0200
Message-Id: <20230601151832.3632525-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Combining UBSAN and GCOV in randconfig builds results in a number of
stack frame size warnings, such as:

crypto/twofish_common.c:683:1: error: the frame size of 2040 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c:1589:1: error: the frame size of 1696 bytes is larger than 1400 bytes [-Werror=frame-larger-than=]
drivers/media/platform/verisilicon/hantro_g2_vp9_dec.c:754:1: error: the frame size of 1260 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
drivers/staging/media/ipu3/ipu3-css-params.c:1206:1: error: the frame size of 1080 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
drivers/staging/media/rkvdec/rkvdec-vp9.c:1042:1: error: the frame size of 2176 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
drivers/staging/media/rkvdec/rkvdec-vp9.c:995:1: error: the frame size of 1656 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]

I managed to track this down to the -fsanitize=bounds option clashing
with the -fprofile-arcs option, which leads a lot of spilled temporary
variables in generated instrumentation code.

Hopefully this can be addressed in future gcc releases the same way
that clang handles the combination, but for existing compiler releases,
it seems best to disable one of the two flags. This can be done either
globally by just not passing both at the same time, or locally using
the no_sanitize or no_instrument_function attributes in the affected
functions.

Try the simplest approach here, and turn off -fsanitize=bounds on
gcc when GCOV is enabled, leaving the rest of UBSAN working. Doing
this globally also helps avoid inefficient code from the same
problem that did not push the build over the warning limit.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/stable/6b1a0ee6-c78b-4873-bfd5-89798fce9899@kili.mountain/
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=110074
Link: https://godbolt.org/z/zvf7YqK5K
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/Kconfig.ubsan | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index f7cbbad2bb2f4..8f71ff8f27576 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -29,6 +29,8 @@ config UBSAN_TRAP
 
 config CC_HAS_UBSAN_BOUNDS_STRICT
 	def_bool $(cc-option,-fsanitize=bounds-strict)
+	# work around https://gcc.gnu.org/bugzilla/show_bug.cgi?id=110074
+	depends on GCC_VERSION > 140000 || !GCOV_PROFILE_ALL
 	help
 	  The -fsanitize=bounds-strict option is only available on GCC,
 	  but uses the more strict handling of arrays that includes knowledge
-- 
2.39.2

