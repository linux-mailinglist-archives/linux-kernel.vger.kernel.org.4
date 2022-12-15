Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D3A64D856
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 10:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiLOJN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 04:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiLOJNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 04:13:55 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E232E9F8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 01:13:53 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id n3so6259955pfq.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 01:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CV/yxiAD8I/dVWILLoVEzHnUUSycLRVJuKvOLcZE2pw=;
        b=beg44w5fksmsGwVqCXhL3LWHUgBDFXHHp8S9HKehkPtfZzXoWY6aMeXMFm0lQJMLyA
         iSRX8qOUXHVb1hDYG+6/ZTrsnNPfK5rHwsvAjlkZlXpZNmGN8e+wRJ9/tw0BuIiz0UWe
         GCVQXNVjclrh+F0mikOVP1I1wNd+GOkhAUigtOeVzSJrm2tn5rDmotcufYbKHYljmVzp
         o+Yg0K1pHVFOT5SCphcbV3PcwKRUFZuNf6H8C4GBN8wNsZCXdcObihEtv2hHdf9G+8X4
         UM3UPUaAy1BEf1W0Kf4UxfIaIR0Qbfc2mpoO3Ww9qQ4WJleODSsnox5F8iuMwNDY41/Z
         FvIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CV/yxiAD8I/dVWILLoVEzHnUUSycLRVJuKvOLcZE2pw=;
        b=JBoKZCbx5Yye/73jfCWf3IZdTELkqDfcG8ySFqyjqasDJ/CL/Oxu5B044nXeujr+Yl
         lMp5h8teft2NPq6//kpnHrRePODSFpGy7Rv19hnP5d+4QlJTqKxoS825lNNVlDYRo8rX
         Jsut4VU7/Wg/eQO0DXcp9pMH1oV5xm7le9B8twdCDhNz8qG3n2Ekn4b1xfertH/rs8g5
         0y5GBQvKFwZNi/MgckJrVmOy2qxZvLX9SlskUwTtgjq0zf+Y0hnONOTqt2Uqt08R0SaB
         duRGLFcjkvHjFTaN9Ox76wc5bwzrEfPjtM9Gcrz87lOop6Jl9QdWOiLdRcfW8cpnF9ut
         wmTA==
X-Gm-Message-State: ANoB5pn8DOD85fQtMefByWq6PYPLXfFM9t54ep1iJQ8xuVYwXbYxwEg7
        +M3iRgXH6sZIlMJB3qRX80M=
X-Google-Smtp-Source: AA0mqf6U6GYMHr0h3xlUOa6iSaDAaBflsbEiXohceX6teh2LBEcdggzqs8d2jcWXFBhXwhpi3IcjEA==
X-Received: by 2002:a05:6a00:2913:b0:579:6402:64ce with SMTP id cg19-20020a056a00291300b00579640264cemr13941944pfb.8.1671095633001;
        Thu, 15 Dec 2022 01:13:53 -0800 (PST)
Received: from ubuntu.localdomain ([60.221.148.50])
        by smtp.gmail.com with ESMTPSA id p4-20020aa79e84000000b00576259507c0sm1222295pfq.100.2022.12.15.01.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 01:13:52 -0800 (PST)
From:   Donglin Peng <dolinux.peng@gmail.com>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, xiehuan09@gmail.com,
        linux-kernel@vger.kernel.org,
        Donglin Peng <dolinux.peng@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v4] tracing/probe: add a char type to show the character value of traced arguments
Date:   Thu, 15 Dec 2022 01:13:46 -0800
Message-Id: <20221215091346.33710-1-dolinux.peng@gmail.com>
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

The to be traced function is 'void demo_func(char type, char *name);', we
can add a kprobe event as follows to show argument values as we want:

echo 'p:myprobe demo_func $arg1:char +0($arg2):char[2]' > kprobe_events

we will get the following trace log:

... 95.451350: myprobe: (demo_func+0x0/0x29) arg1=A arg2={b,p}

Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
---
Changes in v4:
 - update the example in the commit log

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

