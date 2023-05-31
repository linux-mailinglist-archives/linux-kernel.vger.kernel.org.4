Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BB8717280
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 02:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbjEaAe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 20:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233920AbjEaAeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 20:34:18 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB5F1A5
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 17:34:07 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b00ffb4186so33695605ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 17:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685493246; x=1688085246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5f5G6Z5TX6jSNSW7iZ4219jNh0M1Ixv7KFZOMk7yBdk=;
        b=l9VKAMH6WudZIZRhNlh71t6tXPDlsutsmJmLWqRRW2iFdXdhtFrqpS+dXNZnLjIoFx
         X7NDzTAMsMsrBMj5MVv9ZOyOPvEkdf5l32hodPIVj3rprhLMmmcUOwSVHYlnqNfLcVmg
         FwdUHrvYq9AxBfxDwMlDvH4ygVfvGGu483lK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685493246; x=1688085246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5f5G6Z5TX6jSNSW7iZ4219jNh0M1Ixv7KFZOMk7yBdk=;
        b=Z6JmCHJlreII0xy38dKGicmAiDgm5hjrrDojCNAlynRHbBEa/MFxVqcwGos8bI69lS
         63D2wB15z0a/T7Fqk8s/FemwQxj70m9Tc05co1bnrpnpUwyNfdYLTL3Lzd+M9viDXWqV
         xBvVxmc5JpYgiUR9RH7bZPmYyCP2A4pAhO0+hb5j0x3XhxJpy4o1XjnLTMz5i6tRnkCR
         L4aRjacaygrIjGNKwwx58dJeYXfvYS/HlzmZ2CRylE3FIMoY9W6oRPZD8pF/QTZGICZt
         6XRwrNdd9DRpmtFodx/LkD/55sLvfRrDFqRxrsCISJq2KkAFJepF6gs8O58GilTVmYNr
         pcsQ==
X-Gm-Message-State: AC+VfDyjo/4rLNeMgXVKhc+l18WEZZlqMOo/EfgKGHbOHl/iHhBbbI48
        2QPth1zkT2FrBSTJqvlLoPClaA==
X-Google-Smtp-Source: ACHHUZ5/++6K7OTO9X9PqwE6aBl5HupJYUjF7HBbHsNePlIAEb2cGG8BSsZvcRS0ILBFNlBs/WfZ3Q==
X-Received: by 2002:a17:902:d4c3:b0:1b0:348f:c48c with SMTP id o3-20020a170902d4c300b001b0348fc48cmr4556864plg.2.1685493246586;
        Tue, 30 May 2023 17:34:06 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u12-20020a170902b28c00b001b022f2aa12sm7548958plr.239.2023.05.30.17.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 17:34:06 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        =?UTF-8?q?Joan=20Bruguera=20Mic=C3=B3?= <joanbrugueram@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alyssa Ross <hi@alyssa.is>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] riscv/purgatory: Do not use fortified string functions
Date:   Tue, 30 May 2023 17:34:04 -0700
Message-Id: <20230531003404.never.167-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2193; h=from:subject:message-id; bh=/JxqFfJ6nuR0/6IE7Sc4flmcXznFeg2cPC6sgocVuNU=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkdpX8G4kqMGXXMDB6QczvHZO2WMQWHuNrSDDCbUQ3 nkFlCHaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZHaV/AAKCRCJcvTf3G3AJoHXD/ 9VFWg0OwdTmI5Ri78v0MVimMvM+qTS532cnKbCQjAMvJB0aTiyikiMWU1kssDuWYCsWMGrGZL6CiKT kX5eQ071IpzqrvWr+lDigf92GAztBf0FLgC4M2rdgkVinvXEAnzRp2NFMFXRP+pSqv+Fr2Jo7Ke4Ty rBdoUUXJKDCz2n5UXUobVPdvOY+iJWhb/Zt+zHu05O/6JirOLgr6elUbixDbjBH/SvGoi/k4oFPHro Ohl1jQXp7wCmWUiid65oYJb/Wp5CfjTPipiBd1CKC2aPjc/RCuZDCwxxByLY8I21j7+VMJCUfHV+r2 cdJWFXFxoOPW6qeEP1Cc1j/oGP0eAcKESAsiLE/q8nxXU5CbzW4CxZLHqQcIUAXPJRi9edvZm5W1ec 1FxsaGKvgjyGUqzw1WlYU+aGBOXFuldUIHtADp6CZWI3KTWE9o0lnk6a0d0Cxo4bzKHkq6fPmzc81z jS4x587NgH3+JThRZ2GEejTMGxd4Tm0G92jEyEH7evy3ojJNh14+7lS166LEVaLlUnVDp8Ge5xT7xw rEixWCU/RYdU9+P/ukZoI+81IQCIU4cR57jko6FkwnW7vYxMlDIxW2CbNf5W1u2ygPg0eF0KMTS/bO eci3+H2fkfeKH7LlezfLbBssyk5pjZ5iKUY0oSY0E7uPl7z8PKqUnuMY+hPg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the addition of -fstrict-flex-arrays=3, struct sha256_state's
trailing array is no longer ignored by CONFIG_FORTIFY_SOURCE:

struct sha256_state {
        u32 state[SHA256_DIGEST_SIZE / 4];
        u64 count;
        u8 buf[SHA256_BLOCK_SIZE];
};

This means that the memcpy() calls with "buf" as a destination in
sha256.c's code will attempt to perform run-time bounds checking, which
could lead to calling missing functions, specifically a potential
WARN_ONCE, which isn't callable from purgatory.

Reported-by: Thorsten Leemhuis <linux@leemhuis.info>
Closes: https://lore.kernel.org/lkml/175578ec-9dec-7a9c-8d3a-43f24ff86b92@leemhuis.info/
Bisected-by: "Joan Bruguera Micó" <joanbrugueram@gmail.com>
Fixes: df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3")
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Alyssa Ross <hi@alyssa.is>
Cc: Heiko Stuebner <heiko.stuebner@vrull.eu>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-riscv@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/riscv/purgatory/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/purgatory/Makefile b/arch/riscv/purgatory/Makefile
index 5730797a6b40..11f4c275f141 100644
--- a/arch/riscv/purgatory/Makefile
+++ b/arch/riscv/purgatory/Makefile
@@ -31,9 +31,9 @@ $(obj)/strncmp.o: $(srctree)/arch/riscv/lib/strncmp.S FORCE
 $(obj)/sha256.o: $(srctree)/lib/crypto/sha256.c FORCE
 	$(call if_changed_rule,cc_o_c)
 
-CFLAGS_sha256.o := -D__DISABLE_EXPORTS
-CFLAGS_string.o := -D__DISABLE_EXPORTS
-CFLAGS_ctype.o := -D__DISABLE_EXPORTS
+CFLAGS_sha256.o := -D__DISABLE_EXPORTS -D__NO_FORTIFY
+CFLAGS_string.o := -D__DISABLE_EXPORTS -D__NO_FORTIFY
+CFLAGS_ctype.o := -D__DISABLE_EXPORTS -D__NO_FORTIFY
 
 # When linking purgatory.ro with -r unresolved symbols are not checked,
 # also link a purgatory.chk binary without -r to check for unresolved symbols.
-- 
2.34.1

