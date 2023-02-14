Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC456959D5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 08:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbjBNHHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 02:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbjBNHH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 02:07:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F171F5F0;
        Mon, 13 Feb 2023 23:07:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1B835B81C05;
        Tue, 14 Feb 2023 07:06:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC7AC433D2;
        Tue, 14 Feb 2023 07:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676358417;
        bh=1IRtpjryrFlaH3zPaQpRgLkIHqmynE5Y+t83e8Katow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WIt7PESUlL7eAgHG5yZuO/+Pzi2Iam84D6QDgX/lNFfE8E0LXUA7q2LZkTiM5E8Fr
         ltBF7m+A7cmNRWpEhtz56mVsB+LFjKR/8ja/VIadHjfLNx6yoIichWpu3qYfGaq9zV
         JUaO6KsixyAIrqpbjns4PoYgTh+jmEq6E6/qod0ooIa5PLN2YlJkG0c45baK9kSFk7
         rEpSQ/SUSV1Cm1007AMLqK1a8R4bFLtedrlHoNLHVcT+P7vYH3dJ2lb1AoYpaKKEfb
         G5zQb6o7kDZcoEXZ/kyJnO9GlC/GcWjY5p12geGmAv8g+mjBO16dd/Nnx7oWVJM63e
         qIsMMhe6b0uBA==
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
Subject: [PATCH v2 05/24] csky/cpu: Make sure arch_cpu_idle_dead() doesn't return
Date:   Mon, 13 Feb 2023 23:05:39 -0800
Message-Id: <1e9ecc3d248e82973e80bc336fc9f97e3ba2708d.1676358308.git.jpoimboe@kernel.org>
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

arch_cpu_idle_dead() doesn't return.  Make that more explicit with a
BUG().

BUG() is preferable to unreachable() because BUG() is a more explicit
failure mode and avoids undefined behavior like falling off the edge of
the function into whatever code happens to be next.

Acked-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/csky/kernel/smp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/csky/kernel/smp.c b/arch/csky/kernel/smp.c
index b45d1073307f..0ec20efaf5fd 100644
--- a/arch/csky/kernel/smp.c
+++ b/arch/csky/kernel/smp.c
@@ -317,5 +317,7 @@ void arch_cpu_idle_dead(void)
 		"jmpi	csky_start_secondary"
 		:
 		: "r" (secondary_stack));
+
+	BUG();
 }
 #endif
-- 
2.39.1

