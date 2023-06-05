Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58835721EEB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjFEHEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjFEHEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:04:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1055E171C;
        Mon,  5 Jun 2023 00:03:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C420216F8;
        Mon,  5 Jun 2023 00:03:28 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7FABE3F793;
        Mon,  5 Jun 2023 00:02:41 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     akiyks@gmail.com, boqun.feng@gmail.com, corbet@lwn.net,
        keescook@chromium.org, linux@armlinux.org.uk,
        linux-doc@vger.kernel.org, mark.rutland@arm.com,
        mchehab@kernel.org, paulmck@kernel.org, peterz@infradead.org,
        rdunlap@infradead.org, sstabellini@kernel.org, will@kernel.org
Subject: [PATCH v2 26/27] locking/atomic: docs: Add atomic operations to the driver basic API documentation
Date:   Mon,  5 Jun 2023 08:01:23 +0100
Message-Id: <20230605070124.3741859-27-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230605070124.3741859-1-mark.rutland@arm.com>
References: <20230605070124.3741859-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Add the generated atomic headers to driver-api/basics.rst in order to
provide documentation for the Linux kernel's atomic operations.

At the same time, dtop the x86 atomic header, which provides kerneldoc
comments for some arch_atomic*_*() operations. The arch_atomic*_*()
operations are now purely an implenentation detail of the
raw_atomic*_*() ops, and outside of implementing the atomics, code
should use the raw_atomic*_*() forms.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
[Mark: add atomic-{instrumented,long}.h, update commit message]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: <linux-doc@vger.kernel.org>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
---
 Documentation/driver-api/basics.rst | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/driver-api/basics.rst b/Documentation/driver-api/basics.rst
index 4b4d8e28d3be4..7671b531ba1a8 100644
--- a/Documentation/driver-api/basics.rst
+++ b/Documentation/driver-api/basics.rst
@@ -84,7 +84,13 @@ Reference counting
 Atomics
 -------
 
-.. kernel-doc:: arch/x86/include/asm/atomic.h
+.. kernel-doc:: include/linux/atomic/atomic-instrumented.h
+   :internal:
+
+.. kernel-doc:: include/linux/atomic/atomic-arch-fallback.h
+   :internal:
+
+.. kernel-doc:: include/linux/atomic/atomic-long.h
    :internal:
 
 Kernel objects manipulation
-- 
2.30.2

