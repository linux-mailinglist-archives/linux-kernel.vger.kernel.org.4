Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0118C6BBBEA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 19:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbjCOSUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 14:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbjCOSTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 14:19:42 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C973D7FD50
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 11:19:35 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id r5so17221010qtp.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 11:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678904375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5YdSl/dl9DoJC+jKcZh9kCRHqYQQP7O2cdVc7Sb2ak=;
        b=RsVsQ4s1t13v0tdqWA51fkEfKF52Wabe0BT7RvouKtsN3SK0//3iMefFvaIvGSPk3y
         SMfbIluc3bKhAJGiA56yuTxrMPHfSZ3IYJfnGbhREPp5HrIbhQ48sEbDHHmB5GOlCPs6
         ibsxdEx3Lz1874eR10BibIZlrij+HeWqH43x8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678904375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5YdSl/dl9DoJC+jKcZh9kCRHqYQQP7O2cdVc7Sb2ak=;
        b=jFx2IYgkLRo1g3mjn8fwmN8WFB4wX6vSPY2DmPgycDMc6MvjvMdOi/Pv7EVnj00W75
         GmfRkJJqB0Ue6X6LFthAiAZp4Y4Ysbl82Sk3sTyWGxV6hc25jhFyah+bh/5HV6+qF4MB
         URCmQmbuQqhRBEv/y1yxVNPjhOen1KyM/dP83JuLwjL3Sv0IVnmqjPL1pJV/XlKH+obf
         wiM8MVCRyCFOSfsVdpccUYj/WGTP8rLx36QfoUEONNVWomRxAOVaq28J1bjnva52s2wV
         eyFr4R+jbMdVbEVMw982gu7Y64FQW3yu9vpySWueTVnpOz16qRubcziP3ln8T1qzUlBK
         HqPg==
X-Gm-Message-State: AO0yUKUeyd1C2hZM1Ifw0uzW0MAK6zvghfsQRPqQhoKGt3SnnrDHATPy
        QbsKZtUkeGXWqifEX4lVK0TXFg==
X-Google-Smtp-Source: AK7set+w/Bt6e/x/yy6K0dkN6uYT2fGt0eAwmnOwDheSYTZWX82N4YPJ8IfFATBHdM3YIhXA6lLZIA==
X-Received: by 2002:ac8:4cd9:0:b0:3bf:cd81:3a31 with SMTP id l25-20020ac84cd9000000b003bfcd813a31mr758797qtv.65.1678904375328;
        Wed, 15 Mar 2023 11:19:35 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id v125-20020a379383000000b007458ae32290sm4113974qkd.128.2023.03.15.11.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 11:19:34 -0700 (PDT)
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
Cc:     Zqiang <qiang1.zhang@intel.com>, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org
Subject: [PATCH v2 10/14] rcutorture: Create nocb kthreads only when testing rcu in CONFIG_RCU_NOCB_CPU=y kernels
Date:   Wed, 15 Mar 2023 18:18:57 +0000
Message-Id: <20230315181902.4177819-10-joel@joelfernandes.org>
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

From: Zqiang <qiang1.zhang@intel.com>

Given a non-zero rcutorture.nocbs_nthreads module parameter, the specified
number of nocb kthreads will be created, regardless of whether or not
the RCU implementation under test is capable of offloading callbacks.
Please note that even vanilla RCU is incapable of offloading in kernels
built with CONFIG_RCU_NOCB_CPU=n.  And when the RCU implementation is
incapable of offloading callbacks, there is no point in creating those
kthreads.

This commit therefore checks the cur_ops.torture_type module parameter and
CONFIG_RCU_NOCB_CPU Kconfig option in order to avoid creating unnecessary
nocb tasks.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/rcutorture.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 8e6c023212cb..83870c4ae1b8 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -3501,6 +3501,12 @@ rcu_torture_init(void)
 		pr_alert("rcu-torture: ->fqs NULL and non-zero fqs_duration, fqs disabled.\n");
 		fqs_duration = 0;
 	}
+	if (nocbs_nthreads != 0 && (cur_ops != &rcu_ops ||
+					!IS_ENABLED(CONFIG_RCU_NOCB_CPU))) {
+		pr_alert("rcu-torture types: %s and CONFIG_RCU_NOCB_CPU=%d, nocb toggle disabled.\n",
+				cur_ops->name, IS_ENABLED(CONFIG_RCU_NOCB_CPU));
+		nocbs_nthreads = 0;
+	}
 	if (cur_ops->init)
 		cur_ops->init();
 
-- 
2.40.0.rc1.284.g88254d51c5-goog

