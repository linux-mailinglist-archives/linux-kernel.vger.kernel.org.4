Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DADB3739338
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 01:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjFUXto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 19:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjFUXtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 19:49:42 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64B010C1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 16:49:41 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-54f87d5f1abso3066712a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 16:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687391381; x=1689983381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qf6e3zoK2lsWX8TAhmhXGe8qT9YHqy+yrmBlFlT9OBM=;
        b=c5YuTRy9R2yb2eiPTBYXT2zor3k2ndwHM7Z5Nd7s9q1+mLBz0lrz9Te3PBUdI/CRMr
         gYOSYN9K4kxbL9H5UQRxV1pjPbUCgBX+5aDsvcs9HeWrYIO3xebc6wABof7qNNl15ovb
         u3zKMOKhENXOjtAtM7LIG3U2QCZ453qy1irqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687391381; x=1689983381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qf6e3zoK2lsWX8TAhmhXGe8qT9YHqy+yrmBlFlT9OBM=;
        b=LWpwZdGq+xjjR5iM1dAsjhFTf23lZK+j+INOVDfbkkD3PGf9OqSGKkEnPllpHo3CqB
         h+Nx5YlLLZrJ2ZBXU62RDd7rwLITafZHnnJPkhiDqtAxdr2A3NxFnjwhT6Pvein99MPq
         ESNPL2bF6b62udzBm+8OZvpfFbi+1FwGCvRUSgL5exbhLMX8eOG2iPcYu6wEeesXLeDU
         uNstvik305NGcMxrG2Dogf/8Vv068AeE39gdU0EVKiUOzKzKS4+Zq2gnw9lmnZM1jn2s
         Wmv06fkZWKipDvlmZhwv0FJHXBvkGUKkWTAouEV5TPnIH8zRV3Z5JZs5jL7fgNnzBcks
         3Zfw==
X-Gm-Message-State: AC+VfDxgb1GdJwm+6Z4I+kgyPYVxuvRLEVyqdLFSvPIpor4g7urslG4J
        MzuYeRJaWseQBLxfPCIi9af1rA==
X-Google-Smtp-Source: ACHHUZ5RRv6lO7lptwFwZwCIvhWJ2DKoOHfR/syo0v3pV9+ibIJneyN8vuWWvvovrkxhJaXmUQ/z1Q==
X-Received: by 2002:a05:6a20:5496:b0:123:21e7:cf22 with SMTP id i22-20020a056a20549600b0012321e7cf22mr3510740pzk.52.1687391381205;
        Wed, 21 Jun 2023 16:49:41 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:4fc5:ca67:5b9a:cee0])
        by smtp.gmail.com with ESMTPSA id p18-20020a170902ebd200b001b523714ed5sm3940880plg.252.2023.06.21.16.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 16:49:40 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Douglas Anderson <dianders@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Move arch_trigger_cpumask_backtrace from nmi.h to irq.h
Date:   Wed, 21 Jun 2023 16:48:19 -0700
Message-ID: <20230621164809.1.Ice67126857506712559078e7de26d32d26e64631@changeid>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The powerpc architecture was the only one that defined
arch_trigger_cpumask_backtrace() in asm/nmi.h instead of
asm/irq.h. Move it to be consistent.

This fixes compile time errors introduced by commit 7ca8fe94aa92
("watchdog/hardlockup: define HARDLOCKUP_DETECTOR_ARCH"). That commit
caused <asm/nmi.h> to stop being included if the hardlockup detector
wasn't enabled. The specific errors were:
  error: implicit declaration of function ‘nmi_cpu_backtrace’
  error: implicit declaration of function ‘nmi_trigger_cpumask_backtrace’

Fixes: 7ca8fe94aa92 ("watchdog/hardlockup: define HARDLOCKUP_DETECTOR_ARCH")
Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Closes: https://lore.kernel.org/r/871qi5otdh.fsf@mail.lhotse
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I'd expect that this would land in Andrew Morton's tree along with the
other lockup detector stuff.

 arch/powerpc/include/asm/irq.h | 6 ++++++
 arch/powerpc/include/asm/nmi.h | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/irq.h b/arch/powerpc/include/asm/irq.h
index 94dffa1dd223..f7a90b6f3ceb 100644
--- a/arch/powerpc/include/asm/irq.h
+++ b/arch/powerpc/include/asm/irq.h
@@ -53,5 +53,11 @@ void __do_IRQ(struct pt_regs *regs);
 
 int irq_choose_cpu(const struct cpumask *mask);
 
+#ifdef CONFIG_NMI_IPI
+extern void arch_trigger_cpumask_backtrace(const cpumask_t *mask,
+					   bool exclude_self);
+#define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
+#endif
+
 #endif /* _ASM_IRQ_H */
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/include/asm/nmi.h b/arch/powerpc/include/asm/nmi.h
index ce25318c3902..49a75340c3e0 100644
--- a/arch/powerpc/include/asm/nmi.h
+++ b/arch/powerpc/include/asm/nmi.h
@@ -9,12 +9,6 @@ void watchdog_hardlockup_set_timeout_pct(u64 pct);
 static inline void watchdog_hardlockup_set_timeout_pct(u64 pct) {}
 #endif
 
-#ifdef CONFIG_NMI_IPI
-extern void arch_trigger_cpumask_backtrace(const cpumask_t *mask,
-					   bool exclude_self);
-#define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
-#endif
-
 extern void hv_nmi_check_nonrecoverable(struct pt_regs *regs);
 
 #endif /* _ASM_NMI_H */
-- 
2.41.0.162.gfafddb0af9-goog

