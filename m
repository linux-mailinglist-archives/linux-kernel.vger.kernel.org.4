Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B1A69C35C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 00:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjBSXSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 18:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjBSXSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 18:18:15 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDEDCC12
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 15:18:15 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id o3so1777020plg.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 15:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=tVojFOh61n5/mBoezlAnDiDZ41SFIo5Hngz7LkVm9nE=;
        b=AebsIh1ceEodCkEa1047cDBag9J9Ax+iDGhtqvHqJnF6USC1ZSBtbdc0Hm5BXp3CII
         CauR8wX+cZMnwj46bQLilXL/Av8OLh4zjMzwVstSH0jcKFCFEOvkwIKNhwBMf1MSdF8Q
         O5um3if3znQp1zteSYa5U+iLp8iraNH1jUD0JudWyLoNnJkafp0MGuadWpLmGM5PBTme
         lKXeUfv5TLl1h89McLfsElT48SrW8T6RwGIBQ8SRJBcFbYfyNqaUVbc9h4sGYFekj+oZ
         sj9AgeMmCclvBUEwwtFqbHPu8JBmPtlOfGwnPXROSKqbizaY+oGDVHyYqmzw/LnjazRA
         DlGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tVojFOh61n5/mBoezlAnDiDZ41SFIo5Hngz7LkVm9nE=;
        b=PQavAVI97NLv2t9ApC/Rct0IVc6/UEFYRthLB8z+LQ7OVRMULvTuIt/sTau+pRSzaG
         aQRpgNVbarX2N/UUOmVOJc23zqjYQX/nrbhznv+VqSS4WL2t2SgwH+klAEnGHZuhFLtD
         E8DD6pljYQK1e2Kmpv5oy1THj6zMoaZg8Eyj5iHPsHQ1BqKQVyxNJeL87vYNqsqX8HRA
         ZI0WTnbzspzaBmxCWosQmWyNPIq517LgmBUB/0EZr2tIKxQp6CXPwc02HfckgeVSacBa
         WADxaHT3jzb52clehQqvK8ViFH7dGRR72kGVNK6K7lfbROzMNp5iIUAHi2fQz0jgERBH
         YR2w==
X-Gm-Message-State: AO0yUKXuYqy+jwPs12rIWYoPCmPOxFBIcItmVzlvO69gklCIRGVU1/ce
        GRZPTD8Lq2yMSsCGXwiVgzo=
X-Google-Smtp-Source: AK7set8AIMjeFw8TbOGbLNomobiOMmndSIri+gcL+66n9PuC9JnaOZp6PhTdnqLVOvHPTrZPgsthMw==
X-Received: by 2002:a17:902:ea08:b0:199:30a6:3756 with SMTP id s8-20020a170902ea0800b0019930a63756mr2157772plg.18.1676848694243;
        Sun, 19 Feb 2023 15:18:14 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id g5-20020a1709026b4500b0019c33775574sm1380714plt.198.2023.02.19.15.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 15:18:13 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sun, 19 Feb 2023 13:18:11 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [GIT PULL] workqueue changes for v6.3-rc1
Message-ID: <Y/KuM8ovt66dSAHU@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 512dee0c00ad9e9c7ae9f11fc6743702ea40caff:

  Merge tag 'x86-urgent-2023-01-04' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2023-01-04 12:11:29 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.3

for you to fetch changes up to c63a2e52d5e08f01140d7b76c08a78e15e801f03:

  workqueue: Fold rebind_worker() within rebind_workers() (2023-01-13 07:50:40 -1000)

----------------------------------------------------------------
workqueue changes for v6.3-rc1

* When per-cpu workqueue workers expire after sitting idle for too long,
  they used to wake up to the CPU that they're bound to to exit. This
  unfortunately could cause unwanted disturbances on CPUs isolated for e.g.
  RT applications. The worker exit path is restructured so that an existing
  worker is unbound from its CPU before being woken up for the last time,
  allowing it to migrate away from an isolated CPU for exiting.

* A couple debug improvements. Watchdog dump is made more compact and
  workqueue now warns if used-after-free during the RCU grace period after
  destroy_workqueue().

----------------------------------------------------------------
Lai Jiangshan (1):
      workqueue: Protects wq_unbound_cpumask with wq_pool_attach_mutex

Paul E. McKenney (1):
      workqueue: Make show_pwq() use run-length encoding

Richard Clark (1):
      workqueue: Add a new flag to spot the potential UAF error

Valentin Schneider (5):
      workqueue: Factorize unbind/rebind_workers() logic
      workqueue: Convert the idle_timer to a timer + work_struct
      workqueue: Don't hold any lock while rcuwait'ing for !POOL_MANAGER_ACTIVE
      workqueue: Unbind kworkers before sending them to exit()
      workqueue: Fold rebind_worker() within rebind_workers()

 include/linux/workqueue.h |   1 +
 kernel/workqueue.c        | 280 ++++++++++++++++++++++++++++++++++------------
 2 files changed, 210 insertions(+), 71 deletions(-)

-- 
tejun
