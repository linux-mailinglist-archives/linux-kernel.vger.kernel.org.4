Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742DF68895D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 22:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbjBBV50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 16:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbjBBV5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 16:57:11 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECBB70D6E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 13:56:35 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id r2so2987058wrv.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 13:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1t64Rjr6YniyNyrn83Uc/qtpVNvig4MY0wcaZ4A3opU=;
        b=XUy0x/p5QdV4qoA/2HTEBNCjHnhO7mdM58DCWfmzoZFW5rDKNboAfZ6LAtzKpomG55
         eM0FkVsak3pwWr+bZ1NlxDE5LtDtZ6RVEH2qyvRxBe9aSM+bOCJ+ERXyo7ZLACdgGJH6
         QAEGDDoSkk9+UDVcm3SrAo4Gl8UrrPERgu+cOQIQ1w00v8K19tm2ECCUullLs9vKvgEG
         QFPt14rCMgFr7zH5aIQmbVtfcb31sL+nARVUnFY14ZcOJufopoIACFr/WrOU+NSItQkT
         odm+Y9mrXFoFGiJglBNIH7vaG2MUNECtaO4+JYyT25LuQ0Uqy2JJcpOeFJa828ZmtNqY
         TnQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1t64Rjr6YniyNyrn83Uc/qtpVNvig4MY0wcaZ4A3opU=;
        b=7NpQvRQ56OlmcH5wOYvheQHkZxwyD57rsFlDbJWK5cmkw+EN2k0LOEC8JSblzGAxXf
         bdxnozlD4meyyP3XbIKv62AUmc1umOrcZQsR/nIydxJaBONdegHsAFQjExfpJUNA9aww
         Opq6jXOHQQrRh2DP11eNBmZN0KuevS1ZRWjKMSusivbKRPofgaJ1U9P1jZvwEEdoxoBo
         kz4Oq+zNVewEO8hQrmd5M8g+/Y+hxR/+vsJrjvbTiQOtYIgyClaunheyQ2zpOJcOQcUI
         MiprB++Ob5t2YGiuEnuYUL9KgpjKkSkFrE784jGOtXXhO8kgB4wVjs2350ZF+HDdNWdj
         5YsQ==
X-Gm-Message-State: AO0yUKXheDC5H8EAPYSHV9JNW/B/ZUMtp7+bHti/rX61T1RNIdKrDx1Y
        rL6bA7ndsekz4YaSZOZvBF2GlA==
X-Google-Smtp-Source: AK7set/Tzuk1pup5X5DbXmzNAR6IAsywDbfOSmfLHghr7XczYMK1unGT14oz/9LddPx5eGlauvntHA==
X-Received: by 2002:adf:fa84:0:b0:2bf:e449:e72a with SMTP id h4-20020adffa84000000b002bfe449e72amr6584290wrr.60.1675374994014;
        Thu, 02 Feb 2023 13:56:34 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6a:b566:0:98fe:e4ee:fc7e:cd71])
        by smtp.gmail.com with ESMTPSA id e8-20020a5d6d08000000b00297dcfdc90fsm506078wrq.24.2023.02.02.13.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 13:56:33 -0800 (PST)
From:   Usama Arif <usama.arif@bytedance.com>
To:     dwmw2@infradead.org, tglx@linutronix.de, arjan@linux.intel.com
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, x86@kernel.org, pbonzini@redhat.com,
        paulmck@kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, rcu@vger.kernel.org, mimoja@mimoja.de,
        hewenliang4@huawei.com, thomas.lendacky@amd.com, seanjc@google.com,
        pmenzel@molgen.mpg.de, fam.zheng@bytedance.com,
        punit.agrawal@bytedance.com, simon.evans@bytedance.com,
        liangma@liangbit.com, David Woodhouse <dwmw@amazon.co.uk>,
        Usama Arif <usama.arif@bytedance.com>
Subject: [PATCH v6 04/11] x86/smpboot: Reference count on smpboot_setup_warm_reset_vector()
Date:   Thu,  2 Feb 2023 21:56:18 +0000
Message-Id: <20230202215625.3248306-5-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230202215625.3248306-1-usama.arif@bytedance.com>
References: <20230202215625.3248306-1-usama.arif@bytedance.com>
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
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 arch/x86/kernel/smpboot.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 55cad72715d9..a19eddcdccc2 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -121,17 +121,22 @@ int arch_update_cpu_topology(void)
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
@@ -143,10 +148,12 @@ static inline void smpboot_restore_warm_reset_vector(void)
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

