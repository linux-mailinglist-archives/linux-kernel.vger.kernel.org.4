Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C7A64D722
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 08:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbiLOHQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 02:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiLOHPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 02:15:55 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37E0DEA2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 23:15:42 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id o12so9543861pjo.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 23:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=28lIEjjSLrIrKzN42jlij3OXxr7/L9TpyxygGCsWs/E=;
        b=iMJx1Jh4WMUwPeaN/c1HVaNhuZ+f/LIMJLX0bCUkp2+3TsaIXe1wYxPfkiZM6C7KXS
         5DogDQq+NQtD05BArnrJrvUTC6WkPt2n7/bK9qMtMOSL8kKpyQ2FHbv6+jpQzpQ8LUCz
         XnEH7gibGVEb5nR453BEl5A1auansthkxY7GGH9KLQU29zUp+KwXE5ylPhPoFRsRZQE5
         ZqkiLUvbATKJMJ1Kw1JzqKjsKCdAPx3PiAlgp4BYwSkjv3fN32YvVpiS0cQwDucon9CW
         CRCJJ8mBqGF2Y5E8HEo7ljeofIySfGt7EHbuL+keqJSLc66oyxXj8aAjfhfzbh3zPQDd
         8O+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=28lIEjjSLrIrKzN42jlij3OXxr7/L9TpyxygGCsWs/E=;
        b=5XQVmSEKsYdhMwlbi+WavVByy1M0tCU/abchhBP/Gg7+1vRR5Au2bcEcb7ZsWKBTe1
         b0pZZ10VTR3w8A8cFQPo5d0gLAi8o6tlX1QDRA9h9NiVZEqkwXX0NHCfI+a8omw0jNsP
         aJ7iYrnfuGx4fgiPd7PgzNVv3J5dvccP9JUM2tDDOEyVEG1x0XrVP6nNCc6qZnQw4qQK
         Rv9KiTlef941vWVwwFYvackOBw4SyxD/ul1W9A5zkPkUha8QmDsT6yP2ghurAZT2uegP
         qm/PnLihWvTgft2ZONdciSj+5ZBVTa7hM3ViLm9TXHbQYG2LZ+KZZR6EXHiuKqtxquxt
         K06A==
X-Gm-Message-State: ANoB5pmH1UVq3F5wA92WWIYRJ7zNcpIduZu9iyJSLjUstZNUCiAlNLE2
        hZY7Hnfk13YekFnBKpc0gzn0wJrhk9k=
X-Google-Smtp-Source: AA0mqf6A5+elptk39mPtBfX/iyBZ1CICZXoJZo5xTyhIIfy9va7/46jGmvliFh6iZj5svW0EgEnJsg==
X-Received: by 2002:a17:902:a418:b0:186:e8c1:f583 with SMTP id p24-20020a170902a41800b00186e8c1f583mr26923147plq.64.1671088542372;
        Wed, 14 Dec 2022 23:15:42 -0800 (PST)
Received: from ubuntu.localdomain ([118.73.12.140])
        by smtp.gmail.com with ESMTPSA id a15-20020a1709027e4f00b0018b61ecf36fsm2939759pln.287.2022.12.14.23.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 23:15:41 -0800 (PST)
From:   Donglin Peng <dolinux.peng@gmail.com>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, xiehuan09@gmail.com,
        linux-kernel@vger.kernel.org,
        Donglin Peng <dolinux.peng@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v3] tracing/probe: add a char type to print the character value of traced arguments
Date:   Wed, 14 Dec 2022 23:14:58 -0800
Message-Id: <20221215071458.17868-1-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are scenes that we want to show the character value of traced
arguments other than a decimal or hexadecimal or string value for debug
convinience. Add a new type named 'char' to do it.

For example:

echo 'p:myprobe xxxx $arg1:char' > kprobe_events

echo 'p:myprobe xxxx $arg1:char[2]' > kprobe_events

Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
---
Changes in v3:
 - update readme_msg

Changes in v2:
 - fix build warnings reported by kernel test robot
 - modify commit log
---
 Documentation/trace/kprobetrace.rst | 3 ++-
 kernel/trace/trace.c                | 2 +-
 kernel/trace/trace_probe.c          | 2 ++
 kernel/trace/trace_probe.h          | 1 +
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
index 4274cc6a2f94..007972a3c5c4 100644
--- a/Documentation/trace/kprobetrace.rst
+++ b/Documentation/trace/kprobetrace.rst
@@ -58,7 +58,7 @@ Synopsis of kprobe_events
   NAME=FETCHARG : Set NAME as the argument name of FETCHARG.
   FETCHARG:TYPE : Set TYPE as the type of FETCHARG. Currently, basic types
 		  (u8/u16/u32/u64/s8/s16/s32/s64), hexadecimal types
-		  (x8/x16/x32/x64), "string", "ustring" and bitfield
+		  (x8/x16/x32/x64), "char", "string", "ustring" and bitfield
 		  are supported.
 
   (\*1) only for the probe on function entry (offs == 0).
@@ -80,6 +80,7 @@ E.g. 'x16[4]' means an array of x16 (2bytes hex) with 4 elements.
 Note that the array can be applied to memory type fetchargs, you can not
 apply it to registers/stack-entries etc. (for example, '$stack1:x8[8]' is
 wrong, but '+8($stack):x8[8]' is OK.)
+Char type can be used to show the character value of traced arguments.
 String type is a special type, which fetches a "null-terminated" string from
 kernel space. This means it will fail and store NULL if the string container
 has been paged out. "ustring" type is an alternative of string for user-space.
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 5cfc95a52bc3..a64e206f94e6 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5615,7 +5615,7 @@ static const char readme_msg[] =
 	"\t           $stack<index>, $stack, $retval, $comm,\n"
 #endif
 	"\t           +|-[u]<offset>(<fetcharg>), \\imm-value, \\\"imm-string\"\n"
-	"\t     type: s8/16/32/64, u8/16/32/64, x8/16/32/64, string, symbol,\n"
+	"\t     type: s8/16/32/64, u8/16/32/64, x8/16/32/64, char, string, symbol,\n"
 	"\t           b<bit-width>@<bit-offset>/<container-size>, ustring,\n"
 	"\t           <type>\\[<array-size>\\]\n"
 #ifdef CONFIG_HIST_TRIGGERS
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 36dff277de46..a4abf7f6c295 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -50,6 +50,7 @@ DEFINE_BASIC_PRINT_TYPE_FUNC(x8,  u8,  "0x%x")
 DEFINE_BASIC_PRINT_TYPE_FUNC(x16, u16, "0x%x")
 DEFINE_BASIC_PRINT_TYPE_FUNC(x32, u32, "0x%x")
 DEFINE_BASIC_PRINT_TYPE_FUNC(x64, u64, "0x%Lx")
+DEFINE_BASIC_PRINT_TYPE_FUNC(char, u8, "%c")
 
 int PRINT_TYPE_FUNC_NAME(symbol)(struct trace_seq *s, void *data, void *ent)
 {
@@ -93,6 +94,7 @@ static const struct fetch_type probe_fetch_types[] = {
 	ASSIGN_FETCH_TYPE_ALIAS(x16, u16, u16, 0),
 	ASSIGN_FETCH_TYPE_ALIAS(x32, u32, u32, 0),
 	ASSIGN_FETCH_TYPE_ALIAS(x64, u64, u64, 0),
+	ASSIGN_FETCH_TYPE_ALIAS(char, u8, u8,  0),
 	ASSIGN_FETCH_TYPE_ALIAS(symbol, ADDR_FETCH_TYPE, ADDR_FETCH_TYPE, 0),
 
 	ASSIGN_FETCH_TYPE_END
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index de38f1c03776..8c86aaa8b0c9 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -164,6 +164,7 @@ DECLARE_BASIC_PRINT_TYPE_FUNC(x16);
 DECLARE_BASIC_PRINT_TYPE_FUNC(x32);
 DECLARE_BASIC_PRINT_TYPE_FUNC(x64);
 
+DECLARE_BASIC_PRINT_TYPE_FUNC(char);
 DECLARE_BASIC_PRINT_TYPE_FUNC(string);
 DECLARE_BASIC_PRINT_TYPE_FUNC(symbol);
 
-- 
2.25.1

