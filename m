Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864AB702502
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240006AbjEOGjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239963AbjEOGjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:39:23 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B29FCF
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:38:58 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-52160f75920so8472205a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684132738; x=1686724738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CaSWQfDe0u1y4TJh5oORyZ3RjMtOPB8Z8Fj3lYEZXKU=;
        b=JLtOiQsCc58HtoO4E4Yyc5eSsXRibMpTHz7FdBUjNru0nny2lEZ7xGLcVdnICqxyMw
         cMLSKKQ+ZDPqUhNm5apyCoV7uNFs6xvC+2Y9N9THA54+QgWEodvpBp2ltE4SbnGaEaev
         8NapWiJBiy3rO8c1gwPw9jq8VTAfHpmsesTOvlZqR2hnQIK5RV5LOY4+HSzqeoFY4sUt
         oh2m/9tY4XtEdR0W/RyjLVwMwEIxqNWnevB6hHYY6Ta8bmgoRndSd4HN3MSYNxIvrfRb
         rSvQyHLS5iSIHbH58ptDkM+eofi7vQg4nvydg76itVMhlCxlfBl06SQpGD4TOdcupWkL
         MQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684132738; x=1686724738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CaSWQfDe0u1y4TJh5oORyZ3RjMtOPB8Z8Fj3lYEZXKU=;
        b=SpAIps1xUUQ0hCxQHsOD7KvJmx3YWsuhuXdaGpqET28JS+wBGeALuJCRBErmydRp9C
         d0a72x2alKCyqh87xXg/hZFPL/h8yaE4Xw9nvJfX3L5XrrzfmtuMrL3++OliV9qPbEIp
         Nn3NzdWJlF8pIUgB0Ly1tgkZTg6Sr1PEBP8hIs+1YVPwcWN6YHf7XYpJQC+ys116yNPY
         V7TYTpHhBaB6Z2cJoGlwZIEc7aWtd4pfth2sl7LUen+vJUdjSl/QPoBtTK03OqkXQX0Q
         tmSPrSLGoJz2dIHaGtGvFGbuIrPBrfJe7FNX3mVNZEkryQjAriKsbdnI+0GbRVNZViPH
         7x2g==
X-Gm-Message-State: AC+VfDw7fEkF05tLgnpAluLDo0KE4nfRPb80K5yM91icaErjRsg1e49/
        x8Rq7/aCnSnn5mNXSh/cEOntVg==
X-Google-Smtp-Source: ACHHUZ4W48bFO4MpY0CNUQCwBp3yF/Zlca4SI2DP4eV1cRYNAyGUeWAU/Oi2eVtA5udKT2KaLgCLJA==
X-Received: by 2002:a17:902:da89:b0:1ac:acb5:4336 with SMTP id j9-20020a170902da8900b001acacb54336mr26476900plx.33.1684132738134;
        Sun, 14 May 2023 23:38:58 -0700 (PDT)
Received: from C02G87K0MD6R.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id t1-20020a170902a5c100b001ab01598f40sm12608543plq.173.2023.05.14.23.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 23:38:57 -0700 (PDT)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH v3 0/4] Fix some warnings about rq clock
Date:   Mon, 15 May 2023 14:38:44 +0800
Message-Id: <20230515063848.77947-1-jiahao.os@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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
2.37.0

