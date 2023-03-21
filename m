Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1B26C270A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 02:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjCUBLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 21:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjCUBK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 21:10:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91A740F9;
        Mon, 20 Mar 2023 18:10:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A86F618CF;
        Tue, 21 Mar 2023 01:08:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA4F0C433D2;
        Tue, 21 Mar 2023 01:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679360895;
        bh=6yV77rsshCfobUHWUL1LEbSflKIcDxj1x/jHkqzROzk=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=a6HlPp3W9Mzm0ztDmDNq6yTdSdmJGbskmpd58/gVgpRf3LDfW8z6z+BJGOWRlAvZl
         Kb4kFOeyuDSkEH9/LOD8ny5K5Rr5qi6rUmm9CaiwQyrwdGCgltl2l0VyfOqIfIkHKm
         a5XMI6q0yGfY7TB7qsDb6N/56J5tZvcIIZeWQ2Ou3DxZG8DBqY5SGTDaDcz5bWbydY
         kNlYsWvsxMc2aJZoVpFWi4awJ1MX1qMBq1dw/9GHecOvW22s6wwo4UkJ4f3JkVuJfJ
         zffCf/aOq1ZclFdAqtMn8MFpmGt7mtYyq5FzQOrngS6vsnJdPNtMPpAVSqiCD9MYvU
         I2fUKM1cq7twg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 506091540395; Mon, 20 Mar 2023 18:08:15 -0700 (PDT)
Date:   Mon, 20 Mar 2023 18:08:15 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/5] locktorture updates for v6.4
Message-ID: <3679d2b2-bdb9-4fa3-8134-240a8d0f449b@paulmck-laptop>
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

Hello!

This series provides updates to the locktorture test suite:

1.	Add nested_[un]lock() hooks and nlocks parameter, courtesy of
	John Stultz.

2.	Add nested locking to mutex torture tests, courtesy of John
	Stultz.

3.	Add nested locking to rtmutex torture tests, courtesy of John
	Stultz.

4.	With nested locks, occasionally skip main lock, courtesy of
	John Stultz.

5.	Add raw_spinlock* torture tests for PREEMPT_RT kernels, courtesy
	of Zqiang.

						Thanx, Paul

------------------------------------------------------------------------

 b/kernel/locking/locktorture.c                                |   23 +
 b/tools/testing/selftests/rcutorture/configs/lock/CFLIST      |    1 
 b/tools/testing/selftests/rcutorture/configs/lock/LOCK08      |    6 
 b/tools/testing/selftests/rcutorture/configs/lock/LOCK08.boot |    1 
 b/tools/testing/selftests/rcutorture/configs/lock/LOCK09      |    6 
 b/tools/testing/selftests/rcutorture/configs/lock/LOCK09.boot |    1 
 kernel/locking/locktorture.c                                  |  163 +++++++++-
 tools/testing/selftests/rcutorture/configs/lock/CFLIST        |    1 
 8 files changed, 187 insertions(+), 15 deletions(-)
