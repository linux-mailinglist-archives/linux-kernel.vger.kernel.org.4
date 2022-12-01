Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96AB63F73D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 19:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiLASMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 13:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiLASMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 13:12:06 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16AFB7DE8
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 10:12:05 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id bp12so1089892ilb.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 10:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8PHeEQvI03GO1u4arOs5eKGxrrWj+QcJXenB1+d+Ev4=;
        b=HZsYyn/z6EZxF36zedEHApAUBJ4P2dRhxWAAmEyxvmr310UQWzVRPVbApPIsSlk1o/
         rgSJjhyFcbZgkEzBYSXVuoKf9N6ik+dqn61leEofV6Rr7hRtWk0lyGfnaKdO0PG7+u/+
         44cZp9cYXcWPQk/YuxfkuaNFMmi/6uKPYn8HnxVOej4A7MQVSb/ZXS0V5Rpe6SQ0IeAo
         NSmxA1q2sZBjPXe37/6uKtE1H4SbpwEB8Gu314VMk29RlzXWaHSGKH7Ri0Yr5PRMbyvl
         m8y70Uk6erMJKkVghZF++Qv7+nRhEa2ncIOxeLZqW+GFWUPYdDyxCEI0gYmrEfKlxpaN
         VJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8PHeEQvI03GO1u4arOs5eKGxrrWj+QcJXenB1+d+Ev4=;
        b=gdVXWOslFx3XPFWIyyDUr6LrraTAK5/0KEl2e54RlRRIeakValmWUFELU3wNsVNe2y
         WrAFJsp4p4/PbVmfbLbYli3xf6rc3LsVPhm/IrM/H6j3OSwSwuQDLLSVNlPQHZo/kTIL
         4cS3sQR4SGErpU0p4o4vbhCRezo6v2ldE4gzLt0mXEalQ1LXFrwH88NzebsdHFS1OD3K
         VMtA8M7oCgio+U5vvY8czYsR1q2qQaFb0RbOvsmLC7wkXa/BvlJS032OSIAwDE0e4fVJ
         gBcgG6IgxIYbAvi6KIwWJlmeVKgr+QNUACL+Je1mTB/B08RQIVxttl4SEbxmaXTI4sGw
         recQ==
X-Gm-Message-State: ANoB5plN6ERdTZje4Mndf1lFITlil1IJDSp0QcKUPqg2JWLkNuUByVDf
        4nvDQxyLBkNAorOs+2+kTykWR6eMeZKaOGBh
X-Google-Smtp-Source: AA0mqf6kGjBTXK8PVOunig0m1HO0fqDO2b1pZHBDm6FXORezd3Vc7V2LpVfuCrs+dFZA/N6MzEk9+Q==
X-Received: by 2002:a05:6e02:1251:b0:303:1c15:2818 with SMTP id j17-20020a056e02125100b003031c152818mr8384519ilq.87.1669918324962;
        Thu, 01 Dec 2022 10:12:04 -0800 (PST)
Received: from m1max.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id y21-20020a027315000000b00374fe4f0bc3sm1842028jab.158.2022.12.01.10.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 10:12:04 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     soheil@google.com, willemdebruijn.kernel@gmail.com,
        stefanha@redhat.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/7] eventpoll: cleanup branches around sleeping for events
Date:   Thu,  1 Dec 2022 11:11:50 -0700
Message-Id: <20221201181156.848373-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221201181156.848373-1-axboe@kernel.dk>
References: <20221201181156.848373-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than have two separate branches here, collapse them into a single
one instead. No functional changes here, just a cleanup in preparation
for changes in this area.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/eventpoll.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 52954d4637b5..3061bdde6cba 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1869,14 +1869,15 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 		 * important.
 		 */
 		eavail = ep_events_available(ep);
-		if (!eavail)
+		if (!eavail) {
 			__add_wait_queue_exclusive(&ep->wq, &wait);
-
-		write_unlock_irq(&ep->lock);
-
-		if (!eavail)
+			write_unlock_irq(&ep->lock);
 			timed_out = !schedule_hrtimeout_range(to, slack,
 							      HRTIMER_MODE_ABS);
+		} else {
+			write_unlock_irq(&ep->lock);
+		}
+
 		__set_current_state(TASK_RUNNING);
 
 		/*
-- 
2.35.1

