Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDCF70C9AD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 21:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbjEVTuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 15:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235396AbjEVTue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 15:50:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710A99C
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 12:50:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05D9A62AF6
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 19:50:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC23BC433D2;
        Mon, 22 May 2023 19:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684785032;
        bh=BDOTvHvS+lyHmEJFK68MiymZkfGA/R+O1zt/D4SvVIw=;
        h=From:To:Cc:Subject:Date:From;
        b=gtZXvwjzaPwV04snaN59Q/TNOMzoN7uNsTWCTUUPYXLcBtfi8sgZwgcvUBEa6JtFl
         gODmoFuXpl4y6EMMriOuA9LqTJOzltXqagKPFHAAQm4l4VvPv+VJgArMfwcG7WLRbT
         Yuh+Gb0Kx0JwFkWlF9U0/foYvpTiluVLcHcmOGgddRa8N3Jhr2ejNVGiHs8qUHm875
         6YPEUXXJvvWOQS17QbzQMlwYuLSYZFswgvzybMI0sypwpLn28n9IEr4G8SjfGkHmDJ
         aUC+vDzGsAQZS8ZAM+CQizK2+En8E00FoN6QI2+NGH0W4tVMTVJJHSAPZw+NU41sE/
         8NV2qcO3VdM0g==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] sched: address missing-prototype warnings
Date:   Mon, 22 May 2023 21:50:16 +0200
Message-Id: <20230522195021.3456768-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

I sent out a lot of -Wmissing-prototype warnings already, but noticed that
I missed some of the patches I did for the scheduler.

Addressing this is mainly useful in order to allow turning the
warning on by default in the future, but I also tried to
improe the code where possible.

Arnd Bergmann (5):
  sched: hide unused sched_update_scaling()
  sched: add schedule_user() declaration
  sched: fair: hide unused init_cfs_bandwidth() stub
  sched: make task_vruntime_update() prototype visible
  sched: fair: move unused stub functions to header

 kernel/sched/core.c  |  2 --
 kernel/sched/fair.c  | 19 +++----------------
 kernel/sched/sched.h | 13 +++++++++++++
 3 files changed, 16 insertions(+), 18 deletions(-)

-- 
2.39.2

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org

