Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CCF7183F7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237471AbjEaNyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237561AbjEaNuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:50:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DB73A89;
        Wed, 31 May 2023 06:46:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 078B563B35;
        Wed, 31 May 2023 13:46:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91826C433D2;
        Wed, 31 May 2023 13:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685540785;
        bh=Nf0sgHpLiHFr81n72nHj6LFAvUY7W1n5UsPyv7F0P9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p3iIMn5Qy2q7OVELGFiL7yeM9z+RNzKe2+vOg4R0bDoZkvA9izzEzhhkIuPQ6DiL4
         a0A2DbJIF+YwE1IqPnqCLo3FPhSLD670Mj/ET0W/dmoOQNTsYhYqwNXpp8Eb8/8y4k
         kDKA9W6xcrYbELybw6UFVI7wR4zYbHXNAN2Xnc3gpWm/H7yQI+h2KPDODqg8ifCIx7
         kVf6V6R34/5v55h8hwSP3Di2coGnTWJZ/t/SBX+6mWI9cAWogzMfIsfIvLNmzaci8a
         UPdudar1+kOeIeS0XuRYUpaz8PZoDngInT254bwn2RxigBnxR2Z3UcY5HYbpKcBI8Y
         dxAPbazGeA8oQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Liviu Dudau <liviu@dudau.co.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sasha Levin <sashal@kernel.org>, nathan@kernel.org,
        yury.norov@gmail.com, Jason@zx2c4.com, linux-mips@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 09/10] mips: Move initrd_start check after initrd address sanitisation.
Date:   Wed, 31 May 2023 09:46:05 -0400
Message-Id: <20230531134606.3385210-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531134606.3385210-1-sashal@kernel.org>
References: <20230531134606.3385210-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liviu Dudau <liviu@dudau.co.uk>

[ Upstream commit 4897a898a216058dec55e5e5902534e6e224fcdf ]

PAGE_OFFSET is technically a virtual address so when checking the value of
initrd_start against it we should make sure that it has been sanitised from
the values passed by the bootloader. Without this change, even with a bootloader
that passes correct addresses for an initrd, we are failing to load it on MT7621
boards, for example.

Signed-off-by: Liviu Dudau <liviu@dudau.co.uk>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/kernel/setup.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index abd7ee9e90ab0..d205d3875e2c2 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -257,10 +257,6 @@ static unsigned long __init init_initrd(void)
 		pr_err("initrd start must be page aligned\n");
 		goto disable;
 	}
-	if (initrd_start < PAGE_OFFSET) {
-		pr_err("initrd start < PAGE_OFFSET\n");
-		goto disable;
-	}
 
 	/*
 	 * Sanitize initrd addresses. For example firmware
@@ -273,6 +269,11 @@ static unsigned long __init init_initrd(void)
 	initrd_end = (unsigned long)__va(end);
 	initrd_start = (unsigned long)__va(__pa(initrd_start));
 
+	if (initrd_start < PAGE_OFFSET) {
+		pr_err("initrd start < PAGE_OFFSET\n");
+		goto disable;
+	}
+
 	ROOT_DEV = Root_RAM0;
 	return PFN_UP(end);
 disable:
-- 
2.39.2

