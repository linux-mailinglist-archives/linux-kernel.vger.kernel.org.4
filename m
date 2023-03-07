Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABD56AE1C8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjCGOJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:09:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjCGOIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:08:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFC385A7D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:07:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5802FB818F8
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:07:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 090FFC433EF;
        Tue,  7 Mar 2023 14:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678198044;
        bh=W8RSmb13M0UD0uiBw0YgqdVpB2dNrJMQsA88S6nGwfI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hNoGrTgRatEitvHDZe6dRhngMdqkE6TSYrZjyagRu+CAcui5laeM+yXG/3f+WrBvp
         WQZMTMHzssBRfJPVj3QphBI89sgkH+aG1IViRKaijZDAtmxOaGjlb/E9uSmdiLyUBo
         3Olj7MpO8msdIObHe08BXSkBuXxvwToUZHEP1mKF+0kxphwIz6Hc4ztqLpp+4JtEa3
         i6TBJGPSjI6/WzBhMhiHRFzXcuAfNYC61Kuqcn3FFwKPUa4psBthXOGsR2Y5Ol8//t
         ErctYB2JSTwRcGPQxwjYKC55bXg6ZbE3NNKByy7VK3SjNhr410n6y2wuu0JGLyeKYe
         kQv178eK2cxSQ==
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
Subject: [PATCH v3 19/60] arm64: idreg-override: Avoid parameq() and parameqn()
Date:   Tue,  7 Mar 2023 15:04:41 +0100
Message-Id: <20230307140522.2311461-20-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2747; i=ardb@kernel.org; h=from:subject; bh=W8RSmb13M0UD0uiBw0YgqdVpB2dNrJMQsA88S6nGwfI=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXdRUuPQUKqZkZ5qO2sVS/OHP6ds+f3ui9rTm63bdcuv lu0XOl5RwkLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZiIdAzD9xDHX3EvDX+a9a9+ smtG0QQrI+FdWiFT/36+Xf+V5bq0OSPD2wPhcfoB8a7fDSa9Edxy9KlML5/fE8/fi6aJbf1gerK VHQA=
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

The only way parameq() and parameqn() deviate from the ordinary string
and memory routines is that they ignore the difference between dashes
and underscores.

Since we copy each command line argument into a buffer before passing it
to parameq() and parameqn() numerous times, let's just convert all
dashes to underscores just once, and update the alias array accordingly.

This also helps reduce the dependency on kernel APIs that are no longer
available once we move this code into the early mini C runtime.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/idreg-override.c | 26 ++++++++++++--------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
index fc9ed722621412bf..23bbbc37ac24ba09 100644
--- a/arch/arm64/kernel/idreg-override.c
+++ b/arch/arm64/kernel/idreg-override.c
@@ -182,8 +182,8 @@ static const struct {
 	char	alias[FTR_ALIAS_NAME_LEN];
 	char	feature[FTR_ALIAS_OPTION_LEN];
 } aliases[] __initconst = {
-	{ "kvm-arm.mode=nvhe",		"id_aa64mmfr1.vh=0" },
-	{ "kvm-arm.mode=protected",	"id_aa64mmfr1.vh=0" },
+	{ "kvm_arm.mode=nvhe",		"id_aa64mmfr1.vh=0" },
+	{ "kvm_arm.mode=protected",	"id_aa64mmfr1.vh=0" },
 	{ "arm64.nosve",		"id_aa64pfr0.sve=0 id_aa64pfr1.sme=0" },
 	{ "arm64.nosme",		"id_aa64pfr1.sme=0" },
 	{ "arm64.nobti",		"id_aa64pfr1.bt=0" },
@@ -204,7 +204,7 @@ static int __init find_field(const char *cmdline,
 	len = snprintf(opt, ARRAY_SIZE(opt), "%s.%s=",
 		       reg->name, reg->fields[f].name);
 
-	if (!parameqn(cmdline, opt, len))
+	if (memcmp(cmdline, opt, len))
 		return -1;
 
 	return kstrtou64(cmdline + len, 0, v);
@@ -261,23 +261,29 @@ static __init void __parse_cmdline(const char *cmdline, bool parse_aliases)
 
 		cmdline = skip_spaces(cmdline);
 
-		for (len = 0; cmdline[len] && !isspace(cmdline[len]); len++);
+		/* terminate on "--" appearing on the command line by itself */
+		if (cmdline[0] == '-' && cmdline[1] == '-' && isspace(cmdline[2]))
+			return;
+
+		for (len = 0; cmdline[len] && !isspace(cmdline[len]); len++) {
+			if (len >= sizeof(buf) - 1)
+				break;
+			if (cmdline[len] == '-')
+				buf[len] = '_';
+			else
+				buf[len] = cmdline[len];
+		}
 		if (!len)
 			return;
 
-		len = min(len, ARRAY_SIZE(buf) - 1);
-		strncpy(buf, cmdline, len);
 		buf[len] = 0;
 
-		if (strcmp(buf, "--") == 0)
-			return;
-
 		cmdline += len;
 
 		match_options(buf);
 
 		for (i = 0; parse_aliases && i < ARRAY_SIZE(aliases); i++)
-			if (parameq(buf, aliases[i].alias))
+			if (!memcmp(buf, aliases[i].alias, len + 1))
 				__parse_cmdline(aliases[i].feature, false);
 	} while (1);
 }
-- 
2.39.2

