Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457FB7012AD
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 01:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241165AbjELXvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 19:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240999AbjELXuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 19:50:50 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32164204
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 16:50:41 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-643fdfb437aso37898819b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 16:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683935441; x=1686527441;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=0PGjBuYsH+qENFwlP6YIflCQgyh/+jY7Rp+4isY3uAw=;
        b=IpfXQKDNfq33fpp3TPAvdomMbm4Tbp6Xj0gdNAonYxvAp7JiZH8DmMQtZ9srWRapbz
         uC7LCmu5T5/VGui1txQ58MH0oCADW5St/+sfDoVIdQXRmFDLDMqeb+YXOELs57FobABo
         W2VW19HXHMjvv7XhXhLW/3HE5P/QkjRtL+OavFPe7HpQtrOtUGG9nau0a9TrCMXLj/j9
         HgpwQhjgvU153Dot5mlhrfTuKsstno+0N2i/DoQQh31g90SbOl2XZqe9Lh6QhQ1EWwxN
         vYiHuv0qOtY5g2x/zkKecxGT0507wZyf4a0QiN2eJOil/pkK5+ime7jlXipteWR+kVjL
         aHYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683935441; x=1686527441;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0PGjBuYsH+qENFwlP6YIflCQgyh/+jY7Rp+4isY3uAw=;
        b=Unv891HwcDPnsCikyLomAUQRp13toYvNt/FAxcoODsvkfoEXL4yr8/BjvNB2PyHOjz
         2BPRpayKTYopVrhhORu9x3EXEx9qCjNlyAXKmVR+UJzB6VP3QM2AgikNc+VSFAj6DF5E
         64sDj+lJZbPfh3Txf/XWNyJD8DgSoTIQHRL+zB5ynvlvkwJyooMluHLmXKvW/CLuR7xQ
         Te8+fmACN5dPtoKLRx2x0nFEwis9GlLkpsHQSzJQYeiXas1o3SCpR5aX02/EcvrlXTkH
         KWVSFaILnU2eHUnSiYicOpJ8lV+j0wFJFGSUnLfVxZetg/KENvOsix3Qv7XLQ2j0KsO8
         W3vA==
X-Gm-Message-State: AC+VfDxvQQNrxfe+/LCYrZLIWoi97b2Vu4mWmMkbi6HQScRXdiWDwjIP
        TEXGvorLmB/wtbAMXJOdzs9d9EDPBmo=
X-Google-Smtp-Source: ACHHUZ5015X5VBKKDq2a5Ifaz7FuNszYa68VWUi9ZcPvMRinIm3wMD/xCPEGT9Zo2IVcHCQEnAWdclNi+W0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:6f81:b0:24b:6d01:584a with SMTP id
 e1-20020a17090a6f8100b0024b6d01584amr8598399pjk.0.1683935441288; Fri, 12 May
 2023 16:50:41 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 12 May 2023 16:50:14 -0700
In-Reply-To: <20230512235026.808058-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230512235026.808058-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230512235026.808058-7-seanjc@google.com>
Subject: [PATCH v3 06/18] x86/reboot: Assert that IRQs are disabled when
 turning off virtualization
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Kai Huang <kai.huang@intel.com>, Chao Gao <chao.gao@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assert that IRQs are disabled when turning off virtualization in an
emergency.  KVM enables hardware via on_each_cpu(), i.e. could re-enable
hardware if a pending IPI were delivered after disabling virtualization.

Remove a misleading comment from emergency_reboot_disable_virtualization()
about "just" needing to guarantee the CPU is stable (see above).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/reboot.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 20f7bdabc52e..fddfea5f1d20 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -531,7 +531,6 @@ static inline void nmi_shootdown_cpus_on_restart(void);
 
 static void emergency_reboot_disable_virtualization(void)
 {
-	/* Just make sure we won't change CPUs while doing this */
 	local_irq_disable();
 
 	/*
@@ -820,6 +819,13 @@ void cpu_emergency_disable_virtualization(void)
 {
 	cpu_emergency_virt_cb *callback;
 
+	/*
+	 * IRQs must be disabled as KVM enables virtualization in hardware via
+	 * function call IPIs, i.e. IRQs need to be disabled to guarantee
+	 * virtualization stays disabled.
+	 */
+	lockdep_assert_irqs_disabled();
+
 	rcu_read_lock();
 	callback = rcu_dereference(cpu_emergency_virt_callback);
 	if (callback)
-- 
2.40.1.606.ga4b1b128d6-goog

