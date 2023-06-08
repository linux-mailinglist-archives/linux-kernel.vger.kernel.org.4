Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD69727747
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 08:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234706AbjFHGda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 02:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234391AbjFHGd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 02:33:27 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8596F1BE8
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 23:33:26 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-259b2afc6f1so100710a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 23:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686206006; x=1688798006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ThwqC+krzh+2HIXN6ZtBSjBsnlooT1bTYDZhSyyq2Do=;
        b=fwyWZNTAswJohNjeX7VWigJnwFcrIvVzvOfhU6GXq6C+tAfcdY7hkkaaS8IM6HkW2R
         3Gpb7PxNpjeoyR46xYNg33w5asTFwlTBJrL//uRKc/qqIBy7+CUT4dgHeqQFZUWYGEu9
         sZvHhOb3k/50apo3bkxj1/tXOpRvCUy5cQi4kZ9IVSmsHRpME5+2YPILabC2Wozfnu/M
         /R5zysC3HI1LTvChWNRHNuZO4lqX4nMf1yvG3omKCZb0gm94mc13EChBN7MjVP59kl7T
         bgpNPWcA/1Rrli6Z8u4Lmh0Fk8Z0yx/2srSwi/ry5WmV6qHHH2OxubrrZLwDG+JGB7ov
         3g0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686206006; x=1688798006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ThwqC+krzh+2HIXN6ZtBSjBsnlooT1bTYDZhSyyq2Do=;
        b=A7SAV9FmSpPBXJEdKrnHoKsdoebz9aoV4CY4F/JZLM157evJKsmH+P/325XVeAiUYV
         1TvwKCkjoesEBk9ATWbZHnML8WnlMwKVws0bG6/koPwTTZuYbwDxdp7xi6ZlpqZp2PGg
         /xjuPSZhhZgMHkUQwVw9LzqPNfsVTCwj4DixiXGIxH3cFQQZJ3ug9z5AJE+lgQxpCef1
         vCZ+78mELNi/Z4MsGvzqcrlSZm0fo6rqtNfB+hp1VykxCGaPJIWRDYrmfT/dKP0171pk
         ef0dcdbDjxyEX9niTRWOYB8x+lXOt0IVkzKC3UFumyb0euKI2XqMZejgzoxjfMn28Er1
         /O0Q==
X-Gm-Message-State: AC+VfDzezz7onvvytpaknIJj1DrW7fn9UOkKVFrn127FblKEdxHstiC7
        Dfcj1J2RlKameYchLCxbsmYZLg==
X-Google-Smtp-Source: ACHHUZ78LhECc4D3NUYy9DgUzMq8xc9Yu5OUSSgT9bjQYfFBfNtZdnZyUUZFLfxwEQyxb69plrR0dw==
X-Received: by 2002:a17:90a:1db:b0:259:cafc:4e08 with SMTP id 27-20020a17090a01db00b00259cafc4e08mr1719435pjd.29.1686206006006;
        Wed, 07 Jun 2023 23:33:26 -0700 (PDT)
Received: from C02G87K0MD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id c15-20020a17090abf0f00b0025645d118adsm542039pjs.14.2023.06.07.23.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 23:33:25 -0700 (PDT)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH v4 0/4] Fix some warnings about rq clock
Date:   Thu,  8 Jun 2023 14:33:08 +0800
Message-Id: <20230608063312.79440-1-jiahao.os@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These four patches fix some warnings about rq clock.

Patch1 fixes the warning of using the old rq clock caused by
missing update rq clock.

Patch2-4 fixes the warning that the rq clock was updated multiple
times while holding the rq lock.

v3->v4:
    - Add Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org> for
      all patches.

v2->v3:
    - Modify the commit information of patch1 to make the description clearer.
    - Split v2 patch2 into 3 separate patches.

v1->v2:
    - Vincent Guittot suggested using rq_clock_start_loop_update()
      to prevent multiple calls to update_rq_clock() in unthrottle_cfs_rq()
      instead of removing update_rq_clock() from unthrottle_cfs_rq()
      and updating the rq clock before unthrottle_cfs_rq() for patch2.

[v2] https://lore.kernel.org/all/20230510083450.62334-1-jiahao.os@bytedance.com
[v1] https://lore.kernel.org/all/20230410081206.23441-1-jiahao.os@bytedance.com


Hao Jia (4):
  sched/core: Fixed missing rq clock update before calling
    set_rq_offline()
  sched/core: Avoid double calling update_rq_clock() in
    __balance_push_cpu_stop()
  sched/core: Avoid multiple calling update_rq_clock() in
    __cfsb_csd_unthrottle()
  sched/core: Avoid multiple calling update_rq_clock() in
    unthrottle_offline_cfs_rqs()

 kernel/sched/core.c     |  7 ++++---
 kernel/sched/fair.c     | 18 ++++++++++++++++++
 kernel/sched/sched.h    | 21 +++++++++++++++++++++
 kernel/sched/topology.c | 10 ++++++----
 4 files changed, 49 insertions(+), 7 deletions(-)

-- 
2.37.0 (Apple Git-136)

