Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6EC6AE1AA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjCGOGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:06:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjCGOGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:06:45 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10B37EA3A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:06:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8C655CE1BDD
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:06:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D5EC433A4;
        Tue,  7 Mar 2023 14:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678198000;
        bh=UU7UHHKN3Bd0erW9JoS5OAfIvVMowd83YmJWUTJJyEU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uc+w1oi7J43W+sD4f84reyCRhvx0QojS7oA8M0lOPvS0aFzJKjUuEgNxf9ToK6s9H
         t5NKs9aiJSi4y6ECXVmFzT7L5R6oT9nhikg9pIBHIJNXBQkADMSEntgvaHVatFhP03
         n/WdLin+s9pnhkEaY9KiL/eV06cWSA4zmnKpSnCN/PHmRRkGFF7ohSZaEbIowVEgrH
         cjgqyleUtRxu9/mpXpndcjP+jPwNVTXNOoVC2AIqc/1nArhkEuENQWWo5s4Zx9JoKu
         ymYJt15AFHg4rKXCor9PpfVU8vVmka8c8XCfuo/hEG7AG1rOWzVnQ/SRbZUMlfgIy2
         U5pRvMDz1+LDQ==
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
Subject: [PATCH v3 01/60] arm64: kernel: Disable latent_entropy GCC plugin in early C runtime
Date:   Tue,  7 Mar 2023 15:04:23 +0100
Message-Id: <20230307140522.2311461-2-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=849; i=ardb@kernel.org; h=from:subject; bh=UU7UHHKN3Bd0erW9JoS5OAfIvVMowd83YmJWUTJJyEU=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXd+d/V5Cme/D+mi/NJGKn5Lcrht9rvkyvS90//SWbo/ 41eltc6SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwERWujD89+3Q6bQ9XsZZ9DDh 9J6VMdFZz4Nmx57J2xIq8LhbYU9+DiPDvai9f307ln1mOLlHKEtLYVurzUH73XN25TuaR2Tu/97 NBAA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid build issues in the early C code related to the latent_entropy GCC
plugin, by incorporating the C flags fragment that disables it.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/pi/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/pi/Makefile b/arch/arm64/kernel/pi/Makefile
index 4c0ea3cd4ea406b6..c844a0546d7f0e62 100644
--- a/arch/arm64/kernel/pi/Makefile
+++ b/arch/arm64/kernel/pi/Makefile
@@ -3,6 +3,7 @@
 
 KBUILD_CFLAGS	:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) -fpie \
 		   -Os -DDISABLE_BRANCH_PROFILING $(DISABLE_STACKLEAK_PLUGIN) \
+		   $(DISABLE_LATENT_ENTROPY_PLUGIN) \
 		   $(call cc-option,-mbranch-protection=none) \
 		   -I$(srctree)/scripts/dtc/libfdt -fno-stack-protector \
 		   -include $(srctree)/include/linux/hidden.h \
-- 
2.39.2

