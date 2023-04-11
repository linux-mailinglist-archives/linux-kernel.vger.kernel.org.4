Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3746DDBD6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 15:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjDKNNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 09:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjDKNNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 09:13:50 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35873C3B;
        Tue, 11 Apr 2023 06:13:45 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id gb34so20420414ejc.12;
        Tue, 11 Apr 2023 06:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681218824; x=1683810824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YENHw+0ET+w+YdgKcOWDuPPqjwQPjQ7l4ozH72ShpYo=;
        b=jEOci7L6JgQ3ZrujnEk5pp7rYH/FVactWqhOpesWfHl0NdGbhTY+lyQCYxRenXEziK
         SyoZ/PI+Aq2e18lbnmxb9GHzGQQG3dCLMjAL4nuWTvC2QYTHyNFribZYutNatC8VyaWa
         w8MHPhvbugNcFUIIjx/LNIfvoGIdNOOCgESbYBuaIJy4eEooU+8L5xvBeDXZ3ZMN+Csf
         CbHq2UQgHLvfWMZ0tkwSzf16yG5Q+4bxLsFQyFk7oPJrTVKwznM8h/SzTO2vf9gZx+9g
         6tSyhQ7IlrHAocQ95UzWFlkxv+M7tN0Z+OFc0a9nHCS8iknwQy3FshOhnyBND+xN16qs
         s/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681218824; x=1683810824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YENHw+0ET+w+YdgKcOWDuPPqjwQPjQ7l4ozH72ShpYo=;
        b=hSU15Gz0BM45NVKFiI7/ng02eeAcaI1TWf6XdVCmlxHtVON5NlroRl3rePeRF5OGhD
         L6H1NXa4lC7R4VhLSryCwJwif24xV1l9bQLjBox9ojAiJvyFsnB/+dXvhl2wfOO5Aedi
         /FPzSC+RfjCjEuOpUfdXeRsbeQXekVdoDmCJimhC65U/6LNLJx77kzdh3UknFvTjq5kM
         kxKQys9Pcc9CtIllgvj3nPsbSxjjZRmawkBJAX2jKCCcrgRE7c351iEDFZc23e0YsGXS
         PJeCENjyHKjNm9pYsJpl8kROgiu+sEsiSfSMBbfuz9cfyple2jwWjnJ97HUVRnGYpuu5
         wEng==
X-Gm-Message-State: AAQBX9e3JGf9DSCpfde7tSlhHiVPzVdD+G6QDcF8AdHREkoKrW6FeA+5
        +L7vSEwV4/vPfRC73AZYhDE=
X-Google-Smtp-Source: AKy350ZpBwW8EU215CVt7dj21Uis+t7gpF+QzIDRwhkXp3hIgJnsCMI1+Hla5RGgukblAYHvuwXXBA==
X-Received: by 2002:a17:907:8a85:b0:878:481c:c49b with SMTP id sf5-20020a1709078a8500b00878481cc49bmr11201293ejc.1.1681218824091;
        Tue, 11 Apr 2023 06:13:44 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id k5-20020a1709061c0500b0094c3ac3c2bbsm1383905ejg.212.2023.04.11.06.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 06:13:43 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     RCU <rcu@vger.kernel.org>, quic_neeraju@quicinc.com,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 1/1] rcu/kvfree: Do not run a page work if a cache is disabled
Date:   Tue, 11 Apr 2023 15:13:41 +0200
Message-Id: <20230411131341.9910-1-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default the cache size is 5 pages per-cpu. But it can
be disabled at boot time by setting the rcu_min_cached_objs
to zero.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 35be35f8236b..21e3d9dffde5 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3246,6 +3246,10 @@ static void fill_page_cache_func(struct work_struct *work)
 static void
 run_page_cache_worker(struct kfree_rcu_cpu *krcp)
 {
+	// If cache disabled, bail out.
+	if (!rcu_min_cached_objs)
+		return;
+
 	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
 			!atomic_xchg(&krcp->work_in_progress, 1)) {
 		if (atomic_read(&krcp->backoff_page_cache_fill)) {
-- 
2.30.2

