Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBCB68DFE4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 19:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbjBGSXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 13:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjBGSWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 13:22:39 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059AE3FF3B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 10:22:08 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id hn2-20020a05600ca38200b003dc5cb96d46so13809702wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 10:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J5NwLdTe9+0vZLgVBry/0OWW8ooKZkaJGOHBRX4ufN8=;
        b=fRASL2UGIcRNBlf/7ae//8RHK3T5XjSoyr3hRCQQ/pNn5tg2MlxAaLTHUyrgXCZpKU
         AHPIQD8hI/OFXApHVT6ZRDjG9/QWKH7JrARdfDNLfSpOI8BsnkXlG47EYE5JYOHPQGyJ
         x4yiblaJF2UM7yX6fO6T+866rFk5FSIG2vfvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J5NwLdTe9+0vZLgVBry/0OWW8ooKZkaJGOHBRX4ufN8=;
        b=yzOenLsSSwuUMpOIjgAfSRb0N1io8t9JCh+EG63WylS4Vq/E134Y18KqhxyOfRjBVd
         U0BTc4/f5lF7nkPl/yH191sb99/cBM5tNtTlDhTafZJ91cE4QPDxKr95udKaT/heUH2B
         gOVqVVYNCh7g7y6YdZq0C1hzENmKdJ/GMlpaKT/ZKH8ni5qFKthabO6vNXHwWqiu0q28
         Be6+DYj9/v2AUfeLdNJpQtiF9k2NM42qA5E2i35qqB5vHv/5iqQcKwz3AlVu/aaTUerN
         +IPY84DO+qve0YackWUfd8g8Kt7YleJf0kere4guwtcXe9CJBwdGlss18iFCFx+2nr58
         0pBw==
X-Gm-Message-State: AO0yUKXwwLffFpZOSqS7+aIPyzojBXGpJnIlGbu50KT9vNYADlSkpkvH
        3h7Fdo6cUPTN2cN43PQET5pydT+CwMiHHnPms1k=
X-Google-Smtp-Source: AK7set+wZC1fFBJBT4Cz/9WP5hkX0pcI5J1C2FNWlCc4Z6sReHQy8htf+UrUwjq3Yg4xjlzO15lQnQ==
X-Received: by 2002:a05:600c:30ca:b0:3df:c284:7e78 with SMTP id h10-20020a05600c30ca00b003dfc2847e78mr4149127wmn.38.1675794126436;
        Tue, 07 Feb 2023 10:22:06 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:5307:c0c0:ff97:80de])
        by smtp.gmail.com with ESMTPSA id n6-20020a05600c4f8600b003daf672a616sm15578369wmq.22.2023.02.07.10.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 10:22:06 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, mark.rutland@arm.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kpsingh@kernel.org,
        jolsa@kernel.org, xukuohai@huaweicloud.com, lihuafei1@huawei.com,
        Florent Revest <revest@chromium.org>
Subject: [PATCH v2 04/10] ftrace: Store direct called addresses in their ops
Date:   Tue,  7 Feb 2023 19:21:29 +0100
Message-Id: <20230207182135.2671106-5-revest@chromium.org>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
In-Reply-To: <20230207182135.2671106-1-revest@chromium.org>
References: <20230207182135.2671106-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All direct calls are now registered using the register_ftrace_direct API
so each ops can jump to only one direct-called trampoline.

By storing the direct called trampoline address directly in the ops we
can save one hashmap lookup in the direct call ops and implement arm64
direct calls on top of call ops.

Signed-off-by: Florent Revest <revest@chromium.org>
---
 include/linux/ftrace.h | 3 +++
 kernel/trace/ftrace.c  | 6 ++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index a7dbd307c3a4..84f717f8959e 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -321,6 +321,9 @@ struct ftrace_ops {
 	unsigned long			trampoline_size;
 	struct list_head		list;
 	ftrace_ops_func_t		ops_func;
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+	unsigned long			direct_call;
+#endif
 #endif
 };
 
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index cb77a0a208c7..dfa5f34ec320 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2577,9 +2577,8 @@ ftrace_add_rec_direct(unsigned long ip, unsigned long addr,
 static void call_direct_funcs(unsigned long ip, unsigned long pip,
 			      struct ftrace_ops *ops, struct ftrace_regs *fregs)
 {
-	unsigned long addr;
+	unsigned long addr = ops->direct_call;
 
-	addr = ftrace_find_rec_direct(ip);
 	if (!addr)
 		return;
 
@@ -5375,6 +5374,7 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 	ops->func = call_direct_funcs;
 	ops->flags = MULTI_FLAGS;
 	ops->trampoline = FTRACE_REGS_ADDR;
+	ops->direct_call = addr;
 
 	err = register_ftrace_function_nolock(ops);
 
@@ -5445,6 +5445,7 @@ __modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 	/* Enable the tmp_ops to have the same functions as the direct ops */
 	ftrace_ops_init(&tmp_ops);
 	tmp_ops.func_hash = ops->func_hash;
+	tmp_ops.direct_call = addr;
 
 	err = register_ftrace_function_nolock(&tmp_ops);
 	if (err)
@@ -5466,6 +5467,7 @@ __modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 			entry->direct = addr;
 		}
 	}
+	WRITE_ONCE(ops->direct_call, addr);
 
 	mutex_unlock(&ftrace_lock);
 
-- 
2.39.1.519.gcb327c4b5f-goog

