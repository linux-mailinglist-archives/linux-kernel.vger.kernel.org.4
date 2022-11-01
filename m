Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB6F615037
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 18:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiKARMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 13:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiKARMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 13:12:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F22213DD7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 10:12:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF38161689
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 17:12:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ADBCC433B5;
        Tue,  1 Nov 2022 17:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667322755;
        bh=XMBZAalxvQrmfdDJzPuAVpeRHOQ182l1Ysw1qDcYetw=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=U6KSFKqwyDmV+I4VnBcqg4Q04J5E7cL4Sw7v99VP1fWnlAgIk8imCeYH82avgIyFZ
         Q/eyxL33c/SO8jNjLDYRiruocpiIb8CB0FcBb44ooIFeL3joIerQZ0t1kMoaX59XFA
         03+nBQMgZhmCJzJyK/s1VOcjEwgowUE38rQ7enGGpvmXDTbC8bx2rrk5cGpwMs8lrc
         +gcdFVwsZeshwSLdd+LLubH9zSmN+wJBDuvjQcLD8TF/BWerlk9Cn2n44lwe0v+YWN
         ebzx1zViBrpaESSU0NFNEGwsuXmeXpSZQV+WLuVWWqgmQbJ9pCJvIG/xS2Zq1jqhvn
         IRMBH89VFERTQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E37AA5C05B1; Tue,  1 Nov 2022 10:12:34 -0700 (PDT)
Date:   Tue, 1 Nov 2022 10:12:34 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com, w@1wt.eu
Subject: [GIT PULL] nolibc bug fixes for v6.1
Message-ID: <20221101171234.GA763719@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URG_BIZ autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

This urgent pull request fixes a couple of nolibc string-function bugs
noted by kernel test robot, Rasmus Villemoes, Willy Tarreau.

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/nolibc-urgent.2022.10.28a

for you to fetch changes up to b3f4f51ea68a495f8a5956064c33dce711a2df91:

  tools/nolibc/string: Fix memcmp() implementation (2022-10-28 15:07:02 -0700)

----------------------------------------------------------------
Urgent nolibc pull request for v6.1

This pull request contains a couple of commits that fix string-function
bugs introduced by:

96980b833a21 ("tools/nolibc/string: do not use __builtin_strlen() at -O0")
66b6f755ad45 ("rcutorture: Import a copy of nolibc")

These appeared in v5.19 and v5.0, respectively, but it would be good
to get these fixes in sooner rather than later.  Commits providing the
corresponding tests are in -rcu and I expect to submit them into the
upcoming v6.2 merge window.

----------------------------------------------------------------
Rasmus Villemoes (1):
      tools/nolibc/string: Fix memcmp() implementation

Willy Tarreau (1):
      tools/nolibc: Fix missing strlen() definition and infinite loop with gcc-12

 tools/include/nolibc/string.h | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)
