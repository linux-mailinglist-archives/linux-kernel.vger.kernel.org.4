Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF9A68E42F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 00:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjBGXFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 18:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjBGXFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 18:05:09 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28383EC53
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 15:04:43 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id l37-20020a05600c1d2500b003dfe46a9801so221564wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 15:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKydoXD7DOLwoETiq1rVpdNfhGCr3/VFLGt4p4rSeXA=;
        b=Hzld0/JklLKS5ElmGesXwglnkEAxlghpu5u+RXXd8eLsmOBqmKGgmg/qpnGfZqokHq
         xUsE3XHUe3Wb5Gb04q1hiJbGh7DRco334Cn/d4qz0EKEFguht/H01YPLaE854A+cMzQc
         1ScdgN27hmzjlVkkipBYathx6d0cXlkCEVlowZvJ45FYP7K7RKFDR1CZh3oiqnt2Lbmo
         XwDNLs+HdrccUIMu2IPnOs7QW6S/uDGFi+dhru1+sk9ik7jGDE/wwEcNfVVxnes8Ss/5
         qjNvJ4ZvZqZ3z1vzSsH3pSwX5od8kU5TKKyoIXJqigf0F0ci353HD5n6dEL1bbiOyOHx
         wK2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XKydoXD7DOLwoETiq1rVpdNfhGCr3/VFLGt4p4rSeXA=;
        b=j82Ha1OS4v7/xGtoTKMhFwxuGI/aLNbpNGyQxjQs9+D802K/PVFhY+fHe9wfZofDVR
         lkEFAKcGjtDrKl+BOFle9lj7q/JYGa5ZjxkpSznatzPLxvf7817FkEdHvA1iNpIk12NN
         k21hbUdIiy8651URtyp2ZCi4SHWM18Z4A4kra4/odcpb0yxdG33SgxBom96YoKXB3XJ1
         BJC5No1NdW1qzKruwa8SO1q8Royy2yFdvF/13w5Uve+pnnmRgxWYvZttG0XS8q94zMb3
         UsNGa1qMrz0OwSS6XpxPysj9r5k83ycgjcOpBMKJSdxuGDi8DG1b+LnOCmYgW2ptRj8q
         1p8A==
X-Gm-Message-State: AO0yUKXrW4+odtFmW2cOTFAmnc5gLOu+WTBhGWuTsSkvjkYFYGsAK72R
        q+m5Ryfn0dOoM/L5JTjjyAY0Wg==
X-Google-Smtp-Source: AK7set9c8L6aumK33tjgdEopAewE6C0P1FgDfkNb/uvby9cgaEWK0kTU1mfF+aP4S24qfg7jvMcXmQ==
X-Received: by 2002:a05:600c:319d:b0:3df:e1cc:94ff with SMTP id s29-20020a05600c319d00b003dfe1cc94ffmr4565048wmp.28.1675811082324;
        Tue, 07 Feb 2023 15:04:42 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6a:b566:0:c04f:2463:c151:8b87])
        by smtp.gmail.com with ESMTPSA id j14-20020a05600c190e00b003dcc82ce53fsm146485wmq.38.2023.02.07.15.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 15:04:41 -0800 (PST)
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
Subject: [PATCH v7 2/9] cpu/hotplug: Move idle_thread_get() to <linux/smpboot.h>
Date:   Tue,  7 Feb 2023 23:04:29 +0000
Message-Id: <20230207230436.2690891-3-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230207230436.2690891-1-usama.arif@bytedance.com>
References: <20230207230436.2690891-1-usama.arif@bytedance.com>
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

