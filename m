Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D6A708B36
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 00:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjERWD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 18:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjERWDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 18:03:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB7BE56;
        Thu, 18 May 2023 15:03:14 -0700 (PDT)
Date:   Thu, 18 May 2023 22:03:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684447392;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=6yOBB+dHnhueTNIEBj0qNl2Hq3gUzpZCTpbw2qcH+0Q=;
        b=bS+LYrgodFX5yVX2CVoFfgJG1y5rm0HiGidLdLjmTfXc/bokkWFgH+mEj2lPcc1Q7NhKkv
        EBIVauqrreXDeS4d7AG4gMWqCP7qnq1bt7Ws/cRlgJyz9nf6Rne2thtbn2xBsGTNbfAoWA
        JcwLGFwT54tU7NdxadVNnV9EJI1MTPRk2jzcijKEtFDYCEfryGftgQkX0D9JD57rOhgus1
        IYFIH1J3BovukBXl2L7vpA5/a+GsrbYzM3hKbYMJ5BGFzvvcKmL/yz281DrnkaMM3GOE6S
        sH1UNa4b6PJs+iJE90AMJ2cdS3OP2IxNZeaK20uT040oYneTPR2XdWAxx3wzXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684447392;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=6yOBB+dHnhueTNIEBj0qNl2Hq3gUzpZCTpbw2qcH+0Q=;
        b=s0i6bFdU7QlseHJShdb0OD4QwSIu5SwTmYhPAd5Y+38Y1JROfhHPmu6MBWQITSqgi8a3nu
        mcW4YOTShPGsoICg==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/platform: Avoid missing-prototype warnings for OLPC
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168444739153.404.3947589482547079284.tip-bot2@tip-bot2>
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

Commit-ID:     454a348714954f7b626c027a90c3967278e3f93b
Gitweb:        https://git.kernel.org/tip/454a348714954f7b626c027a90c3967278e3f93b
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Tue, 16 May 2023 21:35:49 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 18 May 2023 11:56:19 -07:00

x86/platform: Avoid missing-prototype warnings for OLPC

There are two functions in the olpc platform that have no prototype:

arch/x86/platform/olpc/olpc_dt.c:237:13: error: no previous prototype for 'olpc_dt_fixup' [-Werror=missing-prototypes]
arch/x86/platform/olpc/olpc-xo1-pm.c:73:26: error: no previous prototype for 'xo1_do_sleep' [-Werror=missing-prototypes]

The first one should just be marked 'static' as there are no other
callers, while the second one is called from assembler and is
just a false-positive warning that can be silenced by adding a
prototype.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Link: https://lore.kernel.org/all/20230516193549.544673-21-arnd%40kernel.org
---
 arch/x86/platform/olpc/olpc_dt.c | 2 +-
 include/linux/olpc-ec.h          | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/platform/olpc/olpc_dt.c b/arch/x86/platform/olpc/olpc_dt.c
index 75e3319..74ebd68 100644
--- a/arch/x86/platform/olpc/olpc_dt.c
+++ b/arch/x86/platform/olpc/olpc_dt.c
@@ -234,7 +234,7 @@ static int __init olpc_dt_compatible_match(phandle node, const char *compat)
 	return 0;
 }
 
-void __init olpc_dt_fixup(void)
+static void __init olpc_dt_fixup(void)
 {
 	phandle node;
 	u32 board_rev;
diff --git a/include/linux/olpc-ec.h b/include/linux/olpc-ec.h
index c460236..3c2891d 100644
--- a/include/linux/olpc-ec.h
+++ b/include/linux/olpc-ec.h
@@ -56,6 +56,8 @@ extern int olpc_ec_sci_query(u16 *sci_value);
 
 extern bool olpc_ec_wakeup_available(void);
 
+asmlinkage int xo1_do_sleep(u8 sleep_state);
+
 #else
 
 static inline int olpc_ec_cmd(u8 cmd, u8 *inbuf, size_t inlen, u8 *outbuf,
