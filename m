Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6795068A5BB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 23:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234130AbjBCWIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 17:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbjBCWH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 17:07:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1022DAE87E;
        Fri,  3 Feb 2023 14:06:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D0856202F;
        Fri,  3 Feb 2023 22:06:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00232C433AA;
        Fri,  3 Feb 2023 22:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675461978;
        bh=ikmsAPzcHbKm4BPXAk4vCHLoc1MwBOQvSdhyskC8aqk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YYnlpQSIhXfIuZtmwX80cwYo8HEVkuAoZxxjLbmDEqRvH2RxesFNwaeIQN8SzGBzW
         vLLgsYhL0lS45Fyp9Ve74Sw7eovpDoz9Guf5+yE5xWhW9jMzSmF6nhwFbdConwpN/q
         D9yipeu6g+D7RAafGUb1qRd6MBnXP+1xEKWp3ZVkISd4WH7IqGChCY1svitqCGUU2L
         JdWz9fBXaPuCoakVUsltIf7yUwqSNv7WF803g7r/quj+PbB+xvBjdfXD9xeqxTxmh5
         kyPlNWlqjarxCrasQl1DO4ameVNS+OQy/bXqd6w2fDPppGX9mt+KVd1ga0sKukW8F6
         dCgB90Ai6peWA==
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
Subject: [PATCH 20/22] xtensa/cpu: Mark cpu_die() __noreturn
Date:   Fri,  3 Feb 2023 14:05:29 -0800
Message-Id: <f49d0092aa9eb23fe495c697bd49b2553220fa29.1675461757.git.jpoimboe@kernel.org>
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

cpu_die() doesn't return.  Annotate it as such.  By extension this also
makes arch_cpu_idle_dead() noreturn.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/xtensa/include/asm/smp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/xtensa/include/asm/smp.h b/arch/xtensa/include/asm/smp.h
index 4e43f5643891..5dc5bf8cdd77 100644
--- a/arch/xtensa/include/asm/smp.h
+++ b/arch/xtensa/include/asm/smp.h
@@ -33,7 +33,7 @@ void show_ipi_list(struct seq_file *p, int prec);
 
 void __cpu_die(unsigned int cpu);
 int __cpu_disable(void);
-void cpu_die(void);
+void __noreturn cpu_die(void);
 void cpu_restart(void);
 
 #endif /* CONFIG_HOTPLUG_CPU */
-- 
2.39.0

