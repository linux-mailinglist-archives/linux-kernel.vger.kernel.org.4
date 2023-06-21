Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26050738F62
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 21:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbjFUTA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 15:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjFUTAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 15:00:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5B2B4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 12:00:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27EE0616A2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 19:00:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B382C433C9;
        Wed, 21 Jun 2023 19:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687374053;
        bh=wCtBx+btmEgXd4oHrHrBecjQgIOZOa4Ob05hmny7ong=;
        h=From:To:Cc:Subject:Date:From;
        b=UD6zMebW8v4rlI15uda5rm5vBtPpQemAWU+RHv65YDQt5kS8uIvAdhIdZqXWeSm8a
         RvZa57VSMtudntxVd5mpTTJQZy96QRxiQO8GyGlQ71NpaVjC3HERMHV3Mke/Brss1D
         GF3CI/rbBQcc3dRiQ/LYX+Dwqz35FsqitIMNPm5h+2N8nl2a2nWxPBAx5PKH/IEZXq
         s4HsH6tvowvJzzj2TsCRxvi3N7UOcl5ux6sEAWCX9jN67KFAGN7rPt0jLwSM0J0JQ+
         S99CwpbpB69iEm510ZVFbOGuFn22dlQBGalESET3gvsAqWGQMih8KwTSusRlBbKHBw
         T5AA8uIDjDUYw==
From:   Conor Dooley <conor@kernel.org>
To:     linux-riscv@lists.infradead.org
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] RISC-V: make ARCH_THEAD preclude XIP_KERNEL
Date:   Wed, 21 Jun 2023 20:00:31 +0100
Message-Id: <20230621-panorama-stuffing-f24b26546972@spud>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1448; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=DKC0lvBVjPZAhDU4YTCtHGJdKRYVtZU6wqvi6iUcYRc=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCmTPc78tOsQ3d+/6qTti7LOoA1PpzP7rrzHtIj3ZVPt/ 8Ozd1+O6ihlYRDjYJAVU2RJvN3XIrX+j8sO5563MHNYmUCGMHBxCsBEtFoZGa5YvXy+b8adD3G2 /ntunuGLW8ay6d52hVV7FTbZHz5+w8CPkeFB4rPzaXOFF10MW83VwJ7geDK0sk7MV+GUsvGKf+e 8p/EDAA==
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Randy reported build errors in linux-next where XIP_KERNEL was enabled.
ARCH_THEAD requires alternatives to support the non-standard ISA
extensions used by the THEAD cores, which are mutually exclusive with
XIP kernels. Clone the dependency list from the Allwinner entry, since
Allwinner's D1 uses T-Head cores with the same non-standard extensions.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
Link: https://lore.kernel.org/all/ab38f6af-cb68-a918-1a63-2e7c927a8ffc@infradead.org/
Fixes: da47ce003963 ("riscv: Add the T-HEAD SoC family Kconfig option")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
CC: Paul Walmsley <paul.walmsley@sifive.com>
CC: Palmer Dabbelt <palmer@dabbelt.com>
CC: Albert Ou <aou@eecs.berkeley.edu>
CC: Jisheng Zhang <jszhang@kernel.org>
CC: linux-riscv@lists.infradead.org
CC: linux-kernel@vger.kernel.org
---
 arch/riscv/Kconfig.socs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index ce10a38dff37..6833d01e2e70 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -43,6 +43,7 @@ config ARCH_SUNXI
 
 config ARCH_THEAD
 	bool "T-HEAD RISC-V SoCs"
+	depends on MMU && !XIP_KERNEL
 	select ERRATA_THEAD
 	help
 	  This enables support for the RISC-V based T-HEAD SoCs.
-- 
2.39.2

