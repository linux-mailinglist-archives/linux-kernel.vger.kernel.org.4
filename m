Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CC26FD992
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236607AbjEJIg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236215AbjEJIgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:36:02 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644167EDC
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 01:35:04 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-250252e4113so4442416a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 01:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1683707701; x=1686299701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B+pxvGwx4qB2jHtPFwxz+r1x0GCU+Pru3QTkQf29r70=;
        b=XS4lXvC8vT8nuNkAPeVfxGO6MExeVGMlRdfuS1WsmFBoO9YOIkIy3P47jFVVbltmFA
         XEQTbQ4Z2KX6LnkdjTiv52RO8aSkyYW60JN1sT9m/DVCIBXCRuiZVgIVEYsK16tkDh2a
         J1S8GxrQ/zGBGJEULn/ByH+kY2byciWSyADTPu6XvO3jUC96V9uGqKTO+fteZZE6Sgzm
         MrrhoUI9ngx0C7mrBDOP43CtCqn/2vtQg2JRBEt0CUWLefphHHjf8xyd/PbFgjsZeapB
         XvdxREPMKu+/9NNeM0phepmBcD5pQliENE0Fzy6ttrttM/qYvHC60kCYebUSUDitPbw7
         4qMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683707701; x=1686299701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B+pxvGwx4qB2jHtPFwxz+r1x0GCU+Pru3QTkQf29r70=;
        b=X9vYP0MMXDUxA2thQqRKtrQySZWOwMaXnQVK8bZ76u9x4TUNGYO3Nmcoh+SwA+IDUZ
         ZXqAnjvYxnduX3zTP7LnAgUfP0IuWFNDMilyChya6q4IQZN0iQ4l2Xlj8hA9l8xvqIv8
         Xmm5yecRpMHflHtk27uhQG7IbRd7o8XMkEeewPFS1Gy8i7CbbZhE0G/M76detSut7syM
         UUaoGLGFSrZP1gZZtdURPDDIBQJWoiybRV5cjqIC2aM4QUgEZcHA/zfqugMYhep/JHN6
         O7F+IVInl3Ax9D1xR8njNsFWzXartu0gowtawjnVM01cXfT6Eevgo/erBWdjyTbjP9Os
         7aBA==
X-Gm-Message-State: AC+VfDwfRQXCPQ29P0ysHupNoBz7c9pF9aaay8OA2M7egkhzPid4vhxI
        E6dla6p7tNeB06epiV5wrVbFoQ==
X-Google-Smtp-Source: ACHHUZ7Js4PlJACQk+/Y/i9mBlXF47YXo4soyTcy1gKN++6nq0pF3Oz+/oikTAcIHZp9qv+jDovExA==
X-Received: by 2002:a17:90b:148d:b0:23f:b609:e707 with SMTP id js13-20020a17090b148d00b0023fb609e707mr17649802pjb.2.1683707700896;
        Wed, 10 May 2023 01:35:00 -0700 (PDT)
Received: from C02G87K0MD6R.bytedance.net ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id m2-20020a17090a668200b002504a1a5d1asm7588359pjj.29.2023.05.10.01.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 01:35:00 -0700 (PDT)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH v2 0/2] Fix two warnings about rq clock
Date:   Wed, 10 May 2023 16:34:48 +0800
Message-Id: <20230510083450.62334-1-jiahao.os@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two patches fix two warnings about rq clock

Patch1 fixes the warning of using the old rq clock caused by
missing update rq clock.

Patch2 fixes the warning that the rq clock was updated multiple
times while holding the rq lock.

v1->v2:
    - Vincent Guittot suggested using rq_clock_start_loop_update()
      to prevent multiple calls to update_rq_clock() in unthrottle_cfs_rq()
      instead of removing update_rq_clock() from unthrottle_cfs_rq()
      and updating the rq clock before unthrottle_cfs_rq() for patch2.

[v1] https://lore.kernel.org/all/20230410081206.23441-1-jiahao.os@bytedance.com

Hao Jia (2):
  sched/core: Fixed missing rq clock update before calling
    set_rq_offline()
  sched/core: Avoid double calling update_rq_clock()

 kernel/sched/core.c     |  7 ++++---
 kernel/sched/fair.c     | 16 ++++++++++++++++
 kernel/sched/sched.h    | 21 +++++++++++++++++++++
 kernel/sched/topology.c | 10 ++++++----
 4 files changed, 47 insertions(+), 7 deletions(-)

-- 
2.37.0

