Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31EFE62FE60
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 20:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbiKRTxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 14:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbiKRTxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 14:53:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFBDB8F85;
        Fri, 18 Nov 2022 11:53:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 888BB6251B;
        Fri, 18 Nov 2022 19:53:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51275C4347C;
        Fri, 18 Nov 2022 19:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668801202;
        bh=jCvzmbRIXG2v1BOityBLpJImGOs/YCfsYemgrFfs7aA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sbJP75T3jcPRTR/gj908EXIbYcArqm1r3Zd30/w7+muYa8r8fBi5VKZuknJ6+i2WN
         Ay3MhiWJDrXTOfqhLn8J4MRNxcmNxUEN9YufITNGnMEoUOuDVNpp3RUO2/Zftr76Yf
         sNmxcR86NTp2JROrtlHM/eBUsNoMiXJ2qnUgdN2tL+euM2CJY5D1QZdWpNfsYHAAoj
         VXZ1wCLoT85T9wEPrrebSD0zojMLfXkHnnQ3uIw1pyDzxyHFMGgG9ftEr6lIXdqbIM
         NgQkmhx/37scwbSgv63LST3wr9m39jvqG/unz7OY6vmbTi3qMy4aUwmmNw9DEF1sbC
         5y81cPtJISopQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 6/6] kbuild: check Make version
Date:   Sat, 19 Nov 2022 04:53:07 +0900
Message-Id: <20221118195307.86049-7-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221118195307.86049-1-masahiroy@kernel.org>
References: <20221118195307.86049-1-masahiroy@kernel.org>
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

This is implemented based on test-le. It will work until GNU Make 10
is released.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile b/Makefile
index 93e5749ace55..979363590bd7 100644
--- a/Makefile
+++ b/Makefile
@@ -368,6 +368,9 @@ else # !mixed-build
 
 include $(srctree)/scripts/Kbuild.include
 
+# Check for the minimal Make version
+$(if $(call test-lt, $(MAKE_VERSION), 3.82), $(error Make $(MAKE_VERSION) is too old))
+
 # Read KERNELRELEASE from include/config/kernel.release (if it exists)
 KERNELRELEASE = $(call read-file, include/config/kernel.release)
 KERNELVERSION = $(VERSION)$(if $(PATCHLEVEL),.$(PATCHLEVEL)$(if $(SUBLEVEL),.$(SUBLEVEL)))$(EXTRAVERSION)
-- 
2.34.1

