Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1439E5F7AEC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 17:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbiJGPqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 11:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiJGPqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 11:46:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCC0437D4
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 08:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665157567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O4Pqcbma7I8CmezCzayfM2Dc1cTkJUS9uBKY5V7UMK0=;
        b=U0vsmFnSMadZ0g1qVOI2/m8d9nldX+/EqTojuL1IXkVPcBUaVGYEW0ix1mTdmtNSvz3P3a
        a92ChElQoaj5BIiqMoeKtkOFklL61YKiskY7LDqLqvFeghEUl/AA6s51YErB/0BLhyHfZS
        ralcb5iJmTqgCxrLAymZV4MMtVroCwM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-642-osv29EiBOGOe5jtEwTyJHA-1; Fri, 07 Oct 2022 11:46:04 -0400
X-MC-Unique: osv29EiBOGOe5jtEwTyJHA-1
Received: by mail-wm1-f71.google.com with SMTP id o18-20020a05600c339200b003bf24961658so2845700wmp.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 08:46:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O4Pqcbma7I8CmezCzayfM2Dc1cTkJUS9uBKY5V7UMK0=;
        b=K3MHsut82h050ed2xifnxBJW/DHNOgmODw+Kc3kC6nBh1twUAj8sX6tnrvxBnPh6Zu
         3wsp3LenGwUMbKz4pGFjW6Vn1bfEJhJEkYQgpQbR5rJIj/M96FkR1O3iqdROJPj1qOhm
         YTvheecuodH5eaORVejGTlBBgQCIhIKk3tBZ/Cu2mtPRYJtcnRAXSbuUb3vqtxxXrcSx
         NDwpEd7NUZIimnVfo6GG7hgyHV8gxnVPic1BErIO6ZMh6kbF4Xj8MuywzhHeCX18795r
         PhkgMjky4gOhx2MlFZOov1xR8zMCJLS8k6Q+y0h4GngzXQHHAR5At/PUhfECfhSCXrJR
         Nffg==
X-Gm-Message-State: ACrzQf1BZkQt3i39kIDFcHdMs9rkT4npx8YSiWjhIXRV26tCeqN6GMlK
        xNWUs1UN3QSsl+u/gAHYxCVab2LIRGAIYQSzUHzE6JY5ez5V1PZKZM1itiX88ztrwZD4djt/+9Y
        zLNxEXSBOVYetXgZGkTCEDxP9
X-Received: by 2002:a05:600c:474c:b0:3b4:cbca:5677 with SMTP id w12-20020a05600c474c00b003b4cbca5677mr3615498wmo.76.1665157563625;
        Fri, 07 Oct 2022 08:46:03 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5BU2FP8ts0HH9McA8hGqt4EcEkhUio8tUw5hjcE8rRRaWGVB+HCzlKu55T50nu8VVd2MVS1w==
X-Received: by 2002:a05:600c:474c:b0:3b4:cbca:5677 with SMTP id w12-20020a05600c474c00b003b4cbca5677mr3615475wmo.76.1665157563388;
        Fri, 07 Oct 2022 08:46:03 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id i18-20020adfb652000000b0022e38c93195sm2339428wre.34.2022.10.07.08.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 08:46:01 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        x86@kernel.org
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Guo Ren <guoren@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [RFC PATCH 3/5] smp: Add a multi-CPU variant to send_call_function_single_ipi()
Date:   Fri,  7 Oct 2022 16:45:31 +0100
Message-Id: <20221007154533.1878285-3-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221007154145.1877054-1-vschneid@redhat.com>
References: <20221007154145.1877054-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This simply wraps around the arch function and prepends it with a
tracepoint, bringing parity with send_call_function_single_ipi().

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/smp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 7a7a22d69972..387735180aed 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -160,6 +160,12 @@ void __init call_function_init(void)
 	smpcfd_prepare_cpu(smp_processor_id());
 }
 
+static inline void send_call_function_ipi_mask(const struct cpumask *mask)
+{
+	trace_ipi_send_cpumask(_RET_IP_, mask);
+	arch_send_call_function_ipi_mask(mask);
+}
+
 #ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
 
 static DEFINE_STATIC_KEY_FALSE(csdlock_debug_enabled);
@@ -970,7 +976,7 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 		if (nr_cpus == 1)
 			send_call_function_single_ipi(last_cpu);
 		else if (likely(nr_cpus > 1))
-			arch_send_call_function_ipi_mask(cfd->cpumask_ipi);
+			send_call_function_ipi_mask(cfd->cpumask_ipi);
 
 		cfd_seq_store(this_cpu_ptr(&cfd_seq_local)->pinged, this_cpu, CFD_SEQ_NOCPU, CFD_SEQ_PINGED);
 	}
-- 
2.31.1

