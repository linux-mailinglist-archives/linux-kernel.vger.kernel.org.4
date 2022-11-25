Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E2B63895F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 13:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiKYMIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 07:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiKYMIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 07:08:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A99B22B1C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 04:08:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A399B82A7F
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 12:08:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E25C43470;
        Fri, 25 Nov 2022 12:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669378083;
        bh=TwhSqRrup21U4CF27sTO/M6pc2iifKvlpLvARqgBso8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tlQQJPMETl9fmBXDukSJVB/J+xVITuSX3gm/HkozT6+4sh82miMixQPUN9aNwWv8a
         x2IpaZ4alkUFLFbpXFfXSzXE8h7iq/k7KM06T0Kd2wceVVmw7dmBU1+dqjTiNfuRZf
         hLuCsI5j4Y68+NnEkXgpFBAzIMOs6je7pW1J63960/clm/pxtYbB1rPQtVFFKEAsF6
         /P/IezXyogA9f4OhyHHtNPYA9yhh7J4mI5GKUxWZ9Hc1uZBvjYph0YWrKgpFVGTJm0
         Duyejm8EeY8NbCxdgFHzQMW84yHjwwQVketQGnuXTzn4vzaV7tOMeOGQCmh61YPzaj
         8Lswuge7nEUNA==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, arnd@arndb.de, akpm@linux-foundation.org,
        nathan@kernel.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        daniel@ffwll.ch, ndesaulniers@google.com, trix@redhat.com,
        harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 1/2] drm/amdgpu: Temporarily disable broken Clang builds due to blown stack-frame
Date:   Fri, 25 Nov 2022 12:07:49 +0000
Message-Id: <20221125120750.3537134-2-lee@kernel.org>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
In-Reply-To: <20221125120750.3537134-1-lee@kernel.org>
References: <20221125120750.3537134-1-lee@kernel.org>
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

calculate_bandwidth() is presently broken on all !(X86_64 || SPARC64 || ARM64)
architectures built with Clang (all released versions), whereby the stack
frame gets blown up to well over 5k.  This would cause an immediate kernel
panic on most architectures.  We'll revert this when the following bug report
has been resolved: https://github.com/llvm/llvm-project/issues/41896.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/gpu/drm/amd/display/Kconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
index 6925e0280dbe6..f4f3d2665a6b2 100644
--- a/drivers/gpu/drm/amd/display/Kconfig
+++ b/drivers/gpu/drm/amd/display/Kconfig
@@ -5,6 +5,7 @@ menu "Display Engine Configuration"
 config DRM_AMD_DC
 	bool "AMD DC - Enable new display engine"
 	default y
+	depends on BROKEN || !CC_IS_CLANG || X86_64 || SPARC64 || ARM64
 	select SND_HDA_COMPONENT if SND_HDA_CORE
 	select DRM_AMD_DC_DCN if (X86 || PPC_LONG_DOUBLE_128)
 	help
@@ -12,6 +13,12 @@ config DRM_AMD_DC
 	  support for AMDGPU. This adds required support for Vega and
 	  Raven ASICs.
 
+	  calculate_bandwidth() is presently broken on all !(X86_64 || SPARC64 || ARM64)
+	  architectures built with Clang (all released versions), whereby the stack
+	  frame gets blown up to well over 5k.  This would cause an immediate kernel
+	  panic on most architectures.  We'll revert this when the following bug report
+	  has been resolved: https://github.com/llvm/llvm-project/issues/41896.
+
 config DRM_AMD_DC_DCN
 	def_bool n
 	help
-- 
2.38.1.584.g0f3c55d4c2-goog

