Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319317018CA
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 19:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjEMR6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 13:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233454AbjEMR5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 13:57:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E7F2D4D;
        Sat, 13 May 2023 10:57:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 728A561C67;
        Sat, 13 May 2023 17:57:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611CAC43322;
        Sat, 13 May 2023 17:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684000666;
        bh=dFOoold9GKTSodC+PeDDguWht9y1iSueQLSe4Te7lpM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iSXnl6RIk6AtZkklDEBkULpy2HWbFsa4N09S318WdiYOaEOgJK43Uf+lxUnu1Oxvk
         /1YTblZ0cNO0wK8Vt0AmaemcjJZOpMsR+a+mgeWwNE4bIUaESRn/dQE3Czl5M5J7Xn
         BfYPTus6nH1Zsn9kgBQKCTE+6pXXoF1sVZR48cNZT86gbDn5hvef5kx4aQMHV3eq9J
         P/Ek5Osvj/etg2UYyABrhJeuXVI99Texte2DCixu/Yyzpxqb6GY5bK2Ewvs2Ol1310
         xMjseJfxO3Ml1nbVSlj+GAeO6qSJ6CwnvzxEWEIO5PZCjED7N+6r6mk4IO7T3khL9c
         ZcFdrkjl/G90A==
Received: from mchehab by mail.kernel.org with local (Exim 4.96)
        (envelope-from <mchehab@kernel.org>)
        id 1pxtV1-001tyE-1l;
        Sat, 13 May 2023 18:57:43 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Takashi Iwai <tiwai@suse.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Yu Hao <yhao016@ucr.edu>
Subject: [PATCH 17/24] media: dvb-core: Fix kernel WARNING for blocking operation in wait_event*()
Date:   Sat, 13 May 2023 18:57:34 +0100
Message-Id: <7a9e7df217675449e47c752bbbe5455252e6d2cb.1684000646.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <53558de2b5c4f4ee6bfcfbe34e27071c2d0073d5.1684000646.git.mchehab@kernel.org>
References: <53558de2b5c4f4ee6bfcfbe34e27071c2d0073d5.1684000646.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

Using a semaphore in the wait_event*() condition is no good idea.
It hits a kernel WARN_ON() at prepare_to_wait_event() like:
  do not call blocking ops when !TASK_RUNNING; state=1 set at
  prepare_to_wait_event+0x6d/0x690

For avoiding the potential deadlock, rewrite to an open-coded loop
instead.  Unlike the loop in wait_event*(), this uses wait_woken()
after the condition check, hence the task state stays consistent.

CVE-2023-31084 was assigned to this bug.

Link: https://lore.kernel.org/r/CA+UBctCu7fXn4q41O_3=id1+OdyQ85tZY1x+TkT-6OVBL6KAUw@mail.gmail.com/

Link: https://lore.kernel.org/linux-media/20230512151800.1874-1-tiwai@suse.de
Reported-by: Yu Hao <yhao016@ucr.edu>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 drivers/media/dvb-core/dvb_frontend.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/media/dvb-core/dvb_frontend.c b/drivers/media/dvb-core/dvb_frontend.c
index 375eb255df9e..461f5b49ae0e 100644
--- a/drivers/media/dvb-core/dvb_frontend.c
+++ b/drivers/media/dvb-core/dvb_frontend.c
@@ -293,14 +293,22 @@ static int dvb_frontend_get_event(struct dvb_frontend *fe,
 	}
 
 	if (events->eventw == events->eventr) {
-		int ret;
+		struct wait_queue_entry wait;
+		int ret = 0;
 
 		if (flags & O_NONBLOCK)
 			return -EWOULDBLOCK;
 
-		ret = wait_event_interruptible(events->wait_queue,
-					       dvb_frontend_test_event(fepriv, events));
-
+		init_waitqueue_entry(&wait, current);
+		add_wait_queue(&events->wait_queue, &wait);
+		while (!dvb_frontend_test_event(fepriv, events)) {
+			wait_woken(&wait, TASK_INTERRUPTIBLE, 0);
+			if (signal_pending(current)) {
+				ret = -ERESTARTSYS;
+				break;
+			}
+		}
+		remove_wait_queue(&events->wait_queue, &wait);
 		if (ret < 0)
 			return ret;
 	}
-- 
2.40.1

