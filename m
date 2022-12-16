Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A636D64ED34
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 15:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbiLPO6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 09:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiLPO6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 09:58:10 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48A05D6BB
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 06:58:09 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id m29so3602936lfo.11
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 06:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qnQ8WVqn39lloqLDzY0u45TgwEZ131RficcHAU+KQ+E=;
        b=oeFrpbC9q5PPAqJO+kaJZzPL/fa2Oy9hVNpADsk/a8586GWPaS1aCP5E7xjAKGysDA
         u9aJDkLjv5XtEcv+PyCVB2tKVfbcCaWGGl90UHXLsBUV9JbaMOhDCJK5nVL28Ogh9FT6
         8EH3i8jPcclhrjL/7QtkKfZ9Z1lQpEq1oEgF7dsL7ljqit9fRlajx09JAriSqqj2kQ50
         lgCAuRBHTUlI+u1m752A7ICLwBXy8xPK1HTkVqNbxWCQ+X08LjDEVoTuJHJgdgIZr8Zr
         0hqHwcbROUkSAzBNkVy7AJwHjxdM8sJAWwlFV1wOr52xphNz8+l4UcUGYMfb66MR1rc9
         x2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qnQ8WVqn39lloqLDzY0u45TgwEZ131RficcHAU+KQ+E=;
        b=BX5BJ5tZatnJrPVQmjGX539kjGIPVBCWCzlOC6DQBmnsQNi5tfwaXMorSsX6X9tukT
         xwmYbdz5q5bgU4ig86XnQV9IBa/xfLAnIGD8S8NBkRPxszAd0pdDv8Vq+WmeAJrLrFqB
         jyamoGZNntFmBBAe+xjYPlpef6ejYGJtY3FZkjTIfv6aREmAeq03CsGGhMqdna7ZddSC
         NWrvC0tAua5Hz9f3qLzxO8L3Ng0IW0a4SOUdyelIWNPI51leugMWvpjAueVhWxdqgExo
         Z47ncd77vEa0jxAAhx5xV35+fATolDxHLduBaylE67HTR+9yUe/a7HhrRbIJdej9CC9X
         SfvQ==
X-Gm-Message-State: ANoB5pm3SaYKhVB6KLwCG4mXxMoNOAuUrv8WvFWZWJ7VO+A5TjMNthCd
        8jdaaJKTVA0ghHzyRzHwt03/Cg==
X-Google-Smtp-Source: AA0mqf5zVAxsQWpDKAT+cihDzTutK+yPkquZd6gx5FEZQi1/4SqpZkDMvO905N9BPjowSzn5q4YqQw==
X-Received: by 2002:a05:6512:2102:b0:4b5:6c36:79a4 with SMTP id q2-20020a056512210200b004b56c3679a4mr8644808lfr.65.1671202688023;
        Fri, 16 Dec 2022 06:58:08 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c18-20020ac25f72000000b004b59b43ec61sm238491lfc.179.2022.12.16.06.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 06:58:07 -0800 (PST)
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
Subject: [PATCH RFC 1/2] PM: domains: Add GENPD_FLAG_RT_SAFE for PREEMPT_RT
Date:   Fri, 16 Dec 2022 15:58:01 +0100
Message-Id: <20221216145802.102374-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Realtime kernels with PREEMPT_RT must use raw_spinlock_t, so add a flag
allowing a power domain provider to indicate it is RT safe.  The flag is
supposed to be used with existing GENPD_FLAG_IRQ_SAFE.

Cc: Adrien Thierry <athierry@redhat.com>
Cc: Brian Masney <bmasney@redhat.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Independently from Adrien, I encountered the same problem around genpd
when using PREEMPT_RT kernel.

Previous patch by Adrien:
https://lore.kernel.org/all/20220615203605.1068453-1-athierry@redhat.com/
---
 drivers/base/power/domain.c | 51 +++++++++++++++++++++++++++++++++++--
 include/linux/pm_domain.h   | 13 ++++++++++
 2 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index a539d6bc6fe0..478862ae478a 100644
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
@@ -2048,8 +2090,13 @@ static void genpd_free_data(struct generic_pm_domain *genpd)
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
index c6cda024ff99..6b0f9de2be1c 100644
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

