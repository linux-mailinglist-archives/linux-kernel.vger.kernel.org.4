Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F8A6AE1EB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjCGOMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbjCGOMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:12:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3635E274B3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:09:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83EE66145B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:08:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3870C4339E;
        Tue,  7 Mar 2023 14:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678198138;
        bh=roqr6Q+/LaCDBS0wdH1j7SIax2HpGRyxNIxGqchdc0Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qcBZHpheeGEgqeu9h7lOW0O1leSo000RLluqbtqGMnIUTfeN6SjVzECb8VaYa1qUr
         E4AJDNnjARA2jTPupgk7HgTZAUjR4A7kHjhiXh9rr4CzbplQL1zoG630uqMAfWXfp3
         DXVsaXwInlb8fSY2s+GqUJGLqLZOArUZszoWi1eGtrWwmaPNePOY0JYvLHP7dDLmmh
         DuGGGtyGCDdZKfzp3qntSv5+FekBZjl5dYrE5ySgQYPcu31bq4m8GezeNgiQWE3xel
         gI1CZzri3Mps0bJ5OQWsJqvJ3mzqqv8/nlFfl3aLJpR55sAeBmW5cbo1Cocxw42Pxn
         DjWV7klsej/wg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v3 58/60] arm64: defconfig: Enable LPA2 support
Date:   Tue,  7 Mar 2023 15:05:20 +0100
Message-Id: <20230307140522.2311461-59-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=946; i=ardb@kernel.org; h=from:subject; bh=roqr6Q+/LaCDBS0wdH1j7SIax2HpGRyxNIxGqchdc0Q=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXdZc6Zv6fn1lid3HjxBbdmUDLjI+FWzvr7XU4VcXp7h br6dHs7SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwESMnRn+B+Z+nRnu07U7IqI+ VaorSVB8bdJWtc/zrZhlHl7zOPzZk+GfrlqJzYVdz4X87Fffu1prcvHT2Q3hlVOtrx1+HxOnVa3 BDgA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We typically enable support in defconfig for all architectural features
for which we can detect at runtime if the hardware actually supports
them.

Now that we have implemented support for LPA2 based 52-bit virtual
addressing in a way that should not impact 48-bit operation on non-LPA2
CPU, we can do the same, and enable 52-bit virtual addressing by
default.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/configs/defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7790ee42c68a88d7..728b29549e058e94 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -69,7 +69,7 @@ CONFIG_ARCH_VEXPRESS=y
 CONFIG_ARCH_VISCONTI=y
 CONFIG_ARCH_XGENE=y
 CONFIG_ARCH_ZYNQMP=y
-CONFIG_ARM64_VA_BITS_48=y
+CONFIG_ARM64_VA_BITS_52=y
 CONFIG_SCHED_MC=y
 CONFIG_SCHED_SMT=y
 CONFIG_NUMA=y
-- 
2.39.2

