Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435BF611C94
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 23:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiJ1Vnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 17:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiJ1Vnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 17:43:32 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA5A23B692
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 14:43:31 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id o7so2538124pjj.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 14:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8PHeEQvI03GO1u4arOs5eKGxrrWj+QcJXenB1+d+Ev4=;
        b=l/6HssGhPRExvh/FxdFaGlFZfok/tFw3IcJbJihU0Wuk8reK2iRnYuAKeLKryPObFk
         8+myno8kH2k+Mx/mhpfG6lxbkp75xrFHJBDOoc0Hi+nCjGGX5XPhIzioZiLQHdYG7m+Z
         zH6qRIKT7+DBebh6PfSCHHRhFyJrVib7ADoS1iUOnw26Fx2qSxnkfWZ15xoHpPi+Cfkc
         uX4D3Uu/y7LbtcBERELE4v/eGWzbk+A791IJM5YqSq27H4KLResQNlvAYGSZxE6iTCWr
         J4Bj2quMAldC3LRqMQU5FPn24iu+tqiGbbAVHn1An+yZFSmKvu/tseANxOGiRShg+W+1
         BCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8PHeEQvI03GO1u4arOs5eKGxrrWj+QcJXenB1+d+Ev4=;
        b=V+MFuoI/ORtSQNDSVam+37Ew8GI9mmxFfq93bZx3nB8lEJfQoT0wayYTBPV/LtR5Z3
         58ZmAKu+5UXnTycWVS/yZ0ATGMF+n/R52rnFX6jWf0yalqlqhGe55Ke8H9hBAzMrQiY6
         J4+nhvOLw9PSIBbJhxYj/rNZAcpY78rFQrMLR9AYyD1tgfdn1guLEXq8Wv7G3uTsjyl8
         6B4D8Egmcsozup2TrutwsbvHBFOqaHmkVRNuqkywhNNyhgpYbus2PlKy21e0BsnsgmVB
         VwyGyVpDevOcNUKl/tdmtg1Da2MU3xsfKsz02jnQDh0144nutamKNaRX8o1ikXNxFHqZ
         7V2w==
X-Gm-Message-State: ACrzQf2W19a9SLrctZWKlgcN93DBxrT9OA4lIaMxnDNB291KtD50/fB7
        08NU0bPNmrQpixIQ6m1LXw4s6bPKIWj9Tqld
X-Google-Smtp-Source: AMsMyM4wS5hwn/wufRJz1ZKOMYhlqyGpKApC1sj47wA7IB3hiL7EojiiEEXM6wBR9vXHu4nvCzSA8w==
X-Received: by 2002:a17:902:f685:b0:186:fa9c:2fdc with SMTP id l5-20020a170902f68500b00186fa9c2fdcmr1086126plg.25.1666993410580;
        Fri, 28 Oct 2022 14:43:30 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id u6-20020a17090a1d4600b002130c269b6fsm2993855pju.1.2022.10.28.14.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 14:43:30 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/5] eventpoll: cleanup branches around sleeping for events
Date:   Fri, 28 Oct 2022 15:43:21 -0600
Message-Id: <20221028214325.13496-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221028214325.13496-1-axboe@kernel.dk>
References: <20221028214325.13496-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
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

