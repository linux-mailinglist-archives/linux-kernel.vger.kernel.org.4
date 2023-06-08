Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D4F7273FE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 03:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbjFHBMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 21:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbjFHBMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 21:12:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D00C26A4
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 18:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686186707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=ng32tWXL98UVNzodQ7JANpAeSKBoyfdr5bFpej8jqqg=;
        b=ORRq/TGTJy/WIsR1Xmh1emWdL3MbE6TAgb0fXo264PB9iCJ8Y5CjHUqEzupPGtMzFa7fx4
        ODSfwp2VgB3pSCxi2pIfkPffjeSo7mOr/kiJqxDt/zgksYhpktgm0ccBH3xjtpUVCs5Ikq
        FhRUyxQlHRpDecWqoqa5et8bZyyuBCc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-290-fvbDl8aGMO26Vh-XVmcLYQ-1; Wed, 07 Jun 2023 21:11:42 -0400
X-MC-Unique: fvbDl8aGMO26Vh-XVmcLYQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED86F185A78B;
        Thu,  8 Jun 2023 01:11:41 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9EFA0140E954;
        Thu,  8 Jun 2023 01:11:41 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id F223D40194A6F; Wed,  7 Jun 2023 22:10:46 -0300 (-03)
Date:   Wed, 7 Jun 2023 22:10:46 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sched/idle: disable tick in idle=poll idle entry
Message-ID: <ZIEqlkIASx2F2DRF@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Commit a5183862e76fdc25f36b39c2489b816a5c66e2e5 
("tick/nohz: Conditionally restart tick on idle exit") allows
a nohz_full CPU to enter idle and return from it with the 
scheduler tick disabled (since the tick might be undesired noise).

The idle=poll case still unconditionally restarts the tick when entering
idle.

To reduce the noise for that case as well, stop the tick when entering
idle, for the idle=poll case.

tick_nohz_idle_exit (called if the NEED_RESCHED bit is set) 
is responsible for re-enabling the tick when necessary. 

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---

diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 342f58a329f5..fdc240988ea9 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -276,7 +276,7 @@ static void do_idle(void)
 		 * idle as we know that the IPI is going to arrive right away.
 		 */
 		if (cpu_idle_force_poll || tick_check_broadcast_expired()) {
-			tick_nohz_idle_restart_tick();
+			tick_nohz_idle_stop_tick();
 			cpu_idle_poll();
 		} else {
 			cpuidle_idle_call();

