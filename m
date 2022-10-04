Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E0E5F3FB5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbiJDJbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiJDJ1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:27:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC67ECC1;
        Tue,  4 Oct 2022 02:27:13 -0700 (PDT)
Date:   Tue, 04 Oct 2022 09:27:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664875632;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J/g5fgfQy5iAuWJNM/HNsoeiO6zhzaRhf6o7A2DVVMI=;
        b=KuqsNKflmXW4lztFaaBDlVImZ8UK6fltVYhT34g7rWyPL51cnh/0AycF6QyEoFMU3V6sOf
        J6DP9PzdIGcCAtmgOFYwXY30VGntCUrHGiqhdY3e+iF72Aex6j0z7QNlmsRpJUgcTxdhGF
        TxOrSBBXQnMFr86shMfZer+5o1kNAD9ZRWlnlgsgzFg62ft5kx12g6kdlotiaBSGFiY5ZZ
        Q28gknNP76q5QFboVJARmU/51QXs1yjuUOoSGhHyMDQUDjWk+k1h8BGvMDALVesM3VvjDp
        Bbd4hB69Nge61QAle83aUKcm7qfl/WloOi2WDFbyH/lrL4WEM9n6nmlwQIMYrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664875632;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J/g5fgfQy5iAuWJNM/HNsoeiO6zhzaRhf6o7A2DVVMI=;
        b=nmtjNdlwKd6OuFWzG9Kuxm0NOxoQ62VbFgm2O7zT/v7t6i65xBNzuR50qd59wTez8LbY0k
        gTHW90ezj8AvG2Dw==
From:   "tip-bot2 for Tony Lindgren" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-ti-dm: Move struct
 omap_dm_timer fields to driver
Cc:     Tony Lindgren <tony@atomide.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220815131250.34603-8-tony@atomide.com>
References: <20220815131250.34603-8-tony@atomide.com>
MIME-Version: 1.0
Message-ID: <166487563115.401.874469227042982407.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     a6e543f61531b63bfc8d43053c6ec6f65117f627
Gitweb:        https://git.kernel.org/tip/a6e543f61531b63bfc8d43053c6ec6f65117f627
Author:        Tony Lindgren <tony@atomide.com>
AuthorDate:    Mon, 15 Aug 2022 16:12:48 +03:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 20 Sep 2022 10:49:46 +02:00

clocksource/drivers/timer-ti-dm: Move struct omap_dm_timer fields to driver

There is no longer any need to expose the elements of struct omap_dm_timer
outside the driver. The pwm and remoteproc drivers just use struct
omap_dm_timer as a cookie.

Let's move the elements of struct omap_dm_timer into struct dmtimer that
is private to the driver. To do this, we mostly rename omap_dm_timer to
dmtimer in the driver. We keep omap_dm_timer only for the exposed
functions in the platform_data for the pwm and remoteproc drivers.

Let's also add a note about not using the exposed functions internally as
those will get deprecated eventually in favor of Linux generic frameworks.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Reviewed-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Link: https://lore.kernel.org/r/20220815131250.34603-8-tony@atomide.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-ti-dm.c | 218 ++++++++++++++++++++++-------
 include/clocksource/timer-ti-dm.h |  43 +------
 2 files changed, 170 insertions(+), 91 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index 4967a91..0d0130e 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -95,6 +95,53 @@
 #define OMAP_TIMER_TICK_INT_MASK_COUNT_REG				\
 		(_OMAP_TIMER_TICK_INT_MASK_COUNT_OFFSET | (WP_TOWR << WPSHIFT))
 
+struct timer_regs {
+	u32 ocp_cfg;
+	u32 tidr;
+	u32 tier;
+	u32 twer;
+	u32 tclr;
+	u32 tcrr;
+	u32 tldr;
+	u32 ttrg;
+	u32 twps;
+	u32 tmar;
+	u32 tcar1;
+	u32 tsicr;
+	u32 tcar2;
+	u32 tpir;
+	u32 tnir;
+	u32 tcvr;
+	u32 tocr;
+	u32 towr;
+};
+
+struct dmtimer {
+	struct omap_dm_timer cookie;
+	int id;
+	int irq;
+	struct clk *fclk;
+
+	void __iomem	*io_base;
+	int		irq_stat;	/* TISR/IRQSTATUS interrupt status */
+	int		irq_ena;	/* irq enable */
+	int		irq_dis;	/* irq disable, only on v2 ip */
+	void __iomem	*pend;		/* write pending */
+	void __iomem	*func_base;	/* function register base */
+
+	atomic_t enabled;
+	unsigned long rate;
+	unsigned reserved:1;
+	unsigned posted:1;
+	struct timer_regs context;
+	int revision;
+	u32 capability;
+	u32 errata;
+	struct platform_device *pdev;
+	struct list_head node;
+	struct notifier_block nb;
+};
+
 static u32 omap_reserved_systimers;
 static LIST_HEAD(omap_timer_list);
 static DEFINE_SPINLOCK(dm_timer_lock);
@@ -115,7 +162,7 @@ enum {
  * pending bit must be checked. Otherwise a read of a non completed write
  * will produce an error.
  */
-static inline u32 dmtimer_read(struct omap_dm_timer *timer, u32 reg)
+static inline u32 dmtimer_read(struct dmtimer *timer, u32 reg)
 {
 	u16 wp, offset;
 
@@ -140,7 +187,7 @@ static inline u32 dmtimer_read(struct omap_dm_timer *timer, u32 reg)
  * pending bit must be checked. Otherwise a write on a register which has a
  * pending write will be lost.
  */
-static inline void dmtimer_write(struct omap_dm_timer *timer, u32 reg, u32 val)
+static inline void dmtimer_write(struct dmtimer *timer, u32 reg, u32 val)
 {
 	u16 wp, offset;
 
@@ -155,7 +202,7 @@ static inline void dmtimer_write(struct omap_dm_timer *timer, u32 reg, u32 val)
 	writel_relaxed(val, timer->func_base + offset);
 }
 
-static inline void __omap_dm_timer_init_regs(struct omap_dm_timer *timer)
+static inline void __omap_dm_timer_init_regs(struct dmtimer *timer)
 {
 	u32 tidr;
 
@@ -190,7 +237,7 @@ static inline void __omap_dm_timer_init_regs(struct omap_dm_timer *timer)
  * complete. Enabling this feature can improve performance for writing to the
  * timer registers.
  */
-static inline void __omap_dm_timer_enable_posted(struct omap_dm_timer *timer)
+static inline void __omap_dm_timer_enable_posted(struct dmtimer *timer)
 {
 	if (timer->posted)
 		return;
@@ -206,7 +253,7 @@ static inline void __omap_dm_timer_enable_posted(struct omap_dm_timer *timer)
 	timer->posted = OMAP_TIMER_POSTED;
 }
 
-static inline void __omap_dm_timer_stop(struct omap_dm_timer *timer,
+static inline void __omap_dm_timer_stop(struct dmtimer *timer,
 					unsigned long rate)
 {
 	u32 l;
@@ -230,26 +277,26 @@ static inline void __omap_dm_timer_stop(struct omap_dm_timer *timer,
 	dmtimer_write(timer, timer->irq_stat, OMAP_TIMER_INT_OVERFLOW);
 }
 
-static inline void __omap_dm_timer_int_enable(struct omap_dm_timer *timer,
-						unsigned int value)
+static inline void __omap_dm_timer_int_enable(struct dmtimer *timer,
+					      unsigned int value)
 {
 	dmtimer_write(timer, timer->irq_ena, value);
 	dmtimer_write(timer, OMAP_TIMER_WAKEUP_EN_REG, value);
 }
 
 static inline unsigned int
-__omap_dm_timer_read_counter(struct omap_dm_timer *timer)
+__omap_dm_timer_read_counter(struct dmtimer *timer)
 {
 	return dmtimer_read(timer, OMAP_TIMER_COUNTER_REG);
 }
 
-static inline void __omap_dm_timer_write_status(struct omap_dm_timer *timer,
+static inline void __omap_dm_timer_write_status(struct dmtimer *timer,
 						unsigned int value)
 {
 	dmtimer_write(timer, timer->irq_stat, value);
 }
 
-static void omap_timer_restore_context(struct omap_dm_timer *timer)
+static void omap_timer_restore_context(struct dmtimer *timer)
 {
 	dmtimer_write(timer, OMAP_TIMER_OCP_CFG_OFFSET, timer->context.ocp_cfg);
 
@@ -262,7 +309,7 @@ static void omap_timer_restore_context(struct omap_dm_timer *timer)
 	dmtimer_write(timer, OMAP_TIMER_CTRL_REG, timer->context.tclr);
 }
 
-static void omap_timer_save_context(struct omap_dm_timer *timer)
+static void omap_timer_save_context(struct dmtimer *timer)
 {
 	timer->context.ocp_cfg = dmtimer_read(timer, OMAP_TIMER_OCP_CFG_OFFSET);
 
@@ -277,9 +324,9 @@ static void omap_timer_save_context(struct omap_dm_timer *timer)
 static int omap_timer_context_notifier(struct notifier_block *nb,
 				       unsigned long cmd, void *v)
 {
-	struct omap_dm_timer *timer;
+	struct dmtimer *timer;
 
-	timer = container_of(nb, struct omap_dm_timer, nb);
+	timer = container_of(nb, struct dmtimer, nb);
 
 	switch (cmd) {
 	case CPU_CLUSTER_PM_ENTER:
@@ -301,7 +348,7 @@ static int omap_timer_context_notifier(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
-static int omap_dm_timer_reset(struct omap_dm_timer *timer)
+static int omap_dm_timer_reset(struct dmtimer *timer)
 {
 	u32 l, timeout = 100000;
 
@@ -329,13 +376,29 @@ static int omap_dm_timer_reset(struct omap_dm_timer *timer)
 	return 0;
 }
 
-static int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
+/*
+ * Functions exposed to PWM and remoteproc drivers via platform_data.
+ * Do not use these in the driver, these will get deprecated and will
+ * will be replaced by Linux generic framework functions such as
+ * chained interrupts and clock framework.
+ */
+static struct dmtimer *to_dmtimer(struct omap_dm_timer *cookie)
+{
+	if (!cookie)
+		return NULL;
+
+	return container_of(cookie, struct dmtimer, cookie);
+}
+
+static int omap_dm_timer_set_source(struct omap_dm_timer *cookie, int source)
 {
 	int ret;
 	const char *parent_name;
 	struct clk *parent;
 	struct dmtimer_platform_data *pdata;
+	struct dmtimer *timer;
 
+	timer = to_dmtimer(cookie);
 	if (unlikely(!timer) || IS_ERR(timer->fclk))
 		return -EINVAL;
 
@@ -385,8 +448,9 @@ static int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 	return ret;
 }
 
-static void omap_dm_timer_enable(struct omap_dm_timer *timer)
+static void omap_dm_timer_enable(struct omap_dm_timer *cookie)
 {
+	struct dmtimer *timer = to_dmtimer(cookie);
 	struct device *dev = &timer->pdev->dev;
 	int rc;
 
@@ -395,14 +459,15 @@ static void omap_dm_timer_enable(struct omap_dm_timer *timer)
 		dev_err(dev, "could not enable timer\n");
 }
 
-static void omap_dm_timer_disable(struct omap_dm_timer *timer)
+static void omap_dm_timer_disable(struct omap_dm_timer *cookie)
 {
+	struct dmtimer *timer = to_dmtimer(cookie);
 	struct device *dev = &timer->pdev->dev;
 
 	pm_runtime_put_sync(dev);
 }
 
-static int omap_dm_timer_prepare(struct omap_dm_timer *timer)
+static int omap_dm_timer_prepare(struct dmtimer *timer)
 {
 	struct device *dev = &timer->pdev->dev;
 	int rc;
@@ -442,9 +507,9 @@ static inline u32 omap_dm_timer_reserved_systimer(int id)
 	return (omap_reserved_systimers & (1 << (id - 1))) ? 1 : 0;
 }
 
-static struct omap_dm_timer *_omap_dm_timer_request(int req_type, void *data)
+static struct dmtimer *_omap_dm_timer_request(int req_type, void *data)
 {
-	struct omap_dm_timer *timer = NULL, *t;
+	struct dmtimer *timer = NULL, *t;
 	struct device_node *np = NULL;
 	unsigned long flags;
 	u32 cap = 0;
@@ -528,11 +593,19 @@ found:
 
 static struct omap_dm_timer *omap_dm_timer_request(void)
 {
-	return _omap_dm_timer_request(REQUEST_ANY, NULL);
+	struct dmtimer *timer;
+
+	timer = _omap_dm_timer_request(REQUEST_ANY, NULL);
+	if (!timer)
+		return NULL;
+
+	return &timer->cookie;
 }
 
 static struct omap_dm_timer *omap_dm_timer_request_specific(int id)
 {
+	struct dmtimer *timer;
+
 	/* Requesting timer by ID is not supported when device tree is used */
 	if (of_have_populated_dt()) {
 		pr_warn("%s: Please use omap_dm_timer_request_by_node()\n",
@@ -540,7 +613,11 @@ static struct omap_dm_timer *omap_dm_timer_request_specific(int id)
 		return NULL;
 	}
 
-	return _omap_dm_timer_request(REQUEST_BY_ID, &id);
+	timer = _omap_dm_timer_request(REQUEST_BY_ID, &id);
+	if (!timer)
+		return NULL;
+
+	return &timer->cookie;
 }
 
 /**
@@ -552,14 +629,23 @@ static struct omap_dm_timer *omap_dm_timer_request_specific(int id)
  */
 static struct omap_dm_timer *omap_dm_timer_request_by_node(struct device_node *np)
 {
+	struct dmtimer *timer;
+
 	if (!np)
 		return NULL;
 
-	return _omap_dm_timer_request(REQUEST_BY_NODE, np);
+	timer = _omap_dm_timer_request(REQUEST_BY_NODE, np);
+	if (!timer)
+		return NULL;
+
+	return &timer->cookie;
 }
 
-static int omap_dm_timer_free(struct omap_dm_timer *timer)
+static int omap_dm_timer_free(struct omap_dm_timer *cookie)
 {
+	struct dmtimer *timer;
+
+	timer = to_dmtimer(cookie);
 	if (unlikely(!timer))
 		return -EINVAL;
 
@@ -570,8 +656,9 @@ static int omap_dm_timer_free(struct omap_dm_timer *timer)
 	return 0;
 }
 
-int omap_dm_timer_get_irq(struct omap_dm_timer *timer)
+int omap_dm_timer_get_irq(struct omap_dm_timer *cookie)
 {
+	struct dmtimer *timer = to_dmtimer(cookie);
 	if (timer)
 		return timer->irq;
 	return -EINVAL;
@@ -580,7 +667,7 @@ int omap_dm_timer_get_irq(struct omap_dm_timer *timer)
 #if defined(CONFIG_ARCH_OMAP1)
 #include <linux/soc/ti/omap1-io.h>
 
-static struct clk *omap_dm_timer_get_fclk(struct omap_dm_timer *timer)
+static struct clk *omap_dm_timer_get_fclk(struct omap_dm_timer *cookie)
 {
 	return NULL;
 }
@@ -592,7 +679,7 @@ static struct clk *omap_dm_timer_get_fclk(struct omap_dm_timer *timer)
 __u32 omap_dm_timer_modify_idlect_mask(__u32 inputmask)
 {
 	int i = 0;
-	struct omap_dm_timer *timer = NULL;
+	struct dmtimer *timer = NULL;
 	unsigned long flags;
 
 	/* If ARMXOR cannot be idled this function call is unnecessary */
@@ -620,8 +707,10 @@ __u32 omap_dm_timer_modify_idlect_mask(__u32 inputmask)
 
 #else
 
-static struct clk *omap_dm_timer_get_fclk(struct omap_dm_timer *timer)
+static struct clk *omap_dm_timer_get_fclk(struct omap_dm_timer *cookie)
 {
+	struct dmtimer *timer = to_dmtimer(cookie);
+
 	if (timer && !IS_ERR(timer->fclk))
 		return timer->fclk;
 	return NULL;
@@ -636,15 +725,19 @@ __u32 omap_dm_timer_modify_idlect_mask(__u32 inputmask)
 
 #endif
 
-static int omap_dm_timer_start(struct omap_dm_timer *timer)
+static int omap_dm_timer_start(struct omap_dm_timer *cookie)
 {
-	struct device *dev = &timer->pdev->dev;
+	struct dmtimer *timer;
+	struct device *dev;
 	int rc;
 	u32 l;
 
+	timer = to_dmtimer(cookie);
 	if (unlikely(!timer))
 		return -EINVAL;
 
+	dev = &timer->pdev->dev;
+
 	rc = pm_runtime_resume_and_get(dev);
 	if (rc)
 		return rc;
@@ -658,14 +751,18 @@ static int omap_dm_timer_start(struct omap_dm_timer *timer)
 	return 0;
 }
 
-static int omap_dm_timer_stop(struct omap_dm_timer *timer)
+static int omap_dm_timer_stop(struct omap_dm_timer *cookie)
 {
-	struct device *dev = &timer->pdev->dev;
+	struct dmtimer *timer;
+	struct device *dev;
 	unsigned long rate = 0;
 
+	timer = to_dmtimer(cookie);
 	if (unlikely(!timer))
 		return -EINVAL;
 
+	dev = &timer->pdev->dev;
+
 	if (!(timer->capability & OMAP_TIMER_NEEDS_RESET))
 		rate = clk_get_rate(timer->fclk);
 
@@ -676,12 +773,14 @@ static int omap_dm_timer_stop(struct omap_dm_timer *timer)
 	return 0;
 }
 
-static int omap_dm_timer_set_load(struct omap_dm_timer *timer,
+static int omap_dm_timer_set_load(struct omap_dm_timer *cookie,
 				  unsigned int load)
 {
+	struct dmtimer *timer;
 	struct device *dev;
 	int rc;
 
+	timer = to_dmtimer(cookie);
 	if (unlikely(!timer))
 		return -EINVAL;
 
@@ -697,13 +796,15 @@ static int omap_dm_timer_set_load(struct omap_dm_timer *timer,
 	return 0;
 }
 
-static int omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable,
+static int omap_dm_timer_set_match(struct omap_dm_timer *cookie, int enable,
 				   unsigned int match)
 {
+	struct dmtimer *timer;
 	struct device *dev;
 	int rc;
 	u32 l;
 
+	timer = to_dmtimer(cookie);
 	if (unlikely(!timer))
 		return -EINVAL;
 
@@ -725,13 +826,15 @@ static int omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable,
 	return 0;
 }
 
-static int omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on,
+static int omap_dm_timer_set_pwm(struct omap_dm_timer *cookie, int def_on,
 				 int toggle, int trigger, int autoreload)
 {
+	struct dmtimer *timer;
 	struct device *dev;
 	int rc;
 	u32 l;
 
+	timer = to_dmtimer(cookie);
 	if (unlikely(!timer))
 		return -EINVAL;
 
@@ -757,12 +860,14 @@ static int omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on,
 	return 0;
 }
 
-static int omap_dm_timer_get_pwm_status(struct omap_dm_timer *timer)
+static int omap_dm_timer_get_pwm_status(struct omap_dm_timer *cookie)
 {
+	struct dmtimer *timer;
 	struct device *dev;
 	int rc;
 	u32 l;
 
+	timer = to_dmtimer(cookie);
 	if (unlikely(!timer))
 		return -EINVAL;
 
@@ -778,13 +883,15 @@ static int omap_dm_timer_get_pwm_status(struct omap_dm_timer *timer)
 	return l;
 }
 
-static int omap_dm_timer_set_prescaler(struct omap_dm_timer *timer,
-					int prescaler)
+static int omap_dm_timer_set_prescaler(struct omap_dm_timer *cookie,
+				       int prescaler)
 {
+	struct dmtimer *timer;
 	struct device *dev;
 	int rc;
 	u32 l;
 
+	timer = to_dmtimer(cookie);
 	if (unlikely(!timer) || prescaler < -1 || prescaler > 7)
 		return -EINVAL;
 
@@ -806,12 +913,14 @@ static int omap_dm_timer_set_prescaler(struct omap_dm_timer *timer,
 	return 0;
 }
 
-static int omap_dm_timer_set_int_enable(struct omap_dm_timer *timer,
+static int omap_dm_timer_set_int_enable(struct omap_dm_timer *cookie,
 					unsigned int value)
 {
+	struct dmtimer *timer;
 	struct device *dev;
 	int rc;
 
+	timer = to_dmtimer(cookie);
 	if (unlikely(!timer))
 		return -EINVAL;
 
@@ -834,12 +943,14 @@ static int omap_dm_timer_set_int_enable(struct omap_dm_timer *timer,
  *
  * Disables the specified timer interrupts for a timer.
  */
-static int omap_dm_timer_set_int_disable(struct omap_dm_timer *timer, u32 mask)
+static int omap_dm_timer_set_int_disable(struct omap_dm_timer *cookie, u32 mask)
 {
+	struct dmtimer *timer;
 	struct device *dev;
 	u32 l = mask;
 	int rc;
 
+	timer = to_dmtimer(cookie);
 	if (unlikely(!timer))
 		return -EINVAL;
 
@@ -860,10 +971,12 @@ static int omap_dm_timer_set_int_disable(struct omap_dm_timer *timer, u32 mask)
 	return 0;
 }
 
-static unsigned int omap_dm_timer_read_status(struct omap_dm_timer *timer)
+static unsigned int omap_dm_timer_read_status(struct omap_dm_timer *cookie)
 {
+	struct dmtimer *timer;
 	unsigned int l;
 
+	timer = to_dmtimer(cookie);
 	if (unlikely(!timer || !atomic_read(&timer->enabled))) {
 		pr_err("%s: timer not available or enabled.\n", __func__);
 		return 0;
@@ -874,8 +987,11 @@ static unsigned int omap_dm_timer_read_status(struct omap_dm_timer *timer)
 	return l;
 }
 
-static int omap_dm_timer_write_status(struct omap_dm_timer *timer, unsigned int value)
+static int omap_dm_timer_write_status(struct omap_dm_timer *cookie, unsigned int value)
 {
+	struct dmtimer *timer;
+
+	timer = to_dmtimer(cookie);
 	if (unlikely(!timer || !atomic_read(&timer->enabled)))
 		return -EINVAL;
 
@@ -884,8 +1000,11 @@ static int omap_dm_timer_write_status(struct omap_dm_timer *timer, unsigned int 
 	return 0;
 }
 
-static unsigned int omap_dm_timer_read_counter(struct omap_dm_timer *timer)
+static unsigned int omap_dm_timer_read_counter(struct omap_dm_timer *cookie)
 {
+	struct dmtimer *timer;
+
+	timer = to_dmtimer(cookie);
 	if (unlikely(!timer || !atomic_read(&timer->enabled))) {
 		pr_err("%s: timer not iavailable or enabled.\n", __func__);
 		return 0;
@@ -894,8 +1013,11 @@ static unsigned int omap_dm_timer_read_counter(struct omap_dm_timer *timer)
 	return __omap_dm_timer_read_counter(timer);
 }
 
-static int omap_dm_timer_write_counter(struct omap_dm_timer *timer, unsigned int value)
+static int omap_dm_timer_write_counter(struct omap_dm_timer *cookie, unsigned int value)
 {
+	struct dmtimer *timer;
+
+	timer = to_dmtimer(cookie);
 	if (unlikely(!timer || !atomic_read(&timer->enabled))) {
 		pr_err("%s: timer not available or enabled.\n", __func__);
 		return -EINVAL;
@@ -910,7 +1032,7 @@ static int omap_dm_timer_write_counter(struct omap_dm_timer *timer, unsigned int
 
 static int __maybe_unused omap_dm_timer_runtime_suspend(struct device *dev)
 {
-	struct omap_dm_timer *timer = dev_get_drvdata(dev);
+	struct dmtimer *timer = dev_get_drvdata(dev);
 
 	atomic_set(&timer->enabled, 0);
 
@@ -924,7 +1046,7 @@ static int __maybe_unused omap_dm_timer_runtime_suspend(struct device *dev)
 
 static int __maybe_unused omap_dm_timer_runtime_resume(struct device *dev)
 {
-	struct omap_dm_timer *timer = dev_get_drvdata(dev);
+	struct dmtimer *timer = dev_get_drvdata(dev);
 
 	if (!(timer->capability & OMAP_TIMER_ALWON) && timer->func_base)
 		omap_timer_restore_context(timer);
@@ -951,7 +1073,7 @@ static const struct of_device_id omap_timer_match[];
 static int omap_dm_timer_probe(struct platform_device *pdev)
 {
 	unsigned long flags;
-	struct omap_dm_timer *timer;
+	struct dmtimer *timer;
 	struct device *dev = &pdev->dev;
 	const struct dmtimer_platform_data *pdata;
 	int ret;
@@ -1043,7 +1165,7 @@ err_disable:
  */
 static int omap_dm_timer_remove(struct platform_device *pdev)
 {
-	struct omap_dm_timer *timer;
+	struct dmtimer *timer;
 	unsigned long flags;
 	int ret = -EINVAL;
 
diff --git a/include/clocksource/timer-ti-dm.h b/include/clocksource/timer-ti-dm.h
index df3c6c8..77eceea 100644
--- a/include/clocksource/timer-ti-dm.h
+++ b/include/clocksource/timer-ti-dm.h
@@ -59,50 +59,7 @@
 #define OMAP_TIMER_NEEDS_RESET				0x10000000
 #define OMAP_TIMER_HAS_DSP_IRQ				0x08000000
 
-struct timer_regs {
-	u32 ocp_cfg;
-	u32 tidr;
-	u32 tier;
-	u32 twer;
-	u32 tclr;
-	u32 tcrr;
-	u32 tldr;
-	u32 ttrg;
-	u32 twps;
-	u32 tmar;
-	u32 tcar1;
-	u32 tsicr;
-	u32 tcar2;
-	u32 tpir;
-	u32 tnir;
-	u32 tcvr;
-	u32 tocr;
-	u32 towr;
-};
-
 struct omap_dm_timer {
-	int id;
-	int irq;
-	struct clk *fclk;
-
-	void __iomem	*io_base;
-	int		irq_stat;	/* TISR/IRQSTATUS interrupt status */
-	int		irq_ena;	/* irq enable */
-	int		irq_dis;	/* irq disable, only on v2 ip */
-	void __iomem	*pend;		/* write pending */
-	void __iomem	*func_base;	/* function register base */
-
-	atomic_t enabled;
-	unsigned long rate;
-	unsigned reserved:1;
-	unsigned posted:1;
-	struct timer_regs context;
-	int revision;
-	u32 capability;
-	u32 errata;
-	struct platform_device *pdev;
-	struct list_head node;
-	struct notifier_block nb;
 };
 
 int omap_dm_timer_get_irq(struct omap_dm_timer *timer);
