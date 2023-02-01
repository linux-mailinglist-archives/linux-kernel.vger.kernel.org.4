Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2F7686756
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 14:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbjBANqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 08:46:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbjBANqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:46:22 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0D24DCCD
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 05:46:20 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 568A420854;
        Wed,  1 Feb 2023 13:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675259179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=+Q9l0ojGjzhlrWAJCCfPiMCb0GKzhWbqF+Y48zzDTxk=;
        b=XzCjML6r92bJE82u+spR/U7j1/cn2aHNBcYeKHSnzRIa6OgEeHIG88FOk1tfF0KVfF8W9T
        QQaCxRtZ3Cn/gCFXQBa8iTwvechTWkiZZWiaQXdYRvQqcra99EU7i3XtElICZl4iyYHqph
        cK1uRebk2cDv34PecgFYLrh9APV0ITc=
Received: from alley.suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        by relay2.suse.de (Postfix) with ESMTP id 0FFC82C141;
        Wed,  1 Feb 2023 13:46:19 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Michal Koutny <mkoutny@suse.com>, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [RFC 0/5] workqueue: Debugging improvements
Date:   Wed,  1 Feb 2023 14:45:38 +0100
Message-Id: <20230201134543.13687-1-pmladek@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The workqueue watchdog provides a lot of impormation when a stall is
detected. The report says a lot about what workqueues and worker pools
are active and what is being blocked. Unfortunately, it does not provide
much information about what caused the stall.

In particular, it did not help me to get root of the following problems:

    + New workers were not created because the system reached PID limit.
      Admins limited it too much in a cloud.

    + A networking driver was not loaded because systemd killed modprobe
      when switching the root from initrd to the booted system.

      It was surprisingly quite reproducible. Interrupts are not handled
      immediately in kernel code. The wait in kthread_create_on_node()
      was one of few locations. So the race window evidently was not
      trivial.


1st patch fixes a misleading "hung" time report.

2nd, 3rd, and 4rd patches add warnings into create_worker() and
create_rescuer(). The rather persistent errors are printed only once
until it succeeds again. Otherwise it would be too noisy and might even
break the watchdog.

5th patch adds printing bracktraces of CPU-bound workers that might
block CPU-bound workqueues. The candidate is well defined to keep
the number of backtraces small. It always printed only the right one
during my testing.


The first 4 patches would have helped me to debug the real problems
that I met.

The 5th patch is theoretical. I did not see this case in practice.
But it looks realistic enough. And it worked very well when I
simulated the problem. IMHO, it should be pretty useful.


Petr Mladek (5):
  workqueue: Fix hung time report of worker pools
  workqueue: Warn when a new worker could not be created
  workqueue: Interrupted create_worker() is not a repeated event
  workqueue: Warn when a rescuer could not be created
  workqueue: Print backtraces from CPUs with hung CPU bound workqueues

 kernel/workqueue.c | 186 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 177 insertions(+), 9 deletions(-)

-- 
2.35.3

