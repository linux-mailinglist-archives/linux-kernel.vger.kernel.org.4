Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF2C61F858
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbiKGQGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbiKGQGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:06:10 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A0D201B9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 08:06:05 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-36f8318e4d0so113009157b3.20
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 08:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uzyJmD4Az7oDjnhe50YqEbIJmUOevvk6mu3w0w9rs0M=;
        b=oKFlD2B2yYnR5QAxTSpg1boCCe5kMcd2OGkAr2b7uP5Vhhu69jDguYhGLf+4jMd/6q
         CJJko9hpe4UAMAZIDiMTcMbjrXPiMBvaL1v7Ou4D0byHWg+oBqWEoA/wLSP5Zvnqoo7p
         h57M0HIiEa6UE9hh6k2hLAp8P0qj3WQfJKRMH5htBfloGT4xYYUhnYOnpb0Dgr51y6dh
         rKlEHkFZhShVV2ygmS4zuDgOnZKw77pRLxLoipkVJ1CMzQqTprBo+FcNedyZ6wexR4Wo
         11wlWC4hZO39Emgr0lFivsQ9L2QdMiFSV/qP0oSAKShveUgnam80LQRHuYtI6cYadp3K
         26+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uzyJmD4Az7oDjnhe50YqEbIJmUOevvk6mu3w0w9rs0M=;
        b=JqwtAQpZ8/5EV5v9mipeGjrcFv4z+tn8BT2C5I4GkDreOxgfW+j9XORPZa/9ZTu+rd
         XAwMY/e3N9uasJ95B5oynNaCWo4XWyZXN8jgKs4BlgqOqlQR+Da/0HHHSQhshZO2xe1c
         0dkLIij1IL0Ir/sdV86BacU3h4/Wc3i3LNfhaKYVxmG3juTHNVRaQGzq5cl9T7u4WGL6
         Z/hMc0sskNZOmZ6Xe1LF2og/KuqB1XhyTYYzRowrwBJAI5NvQ/nxyQ7vwL4csmer1cW9
         +c5qszetQ3q/WpXgtyADcOGHYvY8PwCtSCcL2TWwbMcG0QIVOjowxLz29A2KUEWLmNpv
         v88A==
X-Gm-Message-State: ACrzQf1SfB2cD+GiR9OnnEQdye+1kryH5iS9elhVnASTGSu6gHeXIo4n
        wHYSYLVUHIYpPzb55fFx8UbevuphIYM9
X-Google-Smtp-Source: AMsMyM4vMdbBvcVERdZT996wzYmjJIJjDU42ZUE1ozAx0zdpevO9HT7XocqhKglK9N4aJrv7oNa/+81pTogk
X-Received: from ezekiel.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:108e])
 (user=shraash job=sendgmr) by 2002:a25:2d48:0:b0:6d1:16bf:1e07 with SMTP id
 s8-20020a252d48000000b006d116bf1e07mr547301ybe.423.1667837164848; Mon, 07 Nov
 2022 08:06:04 -0800 (PST)
Date:   Mon,  7 Nov 2022 21:35:56 +0530
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221107160556.2139463-1-shraash@google.com>
Subject: [PATCH] tracing: Fix warning on variable 'struct trace_array'
From:   Aashish Sharma <shraash@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Arun Easi <aeasi@marvell.com>, linux-kernel@vger.kernel.org,
        Aashish Sharma <shraash@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the declaration of 'struct trace_array' out of #ifdef
CONFIG_TRACING block, to fix the following warning when CONFIG_TRACING
is not set:

>> include/linux/trace.h:63:45: warning: 'struct trace_array' declared
inside parameter list will not be visible outside of this definition or
declaration

Fixes: 1a77dd1c2bb5 ("scsi: tracing: Fix compile error in trace_array calls when TRACING is disabled")
Cc: Arun Easi <aeasi@marvell.com>
Signed-off-by: Aashish Sharma <shraash@google.com>
---
 include/linux/trace.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/trace.h b/include/linux/trace.h
index b5e16e438448..80ffda871749 100644
--- a/include/linux/trace.h
+++ b/include/linux/trace.h
@@ -26,13 +26,13 @@ struct trace_export {
 	int flags;
 };
 
+struct trace_array;
+
 #ifdef CONFIG_TRACING
 
 int register_ftrace_export(struct trace_export *export);
 int unregister_ftrace_export(struct trace_export *export);
 
-struct trace_array;
-
 void trace_printk_init_buffers(void);
 __printf(3, 4)
 int trace_array_printk(struct trace_array *tr, unsigned long ip,
-- 
2.38.1.431.g37b22c650d-goog

