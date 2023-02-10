Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFAB692084
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 15:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbjBJOJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 09:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbjBJOJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 09:09:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A06F74057
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 06:09:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBD7861DCC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 14:09:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E69C8C433EF;
        Fri, 10 Feb 2023 14:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676038164;
        bh=IWQRr+Q8aIRwlJ77WAyj7aiy1PRgAPS0rY3PdsEvOP0=;
        h=From:To:Cc:Subject:Date:From;
        b=aWoNwEiKdE0Iz9DO/hA14IBQKin2qbo7mtfYNQ6ZKdAkbuhzhhvPXtpBkCyW+S/F0
         2CRZWiGsn4GOKlfhvkN2gf4XVkdklr+7xqvktiZbhLva7JnrBGqm1S6+WcghwytkVX
         WYvKS/Dg5bl0YfAKpbzVc10WvjxwrFFdDqLBAV2y+zGKipJTbT0EG/QjkMFPyzL01r
         d8fdeHTJ3BIl8q5OGj6bp9XhvPknPdiupfsz+Rxtrr3WSKNitIBYiT0PfIyWJEefDy
         pPJ5d4YxkYz4PbWEwUBw/KhEiTurU6JAfyGBe0LJ9EfEG/8ealBKwszOW4XdDlkG1O
         8PQXekHhn+B/A==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Wei Li <liwei391@huawei.com>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yu Liao <liaoyu15@huawei.com>, Hillf Danton <hdanton@sina.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 0/6] timers/nohz: Fixes and cleanups
Date:   Fri, 10 Feb 2023 15:09:11 +0100
Message-Id: <20230210140917.279062-1-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Try to (partially) fix the issue reported in https://lore.kernel.org/lkml/20230128020051.2328465-1-liaoyu15@huawei.com/

Frederic Weisbecker (6):
  timers/nohz: Restructure and reshuffle struct tick_sched
  timers/nohz: Only ever update sleeptime from idle exit
  timers/nohz: Protect idle/iowait sleep time under seqcount
  timers/nohz: Add a comment about broken iowait counter update race
  timers/nohz: Remove middle-function __tick_nohz_idle_stop_tick()
  MAINTAINERS: Remove stale email address

 MAINTAINERS              |   2 +-
 kernel/time/tick-sched.c | 146 ++++++++++++++++++---------------------
 kernel/time/tick-sched.h |  67 +++++++++++-------
 3 files changed, 112 insertions(+), 103 deletions(-)

-- 
2.34.1

