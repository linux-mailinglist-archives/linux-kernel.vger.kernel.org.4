Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633396F20BC
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 00:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346765AbjD1WOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 18:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346745AbjD1WOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 18:14:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BABF944AB
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 15:14:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59E7261004
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 22:14:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B546BC433EF;
        Fri, 28 Apr 2023 22:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682720042;
        bh=9yp7PvrVKcf38GXz19IGa1ES2HkqvQaQcv4R7nbTkIE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WxWiPEBwb0mVWixhVFIit0S0jnaO/sJrR+b3O6bVEsDVFocGazJJqpcwVYEF7KJMY
         rYztaAPk1hnMgQ4KV63/WTLUeLVa/Sh05WQdgJNIHn8CpmdVAREY6JPnKEPRPLdLHR
         mc/XrtZ+K0wqsjoHbmT+MWNZ9BMTtvtx0C/6oP4iPWARwDX7orjF7IGtwdCLZj5V0z
         IXYWzfIiYWW9bLDrNE8WkrfmkkciNbnsDdBR5pJ+YP2rQ7qqvNbSnoSMBaPCQuPUPR
         j9Izdr+IOaAx5Dvwu+6PNTOa3kO7LAH8DAa3/F3wQcLcjqieHl5iBTo6XlmZ74bBQH
         MlQTe+F9R5HHQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9E93AC43158;
        Fri, 28 Apr 2023 22:14:02 +0000 (UTC)
Subject: Re: [GIT PULL] SMP cross-call changes for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZErkdNBn7OLkQZWC@gmail.com>
References: <ZErkdNBn7OLkQZWC@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZErkdNBn7OLkQZWC@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-core-2023-04-27
X-PR-Tracked-Commit-Id: 5c3124975e15c1fadd5af1c61e4d627cf6d97ba2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f20730efbd305d42eded761f6fbd9a59d6125228
Message-Id: <168272004264.15282.11142481421413887803.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Apr 2023 22:14:02 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 27 Apr 2023 23:09:08 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-core-2023-04-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f20730efbd305d42eded761f6fbd9a59d6125228

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
