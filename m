Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8276A4741
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 17:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjB0QsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 11:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjB0Qr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 11:47:59 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141E84237;
        Mon, 27 Feb 2023 08:47:58 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id i34so28389717eda.7;
        Mon, 27 Feb 2023 08:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nTsRWEb5cq8rAdnmR/xyX9EITNYSxEvlyTl6tK19OIY=;
        b=P7dleS0pbKg6essRcudpQjteOOheEDzT7prAq73GtwW+kObPgmXNOLip7e2HFnIPz9
         wEzvD+YUob3Vu38Q1SSxDbt8xhUu9ZJU5kw0o8x+yLjFfRWWVzu9jYCRUl4hZg56TlLT
         CcR/d+B+CgzvGOT44of59fI7i83BJ58JoACcVIHw5UY7lOrYh+pvVYExu6E47iaraCry
         7kSIR+D3DXeIXA19wI9vk7BWut26/CNirSr9RvnKow8tgfbFPYSyC7as2BYjK0U9jSYJ
         90bKXjmJ/59eJKeLYH/yy1rJuPjVJNKOzuFvAYvDDY1FOAz4X5s7+pmCR4Ei1bK1xt6H
         tXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nTsRWEb5cq8rAdnmR/xyX9EITNYSxEvlyTl6tK19OIY=;
        b=76o/kvFrww9OYDPrzFh889/1+XoyktFbQryMIKLt2Djorxxp+9JwzLDG8km9nrGNUh
         /JITXa9PKPv/tmGwo0DyLW1v4fl/8h19EdlwIIwkciK6P+p7PFjefnw6irbi7jhKJvWY
         UnDghihcFWPmJi7CkR3xqqsLpCh4lic4ltZtTSlp51xvxdejEYeaZVUYDojD2FiQG+u+
         F6fIzQLkF/TILBrIQVjk4A2hopP1speHx+KB366GLPTYBMb63ajM5UX0Dp/ElO6KwXfO
         xdT8ff+tBKe3puLNecUu298UGQdtiR8o9HYqP6KXBd30VgoZ3GDAdPObSqAWYAFvK4rU
         zE1A==
X-Gm-Message-State: AO0yUKUlbHVabBxvWAF/iL+tVOdgw4fgQFC5SidX053UxwhW2bFRT8yR
        psqKPYyt7K/Cokm10OZeYw8=
X-Google-Smtp-Source: AK7set+n/IbGjtkDU329YbHOuG2DxhjFqfvEq4lBqQXlRZw28VqPeC+46tOan/x+KkOxs38in56NtQ==
X-Received: by 2002:a17:906:241b:b0:8b1:3193:4874 with SMTP id z27-20020a170906241b00b008b131934874mr35349838eja.46.1677516476407;
        Mon, 27 Feb 2023 08:47:56 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id bk5-20020a170906b0c500b008f0143dfa65sm3402220ejb.27.2023.02.27.08.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 08:47:55 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/ACPI/boot: Improve __acpi_acquire_global_lock
Date:   Mon, 27 Feb 2023 17:47:45 +0100
Message-Id: <20230227164745.339269-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.39.2
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

Improve __acpi_acquire_global_lock by using a temporary variable.
This enables compiler to perform if-conversion and improves generated
code from:

 ...
 72a:	d1 ea                	shr    %edx
 72c:	83 e1 fc             	and    $0xfffffffc,%ecx
 72f:	83 e2 01             	and    $0x1,%edx
 732:	09 ca                	or     %ecx,%edx
 734:	83 c2 02             	add    $0x2,%edx
 737:	f0 0f b1 17          	lock cmpxchg %edx,(%rdi)
 73b:	75 e9                	jne    726 <__acpi_acquire_global_lock+0x6>
 73d:	83 e2 03             	and    $0x3,%edx
 740:	31 c0                	xor    %eax,%eax
 742:	83 fa 03             	cmp    $0x3,%edx
 745:	0f 95 c0             	setne  %al
 748:	f7 d8                	neg    %eax

to:

 ...
 72a:	d1 e9                	shr    %ecx
 72c:	83 e2 fc             	and    $0xfffffffc,%edx
 72f:	83 e1 01             	and    $0x1,%ecx
 732:	09 ca                	or     %ecx,%edx
 734:	83 c2 02             	add    $0x2,%edx
 737:	f0 0f b1 17          	lock cmpxchg %edx,(%rdi)
 73b:	75 e9                	jne    726 <__acpi_acquire_global_lock+0x6>
 73d:	8d 41 ff             	lea    -0x1(%rcx),%eax

BTW: the compiler could generate:

	lea 0x2(%rcx,%rdx,1),%edx

instead of:

	or     %ecx,%edx
	add    $0x2,%edx

but unwated conversion from add to or when bits are known to be zero
prevents this improvement. This is GCC PR108477.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/kernel/acpi/boot.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 1c38174b5f01..577403c69983 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1853,13 +1853,14 @@ early_param("acpi_sci", setup_acpi_sci);
 
 int __acpi_acquire_global_lock(unsigned int *lock)
 {
-	unsigned int old, new;
+	unsigned int old, new, val;
 
 	old = READ_ONCE(*lock);
 	do {
-		new = (((old & ~0x3) + 2) + ((old >> 1) & 0x1));
+		val = (old >> 1) & 0x1;
+		new = (old & ~0x3) + 2 + val;
 	} while (!try_cmpxchg(lock, &old, new));
-	return ((new & 0x3) < 3) ? -1 : 0;
+	return val ? 0 : -1;
 }
 
 int __acpi_release_global_lock(unsigned int *lock)
-- 
2.39.2

