Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7843469EC9B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 02:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjBVB5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 20:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBVB5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 20:57:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E162F279A5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 17:57:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 901C9B8118C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 01:57:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282D2C433D2;
        Wed, 22 Feb 2023 01:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677031020;
        bh=Ij5Iif21fgc/VRcCtvfnwnXCEoMV82z2vw8xe67oFxE=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=f0b7TfQWpmPW7UWH0pNGCTn2S66Op7krxJ2rY9RdDd4JMN8jIpySlyEVC1mFdtk4P
         hDDlV7fPdYOO1wpYF3DKZrAGn8xVDt314xwFfegxsplT+FJIj9PiphcQ75U+KmIkR7
         stEvFSrhU9DmpRiHvSBAylIYzlbFc4IyAz3Po6A/q6B4D0Uh//3HG2AWp6sSiNcUY8
         SzSHBHdrs221sB378OE/UFcQmh4r54sTTvhgrSmUEDqU4yK5/ezt7W2W1Bmvphsw2A
         TR4/9LwQn72gJyF/cOVS9H7SThHixPu2sSB4RwJuAK4mvklQKyzivoVKnRbOli6Fxo
         TDCRrG4+ulpvA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BA87A5C10B5; Tue, 21 Feb 2023 17:56:59 -0800 (PST)
Date:   Tue, 21 Feb 2023 17:56:59 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     parav@nvidia.com, will@kernel.org, stern@rowland.harvard.edu,
        kushagra765@outlook.com, jonas.oberhauser@huawei.com,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: [GIT PULL] LKMM changes for v6.3
Message-ID: <20230222015659.GA1344672@paulmck-ThinkPad-P17-Gen-1>
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

Please pull the latest LKMM changes from:
  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/lkmm.2023.02.15a
  # HEAD: 9ba7d3b3b826ef47c1b7b8dbc2d57da868168128: tools: memory-model: Make plain accesses carry dependencies (2023-01-03 20:47:04 -0800)

----------------------------------------------------------------
LKMM updates for v6.3

Documentation updates.

Add read-modify-write sequences, which means that stronger primitives
more consistently result in stronger ordering, while still remaining in
the envelope of the hardware that supports Linux.

Address, data, and control dependencies used to ignore data that was
stored in temporaries.  This update extends these dependency chains to
include unmarked intra-thread stores and loads.  Note that these unmarked
stores and loads should not be concurrently accessed from multiple
threads, and doing so will cause LKMM to flag such accesses as data races.

----------------------------------------------------------------
Alan Stern (1):
      tools: memory-model: Add rmw-sequences to the LKMM

Jonas Oberhauser (1):
      tools: memory-model: Make plain accesses carry dependencies

Kushagra Verma (1):
      Documentation: Fixed a typo in atomic_t.txt

Parav Pandit (1):
      locking/memory-barriers.txt: Improve documentation for writel() example

 Documentation/atomic_t.txt                       |  2 +-
 Documentation/memory-barriers.txt                | 22 ++++++-------
 tools/memory-model/Documentation/explanation.txt | 39 +++++++++++++++++++++++-
 tools/memory-model/linux-kernel.bell             |  6 ++++
 tools/memory-model/linux-kernel.cat              |  5 +--
 tools/memory-model/litmus-tests/dep+plain.litmus | 31 +++++++++++++++++++
 6 files changed, 90 insertions(+), 15 deletions(-)
 create mode 100644 tools/memory-model/litmus-tests/dep+plain.litmus
