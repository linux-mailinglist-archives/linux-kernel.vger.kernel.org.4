Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091936769DB
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 23:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjAUWx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 17:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjAUWx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 17:53:56 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBF02798F
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 14:53:55 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id r9so7748199wrw.4
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 14:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQ0vKpXMevlkvELPWPprpptk067lWow9uoTw6yIP2k4=;
        b=VRbMVxuEfiVah3EHHwyAfjK75rQ60GkUS0LpmkDIUck051uzMK8IXhm6kwnjK/HxIg
         OJSTSEq1iGyX2P8wTVl8FJQZ6NDvWInUXeN73jRDhSd1zvNtjceQjwt4id1IId9knHX5
         1/L6tG071mp1O7vdh1jqVtrt7DVBoDhZL2w+NDymQACbegbiNphSTonK7b6Yo+tZsJTs
         XGDpOqE49AInOaNIcJa6fNpuDTEFimeZ2eApm5AOo7BopO4/gGAppqarie4a4F+AhZK1
         kDVuN/SHJTFHzGzjT0slIU/Vi32v8Ug8BfeUNDy6bG9xo6MfdihKiWArM0oD1gUituqX
         3r6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uQ0vKpXMevlkvELPWPprpptk067lWow9uoTw6yIP2k4=;
        b=tifZztOABpY/Ab2fQMXWd3ERF2CMTJnhxxpdOXHT5YHAjWMBY8Qdo87seU/Toh2diN
         5TcbXvFor5ju50glCcNOks4MDy+9/PdmRXgUCkg0M+0qOog7JVYMRj5SWZ9FjuzC3Hr1
         84/MN/fgd/GgfbKMq0BS22CCTAEB5R53QtS6pZApJ1OCoJQkth98QQqqNsYtTFwDPLmZ
         K7yN0+qc2mRMPp+5IGfd2MGVQe5bfNXlma09WcvyX88HBImwJECo+wBM5oZLpaD6paVz
         lKxFxutn2AKFy1NJ8hPwZg7yjfqVFMOxBLkxURd4u1UhfLe4EI4peCezZJMXoyu7CHLD
         L7TA==
X-Gm-Message-State: AFqh2kpjtTCnR5TJDBss99DrpBrqiBZk0vxXfroawWMPpf1tgKPaH80g
        rloYIcEcUSg/luOBe5mTDTe0zE64R1DIX6N7
X-Google-Smtp-Source: AMrXdXv3mcoq2nGdYV82MydHDycIZI/Ikt/Bp0QBTn1xIKBuEeLznOU+qWyzojtZglNATuGE9xK/Lw==
X-Received: by 2002:a5d:6b12:0:b0:242:7409:bbf with SMTP id v18-20020a5d6b12000000b0024274090bbfmr12108735wrw.54.1674341633899;
        Sat, 21 Jan 2023 14:53:53 -0800 (PST)
Received: from P-ASN-ECS-830T8C3.mpl.intranet (89-159-1-53.rev.numericable.fr. [89.159.1.53])
        by smtp.gmail.com with ESMTPSA id q16-20020adff950000000b002bcaa47bf78sm29531001wrr.26.2023.01.21.14.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 14:53:53 -0800 (PST)
From:   Yoann Congal <yoann.congal@smile.fr>
To:     linux-trace-kernel@vger.kernel.org
Cc:     Yoann Congal <yoann.congal@smile.fr>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v3 1/3] Documentation: kprobetrace: Fix some typos
Date:   Sat, 21 Jan 2023 23:53:03 +0100
Message-Id: <20230121225304.1711635-2-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230121225304.1711635-1-yoann.congal@smile.fr>
References: <20230121225304.1711635-1-yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Uncapitalise tracepoint
* Hyphen in *-based
* Plurals
* fetch-args -> fetchargs
* 2bytes hex -> 2-byte hex
* .. -> .
* arch -> architecture

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>

TBR typo
---
 Documentation/trace/kprobetrace.rst | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
index 08a2a6a3782f0..5c49cdc8f8323 100644
--- a/Documentation/trace/kprobetrace.rst
+++ b/Documentation/trace/kprobetrace.rst
@@ -6,16 +6,16 @@ Kprobe-based Event Tracing
 
 Overview
 --------
-These events are similar to tracepoint based events. Instead of Tracepoint,
+These events are similar to tracepoint-based events. Instead of tracepoints,
 this is based on kprobes (kprobe and kretprobe). So it can probe wherever
 kprobes can probe (this means, all functions except those with
 __kprobes/nokprobe_inline annotation and those marked NOKPROBE_SYMBOL).
-Unlike the Tracepoint based event, this can be added and removed
+Unlike the tracepoint-based event, this can be added and removed
 dynamically, on the fly.
 
 To enable this feature, build your kernel with CONFIG_KPROBE_EVENTS=y.
 
-Similar to the events tracer, this doesn't need to be activated via
+Similar to the event tracer, this doesn't need to be activated via
 current_tracer. Instead of that, add probe points via
 /sys/kernel/debug/tracing/kprobe_events, and enable it via
 /sys/kernel/debug/tracing/events/kprobes/<EVENT>/enable.
@@ -68,7 +68,7 @@ Synopsis of kprobe_events
 
 Types
 -----
-Several types are supported for fetch-args. Kprobe tracer will access memory
+Several types are supported for fetchargs. Kprobe tracer will access memory
 by given type. Prefix 's' and 'u' means those types are signed and unsigned
 respectively. 'x' prefix implies it is unsigned. Traced arguments are shown
 in decimal ('s' and 'u') or hexadecimal ('x'). Without type casting, 'x32'
@@ -76,14 +76,15 @@ or 'x64' is used depends on the architecture (e.g. x86-32 uses x32, and
 x86-64 uses x64).
 These value types can be an array. To record array data, you can add '[N]'
 (where N is a fixed number, less than 64) to the base type.
-E.g. 'x16[4]' means an array of x16 (2bytes hex) with 4 elements.
+E.g. 'x16[4]' means an array of x16 (2-byte hex) with 4 elements.
 Note that the array can be applied to memory type fetchargs, you can not
 apply it to registers/stack-entries etc. (for example, '$stack1:x8[8]' is
 wrong, but '+8($stack):x8[8]' is OK.)
 String type is a special type, which fetches a "null-terminated" string from
 kernel space. This means it will fail and store NULL if the string container
 has been paged out. "ustring" type is an alternative of string for user-space.
-See :ref:`user_mem_access` for more info..
+See :ref:`user_mem_access` for more info.
+
 The string array type is a bit different from other types. For other base
 types, <base-type>[1] is equal to <base-type> (e.g. +0(%di):x32[1] is same
 as +0(%di):x32.) But string[1] is not equal to string. The string type itself
@@ -120,8 +121,8 @@ space. 'ustring' is a shortcut way of performing the same task. That is,
 
 Note that kprobe-event provides the user-memory access syntax but it doesn't
 use it transparently. This means if you use normal dereference or string type
-for user memory, it might fail, and may always fail on some archs. The user
-has to carefully check if the target data is in kernel or user space.
+for user memory, it might fail, and may always fail on some architectures. The
+user has to carefully check if the target data is in kernel or user space.
 
 Per-Probe Event Filtering
 -------------------------
-- 
2.30.2

