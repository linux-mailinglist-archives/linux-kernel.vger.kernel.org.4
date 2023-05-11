Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774E86FF04E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 12:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237788AbjEKK65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 06:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237235AbjEKK6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 06:58:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031DAFA;
        Thu, 11 May 2023 03:58:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88AFF64C3A;
        Thu, 11 May 2023 10:58:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2170EC433D2;
        Thu, 11 May 2023 10:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683802731;
        bh=qcDiAjFqWhhByq5JwWK2mEEaI3nzFryjK7tJr89pp7Q=;
        h=From:To:Cc:Subject:Date:From;
        b=CEjFQMdf7Jj+aStt5qyHlb4JjvgF+r2KsnPRRnT92mEJ4Ql/TTUFxzxMdp5u/oYwq
         YbNCifcWA4EGsPuxb5BcydH8k29bN+7DjmaWWQ5MHQahMZ5/S6uiBlTBbAlTgCg/BK
         dpm0O8SxJ4p3e/MDSHE9yevb67H1r5plm8qSDW391Nru2bqFI1RYQl7w7hkhA9FZLr
         TaZtL4XuIwtpS/VvLVYyF4cw6mc+F78sxLVVwxozf2xj8jwYOpSdOdexjwIDtzfUF7
         f4QiQ3aGJWcA6Y4PutrmGEdiRHDzkZCA1PikycZdA/1trPHaWnq9cP886iHxA5kahq
         6c+/3EBqQJLOQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, stable@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] clk: pxa: fix NULL pointer dereference in pxa3xx_clk_update_accr
Date:   Thu, 11 May 2023 12:58:33 +0200
Message-Id: <20230511105845.299859-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

sparse points out an embarrasing bug in an older patch of mine,
which uses the register offset instead of an __iomem pointer:

drivers/clk/pxa/clk-pxa3xx.c:167:9: sparse: sparse: Using plain integer as NULL pointer

Unlike sparse, gcc and clang ignore this bug and fail to warn
because a literal '0' is considered a valid representation of
a NULL pointer.

Fixes: 3c816d950a49 ("ARM: pxa: move clk register definitions to driver")
Cc: stable@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202305111301.RAHohdob-lkp@intel.com/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/clk/pxa/clk-pxa3xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/pxa/clk-pxa3xx.c b/drivers/clk/pxa/clk-pxa3xx.c
index 42958a542662..621e298f101a 100644
--- a/drivers/clk/pxa/clk-pxa3xx.c
+++ b/drivers/clk/pxa/clk-pxa3xx.c
@@ -164,7 +164,7 @@ void pxa3xx_clk_update_accr(u32 disable, u32 enable, u32 xclkcfg, u32 mask)
 	accr &= ~disable;
 	accr |= enable;
 
-	writel(accr, ACCR);
+	writel(accr, clk_regs + ACCR);
 	if (xclkcfg)
 		__asm__("mcr p14, 0, %0, c6, c0, 0\n" : : "r"(xclkcfg));
 
-- 
2.39.2

