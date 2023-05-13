Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D630770153E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 10:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjEMIYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 04:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjEMIYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 04:24:08 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358552D78;
        Sat, 13 May 2023 01:24:01 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-643b7b8f8ceso5978327b3a.1;
        Sat, 13 May 2023 01:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683966241; x=1686558241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HfO0FQe7LL8tpwg2PdMURaHU+jV7nrgpfKB4jccXJDQ=;
        b=ZAJFRRMR9pPP9o8YhqxKzCA9OjaxaDllBGMYW0Qepx86qrG33daV5b3vhW5/QwNj7G
         zubAiIlXTdHGzUTfo2pLtGj0s2Ca0qE+m34cFf+/3/zU2H0OPS8igLSELCbTGw/5UaZo
         xL3a2c4ODXw0KzRRSHNkzY/quP+MapWc0cCS1VurCvNpwxK6WzQx4ztxNgHI2iBRbgtg
         PHp4meI7XOYNPuRDf8naCAj2p21ni46WiBukE67MKoKhF7eAX0th5qCQogN7oWK8nfd5
         DjL9r7eyZ0KaETXLJqG3oQmXrR8I9REiNxEUksYuN6uX/1KBc/lTwkQmJP8Js3/l0A0v
         pmXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683966241; x=1686558241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HfO0FQe7LL8tpwg2PdMURaHU+jV7nrgpfKB4jccXJDQ=;
        b=Y8l9pzBCi0phpetBnsXcjKa4eGA2Pw3q290h/bgCZVOYHTFhjRdbKNa2iMVChzCIFL
         4tm+CPyl9oCakYfhlFPZ4a0wQ+2uVdzVsvsMCWbhCJ18js2moCHNKvfqluhZaKV/Q2jY
         Q0X+A+lp9mRjy7m+XuqG64ttxC7/qnJvJCpJfAkhIAYTN+TqTsXu2kiy2ZuHtA73VOj1
         bI3dDjo5Uq8LonB+UUXeERgr7UpuTljHNwKObUHFAwml9viHP7y767GcKxscsTQVA+sf
         gFoYQAsJf7T1T+ivvSQ+U8LLNRIeH3IGz+eBmD4TLphTEG4bEL2D3ZfFCct2e0PsCV3l
         Gfqg==
X-Gm-Message-State: AC+VfDyAxMN4kw4plqZJx5MQxAUT5c8veKiF0KGiBWeSvPV+OhXDBa7s
        oFZZIcIe2QQHSiEy2+bH2XE=
X-Google-Smtp-Source: ACHHUZ4WRaqyhABODUFMw9aMNHW2FAxzuSYUm7PP6cP2LtxKukbrck/qGndKV/n3gPK60xTaF3pgJw==
X-Received: by 2002:a05:6a00:1415:b0:641:558:8e2e with SMTP id l21-20020a056a00141500b0064105588e2emr33219775pfu.15.1683966241160;
        Sat, 13 May 2023 01:24:01 -0700 (PDT)
Received: from localhost.localdomain ([43.132.98.116])
        by smtp.googlemail.com with ESMTPSA id g4-20020a62e304000000b00627ed4e23e0sm8225021pfh.101.2023.05.13.01.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 01:24:00 -0700 (PDT)
From:   Ze Gao <zegao2021@gmail.com>
X-Google-Original-From: Ze Gao <zegao@tencent.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ze Gao <zegao@tencent.com>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH] rethook: use preempt_{disable, enable}_notrace in rethook_trampoline_handler
Date:   Sat, 13 May 2023 16:23:46 +0800
Message-Id: <20230513082346.375928-1-zegao@tencent.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replace preempt_{disable, enable} with its corresponding
notrace version in rethook_trampoline_handler so no worries about stack
recursion or overflow introduced by preempt_count_{add, sub} under
fprobe + rethook context.

Signed-off-by: Ze Gao <zegao@tencent.com>
---
 kernel/trace/rethook.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
index 32c3dfdb4d6a..60f6cb2b486b 100644
--- a/kernel/trace/rethook.c
+++ b/kernel/trace/rethook.c
@@ -288,7 +288,7 @@ unsigned long rethook_trampoline_handler(struct pt_regs *regs,
 	 * These loops must be protected from rethook_free_rcu() because those
 	 * are accessing 'rhn->rethook'.
 	 */
-	preempt_disable();
+	preempt_disable_notrace();
 
 	/*
 	 * Run the handler on the shadow stack. Do not unlink the list here because
@@ -321,7 +321,7 @@ unsigned long rethook_trampoline_handler(struct pt_regs *regs,
 		first = first->next;
 		rethook_recycle(rhn);
 	}
-	preempt_enable();
+	preempt_enable_notrace();
 
 	return correct_ret_addr;
 }
-- 
2.40.1

