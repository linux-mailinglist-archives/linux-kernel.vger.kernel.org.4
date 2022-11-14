Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522DA627CA5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236661AbiKNLpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236660AbiKNLoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:44:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDBA20BC5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:44:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 905B0B80E6C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 11:44:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 988CDC433C1;
        Mon, 14 Nov 2022 11:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668426263;
        bh=owzR+yZF1fBmG413bQU+FKodqiSnrZRm615nsyA2Qd8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iMdFCUcwcAU0BxJEunp20sguBCmcihaBHzTN2R0laCZjfHpV3wYTLqN8Vo2RZE7iE
         haT1PNIPMmf++W29BCMx6YNaaDQS8iK2T4P5eJJzru7mrUTlNkwpLyOvP/sVh3ZW7g
         jVUQmQuZqHtZAIEj4JTTWT7Fml+LW8NRfvsbzTjt4+Ejv/GYDgIi4+nyNlni1tgPdH
         qhdKHJQ1coiRZPhNytWT8z/3lra+iaMThcXGG5fwaGe7WwfIYSj0GxQSZungNuRLsC
         8kdFYo1ocB+NsfrwYgJw3vwGvgr9pTj/vGO7sjkMOOniPt6Bd8ZEa++WhKOr3ySQUf
         Q0rqE88PdqL1w==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andi Kleen <ak@linux.intel.com>, Juergen Gross <jgross@suse.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Martin Liska <mliska@suse.cz>, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 12/46] x86/paravirt, lto: Mark native_steal_clock() as __visible_on_lto
Date:   Mon, 14 Nov 2022 12:43:10 +0100
Message-Id: <20221114114344.18650-13-jirislaby@kernel.org>
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

Symbols referenced from assembler (either directly or e.f. from
DEFINE_STATIC_KEY()) need to be global and visible in gcc LTO because
they could end up in a different object file than the assembler. This
can lead to linker errors without this patch.

So mark native_steal_clock() as __visible_on_lto.

[js] use __visible_on_lto

Cc: Juergen Gross <jgross@suse.com>
Cc: "Srivatsa S. Bhat
Cc: Alexey Makhalov <amakhalov@vmware.com>
Cc: VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
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
 arch/x86/kernel/paravirt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 7ca2d46c08cc..27a537cd4b0e 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -120,7 +120,7 @@ unsigned int paravirt_patch(u8 type, void *insn_buff, unsigned long addr,
 struct static_key paravirt_steal_enabled;
 struct static_key paravirt_steal_rq_enabled;
 
-static u64 native_steal_clock(int cpu)
+__visible_on_lto u64 native_steal_clock(int cpu)
 {
 	return 0;
 }
-- 
2.38.1

