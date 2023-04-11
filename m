Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B916DE7E0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 01:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjDKXQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 19:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjDKXQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 19:16:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E86A171B
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 16:16:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C479624C9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 23:16:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D3E4C433EF;
        Tue, 11 Apr 2023 23:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681254962;
        bh=PRmWJI/rLQPSTnkIdRLTjYixj1KiDwH4/8ydLzFViTY=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=o35orVTnkTn5zZPXoQTPE2B4woFvyaOjtpKbFbWGD4g6WHvRdZFOwhc7iaCtD9Q6H
         iyy9DA/WMZ5vbPhoXPSm1xYrBUaVW62dtxJj8t5Wsvnr9yALdMLzINDzigOt5EW7On
         qNcJpFoRhElW0cXqRH2JksJoXLBpWCzJL/QOtm7bWhqpxh1yxfWmqW1jqFa5xZCLH/
         6KLUtcEfzNPMoVef5tUS01HUeCCIHFJ2+ZMJSucq2Cm+CQHRrZyCzNOifexwsx8vxX
         +mirI6lwgME27jG70Gt6UNRU9VPN/Jl6QOMsVQj42lwxpCnJaT4hBegWK2hIeAn7kA
         UutOXpGDLqnvA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 02CD11540478; Tue, 11 Apr 2023 16:16:01 -0700 (PDT)
Date:   Tue, 11 Apr 2023 16:16:01 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        dave@stgolabs.net, josh@joshtriplett.org, jstultz@google.com,
        qiang1.zhang@intel.com
Subject: [GIT PULL] locktorture changes for v6.4
Message-ID: <ad60da0b-2535-49ad-8b92-5c8264278e4f@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

Once the v6.4 merge window opens, please pull these locktorture changes
from:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/locktorture.2023.04.04a
  # HEAD: 5d65cf6ae6aea1a8d533d4499201a13d0068a0dc: locktorture: Add raw_spinlock* torture tests for PREEMPT_RT kernels (2023-03-07 10:13:57 -0800)

----------------------------------------------------------------
locktorture updates for v6.4

This update adds tests for nested locking and also adds support for
testing raw spinlocks in PREEMPT_RT kernels.

----------------------------------------------------------------
John Stultz (4):
      locktorture: Add nested_[un]lock() hooks and nlocks parameter
      locktorture: Add nested locking to mutex torture tests
      locktorture: Add nested locking to rtmutex torture tests
      locktorture: With nested locks, occasionally skip main lock

Zqiang (1):
      locktorture: Add raw_spinlock* torture tests for PREEMPT_RT kernels

 kernel/locking/locktorture.c                       | 188 +++++++++++++++++++--
 .../selftests/rcutorture/configs/lock/CFLIST       |   2 +
 .../selftests/rcutorture/configs/lock/LOCK08       |   6 +
 .../selftests/rcutorture/configs/lock/LOCK08.boot  |   1 +
 .../selftests/rcutorture/configs/lock/LOCK09       |   6 +
 .../selftests/rcutorture/configs/lock/LOCK09.boot  |   1 +
 6 files changed, 188 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/rcutorture/configs/lock/LOCK08
 create mode 100644 tools/testing/selftests/rcutorture/configs/lock/LOCK08.boot
 create mode 100644 tools/testing/selftests/rcutorture/configs/lock/LOCK09
 create mode 100644 tools/testing/selftests/rcutorture/configs/lock/LOCK09.boot
