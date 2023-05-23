Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE9270E066
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237400AbjEWP0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237530AbjEWP0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:26:02 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DE711A
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 08:26:01 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f60dfc5f93so5091395e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 08:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684855559; x=1687447559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zy1nG9pOTv64SKYtr/YgusfuMQ/Wx1uEVdpgzP/dsWo=;
        b=JBthonnS/HLuvKwWilhGjrU2q4EYeRpdNJaCWDRl6aTDxfgxOVbMR0TUPTPJiIMHWV
         Omb8mOcXWLajNxJJbYN0v0ZEV9u+t/e6meqtkILRPYR7SgeTAhHrESQ/OygkPH270pdX
         j2ZvZIcHx0Brw7EiwhfL2Vd4ssIxxI/KN7qbPgLwJXqiM7qSSwg70PK7q1A66HQBkhwK
         1HLwMcvMezb3KAu5Zx5mqJxfNX//u+TffflgMYOCg559hS+xUpa+jkHvuI57hMl+WTyL
         Id5NDeJSgCqXSAoKAOOxvR5VBI27DVaawlV9shbw1fkb51rRwK1XQO1hWTggrt0uy525
         YBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684855559; x=1687447559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zy1nG9pOTv64SKYtr/YgusfuMQ/Wx1uEVdpgzP/dsWo=;
        b=HXnHaifgyOYnndZvaktio9iblOQE8f9pyhPCaRW6ikXUK4GM0Vvg4EkCnhA4O5A/II
         nGdi+C10CtVqFElVZ5NlZ2xUVWTEM0EUN5ysp5Ndwv/1cPcAKKQnsrZtC6mErCb+2o4N
         zEIT4fGudcw67DqyGnnsNMNir72i0p7+A5RVMBfJvVu/bUC+N1yEhC1zR/4/tKrzRick
         XxFQMlpGLKicFXaB0FVckNONWZ1j0f8GDRRaTC0TSMUU1AFbgTqbmp/J0EkyCRMtX35i
         ImLHu0Bezs1O8UFtDyEu3DP9w2uAP7qWnD6N9Xgw5kFmT8oGLe6itz7Wpj0XyyMYNeaJ
         kNWg==
X-Gm-Message-State: AC+VfDzplaQ7mI3BLkBSTnQuV0mH/ZlqbDh1sRlb5tcYu5D+vy80Q4zE
        dWKWslt80YayWr1btBhcHtKrINXNzJAEZXsOTNI=
X-Google-Smtp-Source: ACHHUZ6KtDnfsk+SHHbfW4V5x0LQezv32mF8tTTW0X9BfWbGAWOJ5L6RIvaeJ5FMmdVWEViZH1Hu8w==
X-Received: by 2002:a7b:c044:0:b0:3f4:e853:6a1 with SMTP id u4-20020a7bc044000000b003f4e85306a1mr9955820wmc.38.1684855559544;
        Tue, 23 May 2023 08:25:59 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id f20-20020a7bc8d4000000b003f6038faa19sm8303887wml.19.2023.05.23.08.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 08:25:58 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Richard Acayan <mailingradian@gmail.com>,
        stable <stable@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 4/4] misc: fastrpc: reject new invocations during device removal
Date:   Tue, 23 May 2023 16:25:50 +0100
Message-Id: <20230523152550.438363-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230523152550.438363-1-srinivas.kandagatla@linaro.org>
References: <20230523152550.438363-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Acayan <mailingradian@gmail.com>

The channel's rpmsg object allows new invocations to be made. After old
invocations are already interrupted, the driver shouldn't try to invoke
anymore. Invalidating the rpmsg at the end of the driver removal
function makes it easy to cause a race condition in userspace. Even
closing a file descriptor before the driver finishes its cleanup can
cause an invocation via fastrpc_release_current_dsp_process() and
subsequent timeout.

Invalidate the channel before the invocations are interrupted to make
sure that no invocations can be created to hang after the device closes.

Fixes: c68cfb718c8f ("misc: fastrpc: Add support for context Invoke method")
Cc: stable <stable@kernel.org>
Signed-off-by: Richard Acayan <mailingradian@gmail.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 964f67dad2f9..30d4d0476248 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2363,7 +2363,9 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	struct fastrpc_user *user;
 	unsigned long flags;
 
+	/* No invocations past this point */
 	spin_lock_irqsave(&cctx->lock, flags);
+	cctx->rpdev = NULL;
 	list_for_each_entry(user, &cctx->users, user)
 		fastrpc_notify_users(user);
 	spin_unlock_irqrestore(&cctx->lock, flags);
@@ -2382,7 +2384,6 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 
 	of_platform_depopulate(&rpdev->dev);
 
-	cctx->rpdev = NULL;
 	fastrpc_channel_ctx_put(cctx);
 }
 
-- 
2.25.1

