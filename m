Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED8E693A6A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 23:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjBLWOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 17:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjBLWOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 17:14:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2468CA23
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 14:14:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32C8260DE8
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 22:14:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84582C433D2;
        Sun, 12 Feb 2023 22:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676240075;
        bh=RpHWTvsJdgMvdTz/pUp4M1bWozM9mReugcjaDWkamSE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=beHyseiDSN2CFnGreNXD/2U7Hlq6iRNZXsnSkvajpjZCJYHF5B3YG1SMXKxoXS71J
         +78HuxMZvDBPNfa28YuL2si7uT6BY+AzJ+h+7PqMpPjk/fgQoBtmUUloBVRYeiJGBS
         987n58kkt2pe+5EIXkpdahUPkugliceslX7wI7YNeqyWcD6A1feW13ZdxyyYE9iaSh
         4ro6ZbY8TEtv5RXKS51FJDi4fScTx1STTX7WhBorHjv+S3Ei1ekwX8ezT3Fbr/L7ba
         vhm33HLj7QaHEK11+YpOzs4bhdWFDEOVWuMX1EF7i+0fOGz9owsvlTsANg+xy7XLps
         KQLzwsV8EgTow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6AC58E55F00;
        Sun, 12 Feb 2023 22:14:35 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Fix TASK_COMM_LEN in trace event format file
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230212154620.4d8fe033@gandalf.local.home>
References: <20230212154620.4d8fe033@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230212154620.4d8fe033@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.2-rc7
X-PR-Tracked-Commit-Id: b6c7abd1c28a63ad633433d037ee15a1bc3023ba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5e98e916f95bdc50e90f3199d7f3d74b94fa5976
Message-Id: <167624007540.2778.13458778701553768055.pr-tracker-bot@kernel.org>
Date:   Sun, 12 Feb 2023 22:14:35 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>,
        Qais Yousef <qyousef@layalina.io>,
        John Stultz <jstultz@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 12 Feb 2023 15:46:20 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.2-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5e98e916f95bdc50e90f3199d7f3d74b94fa5976

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
