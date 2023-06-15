Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD792731BBF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 16:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345111AbjFOOtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 10:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240102AbjFOOts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:49:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2FE273C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 07:49:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A1CA51FDC5;
        Thu, 15 Jun 2023 14:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686840585; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=tWP3X6y1slpOFyHr1sWNQEgiKAMy/X1Ov85nf7gL3Es=;
        b=VovsHV+u6yMps6Jc8eTq/SihTWxDPyG6vyvN159MCR6KcjJMMU2AqSouxcoQ8GVtuzVGjV
        z6z5yhvpn/ET/0B8+8GkreLj4Y0O5B8KLeEVQ0Gs1VB34FMEH48FmPKUzme+DbS8NYtnqx
        m6pi8nYrLF3WZLrBh37kQekKT4WtqIA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 683FB13A32;
        Thu, 15 Jun 2023 14:49:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RdHiFgkli2RDAgAAMHmgww
        (envelope-from <nik.borisov@suse.com>); Thu, 15 Jun 2023 14:49:45 +0000
From:   Nikolay Borisov <nik.borisov@suse.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH] x86/mce: Use lockdep to assert preemption is off in mcheck_cpu_init
Date:   Thu, 15 Jun 2023 17:49:42 +0300
Message-Id: <20230615144942.1020961-1-nik.borisov@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of relying on a comment, use
lockdep_assert_preemption_disabled() as it issue a warning if preemption
is on.

mcheck_cpu_init is called from:

start_kernel
 check_bugs
   identify_boot_cpu
     identify_cpu
       mcheck_cpu_init

Which happens after lockdep_init() call in start_kernel().

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---
 arch/x86/kernel/cpu/mce/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 2eec60f50057..5d945a1690d5 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2126,12 +2126,12 @@ DEFINE_IDTENTRY_RAW(exc_machine_check)
 }
 #endif
 
-/*
- * Called for each booted CPU to set up machine checks.
- * Must be called with preempt off:
- */
+/* Called for each booted CPU to set up machine checks. */
 void mcheck_cpu_init(struct cpuinfo_x86 *c)
 {
+
+	lockdep_assert_preemption_disabled();
+
 	if (mca_cfg.disabled)
 		return;
 
-- 
2.34.1

