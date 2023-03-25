Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B04D6C8FC7
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 18:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbjCYReD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 13:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbjCYReB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 13:34:01 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B528C677
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 10:33:53 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id g19so4488556qts.9
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 10:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1679765631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OoiJ+FwScF+MZSYtj9PNd5p2Qh+BP90RdH8736/Rk7Q=;
        b=lNoPikM5G/4FWXmuDYNdnjBZ+MKG1FY06E45YaSkPZLv1XxeQcSCt4yYXm7v1nLxuh
         qGK1QP4xSquoa9wjmVGbBEOJd0xQRXV0ewGh3rPCtN7klT9gpt4leSqSe6fJLEVbR0vJ
         oskrmwXqaoTpRILy16HLYbN538lVa5rjz9zO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679765631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OoiJ+FwScF+MZSYtj9PNd5p2Qh+BP90RdH8736/Rk7Q=;
        b=zoYi6KvqDGgUMltzRNhONLOLQy+DEjzwc0fLPPpMn1Daq29PbW74ziqPpDBgH0TNVo
         k+ztr++k+3/V1reqsMHB8lc2r9oJW/+TuxCVncapwwyZaoF3wLDi8WNv6Rykwd8xZQAK
         Jy1cruXgF6W1XlAAAbcg/O9T8DufGomRLKLRn7mwgnBwQEU6+QfqrYaZLQ+/K00GHjrN
         uc713KCmvLJu1dL7jE2kMocguSGubZUnKTG8SHKncdyoFHqcT7oPGW2Jm1sKybs/1u4d
         cbz1+xEtAENAZvY2nhRF6puUh8WYEEW+RkvFiCFRo8jOVqBga5AQVYczWzGlqKH6Mm9+
         xn/Q==
X-Gm-Message-State: AO0yUKXZYythhxCDaCFj6TfsEpQ/RbLB37B6iS4S6f1jGDOTXSHpAZQ4
        upYUJjn1s/ra4T7e0ZzLKc1MtR/KNM/QrKB6W9k=
X-Google-Smtp-Source: AKy350ZgAy87j82p90TbWuf29LyF8qI6fxDAdCMVnTg4//07CDSOkNnsp+SS7nIwBuVPmWxAGJUBdw==
X-Received: by 2002:ac8:5ad1:0:b0:3bd:140c:91f7 with SMTP id d17-20020ac85ad1000000b003bd140c91f7mr11530099qtd.40.1679765631640;
        Sat, 25 Mar 2023 10:33:51 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id m4-20020ac84444000000b003e37ee54b5dsm6762764qtn.90.2023.03.25.10.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 10:33:51 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v2 00/13] Core RCU patches for 6.4
Date:   Sat, 25 Mar 2023 17:33:03 +0000
Message-Id: <20230325173316.3118674-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

These are core RCU patches for 6.4. I am resending as there are few more
patches for MAINTAINERS file changes, and few more tags. Plus I dropped the
Frederick's patch that Thomas took in for fixing the entry code.

o  MAINTAINERS files additions and changes.

o  Fix hotplug warning in nohz code.

o  Tick dependency changes by Zqiang.

o  Lazy-RCU shrinker fixes by Zqiang.

o  rcu-tasks stall reporting improvements by Neeraj.

o  Other changes.

Let me know if any objections to anything.

thanks,

 - Joel

Boqun Feng (1):
  MAINTAINERS: Add Boqun to RCU entry

Joel Fernandes (Google) (3):
  MAINTAINERS: Change Joel Fernandes from R: to M:
  MAINTAINERS: Add Zqiang as a RCU reviewer
  tick/nohz: Fix cpu_is_hotpluggable() by checking with nohz subsystem

Neeraj Upadhyay (1):
  rcu-tasks: Report stalls during synchronize_srcu() in
    rcu_tasks_postscan()

Xu Panda (1):
  rcu/trace: use strscpy() to instead of strncpy()

Zheng Yejian (1):
  rcu: Avoid stack overflow due to __rcu_irq_enter_check_tick() being
    kprobe-ed

Zqiang (6):
  rcu: Fix set/clear TICK_DEP_BIT_RCU_EXP bitmask race
  rcu: Fix missing TICK_DEP_MASK_RCU_EXP dependency check
  rcu: Register rcu-lazy shrinker only for CONFIG_RCU_LAZY=y kernels
  rcu: Remove never-set needwake assignment from rcu_report_qs_rdp()
  rcu: Permit start_poll_synchronize_rcu_expedited() to be invoked early
  rcu: Protect rcu_print_task_exp_stall() ->exp_tasks access

 MAINTAINERS                  |  4 +++-
 drivers/base/cpu.c           |  3 ++-
 include/linux/tick.h         |  2 ++
 include/trace/events/rcu.h   |  4 +---
 include/trace/events/timer.h |  3 ++-
 kernel/rcu/tasks.h           | 31 +++++++++++++++++++++++++++++++
 kernel/rcu/tree.c            | 16 +++++++++-------
 kernel/rcu/tree_exp.h        | 16 ++++++++++------
 kernel/rcu/tree_nocb.h       |  4 ++++
 kernel/time/tick-sched.c     | 16 +++++++++++++---
 10 files changed, 77 insertions(+), 22 deletions(-)

-- 
2.40.0.348.gf938b09366-goog

