Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E301679D55
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 16:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234692AbjAXPXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 10:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbjAXPXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 10:23:32 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EECF2C659
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 07:23:22 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id z9-20020a17090a468900b00226b6e7aeeaso14342080pjf.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 07:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDh4QTzHw/7wfcqru+uyNm9ezOu9lq8rt7xeGWJhJ/0=;
        b=Wh6rAVMgDCwlzYMbxMaV3w2L+dwCKP6nCm117xKOJiHgJhOOY8zg0FuEITs7LG5a3G
         jllbBFRKQ3jznMmLhE2V37Bn3i59awGGaoiQi39KyI/uTGtgpwPfJ7ahKnttxntdkKDF
         GcUyB5KiMugWNhV1b3IxKJjKEjFcSvc2tfMTcuim05X5AkNtB7E59T5OG7tTDZOOJfgf
         lgrLzoXtsIRWqDmDJOm3DJ29aXTw2VNt1zRSCs4pmvF8XdpX8l8I8K15fskZGQeWhjUg
         7yEoqNXHVyM12BEl7hRDaOGbYFq5f9yrfNAD5WWQry+gmGcoRxxvLD/Z2C1iz68JfJDi
         IhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EDh4QTzHw/7wfcqru+uyNm9ezOu9lq8rt7xeGWJhJ/0=;
        b=YCL7Yb6ZTi/JUdRDI+IIGcYAuM9WLc+M+dFnglc7UluQqXIONEoviJLw3ufb3Nj0yA
         fT2j2ldDOYn4fP81iahCCga8mRty2RH0h9X4JTkH8QFstbvN9Ad9AKF5J0qchDMO6V7m
         lznz0jkTEDuTRXqN99F7V4lI4yxHb7l8FTNuHSeOCBJepcot2rAgUog2TXIYNRS/MBzp
         IM3HA68FDcrGh99bIAPxQCt5j7O2cuK71da+PIDzE4ckyY4YSvXocc4kewFWf7zrn5wc
         Or7sKtMf/7WQs3nhqRXiGzN7B/JdhgQKaHu0T2ZgkFG3s0gTnEpczc7OVbpvyfO4Oc0J
         6Y3A==
X-Gm-Message-State: AFqh2kr4P/KHqrYoRako6TwILybKWtjYdRg5WTFK93l1pVMBcoqdQQ+D
        D14y+YEygYK5/3/ofQFp/deGVmIJD0V04hbU
X-Google-Smtp-Source: AMrXdXuqmoj89+Uu74kc/T4pp6nJ4liQskksdNJ+RFHVJDvvBBXStdsQjHDN3YzMRsAeNjihiEMA7w==
X-Received: by 2002:a17:902:848d:b0:189:f460:d24b with SMTP id c13-20020a170902848d00b00189f460d24bmr7108780plo.5.1674573801641;
        Tue, 24 Jan 2023 07:23:21 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id c1-20020a170902aa4100b001960441f604sm1778542plr.277.2023.01.24.07.23.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 07:23:21 -0800 (PST)
Message-ID: <560c844c-f128-555b-40c6-31baff27537f@kernel.dk>
Date:   Tue, 24 Jan 2023 08:23:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] x86/fpu: don't set TIF_NEED_FPU_LOAD for PF_IO_WORKER threads
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't set it on PF_KTHREAD threads as they never return to userspace,
and PF_IO_WORKER threads are identical in that regard. As they keep
running in the kernel until they die, skip setting the FPU flag on them.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

Not urgent, more of a cosmetic thing that was found while debugging and
issue and pondering why the FPU flag is set on these threads.

diff --git a/arch/x86/include/asm/fpu/sched.h b/arch/x86/include/asm/fpu/sched.h
index b2486b2cbc6e..c2d6cd78ed0c 100644
--- a/arch/x86/include/asm/fpu/sched.h
+++ b/arch/x86/include/asm/fpu/sched.h
@@ -39,7 +39,7 @@ extern void fpu_flush_thread(void);
 static inline void switch_fpu_prepare(struct fpu *old_fpu, int cpu)
 {
 	if (cpu_feature_enabled(X86_FEATURE_FPU) &&
-	    !(current->flags & PF_KTHREAD)) {
+	    !(current->flags & (PF_KTHREAD | PF_IO_WORKER))) {
 		save_fpregs_to_fpstate(old_fpu);
 		/*
 		 * The save operation preserved register state, so the
diff --git a/arch/x86/kernel/fpu/context.h b/arch/x86/kernel/fpu/context.h
index 958accf2ccf0..9fcfa5c4dad7 100644
--- a/arch/x86/kernel/fpu/context.h
+++ b/arch/x86/kernel/fpu/context.h
@@ -57,7 +57,7 @@ static inline void fpregs_restore_userregs(void)
 	struct fpu *fpu = &current->thread.fpu;
 	int cpu = smp_processor_id();
 
-	if (WARN_ON_ONCE(current->flags & PF_KTHREAD))
+	if (WARN_ON_ONCE(current->flags & (PF_KTHREAD | PF_IO_WORKER)))
 		return;
 
 	if (!fpregs_state_valid(fpu, cpu)) {
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 9baa89a8877d..2babc537ff36 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -426,7 +426,7 @@ void kernel_fpu_begin_mask(unsigned int kfpu_mask)
 
 	this_cpu_write(in_kernel_fpu, true);
 
-	if (!(current->flags & PF_KTHREAD) &&
+	if (!(current->flags & (PF_KTHREAD | PF_IO_WORKER)) &&
 	    !test_thread_flag(TIF_NEED_FPU_LOAD)) {
 		set_thread_flag(TIF_NEED_FPU_LOAD);
 		save_fpregs_to_fpstate(&current->thread.fpu);

-- 
Jens Axboe

