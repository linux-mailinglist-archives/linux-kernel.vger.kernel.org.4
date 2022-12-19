Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D287650E6D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 16:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbiLSPPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 10:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbiLSPPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 10:15:15 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C04E0C3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 07:15:13 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id o6so9234841lfi.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 07:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5GU2NjmgE9pvJfcbP7Wbuf1L4Bg6ALcOGzwayLNEdCc=;
        b=M96PQCEKu708zYSAKfnI3vYYuOYQPIDYBpF3ko4XOFDTuP8CChmqa/eBMxnob9Xvvu
         13bJnQo4DxOWhMM/jR1CrFAF5M9LqPtdN/7YNIKVERNdhI1SDlDl3cc86hykawp9nDlW
         A8LaZVRmgg3mME0zszFlmghrDv2CYA9UQGulYue18w+tfHQ41K2i09gLezGgefdt2Xat
         yA3iZWLVPKyr3leBBG1RmA/uIihnVnrApGFWHFy9C1HuHrxB4Ntk1TXktxvLrCwRmM4l
         HKEKzORBxoGPpeRsegGr5/AeKG3CT40OE9h/5COkm0Ke5wzV7SIHlnUWUrpTu1NnSrTp
         0XRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5GU2NjmgE9pvJfcbP7Wbuf1L4Bg6ALcOGzwayLNEdCc=;
        b=SXgwbuPeZPBfZUHxqXd1xTAE3622lGTtwLw8Ryb/RaujtXPFxM8qlRVJxsJ8/Kdg2g
         sVy4tmUJk2uDTFTayYhq1QbS1V+zXT2U7VX+nk4bR3ruTWqhkNNteTvv82qNBm96Vu4q
         27yXBi4CL3dfFTMlVO1nRcdEklmBImIOqYAVeziDqUp+aS3IaVee5jpGxjbHpQgNA/kq
         Vsiauqh1vhCsAMEuyVNrOXW18DumSyr3zzTuNTPE9RvN1vMvYFUFRnBmB1F7IVrLB+Ew
         5EQJf/JWNF1fAXxilfDiJRqsj7tMp3EX2lC/LEoelBOBMnKO1K7sB58jVcbBXmV6seGG
         9tXA==
X-Gm-Message-State: ANoB5pnlFPvAUQ/B6raEspDhzCdP2E7ZZvDtMva3TKsCux8YqHQXxqfv
        tix/1R2wtGemAZmfUAE42+dsVw==
X-Google-Smtp-Source: AA0mqf5P0EXzSYerNvMnE1tqLXFMHI3GyGO5br1pN4dVVzBmBdh/UJ2E1Tze6Cn2gf/kxMeSGKg5YA==
X-Received: by 2002:ac2:560a:0:b0:4b6:f0ea:4f49 with SMTP id v10-20020ac2560a000000b004b6f0ea4f49mr7591911lfd.9.1671462912024;
        Mon, 19 Dec 2022 07:15:12 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id e1-20020a05651236c100b004bd8534ebbcsm1109894lfs.37.2022.12.19.07.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 07:15:11 -0800 (PST)
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
Subject: [PATCH v2 1/5] PM: domains: Add GENPD_FLAG_RT_SAFE for PREEMPT_RT
Date:   Mon, 19 Dec 2022 16:14:59 +0100
Message-Id: <20221219151503.385816-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221219151503.385816-1-krzysztof.kozlowski@linaro.org>
References: <20221219151503.385816-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Realtime kernels with PREEMPT_RT must use raw_spinlock_t for domains
which are invoked from CPU idle (thus from atomic section).  Example is
cpuidle PSCI domain driver which itself is PREEMPT_RT safe, but is being
called as part of cpuidle.

Add a flag allowing a power domain provider to indicate it is RT safe.
The flag is supposed to be used with existing GENPD_FLAG_IRQ_SAFE.

Cc: Adrien Thierry <athierry@redhat.com>
Cc: Brian Masney <bmasney@redhat.com>
Cc: linux-rt-users@vger.kernel.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Independently from Adrien, I encountered the same problem around genpd
when using PREEMPT_RT kernel.

Previous patch by Adrien:
https://lore.kernel.org/all/20220615203605.1068453-1-athierry@redhat.com/
---
 drivers/base/power/domain.c | 59 +++++++++++++++++++++++++++++++++++--
 include/linux/pm_domain.h   | 13 ++++++++
 2 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 967bcf9d415e..4dfce1d476f4 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -119,6 +119,48 @@ static const struct genpd_lock_ops genpd_spin_ops = {
 	.unlock = genpd_unlock_spin,
 };
 
+static void genpd_lock_rawspin(struct generic_pm_domain *genpd)
+	__acquires(&genpd->rslock)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&genpd->rslock, flags);
+	genpd->rlock_flags = flags;
+}
+
+static void genpd_lock_nested_rawspin(struct generic_pm_domain *genpd,
+					int depth)
+	__acquires(&genpd->rslock)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave_nested(&genpd->rslock, flags, depth);
+	genpd->rlock_flags = flags;
+}
+
+static int genpd_lock_interruptible_rawspin(struct generic_pm_domain *genpd)
+	__acquires(&genpd->rslock)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&genpd->rslock, flags);
+	genpd->rlock_flags = flags;
+	return 0;
+}
+
+static void genpd_unlock_rawspin(struct generic_pm_domain *genpd)
+	__releases(&genpd->rslock)
+{
+	raw_spin_unlock_irqrestore(&genpd->rslock, genpd->rlock_flags);
+}
+
+static const struct genpd_lock_ops genpd_rawspin_ops = {
+	.lock = genpd_lock_rawspin,
+	.lock_nested = genpd_lock_nested_rawspin,
+	.lock_interruptible = genpd_lock_interruptible_rawspin,
+	.unlock = genpd_unlock_rawspin,
+};
+
 #define genpd_lock(p)			p->lock_ops->lock(p)
 #define genpd_lock_nested(p, d)		p->lock_ops->lock_nested(p, d)
 #define genpd_lock_interruptible(p)	p->lock_ops->lock_interruptible(p)
@@ -126,6 +168,8 @@ static const struct genpd_lock_ops genpd_spin_ops = {
 
 #define genpd_status_on(genpd)		(genpd->status == GENPD_STATE_ON)
 #define genpd_is_irq_safe(genpd)	(genpd->flags & GENPD_FLAG_IRQ_SAFE)
+#define genpd_is_rt_safe(genpd)		(genpd_is_irq_safe(genpd) && \
+					 (genpd->flags & GENPD_FLAG_RT_SAFE))
 #define genpd_is_always_on(genpd)	(genpd->flags & GENPD_FLAG_ALWAYS_ON)
 #define genpd_is_active_wakeup(genpd)	(genpd->flags & GENPD_FLAG_ACTIVE_WAKEUP)
 #define genpd_is_cpu_domain(genpd)	(genpd->flags & GENPD_FLAG_CPU_DOMAIN)
@@ -1838,6 +1882,12 @@ static int genpd_add_subdomain(struct generic_pm_domain *genpd,
 		return -EINVAL;
 	}
 
+	if (!genpd_is_rt_safe(genpd) && genpd_is_rt_safe(subdomain)) {
+		WARN(1, "Parent %s of subdomain %s must be RT safe\n",
+		     genpd->name, subdomain->name);
+		return -EINVAL;
+	}
+
 	link = kzalloc(sizeof(*link), GFP_KERNEL);
 	if (!link)
 		return -ENOMEM;
@@ -2008,8 +2058,13 @@ static void genpd_free_data(struct generic_pm_domain *genpd)
 static void genpd_lock_init(struct generic_pm_domain *genpd)
 {
 	if (genpd->flags & GENPD_FLAG_IRQ_SAFE) {
-		spin_lock_init(&genpd->slock);
-		genpd->lock_ops = &genpd_spin_ops;
+		if (genpd->flags & GENPD_FLAG_RT_SAFE) {
+			raw_spin_lock_init(&genpd->rslock);
+			genpd->lock_ops = &genpd_rawspin_ops;
+		} else {
+			spin_lock_init(&genpd->slock);
+			genpd->lock_ops = &genpd_spin_ops;
+		}
 	} else {
 		mutex_init(&genpd->mlock);
 		genpd->lock_ops = &genpd_mtx_ops;
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 1cd41bdf73cf..0a1600244963 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -61,6 +61,14 @@
  * GENPD_FLAG_MIN_RESIDENCY:	Enable the genpd governor to consider its
  *				components' next wakeup when determining the
  *				optimal idle state.
+ *
+ * GENPD_FLAG_RT_SAFE:		When used with GENPD_FLAG_IRQ_SAFE, this informs
+ *				genpd that its backend callbacks, ->power_on|off(),
+ *				do not use other spinlocks. They might use
+ *				raw_spinlocks or other pre-emption-disable
+ *				methods, all of which are PREEMPT_RT safe. Note
+ *				that, a genpd having this flag set, requires its
+ *				masterdomains to also have it set.
  */
 #define GENPD_FLAG_PM_CLK	 (1U << 0)
 #define GENPD_FLAG_IRQ_SAFE	 (1U << 1)
@@ -69,6 +77,7 @@
 #define GENPD_FLAG_CPU_DOMAIN	 (1U << 4)
 #define GENPD_FLAG_RPM_ALWAYS_ON (1U << 5)
 #define GENPD_FLAG_MIN_RESIDENCY (1U << 6)
+#define GENPD_FLAG_RT_SAFE	 (1U << 7)
 
 enum gpd_status {
 	GENPD_STATE_ON = 0,	/* PM domain is on */
@@ -164,6 +173,10 @@ struct generic_pm_domain {
 			spinlock_t slock;
 			unsigned long lock_flags;
 		};
+		struct {
+			raw_spinlock_t rslock;
+			unsigned long rlock_flags;
+		};
 	};
 
 };
-- 
2.34.1

