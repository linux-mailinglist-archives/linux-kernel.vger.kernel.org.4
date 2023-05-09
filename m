Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C356FBE01
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 05:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234704AbjEID6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 23:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234615AbjEID5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 23:57:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173CADC64;
        Mon,  8 May 2023 20:56:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20435643FA;
        Tue,  9 May 2023 03:56:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC25C433D2;
        Tue,  9 May 2023 03:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683604567;
        bh=3awfLUxgFh+sXJD7N4I6ldRMx6yhH/b34e6kdYaeaZ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T98HpLJldDKAc2k7qnkJpCsfPw7I99V2b8S6RLRsqKKBncWoXikL1UY2u8de5Y750
         oXLgahRCG74EoNNE+fZyRV7a0yLxvtiJ9kKrwy1yZ9mNXMBx3wykgm1WKEJ/xLmaKw
         45kgpx2T1yv8j34KQQJR4FVzKgGt7dWugJzJlAc5x0GiHpT3IhrgO93Lmm5S+EEUi0
         AFvK/SGFPb+h4kztOWhdbc2Wc8/GLa6YsQxT0Q+d/YMKycMCjKznqZPV9yRrr8JXrA
         SCXPn3VBgHM+em4Ziw3fM+VTZgjpiGdKCT4G6z+Dvz9rT3v+BVe3WRpW4w/0TW7VbX
         MGqYfGT8Cz36Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>,
        andriy.shevchenko@linux.intel.com, linus.walleij@linaro.org,
        arnd@arndb.de, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.10 2/3] powerpc/fsl_uli1575: Allow to disable FSL_ULI1575 support
Date:   Mon,  8 May 2023 23:55:57 -0400
Message-Id: <20230509035602.60613-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230509035602.60613-1-sashal@kernel.org>
References: <20230509035602.60613-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

[ Upstream commit 22fdf79171e8509db54599fd2c05ef0022ee83f5 ]

ULI1575 PCIe south bridge exists only on some Freescale boards. Allow to
disable CONFIG_FSL_ULI1575 symbol when it is not explicitly selected and
only implied. This is achieved by marking symbol as visible by providing
short description. Also adds dependency for this symbol to prevent enabling
it on platforms on which driver does not compile.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20230409000812.18904-7-pali@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 7a5e8f4541e3f..6fb71f00a3ea3 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -258,7 +258,9 @@ config CPM2
 	  on it (826x, 827x, 8560).
 
 config FSL_ULI1575
-	bool
+	bool "ULI1575 PCIe south bridge support"
+	depends on FSL_SOC_BOOKE || PPC_86xx
+	select FSL_PCI
 	select GENERIC_ISA_DMA
 	help
 	  Supports for the ULI1575 PCIe south bridge that exists on some
-- 
2.39.2

