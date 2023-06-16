Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC51733626
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344858AbjFPQeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbjFPQe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:34:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC7C30F7;
        Fri, 16 Jun 2023 09:34:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFFB960EA5;
        Fri, 16 Jun 2023 16:34:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28108C433C8;
        Fri, 16 Jun 2023 16:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686933256;
        bh=qE1OJbXrmRnZC4ivwx7brjgLHKgk/qZxmdlw3ZmqxXY=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=E1URUOUraeyHzD/HPBb+XiBDLh+qnt7uQJhsay356i/Ij2MF+jQaE1bBFq5h++Y8T
         4KZII45WI7QrCcNBXvYaN228uIIRm1VKuMOkYKKMfblnk0ajl/dV9V+9Gs/kiTchkG
         emlEbg+idTJFtVRHCpbbE7clP2IEdJBQDPC22CgR08jyeoD8l94r+RdcoNtWOVAPg4
         hi4/wf06lWSOvJxzpn2dN8Yw/WHuOU8YF9SP+gImQ5L8NeCnLrQEs+m0UBHBU3H14H
         2UjeafmZGA0jYdtpkK3uA5E3eTcywtAc0wY1Lm/8bN+eRWupwzwlJgg96YYZFa2L4N
         vavFBdlMuTh3w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BDEF8CE0BB2; Fri, 16 Jun 2023 09:34:15 -0700 (PDT)
Date:   Fri, 16 Jun 2023 09:34:15 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rcu@vger.kernel.org, jonathanh@nvidia.com, wenst@chromium.org,
        angelogioacchino.delregno@collabora.com,
        rafael.j.wysocki@intel.com, mirq-linux@rere.qmqm.pl,
        dmitry.osipenko@collabora.com, sachinp@linux.ibm.com,
        qiang.zhang1211@gmail.com
Subject: [GIT PULL] RCU regression fix for v6.4
Message-ID: <21bdc866-f9ae-4cda-a996-370bde183fd0@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URG_BIZ autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/urgent-rcu.2023.06.11a

for you to fetch changes up to de29a96acceae732c68a4094d08dc49079eefa02:

  notifier: Initialize new struct srcu_usage field (2023-06-07 13:42:02 -0700)

----------------------------------------------------------------
Urgent RCU pull request for v6.4

This commit fixes a spinlock-initialization regression in SRCU that causes
the SRCU notifier to fail.  The fix simply adds the initialization,
but introduces a #ifdef because there is no spinlock to initialize for
the Tiny SRCU used in !SMP builds.

Yes, it would be nice to abstract this somehow in order to hide it in
SRCU, but I still don't see a good way of doing this.

----------------------------------------------------------------
Chen-Yu Tsai (1):
      notifier: Initialize new struct srcu_usage field

 include/linux/notifier.h | 10 ++++++++++
 1 file changed, 10 insertions(+)
