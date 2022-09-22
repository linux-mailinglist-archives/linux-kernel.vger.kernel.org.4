Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433085E678D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 17:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbiIVPub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 11:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbiIVPuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 11:50:19 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1003797ECA
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 08:50:10 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so2578418pjh.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 08:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=+K8j+06amGtBzqeg3LNqPUQmrr7rn1eOJcYvflTHpZU=;
        b=lOHQ8lKwbjZvnvS3yQLZcUqXmMeEsdLz6FNSdk+7PMZ7YY/m+r2qhSSiySViGuXDpS
         cIX5pBPGnOBnVHl2Tor8dhRbEHujEh3n5/qotF3PiI4uiApxJQQuQ43eP64gPDGTDhej
         2lqiXVbf0UDSzN+d/1zaVyg5z3hsrKD44qJHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=+K8j+06amGtBzqeg3LNqPUQmrr7rn1eOJcYvflTHpZU=;
        b=Wp2MbpYXMRdAyUETTFZ62FkK4KOsrLwvTgBeq8q2CRyygoqtD1PPi6QgSL2rHCeD58
         iC8qRCJTTGPWXut9/5Att5qD+4+1Q+y4gcFcRFkc+UZwZZOK9C8lA8tfv7pFcCGQ/ZMr
         IegGKu62e5I/l2cPN1dtJp1wA4p/AZs1mYEMC2cI/TXH6u7JGxsNSfisoMW3D6HcGLCo
         JYtW2R2xaj77pqSs1XFFmqsfFNKhjiKf3SsCd+m3ePzIyDZB/sp6S9X1++d5j3ItvoRT
         XqfHkpmZLRFeOnmURGcLOpYkCL4AIKddA4xivacps3wUHXWMBhcZfZfznYld8kKFTFn7
         +9gA==
X-Gm-Message-State: ACrzQf2KWPFijFiIroMtdqmW6PmCzVJDsbOqn46Q+F7E1qnpWpMo67CZ
        l0EMwwHC/4Z9elTyLEJEqhmEdw==
X-Google-Smtp-Source: AMsMyM5+8V2TbVOIhMKjrSqfuProxMDRnSuL6sl56sCUeKf7dIX/0qlV5tFaFwUmF1ejQN105A0zzQ==
X-Received: by 2002:a17:902:8307:b0:172:e611:491f with SMTP id bd7-20020a170902830700b00172e611491fmr3831261plb.111.1663861810112;
        Thu, 22 Sep 2022 08:50:10 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:5321:6ad9:3932:13d8])
        by smtp.gmail.com with ESMTPSA id 145-20020a630097000000b00439c1e13112sm4049425pga.22.2022.09.22.08.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 08:50:09 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     rafael@kernel.org, sboyd@kernel.org
Cc:     linux-pm@vger.kernel.org, len.brown@intel.com,
        gregkh@linuxfoundation.org, pavel@ucw.cz,
        linux-clk@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] PM: clk: Avoid lockdep warning between prepare lock and &psd->lock
Date:   Thu, 22 Sep 2022 08:49:58 -0700
Message-Id: <20220922084941.RFC.1.I206ec946a190e3de9fd13be806498821e9a6612d@changeid>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If you get the exact right boot sequence / timing / hardware setup,
lockdep can complain at bootup about an unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&psd->clock_mutex);
                               lock(prepare_lock);
                               lock(&psd->clock_mutex);
  lock(prepare_lock);

The case of &psd->clock_mutex being grabbed before the prepare lock is
illustrated by this stack crawl:

  clk_prepare_lock()
  clk_unprepare()
  clk_disable_unprepare()
  pm_clk_suspend()
  pm_clk_runtime_suspend()

The critical things to note are:
- pm_clk_suspend(), in some cases, will grab and hold
  "&psd->clock_mutex" first before calling the clock prepare/unprepare
  functions.
- pm_clk_suspend() can be called in cases where the clock prepare
  mutex isn't already held.

The reverse case, where the prepare lock is held first and then the
&psd->clock_mutex is illustrated by:

  pm_clk_op_lock()
  pm_clk_resume()
  pm_generic_runtime_resume()
  ...
  pm_runtime_resume_and_get()
  clk_pm_runtime_get()
  __clk_core_init()
  __clk_register()
  clk_hw_register()

In the above:
- __clk_core_init() grabs the prepare lock and holds it while calling
  clk_pm_runtime_get().
- pm_clk_op_lock() grabs &psd->clock_mutex.

Presumably nobody noticed this before because it only happens in one
specific case of the pm_clk code. It's also possible that it was
unnoticed before because the clock prepare lock is a funny little
animal and allows the lock to be acquired more than once in a given
callchain but lockdep doesn't really track this.

Let's fix this lockdep error by just consistently grabbing the clock
prepare lock before &psd->clock_mutex. This means adding a private
interface since the clock's prepare lock isn't exposed. We'll add it
in a way to discourage anyone else from using it. We're special since
"pm_clk" is core code and already quite intertwined with the clock
core anyway.

NOTE: I haven't done any analysis about whether what lockdep complains
about is really a feasible lockup. I merely confirmed that, indeed, we
have an ABBA situation and it seems like we should fix it.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
As you can tell at just a glance, this is a terrible hack. I'm mostly
throwing it out into the world to try to start a conversation. I'd be
very happy for someone else to send a better patch or to tell me of a
better way to solve this. I've still tried to at least make it a
landable patch, however, in case nobody has any better ideas and we
want to land this.

I'll note that this lockdep warning showed up on my system at the same
time as a deadlock. Unfortunately, to the best of my ability to debug
the two are unrelated. Fixing this lockdep warning doesn't fix the
deadlock and fixing the deadlock doesn't make lockdep happy. If you
want to see my fix for the deadlock, feel free to peruse:

https://lore.kernel.org/r/20220922154354.2486595-1-dianders@chromium.org

NOTE: problem was found and debugging was done on a downstream kernel
(chromeos-5.15), not pure upstream. I see no reason why this won't
apply to upstream, but if you have some belief that this problem is
already solved or can't happen upstream then please yell and tell me
that I should abandon this patch.

If need be, I can also split this into two patches. I figured I'd do
that on-demand if someone actually told me that would be useful to
them and that they were considering landing this patch.

 drivers/base/power/clock_ops.c | 14 ++++++++++++++
 drivers/clk/clk.c              | 12 ++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
index 4110c19c08dc..86066d5a00d9 100644
--- a/drivers/base/power/clock_ops.c
+++ b/drivers/base/power/clock_ops.c
@@ -18,6 +18,13 @@
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 
+/*
+ * These are purposely not in any headers since we don't want anyone to use
+ * them except us.
+ */
+void __clk_prepare_lock(void);
+void __clk_prepare_unlock(void);
+
 #ifdef CONFIG_PM_CLK
 
 enum pce_status {
@@ -108,6 +115,10 @@ static int pm_clk_op_lock(struct pm_subsys_data *psd, unsigned long *flags,
 
 	/* we must switch to the mutex */
 	spin_unlock_irqrestore(&psd->lock, *flags);
+
+	/* Manually grab the prepare lock to avoid ABBA w/ psd->clock_mutex */
+	__clk_prepare_lock();
+
 	mutex_lock(&psd->clock_mutex);
 
 	/*
@@ -118,6 +129,8 @@ static int pm_clk_op_lock(struct pm_subsys_data *psd, unsigned long *flags,
 		return 0;
 
 	mutex_unlock(&psd->clock_mutex);
+	__clk_prepare_unlock();
+
 	goto try_again;
 }
 
@@ -132,6 +145,7 @@ static void pm_clk_op_unlock(struct pm_subsys_data *psd, unsigned long *flags)
 {
 	if (psd->clock_op_might_sleep) {
 		mutex_unlock(&psd->clock_mutex);
+		__clk_prepare_unlock();
 	} else {
 		/* the __acquire is there to work around sparse limitations */
 		__acquire(&psd->lock);
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index bd0b35cac83e..bf563b3fa5f4 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -149,6 +149,18 @@ static void clk_prepare_unlock(void)
 	mutex_unlock(&prepare_lock);
 }
 
+/* Non-static wrapper of lock function for drivers/base/power/clock_ops.c */
+void __clk_prepare_lock(void)
+{
+	clk_prepare_lock();
+}
+
+/* Non-static wrapper of unlock function for drivers/base/power/clock_ops.c */
+void __clk_prepare_unlock(void)
+{
+	clk_prepare_unlock();
+}
+
 static unsigned long clk_enable_lock(void)
 	__acquires(enable_lock)
 {
-- 
2.37.3.968.ga6b4b080e4-goog

