Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73DB609F65
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 12:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiJXKy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 06:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiJXKyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 06:54:40 -0400
Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393DA109E;
        Mon, 24 Oct 2022 03:54:31 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5F33D618F7;
        Mon, 24 Oct 2022 12:44:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1666608268; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding; bh=PwVx9GHMb7vRQqqXAMgZial/VEPJ+6ZVGwTJNOi99aE=;
        b=K3hRJnqCu5P0Pd2UQLF4AxnIOnQot3DaXl5SULmhTFM8Z7z3T92QOLD7SPyGuCyXyoZ4f5
        5pzQM/vurHFiUS0SWZ3uYUgvRERZitwJocG93sfTVeaiZ2XXWGbRNZTzdq1tksMfA0ry7H
        xmm6In77LM5211h1yBYOupqEz5jHghxRBkkgWHl/w3n1xjEKzFkGWHHgmtPnOoPd0W7of5
        ddmTf/wJtfnsbrv9RZL6IYr1GalSO3sIS0qK7rSvegH4RUEe90IVosvFc/XVd78dkixGWv
        mdDhOvuSd47tGiwY5sCY+dIpQXDAXQ3ds976SUzCPMY8kxfbhKJcaQS46OeqBg==
From:   Daniel Wagner <wagi@monom.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
Cc:     Daniel Wagner <wagi@monom.org>
Subject: [PATCH RT 0/9] Linux v4.19.255-rt114-rc1
Date:   Mon, 24 Oct 2022 12:44:16 +0200
Message-Id: <20221024104425.16423-1-wagi@monom.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT Folks,

This is the RT stable review cycle of patch 4.19.255-rt114-rc1.

Please scream at me if I messed something up. Please test the patches
too.

The -rc release will be uploaded to kernel.org and will be deleted
when the final release is out. This is just a review release (or
release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main
release on 2022-10-31.

To build 4.19.255-rt114-rc1 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.255.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/older/patch-4.19.255-rt114-rc1.patch.xz

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel

Changes from v4.19.255-rt113:


Daniel Wagner (3):
  Revert "random: Use local locks for crng context access"
  rcu: Update rcuwait
  Linux 4.19.255-rt114-rc1

Sebastian Andrzej Siewior (6):
  random: Bring back the local_locks
  local_lock: Provide INIT_LOCAL_LOCK().
  Revert "workqueue: Use local irq lock instead of irq disable regions"
  timers: Keep interrupts disabled for TIMER_IRQSAFE timer.
  timers: Don't block on ->expiry_lock for TIMER_IRQSAFE timers
  workqueue: Use rcuwait for wq_manager_wait

 drivers/char/random.c         | 16 +++++++------
 include/linux/locallock.h     |  5 +++++
 include/linux/rcuwait.h       | 42 +++++++++++++++++++++++++++--------
 kernel/exit.c                 |  7 ++++--
 kernel/locking/percpu-rwsem.c |  2 +-
 kernel/rcu/update.c           |  8 +++++++
 kernel/time/timer.c           | 12 ++++++++--
 kernel/workqueue.c            | 28 +++++++++++++++++------
 localversion-rt               |  2 +-
 9 files changed, 93 insertions(+), 29 deletions(-)

-- 
2.38.0

