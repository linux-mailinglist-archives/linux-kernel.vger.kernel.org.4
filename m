Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA506D4396
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 13:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbjDCLgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 07:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbjDCLgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 07:36:08 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C410A11E8C
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 04:36:02 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id j18-20020a05600c1c1200b003ee5157346cso19627719wms.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 04:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680521761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ccD+WMcpnfxpdEJ20qi2WQ3yxV21AzFl62yMric/kQs=;
        b=d21bNTTTerhufMWt9se/NWVWUHQheCPhiV7zaklubrZxhCBxTQ1+EyXCBH7GXTURt6
         /yQPt78roXGy5ltgVsPYL42e7mLgIYTVBCtadleADRgpScd24T83qjEbGwAvNDC5Wb2r
         XFUM1+X7Zn0iTHd80a/dFBy4B6Zj6zqjMpEz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680521761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ccD+WMcpnfxpdEJ20qi2WQ3yxV21AzFl62yMric/kQs=;
        b=G5s0PI/2k6msps4CHhiZitVtle8Vj5qdY6is78VaPAPiQIfaQ756Wr0A7h4K3DUdAB
         Q7llGNsrRDvBfYEJFw2QrCbPab9GNgqXiFp4gF8QImNHde39g2UshbQGXfrX3+Tl9JDi
         BLKsJ094f0rpPykXCqveEYgA6Y6HZ19/MxZnDUnTxwZB5LoqbLtzhDxJK8ouVkrKhLxP
         GpHBZdzvvCeSQEfkAaTCOHPSEag8htp1xFDsYRMUZRfxiVvooNUk0JTRzcuqduqr0MSW
         IkZEyjKp2d5pRlLU1oPQG5psso2hbVO+M1K3Z9qW/6yhkeh3IBXPX0Dly3t9XpV5lQ5e
         5vSg==
X-Gm-Message-State: AO0yUKV1UwXSNdqb0U+oIbIWV/xEsvsJdoaru6ZSC57REfbVCXmNxcMN
        WQNIgJz5yP/wQR3r4oncNMP0nQ==
X-Google-Smtp-Source: AK7set8dbeu0np8yhxoyImONiRj570jnBy4imGpxld9ZSDNakB2E/78I4N+XTLJj4LUuhYDH0GB7nw==
X-Received: by 2002:a05:600c:22d6:b0:3ed:e5db:52e1 with SMTP id 22-20020a05600c22d600b003ede5db52e1mr28166157wmg.15.1680521761105;
        Mon, 03 Apr 2023 04:36:01 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:b5a2:4ffd:8524:ac1])
        by smtp.gmail.com with ESMTPSA id s15-20020a05600c45cf00b003eb2e33f327sm29841410wmo.2.2023.04.03.04.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 04:36:00 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, mark.rutland@arm.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kpsingh@kernel.org,
        jolsa@kernel.org, xukuohai@huaweicloud.com, lihuafei1@huawei.com,
        Florent Revest <revest@chromium.org>
Subject: [PATCH v5 2/4] arm64: ftrace: Simplify get_ftrace_plt
Date:   Mon,  3 Apr 2023 13:35:50 +0200
Message-Id: <20230403113552.2857693-3-revest@chromium.org>
X-Mailer: git-send-email 2.40.0.423.gd6c402a77b-goog
In-Reply-To: <20230403113552.2857693-1-revest@chromium.org>
References: <20230403113552.2857693-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following recent refactorings, the get_ftrace_plt function only ever
gets called with addr = FTRACE_ADDR so its code can be simplified to
always return the ftrace trampoline plt.

Signed-off-by: Florent Revest <revest@chromium.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/kernel/ftrace.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index 758436727fba..432626c866a8 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -195,15 +195,15 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 	return ftrace_modify_code(pc, 0, new, false);
 }
 
-static struct plt_entry *get_ftrace_plt(struct module *mod, unsigned long addr)
+static struct plt_entry *get_ftrace_plt(struct module *mod)
 {
 #ifdef CONFIG_ARM64_MODULE_PLTS
 	struct plt_entry *plt = mod->arch.ftrace_trampolines;
 
-	if (addr == FTRACE_ADDR)
-		return &plt[FTRACE_PLT_IDX];
-#endif
+	return &plt[FTRACE_PLT_IDX];
+#else
 	return NULL;
+#endif
 }
 
 static bool reachable_by_bl(unsigned long addr, unsigned long pc)
@@ -270,7 +270,7 @@ static bool ftrace_find_callable_addr(struct dyn_ftrace *rec,
 	if (WARN_ON(!mod))
 		return false;
 
-	plt = get_ftrace_plt(mod, *addr);
+	plt = get_ftrace_plt(mod);
 	if (!plt) {
 		pr_err("ftrace: no module PLT for %ps\n", (void *)*addr);
 		return false;
-- 
2.40.0.423.gd6c402a77b-goog

