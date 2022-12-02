Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7830E640DBD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 19:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234536AbiLBSqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 13:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234515AbiLBSpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 13:45:54 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DA7E2A99
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 10:45:34 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so9098786pjs.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 10:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MRcFFjDxzBMARpuGQwgqNlOFZU4mwdd9opB0FflUqrw=;
        b=dcvU93Ka1DumP5haCl7D0qgJtxPoSG8f73JoJ8QIp/r4J1ddpUHJgcRlNj2N4lmNTT
         opKWf6gsUDPftwJZs/LOB2lqgk2fJvZPln5E9nfqOb5X7CJY7PbaLZi7trfOmbJP1rmF
         MB/hK5Veu8/XVmIV7ldD+0IilkNmYWos/0fWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MRcFFjDxzBMARpuGQwgqNlOFZU4mwdd9opB0FflUqrw=;
        b=TEN12GJef6mdITXkWxAeVJI58jqZk0WvfhgY925u/fJaE7rb0AlxfSDhNPmkyRfBv3
         tluq8YyqjS+z8ZNuyrqlA4F0mzLaTcPyQOqpEHS7Jxvv6rfVzs5AVgot4wMdG72Fp4QR
         gWjRQEVraF+gq1XFLb9CJoUMMa7csmrEKhjCmQkXT9xbMN8Lo590WU+VKk9weBJrRIWc
         RODR5imAOMBwgumopSCpnYNkXowufWTkMwG06su1gKb+wduGKfZtECFCdIelC1/zJ6zG
         t613sBkZgs4sxS1ea720YJjY6UCsUZQhdUIpS32TyFJxY9i9KhwuLS1QToL/vX0mxYMl
         gdQw==
X-Gm-Message-State: ANoB5pkNcpp+WEIJyCV4Y6wW9QjzVwi45b4aipic0DXx+chvqI4fbCBq
        9F7RyV45BsRbJBffLPnHy+jOrg==
X-Google-Smtp-Source: AA0mqf5dce1eInb8cYfDpFz/egBZEeCagoSEe+Y2nYbvfLCqG/9hkpH/CvToMre4oTKhvZsKTVpQGg==
X-Received: by 2002:a17:902:c186:b0:189:7644:c46d with SMTP id d6-20020a170902c18600b001897644c46dmr32681652pld.155.1670006733705;
        Fri, 02 Dec 2022 10:45:33 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s9-20020a170902b18900b0017f8094a52asm5874084plr.29.2022.12.02.10.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 10:45:32 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Daniel Palmer <daniel@thingy.jp>,
        Romain Perier <romain.perier@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH v2] rtc: msc313: Fix function prototype mismatch in msc313_rtc_probe()
Date:   Fri,  2 Dec 2022 10:45:30 -0800
Message-Id: <20221202184525.gonna.423-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2360; h=from:subject:message-id; bh=hzgnBJC68gGV9L5xZ6Y3j5m9/tlnozcLjEDSeO4mMBU=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjikfJxy8HlFJpzMU5DoS9WJXwZxsl+ceZULY9y6Y9 UZgFwBqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY4pHyQAKCRCJcvTf3G3AJtPtD/ wOGNflYB1z1tZC0DET7Hzszz5MmegRllVQkyCY1Q71OyNwmnOyejJAoeKZCA5ZZy6JHzZMAxy/Vt6S AUP/A+aPT8Dbr8vb67ra+hLw1IrnCsBSuFNPO4PAqJNkj8p6Y9HanWfFcs5m/MbwHJcd0AF1CwYZ8p aO0UtKfzDYE0b37pmKcUKZww7A9CvG5hxoGDhrfCAT0R3DiLie499Mz3QDmkPc7T1se5KdnSAsstHs Rz9fe1uI3kCXaoqKv5D0OBfh6aSYGuSMSXuIOV2VHEyULHLE3gtsfrMljKZsbjEqwLwtjdl1qg+JI+ YYAG/jgOec2J6F0ZrsYbWDDOU6VBT/7L+ufu/TjkIhkOu2oxQxORKS/4nS+2EQcRDfSQd+g28cuSH9 py/t1GW4iAkw+ekx/dJ3CyxNuYDhtqaLaO3FgJKjU/331/ljEVT+NwlWQEeNIZxWpzT27zJycF0Ma7 NFia0vsBgq8VfOM7IoRij5WTJqPvPjrt+oZnJFzErnxUoBLkRyGNJmtzGJhB+tejBAQ9C5r+SfMuD3 a2voZ1WSUq4Bbg0kduKeKv+T/XMrnYYYTNTfffHj2CWEmywt1mqYJXpCLjmQUQ5JMTzc9fwiA30NdV iJ31w9suBSJB/PFmPMoGX4JorI51ZB7CyVCay+gfVL1s8HLYTBqcIvyOTtLw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With clang's kernel control flow integrity (kCFI, CONFIG_CFI_CLANG),
indirect call targets are validated against the expected function
pointer prototype to make sure the call target is valid to help mitigate
ROP attacks. If they are not identical, there is a failure at run time,
which manifests as either a kernel panic or thread getting killed.

msc313_rtc_probe() was passing clk_disable_unprepare() directly, which
did not have matching prototypes for devm_add_action_or_reset()'s
callback argument. Refactor to use devm_clk_get_enabled() instead.

This was found as a result of Clang's new -Wcast-function-type-strict
flag, which is more sensitive than the simpler -Wcast-function-type,
which only checks for type width mismatches.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/lkml/202211041527.HD8TLSE1-lkp@intel.com
Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Daniel Palmer <daniel@thingy.jp>
Cc: Romain Perier <romain.perier@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-rtc@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v1: https://lore.kernel.org/lkml/20221118233101.never.215-kees@kernel.org/
v2: use devm_clk_get_enabled() (christophe)
---
 drivers/rtc/rtc-msc313.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/rtc/rtc-msc313.c b/drivers/rtc/rtc-msc313.c
index f3fde013c4b8..8d7737e0e2e0 100644
--- a/drivers/rtc/rtc-msc313.c
+++ b/drivers/rtc/rtc-msc313.c
@@ -212,22 +212,12 @@ static int msc313_rtc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	clk = devm_clk_get(dev, NULL);
+	clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(clk)) {
 		dev_err(dev, "No input reference clock\n");
 		return PTR_ERR(clk);
 	}
 
-	ret = clk_prepare_enable(clk);
-	if (ret) {
-		dev_err(dev, "Failed to enable the reference clock, %d\n", ret);
-		return ret;
-	}
-
-	ret = devm_add_action_or_reset(dev, (void (*) (void *))clk_disable_unprepare, clk);
-	if (ret)
-		return ret;
-
 	rate = clk_get_rate(clk);
 	writew(rate & 0xFFFF, priv->rtc_base + REG_RTC_FREQ_CW_L);
 	writew((rate >> 16) & 0xFFFF, priv->rtc_base + REG_RTC_FREQ_CW_H);
-- 
2.34.1

