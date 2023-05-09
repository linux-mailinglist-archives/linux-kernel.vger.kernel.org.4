Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7C26FBE05
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 05:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234788AbjEID6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 23:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234534AbjEID5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 23:57:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340D7DC73;
        Mon,  8 May 2023 20:56:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0A746440C;
        Tue,  9 May 2023 03:56:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218E2C433AA;
        Tue,  9 May 2023 03:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683604582;
        bh=7cXJeGa9L60sslKWQNgFOhVcQcwL/gbLCz39lyzO+II=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u87NvmzV0A3g/UXZvz5+iijNu5IeKf3yYmQQ+7gQjgOKgEb6yDVYY2BGzEajy/F+P
         yZ3LR/W3yNtk685Zfnnq54AeX4BQC1jYoKbcpAdFcX1cL7D74nOBE1XmhDwud7Vd7V
         3YtQuQYWbfvm6queGCSp+Zf2vnzvFqOw3uSav5GTae20swrP+HMOZh10antSHrR+my
         koctGxFj+gzGEhxJmj0qbdJPo1OFG8dxwGVH82rm1ozUjxKvXG3xAxcCsFCu6DQQY2
         U9nL+fRjhrY+FrzNTV+sDXtui7TS3+t3ueYZBpJgiYPHTrq+h0IFtY6XATydkPSv2T
         QQSK1BJ/o7ewA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>,
        andriy.shevchenko@linux.intel.com, arnd@arndb.de,
        linus.walleij@linaro.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.4 2/3] powerpc/fsl_uli1575: Allow to disable FSL_ULI1575 support
Date:   Mon,  8 May 2023 23:56:10 -0400
Message-Id: <20230509035616.60683-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230509035616.60683-1-sashal@kernel.org>
References: <20230509035616.60683-1-sashal@kernel.org>
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
index 18792a5b003a0..d239667ea72f6 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -269,7 +269,9 @@ config CPM2
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

