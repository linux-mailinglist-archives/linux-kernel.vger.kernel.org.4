Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193565E6F41
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 00:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbiIVWBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 18:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiIVWBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 18:01:31 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAF4105D73
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 15:01:30 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id g2so7222514qkk.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 15:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=xKb1FWV/BNF7dFbOAVH7aAIeBlfPfyRPTEu/ZS4Sqtc=;
        b=RnyQz9cyUSvE+E9yNg8BuKP3ayY1XXrWj08RP64gS1HcGnYT5NUIRDUjvu3gGiWjUV
         o1Zbw5vznDKaFeJJ5TIS25gdWVQxGknMvaW+EOMWW8Mrw9cPMyB4MMIkbhCcIW/L8WnW
         5FiFRK9OG3eWD6ot5GkUHboo9fTJIcjWNYVko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=xKb1FWV/BNF7dFbOAVH7aAIeBlfPfyRPTEu/ZS4Sqtc=;
        b=qkOesMh/7/C/y4SlAe1jgHg4oes9BVcYj6pxS2Agy+1Ynj3KxqK4ltUjg0pTwRfp+Z
         L88V0rKeFcEKlm0BW1nyA8LZqWSRkHcwVhhVhnUwRk/FU8ios8loL6kdl8W2C1A7VlD/
         y5HHE0KuPbTZiZ6dwVE6SOhMsQI9mhnpxLTGKww+lCHiaE4+DTsn07kV7riE2GhAHvOL
         QXVE33cGJPOoR7nxwRtPnNwr0/Fylqn25n+c20xzSnT1b0CMUEfsXNdM98tnDkPmVUGn
         EWEKzLpDn1OKHhc9D2oGlu0dLSaPqysmIF2lpYIQItbCVcGv4F93br2V9tEY2PUzZ1pk
         IaDQ==
X-Gm-Message-State: ACrzQf3DYEBnXLi0yRh5JPwkXumOHwgnqLuzA4GqaqK6HK54ct8vKQCW
        qyvzCJkO8JAoIn9QW1Rcr/Ibzg==
X-Google-Smtp-Source: AMsMyM4/Y4MStj6VIj9Ja0U0VSqEWGeY7ueLAXYF+EGSUTsY0oso40SG361nVaHoskgS1OvVwPwISA==
X-Received: by 2002:a05:620a:198a:b0:6ce:7f32:9f3f with SMTP id bm10-20020a05620a198a00b006ce7f329f3fmr3844189qkb.90.1663884089931;
        Thu, 22 Sep 2022 15:01:29 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id z12-20020ac87f8c000000b0035ba7012724sm4465833qtj.70.2022.09.22.15.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 15:01:29 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v6 4/4] percpu-refcount: Use call_rcu_flush() for atomic switch
Date:   Thu, 22 Sep 2022 22:01:04 +0000
Message-Id: <20220922220104.2446868-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
In-Reply-To: <20220922220104.2446868-1-joel@joelfernandes.org>
References: <20220922220104.2446868-1-joel@joelfernandes.org>
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

call_rcu() changes to save power will slow down percpu refcounter
per-CPU to atomic switch path.  The primitive uses RCU when switching to
atomic mode.

The enqueued async callback wakes up waiters waiting in the
percpu_ref_switch_waitq. This will slow down the per-CPU refcount users
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
2.37.3.998.g577e59143f-goog

