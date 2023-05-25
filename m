Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991E6711AAA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 01:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234810AbjEYX3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 19:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjEYX3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 19:29:43 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D55E7
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 16:29:41 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-2533ed4f1dcso218957a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 16:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685057381; x=1687649381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qMNG40o2Yy1n8pxFY4abVPnOji+eS2T0lr/rCDAwCsM=;
        b=CkbRAF25xVCJP5p1u3ZVs4erwAQ6+0fCM8G7ivdQEXVSLxuGOuwjNxPev1D/HT+je5
         HPJtplXtVikWnFvmzn7FGfuMWThb0vdAR3YZiYUz87yk7TE3f5D8imiV2cG/oK79Vs1R
         yAnorydP22MRXZbafW49ZO4P8gyO5t0lckC44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685057381; x=1687649381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qMNG40o2Yy1n8pxFY4abVPnOji+eS2T0lr/rCDAwCsM=;
        b=ZUwaGAXonJcjZyqJg/V8ApHgKcQltUCWGBGNcKb8WWMsqJaLsfgL4DCgJuK6KMM3g1
         AWnxQqbPfCdCi8lpza2NR+NuNRCGoMtvKJuAd/kqCkMsyeHHysATPfP9IUkoVe2CIpAt
         /FHEt0lMIKINF/z3c/9Hs0OuAEiwjuRN0JTokNjENXqCO0NpPaILMx93D0F9lAo1yEEa
         NEfL1FPVAKZSwmUJIqtwexPnW79LR5EcFA82sS/eUmd+x3j3puWAoEf3WV5eSbw1Vz2U
         DapDvzLIDDWG0nmi09ncysTfqLihM+8TkV3YKnE2sWZ5IBd0FNlj/eYao60vucsex7ak
         5a2Q==
X-Gm-Message-State: AC+VfDzN7EQL7YeGK1pRGjxf2TP4Ig2V71pcEHssia2EsXCwSSCQHlFH
        0UP+I37vet4xSUIaEz0gTmqNmg==
X-Google-Smtp-Source: ACHHUZ7E7gvQO8/T7dOZsj2pO3ari1eRKRZxK5OV+NNNLptVMrehMhR/BIEKHCoUQFT9qWwAXCdU+A==
X-Received: by 2002:a17:902:8483:b0:1aa:feca:b616 with SMTP id c3-20020a170902848300b001aafecab616mr325594plo.65.1685057380875;
        Thu, 25 May 2023 16:29:40 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:193f:721d:e41f:9c62])
        by smtp.gmail.com with ESMTPSA id t16-20020a170902e85000b001ac912cac1asm1920225plg.175.2023.05.25.16.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 16:29:40 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Tom Rix <trix@redhat.com>, Petr Mladek <pmladek@suse.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: delete old declarations for watchdog_soft,hardlockup_user_enabled + make static
Date:   Thu, 25 May 2023 16:28:32 -0700
Message-ID: <20230525162822.1.I0fb41d138d158c9230573eaa37dc56afa2fb14ee@changeid>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

smatch reports
kernel/watchdog.c:40:19: warning: symbol
  'watchdog_hardlockup_user_enabled' was not declared. Should it be static?
kernel/watchdog.c:41:19: warning: symbol
  'watchdog_softlockup_user_enabled' was not declared. Should it be static?

These variables are only used in their defining file, so they should
be static.

This problem showed up after the patch ("watchdog/hardlockup: rename
some "NMI watchdog" constants/function") because that rename missed
the header file. That didn't cause any compile-time errors because,
since commit dd0693fdf054 ("watchdog: move watchdog sysctl interface
to watchdog.c"), nobody outside of "watchdog.c" was actually referring
to them. Thus, not only should we make these variables static but we
should remove the old declarations in the header file that we missed
renaming.

Fixes: 4b95b620dcd5 ("watchdog/hardlockup: rename some "NMI watchdog" constants/function")
Signed-off-by: Tom Rix <trix@redhat.com>
[dianders: updated subject + commit message; squashed in Petr's suggestion]
Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
This is a squash of two patches that were posted to mailing lists, one
official patch posted by Tom [1] and one that was posted in reply to
my previous patch by Petr [2].

IMO it makes sense to put these two things into one patch since
they're basically dealing with the same issue. As promised [3] I'm
posting the squash of the two patches.

I have no idea how to really tag this and set authorship. I've chosen
to leave author/Signed-off-by from Tom. Peter didn't officially
include his Singed-off-by on his patch (as is common when posting
suggestions in reply to another patch), so I didn't add it but added a
Suggested-by from him. Hopefully this is OK. I dropped Mukesh's
Reviewed-by just because it felt like things changed enough with the
addition of Petr's stuff that it should be re-added.

I've tagged this as "Fixes" based on the git hash in the current
linuxnext.

[1] https://lore.kernel.org/r/20230523122324.1668396-1-trix@redhat.com
[2] https://lore.kernel.org/r/ZG4TW--j-DdSsUO6@alley/
[3] https://lore.kernel.org/all/CAD=FV=V_i5wR4oNy+xarA9e=VcgpH6i3U1uxFKtsaOe5AQX=Zw@mail.gmail.com/

 include/linux/nmi.h | 6 ++----
 kernel/watchdog.c   | 4 ++--
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index d23902a2fd49..333465e235e1 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -18,8 +18,6 @@ void lockup_detector_soft_poweroff(void);
 void lockup_detector_cleanup(void);
 
 extern int watchdog_user_enabled;
-extern int nmi_watchdog_user_enabled;
-extern int soft_watchdog_user_enabled;
 extern int watchdog_thresh;
 extern unsigned long watchdog_enabled;
 
@@ -70,8 +68,8 @@ static inline void reset_hung_task_detector(void) { }
  * 'watchdog_enabled' variable. Each lockup detector has its dedicated bit -
  * bit 0 for the hard lockup detector and bit 1 for the soft lockup detector.
  *
- * 'watchdog_user_enabled', 'nmi_watchdog_user_enabled' and
- * 'soft_watchdog_user_enabled' are variables that are only used as an
+ * 'watchdog_user_enabled', 'watchdog_hardlockup_user_enabled' and
+ * 'watchdog_softlockup_user_enabled' are variables that are only used as an
  * 'interface' between the parameters in /proc/sys/kernel and the internal
  * state bits in 'watchdog_enabled'. The 'watchdog_thresh' variable is
  * handled differently because its value is not boolean, and the lockup
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 877d8670f26e..237990e8d345 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -37,8 +37,8 @@ static DEFINE_MUTEX(watchdog_mutex);
 
 unsigned long __read_mostly watchdog_enabled;
 int __read_mostly watchdog_user_enabled = 1;
-int __read_mostly watchdog_hardlockup_user_enabled = WATCHDOG_HARDLOCKUP_DEFAULT;
-int __read_mostly watchdog_softlockup_user_enabled = 1;
+static int __read_mostly watchdog_hardlockup_user_enabled = WATCHDOG_HARDLOCKUP_DEFAULT;
+static int __read_mostly watchdog_softlockup_user_enabled = 1;
 int __read_mostly watchdog_thresh = 10;
 static int __read_mostly watchdog_hardlockup_available;
 
-- 
2.41.0.rc0.172.g3f132b7071-goog

