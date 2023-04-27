Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C2C6F0D4F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 22:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344238AbjD0Ugh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 16:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343660AbjD0Ugf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 16:36:35 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F14421B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 13:36:11 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1a6f0d8cdfeso70075075ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 13:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682627760; x=1685219760;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=BLUleJYSpWs43QiNRPT7ecDyRRGcgSDqLfJGdo9eeRA=;
        b=FqN40mLRF24rYdpJdsZp0htMZst4I/B15vpkr3i0MZlafvlPRb0ru9qO6hWuZ2RuE0
         lK2BJPF9d/4RShLIlvEu+lMEVzS6aY5rbaOEn2K2oqs2XAB4VXwEa2+JbV4juDPVTkD/
         rWMBkTmYlVJTvg0wYBrB85AZRN08QxIBDPPzqvz1w1D33MxRp3uzV+D5gluvYKTUPPK8
         9YoxwzxOkbm/xcwDjNcYfXrUiCkLeP+RzkITuiADvd7kbhHUhyoX5BaoN1OAvqYAurSZ
         C0yKI0kdhFKpVJQWVp7Dik2W+7dPfuSAzWSJYZl/mz6BeyYfW3gSGenavc/0/sqwQ7Ay
         4AXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682627760; x=1685219760;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BLUleJYSpWs43QiNRPT7ecDyRRGcgSDqLfJGdo9eeRA=;
        b=bIvpe6g6Q3ut7Bos4eJrpUgencHdoL6z7gw/WVlnrUEGjwZVerv2WCJjQz9oDqnwB4
         UDtqYU0S0gEkSg8dLN2uy3CmDYcaqAqxaFLg0xk23nYopXfxvTII61zjo3LqzMv1yrIq
         wUmqSd/HjFLsIG+wETUPq5m7xy1m2oextgVHBHuBIbSK/WuE8pF3GkAoVYXf3+BcrFEU
         2Y8BBL0v5NWAcSEpaRaSuMGieRBSjO+mq0+skLWfkRaLCiJK0IFTstBTEkiUrO++kYoc
         gN3nt53CXN+cF9xHhPl5KxWNtF/1OfQ7RAu2uJWVhcqnmIqtMzzSA/nN7Y00BNsNA21Q
         gnyA==
X-Gm-Message-State: AC+VfDxjWP7py0dSGgiPAtmQ1YnDmqcTE+atpRU+3ou7aWzkgACwZSCQ
        GoyQmkFeVwIrwhBHay+CwAA=
X-Google-Smtp-Source: ACHHUZ5vLSkV8NJpYOifTDZBwT6DI8bpXwxCNHcqLRpTm8eGrzOH7TV4CvUZyapbSF245/I/snwq3Q==
X-Received: by 2002:a17:902:d4c8:b0:19f:87b5:1873 with SMTP id o8-20020a170902d4c800b0019f87b51873mr3094241plg.62.1682627760067;
        Thu, 27 Apr 2023 13:36:00 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id b11-20020a170902d50b00b001a67a2dae7fsm3657077plg.266.2023.04.27.13.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 13:35:59 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 27 Apr 2023 10:35:58 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [GIT PULL] workqueue changes for v6.4-rc1
Message-ID: <ZErcro8_Ylius4wC@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

The following changes since commit 8d3c682a5e3d9dfc2448ecbb22f4cd48359b9e21:

  Merge tag 'block-6.3-2023-03-16' of git://git.kernel.dk/linux (2023-03-17 11:20:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.4

for you to fetch changes up to 704bc669e1dda3eb8f6d5cb462b21e85558a3912:

  workqueue: Introduce show_freezable_workqueues (2023-03-23 15:55:38 -1000)

----------------------------------------------------------------
workqueue changes for v6.4-rc1

Mostly changes from Petr to improve warning and error reporting. Workqueue
now reports more of the relevant failures with better context which should
help debugging.

----------------------------------------------------------------
Ammar Faizi (2):
      MAINTAINERS: Add workqueue_internal.h to the WORKQUEUE entry
      workqueue: Simplify a pr_warn() call in wq_select_unbound_cpu()

Jungseung Lee (1):
      workqueue: Introduce show_freezable_workqueues

Petr Mladek (5):
      workqueue: Fix hung time report of worker pools
      workqueue: Warn when a new worker could not be created
      workqueue: Interrupted create_worker() is not a repeated event
      workqueue: Warn when a rescuer could not be created
      workqueue: Print backtraces from CPUs with hung CPU bound workqueues

 MAINTAINERS               |   1 +
 include/linux/workqueue.h |   1 +
 kernel/power/process.c    |   2 +-
 kernel/workqueue.c        | 134 +++++++++++++++++++++++++++++++++++++++++-----
 4 files changed, 124 insertions(+), 14 deletions(-)
