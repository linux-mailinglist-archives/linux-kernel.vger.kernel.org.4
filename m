Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9A75B36DC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 14:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbiIIMAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 08:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbiIIL75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 07:59:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7F15A8A4
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 04:59:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D91D5B824F1
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 11:59:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7CB9AC433D7;
        Fri,  9 Sep 2022 11:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662724793;
        bh=ck6TTQPdU3yu4yu3DaiNVcT4St6gdeJBE0VuXEK70vE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jQ6TnEvE0KaOq+n1zFYlhMPKXUgcKRwhgZz0UTRnbUhmISCJm5/jlCO3uy5EhiRyi
         AisGWevSulqYyq+pF/y+Kco59mJPGRAUTBoTK70j+Ui3X/I6mEiMSs77Vjpd2OGidF
         a3/FftUF1ibUlBzVlctopTc5oV8wgs3bJj/4HjAMGyC9O6WvCBCs81SkT3Hk9d3Xdp
         pgewcJAj8y7eMncAA03ksJTEgOjnG0r7Pa4sQIiHI25IaHBuD2tim2qJcgiUYB9Ksm
         k4wWO1hXTcRNrSh/ao90xiBJngAENKgGU/7TbqUPtskMIRGZsNO27G4oPXXG38Zb9p
         5+xGKBgFh7g9w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6142AE1CABD;
        Fri,  9 Sep 2022 11:59:53 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Fixes for 6.0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220908172319.175164e7@gandalf.local.home>
References: <20220908172319.175164e7@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220908172319.175164e7@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v6.0-rc4
X-PR-Tracked-Commit-Id: 47311db8e8f33011d90dee76b39c8886120cdda4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 460a75a6f7cd22b7b0522c00fe778c5146b9a96f
Message-Id: <166272479339.31182.29333549389985419.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Sep 2022 11:59:53 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Brian Norris <briannorris@chromium.org>,
        "Christian A. Ehrhardt" <lk@c--e.de>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Yipeng Zou <zouyipeng@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 8 Sep 2022 17:23:19 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v6.0-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/460a75a6f7cd22b7b0522c00fe778c5146b9a96f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
