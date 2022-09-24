Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80805E880C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 05:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbiIXDtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 23:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbiIXDtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 23:49:00 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8A51AD95
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 20:48:59 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id iw17so1810151plb.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 20:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date;
        bh=5gbEClK9s7xDqhnWZ1bay1FHi2n5R6lkU3pCYbHsSb0=;
        b=Y5R55I5B+bFNxsxiALnhY4BI4W6kuohHcmNJJ4vrl0oUr/wcy5NXXrda4EglsjxTM9
         Uwucld3fEuufo4iaC1vvaS9WlxTW63RwpQTtxDwtm+r4eqhECKqN1y4o4SDRK608MHxp
         0nbQAPUPU9tCohr1EZfi3OSSeGIewXx8bTaEGjlNNEG2uHlN4QLo6owq/XpeDJG0U/zu
         VK8iaoTj4LXFEu52eoZJSo42OyBzIRFcYAmm3/o6YL9/WB5UdSbLuJak8l2l3xm68p4V
         8I2itRlnWI+4pOfIjb5OjKfVcdml8Q21uEDMBIo0RRscUotZNgqpjiWjvDoovMvYDxWp
         5ojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date;
        bh=5gbEClK9s7xDqhnWZ1bay1FHi2n5R6lkU3pCYbHsSb0=;
        b=KHpUbj0m+bHIN+Uif7BqAYWaBcQoj9M2RlUv+rgHPJIRSiP4o9qRZxckblkWSqblxN
         LRTmtBlGPKrooVSdhQxocELyMMuKNiyCi6VSDB941wPwtYVcDoVAPwmrLneN8ZNn0fzC
         F5J+7qiRPqoV6bLUL/DZ2jnZop90U9Nx/RblGo/gP3I8jVg8/MxF9Wdq/WV2Eir2GbBs
         2PISksgiPcrPCxZ2tuyLl767nXKH9YYT3+EwtNY/9VpJyyQMGCZd0NwP2RUIZFHZqB+d
         VHhtpQM7wWzW3zmu4/f/3qHbBalb/ziL8TKhddoukOX1UNqDU4GUIPiRTDhYJXvbvfkL
         fO+g==
X-Gm-Message-State: ACrzQf1IDt2mR/EtY4ckifHGPXAgJPMUTalToRC8lOM8GIGGwyS0iOUC
        HvEyWu3Qf9rFTwQw7UqyWFXE7weNpon0KQ==
X-Google-Smtp-Source: AMsMyM7Ny4ce4H/XvdurTVN5pKYzBigrbYkd/yrkOEN2tAnnGOSskB5nXEIHAA+dMHr6Hb1XjNwCeA==
X-Received: by 2002:a17:90b:1c07:b0:202:ff6e:6015 with SMTP id oc7-20020a17090b1c0700b00202ff6e6015mr13379165pjb.210.1663991339009;
        Fri, 23 Sep 2022 20:48:59 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id r10-20020a63e50a000000b00438c0571456sm6343814pgh.24.2022.09.23.20.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 20:48:58 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 23 Sep 2022 17:48:57 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] workqueue fixes for v6.0-rc6
Message-ID: <Yy5+KbO8g7t0szu5@slm.duckdns.org>
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

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.0-rc6-fixes

for you to fetch changes up to c0feea594e058223973db94c1c32a830c9807c86:

  workqueue: don't skip lockdep work dependency in cancel_work_sync() (2022-08-16 06:27:35 -1000)

----------------------------------------------------------------
Workqueue fixes for v6.0-rc6

Just one patch to improve flush lockdep coverage.

----------------------------------------------------------------
Tetsuo Handa (1):
      workqueue: don't skip lockdep work dependency in cancel_work_sync()

 kernel/workqueue.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

-- 
tejun
