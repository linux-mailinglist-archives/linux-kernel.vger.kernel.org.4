Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D636134AD
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 12:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiJaLmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 07:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiJaLmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 07:42:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D4FE0E8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 04:42:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34C38611C6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 11:42:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 901D7C433D6;
        Mon, 31 Oct 2022 11:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667216535;
        bh=REEXBpGsJ/5HJJBTb8bvjCrt7xGBPTLUrPoeLyu7qAI=;
        h=From:To:Cc:Subject:Date:From;
        b=iN3bK+szPIK/wxm7FMhotMqP8dyRkDuRRY+Og8xbKyG4nvaojdWb31GuA5cqu/PVu
         nZ60IrXVp/K73990UBLSuK0HZnnV+Cr1XMyJCBWxv20otbHGGz9ElJzrt03LRtQHJ7
         FuX+uG6507njKT2EPf6KG+yqtL73dp2POx82aFILzyIDvjljKxX9la512kwWeCCF83
         qjcmGm7JwQDlnOQxSx6Q07w9RAcC/MMHgDzGp8cNAP7HwAffQhc5wImt7ZFTbrHJBn
         d0+7BU2YzWlzoPwPAfwD+lmuHQEFhG5NRSj0zDblILbbaqWQG2nyHvZyS0Fiu8+7Vw
         VNjlayeWSXHRg==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Martin Liska <mliska@suse.cz>
Subject: [PATCH] init: Kconfig (gcc13): disable -Warray-bounds on gcc-13 too
Date:   Mon, 31 Oct 2022 12:42:12 +0100
Message-Id: <20221031114212.10266-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.38.1
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

Nobody took the chance to fix (or at least localize) the warnings since
commit f0be87c42cbd (gcc-12: disable '-Warray-bounds' universally for
now). The new compiler (gcc-13) still reports issues like:
  drivers/gpu/drm/amd/display/dc/core/dc_stream.c: In function 'dc_stream_remove_writeback':
  drivers/gpu/drm/amd/display/dc/core/dc_stream.c:531:55: error: array subscript -1 is below array bounds of 'struct dc_writeback_info[1]' [-Werror=array-bounds]

Note that 'j' can never be negative. So disable the warning on gcc-13
too until someone takes time to localize them.

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Martin Liska <mliska@suse.cz>
Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 init/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 8fe07ab401b5..51f0fe64022d 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -900,14 +900,14 @@ config CC_IMPLICIT_FALLTHROUGH
 	default "-Wimplicit-fallthrough=5" if CC_IS_GCC && $(cc-option,-Wimplicit-fallthrough=5)
 	default "-Wimplicit-fallthrough" if CC_IS_CLANG && $(cc-option,-Wunreachable-code-fallthrough)
 
-# Currently, disable gcc-12 array-bounds globally.
+# Currently, disable gcc-12 & 13 array-bounds globally.
 # We may want to target only particular configurations some day.
 config GCC12_NO_ARRAY_BOUNDS
 	def_bool y
 
 config CC_NO_ARRAY_BOUNDS
 	bool
-	default y if CC_IS_GCC && GCC_VERSION >= 120000 && GCC_VERSION < 130000 && GCC12_NO_ARRAY_BOUNDS
+	default y if CC_IS_GCC && GCC_VERSION >= 120000 && GCC_VERSION < 140000 && GCC12_NO_ARRAY_BOUNDS
 
 #
 # For architectures that know their GCC __int128 support is sound
-- 
2.38.1

