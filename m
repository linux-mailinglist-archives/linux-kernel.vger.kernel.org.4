Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8EF469144D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 00:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjBIXYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 18:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjBIXYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 18:24:43 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F0A20059
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 15:24:42 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id b5so4689272plz.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 15:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=B3pPfVMpUiPSyCCzmCrD57AemmKpys6aCeZPw1vQkzc=;
        b=jgWwWwa7nwguVHP8E/H0kL40mtIJGHHQz64K8tE8/mv9uI/opH6H6e97FUaas0zr6f
         dr8+LAiVB1IFEqTn8CRHISEMxueB9PE/dctAB/0i6Pxp/8ZSJTVWiwBwd8ZcREB+t8bl
         Vuvz0dzZ890xH9YUzXBgVmR6nBlqgx8Z3n4m5/l4HcsHAADYr9K5MsP1E+v76RlhA87A
         iootOfpzAYK6GzPDIfn3gLxYiUOpHuMFSP4ZwgehL1mHbkpnuUe6q34DOnw2bZ6Mt28I
         lWUvXcevpy0UyWSB50Bm8EWjNlV2ITTlux2jSbPEa0gmjU5SWwpb0o27kEP3v76gFV4s
         jWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B3pPfVMpUiPSyCCzmCrD57AemmKpys6aCeZPw1vQkzc=;
        b=DH1rCdMudQAKIPOgkIO4CXGMpMVNSpyo8JwejTvZWa5P0dbLL5eUCtrX0WYmancZtY
         yimkIB5fxIN5/c0t1az6hqaH2dZWcMvetAlul6W6SUAD3U8zzKmPcE/4GPfRXFdAXeTS
         tayAnfhEtgufaZD/e5Fy46Sc/8jDtWYwv+W6wzpzlWdL6mbOWHhdYHNorEw2GY909o7f
         3Kf4JI4n1MXiiUXaFortY7Tv5rEbFp9wpzaGn/Qw5UXrflwI9WUTutyGkoE0SCokEDTo
         2FQhWicoCElTvLBx5vaCbx6mHhFzQp2Kfl0kQqcsDSFqEIWcwQD22a7VNDmE08B62KrN
         6FJw==
X-Gm-Message-State: AO0yUKV8BYNCF6Q9/FCpBoDdPRxVsD3y4oI8437CkjJUICX3AfkjBD/S
        Z9/uO9htKJubu0gJhoyeFJrBjA==
X-Google-Smtp-Source: AK7set/Q1MtO27htVLVMwKNv9osyKF2JaGo6dqafw5qA+gpYJFRK6skDPE8u0sHqFzi+/+dJlWJ1mg==
X-Received: by 2002:a17:903:2288:b0:19a:5939:51e3 with SMTP id b8-20020a170903228800b0019a593951e3mr5594520plh.24.1675985081800;
        Thu, 09 Feb 2023 15:24:41 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id e18-20020a170902ed9200b0019904abc93dsm2043766plj.250.2023.02.09.15.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 15:24:41 -0800 (PST)
Subject: [PATCH] clocksource/drivers/riscv: Refuse to probe on T-Head
Date:   Thu,  9 Feb 2023 15:23:02 -0800
Message-Id: <20230209232302.25658-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux@rivosinc.com, Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:         linux-riscv@lists.infradead.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

As of d9f15a9de44a ("Revert "clocksource/drivers/riscv: Events are
stopped during CPU suspend"") this driver no longer functions correctly
for the T-Head firmware.  That shouldn't impact any users, as we've got
a functioning driver that's higher priority, but let's just be safe and
ban it from probing at all.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
This feel super ugly to me, but I'm not sure how to do this more
cleanly.  I'm not even sure if it's necessary, but I just ran back into
the driver reviewing some other patches so I figured I'd say something.
---
 drivers/clocksource/timer-riscv.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index a0d66fabf073..d2d0236d1ae6 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -139,6 +139,22 @@ static int __init riscv_timer_init_dt(struct device_node *n)
 	if (cpuid != smp_processor_id())
 		return 0;
 
+	/*
+	 * The T-Head firmware does not route timer interrups to the core
+	 * during non-retentive suspend.  This is allowed by the specifications
+	 * (no interrupts are required to wake up the core during non-retentive
+	 * suspend), but most systems don't behave that way and Linux just
+	 * assumes that interrupts work.
+	 *
+	 * There's another timer for the T-Head sytems that behave this way
+	 * that is already probed by default, but just to be sure skip
+	 * initializing the SBI driver as it'll just break things later.
+	 */
+	if (sbi_get_mvendorid() == THEAD_VENDOR_ID) {
+		pr_debug_once("Skipping SBI timer on T-Head due to missed wakeups");
+		return 0;
+	}
+
 	domain = NULL;
 	child = of_get_compatible_child(n, "riscv,cpu-intc");
 	if (!child) {
-- 
2.39.1

