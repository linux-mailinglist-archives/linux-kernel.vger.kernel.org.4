Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C587D686F3D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 20:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjBATtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 14:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbjBATtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 14:49:47 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CF92725
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 11:49:46 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d3so19515929plr.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 11:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1dg+uXzaaDlrvsfZB5ZVYE69CBYsnyR8HC8FMGd9uOk=;
        b=mUdhzyCgYPNycF/3bkAMsoqXvQQ/tso4Texyq30NkVnpEYdcyRuKmzz2Rr9fp34Eje
         PStVXCIBfTeS/ewMRxcWIN0eZkpiwVz+K9wrlYOCPExPoX8XDqDeXpo/xdlz8Mb6P8yH
         rcBTRdi3v3r589fekBvveOZSmC7+ooKvp8fSGwL7tL9TYZnQkCuAxoflAaTlkZplc+kS
         eEtwnPc7zlSIS/pHv8ONU0y+IeI1t0HUSWZ8XxQfIZDEqXbwAz2erCpu4iuptmGQRHkV
         n2pvh7Je1PuerQguKUAuzrm4EdS0tWGOF8oz7CtrfidrPzyq9yyoll/nea+iLRYeDveu
         pE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1dg+uXzaaDlrvsfZB5ZVYE69CBYsnyR8HC8FMGd9uOk=;
        b=ds8zJ8JSjhaHTurMaj57Uc5vg25iVtfPJtsndVCnI1bPgpKFY8QCasZzUvZ2Cijbpg
         xYlg4M5XKdzP7jQX0HXWeJdT5lLzkmpTzQxsG+Hcp7UTQNTPT0zrw6LLJQDRBHr5Jal5
         8va7Xd0gqhaX0FiZgR60tyLBMXFg8q8MHa+s4GRgLEg9Vg/FjSCGn8XEKNF2Vc1ODyn5
         cIiqMw3jbMVFKAg2CkdkMZWa1POF2u6JF1tly1dnurvXM0MQijX7H6GNALadGtbMp3F+
         Q5JfYCA4nuwdbvTno4mswyrH+yKSSjyLBLvsV5JRguYCuIc2OLma2slKkyl1rAXpEmsu
         eXYw==
X-Gm-Message-State: AO0yUKVvf74/XOlrrg5UclidDwJguaB35iwlLz0v8QLe0PFEQtXGhZm9
        4G09Zgs5cOGcQdQAb+ODU6tEme0mzlRpXZw6
X-Google-Smtp-Source: AK7set+GulbmfTJcMlD3KZbcW1D0M9MZZW397DAJ+hjZSoE0ohBkXfhXkx7rlEzwdgu1mqowUP6nKw==
X-Received: by 2002:a17:902:d415:b0:196:6298:6226 with SMTP id b21-20020a170902d41500b0019662986226mr3453841ple.49.1675280986263;
        Wed, 01 Feb 2023 11:49:46 -0800 (PST)
Received: from smtpclient.apple ([51.52.155.79])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902b10900b0019608291564sm4015021plr.134.2023.02.01.11.49.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Feb 2023 11:49:45 -0800 (PST)
From:   Matt Evans <mev@rivosinc.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: [PATCH V2] clocksource: riscv: Patch riscv_clock_next_event() jump
 before first use
Message-Id: <CDDAB2D0-264E-42F3-8E31-BA210BEB8EC1@rivosinc.com>
Date:   Wed, 1 Feb 2023 19:49:42 +0000
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Atish Patra <atishp@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A static key is used to select between SBI and Sstc timer usage in
riscv_clock_next_event(), but currently the direction is resolved
after cpuhp_setup_state() is called (which sets the next event).  The
first event will therefore fall through the sbi_set_timer() path; this
breaks Sstc-only systems.  So, apply the jump patching before first
use.

Fixes: 9f7a8ff6391f ("RISC-V: Prefer sstc extension if available")
Signed-off-by: Matt Evans <mev@rivosinc.com>
---

V1 -> V2: Commit msg tweak.

 drivers/clocksource/timer-riscv.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/timer-riscv.c =
b/drivers/clocksource/timer-riscv.c
index 969a552da8d2..a36d173fd6cd 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -177,6 +177,11 @@ static int __init riscv_timer_init_dt(struct =
device_node *n)
 		return error;
 	}
=20
+	if (riscv_isa_extension_available(NULL, SSTC)) {
+		pr_info("Timer interrupt in S-mode is available via sstc =
extension\n");
+		static_branch_enable(&riscv_sstc_available);
+	}
+
 	error =3D cpuhp_setup_state(CPUHP_AP_RISCV_TIMER_STARTING,
 			 "clockevents/riscv/timer:starting",
 			 riscv_timer_starting_cpu, =
riscv_timer_dying_cpu);
@@ -184,11 +189,6 @@ static int __init riscv_timer_init_dt(struct =
device_node *n)
 		pr_err("cpu hp setup state failed for RISCV timer =
[%d]\n",
 		       error);
=20
-	if (riscv_isa_extension_available(NULL, SSTC)) {
-		pr_info("Timer interrupt in S-mode is available via sstc =
extension\n");
-		static_branch_enable(&riscv_sstc_available);
-	}
-
 	return error;
 }
=20
--=20
2.30.2


