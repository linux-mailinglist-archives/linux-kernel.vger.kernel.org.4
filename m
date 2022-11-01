Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4C261508F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 18:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiKARZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 13:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiKARZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 13:25:12 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09451A07B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 10:25:11 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id b5so13998085pgb.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 10:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J6LRwHgWKCwOWn4yhPikzgQ2kZBIaqwpk05PAKv2a3Y=;
        b=DaPWXxso7FHak1bCmcCm4XM7JydFVSumwyBHyeajKm+BUcXJS5XvMJa5HX+4oQzAf2
         BgK2+jsDEJ/tANoVPdBBZdUEcePYJaEzGq5oPV+QD9IX4DSY/l8Jrzl6cR21gQhu7hk7
         Wk6wilFh0GbXbj2e3lsqSrXj/g+aS0h7T5i4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J6LRwHgWKCwOWn4yhPikzgQ2kZBIaqwpk05PAKv2a3Y=;
        b=uzXIZXyasjrzcpnREPuaXR0GyCzlLt1PAGuy4zDZXZIFvXNzXx7+XjDoSNQmhp+ZS4
         g9+KndDTs7mDHVL3BkbYdi8FuTwLtKX+5dEUyyf8qDprVl4k4CDeMz6AS0bcSiApomKG
         OFxHKhiyznHgvKPlQu3CD+NFXM2vjzvFM1Wwp/0IiaaRIc4PZqUr+qir0faUijyWMYqJ
         bOZdqQQUoiqsFl131tSor8byI2vPQD9UP/Yluz1EvMblE+P7MAyym5KbfIJJ/+TSvcA6
         cuiykEv6mqP6BoCRn2Rz0y/9sJFH9+3tRCrDfX2crDHIQS2XXJNPBs+SENKZB4RQJyEi
         62CA==
X-Gm-Message-State: ACrzQf2m7p85Qlz1m4HbQLsO7e90azRQpQ8nIt2K26PfRey84tq5BW0n
        hseHpGKUJToFUUB3uM3r3OGDoQ==
X-Google-Smtp-Source: AMsMyM4RhbvP6zf6mrcFpMcWYZuOS96Vv/5KfzXJBc9FbqY8b4WVdeFjPIAPygEaKVIvxgSl8TWn4g==
X-Received: by 2002:a62:fb13:0:b0:56b:eda9:f47a with SMTP id x19-20020a62fb13000000b0056beda9f47amr166500pfm.84.1667323511344;
        Tue, 01 Nov 2022 10:25:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a16-20020aa794b0000000b005627d995a36sm6789234pfl.44.2022.11.01.10.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 10:25:10 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2] x86/Kconfig: Enable kernel IBT by default
Date:   Tue,  1 Nov 2022 10:25:07 -0700
Message-Id: <20221101172503.gonna.094-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1710; h=from:subject:message-id; bh=BUxMDEzPM1O+OF4wJ0UQbD3pLcsMmA9KesT2iXieSLM=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjYVZyS/oylC73YbOHnGd7AZ3+XB8utWx7H13hxxFt hb2/tVeJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY2FWcgAKCRCJcvTf3G3AJhdkD/ 0ZjMdk7GOU5BxtJPakr6H6nJZLxj80M+40rUA5iu7K0jdzDunXLeZU6G19PHc909btkp1ZqxEyNT5u jFN6BLDz5o++juRR3+H99/wUCVV2/+n6uKC4lLI5wf/ynYyyK+EE1HoGIAhboDbBaUczSBYp9xbwde KlbJCBtD38HZt2lcBFxatazGdjexh4cCZu8cPGxDjwSejVQk0xhezeonwEPKTI7yZ+LreTzMey4ywg HwTZpAf6WCxFke2lFa3ryxzoKmgnFMaxOAlG9nlX82A7RD85+pGHGNmDN3HysftH5tOftwG3LdNqCc pfP+/r7lwKiF8yH3QqD7+/cFRJuAvGdxIqxanPF0utPCOlepX82b7YR42e6d3hFeWffuJ3lFOopAFq CsdP7reuXXBYOwkglZd6103h8I2wSM898GAQYhK4ddoZ6bDzV3G+1TQtBaieM9HxvTIpFKBXsT9MET IK6AblCd1ltJAfMWjEFczRh5oHaOS8mJQfzO7Q4vc3z+ohmwk4S969jURQ8R/NquqC67h/ARWg7x6p T6CkKwUMZTAGYG0zPlbXxcCoypaGkzIwjwLYb0ZlXuzYmhsZZhWj4x4/Q0LOvbwSZVC03h980/S8pA Ug2HWsbFtkjG1HFxdHXUu7hybNX2XPY+DPtpEeBdJ++QHhM/uqjKPXQpQXgQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel IBT defense strongly mitigates the common "first step" of ROP
attacks, by eliminating arbitrary stack pivots (that appear either at
the end of a function or in immediate values), which cannot be reached
if indirect calls must be to marked function entry addresses. IBT is
also required to be enabled to gain the FineIBT feature when built with
Kernel Control Flow Integrity.

Additionally, given that this feature is runtime enabled via CPU ID,
it clearly should be built in by default; it will only be enabled if the
CPU supports it. The build takes 2 seconds longer, which seems a small
price to pay for gaining this coverage by default.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Suggested-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2: update commit log with more details
v1: https://lore.kernel.org/lkml/20220902234213.3034396-1-keescook@chromium.org/
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 67745ceab0db..35d251ba0709 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1854,7 +1854,7 @@ config CC_HAS_IBT
 
 config X86_KERNEL_IBT
 	prompt "Indirect Branch Tracking"
-	bool
+	def_bool y
 	depends on X86_64 && CC_HAS_IBT && HAVE_OBJTOOL
 	# https://github.com/llvm/llvm-project/commit/9d7001eba9c4cb311e03cd8cdc231f9e579f2d0f
 	depends on !LD_IS_LLD || LLD_VERSION >= 140000
-- 
2.34.1

