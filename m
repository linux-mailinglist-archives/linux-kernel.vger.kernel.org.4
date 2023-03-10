Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192396B525D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 21:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjCJUzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 15:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjCJUyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 15:54:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4EB108691;
        Fri, 10 Mar 2023 12:54:54 -0800 (PST)
Date:   Fri, 10 Mar 2023 20:54:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678481692;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NjC0FTxtmpLAecn/XQ1NoFaX1YT4mPri5PoJld/Px6g=;
        b=rDUhS6SYl//kywJSTGl9pVP/irDpEUSiQlfSx31OgIB0XQrOz+9rPF5ykyCpOrMJI+pfpX
        LMHfKyEmU+7qSXPyvRnbSqbrkVmAmncXgypPq+aZL9t3pnP9eJtr3zSGJQ+rkeLgOY8VEx
        BRsiMD00FQvYwKrzzzroJ5eHFAeJudizMX7/H8V9kWwDbC++E8afj70SvF9ngZXqd6hu4f
        lYXRvvOx+MCJrrECBu8deUtI2hnC0ceF1lr8JQK/wCWe7iD7ihRkA54DNW91stVhSKSPWi
        UQHpRSqa8D/a07iI2hVg3ZQifIfAGNzi3MWZ1tZGa+OiCuxFZeI5e+CPYDj6Yw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678481692;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NjC0FTxtmpLAecn/XQ1NoFaX1YT4mPri5PoJld/Px6g=;
        b=bCFpQk9q02DyTTszs1y1k0oNV7WT+yyvdEKecCUzCfDp1Gs6gZPcJAAk1qIevaFhHb/Ghh
        pWtFnWlpIhrB81Cg==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] mips/cpu: Make sure play_dead() doesn't return
Cc:     Florian Fainelli <f.fainelli@gmail.com>, philmd@linaro.org,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <b195e4da190bb06b7d4af15d66ce6129e2347630.1676358308.git.jpoimboe@kernel.org>
References: <b195e4da190bb06b7d4af15d66ce6129e2347630.1676358308.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <167848169247.5837.4395210640592574700.tip-bot2@tip-bot2>
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

Commit-ID:     a80ceed6c9c24088d7a2e3c414eae1fe88a8ccbe
Gitweb:        https://git.kernel.org/tip/a80ceed6c9c24088d7a2e3c414eae1fe88a=
8ccbe
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 13 Feb 2023 23:05:44 -08:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Wed, 08 Mar 2023 08:44:23 -08:00

mips/cpu: Make sure play_dead() doesn't return

play_dead() doesn't return.  Make that more explicit with a BUG().

BUG() is preferable to unreachable() because BUG() is a more explicit
failure mode and avoids undefined behavior like falling off the edge of
the function into whatever code happens to be next.

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
Link: https://lore.kernel.org/r/b195e4da190bb06b7d4af15d66ce6129e2347630.1676=
358308.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/mips/kernel/smp-bmips.c | 2 ++
 arch/mips/loongson64/smp.c   | 1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
index 51d5dae..15466d4 100644
--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -415,6 +415,8 @@ void __ref play_dead(void)
 	"	wait\n"
 	"	j	bmips_secondary_reentry\n"
 	: : : "memory");
+
+	BUG();
 }
=20
 #endif /* CONFIG_HOTPLUG_CPU */
diff --git a/arch/mips/loongson64/smp.c b/arch/mips/loongson64/smp.c
index 4e24b31..df8d789 100644
--- a/arch/mips/loongson64/smp.c
+++ b/arch/mips/loongson64/smp.c
@@ -823,6 +823,7 @@ out:
 	state_addr =3D &per_cpu(cpu_state, cpu);
 	mb();
 	play_dead_at_ckseg1(state_addr);
+	BUG();
 }
=20
 static int loongson3_disable_clock(unsigned int cpu)
