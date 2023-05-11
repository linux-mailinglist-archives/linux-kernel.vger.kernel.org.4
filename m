Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43AA26FF96A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 20:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239122AbjEKSTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 14:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238819AbjEKSTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 14:19:37 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7503330FB
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 11:19:36 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6438d95f447so6303488b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 11:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683829176; x=1686421176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=BO12zW0+WdffWdg+cJvODSzSdqMENSRhscbq9WXoqTo=;
        b=qAfk9OxMU2BDdhG4v5LWzoNl42ypdDZtOTChzJPOXGn4QVki964jUWKBhIhsz7uHeG
         2xfXyPXuIc/TL1FwMaKO/ajlLHW6jnORBGm12Y7mlR2d+69qdKaAnHw9P9du5yIRgIBL
         20Sb/9tZAGkf5jot+6qyqjt8bNqUV/aSQiR3xa6MRTMfD0lQjmw4U7LW1D43v19dt4Ha
         llcPLk6r+ixoUkVbWev7IpunUAY1fkBlFPf9akoP0mjbATpjSomSxDGAhm3xFe/qYfnP
         89UDI5wLIJZaZahJykUyzztHxuGWAkUR7pLXhj/HgjhwkwKXRU4kjsm28oPXY9JX/BBj
         EMCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683829176; x=1686421176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BO12zW0+WdffWdg+cJvODSzSdqMENSRhscbq9WXoqTo=;
        b=fMKiVpWEva6+Q+jk7bV333TJS/O8RpBiCpZnrsuoyBtmKpMBQJR3IXawxZ/5O/xWQ8
         GnMLho75ocBNjDByRgo7gtAAEuu6H7YligQMY0Oz8Nbc+7i8wQW75Umn1apeDWuprTaa
         yVMRCh3tH/633dZskJA8B09NWIEHiLVdwzxRzPSxZrWYUHU34G0Aq8WuICtgSLJ1qwl2
         jiRS9uEaBVB/17bdq9j7ea98XKKiEdiXOvR4VhqePkyGL4V1Fa7qNYC63NRlEEiOKThy
         tQekdmPX+Znnapk4oJuQoJewsz6cHrv4C0CdTVn0pV6UATRqEh7sXsqZq1u+C2EqOeLn
         Q6PQ==
X-Gm-Message-State: AC+VfDzYrnz4aEHyaGubK3QC/NARL9JS8yJaZpUIB077GVOCrhNoxWaP
        ONkReNiJswY70Yjb8rOcTSKkf2o0Gmc=
X-Google-Smtp-Source: ACHHUZ580JIUMtXPvnJRdr2tvnTC0xsNdbX/nRT9j2vWvNdUBCC33J9KCFJDi08+wXW7K0sNQJ9SKw==
X-Received: by 2002:a05:6a20:258d:b0:101:a435:a44 with SMTP id k13-20020a056a20258d00b00101a4350a44mr11895085pzd.37.1683829175401;
        Thu, 11 May 2023 11:19:35 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id 197-20020a6304ce000000b0052c22778e64sm5242021pge.66.2023.05.11.11.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 11:19:34 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: [PATCHSET v3 wq/for-6.5] workqueue: Implement automatic CPU intensive detection and add monitoring
Date:   Thu, 11 May 2023 08:19:24 -1000
Message-Id: <20230511181931.869812-1-tj@kernel.org>
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

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git auto-cpu-intensive-v3

diffstat follows. Thanks.

 Documentation/core-api/workqueue.rst |   32 +++++
 kernel/sched/core.c                  |    3
 kernel/workqueue.c                   |  337 ++++++++++++++++++++++++++++++++++++++++++++++++++-----------
 kernel/workqueue_internal.h          |   24 ++--
 lib/Kconfig.debug                    |   13 ++
 tools/workqueue/wq_monitor.py        |  169 ++++++++++++++++++++++++++++++
 6 files changed, 507 insertions(+), 71 deletions(-)

--
tejun

