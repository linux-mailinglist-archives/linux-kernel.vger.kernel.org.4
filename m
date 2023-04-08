Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78456DBB21
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 15:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjDHNY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 09:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjDHNYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 09:24:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C321D532
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 06:24:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 601C2614BF
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 13:24:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9066FC433A0;
        Sat,  8 Apr 2023 13:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680960248;
        bh=1B1bdtjGi0qphccKaW9xvXzqnYHpNRSwmcqFmuJLGRY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ovdA74ZmhTEzQHM1M24Vjg5ZfQdf6MhINoVwXgCNOzI+f6Y24yYNafplYhnMEN2AU
         2BocP5u05IeYQc27SIuh84Qz5nY0Z06/kgX0/OCqkIhOvy8lhOXmb+URVTO3Yf1S6I
         VK+I6E/f0CZeUgqQRzbp8rsLP7HYcTrtDWKbKKK+S+i6D6hadTUNmSlShrGwZA/+9H
         Xbl+SHmzOwgecuHkHe2ejkKUy8XAh0+VDqUitOR+j8du31pqnGBHzOE2MxeTjZegET
         NJJVNNNR9gRdwQxXnkK2wjLIOoj0qRxEoyhj7sIbA2wau+vP3QVHUdTUDOvbznJcfM
         O06DLaM1oFyBw==
Received: by pali.im (Postfix)
        id 0DE2D20A8; Sat,  8 Apr 2023 15:24:06 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] powerpc/mpc85xx: mpc85xx_rdb: Do not automatically select FSL_ULI1575
Date:   Sat,  8 Apr 2023 15:21:48 +0200
Message-Id: <20230408132151.8902-6-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230408132151.8902-1-pali@kernel.org>
References: <20230408132151.8902-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boards provided by CONFIG_MPC85xx_RDB option do not initialize
fsl_uli1575.c driver. So remove explicit select dependency on it.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/powerpc/platforms/85xx/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index b92cb2b4d54d..a8ce6616fd0a 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -90,7 +90,6 @@ config MPC85xx_RDB
 	bool "Freescale P102x MBG/UTM/RDB and P2020 RDB"
 	select PPC_I8259
 	select DEFAULT_UIMAGE
-	select FSL_ULI1575 if PCI
 	select SWIOTLB
 	help
 	  This option enables support for the P1020 MBG PC, P1020 UTM PC,
-- 
2.20.1

