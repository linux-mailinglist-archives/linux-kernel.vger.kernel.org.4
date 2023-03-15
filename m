Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8C86BBBE9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 19:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbjCOST4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 14:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbjCOSTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 14:19:41 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629D07DD13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 11:19:34 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id y10so17247502qtj.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 11:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678904373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Bvd7KqU+0UJPbIZv2ZisqXKCDIddIzWkPhDnOppke0=;
        b=Bj88++U5M+bx+xrI+ueEqEmtvkt/BQxGm9alRbvENUNQgW/XLsUqKg+0i9rYjVwo/U
         xCkd8SkXbBn5uwMwDpOTp4ud+QYb1pA6hKv6CViFcxzUXknbgDo+WJAOH8ZGPY5Q4kih
         eJkADceCNkzHpKA9rKi6gN8oC5ABQXKSF5mo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678904373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Bvd7KqU+0UJPbIZv2ZisqXKCDIddIzWkPhDnOppke0=;
        b=wIoGRHouKPatvMVZJmxLr6zBjugOkkGkPMbRoXeLyAzFCsrSioPgW5yew28ob5Nc1F
         j0dq5yX3R7huFVRZ02GBsAFByH/wh4xzutFrxXbfeP6VrjboRlK3lSUXgjqp+yPwTPbo
         Ss95wd0s85ReOPDvatVydSwaaAlNnY9e9jeZnnsCmCu9rO+f4I6ptcyvtTurSAI1BI1t
         LX4e/O15pxqlIXqZu7AUKVQph+z1QKn13easgb02BIbf6quGaa6Vh98HH3re/pSEYw+o
         ZsQLlEruBeYOgShYb+06ZyhT1oAp5pkfxzcQAhTYtjZzVY3KWleuvf8r2/m0zz4w+PIc
         lNKA==
X-Gm-Message-State: AO0yUKUTyo3Pzbkvpac1lWH4JJc60fYmS2b84oFYtzoawxwce3CdKasA
        TnlNc4gS820FFwAOWeYh3RMVmA==
X-Google-Smtp-Source: AK7set9+egTI2wMDAMY8dnTaLEBRl12RRV7zCaE7OSYn+8iy+tPhMG7McRQkufAEB31HwULzaVxfUg==
X-Received: by 2002:ac8:7c50:0:b0:3b8:4adb:c604 with SMTP id o16-20020ac87c50000000b003b84adbc604mr1513701qtv.14.1678904373115;
        Wed, 15 Mar 2023 11:19:33 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id v125-20020a379383000000b007458ae32290sm4113974qkd.128.2023.03.15.11.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 11:19:32 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: [PATCH v2 08/14] rcuscale: Rename kfree_rcu() to kfree_rcu_mightsleep()
Date:   Wed, 15 Mar 2023 18:18:55 +0000
Message-Id: <20230315181902.4177819-8-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230315181902.4177819-1-joel@joelfernandes.org>
References: <20230315181902.4177819-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

The kfree_rcu() and kvfree_rcu() macros' single-argument forms are
deprecated.  Therefore switch to the new kfree_rcu_mightsleep() and
kvfree_rcu_mightsleep() variants. The goal is to avoid accidental use
of the single-argument forms, which can introduce functionality bugs in
atomic contexts and latency bugs in non-atomic contexts.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/rcuscale.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 91fb5905a008..98b75995b680 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -716,7 +716,7 @@ kfree_scale_thread(void *arg)
 			// is tested.
 			if ((kfree_rcu_test_single && !kfree_rcu_test_double) ||
 					(kfree_rcu_test_both && torture_random(&tr) & 0x800))
-				kfree_rcu(alloc_ptr);
+				kfree_rcu_mightsleep(alloc_ptr);
 			else
 				kfree_rcu(alloc_ptr, rh);
 		}
-- 
2.40.0.rc1.284.g88254d51c5-goog

