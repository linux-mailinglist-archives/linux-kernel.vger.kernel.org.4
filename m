Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7576464DECC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 17:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbiLOQkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 11:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiLOQj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 11:39:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B272D20F5A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 08:39:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DCDE61E41
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 16:39:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 272BFC433D2;
        Thu, 15 Dec 2022 16:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671122395;
        bh=pP6atf/tM5bifszUgRPBT2KCcUTS6tZpd3asUA7oItQ=;
        h=From:To:Cc:Subject:Date:From;
        b=m9sWbQngPK1fyTuHc3qwtSaoLjAT/wbKhmLExrAaSjv9dK3hcndZIwBXuQTjKQukg
         wS5t9ZQhKggRG5X4kl41YFzYX+2hDijJWsqFPYyb92wVKWu3KJ/ybq1oul/gFnZI1I
         FsOpUcQ116SxQNJ5UfUTxUrrYAhcTqlwqTIk/rulUDB4nmdXwMWk9eaNY/1kVVrnRU
         LDpHuhDgq114nlLtSC8iH5nVhtxDLPl0dnfCSlnXCF+sr/DZ5Ip86m5wNwRFQZ4J84
         kKE2mpBKS2fYFI3GRaPKlzCc3NOxgSO878XYHHZdjahz++7qy9449AlXX4HzLCixPS
         cayMZ8pSdiiRQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Tokunori Ikegami <ikegami.t@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Mauro Lima <mauro.lima@eclypsium.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: cfi: allow building spi-intel standalone
Date:   Thu, 15 Dec 2022 17:39:38 +0100
Message-Id: <20221215163950.649791-1-arnd@kernel.org>
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

When MTD or MTD_CFI_GEOMETRY is disabled, the spi-intel driver
fails to build, as it includes the shared CFI header:

include/linux/mtd/cfi.h:62:2: error: #warning No CONFIG_MTD_CFI_Ix selected. No NOR chip support can work. [-Werror=cpp]
   62 | #warning No CONFIG_MTD_CFI_Ix selected. No NOR chip support can work.

Use an #ifdef here to guard the settings so the header can be included
in all configurations.

Fixes: e23e5a05d1fd ("mtd: spi-nor: intel-spi: Convert to SPI MEM")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/mtd/cfi.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/mtd/cfi.h b/include/linux/mtd/cfi.h
index d88bb56c18e2..0e87b6e2faad 100644
--- a/include/linux/mtd/cfi.h
+++ b/include/linux/mtd/cfi.h
@@ -15,6 +15,7 @@
 #include <linux/mtd/cfi_endian.h>
 #include <linux/mtd/xip.h>
 
+#if IS_ENABLED(CONFIG_MTD)
 #ifdef CONFIG_MTD_CFI_I1
 #define cfi_interleave(cfi) 1
 #define cfi_interleave_is_1(cfi) (cfi_interleave(cfi) == 1)
@@ -88,7 +89,7 @@ static inline int cfi_interleave_supported(int i)
 		return 0;
 	}
 }
-
+#endif
 
 /* NB: these values must represents the number of bytes needed to meet the
  *     device type (x8, x16, x32).  Eg. a 32 bit device is 4 x 8 bytes.
-- 
2.35.1

