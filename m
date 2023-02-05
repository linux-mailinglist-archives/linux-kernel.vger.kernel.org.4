Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B3C68B236
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 23:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjBEWne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 17:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjBEWnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 17:43:33 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4753519F2D
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 14:43:31 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id bk15so29426584ejb.9
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 14:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1J3XyqEQxBVec+OJzxFprhMNdYo0Joqgd8k6vAa+lMo=;
        b=kyaVD0Q/xHQiVH9DbCAkcqf7ZSurcmBBwcNYvRmfC6+MpULMNDpIhbYqXLpJn1ByHl
         7cU+oPblagiCuqT/Lxaaef5dqVWO/8vfskaCQBxg3ADY6a6OZvg6arjohfivwoN3CU8K
         Y++gnm6+/jFpkoC9nBPzWlXHqqEkwggmUEYBKPDHyFg5XdcnpHl/2Y9SR3pDxgnHxhbr
         eZqqFXLvkkviUKeUauZvxzWOM8G2c3jmAWvuScvjfw1FqsLIz9JfazeFNj7KDT0mVP08
         iXvvrjlJDaAu+yQ9GRBzFGJ9ybo8K18HYWYGE3k0DltmzdjTbdH7SCF9IDlfS4GuaFDV
         5nMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1J3XyqEQxBVec+OJzxFprhMNdYo0Joqgd8k6vAa+lMo=;
        b=WSHupPvSGzH4n6od6JnKQvMc+JRm20kLf0R/+XHjnTLfLyE6oWNJMkSZHJXJ7chF9b
         VdoqKvMUU1RbrvoTFZmZeB1D4t2IfPt/3Nnn1rC/fIaro52gGm+1LcP1WeLGoQbabJYn
         GMPEKo4Rjg3oiADkPMdD4KMThiyKfE/4WVRGr7D+Nr/e+9kAjEg5BiU5eT1CJRewFY4h
         l7Xqc5HQ5sv4CfDljdNTo9KzvigMiwIFyoFvhpFhZdeZK7XY1OPuv5h0sUzPp1sjMlez
         VXbb6cyvwTzob5nqhbT1cbymzFsSIUywkOl1m6nJKdkBhTbrwN1C/IRRMOYPS4kDEG2L
         Uk/Q==
X-Gm-Message-State: AO0yUKW8ifHJO1nplRZpFftRIARiOQbaAmxB+Zhgsh7zAX41XBdJFykc
        tyMbpagME6GTZFUuSw2jnOJh8Q==
X-Google-Smtp-Source: AK7set9Or9CyG8vohqnzTSWVRsshklP15IWVcDAczLPVl6mRNJ3hyhKTTsnmPCWCz0xyz6VF4E3aEA==
X-Received: by 2002:a17:906:5a4c:b0:87b:7c1e:7d58 with SMTP id my12-20020a1709065a4c00b0087b7c1e7d58mr17552876ejc.53.1675637009849;
        Sun, 05 Feb 2023 14:43:29 -0800 (PST)
Received: from localhost.localdomain (host86-163-35-10.range86-163.btcentralplus.com. [86.163.35.10])
        by smtp.gmail.com with ESMTPSA id m15-20020a1709061ecf00b0087bd2924e74sm4550779ejj.205.2023.02.05.14.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 14:43:29 -0800 (PST)
From:   Qais Yousef <qyousef@layalina.io>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        Wei Wang <wvw@google.com>, Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v2 0/3] Fix a couple of corner cases in feec() when using uclamp_max
Date:   Sun,  5 Feb 2023 22:43:15 +0000
Message-Id: <20230205224318.2035646-1-qyousef@layalina.io>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:

	* Use long instead of unsigned long to keep the comparison simple
	  in spite of being inconsistent with how capacity type.
	* Fix missing termination parenthesis that caused build error.
	* Rebase on latest tip/sched/core and Vincent v5 of Unlink misift patch.

v1 link: https://lore.kernel.org/lkml/20230129161444.1674958-1-qyousef@layalina.io/

Patch 1 addresses a bug because forcing a task on a small CPU to honour
uclamp_max hint means we can end up with spare_capacity = 0; but the logic is
constructed such that spare_capacity = 0 leads to ignoring this CPU as
a candidate to compute_energy().

Patch 2 addresses a bug due to an optimization in feec() that could lead to
ignoring tasks whose uclamp_max = 0 but task_util(0) != 0.

Patch 3 adds a new tracepoint in compute_energy() as it was helpful in
debugging these two problems.

This is based on tip/sched/core + Vincent's v5 of
Unlink util_fits_cpu()... patch [1]

[1] https://lore.kernel.org/lkml/20230201143628.270912-1-vincent.guittot@linaro.org/

Qais Yousef (3):
  sched/uclamp: Set max_spare_cap_cpu even if max_spare_cap is 0
  sched/uclamp: Ignore (util == 0) optimization in feec() when
    p_util_max = 0
  sched/tp: Add new tracepoint to track compute energy computation

 include/trace/events/sched.h |  4 ++++
 kernel/sched/core.c          |  1 +
 kernel/sched/fair.c          | 18 +++++++++++-------
 3 files changed, 16 insertions(+), 7 deletions(-)

-- 
2.25.1

