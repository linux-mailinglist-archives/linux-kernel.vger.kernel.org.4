Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10166BBD6E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 20:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbjCOTj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 15:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbjCOTj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 15:39:26 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE18167711
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 12:39:18 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d7so17419077qtr.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 12:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678909158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H58NOkpBsborYqDlb6apVPOFULtTVVJdIxtX+vdpwc4=;
        b=C093a986XM+BY5phSly7wrGZCcmMxTiTlUfXZxpE7QnM3ZVj5e2y6nnNsgpnj1q4g3
         b6kqPR4fnmeuu41UvzmMuQxZPdQQZyQ53vE4qe5XrF40jJi2gYTkZ1sgrCn/kXrFPMt0
         uDqqMdAuP1MgwDf5FFqNt6sQOBCop356zuIeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678909158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H58NOkpBsborYqDlb6apVPOFULtTVVJdIxtX+vdpwc4=;
        b=o9KTTEdd/hWVp5j5JNEixNn6GJQ+VEQN8DYGHRR4P8Wiozmbzn2oYN1uvoqd+A0o4+
         IeEyssB3pg/o6uvH9W/TMJ2SPvZ84Pr7AOrYZUd2YZGJvpTYmoSs3gX1yfdywyNUAoVw
         n/O7KBl0nBLY6TOpAbF6+dO9WbnK0CoS092D4ix7mn4g9v3QqWfUF83LehTPUAjZx1GO
         cjfFJayrIFGxhlqYMNW0ikbl81WvbqOisrnmgpe+EsDLE5YEHmciF9dVVhBwp1x7XXzr
         Q6T5fr0gWkQUBAqhOoLloOfpSRQYAraDpOvLMnvOUHZP9FQPCEwDBl0xvA41uJK776sh
         D9Uw==
X-Gm-Message-State: AO0yUKX1YUiOLwfhKsIHvU/oKgq+1iduuEp5lzY47bIdsXLfI2Cty8VS
        IoexAwIlHv9bNkCHOVXnqXN6bqmIM4tBVQpLEFM=
X-Google-Smtp-Source: AK7set/66oK6XSfs52GYzh6EZaoShJeuEtQsucB4O83OGbah83EM8uB0VUPPO6XgJzFDF7lhYm8bvQ==
X-Received: by 2002:ac8:5bca:0:b0:3bf:be4b:808c with SMTP id b10-20020ac85bca000000b003bfbe4b808cmr1465528qtb.55.1678909157780;
        Wed, 15 Mar 2023 12:39:17 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id s10-20020a05620a254a00b00745af48838bsm4347227qko.5.2023.03.15.12.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 12:39:17 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org
Subject: [PATCH 6/6] rcu: Add comment to rcu_do_batch() identifying rcuoc code path
Date:   Wed, 15 Mar 2023 19:38:51 +0000
Message-Id: <20230315193851.8598-6-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230315193851.8598-1-joel@joelfernandes.org>
References: <20230315193851.8598-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds a comment to help explain why the "else" clause of the
in_serving_softirq() "if" statement does not need to enforce a time limit.
The reason is that this "else" clause handles rcuoc kthreads that do not
block handlers for other softirq vectors.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8e880c09ab59..06cc6a6ad819 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2131,6 +2131,8 @@ static void rcu_do_batch(struct rcu_data *rdp)
 				break;
 			}
 		} else {
+			// In rcuoc context, so no worries about depriving
+			// other softirq vectors of CPU cycles.
 			local_bh_enable();
 			lockdep_assert_irqs_enabled();
 			cond_resched_tasks_rcu_qs();
-- 
2.40.0.rc1.284.g88254d51c5-goog

