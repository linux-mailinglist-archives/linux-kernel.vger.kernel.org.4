Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67686705E4F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 05:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjEQDqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 23:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbjEQDps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 23:45:48 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC804ECF;
        Tue, 16 May 2023 20:45:38 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1ae3fe67980so4102875ad.3;
        Tue, 16 May 2023 20:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684295138; x=1686887138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TpQR3cccQnkFxa/VBlSDTBSv5SyL5gibvWrL1LrLMho=;
        b=UERCSL4JnKxWSII93BWPVPBBwK6uL6PmIwlr8ZXOKLlNtpxo5SuSIG9NCdRoUWZOoZ
         +hYxmrQqH/Q8Nn729aEESqAHFErEnG5gxcYEkikRN8HovztUkVCPnfidYHdjmfJn+l6e
         gPuj5+IyFNkSWsVE10FucW4qXqClKG6/w9Wcd6mq92qXTmFiEFyl9MK0fjfWsOjlNaiE
         QByDM+aLJ9R3qtw1YAJQhEHVvBAURJgNELbn6b65JIvslmWs6VSBHTubnpB57vEVbPCm
         +o0szfsEnOcquAkSel2xOZHbDEFVqFPW+K6B6MfoBO6zQxqzqLXJyy1b1eY7ngteuAgP
         EiJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684295138; x=1686887138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TpQR3cccQnkFxa/VBlSDTBSv5SyL5gibvWrL1LrLMho=;
        b=RKdobhXpfuoQxTdnrJmdVxhPJ5Dnkh+KCUsJx/VqgEgSySy9ABMHXM8j8mhkkD86Go
         5baR2bC9Wb4rPYXMhs5ow9mNWZvArVb+Z+/RV57UL7X0SZuae3ksSzMwhze7m0cgzXdC
         nfJbN2exVCNCXSgPYI8cdO/OSNRX9XO2C7u2T/bQ1w/5ZNVJR3YN595/dTbImC+9f/XA
         7dZg7AcYENfDT3h1JYUWp1oq+FOjHrf1oofDu9rjUTWsE51+ejzQvmiHXrKKZFZvO8QQ
         zdqdYXDAlIOt8he4OSXhKRce58sm12cbzUJxkKs/B80WsxsehK9NNB3dOYEte3RbU5M7
         s8UA==
X-Gm-Message-State: AC+VfDx6Jx39R1Cu8ClguI54YsgEJJQX6HALFPazakLttX7p5B3uXQFb
        bP9uZinnmhyyl2qVWN4bHpI=
X-Google-Smtp-Source: ACHHUZ72TBl2qjdRobeJYwihGY/op1xZOYs590vrrpWwxotkrQx2nlDtr1JT0DXq9EF6bOCOpjSqyw==
X-Received: by 2002:a17:902:9897:b0:1ab:253e:6906 with SMTP id s23-20020a170902989700b001ab253e6906mr37006175plp.67.1684295138247;
        Tue, 16 May 2023 20:45:38 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.83])
        by smtp.googlemail.com with ESMTPSA id t2-20020a170902e84200b001a19196af48sm16336746plg.64.2023.05.16.20.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 20:45:37 -0700 (PDT)
From:   Ze Gao <zegao2021@gmail.com>
X-Google-Original-From: Ze Gao <zegao@tencent.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>, x86@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Conor Dooley <conor@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Yonghong Song <yhs@fb.com>, Ze Gao <zegao@tencent.com>,
        stable@vger.kernel.org
Subject: [PATCH v3 3/4] fprobe: add recursion detection in fprobe_exit_handler
Date:   Wed, 17 May 2023 11:45:08 +0800
Message-Id: <20230517034510.15639-4-zegao@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517034510.15639-1-zegao@tencent.com>
References: <20230517034510.15639-1-zegao@tencent.com>
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

fprobe_hander and fprobe_kprobe_handler has guarded ftrace recursion
detection but fprobe_exit_handler has not, which possibly introduce
recursive calls if the fprobe exit callback calls any traceable
functions. Checking in fprobe_hander or fprobe_kprobe_handler
is not enough and misses this case.

So add recursion free guard the same way as fprobe_hander. Since
ftrace recursion check does not employ ip(s), so here use entry_ip and
entry_parent_ip the same as fprobe_handler.

Fixes: 5b0ab78998e3 ("fprobe: Add exit_handler support")
Signed-off-by: Ze Gao <zegao@tencent.com>
Cc: stable@vger.kernel.org
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Link: https://lore.kernel.org/linux-trace-kernel/20230516071830.8190-4-zegao@tencent.com
---
 kernel/trace/fprobe.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 097c740799ba..281b58c7dd14 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -17,6 +17,7 @@
 struct fprobe_rethook_node {
 	struct rethook_node node;
 	unsigned long entry_ip;
+	unsigned long entry_parent_ip;
 	char data[];
 };
 
@@ -39,6 +40,7 @@ static inline void __fprobe_handler(unsigned long ip, unsigned long
 		}
 		fpr = container_of(rh, struct fprobe_rethook_node, node);
 		fpr->entry_ip = ip;
+		fpr->entry_parent_ip = parent_ip;
 		if (fp->entry_data_size)
 			entry_data = fpr->data;
 	}
@@ -114,14 +116,26 @@ static void fprobe_exit_handler(struct rethook_node *rh, void *data,
 {
 	struct fprobe *fp = (struct fprobe *)data;
 	struct fprobe_rethook_node *fpr;
+	int bit;
 
 	if (!fp || fprobe_disabled(fp))
 		return;
 
 	fpr = container_of(rh, struct fprobe_rethook_node, node);
 
+	/*
+	 * we need to assure no calls to traceable functions in-between the
+	 * end of fprobe_handler and the beginning of fprobe_exit_handler.
+	 */
+	bit = ftrace_test_recursion_trylock(fpr->entry_ip, fpr->entry_parent_ip);
+	if (bit < 0) {
+		fp->nmissed++;
+		return;
+	}
+
 	fp->exit_handler(fp, fpr->entry_ip, regs,
 			 fp->entry_data_size ? (void *)fpr->data : NULL);
+	ftrace_test_recursion_unlock(bit);
 }
 NOKPROBE_SYMBOL(fprobe_exit_handler);
 
-- 
2.40.1

