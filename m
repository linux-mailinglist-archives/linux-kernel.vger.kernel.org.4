Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAEE265A2AB
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 05:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbiLaEMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 23:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbiLaEMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 23:12:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D641570C
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 20:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672459891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=8dPoeeJQVkopYwEi9IXJYcVbIn3l+ToqMBkwsqQCqCo=;
        b=FFMf36ObvTbUDjihst5/2dEKs8uED4ni9nNljrE7JkUC+YJoBIUbETEh5e8Xfd306mMaix
        5mPgeFhKsbKLQaOYkpldMSdUUWlP+AdCGaHedlqrDrOoHsxyznuk3RJRUI3/+87UUBwydt
        4U9Jt4xi38iS1jlm1ms/dnL5MnrUE7Y=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-433-IVWSUH7lOrmG6lZheSjKZA-1; Fri, 30 Dec 2022 23:11:28 -0500
X-MC-Unique: IVWSUH7lOrmG6lZheSjKZA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1573938012C0;
        Sat, 31 Dec 2022 04:11:27 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.204])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2C20D492B00;
        Sat, 31 Dec 2022 04:11:26 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Cc:     Phil Auld <pauld@redhat.com>,
        Wenjie Li <wenjieli@qti.qualcomm.com>,
        =?UTF-8?q?David=20Wang=20=E7=8E=8B=E6=A0=87?= 
        <wangbiao3@xiaomi.com>, Quentin Perret <qperret@google.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v6 0/2] sched: Fix dup_user_cpus_ptr() & do_set_cpus_allowed() bugs
Date:   Fri, 30 Dec 2022 23:11:18 -0500
Message-Id: <20221231041120.440785-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 v6:
  - Update patch 2 to fix build error with !CONFIG_SMP configs.

 v5:
  - Add an alloc_user_cpus_ptr() helper and use it in patch 2.

 v4:
  - Make sure user_cpus_ptr allocation size is large enough for
    rcu_head.

This series fixes a UAF bug in dup_user_cpus_ptr() and uses kfree_rcu()
in do_set_cpus_allowed to avoid lockdep splats.

Waiman Long (2):
  sched: Fix use-after-free bug in dup_user_cpus_ptr()
  sched: Use kfree_rcu() in do_set_cpus_allowed()

 kernel/sched/core.c | 65 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 57 insertions(+), 8 deletions(-)

-- 
2.31.1

