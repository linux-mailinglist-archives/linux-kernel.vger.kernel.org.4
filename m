Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73FD960539C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 01:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbiJSXCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 19:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbiJSXCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 19:02:11 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A13A1D4407
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 16:02:01 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id d18-20020a05683025d200b00661c6f1b6a4so10393449otu.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 16:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b7+Y9Us5vY6Sok7RqhqU+hdfsfZgw3dMiSDjIRAqLFg=;
        b=mRY5SF7eMnsrZtZ6gxEpdWht+U7yEwBB4BqUxXK8hMcKjuo7YSkgLMeztyILk82kf8
         eU4Dw7LTmtMjJcNiNVqlozYj5JsN4SRVJnYyg7xdBqU7H3niBYU76TXOsv/z3N1+s0lo
         kEt/2CznYsL6LciJGsdf66JIe6NE/XK16lP9ew/pMXmDRGad5P2ddckVl7R60jQ0Zu31
         6ZX2d6XIrHNMoF67jLlktmo8GVL4LmB3E7jMkUfXFPFKBPg5KXzzlo5OaXt1D1SVEY1F
         qNCASacT4nWfWZjf+xndhXfUeAh09yBqQjCSz6F9vwcs1xFr5L0c7ZWKjjh0ZHQ+sKkQ
         JaAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b7+Y9Us5vY6Sok7RqhqU+hdfsfZgw3dMiSDjIRAqLFg=;
        b=7GrA5oUCA0sf6JegTFKvL7A8CoXLUl/YpFilNYDiceJar/wapw0i2V5m04S0OSag7z
         xVX2dqHNBQ6C4tKyWsD0NDIgjCmF9H8sRvmkORl/r8B/LW0YWCEUGdRMfB3H9xWOBWcC
         O9nXCekX3FdK+U0dCeCOrnVvkA1/Oiyh9goPeae3MQ7ktdTdZTXTuKzKWW8MSFgM8NKn
         U85bur7vE0twfxSDh5S6nSiG6oN4/+bLCcdDWX3mBDpxTEJ8KI9n8qbiVehucb3zUlEa
         0eyl2GHdi0bL6OFt3ZjOivB/2BNyBJqAVm/7J4CZUv0YCeTiwdic+UqhHFrZRD1oxLUy
         TOAw==
X-Gm-Message-State: ACrzQf3RmFLH4l9Yr16vjAMIbX26ibZ277KCZV7TWjYx1CdCjlVcPKGc
        AhN6U/TpX0SQScnouW7CdH8Cv7V1vXk=
X-Google-Smtp-Source: AMsMyM55xDxsHj27MXDEnM93Nazr5ZGkpHgWhdg6kQ5PYQQk39rtYNelh2E9OtRrYLlWr46OMemrhQ==
X-Received: by 2002:a05:6830:1dba:b0:662:968:75c0 with SMTP id z26-20020a0568301dba00b00662096875c0mr1803632oti.158.1666220513698;
        Wed, 19 Oct 2022 16:01:53 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id n20-20020a9d4d14000000b006618e23df48sm7529008otf.39.2022.10.19.16.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 16:01:53 -0700 (PDT)
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
Subject: [PATCH v2] cpumask: limit visibility of FORCE_NR_CPUS
Date:   Wed, 19 Oct 2022 15:59:39 -0700
Message-Id: <20221019225939.1646349-1-yury.norov@gmail.com>
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

The 'choice' and unused config UNFORCE_NR_CPUS are used to ensure that
auto-generated configs that try to enable as much options as possible,
like allmodconfig, don't enable FORCE_NR_CPUS.

Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
v2: extend commit message with an explanation for what we need 'choice'.

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

