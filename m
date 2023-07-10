Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C586874D748
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 15:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjGJNTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 09:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjGJNT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:19:28 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEF1C4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 06:19:26 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-77ac14ff51bso142735739f.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 06:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1688995166; x=1691587166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r1gRBue3D63AcisS8ZRrKq/nAe8+ybrtdsVfAzlr1PY=;
        b=pA+OZj+6VRBv5gS74DBiOVUTgwvqM6wfhrRwlQNZG7tF+0mRI9MD1owZvdSX7ukimh
         k8suDBs0QgKceGAu3WuWnG43cRnQhiCgUbXPnkIEICLi1FX3T2OtPFwSpBDYcJqYySgt
         8mew5dOHk8HZ5c1QM7tS98XYN0MyH0n0xs+ZuFNgCNoZPS0u8LbWovuZ4i9/NUmQyg4n
         fbtlVo8iSDEAMIIdt218mawBd6L7r00CCJnYonLgqo8KA3BEgoQ3XASlfTOPoyfp3UdI
         pJThRWHkf8gbMgSucIu3KeJySWz3zR+8VUhz1cFP0/2GWDgOPQyx09LmmXuGwk7LWPuD
         qXTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688995166; x=1691587166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r1gRBue3D63AcisS8ZRrKq/nAe8+ybrtdsVfAzlr1PY=;
        b=NqqGR1M6E/V0UJb9LMpje0nBy7dS170o8cine1WZq253HfAwoP8KChZXIJgbNNQXpi
         r3Lkhp2Tx2SMllqmx0Ujdf8I/9NsK54UAtvgKH40pYS3AtyttioH5p4cKQ4eYBKXUtKn
         k/qN4xgbvNGHnjDKREtIuzf/7meJ2428wlAHAJkT0aMiVOmjDkzOiPcpMmzaNQJ94Px+
         wdXFCriiW8sCJNh7YswfVJuXKU7x0DAKwSx0F7Hox5627oJazYJA3GOxaKgKRSVKIp23
         xJLMylTdoX4Yky38fJ6dkhf40TDa6L4L9/gZ4wkrFp2HHbQmelggWD89CEblnrvmZyUm
         O9YA==
X-Gm-Message-State: ABy/qLaWeAMpkcHLrFHA5J+OkEYJ41iPz4v2mwUatSW8eIA8/gmtreS2
        MdDXQ9wRXNCjY/1mTnggiRvZ2g==
X-Google-Smtp-Source: APBJJlHvGG/zjHslHAxhLRw47sOr0nUaUNS7C7K4tdHJPkUEe+8zgZyMURiUepQv7N2eA4R4IfmuUg==
X-Received: by 2002:a5d:9451:0:b0:783:72b9:ed67 with SMTP id x17-20020a5d9451000000b0078372b9ed67mr12562805ior.10.1688995165630;
        Mon, 10 Jul 2023 06:19:25 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id q14-20020a5d9f0e000000b0077a1b6f73b9sm3643242iot.41.2023.07.10.06.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 06:19:25 -0700 (PDT)
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
Subject: [PATCH 2/2] clocksource: timer-riscv: Increase rating of clock_event_device for Sstc
Date:   Mon, 10 Jul 2023 18:49:02 +0530
Message-Id: <20230710131902.1459180-3-apatel@ventanamicro.com>
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

When Sstc is available the RISC-V timer clock_event_device should be
the preferred clock_event_device hence we increase clock_event_device
rating for Sstc.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/clocksource/timer-riscv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index f2ea2b3d2d43..9c8f3e2decc2 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -105,6 +105,8 @@ static int riscv_timer_starting_cpu(unsigned int cpu)
 	ce->irq = riscv_clock_event_irq;
 	if (riscv_timer_cannot_wake_cpu)
 		ce->features |= CLOCK_EVT_FEAT_C3STOP;
+	if (static_branch_likely(&riscv_sstc_available))
+		ce->rating = 450;
 	clockevents_config_and_register(ce, riscv_timebase, 100, 0x7fffffff);
 
 	enable_percpu_irq(riscv_clock_event_irq,
-- 
2.34.1

