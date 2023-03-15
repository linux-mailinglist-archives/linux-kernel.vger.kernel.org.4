Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3722E6BBF3D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 22:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbjCOVkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 17:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbjCOVkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 17:40:35 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEC7559E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 14:40:34 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-541a39df9f4so105547817b3.20
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 14:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678916433;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0vT5pZgC3odOnq/dCWudlRqWXNT/3pXxM4U4p7g/Zps=;
        b=GBOhli6DgB6C2e3UwLY3hOUyIJJCYvBv89mVgUJNI9rwDtzV+xfm8MeOiM6FEn49Og
         dac3udvhEPDGv68VxZ6KhmgYa4bE5Dz2pnI3o8WNC7zwpdH+SXm0yGK2BrWrxEibNsx8
         QKnsQoEIsXs+afDVgCAFeywJEHRVjsD4xI8bX3UKIZ4GhZqHkz0b+XtP5oLct1tiKV/F
         iYR9De56Y/qllKPi2/15D5E/kuCmnylV9fo3Kt/lp51pvJt+dzgVvcEIMWJNH5RgUhn3
         wmDFBrCXDyMivyyL/lELOeFVcxU8TifaiKU3oAM6dlFLK+vrPqZNEe2nDCphqMJtMcz7
         t7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678916433;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0vT5pZgC3odOnq/dCWudlRqWXNT/3pXxM4U4p7g/Zps=;
        b=dhoY56DtDIbpYGgg5dBjm+41rACsAX7ecR+xPyssNvr6dWno7MJjOEkr7TyUkkfbIS
         D2EQMktlao38Ic9KvgOvOq1BXaw+FACOD9dmEHvn8Z3QNaifNHDzcaNqdMsOgimPiPW7
         dc/mAXnQ9SvZY7ToKsefR30t+kBiGQTtmwqj4QdkuGHLzvBEEsh0UMiVXf5KajjlZjSn
         H+oHSdTDkV68/qyfa/0jMJ/b/q1y0SX6Fn501DptaLutPRWm++to7h9N+2UFGeN2afuQ
         f50P2wfSrJXnU6yQ+tnyzaQ2xRMJ3UN1RTfoHGGRW32H3iAUUoBJ1SQIK2+7Z9w4UvA+
         QHdg==
X-Gm-Message-State: AO0yUKVJ0STY1O/uEXcfDPOEPJznIfewtb27z3AkuHBGRNRig8/x8eBF
        mxYti57ganQIZx8prBHiLkYz9Wjfzeyd
X-Google-Smtp-Source: AK7set+CKIA9ZIEye56laL62srsDkRhvodbIp2AR/zSjX2tYwzng91U5EIxkNpMgpy6cESV4UeWNIkmL36mi
X-Received: from joshdon-desktop.svl.corp.google.com ([2620:15c:2d4:203:d03e:7c5d:386a:dce3])
 (user=joshdon job=sendgmr) by 2002:a05:690c:68d:b0:521:daa4:d687 with SMTP id
 bp13-20020a05690c068d00b00521daa4d687mr1098786ywb.0.1678916433410; Wed, 15
 Mar 2023 14:40:33 -0700 (PDT)
Date:   Wed, 15 Mar 2023 14:40:29 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230315214029.899573-1-joshdon@google.com>
Subject: [PATCH] cgroup: fix display of forceidle time at root
From:   Josh Don <joshdon@google.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Josh Don <joshdon@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to reset forceidle_sum to 0 when reading from root, since the
bstat we accumulate into is stack allocated.

To make this more robust, just replace the existing cputime reset with a
memset of the overall bstat.

Signed-off-by: Josh Don <joshdon@google.com>
---
 kernel/cgroup/rstat.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 831f1f472bb8..0a2b4967e333 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -457,9 +457,7 @@ static void root_cgroup_cputime(struct cgroup_base_stat *bstat)
 	struct task_cputime *cputime = &bstat->cputime;
 	int i;
 
-	cputime->stime = 0;
-	cputime->utime = 0;
-	cputime->sum_exec_runtime = 0;
+	memset(bstat, 0, sizeof(*bstat));
 	for_each_possible_cpu(i) {
 		struct kernel_cpustat kcpustat;
 		u64 *cpustat = kcpustat.cpustat;
-- 
2.40.0.rc1.284.g88254d51c5-goog

