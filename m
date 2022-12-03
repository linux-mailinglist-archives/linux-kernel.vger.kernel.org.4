Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04158641305
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 02:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiLCBXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 20:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234697AbiLCBXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 20:23:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C562CC643
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 17:23:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E85EBB82313
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 01:23:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3219C433C1;
        Sat,  3 Dec 2022 01:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670030623;
        bh=q4cPlzhmxgm7/C1xVCWObCSHUgvcp2QExAy0ZYAjb6U=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=KjDpCt/YjzSEt3mgQsjNhK5woXZgS/fcHaQMxB4rudtSljMIHhGMTlSJaSf6SekhT
         IEuZpdQGTt6Q9Q459NuoWm4WGFUmB+GADE+uwjtO/6y4KmmEMHqXK4fD3Kwr7prtgF
         LqSYrQSiUtGUjR3nqwMArlJIIqgY3CeQuVNVW9PmOD7e1cI1OA8WftCoBGCnQCroTB
         IkSvkdYkvV8xaO5hxcnvlopeaWlALO3k1XD+VAJP4lppkL36oPf4goMWSitfYZX1qL
         7KXZexmwu1vWIIMDb5DYUeAiyvNXPoV81pL33d2rsUFKZQrPr5vR1qTb7ErQBSgDOF
         WpcNsR+GqQNKA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 43E675C095D; Fri,  2 Dec 2022 17:23:43 -0800 (PST)
Date:   Fri, 2 Dec 2022 17:23:43 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        kasan-dev@googlegroups.com, elver@google.com, ryasuoka@redhat.com
Subject: [GIT PULL] KCSAN changes for v6.2
Message-ID: <20221203012343.GA1816460@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

Please pull the latest KCSAN git tree from:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/kcsan.2022.12.02a
  # HEAD: 144b9152791ffcd038c3b63063999b25780060d8: kcsan: Fix trivial typo in Kconfig help comments (2022-10-18 15:07:33 -0700)

----------------------------------------------------------------
KCSAN updates for v6.2

This series adds instrumentation for memcpy(), memset(), and memmove() for
Clang v16+'s new function names that are used when the -fsanitize=thread
argument is given.  It also fixes objtool warnings from KCSAN's volatile
instrumentation, and fixes a pair of typos in a pair of Kconfig options'
help clauses.

----------------------------------------------------------------
Marco Elver (2):
      kcsan: Instrument memcpy/memset/memmove with newer Clang
      objtool, kcsan: Add volatile read/write instrumentation to whitelist

Ryosuke Yasuoka (1):
      kcsan: Fix trivial typo in Kconfig help comments

 kernel/kcsan/core.c   | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/Kconfig.kcsan     |  6 +++---
 tools/objtool/check.c | 10 ++++++++++
 3 files changed, 63 insertions(+), 3 deletions(-)
