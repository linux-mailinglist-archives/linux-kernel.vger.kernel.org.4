Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEAA73AF13
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 05:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjFWD3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 23:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjFWD3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 23:29:00 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2F72130
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 20:28:58 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-666eef03ebdso43739b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 20:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687490937; x=1690082937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UbCparE/RKUBvduSG+9T7tJYjF4EAS3Se6eC6l4lN3I=;
        b=Ri8oxVqPuYB8qbqbpDHBR7UsvWxZYJPhe0Z/RzlE+I4ZLTBMwDVvs4C6yEr/K2LQM0
         G8KdvziFF5fR91nZYgF/YyNcQ7CHa5pAiNev+qKDdpls/Un3s/+e58oaD/FTy6+rDTV/
         EP7ug2pDfnLrdNksWColE+/sETHm8R2Ze2zZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687490937; x=1690082937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UbCparE/RKUBvduSG+9T7tJYjF4EAS3Se6eC6l4lN3I=;
        b=T3qCNYgCevi60sPpE/AZhoi8gCAYXbvTLTvsFeFoJaK4MdiFMB524Z/uswY82B8acw
         wFC7OdQ9tiB8x8s3O1Xhe8PQZTIqwEnKr8uLYjg+BkcO2n2wJzn8UUF4oO8h1KdnQMor
         jMxZWFwypb9RToU9FFlyISI8KnDV1LXqHxjEN1bbjZr/kgzpgsO9xK0ddsvglRQ5MSmF
         4erosYNgoZtn1nx6CfD6j0WCuJEeHbIMk0GS/+2izrte8nahsgKgEHAfYcTpdQROf4kc
         3GQyVEmKstKegfpFEcXCElCO8rcnZyW5XrW9L/PUpK0zKyRncuDp7hGlkfyf5BQs8+pS
         pNXg==
X-Gm-Message-State: AC+VfDyC+TSDFOnh1+kQzrRk6Ux96Xib1SK7N492H5FB50DExP68ML/h
        MDydnTIR3yF49/FftDgJ9N7Fcw==
X-Google-Smtp-Source: ACHHUZ71Y8YUhMdZD3k4/kExQ1KMRHXAMNZY4EEbBixcC9tU/J9oOscg5bO9OohTYDHLuQg7HGWZ2A==
X-Received: by 2002:a05:6a00:b51:b0:668:71a1:2e74 with SMTP id p17-20020a056a000b5100b0066871a12e74mr12139295pfo.5.1687490937604;
        Thu, 22 Jun 2023 20:28:57 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:fddd:7fcf:b7e4:2619])
        by smtp.gmail.com with ESMTPSA id m2-20020aa79002000000b0064d1d8fd24asm5156391pfo.60.2023.06.22.20.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 20:28:56 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Petr Mladek <pmladek@suse.com>,
        Douglas Anderson <dianders@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powerpc: Move arch_trigger_cpumask_backtrace from nmi.h to irq.h
Date:   Thu, 22 Jun 2023 20:28:25 -0700
Message-ID: <20230622202816.v2.1.Ice67126857506712559078e7de26d32d26e64631@changeid>
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

NOTE: when moving this into irq.h, we also change the guards from just
checking if "CONFIG_NMI_IPI" is defined to also checking if
"CONFIG_PPC_BOOK3S_64" is defined. This matches the code in
arch/powerpc/kernel/stacktrace.c. Previously this worked because
<asm.nmi.h> was included if "CONFIG_HAVE_HARDLOCKUP_DETECTOR_ARCH" was
defined. For powerpc that's only selected if "CONFIG_PPC_BOOK3S_64" is
defined.

Fixes: 7ca8fe94aa92 ("watchdog/hardlockup: define HARDLOCKUP_DETECTOR_ARCH")
Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Closes: https://lore.kernel.org/r/871qi5otdh.fsf@mail.lhotse
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I'd expect that this would land in Andrew Morton's tree along with the
other lockup detector stuff.

Changes in v2:
- Change the guards to include CONFIG_PPC_BOOK3S_64.

 arch/powerpc/include/asm/irq.h | 6 ++++++
 arch/powerpc/include/asm/nmi.h | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/irq.h b/arch/powerpc/include/asm/irq.h
index 94dffa1dd223..f257cacb49a9 100644
--- a/arch/powerpc/include/asm/irq.h
+++ b/arch/powerpc/include/asm/irq.h
@@ -53,5 +53,11 @@ void __do_IRQ(struct pt_regs *regs);
 
 int irq_choose_cpu(const struct cpumask *mask);
 
+#if defined(CONFIG_PPC_BOOK3S_64) && defined(CONFIG_NMI_IPI)
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

