Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8701745CBA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 15:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjGCNAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 09:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjGCNAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 09:00:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82022E67
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 06:00:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E3FD2218F3;
        Mon,  3 Jul 2023 13:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1688389234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=g/qfo8Cb33qUzg9p/sYx93BIkx/lh9MH46SOSdnmyf8=;
        b=E0ValWnb8323NYs3nZ1reUyn9xcW6UnT/WjrnwfuddpLUbUcW8umrJK2eBg3GMgbEVZlc5
        e7Op8WL+1NzVEDBRQL2foLY3SM64CFvRMXs5yP/7PJD1wYpI7+kCyTD72S180Jsu1OyMFY
        Lwnv8tdJ/g8zVtBTGNEHkHjIPCjEI1g=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9A656138FC;
        Mon,  3 Jul 2023 13:00:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2xVZJHLGomSYCgAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 03 Jul 2023 13:00:34 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org
Subject: [PATCH] x86/xen: fix secondary processor fpu initialization
Date:   Mon,  3 Jul 2023 15:00:32 +0200
Message-Id: <20230703130032.22916-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
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

Moving the call of fpu__init_cpu() from cpu_init() to start_secondary()
broke Xen PV guests, as those don't call start_secondary() for APs.

Fix that by adding the call of fpu__init_cpu() to cpu_bringup(), which
is the Xen PV replacement of start_secondary().

Fixes: b81fac906a8f ("x86/fpu: Move FPU initialization into arch_cpu_finalize_init()")
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/xen/smp_pv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index d5ae5de2daa2..cef78b8c89f4 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -63,6 +63,7 @@ static void cpu_bringup(void)
 	cr4_init();
 	cpuhp_ap_sync_alive();
 	cpu_init();
+	fpu__init_cpu();
 	touch_softlockup_watchdog();
 
 	/* PVH runs in ring 0 and allows us to do native syscalls. Yay! */
-- 
2.35.3

