Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4716D74D747
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 15:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjGJNTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 09:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjGJNTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:19:23 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EF2D7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 06:19:21 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-7869bcee569so143393139f.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 06:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1688995160; x=1691587160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/mpcltcpfYZvMxozrUvDAlbbzSsEYse6Dp8FAFYE/Y=;
        b=pRM4SRhC4BcC6WvkfHp+9VQNMx6pEMQAigYEXFZhUYg/EBNumEgM1yRXhES0h3SB1x
         LFG9Pl70z8JZfd9PsuS/fPLoS0eYU/K2qveVgJ7alZOH58YAEyKLaguGygZVvOXsg9JC
         gBxXoKeHRtQ6KoWEM6zIz9zS+GvY//ChCT/Ugwf0WgFoD/qNI7rAAefnCkPODN0qAiBL
         kZdsp3E8MYdIskT5ybqqiKd/VZcOun+x5+MjXxII6cd0l308e3pwsGyKOQCQGSs/MTCV
         TcNWuw150Dv3iwE+djEW2gNS8O2vCt9wwhWTQt2mlfFgopnH342mqUw5XotHgy2g/2jp
         zymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688995160; x=1691587160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h/mpcltcpfYZvMxozrUvDAlbbzSsEYse6Dp8FAFYE/Y=;
        b=bkAFkZoy+W1lB8Jeke15h5ZpkBwU2nmPQI4FjsW9XlQOTfBr261REnq2maxACBadSz
         UoqFTlq9kIsjfegH+VVFpEx1qg3lUkVBkGVKXfoPBgXZi5jrlyK+PWkpo+rGbNTCEQc1
         ZbAtVizl2xrW++/h/xTmf9ImJEe9lZe4OFxQiY923lhUm4Nln3tEdMNxqzxExnRLzHIO
         kwl8VUg2/IoteKhobNSQ8tXq4Er1WqZ8xuKii91sQrUUWPqFmaUeQnaXkEbFxThj5nAQ
         +nl79GPPCrLKNXMPOFSDghzpCCQpCvK9v/nLMn9EP89xv1R+R46k9VXJtFWWyhLkV8MA
         zjSg==
X-Gm-Message-State: ABy/qLaz48zSMUsoB3vIvR43z6owbFsyUkdpskeH+7AW/pfMbobv0v+8
        stwT+E2UMkaMWd8w/d2y4kkQQA==
X-Google-Smtp-Source: APBJJlHEKKAe5FMXwjfaffR8jMAuyuZBXmIS2Nm5cTFlKw8kRCpjNg3NP95fiNXB9KaNPlz5bW1Itg==
X-Received: by 2002:a6b:dc16:0:b0:786:2c7d:dd19 with SMTP id s22-20020a6bdc16000000b007862c7ddd19mr12338002ioc.17.1688995160268;
        Mon, 10 Jul 2023 06:19:20 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id q14-20020a5d9f0e000000b0077a1b6f73b9sm3643242iot.41.2023.07.10.06.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 06:19:20 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Conor Dooley <conor@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 1/2] clocksource: timer-riscv: Don't enable/disable timer interrupt
Date:   Mon, 10 Jul 2023 18:49:01 +0530
Message-Id: <20230710131902.1459180-2-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230710131902.1459180-1-apatel@ventanamicro.com>
References: <20230710131902.1459180-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, we enable/disable timer interrupt at runtime to start/stop
timer events. This makes timer interrupt state go out-of-sync with
the Linux interrupt subsystem.

To address the above issue, we can stop a per-HART timer interrupt
by setting U64_MAX in timecmp CSR (or sbi_set_timer()) at the time
of handling timer interrupt.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/clocksource/timer-riscv.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index da3071b387eb..f2ea2b3d2d43 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -22,6 +22,7 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/interrupt.h>
 #include <linux/of_irq.h>
+#include <linux/limits.h>
 #include <clocksource/timer-riscv.h>
 #include <asm/smp.h>
 #include <asm/hwcap.h>
@@ -31,12 +32,22 @@
 static DEFINE_STATIC_KEY_FALSE(riscv_sstc_available);
 static bool riscv_timer_cannot_wake_cpu;
 
+static void riscv_clock_event_stop(void)
+{
+	if (static_branch_likely(&riscv_sstc_available)) {
+		csr_write(CSR_STIMECMP, ULONG_MAX);
+		if (IS_ENABLED(CONFIG_32BIT))
+			csr_write(CSR_STIMECMPH, ULONG_MAX);
+	} else {
+		sbi_set_timer(U64_MAX);
+	}
+}
+
 static int riscv_clock_next_event(unsigned long delta,
 		struct clock_event_device *ce)
 {
 	u64 next_tval = get_cycles64() + delta;
 
-	csr_set(CSR_IE, IE_TIE);
 	if (static_branch_likely(&riscv_sstc_available)) {
 #if defined(CONFIG_32BIT)
 		csr_write(CSR_STIMECMP, next_tval & 0xFFFFFFFF);
@@ -119,7 +130,7 @@ static irqreturn_t riscv_timer_interrupt(int irq, void *dev_id)
 {
 	struct clock_event_device *evdev = this_cpu_ptr(&riscv_clock_event);
 
-	csr_clear(CSR_IE, IE_TIE);
+	riscv_clock_event_stop();
 	evdev->event_handler(evdev);
 
 	return IRQ_HANDLED;
-- 
2.34.1

