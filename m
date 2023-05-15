Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6E7702228
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 05:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235813AbjEOD1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 23:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbjEOD1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 23:27:05 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7F01997;
        Sun, 14 May 2023 20:27:04 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6434e263962so8954157b3a.2;
        Sun, 14 May 2023 20:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684121224; x=1686713224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HfO0FQe7LL8tpwg2PdMURaHU+jV7nrgpfKB4jccXJDQ=;
        b=WVB3C+5of4uMP7ScO4Yvn60WFDYoZNDWLC01FoZNuZamSGzinFIhL1w/yn5LeSaHsf
         2mLOOVY3Edk9fekV4079ljH4DU4Iqdw7lhLf6R6cmjsLGHOhoRbBglRCi3DFwZ5jTP7C
         GrbVATSZ3VdzrORZcPMoHtC94RWmOjbHrb/jRlj2Urt07DFAmnUl+GeWurCUYg/tdbU0
         b9M7fiY9FzWmDsK2/OAEWmMQAeuftDNcl7Y2GYAIR/iUnLRUriLPTEoDCeCwgT7m3iwY
         KG4kbm1vSDeHkz/PUOiXUGZJsTlGVSQwjg0AdRpxH/Baih5krASD17n4VZxKuzWlL0rz
         E4kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684121224; x=1686713224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HfO0FQe7LL8tpwg2PdMURaHU+jV7nrgpfKB4jccXJDQ=;
        b=VI8pyGag1JXpGFppzjhRBEsy8D9nctXuUW1cncuwLrskLgYn+AqhFUxfYDXkfKpFMp
         aVPm25iOBdY4MaynVxE+AXGHLCr2noMClUbNPj9u7dCLRVujw3f2pNRVbguXBtJEcpjd
         2fREDSya3zsx/l5s3Gfg+chof0irn1e6ZmhybviQhAc2wchXgSXoRKQFx2jP9RwS3lP7
         MZZ+Sfnkt1bF95xRR8TxlUbEZ/aIfVA+Hbe5L7dOHAluBT94t67AKJtPym07ML56j67K
         WYQS38NJbW+LSuO078wAKHjJO1INNJFDiwIDR+1sQXdEKN5Gff0GSmGSewZCYdzjBxyj
         QKXw==
X-Gm-Message-State: AC+VfDyJGD03mtPjFNLBT0iDUoiQDos8TbOkKt97bg/UHUFZZqQbQFwr
        hfz/tl95rrh/QZtnH9+n8Vg=
X-Google-Smtp-Source: ACHHUZ5Opnskn8gs8ouEil7iwtpjR/89ZUipzgn5gG8RbnxJ+alCTkftBTVdj6emh/UTrgd5ZRsLRg==
X-Received: by 2002:a05:6a20:4291:b0:100:efa1:eab0 with SMTP id o17-20020a056a20429100b00100efa1eab0mr31177918pzj.2.1684121223711;
        Sun, 14 May 2023 20:27:03 -0700 (PDT)
Received: from localhost.localdomain ([43.132.98.42])
        by smtp.googlemail.com with ESMTPSA id s6-20020a632146000000b0051416609fb7sm10363825pgm.61.2023.05.14.20.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 20:27:03 -0700 (PDT)
From:   Ze Gao <zegao2021@gmail.com>
X-Google-Original-From: Ze Gao <zegao@tencent.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ze Gao <zegao@tencent.com>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH 1/4] rethook: use preempt_{disable, enable}_notrace in rethook_trampoline_handler
Date:   Mon, 15 May 2023 11:26:38 +0800
Message-Id: <a17a14abfb81cb0eea77c2ee10d7fc98d5d5a73e.1684120990.git.zegao@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1684120990.git.zegao@tencent.com>
References: <cover.1684120990.git.zegao@tencent.com>
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

