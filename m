Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1FAF64B486
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 12:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235383AbiLMLyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 06:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235442AbiLMLyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 06:54:25 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7BADF7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 03:54:25 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id b13-20020a17090a5a0d00b0021906102d05so3236164pjd.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 03:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5SGwK/6oPfn8HdbBysE15KD2RmCgscLBo4xIXtp01Y8=;
        b=TLjK+fZQilsZXzUXzwNLPLYSRK2rG4IbGoi73XfcqT1Tii1DHpMqydYrJ97FWu+PX3
         Lr69knq8EcZ9WH4rqtVCBex7ppn4ymPqh9c6NPSGtGr7PcIBQU2a8pIXILDJ2CMYvri+
         2qluteI1mZzWWc75engVQbTGVgnylh8zk6F+IViFyXzCCyDxJdjDpJA/BC2Vcn9tbS1B
         P8kqzw0Xcu9RA+ykfCHqrfS3ABrtdYEV01uzFiwlEMXT3M1lyTVBt4vhrtd+FdqH4wDT
         CUKxD3hp+MOhr1dzo0Ngq6f4rBOnKLz4tx8+eWSOtH/FKQfiXOrLW0tpqS1Tei6VvsmJ
         vLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5SGwK/6oPfn8HdbBysE15KD2RmCgscLBo4xIXtp01Y8=;
        b=tHsF5UzxP3hpE4Ffg3bCJSVXNXr3VrR1uzo19R7Y5tyY5P44tnHRZmxVpvHy3QWce/
         ttw+oSN1lt4KKgoplITwYuWjzmZwrhpMKTCcktKKHvdxFCyXNAj9TxwsMvImI00Pw9v8
         gZWPVFG7IU/EHDSvNUzrpyaPk3R2ZP7K8w0hgXtK+Q4d7i2ASpEQ5xRWJNaJBDK0vmJP
         ao+dJJiopEPZZi5CmEejAf5pvfpsPUwsogpan+yaN9/yLIWPRevGdQlkdZJVOrZgkeQA
         eK2gJlzR6sK7Cu/TIXG/yz4asi8bYSjAApwiF9Okff9+D3iqqyyAxlriI0RvS0l+fU/1
         ddsw==
X-Gm-Message-State: ANoB5pmWDo+WKUsv9YGiqAhfb7utUZZ0u/++wgIr6fDqGtnocs244/ru
        sGbJoxcRQCHxOo0vBigtULo=
X-Google-Smtp-Source: AA0mqf4Ez2bvMSg/p1Lzr1EJ6GqINpOTa3j7tBXS1apnGTJupfRhnkwpQEk+2PJNRomc1nPRPyQQGQ==
X-Received: by 2002:a17:903:555:b0:188:8cfc:6ba7 with SMTP id jo21-20020a170903055500b001888cfc6ba7mr17605162plb.68.1670932464871;
        Tue, 13 Dec 2022 03:54:24 -0800 (PST)
Received: from ubuntu.localdomain ([118.73.12.140])
        by smtp.gmail.com with ESMTPSA id b7-20020a170902650700b001868bf6a7b8sm8252776plk.146.2022.12.13.03.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 03:54:23 -0800 (PST)
From:   Donglin Peng <dolinux.peng@gmail.com>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, xiehuan09@gmail.com,
        linux-kernel@vger.kernel.org, Donglin Peng <dolinux.peng@gmail.com>
Subject: [PATCH] tracing/probe: add a char type to print the character value of traced arguments
Date:   Tue, 13 Dec 2022 03:53:04 -0800
Message-Id: <20221213115304.3964458-1-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
---
 Documentation/trace/kprobetrace.rst | 3 ++-
 kernel/trace/trace_probe.c          | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

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
-- 
2.25.1

