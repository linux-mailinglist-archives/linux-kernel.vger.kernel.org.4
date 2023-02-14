Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6469697067
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 23:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbjBNWEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 17:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbjBNWEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 17:04:42 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC0B3AAA;
        Tue, 14 Feb 2023 14:04:39 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d8so17225339plr.10;
        Tue, 14 Feb 2023 14:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oV3VgFBLdqdFf0Ea+vkgthoqfBBbr34vGspqoFBdBuY=;
        b=ci6jB/L5E5M98Nw7Z5xC1J1e0t9D3ayUJF0Fb03GdIxeHHbkym8/PRcs7av+rDcq1Z
         osJFuYQ8zwoJKUO+5e2xMLXaT6pfQmtI/3I0a2uX6gOH3ZaxXZNdgOJ6QFMBjaWHw3q7
         LMeEpIavISB31JJvk35mO0ZCv35C9poV2uiT3Lz92wgCB3GbwXvrmErdjuapg2PLuk0U
         8n3bV6OteJRnbhggxEMnlylqFr6RB3kQwSBDYgutxYEkVGijTvXdAFNb1cJpk2BPt2L8
         HRFL1nw32Oz854hiCrt7iUQs1iC0DyKo4p2UzdzHuHnDmvHPcs5LMz7/w1UhAGTfrgqM
         22NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oV3VgFBLdqdFf0Ea+vkgthoqfBBbr34vGspqoFBdBuY=;
        b=N/+Nq5KuAAduIjxKjnwSpJZPBwdZqngZ8cAZdwOkOKQQc8uf3xx3r8j8b6dOxL555p
         tREu3rB29vWw+n2ovw1490fsvBPyLpsDPFEx4+f8yvumh7corJzBG9aJAp9h/oTS1ZIQ
         zqBbnWnTkmKA4S8xtFfPPnSjLwBVCsnCVFYqwF5h5rhRKGPkZMFjCxk9fK2Zkfg9GRd9
         EkT1+iKf+U2fqniDQKP9vIoe+ny4MxX3oNWnAjFUzf1VFlmWnQLajNleneJAZLOohz++
         0wiY879EwR/TRO+VHqXbCcIRY6WXzWlc6gwaEOdBoqFY+dHoxjBaqaKGN3cmM42PCMSY
         jrow==
X-Gm-Message-State: AO0yUKVkH8xLAX5vinkfmCBVte+w2L9sdLWuyyGaVP9Alv1RbrcVmPnm
        vpVYvXpQHFELRRF2yYRP+w9oALKDeQ6Pbg==
X-Google-Smtp-Source: AK7set+JFYJC70ppqj6wFSZKns7z/qYnwZw5g3Dtklhm0QZPoVE5Foy6hPNHInIp/4cr3C64xgUXWQ==
X-Received: by 2002:a17:90b:4b0b:b0:233:e940:d3f9 with SMTP id lx11-20020a17090b4b0b00b00233e940d3f9mr347227pjb.34.1676412279094;
        Tue, 14 Feb 2023 14:04:39 -0800 (PST)
Received: from kazuki-mac.lan ([2400:4051:ea3:5910::19a])
        by smtp.gmail.com with ESMTPSA id e17-20020a17090ab39100b00233e8a83853sm23759pjr.34.2023.02.14.14.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 14:04:38 -0800 (PST)
From:   Kazuki Hashimoto <kazukih0205@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Kazuki Hashimoto <kazukih0205@gmail.com>
Subject: [PATCH] PM: s2idle: Don't allow s2idle when cpuidle isn't supported
Date:   Wed, 15 Feb 2023 06:50:03 +0900
Message-Id: <20230214215003.70683-1-kazukih0205@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s2idle isn't supported on platforms that don't support cpuidle as of
31a3409065d1 ("cpuidle / sleep: Do sanity checks in cpuidle_enter_freeze()
too"), so update the suspend framework to reflect this in order to avoid
breakages.

Link: https://lore.kernel.org/all/20230204152747.drte4uitljzngdt6@kazuki-mac
Fixes: 31a3409065d1 ("cpuidle / sleep: Do sanity checks in cpuidle_enter_freeze() too")
Signed-off-by: Kazuki Hashimoto <kazukih0205@gmail.com>
---
 kernel/power/suspend.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 3f436282547c..27507ae7c9c9 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -556,6 +556,12 @@ static int enter_state(suspend_state_t state)
 
 	trace_suspend_resume(TPS("suspend_enter"), state, true);
 	if (state == PM_SUSPEND_TO_IDLE) {
+		struct cpuidle_device *dev = cpuidle_get_device();
+		struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
+
+		if (cpuidle_not_available(drv, dev))
+			return -EINVAL;
+
 #ifdef CONFIG_PM_DEBUG
 		if (pm_test_level != TEST_NONE && pm_test_level <= TEST_CPUS) {
 			pr_warn("Unsupported test mode for suspend to idle, please choose none/freezer/devices/platform.\n");
-- 
2.39.1

