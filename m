Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58EAD72DC37
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236708AbjFMIU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235167AbjFMIU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:20:26 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB581128
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:20:23 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b3b3f67ad6so24404895ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686644423; x=1689236423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zGxTjqPnaSVuYuCYJlwJW6b7DpS+WH8VO9UU6JcI+S0=;
        b=LJ5ZHj3+z1kbkpAkqIwdjFBR+Q78ezOyQeFFDVCo8dtpi80/M0LGFR3zAiCbEKetb+
         eRzZWtqjr2c+09/VRLVo/7L6u6Z4mPAkvChlsKIbkvhKA47vJhgJbsMnorpPqWqGm6RD
         zOoFcP89OI27zrt7sMBYZkMF0mJsz7LavAbvB1tmZClnC96iodDSSOuNBePO70xJKJXl
         0KvdvdJ5y2gDV03QjV8AArDvenPtwVKQMFOTcOby37SdECr8D4aTTEvf+oT5mfOwOc7c
         1pqKsH+HowteySMQwNW4EzO36qTZ1BK9HhKYkOnmah/eeYYaWizeoN5mWIvSdkGIgg7x
         /ltA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686644423; x=1689236423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zGxTjqPnaSVuYuCYJlwJW6b7DpS+WH8VO9UU6JcI+S0=;
        b=XYU01+3UwQNaUFIA7PSEfX4SqmmyNdfyeNLlwvNyZHiw6eZ8KlUcWP3mxRMbNSpe7o
         KNnHHaIlRCrO11IMg5IU5dXZRKbz/ONzIbu7lsB8C+ZTgXhjPqEnajOGMIZSTmYQ/HO8
         fWfXiDDFk34e4VqEiN1GjB6UMdpvQc4bwaKbIsnj8itv1gH46d/B6/2zg+fgf57tCkUT
         ATvuMaO6T2Eepku3svf/KI690Cavfw8c87PWDDQM/2lKz+ZXjPzXppNsQr4xY4AbMVq5
         EQYFDLNTPOWbOAcCbHbTLrMZRGJq7m8SGHAwKenHI3qRU7WXYGKja6EUiYHH6D8+e5AO
         iajA==
X-Gm-Message-State: AC+VfDxdUYh/DnVbyAJ4Yn97/5U99yUNMwHuPXFpRyCDhzn68Pw7JDZj
        KuI4EmCuZ44EtMhgAhsfCnLWXA==
X-Google-Smtp-Source: ACHHUZ6AnL/Ztn0IGfkC4vNfCjmpj/BkbMc6l2cKxouVmr3Qdg2eOFQ6wHE6YJ7RdZ5TxyJsDaPYSg==
X-Received: by 2002:a17:902:8a8d:b0:1ac:451d:34a with SMTP id p13-20020a1709028a8d00b001ac451d034amr7891328plo.33.1686644423166;
        Tue, 13 Jun 2023 01:20:23 -0700 (PDT)
Received: from C02G87K0MD6R.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902c1c500b001b027221393sm9567834plc.43.2023.06.13.01.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 01:20:22 -0700 (PDT)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH v5 0/4] Fix some warnings about rq clock
Date:   Tue, 13 Jun 2023 16:20:08 +0800
Message-Id: <20230613082012.49615-1-jiahao.os@bytedance.com>
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

These four patches fix some warnings about rq clock.

Patch1 fixes the warning of using the old rq clock caused by
missing update rq clock.

Patch2-4 fixes the warning that the rq clock was updated multiple
times while holding the rq lock.

v4->v5:
    - Benjamin Segall suggested adding update_rq_clock() to set_rq_offline()
      instead of calling update_rq_clock() before set_rq_offline() runs.

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

[v4] https://lore.kernel.org/all/20230608063312.79440-1-jiahao.os@bytedance.com
[v3] https://lore.kernel.org/all/20230515063848.77947-1-jiahao.os@bytedance.com
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

 kernel/sched/core.c     |  9 +++++----
 kernel/sched/fair.c     | 18 ++++++++++++++++++
 kernel/sched/sched.h    | 21 +++++++++++++++++++++
 kernel/sched/topology.c |  6 +++---
 4 files changed, 47 insertions(+), 7 deletions(-)

-- 
2.20.1

