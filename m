Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB026E6DB3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 22:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbjDRUwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 16:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjDRUwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 16:52:09 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B246DB2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 13:52:07 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id s6-20020a17090a698600b00247a7794e78so162900pjj.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 13:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681851127; x=1684443127;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=W5qSfyWAGj6hbchSGTd4Ks5BZEpBnz6gWhS2T4O2Cfo=;
        b=eSAf9Bxp+b+VhSUbU3YcPU2/TMJ54Kvtu7WEvNRG4rO6oPwByda+SmC9Ftjul2scoO
         qEVfMDxQzgnrMsx8xY1RxqLuAeNVTts9iKrj3+P2ZrRN/ipUqYV0VFAK5OFrrirnM+uw
         rBW/qLt0GA1ceUE30haafG3zUrO/ULaLp+HUx6WLOeb+GGRDo0rVUBwIbLJbvGjrjbqi
         D505VD3LKI3bnmGisy2j4efgnTegnH9TZB7+x7iex4BGtgAhxQdljiWELzWe17ltsRki
         DFDQZo+3fHtIlQyluf8dZKD1b+upFfuPZOZz6FskRNezfvzkhrXugH92d1+aLq5rU4f6
         bjxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681851127; x=1684443127;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W5qSfyWAGj6hbchSGTd4Ks5BZEpBnz6gWhS2T4O2Cfo=;
        b=LaH26+X2PlkIeI+iOJhy2eSSChkXgYQ6Q6Z1m5/Iq0J+Op63VgjCQNfsZtmx8e8Q11
         C5b4NKPDy4J3Fwl5Qa2+oMA7Mmz9PpkgDKzyh8TKP4hePhmewkAj1HTHt5AaCLS+qfTD
         sCHv68jPGtYUZ34NzowzW5G67ctiip7xVBN40pCpTKW7+DqrlsxjaRj04wCgtXFfkDec
         q6LfI65YFkMTXUIYip+k2wMDHuuH17qqq/JQXw7hUVqUBK1SQSOpH5e9/L5civYsgKV5
         cPMC/SUX6LUdHkI6UdLy+Ia1NA4E9Dvh4dlmXqNXFXt7lUKeFzwjgMiZZI9t5dPo/cDB
         hvhw==
X-Gm-Message-State: AAQBX9dEIWff9DgkjgOdOmBSQg1hbmYJE8iw7PBhtdxGIdM/eM7RLDs/
        yUGBm2WQywiWZYRPhS+sgLs=
X-Google-Smtp-Source: AKy350atJ8d2g/CeVSQDjZHaiDMf5zw1zG4XTLVCdUckJyteMRgWBpDtlKt8qE+E+D5MnuNV+8gNsQ==
X-Received: by 2002:a05:6a20:9382:b0:ef:4fa7:b1f1 with SMTP id x2-20020a056a20938200b000ef4fa7b1f1mr1220722pzh.0.1681851126744;
        Tue, 18 Apr 2023 13:52:06 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id c6-20020aa78c06000000b0063b7c42a072sm6342906pfd.13.2023.04.18.13.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 13:52:06 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: [PATCHSET wq/for-6.5] workqueue: Implement automatic CPU intensive detection and add monitoring
Date:   Tue, 18 Apr 2023 10:51:54 -1000
Message-Id: <20230418205159.724789-1-tj@kernel.org>
X-Mailer: git-send-email 2.40.0
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
CPU consumption. If a work item consumes more than the threshold (5ms by
default) of CPU time, it's automatically marked as CPU intensive when it
gets scheduled out which unblocks starting of pending per-cpu work items.

The mechanism isn't foolproof in that the detection delays can add up if
many CPU-hogging work items are queued at the same time. However, in such
situations, the bigger problem likely is the CPU being saturated with
per-cpu work items and the solution would be making them UNBOUND. Future
changes will make UNBOUND workqueues more attractive by improving their
locality behaviors and eventually remove the explicit WQ_CPU_INTENSIVE flag.

While at it, add statistics and a monitoring script. Lack of visibility has
always been a bit of pain point when debugging workqueue related issues and
with this change and more drastic ones planned for workqueue, this is a good
time to address the shortcoming.

This patchset was born out of the discussion in the following thread:

 https://lkml.kernel.org/r/CAHk-=wgE9kORADrDJ4nEsHHLirqPCZ1tGaEPAZejHdZ03qCOGg@mail.gmail.com

and contains the following five patches:

 0001-workqueue-sched-Notify-workqueue-of-scheduling-of-RU.patch
 0002-workqueue-Re-order-struct-worker-fields.patch
 0003-workqueue-Move-worker_set-clr_flags-upwards.patch
 0004-workqueue-Automatically-mark-CPU-hogging-work-items-.patch
 0005-workqueue-Add-pwq-stats-and-a-monitoring-script.patch

and also available in the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git auto-cpu-intensive

diffstat follows. Thanks.

 Documentation/core-api/workqueue.rst |   30 ++++++++
 kernel/sched/core.c                  |   18 +----
 kernel/workqueue.c                   |  221 +++++++++++++++++++++++++++++++++++++++-----------------------
 kernel/workqueue_internal.h          |   14 +--
 tools/workqueue/wq_monitor.py        |  148 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 333 insertions(+), 98 deletions(-)

--
tejun

