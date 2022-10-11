Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30CA85FBA0E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 20:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiJKSCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 14:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiJKSCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 14:02:21 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4106B672
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 11:02:14 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id a18so6105008qko.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 11:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WO1zLatTGk7w49T3dw38/yevK8lFIMN7WGO9rdhO2q0=;
        b=hJudK9mmd0OcgTLgDLgV1SgQdwzWbP+YDsFTSLx5pTw6kLDd9wvZUakI1Y0RBR9N4F
         MiCZ9FURS1a2ZlqaLiJrZAVZui1do8JjJFFDrGJZVUyP9dLAXPaLHVN4wSeUhFGYY3O7
         Foo5ge8rRQxBknxNlFPED8LHL+QAt890PhS/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WO1zLatTGk7w49T3dw38/yevK8lFIMN7WGO9rdhO2q0=;
        b=JO3+iWxfDLlFUo9q9Jrp8GPr7ZR13nljv0Of+aYssTqEc8mYodSVRarwP0F36YkJ8X
         JPuvP4zd3kZEWxovqRJ5kYTm7xgV1dC/olq6zANreufyMdtbIpFREoPWGOQVZHh7fkKl
         So2wza1S/Ivg2vgWW6Q057Vpchusg9l0BaZr9tYMvAmZJ/WW/8vu6NjETdp9OVE8kUZJ
         z9pZD5P/QKwv7bRMcFher4QQHpmAVQV/1DLhfugfHuf6t8S30IB9GcQXxiW2udKGNEvX
         spvot+ovpNb65mNJ8IYCmT+Ky4BMHCy4SK106V2yU3+B0w1K8H9Te24jhDGgbfONmxqK
         4XaA==
X-Gm-Message-State: ACrzQf09dJ3ZcY0m/Opd/a9f/AeQ0mhBwLIV2HjO10Rf/vdDn2/Gudea
        4ngRKzDZROO7BitIJtgtmfEVgQ==
X-Google-Smtp-Source: AMsMyM7324BoWYVxRirwNMwpbVd3WMPZue9BstlCjUpvA89OlscCV7sGeoW1dTP5ocXp5XnFyijwVA==
X-Received: by 2002:a05:620a:28c1:b0:6ce:b23c:dcac with SMTP id l1-20020a05620a28c100b006ceb23cdcacmr17417950qkp.123.1665511333536;
        Tue, 11 Oct 2022 11:02:13 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id w22-20020a05620a425600b006cbc00db595sm13464375qko.23.2022.10.11.11.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 11:02:13 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, youssefesmat@google.com,
        surenb@google.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v8 06/13] percpu-refcount: Use call_rcu_flush() for atomic switch
Date:   Tue, 11 Oct 2022 18:01:35 +0000
Message-Id: <20221011180142.2742289-7-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221011180142.2742289-1-joel@joelfernandes.org>
References: <20221011180142.2742289-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

call_rcu() changes to save power will slow down the percpu refcounter's
"per-CPU to atomic switch" path. The primitive uses RCU when switching to
atomic mode. The enqueued async callback wakes up waiters waiting in the
percpu_ref_switch_waitq. Due to this, per-CPU refcount users will slow down,
such as blk_pre_runtime_suspend().

Use the call_rcu_flush() API instead which reverts to the old behavior.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 lib/percpu-refcount.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/percpu-refcount.c b/lib/percpu-refcount.c
index e5c5315da274..65c58a029297 100644
--- a/lib/percpu-refcount.c
+++ b/lib/percpu-refcount.c
@@ -230,7 +230,8 @@ static void __percpu_ref_switch_to_atomic(struct percpu_ref *ref,
 		percpu_ref_noop_confirm_switch;
 
 	percpu_ref_get(ref);	/* put after confirmation */
-	call_rcu(&ref->data->rcu, percpu_ref_switch_to_atomic_rcu);
+	call_rcu_flush(&ref->data->rcu,
+		       percpu_ref_switch_to_atomic_rcu);
 }
 
 static void __percpu_ref_switch_to_percpu(struct percpu_ref *ref)
-- 
2.38.0.rc1.362.ged0d419d3c-goog

