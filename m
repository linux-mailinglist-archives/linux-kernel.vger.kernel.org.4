Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0995FBA10
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 20:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbiJKSCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 14:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiJKSCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 14:02:22 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2540B6C13B
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 11:02:15 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id jr1so736300qtb.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 11:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyNPGKSpanWg1PBp+oFJtta8YoEUOyUADsqxsJVyYKI=;
        b=RtJLh8hhWnLgz7H2ouhSD8X603653sxyhN7F+Uyl3LsoMZ495whCSzGe0Tv82QG8AY
         40OZ8tMwqiBkGxWoZc5D8yzi4E0VacjdZbVahuN0sq8Q1HnKHfvDz0bt12Qgk5RsQOvo
         iDkd3DZofVxvv2YqJvV9mFXxc8ixoqdCvLMR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cyNPGKSpanWg1PBp+oFJtta8YoEUOyUADsqxsJVyYKI=;
        b=pww4jaw8dlLRXPHRo6n7gzuM5W83pQraujcjwFIK0dcllBD34VRkckAVLWg/Q//vex
         dnvJV5r0C7DeEgnxYOOoqrg0BdMp3nYrNcAKR7ny++AzA4PB0io6h/CzClrexcaHTR3S
         uaWkCvvVb63mCABEkz7qDnTjR0QbaBKrUXZvEB2OGnR4BuBk1GlYTF6AFa4a1AMNvDNB
         CWss8FghYLpQKXq7uN9bs3wS5jLQkhjHvJ6FhyHSJo0yqnS3x9qgAJ+Pg2fVLiveo5z2
         MPiWkHz+J/z3M+CyYoC0C4Hjez3vKXYvhwKtVc37kL/kj4opKnyfMHsqCCmQSHLBZME2
         VF3A==
X-Gm-Message-State: ACrzQf26HNOLyDFgw34/kr9r2j0PPMFHuYHaBENKI5WClw19LYexqCsN
        1VtTMR7bs12VJY7WnBB42J2jlw==
X-Google-Smtp-Source: AMsMyM5NxunybvBu18cQe7HH24MwPf/Pyl1zvCxtMO7bdugqWtTjcqNtWX0QeIY/yx3X5mIwNou/yA==
X-Received: by 2002:a05:622a:1ba6:b0:393:d282:9a8b with SMTP id bp38-20020a05622a1ba600b00393d2829a8bmr20297291qtb.342.1665511334364;
        Tue, 11 Oct 2022 11:02:14 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id w22-20020a05620a425600b006cbc00db595sm13464375qko.23.2022.10.11.11.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 11:02:13 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, youssefesmat@google.com,
        surenb@google.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v8 07/13] rcu/sync: Use call_rcu_flush() instead of call_rcu
Date:   Tue, 11 Oct 2022 18:01:36 +0000
Message-Id: <20221011180142.2742289-8-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221011180142.2742289-1-joel@joelfernandes.org>
References: <20221011180142.2742289-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

call_rcu() changes to save power will slow down rcu sync. Use the
call_rcu_flush() API instead which reverts to the old behavior.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/sync.c b/kernel/rcu/sync.c
index 5cefc702158f..bdce3b5d7f71 100644
--- a/kernel/rcu/sync.c
+++ b/kernel/rcu/sync.c
@@ -44,7 +44,7 @@ static void rcu_sync_func(struct rcu_head *rhp);
 
 static void rcu_sync_call(struct rcu_sync *rsp)
 {
-	call_rcu(&rsp->cb_head, rcu_sync_func);
+	call_rcu_flush(&rsp->cb_head, rcu_sync_func);
 }
 
 /**
-- 
2.38.0.rc1.362.ged0d419d3c-goog

