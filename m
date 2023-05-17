Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85753706881
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 14:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbjEQMpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 08:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjEQMpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 08:45:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C08212D
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 05:45:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE0BC646CB
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:45:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC045C4339B;
        Wed, 17 May 2023 12:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684327532;
        bh=iOvwhrIqurJ9VDkNH99fkMyAAsvkDjtRTJDy0SAwuEE=;
        h=From:To:Cc:Subject:Date:From;
        b=KXW/r94Q7ohDPiHr0WynE0BNA5PbgMdv1VdP3fPVRosVwyBRn7cKtcvUHduFDm/6n
         Z7ROnCIBNMzOYh4W6Lne0zgMcRsWz4vfpGfN2AFOdfrb+uUtd7orQ0KL6Kp5dEGLrs
         FlzSb7yHd4VOO64a3lGHt429hR9rOA9YlSkxHH/kaptA/8GzG3jIOOIFT34l7SD+GH
         lne4q4ssxGKV8nM4y86ywSHghXnzr3qmL6B11q5AKGvTW76/nagyX35hi0QLj5CSX8
         rjKhJ/JdACi3+X78dudTjmyOL6QV+dyifUsO3VQeo+W+pkq6tm0+ts0sn+8kgtqGYL
         GOd3HPkal7XTw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Jan Beulich <jbeulich@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: [PATCH] xen: xen_debug_interrupt prototype to global header
Date:   Wed, 17 May 2023 14:45:07 +0200
Message-Id: <20230517124525.929201-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The xen_debug_interrupt() function is only called on x86, which has a
prototype in an architecture specific header, but the definition also
exists on others, where the lack of a prototype causes a W=1 warning:

drivers/xen/events/events_2l.c:264:13: error: no previous prototype for 'xen_debug_interrupt' [-Werror=missing-prototypes]

Move the prototype into a global header instead to avoid this warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/xen/xen-ops.h | 2 --
 include/xen/events.h   | 3 +++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/xen/xen-ops.h b/arch/x86/xen/xen-ops.h
index 84a35ff1e0c9..0f71ee3fe86b 100644
--- a/arch/x86/xen/xen-ops.h
+++ b/arch/x86/xen/xen-ops.h
@@ -72,8 +72,6 @@ void xen_restore_time_memory_area(void);
 void xen_init_time_ops(void);
 void xen_hvm_init_time_ops(void);
 
-irqreturn_t xen_debug_interrupt(int irq, void *dev_id);
-
 bool xen_vcpu_stolen(int vcpu);
 
 void xen_vcpu_setup(int cpu);
diff --git a/include/xen/events.h b/include/xen/events.h
index 44c2855c76d1..ac1281c5ead6 100644
--- a/include/xen/events.h
+++ b/include/xen/events.h
@@ -138,4 +138,7 @@ int xen_test_irq_shared(int irq);
 
 /* initialize Xen IRQ subsystem */
 void xen_init_IRQ(void);
+
+irqreturn_t xen_debug_interrupt(int irq, void *dev_id);
+
 #endif	/* _XEN_EVENTS_H */
-- 
2.39.2

