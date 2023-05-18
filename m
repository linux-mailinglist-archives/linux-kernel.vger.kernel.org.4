Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0857F708B3D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 00:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbjERWDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 18:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbjERWDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 18:03:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763DCE57;
        Thu, 18 May 2023 15:03:17 -0700 (PDT)
Date:   Thu, 18 May 2023 22:03:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684447394;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=dcyvsg0Btvdn8+Kef5n19qjzFQcju1U15FF4mHUaMJg=;
        b=tIxqoHF9K7MQtw89Hqyyu4tCJ3Hw5p3HUzycuC+HWHx1gIucItsrCOL/Tpeg1/LdjM0V1X
        RmHtWSlDU1wX4kV7zBIgr1s4tW8kbuM/Bu8W6eWJA+cBAkEoh6CoAddzjpbuGKWLVrc5NW
        LcUFuHxjL8jJGdUeG5C62xK8K5BAVPmLFiSOvNQp1FLobRpnoQo1VG4z826t1211ekuwMX
        Bkc3WRyjAZ8EiftFGi9J/V2m1RcIh3KmGhFVLCZmePYPzvAbWgmmryBOnBnq3uUqQkt+St
        BlEZh4eTtTQML68G/on9u3eHZGuFou1e0VNXw+r0rPpcxfxfMyXL+15YQ05IpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684447394;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=dcyvsg0Btvdn8+Kef5n19qjzFQcju1U15FF4mHUaMJg=;
        b=ofPFEKgtrteb1nWZ64leJ0FvsEjJaE0nMCTPWByEAuP4K51MvnYU1gRTzNNR/i8Jc2bfr/
        Z44kQdh1CyiBXVAQ==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/entry: Add do_SYSENTER_32() prototype
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168444739377.404.12912509719388717312.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     f34f0d3c10eb4d3160fc6fe7a2482cb78d3b0c12
Gitweb:        https://git.kernel.org/tip/f34f0d3c10eb4d3160fc6fe7a2482cb78d3b0c12
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Tue, 16 May 2023 21:35:40 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 18 May 2023 11:56:18 -07:00

x86/entry: Add do_SYSENTER_32() prototype

The 32-bit system call entry points can be called on both 32-bit
and 64-bit kernels, but on the former the declarations are hidden:

arch/x86/entry/common.c:238:24: error: no previous prototype for 'do_SYSENTER_32' [-Werror=missing-prototypes]

Move them all out of the #ifdef block to avoid the warnings.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Link: https://lore.kernel.org/all/20230516193549.544673-12-arnd%40kernel.org
---
 arch/x86/include/asm/syscall.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
index 5b85987..4fb36fb 100644
--- a/arch/x86/include/asm/syscall.h
+++ b/arch/x86/include/asm/syscall.h
@@ -127,9 +127,11 @@ static inline int syscall_get_arch(struct task_struct *task)
 }
 
 void do_syscall_64(struct pt_regs *regs, int nr);
-void do_int80_syscall_32(struct pt_regs *regs);
-long do_fast_syscall_32(struct pt_regs *regs);
 
 #endif	/* CONFIG_X86_32 */
 
+void do_int80_syscall_32(struct pt_regs *regs);
+long do_fast_syscall_32(struct pt_regs *regs);
+long do_SYSENTER_32(struct pt_regs *regs);
+
 #endif	/* _ASM_X86_SYSCALL_H */
