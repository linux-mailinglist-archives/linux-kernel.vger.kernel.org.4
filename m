Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE287115FF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242818AbjEYStm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242964AbjEYSpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:45:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCBA3C29;
        Thu, 25 May 2023 11:42:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A016F60BEC;
        Thu, 25 May 2023 18:42:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 088B5C433D2;
        Thu, 25 May 2023 18:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685040123;
        bh=V6Qe5K1QN9D8bDEoRk94m8xGFrxEn6EKWIgVEI2ErEM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UUISq7yXN3KoECtjtIo6QELKEj+jF9Z7eiaA5fIXVPVKPhb+NUM0sfO0fu7slGy1M
         xqmdy8WsRQuQI1Tihtza0m51kP+EgarFROEzaXNkrUIy8WditYpZZ2PWF09i40i5jb
         fTuSRVIuLONdCC3LT8XGa8jg7QyA+dA+Aj/nKGK5V77J6lsVteyT0a0teJ07/aj1nG
         jUdFjpOToeNgZ8wtNsUIDwjuPRBTJy3A0As/Zhg8bG3ubVDIIhlzdVf96HXJBft7Fs
         CIi/dpnBm7xngzTqNA3Ib2wUW/TXTBTDRq0kBi6hfgRfuuFnzU7jBoV4hyd84YAbqM
         SUzNiDRRsJkkA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Takashi Iwai <tiwai@suse.de>, Yu Hao <yhao016@ucr.edu>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>, robert_s@gmx.net,
        imv4bel@gmail.com, linma@zju.edu.cn, chenzhongjin@huawei.com,
        linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 18/31] media: dvb-core: Fix kernel WARNING for blocking operation in wait_event*()
Date:   Thu, 25 May 2023 14:40:49 -0400
Message-Id: <20230525184105.1909399-18-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525184105.1909399-1-sashal@kernel.org>
References: <20230525184105.1909399-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit b8c75e4a1b325ea0a9433fa8834be97b5836b946 ]

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
Closes: https://nvd.nist.gov/vuln/detail/CVE-2023-31084
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/dvb-core/dvb_frontend.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/media/dvb-core/dvb_frontend.c b/drivers/media/dvb-core/dvb_frontend.c
index b04638321b75b..ad3e42a4eaf73 100644
--- a/drivers/media/dvb-core/dvb_frontend.c
+++ b/drivers/media/dvb-core/dvb_frontend.c
@@ -292,14 +292,22 @@ static int dvb_frontend_get_event(struct dvb_frontend *fe,
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
2.39.2

