Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182D2612D2A
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 23:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiJ3WCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 18:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiJ3WCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 18:02:12 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E32A1BE
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 15:02:09 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id o7so5703363pjj.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 15:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8PHeEQvI03GO1u4arOs5eKGxrrWj+QcJXenB1+d+Ev4=;
        b=6l9nZSzxsOlgev3XI2BPsdlCYcxkwe86MfpEVfJczMSX1+0I/rH8AlHqSqBvvyUFD+
         FLOo+9r+o+aWu5kEugJOUFPwjCw4I54idiEjMpMSPIltB8jPPCqhqN8P1bXH5sssnvQA
         qkfQNjn4W48osJfV2juo6XvIlw9Z/Hure5Ix8EsJEn5JkL+e3nOK6wqxUNn8vX9vqmPp
         rG+PyTTCQLqQ6k6pwkXoxeA+qz4Tgabrzzbj+3ooWXmaRO+62+Qi0xNSgA3F6qi5GTnj
         gMK/ksFvl1WR/UPEciiD58drbBPYSQwTv7nUZ+wLrJehGnY27OoUj1IHxXCBypqKpjKr
         qU9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8PHeEQvI03GO1u4arOs5eKGxrrWj+QcJXenB1+d+Ev4=;
        b=kBXWnhdTONVxRWkrvozqzBWM15CSlYWET7nerFyxdW1toYQ/A9pWjIg4s4JFtBHY8s
         rjcOA95PwZBSRNzJAE5C54UruTvPkfyYmJ8VTlNyUDGCAo0r7DrQFzVGHi8bJuBVLV/4
         z+pslT5N1pgvY+a6FG/VVQsiYG0qOo73/NbJtxAd5f3a81kLLXBndgGUXrUo7BHFW+Z8
         he2j7p4Q20MH3NzZMRTxLs/tPTUrSizqA1aIVKa7WAGZ9wuI95YA5CNrfFVepycTvtVB
         OoWZ1HFWa50qZRddLiQHov153es6y+ZHrGe7UzTgkoI3nMCMJIB5eGrthbtrw+2LPhbb
         xGug==
X-Gm-Message-State: ACrzQf09nVe6bOjVX7WY1hIKbu4pQIN/+mD17TaF1FVhYcPjniaX3Bax
        nbqMk/gf6Q/HU2/yLstJIqaBto8zpgoxs12F
X-Google-Smtp-Source: AMsMyM6FFdgylcHCZmtH8I4OKTzEQHVeq1NVugx8akj7qK+2y0An0oYMAXlbDOSj+D4hmYwUynLsSA==
X-Received: by 2002:a17:903:2452:b0:186:99e0:672d with SMTP id l18-20020a170903245200b0018699e0672dmr11199251pls.95.1667167328768;
        Sun, 30 Oct 2022 15:02:08 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id y3-20020aa79e03000000b0056d73ef41fdsm562852pfq.75.2022.10.30.15.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 15:02:08 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/6] eventpoll: cleanup branches around sleeping for events
Date:   Sun, 30 Oct 2022 16:01:58 -0600
Message-Id: <20221030220203.31210-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221030220203.31210-1-axboe@kernel.dk>
References: <20221030220203.31210-1-axboe@kernel.dk>
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

