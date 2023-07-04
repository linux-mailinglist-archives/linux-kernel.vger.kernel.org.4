Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CD0746A50
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 09:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjGDHIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 03:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjGDHIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 03:08:19 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D982136;
        Tue,  4 Jul 2023 00:08:19 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b89114266dso17126935ad.0;
        Tue, 04 Jul 2023 00:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688454498; x=1691046498;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3QSBORDVW5k2buwTkXzNiNoPGGqOZzae03kTOF+RVSo=;
        b=PYEOW9zIgAsNL9l0PbiWAISqeRxsMFljrPe3hyFhDFaDU3UmiRt0RpA9G0y/acDdGX
         l7/Jd7OxLmjKKZpKJ8vnGlqfvyzwjnYXbi+38gIY6nlWPiwfWcxmpas1y31MJqLr0ATD
         1uVeyMerVkE1YtkAHO6zB+JrsCxZqHVKPvaNti5NCdq0BmTwKQe5VARd57IGTyRHuEee
         jyfhVW+w3BeMVEMwSFTngE4eh+y7KV2jTvvGdpjcOqpBuoLbe4sgj+jE0crgNG6nPESl
         sgpxm5GJdbsP+LpTczWZV+neZpcjefWiRphS0HCac6yPzUH1h/6Ypwr2t0c9RvCg18rL
         l/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688454498; x=1691046498;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3QSBORDVW5k2buwTkXzNiNoPGGqOZzae03kTOF+RVSo=;
        b=exHzuzNrJ/2byVKKTCYMee5lkaTXkeUoqmj/jcoTZcIOBeh7jCMVXLBqHOU3TFE76N
         e40MJ/r3zdFTu6rOPjKXpoV2CL9Lr354moB8dAzgBe4V86gUuSjm3N307jHA25uu0ILV
         2J6I483EAT0rtT7+g3TC/1MrHG0DbZpRew2WSe8Ap4vVU9V5R7Vd9OChZPTHm5utHjLw
         qMuUZPNyfbBQBZlGIjxd2n9qkHmDoUIPUAVvVWwqeefSHOHeaNhcvXGhFSdBCmr8jM48
         mTMM419Eu6+bJ3HGxo82vC/J6n+fd8Y8pZUKFSnTMVZrpV2vEkEGxQCWRuRROwEMhs0P
         f/3Q==
X-Gm-Message-State: ABy/qLbD/cw4TyZf//XfuoHpmjSfL8rYWCLSOsmV8vDxlLPQi/uo5Tu4
        Hh1qn2XmCueWw+YovLiTx4Y=
X-Google-Smtp-Source: APBJJlEcjPPVO+rQY7XGJaL7px2FduCNvz4NWrbnyALMIyBZ6RIaUK6UDvx6qyqwC2QNfnN08oEgLQ==
X-Received: by 2002:a17:903:2594:b0:1b2:28ca:d16 with SMTP id jb20-20020a170903259400b001b228ca0d16mr12878627plb.44.1688454498470;
        Tue, 04 Jul 2023 00:08:18 -0700 (PDT)
Received: from MSCND1355B05.fareast.nevint.com ([183.242.39.186])
        by smtp.gmail.com with ESMTPSA id be4-20020a170902aa0400b001b52891bd45sm16395497plb.57.2023.07.04.00.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 00:08:17 -0700 (PDT)
From:   Zqiang <qiang.zhang1211@gmail.com>
To:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, qiang.zhang1211@gmail.com
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] srcu: Priority check rcu_gp_is_expedited() in synchronize_srcu()
Date:   Tue,  4 Jul 2023 15:08:09 +0800
Message-Id: <20230704070809.31951-1-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the atomic variable rcu_expedited_nesting is initialized to
true, so the rcu_gp_is_expedited() is always return true during
system startup until the rcu_end_inkernel_boot() is called. this
means that without setting rcupdate.rcu_normal=1 and before the
rcu_end_inkernel_boot() is executed, regardless of whether the
return value of srcu_might_be_idle() is true, call synchronize_srcu()
always fall back to synchronize_srcu_expedited(), so there is
no need to checking srcu_might_be_idle() return value.

For the rcupdate.rcu_normal=0, rcupdate.rcu_normal_after_boot=0 and
rcupdate.rcu_expedited=1 kernels, there is also no need to checking
srcu_might_be_idle() return value.

This commit therefore priority check rcu_gp_is_expedited() return value
in synchronize_srcu().

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 kernel/rcu/srcutree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 20d7a238d675..a819f11d9b90 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1435,7 +1435,7 @@ EXPORT_SYMBOL_GPL(synchronize_srcu_expedited);
  */
 void synchronize_srcu(struct srcu_struct *ssp)
 {
-	if (srcu_might_be_idle(ssp) || rcu_gp_is_expedited())
+	if (rcu_gp_is_expedited() || srcu_might_be_idle(ssp))
 		synchronize_srcu_expedited(ssp);
 	else
 		__synchronize_srcu(ssp, true);
-- 
2.17.1

