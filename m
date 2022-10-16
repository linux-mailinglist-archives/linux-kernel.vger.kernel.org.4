Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CF8600142
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 18:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiJPQYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 12:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiJPQXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 12:23:54 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9A233E22
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 09:23:43 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id a5so5401159qkl.6
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 09:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8IMqQmd/XghF0vc5rGTchLEnwifIWdplO8ZK5ZR9Yzk=;
        b=py7m4915l5o5WsLd4bMO+78MLiz5ALzpVVpmzpKDyUl2p5IK12I+DK7uMK1ctklRZc
         0ctsYyMCESSdCSlRIci8QFRlMwzZFyL/wDKPbOgLpI9GsDGWmO+UREym0nzKAi3x0z06
         1U5rjt6VxS5AmaRVMN/lURrp/Fv3eAx599HvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8IMqQmd/XghF0vc5rGTchLEnwifIWdplO8ZK5ZR9Yzk=;
        b=Y2vm1rSHed6KB0wRwRi891ImRZFu1IwpSkFqsqViz9qABsNjKGZYnaqRGOrqnCDQ/z
         MQIrCxNNmJA8wVoH4v6Lk+mMkFg4PpycP45/arPZUwDwR6An1IXNbMAVwiqfq18E1Sxd
         e8ToBd1piLn0xB97uckva0/EpUb0dWf97/jq0MmFy7fTCM4pokgjGD050L0rehSsfCXs
         StXWeF53ZQ9BEC1lUB1CSp4JZgah9hb/OBKGyDv44An23ZNTa60fIBUC4M3yh9tPgTw6
         n3iWaXjJzLj3xP9XVmgddOG46KfQVQDjszAQQ2t6u8rmWoElEUUYrcDTpoT+FHC3X/n6
         wJ9A==
X-Gm-Message-State: ACrzQf2kSXBAIfVoiCuPziHEm23hnTWjsVrEowU/Y57JXQpIBHrhJAuX
        AXAD8GJlFyoW/yfbNP+AeT3o6A==
X-Google-Smtp-Source: AMsMyM7B+qxY2by1V80Iz7B1giQEQSaStGfhI9NCYkeSiOKo4y/7wOpJUJbmcS876UGqN1p2LoXwsQ==
X-Received: by 2002:a05:620a:2045:b0:6ec:bd25:ea67 with SMTP id d5-20020a05620a204500b006ecbd25ea67mr5004470qka.85.1665937421414;
        Sun, 16 Oct 2022 09:23:41 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id x19-20020ac87ed3000000b003436103df40sm6001207qtj.8.2022.10.16.09.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 09:23:41 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, frederic@kernel.org,
        paulmck@kernel.org, Uladzislau Rezki <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH v9 11/13] workqueue: Make queue_rcu_work() use call_rcu_flush()
Date:   Sun, 16 Oct 2022 16:23:03 +0000
Message-Id: <20221016162305.2489629-12-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221016162305.2489629-1-joel@joelfernandes.org>
References: <20221016162305.2489629-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Uladzislau Rezki <urezki@gmail.com>

call_rcu() changes to save power will slow down RCU workqueue items
queued via queue_rcu_work(). This may not be an issue, however we cannot
assume that workqueue users are OK with long delays. Use
call_rcu_flush() API instead which reverts to the old behavior.

Signed-off-by: Uladzislau Rezki <urezki@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index aeea9731ef80..fe1146d97f1a 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1771,7 +1771,7 @@ bool queue_rcu_work(struct workqueue_struct *wq, struct rcu_work *rwork)
 
 	if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work))) {
 		rwork->wq = wq;
-		call_rcu(&rwork->rcu, rcu_work_rcufn);
+		call_rcu_flush(&rwork->rcu, rcu_work_rcufn);
 		return true;
 	}
 
-- 
2.38.0.413.g74048e4d9e-goog

