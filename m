Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1107183FE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237207AbjEaNye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237447AbjEaNxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:53:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D88448C;
        Wed, 31 May 2023 06:47:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C63C863B9B;
        Wed, 31 May 2023 13:46:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF3AC433EF;
        Wed, 31 May 2023 13:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685540764;
        bh=iNSIX/q69BO9D9C8quIGMYIKKtzREPqOzGa8/KIbOUY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UVEcZ7G5AHUfhPr1OhmwE0CLaXJuu0CCz5ksVipt9ls6bm8aMpjrxNP+cpwRwU1pK
         WYV8YuI8B98YOITXHnmU3OB2PQsDHFwrB7IXHs+AjElpffCoOsLPsHVM5SOx4N53bk
         F/v2jtjtknpK4tvF8o9rMbZddwz2xzBez+p6NTnQyahFPmBckZ4khBu+y9pngw3tI0
         b7+c1wgdsIMNYwWennYwWTyEoyOJNxAB8/d0DwfprQqYyggHobXDZiNezyK6sI+ahZ
         ES9ctoZtnYBXC0JLR3BnNq2ZQw1zyxyjpB5d+x8L3Y95eVqol7jEsC0ciPRRwm68nq
         t9HEan2xLOKVQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Liviu Dudau <liviu@dudau.co.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sasha Levin <sashal@kernel.org>, nathan@kernel.org,
        yury.norov@gmail.com, Jason@zx2c4.com, linux-mips@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 12/13] mips: Move initrd_start check after initrd address sanitisation.
Date:   Wed, 31 May 2023 09:45:40 -0400
Message-Id: <20230531134541.3385043-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531134541.3385043-1-sashal@kernel.org>
References: <20230531134541.3385043-1-sashal@kernel.org>
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
index 2c2480be3f365..124bc842306d6 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -265,10 +265,6 @@ static unsigned long __init init_initrd(void)
 		pr_err("initrd start must be page aligned\n");
 		goto disable;
 	}
-	if (initrd_start < PAGE_OFFSET) {
-		pr_err("initrd start < PAGE_OFFSET\n");
-		goto disable;
-	}
 
 	/*
 	 * Sanitize initrd addresses. For example firmware
@@ -281,6 +277,11 @@ static unsigned long __init init_initrd(void)
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

