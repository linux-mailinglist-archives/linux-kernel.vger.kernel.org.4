Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3111D5B9186
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 02:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiIOAOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 20:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiIOAOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 20:14:36 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A12E5F6E
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 17:14:34 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id 3so11757336qka.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 17:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=A1vsCw7qsSbg6LG6s3lCEoHneJ7sDD1rTCb2gsMBhiI=;
        b=PVl0MtbuC8jP0UnDsRzD+DryiQcwfi3cdRxo1mYiLGB8fjmQS20KFseigIWbxllokR
         COcSb6OcEDsD5gucsUYep4hzLW6CW/pF7H6hf7a7LE9R+G6dJUVv+ekd/+7NxLMJCCVL
         4QUu2IzMbm6D2kPkwWMzqte+24i+TJwQtpCTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=A1vsCw7qsSbg6LG6s3lCEoHneJ7sDD1rTCb2gsMBhiI=;
        b=hMtEzw69nzRPd4tPoXlbywgmRPSzGKCGC3dd4zV2fP7c6xC1HLVdO2b5Mf6t4dD0lb
         uCGFrM5NQII/jlOatjCmPqw0U8P2zFzFM1Jxo+d10etP2luVqhgFd18zMuaBFkYeUlnx
         ZulMropoG7smLttNdipcHHvX3RvmyKNwUl4hEWC92BjerIMYY0uJD+e97lO9QjZN/3FA
         8piCTXdV6D9f5GYql33RIzSdTmdvXMOEmNlFPgcAyvduyDaqV/R+S8f8w7RinhLmZ4gm
         PwnAsFDWppbGtz+FRJdTsjZabkj7nWcVczj4f0JGShCzcyLjHAJpVVL8Zdv6w4iY4qre
         1GzA==
X-Gm-Message-State: ACgBeo3ksSqJif8U85UBUp5ZjuaGecBcYfBSqCmkM73dOnUgK15dsAyS
        mT/BXITMwZ5poE6YIqJ21EDW8GLwP1QritWBgSM=
X-Google-Smtp-Source: AA6agR7skx+qmUrnXxbC9eolRQX/E9WCYME4MPsQJ6mEMoqK9nsQdr33ypJE00CInZ5jxffolQVMlw==
X-Received: by 2002:a05:620a:454e:b0:6ce:3c11:24ad with SMTP id u14-20020a05620a454e00b006ce3c1124admr13034044qkp.606.1663200873386;
        Wed, 14 Sep 2022 17:14:33 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id do11-20020a05620a2b0b00b006bbb07ebd83sm2872422qkb.108.2022.09.14.17.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 17:14:32 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH rcu/next 1/3] rcu/tree: Use READ_ONCE() for lockless read of rnp->qsmask
Date:   Thu, 15 Sep 2022 00:14:17 +0000
Message-Id: <20220915001419.55617-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220915001419.55617-1-joel@joelfernandes.org>
References: <20220915001419.55617-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rnp->qsmask is locklessly accessed from rcutree_dying_cpu(). This
may help avoid load tearing due to concurrent access, KCSAN
issues, and preserve sanity of people reading the mask in tracing.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 0ca21ac0f064..5ec97e3f7468 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2106,7 +2106,7 @@ int rcutree_dying_cpu(unsigned int cpu)
 	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
 		return 0;
 
-	blkd = !!(rnp->qsmask & rdp->grpmask);
+	blkd = !!(READ_ONCE(rnp->qsmask) & rdp->grpmask);
 	trace_rcu_grace_period(rcu_state.name, READ_ONCE(rnp->gp_seq),
 			       blkd ? TPS("cpuofl-bgp") : TPS("cpuofl"));
 	return 0;
-- 
2.37.2.789.g6183377224-goog

