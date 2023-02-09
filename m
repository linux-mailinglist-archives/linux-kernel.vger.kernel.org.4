Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF32690D4B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 16:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbjBIPmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 10:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjBIPm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 10:42:28 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8972367F
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 07:42:02 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id j32-20020a05600c1c2000b003dc4fd6e61dso4168597wms.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 07:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKydoXD7DOLwoETiq1rVpdNfhGCr3/VFLGt4p4rSeXA=;
        b=2CVH9cp3pr0dhjoEe5Lh7i3BSbemsRr/OqAzKsploHApi7J03BEPBfBch4bLbqTSIA
         pjBpDpcdmOx7wc551tUDnwQOY6GyXzohRPqZ3VpIcB0CvhrwGpteU67ei1o2yD6q2eoq
         RxrEFY/smCKBaIyQa/vshAcR3v1M/3Y8CyZuY4LWwEjDq/KAxxSGVypXyMSXwS4Y6TKG
         M553wANc1uTwq1xbrCGxwwZrb3j381XzlyCd7cOS50+ujMsP4WKzO2/MfDzSIGGDwq6R
         DOFaT97zoZP3cBxt7kpar0m0CJVluRA+D1wcwNrF/zaNlwcFQ7IAp1MlcUzkkqgTz8gL
         uCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XKydoXD7DOLwoETiq1rVpdNfhGCr3/VFLGt4p4rSeXA=;
        b=EQIiwT+gW3nCoy/amnEjqByNKEECo9iPmTKcsU5c2Q8J5GFEJkyNAsg9yC0JUV70hM
         RZCz2ilqSqtsv6NPECFzZn2vtTuqEx0im3mRY4P2kXVpveoGnFmoovinanIPuGL282TY
         +8MSVLAqVXwRIj65yPOuCswt4PRHvFum3Pa8dVGO5Ppw/1ibgzrL8q7t/byGJ9+8uvOg
         aKYlwtKtMad67mRVJhZfYbqv1mnQ+NZCPj56RYay7ZfIH9kLBBjoADT3K9oIxi7PCatU
         Y2Hu7AoV+ZlqlMjELLeaBkvg4vOObKpFg2hlu4+IuPVIhf3VTY+8TE/Da7I6l+WU9DEw
         3L1g==
X-Gm-Message-State: AO0yUKXWkHGDZG2UubhxyeLIAxNd6BeAvtpVBOkVx1vX3i/FGKCTcwsV
        PbpkI2VPAHYPH7PDJoeD/LoKzA==
X-Google-Smtp-Source: AK7set9HcQn5njNfZ89WKBa5SFul8SUdp0kexugSeUAJLkuJUAocQZDht+khT1NSCYygFgM0B3hlaA==
X-Received: by 2002:a05:600c:1713:b0:3da:fb3c:c1ab with SMTP id c19-20020a05600c171300b003dafb3cc1abmr10420659wmn.0.1675957321622;
        Thu, 09 Feb 2023 07:42:01 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6a:b566:0:8009:2525:9580:8db2])
        by smtp.gmail.com with ESMTPSA id y6-20020a05600c364600b003df7b40f99fsm5099754wmq.11.2023.02.09.07.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 07:42:01 -0800 (PST)
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
Subject: [PATCH v8 2/9] cpu/hotplug: Move idle_thread_get() to <linux/smpboot.h>
Date:   Thu,  9 Feb 2023 15:41:49 +0000
Message-Id: <20230209154156.266385-3-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230209154156.266385-1-usama.arif@bytedance.com>
References: <20230209154156.266385-1-usama.arif@bytedance.com>
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

Instead of relying purely on the special-case wrapper in bringup_cpu()
to pass the idle thread to __cpu_up(), expose idle_thread_get() so that
the architecture code can obtain it directly when necessary.

This will be useful when the existing __cpu_up() is split into multiple
phases, only *one* of which will actually need the idle thread.

If the architecture code is to register its new pre-bringup states with
the cpuhp core, having a special-case wrapper to pass extra arguments is
non-trivial and it's easier just to let the arch register its function
pointer to be invoked with the standard API.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Usama Arif <usama.arif@bytedance.com>
---
 include/linux/smpboot.h | 7 +++++++
 kernel/smpboot.h        | 2 --
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/smpboot.h b/include/linux/smpboot.h
index 9d1bc65d226c..3862addcaa34 100644
--- a/include/linux/smpboot.h
+++ b/include/linux/smpboot.h
@@ -5,6 +5,13 @@
 #include <linux/types.h>
 
 struct task_struct;
+
+#ifdef CONFIG_GENERIC_SMP_IDLE_THREAD
+struct task_struct *idle_thread_get(unsigned int cpu);
+#else
+static inline struct task_struct *idle_thread_get(unsigned int cpu) { return NULL; }
+#endif
+
 /* Cookie handed to the thread_fn*/
 struct smpboot_thread_data;
 
diff --git a/kernel/smpboot.h b/kernel/smpboot.h
index 34dd3d7ba40b..60c609318ad6 100644
--- a/kernel/smpboot.h
+++ b/kernel/smpboot.h
@@ -5,11 +5,9 @@
 struct task_struct;
 
 #ifdef CONFIG_GENERIC_SMP_IDLE_THREAD
-struct task_struct *idle_thread_get(unsigned int cpu);
 void idle_thread_set_boot_cpu(void);
 void idle_threads_init(void);
 #else
-static inline struct task_struct *idle_thread_get(unsigned int cpu) { return NULL; }
 static inline void idle_thread_set_boot_cpu(void) { }
 static inline void idle_threads_init(void) { }
 #endif
-- 
2.25.1

