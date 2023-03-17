Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C917D6BED2F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 16:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjCQPoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 11:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjCQPo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 11:44:27 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7118518AA4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 08:44:24 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id bp11so2959700ilb.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 08:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jeremypeper-com.20210112.gappssmtp.com; s=20210112; t=1679067864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=21roTRUFYSLLJFessVibMx1ja8dVFGRoLEiUz4pjbZA=;
        b=N/6MwwM8MwIUoKDPjDj4TLfMyY13XYcI+GIXXkqj2rxavjlL4Ii0r7TjTXfS72MhkT
         hAW/2LTXutbrAJfpVFn7KDr1EfcE3N5WxN14n1MAYqE1HgVFbBsKlKSxhJQy6gud3Vp1
         qWt7AQK/KKaoooI5oD7y4veBl9JB/I0BADSFGbf1h/ys1/8KPqzjj2vrT7aB3IUvPfyX
         lGUm9XUUhdzkiG7aLXWnMqCZXyro/kaMry9354in7/Go/baN9Nwwmg2co5toNbFLywM+
         aYrNH8p4SDCQvr/QsFnVxboLTPfOc87i/O3S8S9LGSch1bArKbjjkHwqu8t71C9sDkoq
         MU3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679067864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=21roTRUFYSLLJFessVibMx1ja8dVFGRoLEiUz4pjbZA=;
        b=pR5QycIpFsUdwclNV1uwcGJyell5Lk7wSpCLIZvT2fJin0EG57nPoX0gd/ZnT4rrka
         7FqWl6gJtGOFFr0RIFeM916kTVpQvl5yewYqt7bOj1cvaKPsFo4Y3/8wcN+BIT+qa18k
         gGAVCdYzhZjjod4ifyudAc1wBU5fY/yXNgtJuofIRhFV1R0nGAcahpo4sq4Z8Iv1Fsy/
         p/N0EXpGhXfzzoOl4R/lbLJK/rzaHRlKJLqBUFfret1EY4TqNxu3gh8IadM8JVxvJXJv
         cTEBtOxi5Rd9oMG63imJ19XnKVA9j3auAhIifq2d/7+8xwp7blKPGOHrWN1jM6Ei2evW
         B5gg==
X-Gm-Message-State: AO0yUKV4PdNlBGglweBpvxNDQv2tQep5upD49rYFn9bETrPYVvPN9N5b
        h6zPue6M3bcoIgPn7Jfxz7z5vJrtmE/Jw9m6QyRqBg==
X-Google-Smtp-Source: AK7set9bwYplBQ2VdZd0/4DkXHKS+ixyQSVMqX9wpqeYuUD2wduc6gCnQuz7sy8U+BX3ZNArcvHcpA==
X-Received: by 2002:a92:d390:0:b0:315:851c:279 with SMTP id o16-20020a92d390000000b00315851c0279mr163405ilo.1.1679067863781;
        Fri, 17 Mar 2023 08:44:23 -0700 (PDT)
Received: from earth (70-59-64-215.mpls.qwest.net. [70.59.64.215])
        by smtp.gmail.com with ESMTPSA id r13-20020a92440d000000b00318ad12246fsm683784ila.1.2023.03.17.08.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 08:44:23 -0700 (PDT)
Received: by earth (Postfix, from userid 1000)
        id A01D01060082; Fri, 17 Mar 2023 10:44:22 -0500 (CDT)
From:   "Jeremy J. Peper" <jeremy@jeremypeper.com>
To:     linux-kernel@vger.kernel.org, arnd@kernel.org
Cc:     "Jeremy J . Peper" <jeremy@jeremypeper.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/4] adjust init logic for ts-wxl to reflect single core dev
Date:   Fri, 17 Mar 2023 10:43:44 -0500
Message-Id: <20230317154411.3727514-1-jeremy@jeremypeper.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Original code was largely copy-pasted from the reference board code, adjust pcie initialiazation to reflect the TS-WXL using the single-core variant of this SoC.
Correct pcie_port_size to be a power of 2 as required.

Signed-off-by: Jeremy J. Peper <jeremy@jeremypeper.com>
---
 arch/arm/mach-mv78xx0/buffalo-wxl-setup.c | 12 ++----------
 arch/arm/mach-mv78xx0/pcie.c              |  2 +-
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c b/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c
index 9aa765d4c..383dc6eab 100644
--- a/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c
+++ b/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c
@@ -125,16 +125,8 @@ static void __init wxl_init(void)
 
 static int __init wxl_pci_init(void)
 {
-	if (machine_is_terastation_wxl()) {
-		/*
-		 * Assign the x16 PCIe slot on the board to CPU core
-		 * #0, and let CPU core #1 have the four x1 slots.
-		 */
-		if (mv78xx0_core_index() == 0)
-			mv78xx0_pcie_init(0, 1);
-		else
-			mv78xx0_pcie_init(1, 0);
-	}
+	if (machine_is_terastation_wxl() && mv78xx0_core_index() == 0)
+                mv78xx0_pcie_init(1, 1);
 
 	return 0;
 }
diff --git a/arch/arm/mach-mv78xx0/pcie.c b/arch/arm/mach-mv78xx0/pcie.c
index 6190f538a..fa68b6394 100644
--- a/arch/arm/mach-mv78xx0/pcie.c
+++ b/arch/arm/mach-mv78xx0/pcie.c
@@ -42,7 +42,7 @@ void __init mv78xx0_pcie_id(u32 *dev, u32 *rev)
 
 u32 pcie_port_size[8] = {
 	0,
-	0x30000000,
+	0x20000000,
 	0x10000000,
 	0x10000000,
 	0x08000000,
-- 
2.30.2

