Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4584D6CCB13
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 21:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjC1T6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 15:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjC1T6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 15:58:37 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092873C07
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 12:58:02 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id l27so13423348wrb.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 12:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680033481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYvh1s2ZCo/2BwztG9fqIEjBvGQeOoHd9NlNhXt+v68=;
        b=k8IGY8FXbInHectY0rZvxlmn9L+tWhj0zGMBI7O8Ql7u5Z4ceqiRTB2gFHXzX2MGac
         11Z1JyFHrbV8fvIa+MAjKzA7iwoBsywMYXQmCkw1YR9M/QCiAyPisYIf4KnzupN1aUem
         dp8cS3tDEW7nzZxeIPhDTU4ElIXhJxIq0aVNmA02eRT7Ce93WjhGheAezSTwl3W6MPEZ
         hmsobvHyyWuFgl6GiC+yg1kK6M+/utjCkVtO4wdmAf/UGD63kd09EGWJnfQxbrAt9pmu
         y6fATlkNrGrpADFnsb/jR/Eo/Qmk8HCJuuDAM+66SjQKUCjmusTD7fvQuvwUhUyXARQk
         nwPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680033481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PYvh1s2ZCo/2BwztG9fqIEjBvGQeOoHd9NlNhXt+v68=;
        b=c7Utn8x9x3MntLPOcwcoagYX5ImxqLpZFXwtRboku6lGXgm7sQiPIgR1J8cdNUrNTX
         POE04LBIDwPp/k4SUffvWrEYTRtxJnckRIKJnaTZL3wnB57WohUys8IRLnujUyz70pyu
         +vQMgcYZ1lP3DTgXH+OqZN13sFkooRkJANX3p/jaFcQJNFpZ5C3FB/6dnEfzOSOE51J8
         PO8KLipC6K2hCnQzvhoOhNBkKLOE1foNy44FRxZhHBXDK8dR4BV+X/mj2gJAvJvyhgVY
         VFtex9R4HE9t5PAPD8PSIkUCfaIJREvezZhbdhNDmHy9SQZ7jzEfivFUrkpa0e400hZa
         zykg==
X-Gm-Message-State: AAQBX9dKLolVlGv2WSdc+piXCipy5GSnuThSF3QhCmz099P+rpwLH3gV
        hOG8h2u14UjDnX1EROR1FzqyTQ==
X-Google-Smtp-Source: AKy350Y5RvAESxe4hLG/sTeNGiybz+f/imU5YRREC5r9As0LNEwIOPdnGUldjcK/izlEsaSCOMvdsg==
X-Received: by 2002:adf:f982:0:b0:2d6:5afe:7b99 with SMTP id f2-20020adff982000000b002d65afe7b99mr14282352wrr.10.1680033481472;
        Tue, 28 Mar 2023 12:58:01 -0700 (PDT)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6a:b566:0:8445:3123:91d7:959d])
        by smtp.gmail.com with ESMTPSA id z6-20020a056000110600b002c557f82e27sm28248386wrw.99.2023.03.28.12.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 12:58:00 -0700 (PDT)
From:   Usama Arif <usama.arif@bytedance.com>
To:     dwmw2@infradead.org, tglx@linutronix.de, kim.phillips@amd.com,
        brgerst@gmail.com
Cc:     piotrgorski@cachyos.org, oleksandr@natalenko.name,
        arjan@linux.intel.com, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, x86@kernel.org,
        pbonzini@redhat.com, paulmck@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        rcu@vger.kernel.org, mimoja@mimoja.de, hewenliang4@huawei.com,
        thomas.lendacky@amd.com, seanjc@google.com, pmenzel@molgen.mpg.de,
        fam.zheng@bytedance.com, punit.agrawal@bytedance.com,
        simon.evans@bytedance.com, liangma@liangbit.com,
        gpiccoli@igalia.com, David Woodhouse <dwmw@amazon.co.uk>,
        Usama Arif <usama.arif@bytedance.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v17 1/8] cpu/hotplug: Move idle_thread_get() to <linux/smpboot.h>
Date:   Tue, 28 Mar 2023 20:57:51 +0100
Message-Id: <20230328195758.1049469-2-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230328195758.1049469-1-usama.arif@bytedance.com>
References: <20230328195758.1049469-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Tested-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Kim Phillips <kim.phillips@amd.com>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com> [arm64]
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

