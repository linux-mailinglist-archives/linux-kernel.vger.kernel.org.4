Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5D2748251
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 12:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbjGEKka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 06:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbjGEKk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 06:40:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32921727;
        Wed,  5 Jul 2023 03:40:23 -0700 (PDT)
Date:   Wed, 05 Jul 2023 10:40:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1688553621;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ovbrxVE68OGB4mGLejvxcJ2FvxKGgQrffrokf0loOvg=;
        b=gPrz+4dqnyKKr2R0NPP3gMhHrZru3Vds5QvAa4JaSZkEA1dkz75NB5phvOW0qnEO6v/uLq
        5ncinBiN6nb60GEdsip6PKomQNzSs1VE/GBXtYqonRkN3WvcbDMx2pODTAHCuj616rqkv3
        ovffTXqFzBpV1d89UiZ9AT/6KN/B2IS9d59PgHWFZzb5EvN89bPkGRp3FqAk/w8lJj/xL9
        zFZIvEHp10+SIu8WdSTHM5XYlUewceg1/WZjNvmlls/NuiMPZztMh4/OsdL+c/aLovnomd
        E0BHkO8ITvs+4nxVvXuz9l9k/shgMfySPTDEteOiGLYUs3iwvSzQe/lvL2xlxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1688553621;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ovbrxVE68OGB4mGLejvxcJ2FvxKGgQrffrokf0loOvg=;
        b=0z1JVdtQRAzeEex7Dc1N0LbN1eEMgj74EaiG0BOSt3aHS1rc2A9rwZyEsVwg2IXdFpKjj9
        es44xo8UWweqprDA==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/xen: Fix secondary processors' FPU initialization
Cc:     Juergen Gross <jgross@suse.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230703130032.22916-1-jgross@suse.com>
References: <20230703130032.22916-1-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <168855362058.404.7316702697493690909.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     fe3e0a13e597c1c8617814bf9b42ab732db5c26e
Gitweb:        https://git.kernel.org/tip/fe3e0a13e597c1c8617814bf9b42ab732db5c26e
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Mon, 03 Jul 2023 15:00:32 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 05 Jul 2023 11:44:16 +02:00

x86/xen: Fix secondary processors' FPU initialization

Moving the call of fpu__init_cpu() from cpu_init() to start_secondary()
broke Xen PV guests, as those don't call start_secondary() for APs.

Call fpu__init_cpu() in Xen's cpu_bringup(), which is the Xen PV
replacement of start_secondary().

Fixes: b81fac906a8f ("x86/fpu: Move FPU initialization into arch_cpu_finalize_init()")
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230703130032.22916-1-jgross@suse.com
---
 arch/x86/xen/smp_pv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index a9cf8c8..0b6efc4 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -63,6 +63,7 @@ static void cpu_bringup(void)
 
 	cr4_init();
 	cpu_init();
+	fpu__init_cpu();
 	touch_softlockup_watchdog();
 
 	/* PVH runs in ring 0 and allows us to do native syscalls. Yay! */
