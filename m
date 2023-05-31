Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E4E7183DC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237284AbjEaNws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237290AbjEaNuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:50:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99C12D7B;
        Wed, 31 May 2023 06:45:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4410636E2;
        Wed, 31 May 2023 13:45:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 633A5C433D2;
        Wed, 31 May 2023 13:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685540730;
        bh=wCDJTuhEOznNXw5xC8FsaE2KX5sRtS9zL7OApwbxwMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rGtISeRVQA8sMQ3gc1y8revb2ZcrSa0qHs/08eXUkFwCDAmLv96byapZBhAS6ohbV
         u6gS+x8N6gOkv7Sqes7fxcN3uh2dR9ftzCV1C/2JRmK8lAnTgdrIaGYLq8UQPAAiND
         EQnlO0i3E9eAMunCdu8enoERveHRsNFlQH+ot8RZkiDCxiM19m9KbRx8eqbHnaW7Ui
         5jW4BqWMa69Ds1P+Ey12GtkO2anksSChYvIAmtAoBp+pATpOVm6DL3jop5lqn5oRtW
         2Cnu8fFdcy8wxD7yWkOZqkczxzHZDYrKQ9yVFeCvCZeii7D4Dh42tGFnvNrCeh9622
         q4GucQr0zreZg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Liviu Dudau <liviu@dudau.co.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sasha Levin <sashal@kernel.org>, yury.norov@gmail.com,
        Jason@zx2c4.com, nathan@kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 15/17] mips: Move initrd_start check after initrd address sanitisation.
Date:   Wed, 31 May 2023 09:44:59 -0400
Message-Id: <20230531134502.3384828-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531134502.3384828-1-sashal@kernel.org>
References: <20230531134502.3384828-1-sashal@kernel.org>
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
index 82e44b31aad59..d91b772214b5d 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -190,10 +190,6 @@ static unsigned long __init init_initrd(void)
 		pr_err("initrd start must be page aligned\n");
 		goto disable;
 	}
-	if (initrd_start < PAGE_OFFSET) {
-		pr_err("initrd start < PAGE_OFFSET\n");
-		goto disable;
-	}
 
 	/*
 	 * Sanitize initrd addresses. For example firmware
@@ -206,6 +202,11 @@ static unsigned long __init init_initrd(void)
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

