Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D65F686FE8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 21:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjBAUpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 15:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjBAUpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 15:45:22 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D0C78AE9
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 12:44:52 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id y1so18518665wru.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 12:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6e9FsuHypszT7EvXQeEpKp5FLlszNay99UK4BoH4rM=;
        b=CwNSnHQiMWxYA/AjxMfHHlxHH6vbja8TRT1y9aTu12HxkVYye6Siks4+Jaoz8DdYxQ
         6BN+MgUbghZ8pXP0F5EbX5ssnDuePd0zdBTOYLLR8v22Ii2gWTUTGBprCQpHnhfHBWvk
         PqKjfY4iLnId8XY6A4ykMVbHrxoldwAKGVzmzZpkg0nn0wwbaSGA4cnQUaM1Ni9KbNaD
         2RK+CsdP0BEyIf9mghg++Zqpek1O2bkzOcfh8r5xI2mhqrPe10iuvsiCKyuusr9771iT
         mEc3DngzAFDNe3VmiJM4yva9zuZhtHvXT1kl2z1yXbyf2tDSPhRTgy3GdMVg7AI8NUti
         lpYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i6e9FsuHypszT7EvXQeEpKp5FLlszNay99UK4BoH4rM=;
        b=BvcwjeSdcNS1U1GbjSerzQp2y4n+vZVmp0izwxPB8nQ/IXlh09kFi4vx0tzKpTKwig
         yDeQS5lwtxy6ltefkA6/txegfnAKfvEVDqLIbXMW9FP1paKG+lyp+mSLYemd3vfq5Q0Z
         1vJScCxEDBYM0dH2v63EzjoVNOAe9PW2HPEzrDIyNNlHP6EZOFm3Xk//6w9Px8IAJ5tX
         E1SlVlgRHmXhgF7L6zRhu9j1gFDlrXKxAlxMNkB+XE0rRcfbtoWP1NW9bBq42sNN4TC2
         H8wRh5oR6wz3Q//xqEqqeZA7BaHjmlAmiZS48bSoUEfrYrnvxIicU+U0w2z0B7NE3L6V
         LK9w==
X-Gm-Message-State: AO0yUKXVlXywEqVx5DIxGB6vEAM3H/sjIJy475ykNO7AKCPviTHJFnzN
        9LjNjy2fkZOO8oQQrXenuKtkWg==
X-Google-Smtp-Source: AK7set/pT3z74IzW2nBj02yK+QlfaSM8ms0sxco1W7xIC1ERUGrB3EahjT363MYdB+ER9YH03N5g7Q==
X-Received: by 2002:a5d:5643:0:b0:2c0:227d:ca48 with SMTP id j3-20020a5d5643000000b002c0227dca48mr3283516wrw.63.1675284290622;
        Wed, 01 Feb 2023 12:44:50 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6a:b566:0:7611:c340:3d8d:d46c])
        by smtp.gmail.com with ESMTPSA id n15-20020a5d598f000000b002bdff778d87sm19993584wri.34.2023.02.01.12.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 12:44:50 -0800 (PST)
From:   Usama Arif <usama.arif@bytedance.com>
To:     dwmw2@infradead.org, tglx@linutronix.de
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, x86@kernel.org, pbonzini@redhat.com,
        paulmck@kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, rcu@vger.kernel.org, mimoja@mimoja.de,
        hewenliang4@huawei.com, thomas.lendacky@amd.com, seanjc@google.com,
        pmenzel@molgen.mpg.de, fam.zheng@bytedance.com,
        punit.agrawal@bytedance.com, simon.evans@bytedance.com,
        liangma@liangbit.com, David Woodhouse <dwmw@amazon.co.uk>,
        Usama Arif <usama.arif@bytedance.com>
Subject: [PATCH 4/9] x86/smpboot: Reference count on smpboot_setup_warm_reset_vector()
Date:   Wed,  1 Feb 2023 20:43:33 +0000
Message-Id: <20230201204338.1337562-5-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230201204338.1337562-1-usama.arif@bytedance.com>
References: <20230201204338.1337562-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Woodhouse <dwmw@amazon.co.uk>

If we want to do parallel CPU bringup, we're going to need to set this up
and leave it until all CPUs are done. Might as well use the RTC spinlock
to protect the refcount, as we need to take it anyway.

[Usama Arif: fixed rebase conflict]
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Usama Arif <usama.arif@bytedance.com>
---
 arch/x86/kernel/smpboot.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index dd2f61c3797f..2d5014752dc4 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -120,17 +120,22 @@ int arch_update_cpu_topology(void)
 	return retval;
 }
 
+
+static unsigned int smpboot_warm_reset_vector_count;
+
 static inline void smpboot_setup_warm_reset_vector(unsigned long start_eip)
 {
 	unsigned long flags;
 
 	spin_lock_irqsave(&rtc_lock, flags);
-	CMOS_WRITE(0xa, 0xf);
+	if (!smpboot_warm_reset_vector_count++) {
+		CMOS_WRITE(0xa, 0xf);
+		*((volatile unsigned short *)phys_to_virt(TRAMPOLINE_PHYS_HIGH)) =
+			start_eip >> 4;
+		*((volatile unsigned short *)phys_to_virt(TRAMPOLINE_PHYS_LOW)) =
+			start_eip & 0xf;
+	}
 	spin_unlock_irqrestore(&rtc_lock, flags);
-	*((volatile unsigned short *)phys_to_virt(TRAMPOLINE_PHYS_HIGH)) =
-							start_eip >> 4;
-	*((volatile unsigned short *)phys_to_virt(TRAMPOLINE_PHYS_LOW)) =
-							start_eip & 0xf;
 }
 
 static inline void smpboot_restore_warm_reset_vector(void)
@@ -142,10 +147,12 @@ static inline void smpboot_restore_warm_reset_vector(void)
 	 * to default values.
 	 */
 	spin_lock_irqsave(&rtc_lock, flags);
-	CMOS_WRITE(0, 0xf);
+	if (!--smpboot_warm_reset_vector_count) {
+		CMOS_WRITE(0, 0xf);
+		*((volatile u32 *)phys_to_virt(TRAMPOLINE_PHYS_LOW)) = 0;
+	}
 	spin_unlock_irqrestore(&rtc_lock, flags);
 
-	*((volatile u32 *)phys_to_virt(TRAMPOLINE_PHYS_LOW)) = 0;
 }
 
 /*
-- 
2.25.1

