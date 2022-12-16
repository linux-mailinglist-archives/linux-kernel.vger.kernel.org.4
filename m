Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3968764ED3A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 15:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbiLPO6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 09:58:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiLPO6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 09:58:11 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5D05E08B
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 06:58:10 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id cf42so3867801lfb.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 06:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XI5FWBUPx6OMJbv7hDR0vpuygKMiyn48qRmwgBRrpyg=;
        b=EjIV/9MO/jyr60HiahpHnsgbaMKKNPGZzbZkILX054s2tSkZjbR+YPU3MsrCaoowzB
         0GHQhPSElmgbkTB3ztBmRq5YmW6je+CGusNx7M4GiA28XsgEoVfeoHg0FEfK9w8egsiU
         WAS7wpOw1xqETJhgx/dMIviVsyA94i8R+XgdMJqWg6LFJZtYReRadI/gLlzhVV+k9qPx
         lg0EMKE3+n2p32hXqJK81sBxrgjSv/r3laKdi57M+qDU8EfAFVq1QENe0DGANercJGLp
         aDIP5OHbnkuf21y86i65QKribqVIlXU4KjJWx5WSy6mIFt9t78xFKTnk0cOS16VGE7lq
         eskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XI5FWBUPx6OMJbv7hDR0vpuygKMiyn48qRmwgBRrpyg=;
        b=PCHfWAGlfQ5tYU5mVrqwDMUywTY5sWUGRUJLdOnNZmKuq1rsJNT0ylUpV9xiIv1XZ7
         jqo9w++tGgzkXy8g6InNy6VvcSqU4t9CVwrKVf7xq7sr3pdDUszYsjlymXK9vaFdQ/5C
         hHc68+G142SZPfLO1MGsodpFh0KEccro5+TiraSloCQrBLFNMXAU1SpE0ZEzhCauDeux
         NxX6uRKmqtdvs1mXHvJlQnHJMKK4q8FljrHrxCppBratIT2k3LS81ESpBrch4rWjtHLB
         kaMgQtJzXCaDHFnVckrauLoivnqyAFC1De2Vcz2JauMhAoWQ/mnOedOtzq1q4IIxFCHy
         qfqQ==
X-Gm-Message-State: ANoB5pl33v7GuqFCfhlXxH/27cUjA1kYMZ7If27kh/EHLBJO2Sg3peIG
        RDZzFgVTUEXibs5zvMvVTgaQ1g==
X-Google-Smtp-Source: AA0mqf7o2LPOY0FvSHAVIjM0eT7KSIcxGgoOk4WtpFSZ1GwSLmN7A174rFc/lccav32QpexwxxNkgw==
X-Received: by 2002:a05:6512:3042:b0:4a4:68b7:d642 with SMTP id b2-20020a056512304200b004a468b7d642mr11799574lfb.41.1671202689138;
        Fri, 16 Dec 2022 06:58:09 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c18-20020ac25f72000000b004b59b43ec61sm238491lfc.179.2022.12.16.06.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 06:58:08 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Adrien Thierry <athierry@redhat.com>,
        Brian Masney <bmasney@redhat.com>
Subject: [PATCH RFC 2/2] cpuidle: psci: Mark as PREEMPT_RT safe
Date:   Fri, 16 Dec 2022 15:58:02 +0100
Message-Id: <20221216145802.102374-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221216145802.102374-1-krzysztof.kozlowski@linaro.org>
References: <20221216145802.102374-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PSCI cpuidle power domain in power_off callback uses
__this_cpu_write() so it is PREEMPT_RT safe.  This allows to use it in
Realtime kernels and solves errors like:

 BUG: scheduling while atomic: swapper/2/0/0x00000002
 Hardware name: Qualcomm Technologies, Inc. Robotics RB5 (DT)
 Call trace:
  dump_backtrace.part.0+0xe0/0xf0
  show_stack+0x18/0x40
  dump_stack_lvl+0x68/0x84
  dump_stack+0x18/0x34
  __schedule_bug+0x60/0x80
  __schedule+0x628/0x800
  schedule_rtlock+0x28/0x5c
  rtlock_slowlock_locked+0x360/0xd30
  rt_spin_lock+0x88/0xb0
  genpd_lock_nested_spin+0x1c/0x30
  genpd_power_off.part.0.isra.0+0x20c/0x2a0
  genpd_runtime_suspend+0x150/0x2bc
  __rpm_callback+0x48/0x170
  rpm_callback+0x6c/0x7c
  rpm_suspend+0x108/0x660
  __pm_runtime_suspend+0x4c/0x8c
  __psci_enter_domain_idle_state.constprop.0+0x54/0xe0
  psci_enter_domain_idle_state+0x18/0x2c
  cpuidle_enter_state+0x8c/0x4e0
  cpuidle_enter+0x38/0x50
  do_idle+0x248/0x2f0
  cpu_startup_entry+0x24/0x30
  secondary_start_kernel+0x130/0x154
  __secondary_switched+0xb0/0xb4

Cc: Adrien Thierry <athierry@redhat.com>
Cc: Brian Masney <bmasney@redhat.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/cpuidle/cpuidle-psci-domain.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
index 821984947ed9..5cb78e754b27 100644
--- a/drivers/cpuidle/cpuidle-psci-domain.c
+++ b/drivers/cpuidle/cpuidle-psci-domain.c
@@ -62,7 +62,8 @@ static int psci_pd_init(struct device_node *np, bool use_osi)
 	if (!pd_provider)
 		goto free_pd;
 
-	pd->flags |= GENPD_FLAG_IRQ_SAFE | GENPD_FLAG_CPU_DOMAIN;
+	pd->flags |= GENPD_FLAG_IRQ_SAFE | GENPD_FLAG_RT_SAFE | \
+		     GENPD_FLAG_CPU_DOMAIN;
 
 	/* Allow power off when OSI has been successfully enabled. */
 	if (use_osi)
-- 
2.34.1

