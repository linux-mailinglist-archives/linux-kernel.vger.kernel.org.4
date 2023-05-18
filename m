Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC08707845
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 05:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjERDBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 23:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjERDAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 23:00:49 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069AF121
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 20:00:48 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-64d18d772bdso217301b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 20:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684378847; x=1686970847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=vJGjatlH1NfRn1Vu6yLURwI+5U/cA1qG/lnoi/95mX8=;
        b=aGYiOxlBHHc4Zi1tIwdd/WrteX+p12v6ezrS0GwgSPhFJF2ZqtrsUrQJmK5zFKGxZI
         mxse6lYnkHJVk8P2b36sv4SjGLNk7B2X757fQWNmfvkK0A8Kq0C/sX5iAntbrv46tWSz
         Rp8bNJBv0MXfjqNBqY7NsWRn4R9Z4hUIZn20H735bMXKW1OFGjV9iBZkSKRgARLyEgvh
         eZteJMzIj2PMI/vpepmkbKKLuGlZ1lHR9rrBhuHTYlDUsl1S7nN13rEN0adWZMNKsd5p
         vDRNaiEipL4c9LJq8wqJsUlBSAfo2tIx/2IsttpVmTRB2UDLtmxEH51oOQQe+XMoSFjz
         Bywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684378847; x=1686970847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJGjatlH1NfRn1Vu6yLURwI+5U/cA1qG/lnoi/95mX8=;
        b=MFr+pL3dCtEYCTnBf32YuND4AF6uW3bOj4czmRBt73tTITXDW8zB1iXOvQF8YnVftV
         Kud3dRz+yqRjE48RYioLCvS8d+N+pwnsSAIAhWxi+ugz8Vu5eDr1XC55D1fj7+SYawiO
         3CGXKRVcVYUYozV9bYif3Rv/GAp+CnALdssJPUyIUO8m63H0+yW9OtUc3MdfkIbYvQAk
         DUWH/gYsfiLdy3em+uJRi/6YS0vt3zJsf5nMinDJ+oXtG5CNYFyg/2nuC4hl4WHvR1xa
         L6TvVlELfCZIEAsVe2kbfDqzSY1FFfQPQzt0oIej/U5wMYkcsGglV8OkJJlY7h70MthU
         CVYQ==
X-Gm-Message-State: AC+VfDwuoALjRK4tuN/o32FI+k4R3eovDRGYAWdud+w/5sAh696UkLli
        LR7BwqSEVfOoQS1bkCdrQk5S/zN6PT0=
X-Google-Smtp-Source: ACHHUZ7UKXSI8sFHaoW9bwHEu8GpoZl2KE3EtsQxpQs/mkUsZYa/JhIMzE+IaG7yobGe6wPSgJeCNA==
X-Received: by 2002:a05:6a00:a14:b0:64a:ea46:3b7d with SMTP id p20-20020a056a000a1400b0064aea463b7dmr2499141pfh.23.1684378847099;
        Wed, 17 May 2023 20:00:47 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:1c2f])
        by smtp.gmail.com with ESMTPSA id p22-20020a62ab16000000b0064867dc8719sm226697pff.118.2023.05.17.20.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 20:00:46 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: [PATCHSET v4 wq/for-6.5] workqueue: Implement automatic CPU intensive detection and add monitoring
Date:   Wed, 17 May 2023 17:00:26 -1000
Message-Id: <20230518030033.4163274-1-tj@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The only meaningful change is the use of printk_deferred() in 0006 which was
posted in the v3 thread. I'm applying this version to wq/for-6.5. Posting
for the record.

v4: * 0006-workqueue-Report-work-funcs-that-trigger-automatic-C.patch
      updated to use printk_deferred() instead of custom bouncing which was
      broken and didn't resolve the deadlock possibility anyway.

    * Documentation updates.

v3: * Switched to hooking into scheduler_tick() instead of scheduling paths
      as suggested by Peter. It's less gnarly and works well in general;
      however, as the mechanism is now sampling based, there can be
      contrived cases where detection can be temporarily avoided. Also, it
      wouldn't work on nohz_full CPUs. Neither is critical especially given
      that common offenders are likely to be weeded out with the debug
      reporting over time.

    * As the above means that workqueue is no longer obersving all
      scheduling events, it can't track the CPU time being consumed by the
      workers on its own and thus can't use global clocks (e.g. jiffies).
      The CPU time consumption tracking is still done with
      p->se.sum_exec_runtime.

    * The mechanism was incorrectly monitoring the entire CPU time a given
      work item has consumed instead of each stretch without intervening
      sleeps. Fixed.

    * CPU time monitoring is now tick sampling based. The previous
      p->se.sum_exec_runtime implementation was missing CPU time consumed
      between the last scheduling event the work item finished and the
      completion, so, e.g., work items that never schedule would always be
      accounted as zero CPU time. While the sampling based implementation
      isn't very accurate, this is good enough for getting the overall
      picture of workqueues that consume a lot of CPU cycles.

    * Patches reordered so that the visibility one can be applied first.
      Documentation improved.

v2: * Lai pointed out that !SM_NONE cases should also be notified. 0001 and
      0004 are updated accordingly.

    * PeterZ suggested reporting on work items that trigger the auto CPU
      intensive mechanism. 0006 adds reporting of work functions that
      trigger the mechanism repeatedly with exponential backoff.

To reduce the number of concurrent worker threads, workqueue holds back
starting per-cpu work items while the previous work item stays in the
RUNNING state. As such a per-cpu work item which consumes a lot of CPU
cycles, even if it has cond_resched()'s in the right places, can stall other
per-cpu work items.

To support per-cpu work items that may occupy the CPU for a substantial
period of time, workqueue has WQ_CPU_INTENSIVE flag which exempts work items
issued through the marked workqueue from concurrency management - they're
started immediately and don't block other work items. While this works, it's
error-prone in that a workqueue user can easily forget to set the flag or
set it unnecessarily. Furthermore, the impacts of the wrong flag setting can
be rather indirect and challenging to root-cause.

This patchset makes workqueue auto-detect CPU intensive work items based on
CPU consumption. If a work item consumes more than the threshold (10ms by
default) of CPU time, it's automatically marked as CPU intensive when it
gets scheduled out which unblocks starting of pending per-cpu work items.

The mechanism isn't foolproof in that the detection delays can add up if
many CPU-hogging work items are queued at the same time. However, in such
situations, the bigger problem likely is the CPU being saturated with
per-cpu work items and the solution would be making them UNBOUND. Future
changes will make UNBOUND workqueues more attractive by improving their
locality behaviors and configurability. We might eventually remove the
explicit WQ_CPU_INTENSIVE flag.

While at it, add statistics and a monitoring script. Lack of visibility has
always been a bit of pain point when debugging workqueue related issues and
with this change and more drastic ones planned for workqueue, this is a good
time to address the shortcoming.

This patchset was born out of the discussion in the following thread:

 https://lkml.kernel.org/r/CAHk-=wgE9kORADrDJ4nEsHHLirqPCZ1tGaEPAZejHdZ03qCOGg@mail.gmail.com

and contains the following patches:

 0001-workqueue-Add-pwq-stats-and-a-monitoring-script.patch
 0002-workqueue-Re-order-struct-worker-fields.patch
 0003-workqueue-Move-worker_set-clr_flags-upwards.patch
 0004-workqueue-Improve-locking-rule-description-for-worke.patch
 0005-workqueue-Automatically-mark-CPU-hogging-work-items-.patch
 0006-workqueue-Report-work-funcs-that-trigger-automatic-C.patch
 0007-workqueue-Track-and-monitor-per-workqueue-CPU-time-u.patch

and also available in the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git auto-cpu-intensive-v4

diffstat follows. Thanks.

 Documentation/admin-guide/kernel-parameters.txt |   12 +
 Documentation/core-api/workqueue.rst            |   32 +++++
 kernel/sched/core.c                             |    3
 kernel/workqueue.c                              |  302 ++++++++++++++++++++++++++++++++++++++++----------
 kernel/workqueue_internal.h                     |   24 ++-
 lib/Kconfig.debug                               |   13 ++
 tools/workqueue/wq_monitor.py                   |  168 +++++++++++++++++++++++++++
 7 files changed, 483 insertions(+), 71 deletions(-)

--
tejun

