Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2075705E53
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 05:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbjEQDqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 23:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbjEQDp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 23:45:57 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0956D526E;
        Tue, 16 May 2023 20:45:44 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1ab1b79d3a7so2945855ad.3;
        Tue, 16 May 2023 20:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684295144; x=1686887144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0tAjWrmzrXGyO7rim5mWO1xH9wWB24VwxwxXjgy9nqY=;
        b=IXqKz9k5vSycU5LcG+OjyO4IGbHD5KIhty+95sowy/bKSzZa6tVax2mkeL31D/yJXY
         zZ1ImDoihBfW8G988jhG7sfn7iDKErXUynFJTStUSB5InW+x9v4xALBs6IRvfWppMBCb
         Fw9RijMCj0KacaPY0rt1opW3J+Q1n1/ewB/QVr0B2wcDg8nvSsTgVbY876opBh2vwXh9
         RdhfyRMJ1vqrv7dawirsMEnJkbkG/ZpErcsyRoOUyhNEV0o8vS66V1QEbsBQGpKlVvqz
         882Rda4fpgf0Ayg1p+FBxlEBJO9Q5Ee1eINQYzfKeZjacQZhCSJaPRU+age+OA6o6P6Q
         1ILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684295144; x=1686887144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0tAjWrmzrXGyO7rim5mWO1xH9wWB24VwxwxXjgy9nqY=;
        b=Mf2pAA5GywEimpHyglZ/yVF02LoBun5PT+++n5d/jWy2rKfFAmBOOum/TU8ms6uR7m
         CbZ1aWn/HLL9UQ2DhE47+m/o2IRX2rVx1h3ux9D4nzs+cEHul+6HJVgrlnbV0IPf3jDH
         Rx7EqCQbsr6/RsaD0INfXsQuEn3Xd8uziYCg52ljH6sRjmMwVPpspijAXqKmZBOK6J+q
         TSpqUJucdpRe92IK6mrAj2ZfUfuauLdrWEyPClewxCnNvEXBgUvrS8MPJNmJ5M/Zn9w9
         CwTvKe4PcxhKV4CV3mTs+miv98O0IesFUzuj07/81d1uekX91uYowZA/78lGFTmWF8Dz
         k5WA==
X-Gm-Message-State: AC+VfDzBQ2qllEOApQ6DfgU8cQYODEzHleZJY9bknmGblfLEWbBfPXC3
        G+hnUAQ+3Clp2f1ntQqa0KhSSk3eYGWUnA==
X-Google-Smtp-Source: ACHHUZ5hBx5XqkMa8UrfCmDpz7N6J9hB4QncpaWly6GjeoRST5WdYe4jEmV14lesqGLCCx1F9Jv8EA==
X-Received: by 2002:a17:902:dace:b0:1ac:6e1f:d1bd with SMTP id q14-20020a170902dace00b001ac6e1fd1bdmr44584262plx.19.1684295144122;
        Tue, 16 May 2023 20:45:44 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.83])
        by smtp.googlemail.com with ESMTPSA id t2-20020a170902e84200b001a19196af48sm16336746plg.64.2023.05.16.20.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 20:45:43 -0700 (PDT)
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
        Yonghong Song <yhs@fb.com>, Ze Gao <zegao@tencent.com>
Subject: [PATCH v3 4/4] rethook, fprobe: do not trace rethook related functions
Date:   Wed, 17 May 2023 11:45:09 +0800
Message-Id: <20230517034510.15639-5-zegao@tencent.com>
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

These functions are already marked as NOKPROBE to prevent recursion and
we have the same reason to blacklist them if rethook is used with fprobe,
since they are beyond the recursion-free region ftrace can guard.

Signed-off-by: Ze Gao <zegao@tencent.com>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Link: https://lore.kernel.org/linux-trace-kernel/20230516071830.8190-5-zegao@tencent.com
---
 arch/riscv/kernel/probes/Makefile | 2 ++
 arch/s390/kernel/Makefile         | 1 +
 arch/x86/kernel/Makefile          | 1 +
 3 files changed, 4 insertions(+)

diff --git a/arch/riscv/kernel/probes/Makefile b/arch/riscv/kernel/probes/Makefile
index c40139e9ca47..8265ff497977 100644
--- a/arch/riscv/kernel/probes/Makefile
+++ b/arch/riscv/kernel/probes/Makefile
@@ -4,3 +4,5 @@ obj-$(CONFIG_RETHOOK)		+= rethook.o rethook_trampoline.o
 obj-$(CONFIG_KPROBES_ON_FTRACE)	+= ftrace.o
 obj-$(CONFIG_UPROBES)		+= uprobes.o decode-insn.o simulate-insn.o
 CFLAGS_REMOVE_simulate-insn.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_rethook.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_rethook_trampoline.o = $(CC_FLAGS_FTRACE)
diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
index 8983837b3565..6b2a051e1f8a 100644
--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -10,6 +10,7 @@ CFLAGS_REMOVE_ftrace.o		= $(CC_FLAGS_FTRACE)
 
 # Do not trace early setup code
 CFLAGS_REMOVE_early.o		= $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_rethook.o		= $(CC_FLAGS_FTRACE)
 
 endif
 
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index dd61752f4c96..4070a01c11b7 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -17,6 +17,7 @@ CFLAGS_REMOVE_ftrace.o = -pg
 CFLAGS_REMOVE_early_printk.o = -pg
 CFLAGS_REMOVE_head64.o = -pg
 CFLAGS_REMOVE_sev.o = -pg
+CFLAGS_REMOVE_rethook.o = -pg
 endif
 
 KASAN_SANITIZE_head$(BITS).o				:= n
-- 
2.40.1

