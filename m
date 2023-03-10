Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582586B5260
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 21:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbjCJU4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 15:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbjCJUyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 15:54:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208F4118BED;
        Fri, 10 Mar 2023 12:54:55 -0800 (PST)
Date:   Fri, 10 Mar 2023 20:54:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678481693;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DkS8ffj6l4DSQ1wDgSe+WmN13XI+OvNKC2dLe4V4i34=;
        b=2G2mRsjELY2IAQp+TzHzsynwsUt8o67AoCS3dtbtQ/ltD50ZYtjCXwhUiamuPM0/lmbgSc
        8QtgMXGgF+qJtWPkMd7+pql0rKfb6bS+7URGQNusXy4autQRGUFfthVLK/0i1dPSQ+FInC
        bO5Ujz/zaM3Q0dekkUnwh3ptI0p3iDT7w97fTTbc91W667ywsbTZBzMNELH3J/BhYSo5MZ
        iAYqtQe8p4NUo7FcuCgwelTmtBEaSiGo55RX+AfPT2ZNxZ7b71cLwb6nQ/1S9Ua7H2bBI8
        VGsd8VSWhMZmU5968kgfnyTegymf9IYi54ijEOQ6b/BWVYRloo6vqkWHSzJ1oA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678481693;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DkS8ffj6l4DSQ1wDgSe+WmN13XI+OvNKC2dLe4V4i34=;
        b=8nByOR6iECZYA2dmQm1VMnqI8rbNKyaETN21pSn4OrQmKM4G8mu2aQ0aywt6NS8KhMF76j
        obUimiRHuGjf7ZBA==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] loongarch/cpu: Mark play_dead() __noreturn
Cc:     philmd@linaro.org, Josh Poimboeuf <jpoimboe@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <4da55acfdec8a9132c4e21ffb7edb1f846841193.1676358308.git.jpoimboe@kernel.org>
References: <4da55acfdec8a9132c4e21ffb7edb1f846841193.1676358308.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <167848169339.5837.3411505337916223635.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     6c0f2d071eded22cb72413e0abfaa5b3373b4d96
Gitweb:        https://git.kernel.org/tip/6c0f2d071eded22cb72413e0abfaa5b3373=
b4d96
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 13 Feb 2023 23:05:42 -08:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Mon, 06 Mar 2023 15:34:06 -08:00

loongarch/cpu: Mark play_dead() __noreturn

play_dead() doesn't return.  Annotate it as such.  By extension this
also makes arch_cpu_idle_dead() noreturn.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
Link: https://lore.kernel.org/r/4da55acfdec8a9132c4e21ffb7edb1f846841193.1676=
358308.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/loongarch/include/asm/smp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/include/asm/smp.h b/arch/loongarch/include/asm/sm=
p.h
index d826873..416b653 100644
--- a/arch/loongarch/include/asm/smp.h
+++ b/arch/loongarch/include/asm/smp.h
@@ -99,7 +99,7 @@ static inline void __cpu_die(unsigned int cpu)
 	loongson_cpu_die(cpu);
 }
=20
-extern void play_dead(void);
+extern void __noreturn play_dead(void);
 #endif
=20
 #endif /* __ASM_SMP_H */
