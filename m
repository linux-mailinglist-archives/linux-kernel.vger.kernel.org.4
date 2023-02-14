Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCC06959DA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 08:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbjBNHIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 02:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjBNHHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 02:07:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DDD1E1E9;
        Mon, 13 Feb 2023 23:07:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2D13B81C0F;
        Tue, 14 Feb 2023 07:07:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB65C433AA;
        Tue, 14 Feb 2023 07:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676358430;
        bh=u65MWf1uVeHIl30gAKDo2aE5QNS7tuwQzlQSMBdo3oU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZJAfKz8V7gxrEQeEM2FOq72HpVAthk3QdF2F+SrcqlVX34YG0N79sAPGnZv8WeBzA
         76TFko1eEZ5v2I+9grCE6Qbuy8g/An1sSN/pqh8sGbKulDZ+OdvV5I32K2EsB2KGN+
         YvZIr3GI4PYP4je8w6RaZtwlKf8cQUWS3DTXfmX8KZN6JjORkYoCbbxs8pfkrsDge3
         ENl3ldF/KS+naTsLAh9tTgnTmn9uA0x4CcHu1zxnhNokt9ukTeZBmxxhckIIeLWoyX
         Ral+PK9l+ZQ7aeh6LxXkCJ1lwUF0E+dd5+Z2QiKEDtGqLXLo4wscBg7uQfnPK0ek17
         qFVCGdkl2WYRA==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     jgross@suse.com, richard.henderson@linaro.org,
        ink@jurassic.park.msu.ru, mattst88@gmail.com,
        linux-alpha@vger.kernel.org, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will@kernel.org, guoren@kernel.org, linux-csky@vger.kernel.org,
        linux-ia64@vger.kernel.org, chenhuacai@kernel.org,
        kernel@xen0n.name, loongarch@lists.linux.dev, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, tsbogend@alpha.franken.de,
        linux-mips@vger.kernel.org, jiaxun.yang@flygoat.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        linuxppc-dev@lists.ozlabs.org, ysato@users.sourceforge.jp,
        dalias@libc.org, linux-sh@vger.kernel.org, davem@davemloft.net,
        sparclinux@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com,
        linux-xtensa@linux-xtensa.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        paulmck@kernel.org
Subject: [PATCH v2 12/24] powerpc/cpu: Mark start_secondary_resume() __noreturn
Date:   Mon, 13 Feb 2023 23:05:46 -0800
Message-Id: <b6b2141f832d8cd8ade65f190d04b011cda5f9bb.1676358308.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1676358308.git.jpoimboe@kernel.org>
References: <cover.1676358308.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

start_secondary_resume() doesn't return.  Annotate it as such.  By
extension this also makes arch_cpu_idle_dead() noreturn.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/powerpc/include/asm/smp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index f63505d74932..cfd42ca8765c 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -66,7 +66,7 @@ void start_secondary(void *unused);
 extern int smp_send_nmi_ipi(int cpu, void (*fn)(struct pt_regs *), u64 delay_us);
 extern int smp_send_safe_nmi_ipi(int cpu, void (*fn)(struct pt_regs *), u64 delay_us);
 extern void smp_send_debugger_break(void);
-extern void start_secondary_resume(void);
+extern void __noreturn start_secondary_resume(void);
 extern void smp_generic_give_timebase(void);
 extern void smp_generic_take_timebase(void);
 
-- 
2.39.1

