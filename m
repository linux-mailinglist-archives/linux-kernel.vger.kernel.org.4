Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8E96CC257
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 16:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbjC1OoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 10:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbjC1OoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 10:44:15 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D051BBA8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 07:44:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4C6D9CE1C78
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 14:44:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 776CFC433D2;
        Tue, 28 Mar 2023 14:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680014651;
        bh=GjbFF5kxNZ3VUOnYj3ADIwJWyTgKZ4fW4nbBVLgpyPU=;
        h=From:To:Cc:Subject:Date:From;
        b=SHBSwfpjaX4oP6cW5QVDvPrlYqVd4uHOXupPZOUUTkB0o8HtGQtLjhyR6AbEcoOK0
         tFwOeiVZkrYmbil21063Xaefm/LQ/zmjFF6ik6SUF7nRcKY6F2IAPKS1VZQ8NGo39X
         u3ka72zPzjlYEC9cKgAsiMnk20ZONUqNLH2tFrSZ2H7s6rKQEaBKLgMvyvhl0/tdyP
         ngfm8hnIpf9g8xTBVlJugDT7vM0H49dR4nWNAd3eYspE4KuwW5VXM4QzOYEgk33fiS
         3Y1u73HvQMr0CVjY0c7eD7UM6C9yCpDbGJaJGG1yN9Ru+UquPK7L2BPVZoYin4e2cr
         PyJtvK4ColtEw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Zaid Al-Bassam <zalbassam@google.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: mach-virt: fix PMUv3 dependendency
Date:   Tue, 28 Mar 2023 16:43:44 +0200
Message-Id: <20230328144405.1527555-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Selecting a ARM_PMUV3 from a platform option breaks the build
when CONFIG_ARM_PMU is not already set:

WARNING: unmet direct dependencies detected for ARM_PMUV3
  Depends on [n]: PERF_EVENTS [=y] && HW_PERF_EVENTS [=n] && (ARM [=y] && CPU_V7 [=y] || ARM64)
  Selected by [y]:
  - ARCH_VIRT [=y] && ARCH_MULTI_V7 [=y] && PERF_EVENTS [=y]

drivers/perf/arm_pmuv3.c:48:9: error: 'PERF_MAP_ALL_UNSUPPORTED' undeclared here (not in a function)
   48 |         PERF_MAP_ALL_UNSUPPORTED,
      |         ^~~~~~~~~~~~~~~~~~~~~~~~
drivers/perf/arm_pmuv3.c:63:9: error: 'PERF_CACHE_MAP_ALL_UNSUPPORTED' undeclared here (not in a function)
   63 |         PERF_CACHE_MAP_ALL_UNSUPPORTED,
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/perf/arm_pmuv3.c:65:10: error: implicit declaration of function 'C' [-Werror=implicit-function-declaration]
   65 |         [C(L1D)][C(OP_READ)][C(RESULT_ACCESS)]  = ARMV8_PMUV3_PERFCTR_L1D_CACHE,

Fixes: 3b16f6268e66 ("ARM: mach-virt: Select PMUv3 driver by default")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e8ccacb3653b..700458c7cace 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -397,7 +397,7 @@ config ARCH_VIRT
 	select ARM_GIC_V3
 	select ARM_GIC_V3_ITS if PCI
 	select ARM_PSCI
-	select ARM_PMUV3 if PERF_EVENTS
+	select ARM_PMUV3 if PERF_EVENTS && ARM_PMU
 	select HAVE_ARM_ARCH_TIMER
 
 config ARCH_AIROHA
-- 
2.39.2

