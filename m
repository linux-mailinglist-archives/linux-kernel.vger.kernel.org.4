Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B49A5BC37C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 09:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiISHYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 03:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiISHYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 03:24:00 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56161A83E
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 00:23:59 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-11e9a7135easo60713957fac.6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 00:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date;
        bh=sCiPjQA8piKqpO36PIwKnu4u/TUaVUoG8iasiR3UyYg=;
        b=FZ0UP0kVQBddy5BvvXz/0bbGguGduK7ReCFhhPrly+/Tr+wl/w8ABX6rJ59mqJIdp1
         3hLfh9qVzQZVAO9UHVBDq+C9sjaRVbHMtbe8FrmlqUYQEX/IopnJBE2Din+Ygs4ko+9W
         yPZmG2PIoQ5ecKKgP1h0dqOnYrQy7Ch1heFSZkq90uyWMdnK5csZbcIO4OO0Rfy7GSXg
         JJYlYNMdOe7qEQJinvCx78ubuPPeoV7rIgjxrW0qbiouPrNzY2lLRekg+L0jlnjBD1/v
         d4b/qHGOb5+4XIA0RUB1psmV3LfdnhFaJ7y2TmqWJJ4Vw02OZQw7nH+UqahELHcHLhZE
         6/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=sCiPjQA8piKqpO36PIwKnu4u/TUaVUoG8iasiR3UyYg=;
        b=y+J1fiZrQnkZy3JVfpU3aycpKnZyrPLJS+hOhu7BIMQ7EpJu4mbpDCqvET9DatXmtn
         tL3h5YAfp4boPvSy2DmjzGuCoznrfoiqPnxt2h+oqJkUPlK7lAE01dENc0zO/mYbFFev
         nwHQPQEgjN+yQX3PFBsx3Qo4Cdf+YHAuKIQ5+JGWvMDUqQOI9BkG9mKSP8f0xOgZY6W9
         050XDwfK2vPVnqMZv9c5xr2vnTCBptfhYAQJG3rE1Lnwy1bcGAOdG2gNC4lX2MRajfob
         ym06pxpCet8bR6QP3XFTe2EqjRXYj0NgiRLoDmGxuG8IHRCb8XmWnsRT+JxQJ2dLJ4kC
         q5Uw==
X-Gm-Message-State: ACgBeo0eATbMUtzmwGQCem10BGYFcMrGGEpNpeWKHkmlJbFLO7GRJWek
        9Fz1jLKzSWtxqCm9wavlL0U=
X-Google-Smtp-Source: AA6agR7bsHoK8O8o+qYLGqJhcg9CxAHfP7w+25hqrijqTl6F8de0QmGpWkd1yEib2fhGsWgd53+Fdg==
X-Received: by 2002:a05:6870:c38f:b0:12b:cb22:9056 with SMTP id g15-20020a056870c38f00b0012bcb229056mr15542798oao.125.1663572238301;
        Mon, 19 Sep 2022 00:23:58 -0700 (PDT)
Received: from haolee.io ([2600:3c00::f03c:91ff:fe02:b162])
        by smtp.gmail.com with ESMTPSA id x30-20020a056870331e00b00127a91041a9sm7202871oae.38.2022.09.19.00.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 00:23:57 -0700 (PDT)
Date:   Mon, 19 Sep 2022 07:23:56 +0000
From:   Hao Lee <haolee.swjtu@gmail.com>
To:     hannes@cmpxchg.org, surenb@google.com
Cc:     peterz@infradead.org, zhaoyang.huang@unisoc.com,
        haolee.swjtu@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2] psi: fix possible missing or delayed pending event
Message-ID: <20220919072356.GA29069@haolee.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a pending event exists and growth is less than the threshold, the
current logic is to skip this trigger without generating event. However,
from e6df4ead85d9 ("psi: fix possible trigger missing in the window"),
our purpose is to generate event as long as pending event exists and the
rate meets the limit, no matter what growth is.
This patch handles this case properly.

Fixes: e6df4ead85d9 ("psi: fix possible trigger missing in the window")
Signed-off-by: Hao Lee <haolee.swjtu@gmail.com>
---
 kernel/sched/psi.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 9711827e3..7d305d0e0 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -539,10 +539,12 @@ static u64 update_triggers(struct psi_group *group, u64 now)
 
 			/* Calculate growth since last update */
 			growth = window_update(&t->win, now, total[t->state]);
-			if (growth < t->threshold)
-				continue;
+			if (!t->pending_event) {
+				if (growth < t->threshold)
+					continue;
 
-			t->pending_event = true;
+				t->pending_event = true;
+			}
 		}
 		/* Limit event signaling to once per window */
 		if (now < t->last_event_time + t->win.size)
-- 
2.21.0

