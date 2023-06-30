Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FEC7431E9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 02:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbjF3AsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 20:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbjF3AsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 20:48:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCB22112
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 17:48:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 321536168A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 00:48:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9714AC433C0;
        Fri, 30 Jun 2023 00:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688086084;
        bh=SlAchQQaSGwc+9AoR1N9TrcVMxg5YsuSLrlUBPzKLFw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AzPCdrPCam5rvwOvnxy3T90muk3EdP8/IjRRZunH0HVMHypba6x7bnKn1SnNx0NSf
         7qyA/47egWxaYlaAtj07PRNZPWYmLZTX2jEeEZafCeNsE+c3JK+87qDxv67rmW7Bjl
         pMiuqJWGtHj+G6Qw2DMaXY4hOddQwDtF2KQ0CQtVMSsGyFeDg4b1KSBx1pXZHNlsGU
         gpfvNhWeaWco5EyeoW5wPMCnvNCZ/3vBexi2xxsrDJ++/PpR9bPnG46RpaRjHjW3P9
         WRarssPUTkgAvrmdiaUjtR0Vui/vQBqoBW9eXRAVJ4dLiHC4STqaR0iDYY3SAb7chR
         Z/qTnLuWHJRIw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 81D4AC39563;
        Fri, 30 Jun 2023 00:48:04 +0000 (UTC)
Subject: Re: [GIT PULL] Fix error return in do_vmi_align_munmap()
From:   pr-tracker-bot@kernel.org
In-Reply-To: <9a816818f4d0b3eadc1c16fa3f3d42225c55c4b1.camel@infradead.org>
References: <ef2c7c0eeb166acf050597f49eb118d94f18bd39.camel@infradead.org>
         <20230628131330.ufrp57vnfpynlapq@revolver> <9a816818f4d0b3eadc1c16fa3f3d42225c55c4b1.camel@infradead.org>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <9a816818f4d0b3eadc1c16fa3f3d42225c55c4b1.camel@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/dwmw2/linux unmap-fix-20230629
X-PR-Tracked-Commit-Id: 6c26bd4384da24841bac4f067741bbca18b0fb74
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 43ec8a620b38291c959afb47816cf2de6207125a
Message-Id: <168808608452.32109.3471114651335419900.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Jun 2023 00:48:04 +0000
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 29 Jun 2023 22:17:09 +0100:

> git://git.infradead.org/users/dwmw2/linux unmap-fix-20230629

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/43ec8a620b38291c959afb47816cf2de6207125a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
