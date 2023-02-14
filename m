Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0945695A38
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 08:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbjBNHJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 02:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjBNHHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 02:07:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E821E1D1;
        Mon, 13 Feb 2023 23:07:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B19BFB81C0B;
        Tue, 14 Feb 2023 07:07:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFFFFC433EF;
        Tue, 14 Feb 2023 07:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676358436;
        bh=Ps4PGBv5yPXgtfxfiozPFQBkOC0Om6bfqHZoaR0a8Wo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MDsB0lHraBham/iBQwdl/0Ii9dk8Fs9DMdBLbIn4m+kNU0Ocm8Gn9vAEo2FfPFAGg
         MXid5BhOlSnx6jtD07OvEM0AQjNL6xK96ztsfJaaJbji01ahTN77Njrk8qiVs4WrQZ
         RGqCdA/2a/guY2gP+hj7f+21EdwRYt7sXIbtaE1Ukcp1q+Gh6DgkQ64wn1A5vJLc+V
         odxmo+I5tHChoineV/Y+LwKEiWgmUKi/aJU+aQ/l6vUIO1+ZQ8XYX80Bv/mo2ZVL6d
         4DsM/ppaCL0pPFKUsMcO3kYD7KJFpXSTX3GxGujVjrt5tnDm1VdYU8uBZ+R1xQzCB4
         rNYx73prqIL/A==
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
Subject: [PATCH v2 15/24] sh/cpu: Expose arch_cpu_idle_dead()'s prototype definition
Date:   Mon, 13 Feb 2023 23:05:49 -0800
Message-Id: <3d9661e97828fb464a48d4becf18f12604831903.1676358308.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1676358308.git.jpoimboe@kernel.org>
References: <cover.1676358308.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include <linux/cpu.h> to make sure arch_cpu_idle_dead() matches its
prototype going forward.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/sh/kernel/idle.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/kernel/idle.c b/arch/sh/kernel/idle.c
index 3418c40f0099..114f0c4abeac 100644
--- a/arch/sh/kernel/idle.c
+++ b/arch/sh/kernel/idle.c
@@ -4,6 +4,7 @@
  *
  *  Copyright (C) 2002 - 2009  Paul Mundt
  */
+#include <linux/cpu.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/mm.h>
-- 
2.39.1

