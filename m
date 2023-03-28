Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE16D6CCB1E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 21:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjC1T7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 15:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjC1T6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 15:58:38 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E2B1BC6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 12:58:03 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id e18so13401053wra.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 12:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680033482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XHD5cN+9NG2teoVVuOSus5vfOKvUrEkkcqEu7E43kuM=;
        b=ZWbGy/qB9O4uIXmbnFJPzgndZVBdjQ7fRWg0uO8JRvcFhlus0uhdFK85yQMon2+hSO
         Ih2Wuad+2T/mmT1ReIQ8AzXzEN4Hxo/5h5gvFLl/p9mYvN1NUYN/NNqXtZlRqcLhiAGd
         bK4JNMc7njvwdLhuMUDHpOQImnYK+97PG5LALvKK5WqgXgLC4EzHEGyk3E8j07YoebtM
         8N/QPVWvNnKs5om6hiI2QilQDcUi29GH4R+a6NFfomkEIZ8PeFU3l5xDhAtNZYFRoo2K
         fWKRYD4KdIaWpHtqTqbLn214mh6hCmJG67hDxryH+ErkUnM+o5jnnRs7F6+DfSLVp/t8
         rY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680033482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XHD5cN+9NG2teoVVuOSus5vfOKvUrEkkcqEu7E43kuM=;
        b=K4LfehT05lO5egFOds2IrLD5ohqRjtOTOKNSw6zLm7J7QCUjWQFejFxQtYnieubay5
         Jn0qDG5LBsmt4svmsXjmXubUO1T6InPwjLjQogeVFZzgX2sS0W9gPNcU8X5SNlhlpfFI
         ZLOlldb+6GZWSVjutooWS2bdgvMuo05wCiL7lvD7wapIIpwsGJSBFoXBO9UdEUqMAjGX
         VxzN0m57cHWlO974jsMb6FoxCByqGT6Y4GZvbqV+hbrUe0TLEpyQ57CzC/lcIRYyFLT/
         kZqn2cWz4+uHSkQq5uGSbx/+fHlN9O1jsInELA6yg4WZPgTLSTEPNVMGF7N3jkw1qH9u
         l6KA==
X-Gm-Message-State: AAQBX9fI+X/x2i27anq0PMEZcjF3pRzFD6z5UWbOAyMICmf63C6ml5QM
        3sF0k2IJYgUyIJ27yw1zy9ragw==
X-Google-Smtp-Source: AKy350a+CkM599ZmoWKEKahYxx4p6YM4cZDHr6OxnnBGr3OOYOjDokmLrgjI/ZkKjBeWoPEYwQ+P+w==
X-Received: by 2002:a05:6000:542:b0:2d1:7ade:aad with SMTP id b2-20020a056000054200b002d17ade0aadmr13593380wrf.31.1680033482442;
        Tue, 28 Mar 2023 12:58:02 -0700 (PDT)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6a:b566:0:8445:3123:91d7:959d])
        by smtp.gmail.com with ESMTPSA id z6-20020a056000110600b002c557f82e27sm28248386wrw.99.2023.03.28.12.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 12:58:02 -0700 (PDT)
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
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v17 2/8] cpu/hotplug: Reset task stack state in _cpu_up()
Date:   Tue, 28 Mar 2023 20:57:52 +0100
Message-Id: <20230328195758.1049469-3-usama.arif@bytedance.com>
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

Commit dce1ca0525bf ("sched/scs: Reset task stack state in bringup_cpu()")
ensured that the shadow call stack was reset and KASAN poisoning removed
from a CPU's stack each time that CPU is brought up, not just once.

This is not incorrect. However, with parallel bringup, an architecture
may obtain the idle thread for a new CPU from a pre-bringup stage, by
calling idle_thread_get() for itself. This would mean that the cleanup
in bringup_cpu() would be too late.

Move the SCS/KASAN cleanup to the generic _cpu_up() function instead,
which already ensures that the new CPU's stack is available, purely to
allow for early failure. This occurs when the CPU to be brought up is
in the CPUHP_OFFLINE state, which should correctly do the cleanup any
time the CPU has been taken down to the point where such is needed.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com> [arm64]
---
 kernel/cpu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 6c0a92ca6bb5..43e0a77f21e8 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -591,12 +591,6 @@ static int bringup_cpu(unsigned int cpu)
 	struct task_struct *idle = idle_thread_get(cpu);
 	int ret;
 
-	/*
-	 * Reset stale stack state from the last time this CPU was online.
-	 */
-	scs_task_reset(idle);
-	kasan_unpoison_task_stack(idle);
-
 	/*
 	 * Some architectures have to walk the irq descriptors to
 	 * setup the vector space for the cpu which comes online.
@@ -1383,6 +1377,12 @@ static int _cpu_up(unsigned int cpu, int tasks_frozen, enum cpuhp_state target)
 			ret = PTR_ERR(idle);
 			goto out;
 		}
+
+		/*
+		 * Reset stale stack state from the last time this CPU was online.
+		 */
+		scs_task_reset(idle);
+		kasan_unpoison_task_stack(idle);
 	}
 
 	cpuhp_tasks_frozen = tasks_frozen;
-- 
2.25.1

