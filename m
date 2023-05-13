Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B938D70153A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 10:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjEMISd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 04:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjEMISb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 04:18:31 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D334E270E;
        Sat, 13 May 2023 01:18:30 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1ab267e3528so77365685ad.0;
        Sat, 13 May 2023 01:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683965910; x=1686557910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hxa4rxa1h1xXqvZgIrJ/FdwQTgDs+stW88TIUg6eXhY=;
        b=SJNnPIeB9h82iR0tlVUJNt0KW7TwWNV2/y7dxWcDwaUx1rRP/XBrywImTgs1RJ6DH+
         2RaEH3qpmDPQjfcd/qha4tYV5mPRIMp+/tzTi2iU0QXBLPlY5ePv7px0VuUmNhvFjOgq
         Se2bYk/0hr1aHVWID2g8MLI6EdH7W6mZEcpRAqdovCG7+f1NXqvpXvz+ROZCA8Utu6Q9
         K2Sa6R/Ks6voIvv4zysGqvRGltjYt+yLJ8mErd9IUvU+92othwIqHNZhhI9CQMd/VVFt
         Wgj+mxJDJRgWskf17J2mL0xF0Q/fipkTdzpo73t3sM2ucpoVU3jbkm0UjsSt0XOKcDcY
         43og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683965910; x=1686557910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hxa4rxa1h1xXqvZgIrJ/FdwQTgDs+stW88TIUg6eXhY=;
        b=VU/mTSbVkEdoNWLowzrg/c65efhMGdyTNF8Ij4vUTUYM2HA0nm6Nwv3WW2r7e+wQho
         VXzZGCPubzHhc/iUGq1RH6tvBW47YmTaO+2wQRF8ilfDvVI212AkyOtxTGHkLQY1lfwJ
         HOT9cL3+qJRp0tzGEiLt1CsfrklPB+hm4cLvfsrRZJBEDF6HgCMhKk1mnQeJ4iWSqPXo
         b49CKRi/ESMRQaBMm7KyrLi30vFxBTQWNUpMtU0n1jyRKLQu3zbxjFScj91jZDQIDNzl
         tGzXXKx23Uwiw9GjP1skGWRtWtngNM+ej2N7hNYOdkAlBdnNV7q+v87yqJIblSuGuJbG
         XxBA==
X-Gm-Message-State: AC+VfDw8GMIzD9r/m+hzAchpCWsbGNa+EYQommnRYflZwVoFzrNE7mXf
        8z80zO1vD5NDjAOadbDshEaTal/cUhUn4g==
X-Google-Smtp-Source: ACHHUZ6koZqghO760PzfPP7MBCnirNYhEDdAW61bzbl3IwRrdrevvHTrmiRF2hY++jAz+ZIbC4az4g==
X-Received: by 2002:a17:903:64c:b0:1ab:107b:c127 with SMTP id kh12-20020a170903064c00b001ab107bc127mr25375943plb.59.1683965910229;
        Sat, 13 May 2023 01:18:30 -0700 (PDT)
Received: from localhost.localdomain ([43.132.98.116])
        by smtp.googlemail.com with ESMTPSA id d23-20020a170902729700b001a216d44440sm9239286pll.200.2023.05.13.01.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 01:18:29 -0700 (PDT)
From:   Ze Gao <zegao2021@gmail.com>
X-Google-Original-From: Ze Gao <zegao@tencent.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ze Gao <zegao@tencent.com>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH] rethook: use preempt_{disable, enable}_notrace in rethook_trampoline_handler
Date:   Sat, 13 May 2023 16:16:56 +0800
Message-Id: <20230513081656.375846-1-zegao@tencent.com>
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
notrace version in rethook_trampoline_handler so worries about stack
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

