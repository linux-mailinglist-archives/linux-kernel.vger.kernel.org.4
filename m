Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F62F7115E3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242858AbjEYSrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242707AbjEYSpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:45:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23DE3AAE;
        Thu, 25 May 2023 11:41:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CEA560C57;
        Thu, 25 May 2023 18:40:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CAEAC433EF;
        Thu, 25 May 2023 18:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685040035;
        bh=gXwRhtRsYouFNBMlk7S8phDmvO3mR2uoyaYBy8rdqV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PIW1y+grPdpJGoU49IfAjCLPDxGIW82VdRQoatHG0j8kTuqXM7G19iDQ+XscQ+Aug
         Fz4ScrqLa+2M+SshqZn2BpEHTl9yRgU8T9mk7bpo/UyI82fIq/Zq1p/i1BRjAJAcL3
         08XtsAi4aY8kfDJmXqTgijR+GBv6HOTJEsdj1T3zU0aTZxDJLJgMwTjmBObAwyMZ95
         tCCjPnAm3vpXQcTPGwdw2PhcfIsg7sCGggbZ7LvgWwgj5mKFNwcSJngHVb3DRrOxrb
         VssNpU1cACi/paqfJ+cByWNpXNEKCPkZfYwTV/wk2wa+qN5EOSWPFShUC4T+Z91oOf
         B4XFJy/J2ty2g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>,
        catalin.marinas@arm.com, akpm@linux-foundation.org,
        peterx@redhat.com, hca@linux.ibm.com, dave@stgolabs.net,
        vbabka@suse.cz, mike.kravetz@oracle.com, willy@infradead.org,
        joey.gouly@arm.com, jannh@google.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 32/43] arm64: vdso: Pass (void *) to virt_to_page()
Date:   Thu, 25 May 2023 14:38:43 -0400
Message-Id: <20230525183854.1855431-32-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525183854.1855431-1-sashal@kernel.org>
References: <20230525183854.1855431-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>

[ Upstream commit b0abde80620f42d1ceb3de5e4c1a49cdd5628229 ]

Like the other calls in this function virt_to_page() expects
a pointer, not an integer.

However since many architectures implement virt_to_pfn() as
a macro, this function becomes polymorphic and accepts both a
(unsigned long) and a (void *).

Fix this up with an explicit cast.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Link: http://lists.infradead.org/pipermail/linux-arm-kernel/2023-May/832583.html
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/vdso.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index a61fc4f989b37..55dd15c9745da 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -314,7 +314,7 @@ static int aarch32_alloc_kuser_vdso_page(void)
 
 	memcpy((void *)(vdso_page + 0x1000 - kuser_sz), __kuser_helper_start,
 	       kuser_sz);
-	aarch32_vectors_page = virt_to_page(vdso_page);
+	aarch32_vectors_page = virt_to_page((void *)vdso_page);
 	return 0;
 }
 
-- 
2.39.2

