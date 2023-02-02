Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4275D688966
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 22:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbjBBV5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 16:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbjBBV5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 16:57:18 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A79A728D5
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 13:56:38 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id q5so3042154wrv.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 13:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NSUUSSxTZ02F+r1LTVXNULWrMNdIZEEBIKeOIraHNX8=;
        b=jWrmnXctFoGJa9Wp7ZeU4q2i+NjqAJ2dYC96bkDbNz/V5jBzNy4cOuVK5EOPrnZJyq
         /vpwLO/s8e9/wVeW8Shg8jS//TmAwxBJVWnJJERRHdtvez1G1qiZ06wqhIYPy5MPxsSh
         8Vb/DlK4m4XAqJokCHT4pGnu7NU/zeYRJsgzo6YI6RkYQqHTnluKdmWVlUNAvqYCG/lx
         XbgH1M3MTSsxPWLBlAh6scMY/xpQ9kQph0tL23tJYJQUphfb617YuhPngBrGVzw5SWak
         msODHrjIlagSjaREHtgTxusON6vTobYmR2bISUHElyoTNfwIjvzehB94J43pAdYcCSKS
         XpFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NSUUSSxTZ02F+r1LTVXNULWrMNdIZEEBIKeOIraHNX8=;
        b=aGFEfyXRBqPN8E6XZTTZAnH1iPp+KdiJIU+a70A0IJDoYA2jkg1zAMUcvgtk8fKy5S
         Ihk8K0lshnY6IJZWAJkO88dzUt+UeGad7Uo6WBjdQytXymlbvSHw/muPwX4/XLnMb3UP
         3x1Fv/7xKpUwHGGD4N6/dGB55ETVEtanVFTBuymGpqyrskQRzS+qY9zN+OBwCE9ZR3HU
         G37OJrgkp24qKT/QcSKlMOsHy2nTDlRrB6F2zz696iPn+CF+EQAexWBGGuFVyXh1TeSs
         laEYDZ3RRjZ5zGej/wBXjjI79gTK35cZIrY/jCSV2PJr3Sex0arG0ySPv/xA2g6ui+24
         GIhA==
X-Gm-Message-State: AO0yUKW6nukoe2DjZ82Lhaqos2wss0uTIP9kfGOImNkk/jCDxp7l08QG
        QhreMaRjXSvkVaYJzzxkoINmSg==
X-Google-Smtp-Source: AK7set/9yN5ghqrWuDZorQQrjw852Sy0D4djdRmwnqCvLo9UBHVv1xA3/RZeoAeN/n5m675HyNZEbA==
X-Received: by 2002:a5d:6da3:0:b0:2bf:ae11:c40c with SMTP id u3-20020a5d6da3000000b002bfae11c40cmr8326498wrs.32.1675374996905;
        Thu, 02 Feb 2023 13:56:36 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6a:b566:0:98fe:e4ee:fc7e:cd71])
        by smtp.gmail.com with ESMTPSA id e8-20020a5d6d08000000b00297dcfdc90fsm506078wrq.24.2023.02.02.13.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 13:56:36 -0800 (PST)
From:   Usama Arif <usama.arif@bytedance.com>
To:     dwmw2@infradead.org, tglx@linutronix.de, arjan@linux.intel.com
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, x86@kernel.org, pbonzini@redhat.com,
        paulmck@kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, rcu@vger.kernel.org, mimoja@mimoja.de,
        hewenliang4@huawei.com, thomas.lendacky@amd.com, seanjc@google.com,
        pmenzel@molgen.mpg.de, fam.zheng@bytedance.com,
        punit.agrawal@bytedance.com, simon.evans@bytedance.com,
        liangma@liangbit.com, David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH v6 07/11] x86/smpboot: Disable parallel boot for AMD CPUs
Date:   Thu,  2 Feb 2023 21:56:21 +0000
Message-Id: <20230202215625.3248306-8-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230202215625.3248306-1-usama.arif@bytedance.com>
References: <20230202215625.3248306-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Woodhouse <dwmw@amazon.co.uk>

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/include/asm/cpufeatures.h |  1 +
 arch/x86/kernel/cpu/amd.c          | 11 +++++++++++
 arch/x86/kernel/smpboot.c          | 13 +++++++++++--
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 61012476d66e..ed7f32354edc 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -466,5 +466,6 @@
 #define X86_BUG_MMIO_UNKNOWN		X86_BUG(26) /* CPU is too old and its MMIO Stale Data status is unknown */
 #define X86_BUG_RETBLEED		X86_BUG(27) /* CPU is affected by RETBleed */
 #define X86_BUG_EIBRS_PBRSB		X86_BUG(28) /* EIBRS is vulnerable to Post Barrier RSB Predictions */
+#define X86_BUG_NO_PARALLEL_BRINGUP	X86_BUG(29) /* CPU has hardware issues with parallel AP bringup */
 
 #endif /* _ASM_X86_CPUFEATURES_H */
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index f769d6d08b43..19b5c8342d7e 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -941,6 +941,17 @@ static void init_amd(struct cpuinfo_x86 *c)
 	case 0x19: init_amd_zn(c); break;
 	}
 
+	/*
+	 * Various AMD CPUs appear to not to cope with APs being brought up
+	 * in parallel. In debugging, the AP doesn't even seem to reach an
+	 * outb to port 0x3f8 right at the top of the startup trampoline.
+	 * We don't *think* there are any remaining software issues which
+	 * may contribute to this, although it's possible. So far, attempts
+	 * to get AMD to investigate this have been to no avail. So just
+	 * disable parallel bring up for all AMD CPUs for now.
+	 */
+	set_cpu_bug(c, X86_BUG_NO_PARALLEL_BRINGUP);
+
 	/*
 	 * Enable workaround for FXSAVE leak on CPUs
 	 * without a XSaveErPtr feature
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 741da8d306a4..656897b055f5 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1534,13 +1534,22 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 	 * We can do 64-bit AP bringup in parallel if the CPU reports its
 	 * APIC ID in CPUID leaf 0x0B. Otherwise it's too hard. And not
 	 * for SEV-ES guests because they can't use CPUID that early.
-	 * Also, some AMD CPUs crash when doing parallel cpu bringup, disable
-	 * it for all AMD CPUs to be on the safe side.
 	 */
 	if (IS_ENABLED(CONFIG_X86_32) || boot_cpu_data.cpuid_level < 0x0B ||
 	    cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
 		do_parallel_bringup = false;
 
+	/*
+	 * Various AMD CPUs appear not to cope with APs being brought up
+	 * in parallel, so just disable parallel bring up for all AMD CPUs
+	 * for now.
+	 */
+	if (do_parallel_bringup &&
+	    boot_cpu_has_bug(X86_BUG_NO_PARALLEL_BRINGUP)) {
+		pr_info("Disabling parallel bringup due to CPU bugs\n");
+		do_parallel_bringup = false;
+	}
+
 	snp_set_wakeup_secondary_cpu();
 }
 
-- 
2.25.1

