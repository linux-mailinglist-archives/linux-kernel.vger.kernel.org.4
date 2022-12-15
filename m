Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE89264DEBC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 17:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiLOQfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 11:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiLOQfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 11:35:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2162232B9E
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 08:35:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C99C5B81C03
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 16:35:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E81A8C433EF;
        Thu, 15 Dec 2022 16:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671122118;
        bh=g+llGdryqrPBn/E1pMNZ7VfxGoucOwyeg4NbT0i9qN8=;
        h=From:To:Cc:Subject:Date:From;
        b=OZz69KEVu8zw0awttRT/LTDhwdgnAiiEQ3EocltG1q6SLSM8KtEx7EQyXhCLAnyii
         O1Kzsa4o6oD4E+IQqqtzp0TUhOb2sYgz0xJoN48kKczNb8tWH3rr6BnvVTKnXtJFNJ
         zvnuuhxTpy39u+WQh7GwwPR18zp/97T+J76POMvfGJIZLRjzasFliCpUyUwzdbelhn
         I7GwLL1ijFBg188O8SIum+p6nQqA+9ng8c/ULmaTfUgK7Q9y/cdeygGngaWhxNxXr/
         tQzh05kPt49OJITLM+ni/Pbf1f6V2XOdu5ZSM8hhZPH2LTlGvCXb8NgJ+OZZivTLZm
         7ky1rgk65x9Qw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>,
        Daniel Latypov <dlatypov@google.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] drm/tests: reduce drm_mm_test stack usage
Date:   Thu, 15 Dec 2022 17:34:49 +0100
Message-Id: <20221215163511.266214-1-arnd@kernel.org>
X-Mailer: git-send-email 2.35.1
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

The check_reserve_boundaries function uses a lot of kernel stack,
and it gets inlined by clang, which makes __drm_test_mm_reserve
use even more of it, to the point of hitting the warning limit:

drivers/gpu/drm/tests/drm_mm_test.c:344:12: error: stack frame size (1048) exceeds limit (1024) in '__drm_test_mm_reserve' [-Werror,-Wframe-larger-than]

When building with gcc, this does not happen, but the structleak
plugin can similarly increase the stack usage and needs to be
disabled, as we do for all other kunit users.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/tests/Makefile      | 2 ++
 drivers/gpu/drm/tests/drm_mm_test.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tests/Makefile b/drivers/gpu/drm/tests/Makefile
index b29ef1085cad..f896ef85c2f2 100644
--- a/drivers/gpu/drm/tests/Makefile
+++ b/drivers/gpu/drm/tests/Makefile
@@ -12,3 +12,5 @@ obj-$(CONFIG_DRM_KUNIT_TEST) += \
 	drm_mm_test.o \
 	drm_plane_helper_test.o \
 	drm_rect_test.o
+
+CFLAGS_drm_mm_test.o := $(DISABLE_STRUCTLEAK_PLUGIN)
diff --git a/drivers/gpu/drm/tests/drm_mm_test.c b/drivers/gpu/drm/tests/drm_mm_test.c
index 89f12d3b4a21..90a5becc99b8 100644
--- a/drivers/gpu/drm/tests/drm_mm_test.c
+++ b/drivers/gpu/drm/tests/drm_mm_test.c
@@ -298,7 +298,7 @@ static bool expect_reserve_fail(struct kunit *test, struct drm_mm *mm, struct dr
 	return false;
 }
 
-static bool check_reserve_boundaries(struct kunit *test, struct drm_mm *mm,
+static bool noinline_for_stack check_reserve_boundaries(struct kunit *test, struct drm_mm *mm,
 				     unsigned int count,
 				     u64 size)
 {
-- 
2.35.1

