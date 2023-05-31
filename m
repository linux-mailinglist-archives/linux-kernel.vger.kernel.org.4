Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3511718486
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 16:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236459AbjEaOQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 10:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237614AbjEaOPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 10:15:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D5F1735;
        Wed, 31 May 2023 07:13:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2499263B53;
        Wed, 31 May 2023 13:43:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B317BC433A8;
        Wed, 31 May 2023 13:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685540638;
        bh=BD8uVK2dm7R6ocCGbEgiBV1FA2crFyMr0HYhvnuN3FU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LZFm3rx0RifLNknBh82fb5YBTY/G3sksbG+gdNi5/DC1FIS+smr+r/8wCBV4I1AEq
         ijQyMlCcAu7LswRVKpA71pPyk0rq/p3odzEp3gQIGAIO6NGhvCswV5xED7n7l2HdMh
         qwHCUy5eK0TX0+pSpBq/WMevhOi0JGACWgSyoeaM1us/SYRTrgHMfiIsnhMdAc70Y8
         2RF+VRJRRkxyCwqApWmn8L6LY0oTFRznlUItB/dqP2mWggOFLgz0yiTiwpEdeuBDZG
         LUy1Fn4URrwe6O7F9SCBbd+W1Ppd/ERQxaNyqZ1uVpaxJr96t42yCrWo1Q3LU0oIYu
         LP01lJd70n7KQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Liviu Dudau <liviu@dudau.co.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sasha Levin <sashal@kernel.org>, Jason@zx2c4.com,
        nathan@kernel.org, yury.norov@gmail.com, linux-mips@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 20/24] mips: Move initrd_start check after initrd address sanitisation.
Date:   Wed, 31 May 2023 09:43:16 -0400
Message-Id: <20230531134320.3384102-20-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531134320.3384102-1-sashal@kernel.org>
References: <20230531134320.3384102-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index ef73ba1e0ec10..c8d849d8a8440 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -156,10 +156,6 @@ static unsigned long __init init_initrd(void)
 		pr_err("initrd start must be page aligned\n");
 		goto disable;
 	}
-	if (initrd_start < PAGE_OFFSET) {
-		pr_err("initrd start < PAGE_OFFSET\n");
-		goto disable;
-	}
 
 	/*
 	 * Sanitize initrd addresses. For example firmware
@@ -172,6 +168,11 @@ static unsigned long __init init_initrd(void)
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

