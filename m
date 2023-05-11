Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A616FEEEB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 11:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237736AbjEKJdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 05:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237656AbjEKJct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 05:32:49 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615B67EC9;
        Thu, 11 May 2023 02:32:47 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-643846c006fso8889873b3a.0;
        Thu, 11 May 2023 02:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683797567; x=1686389567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1t0ft/AfuKy/xQMa6et8iuTG4wcZxNYRj+6RIhEHQg=;
        b=ZUaERY7KluVgV1urVG9GVSmVHBH7RYw3PkzZILqQv6OpFvR3G0o+XmUalnrH8IQ+j1
         Dld0HaSegC5VzwsX/ArbewSGZylR9EndPFLvoCVz1Mg1jbxdQ7epp8zii7RdWkm35SJg
         BNQjs7CRuWUdnQKiOrTKt6agvRxoodPehag+MAe1oC9LAs/1wln+ppFKRK+l0JTPQ01O
         eZSCbFOiQWD5i+w7Ivhx+P3OFwoMpoG8ZhvfPj8JsWXU6jo29aI+XF6F/0bK0ahV+nPX
         qfy/an8GlvnmjWOvw4FzwQiBq/g/rue4OgSYOBZbZBCSFEki989DA6WOYUceaoLAm+wu
         TDKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683797567; x=1686389567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z1t0ft/AfuKy/xQMa6et8iuTG4wcZxNYRj+6RIhEHQg=;
        b=fsekAF+IOTjN1Zq5L0DYpNPtexFnQBBUki0OlgevZoElF2WcjGs6/EwgQoJKrHy2w7
         HmOitui+M/FL/moMCbbZq4EcBxJbani2QeDLn+jTnDemMh4/R6ONa1QaoLXpzRZyTrkz
         hPnhOY6XpmpBwh5BKwC4rq6HtMmmi4Di6p4od//MRMbYcQwwJ7wf7VC6lLJXpRg+gaM8
         7MUbTTw23l0Tpj371t/uNMoO1cCwjjUcqC0T/n8SF8H5yIOtekvmREuq9fGs6nyKxiY2
         PthzX9WD9XDe5uYQ3kmpenLuO1K9R9deaat+5K8fWKAHuc9W+4/yTu8JWLRosW8HkbP3
         WbrQ==
X-Gm-Message-State: AC+VfDyYhuLkitSw9nl025EC4+ZpNuZCZWP/3Ac2srI5/eii4Xm8WPaO
        TFnik5nWKP9YhHslJB9mwCQ=
X-Google-Smtp-Source: ACHHUZ4lQ4MsoQ2H8y55dCOVIAxG2NxXuvFCeesI+ZlRh2pUdbfKc6WnStP0hclRyjW1MF7dIRuPOQ==
X-Received: by 2002:a05:6a00:1907:b0:643:b081:3428 with SMTP id y7-20020a056a00190700b00643b0813428mr25363263pfi.27.1683797567068;
        Thu, 11 May 2023 02:32:47 -0700 (PDT)
Received: from localhost.localdomain ([221.226.144.218])
        by smtp.gmail.com with ESMTPSA id v16-20020aa78510000000b00627e87f51a5sm4875400pfn.161.2023.05.11.02.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 02:32:46 -0700 (PDT)
From:   Song Shuai <suagrfillet@gmail.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mhiramat@kernel.org,
        mark.rutland@arm.com, guoren@kernel.org, suagrfillet@gmail.com,
        jszhang@kernel.org, e.shatokhin@yadro.com, bjorn@rivosinc.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH V10 1/4] riscv: select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
Date:   Thu, 11 May 2023 17:32:31 +0800
Message-Id: <20230511093234.3123181-2-suagrfillet@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230511093234.3123181-1-suagrfillet@gmail.com>
References: <20230511093234.3123181-1-suagrfillet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In RISC-V, -fpatchable-function-entry option is used to support
dynamic ftrace in this commit afc76b8b8011 ("riscv: Using
PATCHABLE_FUNCTION_ENTRY instead of MCOUNT"). So recordmcount
don't have to be called to create the __mcount_loc section before
the vmlinux linking.

Here selects FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY to tell
Makefile not to run recordmcount.

Link: https://lore.kernel.org/linux-riscv/CAAYs2=j3Eak9vU6xbAw0zPuoh00rh8v5C2U3fePkokZFibWs2g@mail.gmail.com/T/#t
Link: https://lore.kernel.org/linux-riscv/Y4jtfrJt+%2FQ5nMOz@spud/
Signed-off-by: Song Shuai <suagrfillet@gmail.com>
Tested-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Guo Ren <guoren@kernel.org>
Acked-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 348c0fa1fc8c..e0632493482f 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -58,6 +58,7 @@ config RISCV
 	select COMMON_CLK
 	select CPU_PM if CPU_IDLE || HIBERNATION
 	select EDAC_SUPPORT
+	select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY if DYNAMIC_FTRACE
 	select GENERIC_ARCH_TOPOLOGY
 	select GENERIC_ATOMIC64 if !64BIT
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
-- 
2.20.1

