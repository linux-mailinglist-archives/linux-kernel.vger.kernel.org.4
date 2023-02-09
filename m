Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69665690D57
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 16:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbjBIPnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 10:43:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbjBIPmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 10:42:47 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5296466D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 07:42:09 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so4182936wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 07:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+ne+m/jA9f2Vf5iapwS72QpCbb1ZulqNbxU7adH9sw=;
        b=5ayItAXXkr2LKM0D15OvuWaDbJN5E6hG9PHeXml42YtZ9TzV7Oy1fg6JVKJD8Tsnyo
         l9LhMel+mSwzxjR5+pEhTg+DpFouf58cA4eNvbULMQftW7EozDC5VCykpNI9Ocy7KXRk
         7eG8LL/leNth8VaJoRqsJTWOPqaM6XCcNxeiFCQnUeIUF03iCQjbujUjBJn12VHAc4lU
         Gw6IwrZNO2Ui/nif1Az4vFjsyNxP2tTuj0gjA6Ce+qnzGLOd3UDIZTT5GtbmHuPD7Z+n
         hGt1M2hhbyF+88D//Z3+cn9/RwJ1t5CW2S5BuMbYZgwb9NjL15ueESBzmfp7CgCCixFX
         55Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+ne+m/jA9f2Vf5iapwS72QpCbb1ZulqNbxU7adH9sw=;
        b=7wROVEyX6NfBhVVMDBF7TPS+9nX0tt3ngelASGSUTBtIhP9nir7B+5uxMT/mEemz88
         QLItHkeZaLS8RlP3nwkrmXjsfsZe3ZRUL9zwyWvm80gh4HXMkgxvZGVnNTADPcGyjY21
         wujafzoB9hBLTDWcKL+7dI9KsTfhG8IsMZjns6E++xd5cbmLvX7QRYdPOqNiJV/juP1p
         f9Va9i5JvW7AXwThOFu4pqofe2xfjMZsE7bEjassYcNmyeqUDw2jc63Xd/ud+/FeCqzB
         s19rnWhNOIQoqffGzOU/KyD0X7VVQ3OHGaRDoRp+AWEknTUQcdgT4L4iuBf432Z7VVkH
         t29A==
X-Gm-Message-State: AO0yUKVm3d+a/Myfwk3aZAF2rvqvSEiSyi9FtlmDTwvxOoWB6W0BXwN6
        OEmuf9UAPennuY7BpgDlF5AlxQ==
X-Google-Smtp-Source: AK7set+GqBqgMlsZlVYdxi0QFHXkVKasyOlU5H/1rZSutO+k6I5qgjE5zwRQlznc0/b9wFiBgjmrEQ==
X-Received: by 2002:a05:600c:755:b0:3dc:4b87:a570 with SMTP id j21-20020a05600c075500b003dc4b87a570mr11538710wmn.35.1675957328115;
        Thu, 09 Feb 2023 07:42:08 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6a:b566:0:8009:2525:9580:8db2])
        by smtp.gmail.com with ESMTPSA id y6-20020a05600c364600b003df7b40f99fsm5099754wmq.11.2023.02.09.07.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 07:42:07 -0800 (PST)
From:   Usama Arif <usama.arif@bytedance.com>
To:     dwmw2@infradead.org, tglx@linutronix.de, kim.phillips@amd.com
Cc:     arjan@linux.intel.com, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, x86@kernel.org,
        pbonzini@redhat.com, paulmck@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        rcu@vger.kernel.org, mimoja@mimoja.de, hewenliang4@huawei.com,
        thomas.lendacky@amd.com, seanjc@google.com, pmenzel@molgen.mpg.de,
        fam.zheng@bytedance.com, punit.agrawal@bytedance.com,
        simon.evans@bytedance.com, liangma@liangbit.com,
        David Woodhouse <dwmw@amazon.co.uk>,
        Usama Arif <usama.arif@bytedance.com>
Subject: [PATCH v8 8/9] x86/mtrr: Avoid repeated save of MTRRs on boot-time CPU bringup
Date:   Thu,  9 Feb 2023 15:41:55 +0000
Message-Id: <20230209154156.266385-9-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230209154156.266385-1-usama.arif@bytedance.com>
References: <20230209154156.266385-1-usama.arif@bytedance.com>
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

There's no need to repeatedly save the BSP's MTRRs for each AP being
brought up at boot time. And no need to use smp_call_function_single()
even for the one time they do need to be saved.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Usama Arif <usama.arif@bytedance.com>
---
 arch/x86/kernel/cpu/mtrr/mtrr.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 783f3210d582..b6eae3ad4414 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -721,11 +721,20 @@ void __init mtrr_bp_init(void)
  */
 void mtrr_save_state(void)
 {
+	static bool mtrr_saved;
 	int first_cpu;
 
 	if (!mtrr_enabled())
 		return;
 
+	if (system_state < SYSTEM_RUNNING) {
+		if (!mtrr_saved) {
+			mtrr_save_fixed_ranges(NULL);
+			mtrr_saved = true;
+		}
+		return;
+	}
+
 	first_cpu = cpumask_first(cpu_online_mask);
 	smp_call_function_single(first_cpu, mtrr_save_fixed_ranges, NULL, 1);
 }
-- 
2.25.1

