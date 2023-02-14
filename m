Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89EDC6959FF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 08:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjBNHJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 02:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbjBNHHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 02:07:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C680D1E2A5;
        Mon, 13 Feb 2023 23:07:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3362E61470;
        Tue, 14 Feb 2023 07:07:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E12C5C433A7;
        Tue, 14 Feb 2023 07:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676358419;
        bh=3mR91vFTYi4rZMGRYXhJgaTgkFrCc+v4wRJPGBILCHc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lSg8bVoi1sh/I6LONG4iulI3+H5Ch/fv8oDbHX3Iz0jLvADbdNJ6D9Sz4m9UcKyBI
         u8j3EjXkJ36I1pjLPkbtpMMmXURLhpf0+V6yaLVf1isw74nA6CnSOlvkxRCip1ngGU
         95eXUsVxMrlU6SstBN4ziVQPwIQ8/17wMlV2LoZUpRs3AjK1TEzUHxr9L1Unx2Bc2c
         iPW6u9juO9foAwGO5JJByMvXfPQB1Lpxb4CcPYBA8FAJBUrIQBu6A2r//KGsu7LfUt
         1HyKwkSfkaRwk/DdZ7zy/c/F59Cd3SGJj/k7oluBq9g8jtnPj9mSreXUy0dUR7bYBo
         6iq/gvWezobbQ==
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
Subject: [PATCH v2 06/24] ia64/cpu: Mark play_dead() __noreturn
Date:   Mon, 13 Feb 2023 23:05:40 -0800
Message-Id: <7575bb38417bd8bcb5be980443f99cab29319342.1676358308.git.jpoimboe@kernel.org>
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

play_dead() doesn't return.  Annotate it as such.  By extension this
also makes arch_cpu_idle_dead() noreturn.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/ia64/kernel/process.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
index f6195a0a00ae..78f5794b2dde 100644
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -201,7 +201,7 @@ __setup("nohalt", nohalt_setup);
 
 #ifdef CONFIG_HOTPLUG_CPU
 /* We don't actually take CPU down, just spin without interrupts. */
-static inline void play_dead(void)
+static inline void __noreturn play_dead(void)
 {
 	unsigned int this_cpu = smp_processor_id();
 
@@ -219,7 +219,7 @@ static inline void play_dead(void)
 	BUG();
 }
 #else
-static inline void play_dead(void)
+static inline void __noreturn play_dead(void)
 {
 	BUG();
 }
-- 
2.39.1

