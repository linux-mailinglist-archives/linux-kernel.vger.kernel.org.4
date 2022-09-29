Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE975EFCE5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 20:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbiI2SSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 14:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235785AbiI2SS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 14:18:26 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890091F7ED2;
        Thu, 29 Sep 2022 11:18:21 -0700 (PDT)
Received: from zoe.. (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 28TIHKFu020165;
        Fri, 30 Sep 2022 03:17:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 28TIHKFu020165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1664475441;
        bh=im3I7uBc1WIhFbxXT+owODuKLCJ4ysSQNjRbCMjInPE=;
        h=From:To:Cc:Subject:Date:From;
        b=cXrfyvfavVvpa5eeLgTX9opdxrYkvqUYC2e5hBl4uJ1mWlwmfl0WSwF+uFVWNB3E6
         IwT3dRcpD1h97NS684YjJ2b8bKE+x6UcdOgiWkKxBbrEnEx2gdZSLt7pH8Ze0XAV5O
         otLOq40THZMS+FVg0/otqsiqqMeEtRJdQUFALDQeNXG3kHw1B0d2WkXhOAEAnSRhU4
         xDW160Ti+hv7weH9gU+m9lZTBx7XI1xnY6x3OhmU0f2lxh1Mmks15EZ04vi9vPUHnG
         YlWshr8M0LoO0/dNHChzogXfaSgjvT/mYr5dQVxAjzoU80VaBvHzNN8A8IcLZTbLfK
         U4YDL+hp5WGSA==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH] ia64: simplify esi object addition in Makefile
Date:   Fri, 30 Sep 2022 03:17:15 +0900
Message-Id: <20220929181715.2504087-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_IA64_ESI is a bool option. I do not know why the Makefile was
written like this, but this should not have any functional change.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/ia64/kernel/Makefile | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/ia64/kernel/Makefile b/arch/ia64/kernel/Makefile
index 4a1fcb121dda..ae9ff07de4ab 100644
--- a/arch/ia64/kernel/Makefile
+++ b/arch/ia64/kernel/Makefile
@@ -34,10 +34,7 @@ mca_recovery-y			+= mca_drv.o mca_drv_asm.o
 obj-$(CONFIG_IA64_MC_ERR_INJECT)+= err_inject.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 
-obj-$(CONFIG_IA64_ESI)		+= esi.o
-ifneq ($(CONFIG_IA64_ESI),)
-obj-y				+= esi_stub.o	# must be in kernel proper
-endif
+obj-$(CONFIG_IA64_ESI)		+= esi.o esi_stub.o # must be in kernel proper
 obj-$(CONFIG_INTEL_IOMMU)	+= pci-dma.o
 
 obj-$(CONFIG_ELF_CORE)		+= elfcore.o
-- 
2.34.1

