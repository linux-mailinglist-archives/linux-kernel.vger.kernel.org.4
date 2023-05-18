Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A631B708B3A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 00:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjERWDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 18:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbjERWDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 18:03:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541F0E50;
        Thu, 18 May 2023 15:03:17 -0700 (PDT)
Date:   Thu, 18 May 2023 22:03:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684447393;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=1k/3w307U/MJ10TV+ypCGRT5xWTJAV5Vkvrl79Z2oUQ=;
        b=MtcTby22J3V74i1n9YyXZ6Hm5KPcKw6EUfMbwvDJXxFwhv/qTubBC/NFIijx8Ia5c610UM
        5XYo3WDg6eeb1CiHhIFAxXx1prMPCnj/ddprvFLvX51EMZKCxqJ6cPzt9JuMtbZG8LXPQF
        twGvFcWe/sts1MwsqyKhvFwTnL/IkCVbCHgRZ+gObP/mcEwA6ON94k2vROWXAso+sZqZmB
        JWDNjTIZrF7M9lEmjXuevdcEyMBp8COwAK3009ITIjfwmpNlQywgAcBOd2sr/Ict1pzZVK
        7P/H2CcxaHRsdfowzhnfAxwMq+JuT/hV0rW0WSm1J9+CEtNDO3VHu/LPP/wgmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684447393;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=1k/3w307U/MJ10TV+ypCGRT5xWTJAV5Vkvrl79Z2oUQ=;
        b=cnsg23dVenSBt3Ne9k8ig10LUf7+60u+mDtxn2It6w4212c6uMRVuxlhmkd2arIgqNYjo0
        1o1KAUOhSU7j1KBQ==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/hibernate: Declare global functions in suspend.h
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168444739349.404.11523782162074179153.tip-bot2@tip-bot2>
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

Commit-ID:     8a3e82d38674066f4cbed3588b78b0d9b8b15ed7
Gitweb:        https://git.kernel.org/tip/8a3e82d38674066f4cbed3588b78b0d9b8b15ed7
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Tue, 16 May 2023 21:35:42 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 18 May 2023 11:56:18 -07:00

x86/hibernate: Declare global functions in suspend.h

Three functions that are defined in x86 specific code to override
generic __weak implementations cause a warning because of a missing
prototype:

arch/x86/power/cpu.c:298:5: error: no previous prototype for 'hibernate_resume_nonboot_cpu_disable' [-Werror=missing-prototypes]
arch/x86/power/hibernate.c:129:5: error: no previous prototype for 'arch_hibernation_header_restore' [-Werror=missing-prototypes]
arch/x86/power/hibernate.c:91:5: error: no previous prototype for 'arch_hibernation_header_save' [-Werror=missing-prototypes]

Move the declarations into a global header so it can be included
by any file defining one of these.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Link: https://lore.kernel.org/all/20230516193549.544673-14-arnd%40kernel.org
---
 include/linux/suspend.h | 4 ++++
 kernel/power/power.h    | 5 -----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index d0d4598..f16653f 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -452,6 +452,10 @@ extern struct pbe *restore_pblist;
 int pfn_is_nosave(unsigned long pfn);
 
 int hibernate_quiet_exec(int (*func)(void *data), void *data);
+int hibernate_resume_nonboot_cpu_disable(void);
+int arch_hibernation_header_save(void *addr, unsigned int max_size);
+int arch_hibernation_header_restore(void *addr);
+
 #else /* CONFIG_HIBERNATION */
 static inline void register_nosave_region(unsigned long b, unsigned long e) {}
 static inline int swsusp_page_is_forbidden(struct page *p) { return 0; }
diff --git a/kernel/power/power.h b/kernel/power/power.h
index b83c8d5..a6a16fa 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -26,9 +26,6 @@ extern void __init hibernate_image_size_init(void);
 /* Maximum size of architecture specific data in a hibernation header */
 #define MAX_ARCH_HEADER_SIZE	(sizeof(struct new_utsname) + 4)
 
-extern int arch_hibernation_header_save(void *addr, unsigned int max_size);
-extern int arch_hibernation_header_restore(void *addr);
-
 static inline int init_header_complete(struct swsusp_info *info)
 {
 	return arch_hibernation_header_save(info, MAX_ARCH_HEADER_SIZE);
@@ -41,8 +38,6 @@ static inline const char *check_image_kernel(struct swsusp_info *info)
 }
 #endif /* CONFIG_ARCH_HIBERNATION_HEADER */
 
-extern int hibernate_resume_nonboot_cpu_disable(void);
-
 /*
  * Keep some memory free so that I/O operations can succeed without paging
  * [Might this be more than 4 MB?]
