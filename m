Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287BE668820
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 01:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239946AbjAMALZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 19:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240184AbjAMALL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 19:11:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3782155650;
        Thu, 12 Jan 2023 16:11:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA40D621D7;
        Fri, 13 Jan 2023 00:11:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39C4AC433EF;
        Fri, 13 Jan 2023 00:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673568664;
        bh=bezMuXcUUZ3sIW4oHH2X7S7RAStckOll++aPwBdoMwA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=XHf/y9sUekTwOCA8LzYQ7xe4oo3dtHa6pzOnujXLwbXPsoWVhER8h0ZoOFVkP2Gqp
         SwbkvkBOpeG0JPqr/+1CtzaCSXBzkqskTJdCm9VldAiT5wRb8vt2plXPqa9CQi3CiP
         PD6SUqkm3OyzvDscVEIhZncAiBrJBjBTKQzDN7/9bkL7WUByhzZKlygTtkawugOelw
         nW/4PVW7Tw2F+sjMHFFtBpA8oBv/pzKBLGUHM6S2qWnZQmevSWg0M/w9ilEt1ZVc85
         X9RW2k/npw6xFAI2/XBdAlMAPiQc7vkzlqIbPoN0QvQy4wnYB+Up8u/0iqmkFs085Q
         FvBjGiB37xerQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C32545C09F1; Thu, 12 Jan 2023 16:11:03 -0800 (PST)
Date:   Thu, 12 Jan 2023 16:11:03 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org
Subject: Re: [PATCH rcu 0/27] Unconditionally enable SRCU
Message-ID: <20230113001103.GA3374173@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This v2 series removes Kconfig "select" clauses and #ifdef directives that
are no longer necessary give that SRCU is now unconditionally enabled,
courtesy of new-age printk() requirements.  Finally, the SRCU Kconfig
option is removed entirely.

1.	arch/x86: Remove "select SRCU".

2.	drivers/base: Remove CONFIG_SRCU.

3.	drivers/cpufreq: Remove "select SRCU".

4.	drivers/dax: Remove "select SRCU".

5.	drivers/hwtracing/stm: Remove "select SRCU".

6.	drivers/md: Remove "select SRCU".

7.	drivers/net: Remove "select SRCU".

8.	drivers/pci/controller: Remove "select SRCU".

9.	fs: Remove CONFIG_SRCU.

10.	fs/btrfs: Remove "select SRCU".

11.	fs/dlm: Remove "select SRCU".

12.	fs/notify: Remove "select SRCU".

13.	fs/quota: Remove "select SRCU".

14.	init: Remove "select SRCU".

15.	kernel/notifier: Remove CONFIG_SRCU.

16.	kernel/power: Remove "select SRCU".

17.	kvm: Remove "select SRCU".

18.	mm: Remove "select SRCU".

19.	tomoyo: Remove "select SRCU".

20.	Remove CONFIG_SRCU.

Changes since v1:

o	Added ack and review tags.

o	Dropped patches taken by their maintainers.

o	Combined the KVM-related commits into a single commit, as requested
	by Sean Christopherson.  Acks received thus far are qualified by
	the corresponding architecture.

o	Added the tomoyo patch based on feedback from Nick Desaulniers.

						Thanx, Paul

------------------------------------------------------------------------

 arch/arm64/kvm/Kconfig                                      |    1 
 arch/mips/kvm/Kconfig                                       |    1 
 arch/powerpc/kvm/Kconfig                                    |    1 
 arch/riscv/kvm/Kconfig                                      |    1 
 arch/s390/kvm/Kconfig                                       |    1 
 arch/x86/Kconfig                                            |    2 
 arch/x86/kvm/Kconfig                                        |    1 
 drivers/base/core.c                                         |   42 ------------
 drivers/cpufreq/Kconfig                                     |    1 
 drivers/dax/Kconfig                                         |    1 
 drivers/hwtracing/stm/Kconfig                               |    1 
 drivers/md/Kconfig                                          |    1 
 drivers/net/Kconfig                                         |    1 
 drivers/pci/controller/Kconfig                              |    2 
 fs/btrfs/Kconfig                                            |    1 
 fs/dlm/Kconfig                                              |    1 
 fs/locks.c                                                  |   25 -------
 fs/notify/Kconfig                                           |    1 
 fs/quota/Kconfig                                            |    1 
 init/Kconfig                                                |    1 
 kernel/notifier.c                                           |    3 
 kernel/power/Kconfig                                        |    1 
 kernel/rcu/Kconfig                                          |    3 
 mm/Kconfig                                                  |    1 
 security/tomoyo/Kconfig                                     |    1 
 tools/testing/selftests/rcutorture/doc/TREE_RCU-kconfig.txt |    4 -
 26 files changed, 1 insertion(+), 99 deletions(-)
