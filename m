Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEDC6ADF33
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 13:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjCGMyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 07:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjCGMx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 07:53:59 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6276E3C10
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 04:53:52 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9F664219C2;
        Tue,  7 Mar 2023 12:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1678193631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=J0QDfE2VDRRXa7dNYYL0ybh9qvI0KeRezmzPWc8ZeZA=;
        b=fYXCDmcD02Td4CJIugqzCi5pIEW2SROaQPQERm5ecznPwtqAf1HfIziJcoxyZHwwTXftQ/
        FHC4AW6bVXXvsRfthrlgIQ2RGz/gP8WnoISE+Huh/+bxhGsZHr0FvG0JTdmIenTy8INKMl
        ZuFcSTvj2tWBsJ3rjQcolPvKUDXIFvE=
Received: from alley.suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        by relay2.suse.de (Postfix) with ESMTP id 52BF62C142;
        Tue,  7 Mar 2023 12:53:51 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Michal Koutny <mkoutny@suse.com>, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 0/5] workqueue: Debugging improvements
Date:   Tue,  7 Mar 2023 13:53:30 +0100
Message-Id: <20230307125335.28805-1-pmladek@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The workqueue watchdog provides a lot of information when a stall is
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
create_rescuer().

5th patch adds printing bracktraces of CPU-bound workers that might
block CPU-bound workqueues. The candidate is well defined to keep
the number of backtraces small. It always printed only the right one
during my testing.


The first 4 patches would have helped me to debug the real problems
that I met.

The 5th patch is theoretical. I did not see this case in practice.
But it looks realistic enough. And it worked very well when I
simulated the problem. IMHO, it should be pretty useful.


Changes against v1:

  + Used pr_err_once() instead of the complicated code synchronizing
    the error messages with the watchdog interval.

    I tried also the standard ratelimit API was not really usable.
    The synchronization with the watchdog was bad and the error
    messages touched/restarted the watchdog timestamp a non-reliable
    way. In fact, we wanted something like reset-able pr_once().
    

  + Added "cpu_stall" into struct worker_pool.

  + Renamed the functions for printing backtraces of hogging CPU-bound
    workers and cleaned up the code.


Petr Mladek (5):
  workqueue: Fix hung time report of worker pools
  workqueue: Warn when a new worker could not be created
  workqueue: Interrupted create_worker() is not a repeated event
  workqueue: Warn when a rescuer could not be created
  workqueue: Print backtraces from CPUs with hung CPU bound workqueues

 kernel/workqueue.c | 102 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 95 insertions(+), 7 deletions(-)

-- 
2.35.3

