Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D9C68A576
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 23:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbjBCWHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 17:07:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233568AbjBCWGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 17:06:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72628AF6A2;
        Fri,  3 Feb 2023 14:06:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65018B82C2A;
        Fri,  3 Feb 2023 22:05:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7129AC433A7;
        Fri,  3 Feb 2023 22:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675461958;
        bh=xE5ZmRzKMxAFPrHiSIoJTZlCDR5ti+ono/cm0PWjfeU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bWyWlCGQ8ixOuALZdKCzLss/6SMXhh1P0jHxv5K8dz+pGFJWRKFe/rDpdYt/pbEBy
         Cv20t60IqNd4k2OPeeakryqDZQBCSnCIFbZYn4w8Wh4hZfyxfuwPiu4jwkipYMyAjx
         3wjdyLJq2+oQSUZX9lPMnbCOK9kacUFdHpR/7gDTkVlFBlenq2ALG85m81cnxhAlqT
         DUmyvxZm4cJjdO0Y03EgNOuJPyX9ZAC+k2Whi2B9zytn0fu/YSFoO3CbU5ghN7eGNf
         AnlKFwVCJfplEUcEgqGsH3y9cSX006B8L7WqnSyPF5fCyXIzVXK57ufqsSU1oTeXrl
         yrsQBm2IXfrYQ==
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
Subject: [PATCH 09/22] mips/cpu: Expose play_dead()'s prototype definition
Date:   Fri,  3 Feb 2023 14:05:18 -0800
Message-Id: <a532966831383927f5f4fbec0a1e13304588685a.1675461757.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1675461757.git.jpoimboe@kernel.org>
References: <cover.1675461757.git.jpoimboe@kernel.org>
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

Include <asm/smp.h> to make sure play_dead() matches its prototype going
forward.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/mips/kernel/smp-bmips.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
index f5d7bfa3472a..df9158e8329d 100644
--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -38,6 +38,7 @@
 #include <asm/traps.h>
 #include <asm/barrier.h>
 #include <asm/cpu-features.h>
+#include <asm/smp.h>
 
 static int __maybe_unused max_cpus = 1;
 
-- 
2.39.0

