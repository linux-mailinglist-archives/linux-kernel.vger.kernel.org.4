Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4E4650E6F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 16:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbiLSPP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 10:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbiLSPPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 10:15:16 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68ACB7DB
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 07:15:14 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 1so14128767lfz.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 07:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=710npLST/xPzuXiih2c1d9pFv9jXZIz92buQVuG0oAE=;
        b=uEio8RqgLj7kCKnMrT/ndnvx/qtape0C21ameHDn5oxR1frx1ZVQ/UjjKEP/ibeWWh
         /FrAeFueaLx7BNbF218RzyfLQhs6ts56jbLBL2inGVZ8II/hhK38SdmB46mvrjRjuhWs
         LneaquS3DyNt64GkklXVgbkS2zL9bf6bEp74uvqATEfY07UyjJTqmZM+QFcOLM4uy8Bo
         CE/mOMKX0Cwc47pRYdikRdnVWrHoU5LoezIzgPZcUuo1I6KJTFkMPX9rvq5ht+fmfcMC
         ONvGwjkQVW0VtSI8uJhE12tdg/7q+CM2fWOMU6PmvL3H+i1ZDUpFhpWuX439KLEKV4MS
         LZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=710npLST/xPzuXiih2c1d9pFv9jXZIz92buQVuG0oAE=;
        b=kw+b73cq/61U1ewy4Yr7tJlGnvuEGbMm+xMxYTE1zoy060BFXfDjX3MNOoC5jMLDMf
         rNTIfyCku5Pk/bSwyq8r3WLNjcO6lAKcgYIigkpVZMCq2VEqSVJq7QlEiw/jHaOe1hU4
         4IlJRLsFcgQuMhtLizrJ1G32qtz70NepR9e5z8OXz0gm4Rahh5WMHIi288oIY3+t8usi
         aQXAfH+uP1ym3ukIs02VCljT2Qf8mQnaYxIWppd5dp03MFQyMBKNWnflYueYPmKX1MbJ
         5S37i78w02oge1cunMWQoVOj48auuT1nw+pY25XeTt/9ppCZ1OHiDGmTx4Kxc6cQdgw2
         e2JQ==
X-Gm-Message-State: ANoB5pmJT1frRtwImj3vpt525FB+lPliWseSzNatQMHvsaYABIcKOc39
        FdwZXqqE4jc5ZAX0NJf1CyZg8w==
X-Google-Smtp-Source: AA0mqf5O5lOshUMBMDUAarE8CUlxxQDab0aOfGYCt75u7yth94O0C4yTULqeDUE5eHe18yeibJ7oYw==
X-Received: by 2002:a05:6512:261b:b0:4b4:dd3d:4310 with SMTP id bt27-20020a056512261b00b004b4dd3d4310mr16841834lfb.19.1671462913205;
        Mon, 19 Dec 2022 07:15:13 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id e1-20020a05651236c100b004bd8534ebbcsm1109894lfs.37.2022.12.19.07.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 07:15:12 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Adrien Thierry <athierry@redhat.com>,
        Brian Masney <bmasney@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: [PATCH v2 2/5] cpuidle: psci: Mark as PREEMPT_RT safe
Date:   Mon, 19 Dec 2022 16:15:00 +0100
Message-Id: <20221219151503.385816-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221219151503.385816-1-krzysztof.kozlowski@linaro.org>
References: <20221219151503.385816-1-krzysztof.kozlowski@linaro.org>
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
Cc: linux-rt-users@vger.kernel.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/cpuidle/cpuidle-psci-domain.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
index c80cf9ddabd8..d15a91fb7048 100644
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

