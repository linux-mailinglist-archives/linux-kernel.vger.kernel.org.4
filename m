Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09AC67114E6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242146AbjEYSlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242583AbjEYSks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:40:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE8B272D;
        Thu, 25 May 2023 11:38:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B9276492F;
        Thu, 25 May 2023 18:38:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CCE3C433D2;
        Thu, 25 May 2023 18:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685039889;
        bh=w0rF4n5T+F4b9Rhogag7SPApxLiX1SbXOwP5SgUfXSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OnjEbnvMZWW3fb1GVPJp52Qs2Kii/kQeHi9SnyBD7lq0c2nThuWgJOqQCH1cupswm
         4Q1BEeCPrSqjQc40Zrjin+ZX3DlKgM1fiT+SZP9Bv8uyanrkircFHsI8WWMefgTDnu
         JvkoJmlPtBTjRLVjjNKfhcgG2ngsbokIGMIW+eQGCymSzzcv0jYrfXs3z3KNYKje1w
         rA+pitTGyBuORQ3rsSnYx8OqWW1+SnM/XTgNAMoHOo2lQQAEYQqFPuxrWYwbqV6tXW
         CBdEeDgu5JRtfF18XqnG4Mxql/Nt+Gxm7wFzg8rQj5NztYU5vteEoi3XCqlYBq10Db
         iFyo6wl+0tjtw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>,
        catalin.marinas@arm.com, akpm@linux-foundation.org,
        mhocko@suse.com, mike.kravetz@oracle.com, Liam.Howlett@Oracle.com,
        jannh@google.com, willy@infradead.org, joey.gouly@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 38/57] arm64: vdso: Pass (void *) to virt_to_page()
Date:   Thu, 25 May 2023 14:35:48 -0400
Message-Id: <20230525183607.1793983-38-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525183607.1793983-1-sashal@kernel.org>
References: <20230525183607.1793983-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
index 99ae81ab91a74..6ebb8dea5f09e 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -312,7 +312,7 @@ static int aarch32_alloc_kuser_vdso_page(void)
 
 	memcpy((void *)(vdso_page + 0x1000 - kuser_sz), __kuser_helper_start,
 	       kuser_sz);
-	aarch32_vectors_page = virt_to_page(vdso_page);
+	aarch32_vectors_page = virt_to_page((void *)vdso_page);
 	return 0;
 }
 
-- 
2.39.2

