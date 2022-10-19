Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA25B603935
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 07:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiJSFYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 01:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJSFYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 01:24:14 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A36A6704D
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 22:24:14 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id u15so18079281oie.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 22:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M/s04qlg1QWSCwEdMmimtva0jNuFE11gbWe+BdsHkxc=;
        b=f8BQytgKwPpGb2OXnD4IX7LNSU+yCghwsd8w2b+gz++Apw5TfpJsvVV5uW+7lLOiSQ
         liV/UOZhKoZRZ01OCQZcLzJ2Pg/N1DcT/dQOSe2zHImtqCYmRdy6xREuu08r2+0tByZ6
         NcNaWTNm+KlV4dMZQQCMy+/mbD/gEFJgyhltDeEijR1fjYwbAYNliQ+BnoU8zs4d0i7Z
         CLmAUf9g9Xh0rF2aetNaVENWc3/bqZx08TzTzFG7C7V8DZy7CcaHXXstyCbtNzRzHbld
         RwsHPp7sQYNer5uH0ya6MDzDcE1rf2NU7Pf6HFKrd/6ZVtbCWGKDJCkyCuXrT7c+7Nis
         EPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M/s04qlg1QWSCwEdMmimtva0jNuFE11gbWe+BdsHkxc=;
        b=2yRjrYfvEBVde25w0lThYApYyhpGso6OoE+7KWLRyKCa+yk0KbG8UXOVpfm1Kwys3h
         dfZjizzn3hSjHbLZ4cBC3zskKAnX0a6J2pzTGnulaHlaGadcjwBT1lBKgstgA1b6SQ5B
         Jk/KVNcyZj5glFmAovBh7R+Bo9l5TxcBnsv23YG1521sBtsJPTUBw7WfDMI6NJ1w6W2I
         ZFSnMil5Pn+sK8fBR1ZTT4yyHhEqasA/+BL4sE5Sl2t4QQVBT/0ZqfXd29iOf5iMEueo
         ksY/WqnZYtVEHyi1vdO1jsN8vV4uBP86Vm9+e3SWicRK2bNsMBnvso71qKLZ+U3VEgbK
         aPGw==
X-Gm-Message-State: ACrzQf3rn+P/ZZFupe2ZVucAAg+MuuSZgsZGrhNsOhTqsxr5e/+U1/Un
        lJFOsBivjfEhbLEwbJNAI0tIC5Gv44I=
X-Google-Smtp-Source: AMsMyM4B4qJ0x3yt3jX+mFE/H+yecHXk+pc+eXF+KITOlzep48yjl2SUU6MOzWdDL6vQ8et0iPGH8g==
X-Received: by 2002:a05:6808:1b22:b0:355:2980:2ac8 with SMTP id bx34-20020a0568081b2200b0035529802ac8mr3158005oib.1.1666157053279;
        Tue, 18 Oct 2022 22:24:13 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id m67-20020aca3f46000000b00350743ac8eesm6380532oia.41.2022.10.18.22.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 22:24:12 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dmitry Vyukov <dvyukov@google.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Sander Vanheule <sander@svanheule.net>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Eric Biggers <ebiggers@google.com>
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH] cpumask: limit visibility of FORCE_NR_CPUS
Date:   Tue, 18 Oct 2022 22:22:00 -0700
Message-Id: <20221019052200.1604488-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
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

In current form, FORCE_NR_CPUS is visible to all users building their
kernels, even not experts. It is also set in allmodconfig or allyesconfig,
which is not a correct behavior.

Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/Kconfig | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index 9bbf8a4b2108..1ada12f5dda6 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -528,14 +528,31 @@ config CPUMASK_OFFSTACK
 	  them on the stack.  This is a bit more expensive, but avoids
 	  stack overflow.
 
+choice
+	prompt "Number of CPUs detection method"
+	default UNFORCE_NR_CPUS
+	depends on SMP && EXPERT
+	help
+	  Select between boot-time and compile-time detection of number
+	  of CPUs. If it's possible to provide exact number of CPUs at
+	  compile-time, kernel code may be optimized better.
+	  For general-purpose kernel, choose "boot time" option.
+
+config UNFORCE_NR_CPUS
+	bool "Set number of CPUs at boot time"
+	help
+	  Choose it if you build general-purpose kernel and want to rely
+	  on kernel to detect actual number of CPUs.
+
 config FORCE_NR_CPUS
-       bool "NR_CPUS is set to an actual number of CPUs"
-       depends on SMP
-       help
-         Say Yes if you have NR_CPUS set to an actual number of possible
-         CPUs in your system, not to a default value. This forces the core
-         code to rely on compile-time value and optimize kernel routines
-         better.
+	bool "Set number of CPUs at compile time"
+	help
+	  Choose it if NR_CPUS corresponds to an actual number of
+	  possible CPUs in your system. This forces the core code
+	  to rely on compile-time value and optimize kernel routines
+	  better.
+
+endchoice
 
 config CPU_RMAP
 	bool
-- 
2.34.1

