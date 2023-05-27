Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B8A71319D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 03:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjE0Bme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 21:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242942AbjE0Bmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 21:42:31 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5286E4E
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 18:42:18 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-64d44b198baso1094592b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 18:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685151738; x=1687743738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXckUaQ/Den31trhbx+i2KR50Js/yPFH+sDpvHnJKzE=;
        b=k5hflWz1ojXxjFKRiwHgsk5p/ZbmXIIfYfK4EdK0UtXLo2Tbb74nHxOJ8I17Sf9sxy
         7MD+TcUADQQ+iohHT+1kqBlvhx1hOCsgxOD4ajd121XAcoVe7I9JgK6CPn4SYzCJm/ol
         YM9N2ByDO4u3BG+dWzNDW3yTIS6cbMGQWCxnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685151738; x=1687743738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FXckUaQ/Den31trhbx+i2KR50Js/yPFH+sDpvHnJKzE=;
        b=X2XBg+g57djfujAjFl+8yD2tU/UuUaNmMI8P+JVG/1lXZnu4FPiUMNw5THsC2QKqKK
         yXzmbSezs6RjZeS9SAOyYQ9fws+bLeE1lWR3tVVmGlSsvezDcU8BrRn2TDzGSQf4J/Lh
         pvx4N9g3S1edkHqHCxBwFJ9eWwy5FTFL7twK1vamXx95noS6sjNajfhSpnY22/9ZLfe8
         zX8qpKmJR8WhlHibJwQnfdfhocSsDEzAKbF3Yroi76dGSJcUlXkrybXNUYgL+Lo6AeTh
         jF6h/5/UAid6NbT082orvPGXaCOR4+zumIU7+AA7QHgjoLOlfgtLmCgVR5OqkeBlVlWn
         ONAg==
X-Gm-Message-State: AC+VfDx3tWL8ccCr5p9Q348ep+2O4h3AjMPA4V40TluOoFaro1DZTFvc
        4Gjf2wmYPYaPRhVxt7pP3hk5YA==
X-Google-Smtp-Source: ACHHUZ7tQKomhZw+AyOO+6VKcS+sY1Y2WDAS5xt3xizvvLTbv73yPg/Ctnx4geaFhMkCoPBSd4R4lw==
X-Received: by 2002:a05:6a00:1586:b0:648:a518:4ac6 with SMTP id u6-20020a056a00158600b00648a5184ac6mr1023104pfk.14.1685151738030;
        Fri, 26 May 2023 18:42:18 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:4015:7255:c79a:26d7])
        by smtp.gmail.com with ESMTPSA id x25-20020aa79199000000b0063b8ddf77f7sm3202440pfa.211.2023.05.26.18.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 18:42:17 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        sparclinux@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        linux-perf-users@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 01/10] watchdog/hardlockup: Keep kernel.nmi_watchdog sysctl as 0444 if probe fails
Date:   Fri, 26 May 2023 18:41:31 -0700
Message-ID: <20230526184139.1.I0d75971cc52a7283f495aac0bd5c3041aadc734e@changeid>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
In-Reply-To: <20230527014153.2793931-1-dianders@chromium.org>
References: <20230527014153.2793931-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The permissions for the kernel.nmi_watchdog sysctl have always been
set at compile time despite the fact that a watchdog can fail to
probe. Let's fix this and set the permissions based on whether the
hardlockup detector actually probed.

Fixes: a994a3147e4c ("watchdog/hardlockup/perf: Implement init time detection of perf")
Reported-by: Petr Mladek <pmladek@suse.com>
Closes: https://lore.kernel.org/r/ZHCn4hNxFpY5-9Ki@alley
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 include/linux/nmi.h |  6 ------
 kernel/watchdog.c   | 30 ++++++++++++++++++++----------
 2 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index 333465e235e1..3a27169ec383 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -95,12 +95,6 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs);
 static inline void arch_touch_nmi_watchdog(void) { }
 #endif
 
-#if defined(CONFIG_HAVE_NMI_WATCHDOG) || defined(CONFIG_HARDLOCKUP_DETECTOR)
-# define NMI_WATCHDOG_SYSCTL_PERM	0644
-#else
-# define NMI_WATCHDOG_SYSCTL_PERM	0444
-#endif
-
 #if defined(CONFIG_HARDLOCKUP_DETECTOR_PERF)
 extern void hardlockup_detector_perf_stop(void);
 extern void hardlockup_detector_perf_restart(void);
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 237990e8d345..4b9e31edb47f 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -880,15 +880,6 @@ static struct ctl_table watchdog_sysctls[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= (void *)&sixty,
 	},
-	{
-		.procname       = "nmi_watchdog",
-		.data		= &watchdog_hardlockup_user_enabled,
-		.maxlen		= sizeof(int),
-		.mode		= NMI_WATCHDOG_SYSCTL_PERM,
-		.proc_handler   = proc_nmi_watchdog,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
 	{
 		.procname	= "watchdog_cpumask",
 		.data		= &watchdog_cpumask_bits,
@@ -952,10 +943,28 @@ static struct ctl_table watchdog_sysctls[] = {
 	{}
 };
 
+static struct ctl_table watchdog_hardlockup_sysctl[] = {
+	{
+		.procname       = "nmi_watchdog",
+		.data		= &watchdog_hardlockup_user_enabled,
+		.maxlen		= sizeof(int),
+		.mode		= 0444,
+		.proc_handler   = proc_nmi_watchdog,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+	{}
+};
+
 static void __init watchdog_sysctl_init(void)
 {
 	register_sysctl_init("kernel", watchdog_sysctls);
+
+	if (watchdog_hardlockup_available)
+		watchdog_hardlockup_sysctl[0].mode = 0644;
+	register_sysctl_init("kernel", watchdog_hardlockup_sysctl);
 }
+
 #else
 #define watchdog_sysctl_init() do { } while (0)
 #endif /* CONFIG_SYSCTL */
@@ -1011,6 +1020,8 @@ static int __init lockup_detector_check(void)
 	/* Make sure no work is pending. */
 	flush_work(&detector_work);
 
+	watchdog_sysctl_init();
+
 	return 0;
 
 }
@@ -1030,5 +1041,4 @@ void __init lockup_detector_init(void)
 		allow_lockup_detector_init_retry = true;
 
 	lockup_detector_setup();
-	watchdog_sysctl_init();
 }
-- 
2.41.0.rc0.172.g3f132b7071-goog

