Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE606AE1C6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjCGOJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbjCGOIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:08:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B345D867D9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:07:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F458B818E9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:07:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BFA7C433A0;
        Tue,  7 Mar 2023 14:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678198051;
        bh=hxezYyQWYIw+0PPMhQw20oQnBobe/ik8sJQ0xwbtFKk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PN/3C4zb71kHR2EC4VJjtXnKKx1XE1/0BQIwxpmI4Sxj9+qp1VKbeKRhbtc3YAbeS
         C8nfCAr7iCCKwFTrN4Oh04FXik3kVT7LDN9uTZw0+Lk1OXgla25XwYfRCUcwluEryz
         /L5oexRVHy0Z9i2k868BgOZpWj/b2H/a82nB9wrH7nQMv/s1XjFi2u1QLr5aSPnfnQ
         +MASJV4gL5qSvvoYDl3yX9YX2CIRFZ7bKraUQhipCfIyJRyIAY6xWfykKoC7KlvYfS
         Itdtg0RwutZeNXFZsjZOf1ERf3ap3TCr0axn8gYhejqt8n+W569S/elox04drH9bCk
         4WDOl8gatJ64w==
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
Subject: [PATCH v3 22/60] arm64: idreg-override: Avoid kstrtou64() to parse a single hex digit
Date:   Tue,  7 Mar 2023 15:04:44 +0100
Message-Id: <20230307140522.2311461-23-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1644; i=ardb@kernel.org; h=from:subject; bh=hxezYyQWYIw+0PPMhQw20oQnBobe/ik8sJQ0xwbtFKk=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXdxXTJ4/+G+3m9lvhO8o42u3pI5v863Y/XyvXOtszzz 05/ukGio5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEzknRvD/zxxTYk8/79ts88/ O2Muq6LueLq+zpBx629WkdAZvWJeYYwMbT/OVrn5yD+Ku7yh+e0MMb+Xx97qOCw7raRkftTqL4M tEwA=
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

All ID register value overrides are =0 with the exception of the nokaslr
pseudo feature which uses =1. In order to remove the dependency on
kstrtou64(), which is part of the core kernel and no longer usable once
we move idreg-override into the early mini C runtime, let's just parse a
single hex digit (with optional leading 0x) and set the output value
accordingly.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/idreg-override.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
index 58c02fe20e1050b4..758f0e86e2bd2a34 100644
--- a/arch/arm64/kernel/idreg-override.c
+++ b/arch/arm64/kernel/idreg-override.c
@@ -195,6 +195,20 @@ static const struct {
 	{ "nokaslr",			"arm64_sw.nokaslr=1" },
 };
 
+static int __init parse_hexdigit(const char *p, u64 *v)
+{
+	// skip "0x" if it comes next
+	if (p[0] == '0' && tolower(p[1]) == 'x')
+		p += 2;
+
+	// check whether the RHS is a single hex digit
+	if (!isxdigit(p[0]) || (p[1] && !isspace(p[1])))
+		return -EINVAL;
+
+	*v = tolower(*p) - (isdigit(*p) ? '0' : 'a' - 10);
+	return 0;
+}
+
 static int __init find_field(const char *cmdline, char *opt, int len,
 			     const struct ftr_set_desc *reg, int f, u64 *v)
 {
@@ -208,7 +222,7 @@ static int __init find_field(const char *cmdline, char *opt, int len,
 	if (memcmp(cmdline, opt, len))
 		return -1;
 
-	return kstrtou64(cmdline + len, 0, v);
+	return parse_hexdigit(cmdline + len, v);
 }
 
 static void __init match_options(const char *cmdline)
-- 
2.39.2

