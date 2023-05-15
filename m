Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED53702206
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 05:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237789AbjEODNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 23:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjEODNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 23:13:43 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E3B10F8;
        Sun, 14 May 2023 20:13:42 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-52160f75920so8354957a12.2;
        Sun, 14 May 2023 20:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684120421; x=1686712421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HfO0FQe7LL8tpwg2PdMURaHU+jV7nrgpfKB4jccXJDQ=;
        b=AriHxAGwHUCx9Thh3FsC2fX+7ryTYGbNbpqTWfPEJAGknhGeexqWbFK1+boA7T7l2i
         cvZsPOsPIDZabmoL1UYaQ+W0PbauJN8DEj9jsFE1MONzFGabg2F0r698TyuuiWsH50oP
         WNj1umDfsuCg8kJggoxamsUhZs+OZeDDFlixPn8g1MsXajPaIUXOBnIqcNt2Mm8I/+uO
         laHDPUW5/MBzYBYJarVwqxAoi6OOwB5Zw0ic+dsbDsopHMdUSJJd1/BaMGf/WU2MJrLG
         hSjR4vV3n0yt9gYg/ctMJrrFHZGySk92o/C+2L1l6BXChx8u64b+cCyyN4cYN2OMU/2i
         V6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684120421; x=1686712421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HfO0FQe7LL8tpwg2PdMURaHU+jV7nrgpfKB4jccXJDQ=;
        b=TURNCvXJlwtci6WNG/Yc5w/HZs2jo5stgqkBGTAhDwmfWctkltqwLN/lgh4/ajzLwB
         wmMsmMP3RoyMofXnfXoXGtUyuMZDgL+1LggNAzpETQCBehDOQWQ/DSbMYYLwWJi/dg1W
         sTB1Z4xy8SrtFW0I1eD03FWe1xypv2OJ7hnE0CAjdgIUiSLrtosGP8gvf6BCC3KZZlod
         NuCg3WhBjomfCw77IQSNiTc8a5WMAO3pPDKXlMKA4SzgSzNCktmFveDHnCc5mEowpKEw
         18MHP2VE1DWaU5hCmWJx6clViXpgbC6N0wop4SCNbsz170p8vb9U4CGA1WikHwwuI1eY
         E2sg==
X-Gm-Message-State: AC+VfDzswF2ciQESfRUy8HROF/Qd5oCakPz6AU2iX1DBxOGD3OXElmV7
        S1lEQI6mVElU6zXaeYO7160=
X-Google-Smtp-Source: ACHHUZ4Eu56onjEdC395JngFpHHeJLPPLSgxGJ5U39ha0VlL1QzP6hOvCQttWBynsnX9GU1y9lnZ2Q==
X-Received: by 2002:a05:6a20:3d1a:b0:104:d028:ffe8 with SMTP id y26-20020a056a203d1a00b00104d028ffe8mr10782506pzi.45.1684120421467;
        Sun, 14 May 2023 20:13:41 -0700 (PDT)
Received: from localhost.localdomain ([43.132.98.42])
        by smtp.googlemail.com with ESMTPSA id o4-20020a17090a744400b00252b3328ad8sm4943577pjk.0.2023.05.14.20.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 20:13:41 -0700 (PDT)
From:   Ze Gao <zegao2021@gmail.com>
X-Google-Original-From: Ze Gao <zegao@tencent.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ze Gao <zegao@tencent.com>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH 1/4] rethook: use preempt_{disable, enable}_notrace in rethook_trampoline_handler
Date:   Mon, 15 May 2023 11:13:10 +0800
Message-Id: <20230515031314.7836-2-zegao@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515031314.7836-1-zegao@tencent.com>
References: <20230515031314.7836-1-zegao@tencent.com>
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

