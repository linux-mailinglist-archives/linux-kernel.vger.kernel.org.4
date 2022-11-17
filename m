Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F9D62CF6B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 01:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234346AbiKQAUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 19:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234039AbiKQAUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 19:20:31 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94E247328
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 16:20:30 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id r81so259906iod.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 16:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=141E8a1mmNxybFT5cH+5JL9cg+6l3MIV4pAtA/MvRqQ=;
        b=JnoZCHbaJPOhGVTuemL+ScxeKtbkZnan1wtVEUSLnu05vIZ3/P/1HBtlP58/Davzef
         rLU7tVevOsHOzCHBr7SddlcOfHj0ItgmLsoSDJJ2xJPZr1vZzRf/3sIMPniZAjqpvaao
         0aK9QXxP9POHj6FKJrdAsYgleSxiexWzIXbDd56jQysagDswcPJ+o6JBRoxT4lI0R62+
         Gui+kbdXxNnMgEV2xnDCAihshpreiV/OzzVOSlfNcg931WjafaKrqigwrh4NDC4tX24I
         XxjS/8je6m1zneyaOjIlHbWm6tvy1SQsASLOvvIYzdKUBRVPEltNUZPY5ObFX0zW0r13
         74ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=141E8a1mmNxybFT5cH+5JL9cg+6l3MIV4pAtA/MvRqQ=;
        b=EdvjaoJOWJBLgW+pQ/Pa+wCBNu9wkzNN97RnkbzQp66da7k2fm5id+jgr2uPy2H38h
         bNnxGznt3iw+eQzOCXbHNL4XwhVvop3hKRng10kY61qFEDG2wy6rwXeLhLnBRj+Syh3V
         r6qVrl54cm9pcjbSnao0k9eXIoToxDDJYI8u4UPTLyGeyWXhYd/W3nRXgZABpkDolx6j
         2ql0fVVsG4XiKjglCwwP40wfLyBgQlbOzRXgWasFXjgaU+qYnY5U7EDAl+r4ymcQ1nOJ
         02fAZaPp9HCfx7p3bDlm4UFFTbtcwzv9UtaC+MRcqRm5z9Z9bMFaYgnX+xVD51GZu98J
         mSpg==
X-Gm-Message-State: ANoB5pl3wl1l5Lf87rZOd5M+qkwWHisdpZ3sbRxZncMv5NJg7LT/lKGF
        TVykmNPh6VcQ93myY3b1t5g=
X-Google-Smtp-Source: AA0mqf7dOce4tLH9MjSQmgy7Pk2eE2p+FjVEmHWNRqsKjb7rUJnJCDAOEJ0Pbl2Ll+Em1twZwdwLLQ==
X-Received: by 2002:a05:6602:736:b0:6bc:b2ee:a61e with SMTP id g22-20020a056602073600b006bcb2eea61emr319815iox.195.1668644430279;
        Wed, 16 Nov 2022 16:20:30 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id o194-20020a0222cb000000b0037556012c63sm6119777jao.132.2022.11.16.16.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 16:20:29 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 2/2] vmlinux.lds.h: add HEADERED_SECTION_* macros
Date:   Wed, 16 Nov 2022 17:20:22 -0700
Message-Id: <20221117002022.860237-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117002022.860237-1-jim.cromie@gmail.com>
References: <Y20+PqtF+dFAe7hX@kroah.com>
 <20221117002022.860237-1-jim.cromie@gmail.com>
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

These macros elaborate on BOUNDED_SECTION_(PRE|POST)_LABEL macros,
prepending an optional KEEP(.gnu.linkonce##_sec_) reservation, and a
linker-symbol to address it.

This allows a developer to define a header struct (which must fit with
the section's base struct-type), and could contain:

1- fields whose value is common to the entire set of data-records.
   This allows the header & data structs to specialize, complement
   each other, and shrink.

2- an uplink pointer to an organizing struct
   which refs other related/sub data-tables
   header record is addressable via the extern'd header linker-symbol

Once the linker-symbols created by the macro are ref'd extern in code,
that code can compute a record's index (ptr - start) in the "primary"
table, then use it to index into the related/sub tables.  Adding a
primary.map_* field foreach sub-table would then allow deduplication
and remapping of that sub-table.

This is aimed at dyndbg's struct _ddebug __dyndbg[] section, whose 3
columns: function, file, module are 50%, 90%, 100% redundant.  The
module column is fully recoverable after dynamic_debug_init() saves it
to each ddebug_table.module as the builtin __dyndbg[] table is parsed.

Given that those 3 columns use 24/56 of a prdbg record, a dyndbg=y
kernel with ~5k callsites could save substantially.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
---
 include/asm-generic/vmlinux.lds.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 85d5d5b203dc..a3b6aa30a525 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -214,6 +214,21 @@
 
 #define BOUNDED_SECTION(_sec)	 BOUNDED_SECTION_BY(_sec, _sec)
 
+#define HEADERED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_, _HDR_) \
+	_HDR_##_label_	= .;						\
+	KEEP(*(.gnu.linkonce.##_sec_))					\
+	BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_)
+
+#define HEADERED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_, _HDR_) \
+	_label_##_HDR_ = .;						\
+	KEEP(*(.gnu.linkonce.##_sec_))					\
+	BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_)
+
+#define HEADERED_SECTION_BY(_sec_, _label_)				\
+	HEADERED_SECTION_PRE_LABEL(_sec_, _label_, __start, __stop)
+
+#define HEADERED_SECTION(_sec)	 HEADERED_SECTION_BY(_sec, _sec)
+
 #ifdef CONFIG_TRACE_BRANCH_PROFILING
 #define LIKELY_PROFILE()						\
 	BOUNDED_SECTION_BY(_ftrace_annotated_branch, _annotated_branch_profile)
-- 
2.38.1

