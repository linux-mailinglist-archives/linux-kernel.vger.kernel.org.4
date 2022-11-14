Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE76627CD9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236833AbiKNLsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236842AbiKNLsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:48:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8415264BF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:45:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 72A66B80E78
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 11:45:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9976C433D7;
        Mon, 14 Nov 2022 11:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668426337;
        bh=VYQURovUo97zO8sJmHkHAsr8KxvRG48y3FQbb9I2wLo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z56jXBWIsBXBUMabvHqQKKRnY5i9Yvn3pWB+MImH0iB9rNmtARnU/nYhyOp87J2KY
         ml3vFdOHGOQgMiMSvx5Mk9jDreX5NOGSklPB09RpuPYi+6TENrcT7e60VFQGSmIUnR
         3LKqf5Jt4rbq42rrcKS6/ItDLaLySbMldOWP6LlnQs755cD5K9NsUQaLQN9y1Hq8Qa
         ntYAvZPVESwrDLyh1XRFO6i3Cd2GeaSSmag4Fhiys6xEuadykc9BW7b3Vt3njgjZbX
         5xCxKCBLPRNrwm7FWVhhsk+4CZhs9ltA6UF4Nnmd7n16b/JKDFvmZ10Qakl4qVQnv5
         8u7O4bFsjNrJw==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Martin Liska <mliska@suse.cz>, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 41/46] x86/lib, lto: Mark 32bit mem{cpy,move,set} as __used
Date:   Mon, 14 Nov 2022 12:43:39 +0100
Message-Id: <20221114114344.18650-42-jirislaby@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114114344.18650-1-jirislaby@kernel.org>
References: <20221114114344.18650-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

gcc doesn't always recognize that memcpy/set/move called through
__builtins are referenced because the reference happens too late in the
RTL expansion phase. This can make LTO to drop them, leading to
undefined symbols. Mark them as __used to avoid that.

This is only needed on 32bit, on 64bit they're assembler anyways.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Martin Liska <mliska@suse.cz>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 arch/x86/lib/memcpy_32.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/lib/memcpy_32.c b/arch/x86/lib/memcpy_32.c
index ef3af7ff2c8a..53fa1cac79d1 100644
--- a/arch/x86/lib/memcpy_32.c
+++ b/arch/x86/lib/memcpy_32.c
@@ -6,19 +6,19 @@
 #undef memset
 #undef memmove
 
-__visible void *memcpy(void *to, const void *from, size_t n)
+__used __visible void *memcpy(void *to, const void *from, size_t n)
 {
 	return __memcpy(to, from, n);
 }
 EXPORT_SYMBOL(memcpy);
 
-__visible void *memset(void *s, int c, size_t count)
+__used __visible void *memset(void *s, int c, size_t count)
 {
 	return __memset(s, c, count);
 }
 EXPORT_SYMBOL(memset);
 
-__visible void *memmove(void *dest, const void *src, size_t n)
+__used __visible void *memmove(void *dest, const void *src, size_t n)
 {
 	int d0,d1,d2,d3,d4,d5;
 	char *ret = dest;
-- 
2.38.1

