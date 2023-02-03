Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215A168A58C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 23:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbjBCWHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 17:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233929AbjBCWHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 17:07:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A8FAF6BD;
        Fri,  3 Feb 2023 14:06:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E77EDB82C2C;
        Fri,  3 Feb 2023 22:06:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E08DFC433EF;
        Fri,  3 Feb 2023 22:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675461965;
        bh=X1eIlBV7mYZUrbC//4ufL+T75dx0a2gkyRGVpnoY/QM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DhDkIMUjEJOyX2EMlHrPxdUnBWRX3se0vLGO731POCqHk9/VQrMV/gXm8Vb9/Z2m3
         UvzerGv0nP8kmAJhO23jS42gvkc6o8sJJTyUd/dleHrvmoqm98KN02bKtkQZO7MfFL
         WiEZU6kpXcLgGxhn/vJpxLEiRCyGWZl3pjakg3znFOX8OkwD/QWUnY0u+Z51AYGuT1
         3ZX1IoRQ7B7uGKZ1bvIOTbD3JdF+6rUUJYCcYypC+Tlbn/Ml8u53/6kdTb+Sog6/sv
         AsLRZWp+uNctE1zUajMgDNYRMYvTo3DPuPNnHQwSTW0D6vHT8JOdvEDURTxD2SUNqz
         O5cRPvgdcbiQQ==
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
Subject: [PATCH 13/22] sh/cpu: Make sure play_dead() doesn't return
Date:   Fri,  3 Feb 2023 14:05:22 -0800
Message-Id: <a984bc4e16d6074f69c12483feec2ddb1721b325.1675461757.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1675461757.git.jpoimboe@kernel.org>
References: <cover.1675461757.git.jpoimboe@kernel.org>
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

play_dead() doesn't return.  Make that more explicit with a BUG().

BUG() is preferable to unreachable() because BUG() is a more explicit
failure mode and avoids undefined behavior like falling off the edge of
the function into whatever code happens to be next.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/sh/include/asm/smp-ops.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/include/asm/smp-ops.h b/arch/sh/include/asm/smp-ops.h
index e27702130eb6..63866b1595a0 100644
--- a/arch/sh/include/asm/smp-ops.h
+++ b/arch/sh/include/asm/smp-ops.h
@@ -27,6 +27,7 @@ static inline void plat_smp_setup(void)
 static inline void play_dead(void)
 {
 	mp_ops->play_dead();
+	BUG();
 }
 
 extern void register_smp_ops(struct plat_smp_ops *ops);
-- 
2.39.0

