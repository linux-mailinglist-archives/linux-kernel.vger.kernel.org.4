Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FEE63F866
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 20:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiLATgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 14:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiLATgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 14:36:21 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08F312B
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 11:36:19 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id n21so6627294ejb.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 11:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+xvbHrF7Tm2zAWFmetj60oSM5IBgE1cIt2lREpq6WUs=;
        b=qszaC5cVvnw2yItPPBDvc+kowqUVvKjRJ9jwv/bmKvksaLTzFIXly+zh7JXWsa227/
         L9SLd90idEW/jcJLeO/2TwYKnY7qTRHOj1BE5T5ckwtQlrbfP84r35RVp8EDNFWjSZS1
         EA/Ce04CMf4hJOuaDc1HAxmaJeGlBWn7RNnKg1AR2CZaTN05emhsoR26+RS9s+tnInZz
         CeTNsNmz8TMrQfdUJb2nPZG21ENsxeQjmGJdNFObyvJek0fu28G7C0gOzAGDJ+iF4sOV
         G8gnycxWEpc0RwfLKMo7qVDejnveD6Lqb5ZjrKim4opufeLf9VlRx2bZ8y6yuHpIa9HK
         AULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+xvbHrF7Tm2zAWFmetj60oSM5IBgE1cIt2lREpq6WUs=;
        b=P3oxnvjkAjrxFCQ1sIda/wU6bv4HDfQMtXk47NpMERilHCuAuHPryUg3ZPwvLLwLeS
         9mfZtYYn8je5bJvVsuwbrUA03JN1Rvmdkq3JgK1XSFNRO6+AER8IrMRlU9Sjn3s7qBBF
         ZGC8zkH79D/7zxDbdxPlSqrynDO0MolyshcEZ+nYzBpJ4zH8espAD8oU1tYFKeAqFfxI
         qVAbbqOVgBSLXcGyCq6yyrCX43rWib5x23DBnFf5DPpI6smWbLiMbnUI7c5FE+8zkm+4
         5MYn6d5l+m02NsOpuJm6gek8cmfWbdMFk6R/msZ9drQosnpjf6QxNYndVDwxZj5TTPkB
         dLMw==
X-Gm-Message-State: ANoB5pksHxMUUThjgdX9VpTwJSBNGrw00OvzHhyPIVivzN2s8RrjhhDR
        09I6+rlTNcs0CyLLWN2faebkKhEppb8cFqf5
X-Google-Smtp-Source: AA0mqf7Q9dWeqHOUTrc0H5NHmnlZPriE+Alwz9KVWJQYoyU+MGHuZNUFX7lCMFa5HYqcXbZliLg8Bw==
X-Received: by 2002:a17:906:830b:b0:7bb:7dda:7d49 with SMTP id j11-20020a170906830b00b007bb7dda7d49mr31302792ejx.156.1669923378083;
        Thu, 01 Dec 2022 11:36:18 -0800 (PST)
Received: from localhost.localdomain ([194.110.85.83])
        by smtp.gmail.com with ESMTPSA id 24-20020a170906329800b007b29d292852sm2125212ejw.148.2022.12.01.11.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 11:36:17 -0800 (PST)
From:   Petar Gligoric <petar.gligor@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Petar Gligoric <petar.gligor@gmail.com>
Subject: [PATCH 0/2] perf: introduce perf based task analyzer
Date:   Thu,  1 Dec 2022 14:35:55 -0500
Message-Id: <20221201193557.65548-1-petar.gligor@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-series introduces the task analyzer and adds the feature to
output csv files for further analysis in thirds party script 
(e.g. pandas and friends). 

The task analyzer dissects recorded perf.data files based on
sched:sched_switch events. It outputs useful information for the user
of each task, like times between schedule in/schedule out of the same
task.

    Switched-In      Switched-Out CPU      PID      TID             Comm    Runtime     Time Out-In
15576.658891407   15576.659156086   4     2412     2428            gdbus        265            1949
15576.659111320   15576.659455410   0     2412     2412      gnome-shell        344            2267
15576.659491326   15576.659506173   2       74       74      kworker/2:1         15           13145
[...]
 
The user can modify the output to his liking and his necessity. He can
either limit the output to tasks he wants or filter tasks he does not
present in the output. The output can also be limited via the time or
specific tasks can be highlight via colors. A combination of those 
options is also possible.
Additionally the user can print out a summary of all tasks, which is a
table of information from all tasks throughout the whole trace.
Information, like total runtime, how many times the tasks have been 
scheduled in, what the max runtime was and when it occurred, just to 
name few.

Summary
    Task Information                       Runtime Information
PID   TID            Comm Runs Accumulated    Mean  Median  Min   Max          Max At
 14    14     ksoftirqd/0   13         334      26      15    9   127 15571.621211956
 15    15     rcu_preempt  133        1778      13      13    2    33 15572.581176024
 16    16     migration/0    3          49      16      13   12    24 15571.608915425
[...]

The standard task as well as the summary can be printed in either
nanoseconds, milliseconds or microseconds(standard). 
Both standard as well as summary can be saved in a user specified file
in csv format.        

Hagen Paul Pfeifer (1):
  perf script: introduce task analyzer

Petar Gligoric (1):
  perf script: task-analyzer add csv support

 .../scripts/python/bin/tasks-analyzer-record  |   2 +
 .../scripts/python/bin/tasks-analyzer-report  |   3 +
 tools/perf/scripts/python/tasks-analyzer.py   | 937 ++++++++++++++++++
 3 files changed, 942 insertions(+)
 create mode 100755 tools/perf/scripts/python/bin/tasks-analyzer-record
 create mode 100755 tools/perf/scripts/python/bin/tasks-analyzer-report
 create mode 100755 tools/perf/scripts/python/tasks-analyzer.py

-- 
2.30.2

