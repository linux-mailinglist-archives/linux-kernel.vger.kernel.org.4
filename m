Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4045F3B87
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 04:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiJDCm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 22:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiJDCm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 22:42:26 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3038E2339B
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 19:42:25 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id u28so7693575qku.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 19:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=cyNPGKSpanWg1PBp+oFJtta8YoEUOyUADsqxsJVyYKI=;
        b=p7gxr8BOzPMoIl63Waae9ssjZi2XtE67S7yBYwewcinAF/AqvnClbq17oXihpKvHQi
         /8SzODU4rEaB9L2Xt7526x1uvkkX+cJFkK2yopse5rNtnLC42UWRgbODMXZAt/nh/FQ2
         +mjgTe4d7MtTAJ/CJug4mLXOQgiCVUOeqwoho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=cyNPGKSpanWg1PBp+oFJtta8YoEUOyUADsqxsJVyYKI=;
        b=tw1pGjV0pnQOVH4xHFijDbkmqzyJQJGsQftzyEUGem+7WBBcA078xUV1YVypXJpo7O
         vrmf6//ioMwsMgmg/WOZsBSqV/BYaXAoBfW2tRRROFAho8tCtGIGoFb90O0mSPgkQzMn
         3Jm/Jmt+zsYldM6qsoK5WtglK6a8RqFLPwdtelJPRfhKyJZ+TWogpjZu9BdkdEv2o8+N
         Jp8Ing7uqoF+aZNj3JZmJzxnT8QCVoqK5SjsivhQA/sMMjWlsR1MopE9Dk4PEhYTzrk1
         N704y3QRbtp49mJ6RJIE3s/hXOIbV3PHCymBmgn3AWp24pHP6ou/HXmGZglP33UeKQ/j
         4xJA==
X-Gm-Message-State: ACrzQf3hrLftR3SSOJuOsDMNYCRHwX//nL0Hpbh1d6DCwJDtpLAbE6D7
        KvCcRuSSPNMhWBiFbCWR1ZJJyw==
X-Google-Smtp-Source: AMsMyM6fCVLZqIV9NJDDecY/faq4ubFj7YCBYr92jE5ezFM/7K/NssIz4oF08sZhf7H/Aa1rVIfyow==
X-Received: by 2002:a05:620a:198a:b0:6ce:7f32:9f3f with SMTP id bm10-20020a05620a198a00b006ce7f329f3fmr15896386qkb.90.1664851344870;
        Mon, 03 Oct 2022 19:42:24 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id 1-20020ac85901000000b0035cf5edefa6sm11793875qty.56.2022.10.03.19.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 19:42:24 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, youssefesmat@google.com,
        surenb@google.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v7 07/11] rcu/sync: Use call_rcu_flush() instead of call_rcu
Date:   Tue,  4 Oct 2022 02:41:53 +0000
Message-Id: <20221004024157.2470238-8-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221004024157.2470238-1-joel@joelfernandes.org>
References: <20221004024157.2470238-1-joel@joelfernandes.org>
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

