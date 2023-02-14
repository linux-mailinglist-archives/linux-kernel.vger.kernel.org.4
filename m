Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02394695A19
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 08:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbjBNHJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 02:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbjBNHHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 02:07:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D62D1DBBB;
        Mon, 13 Feb 2023 23:07:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EA1561483;
        Tue, 14 Feb 2023 07:07:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC09C4339C;
        Tue, 14 Feb 2023 07:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676358443;
        bh=Vz9pacmD2uWnKtGE9AgzwIGUED4qhPPVsYwwh31r10c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ihibyp4ipYh7lQbANFcsUTiHup0xNx5JMQ/c4E3q5yGId+1gTQii/DTVSUWTsOltw
         IqvTEQrOFzi2eFo294/k7bZhA6LANgcvqyIA6iJgUKc3l8XDMyd8GBQE+AIh601ofR
         Qc3xpRS1OEc1oUgLhUfbdhFWnImGAZlRDONcTJ/AUMAJRMW7eT2YlrHDa/yyWvyexc
         X6uQrIyw5EWPq7+6xku9zrDlYBy8ZUaQ+gxoKXgdd3pvsLjc6WJXXE5XCSZlHYHxoY
         0KvkA5welRNTeqfi984yl9rKlVPjqPnNJdmII0J45bsDxbkD1Y+8mlhaPORYaSNPw7
         yJswjRO+Y9qRw==
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
Subject: [PATCH v2 19/24] xtensa/cpu: Make sure cpu_die() doesn't return
Date:   Mon, 13 Feb 2023 23:05:53 -0800
Message-Id: <cca346b5c87693499e630291d78fb0bf12c24290.1676358308.git.jpoimboe@kernel.org>
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

cpu_die() doesn't return.  Make that more explicit with a BUG().

BUG() is preferable to unreachable() because BUG() is a more explicit
failure mode and avoids undefined behavior like falling off the edge of
the function into whatever code happens to be next.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/xtensa/kernel/smp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/xtensa/kernel/smp.c b/arch/xtensa/kernel/smp.c
index 4dc109dd6214..7bad78495536 100644
--- a/arch/xtensa/kernel/smp.c
+++ b/arch/xtensa/kernel/smp.c
@@ -341,6 +341,8 @@ void __ref cpu_die(void)
 	__asm__ __volatile__(
 			"	movi	a2, cpu_restart\n"
 			"	jx	a2\n");
+
+	BUG();
 }
 
 #endif /* CONFIG_HOTPLUG_CPU */
-- 
2.39.1

