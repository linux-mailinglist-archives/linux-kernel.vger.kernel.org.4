Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA99721493
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 06:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjFDE0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 00:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjFDE0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 00:26:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0283DE
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 21:26:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 688666023A
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 04:26:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2013C4339B;
        Sun,  4 Jun 2023 04:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685852763;
        bh=/YvihPZdhZSDkksrilKVclKCEw5ckynqFNfIY815en0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LNA7FOFgD2soxOOer5q31fFru2cxbCVNbsSCOfrKWFRVspzuWzwJ8se4r0dZ/+Hl2
         O9n5r3YjA6xETicK3Qjf+xp4cIN/QnLqiMUSk2FoD4fJHEVG3s9rI4d40jo3XUjpeM
         fvsg7PR6cPCy6iw9Ux0DnjnlsUituy2Oa9bmC1E/yynr12z0s4TzTFgVNoY/Tlbs0H
         4gpUuXhsy4yjhPlPiK+4kF0KL0q7gbVDFKe7FiyCs5U0Q7bKw5SFTQdLMc9aZ5j/v0
         DEfYxK6OOEYtNaQllJ8LqSfDlAy3AdVtIP7sk0xvJSkK9BJmXd/457x37hBoBLtMaE
         9DYl/Rt9SN8+w==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 2/2] mfd: rsmu: turn rsmu-{core,i2c,spi} into single-object modules
Date:   Sun,  4 Jun 2023 13:25:57 +0900
Message-Id: <20230604042557.900590-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230604042557.900590-1-masahiroy@kernel.org>
References: <20230604042557.900590-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the previous fix, these modules are built from a single C file.

Rename the source files so they match the module names.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 drivers/mfd/Makefile                     | 3 ---
 drivers/mfd/{rsmu_core.c => rsmu-core.c} | 0
 drivers/mfd/{rsmu_i2c.c => rsmu-i2c.c}   | 0
 drivers/mfd/{rsmu_spi.c => rsmu-spi.c}   | 0
 4 files changed, 3 deletions(-)
 rename drivers/mfd/{rsmu_core.c => rsmu-core.c} (100%)
 rename drivers/mfd/{rsmu_i2c.c => rsmu-i2c.c} (100%)
 rename drivers/mfd/{rsmu_spi.c => rsmu-spi.c} (100%)

diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 2a0e80f941a1..0fe213858974 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -271,9 +271,6 @@ obj-$(CONFIG_MFD_INTEL_M10_BMC_PMCI)   += intel-m10-bmc-pmci.o
 obj-$(CONFIG_MFD_ATC260X)	+= atc260x-core.o
 obj-$(CONFIG_MFD_ATC260X_I2C)	+= atc260x-i2c.o
 
-rsmu-core-objs			:= rsmu_core.o
-rsmu-i2c-objs			:= rsmu_i2c.o
-rsmu-spi-objs			:= rsmu_spi.o
 obj-$(CONFIG_MFD_RSMU_CORE)	+= rsmu-core.o
 obj-$(CONFIG_MFD_RSMU_I2C)	+= rsmu-i2c.o
 obj-$(CONFIG_MFD_RSMU_SPI)	+= rsmu-spi.o
diff --git a/drivers/mfd/rsmu_core.c b/drivers/mfd/rsmu-core.c
similarity index 100%
rename from drivers/mfd/rsmu_core.c
rename to drivers/mfd/rsmu-core.c
diff --git a/drivers/mfd/rsmu_i2c.c b/drivers/mfd/rsmu-i2c.c
similarity index 100%
rename from drivers/mfd/rsmu_i2c.c
rename to drivers/mfd/rsmu-i2c.c
diff --git a/drivers/mfd/rsmu_spi.c b/drivers/mfd/rsmu-spi.c
similarity index 100%
rename from drivers/mfd/rsmu_spi.c
rename to drivers/mfd/rsmu-spi.c
-- 
2.39.2

