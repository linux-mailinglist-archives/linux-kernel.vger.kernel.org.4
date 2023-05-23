Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD21B70E065
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbjEWP0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237474AbjEWP0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:26:00 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A662B11A
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 08:25:58 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f60444238cso25906405e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 08:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684855558; x=1687447558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QM/LRXENQW92kfDEhBKbagV6DNZu10tuXMpBW4Kha3Y=;
        b=GpP3QlEO868ffEdiFshPBP0wC/K5EmhUiYR1UhNLFmT/1/sG8ZnkK7OBYZtsddw9j0
         0HzPGOIE5uiQK3f7lqw48S81m4YQWD+WK2oy1X59AfI7VNpj7kUj1ZJVNP/Wy6U/NxFM
         GZybTQEpLBZabo/32Nhtig+QGiV4iSwQ1Aw73Ewjbf/uoCFjyecvLc0twnaw2lSdyN7B
         VasARwg1nz1DlYQqFM32k/Ibj9YZRvjy9pr6CNhiwbUFqk5F2zRcxeSq41saOz2A/OsQ
         NiC5YVsfp5+cS1U8L54rfMp5Ig4do80EaXx3x5mct6cadRpt+cEk7x2Pmy390LMgq8Nh
         JXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684855558; x=1687447558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QM/LRXENQW92kfDEhBKbagV6DNZu10tuXMpBW4Kha3Y=;
        b=GkzbPX8GOxOEq/bLcp0hUbbLkupQCq59sdzNxfwe18A6TD3jaMGR60w3Y431keA+sC
         Bxx0K8J0uFznzQltdaAN2/2qWQGa6F44z4yuoFgak4WkohIGE1vmHqyYStLdnTKI3vBh
         JrGDxr2eXEG93RC5Z9776i262mzlNHakdqsgwuaSXAB5dVzt5iXs7Y6A1rpk9210l88L
         nakXytruaAFZYgN5YOge0MY5airSU1KHJeyG7kYddnGb7mX06nIu3VXp7Iqrzg9+oI7b
         9CimnFjd9NmHVY+FrnBwujiNXeOflfGNhBeR97QM50nkP/olIP/eYYrB9toOBXqWiYGh
         2hXA==
X-Gm-Message-State: AC+VfDxHiddktgKlAhbbcgm+ueZ82WV0WyY38zZZiw2VVHMebnsN2E6n
        Htf5iZXBCGYCqEqCP/iKtI++7g==
X-Google-Smtp-Source: ACHHUZ4r7o6Knju/yMsc9U4cWv2KB6txXsxYZUAah0Q5D9tNDyGrz644LnxSlIiZHptFPqWM77oJMg==
X-Received: by 2002:a1c:7311:0:b0:3f5:6e5:1689 with SMTP id d17-20020a1c7311000000b003f506e51689mr10865100wmb.17.1684855558235;
        Tue, 23 May 2023 08:25:58 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id f20-20020a7bc8d4000000b003f6038faa19sm8303887wml.19.2023.05.23.08.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 08:25:57 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Richard Acayan <mailingradian@gmail.com>,
        stable <stable@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/4] misc: fastrpc: return -EPIPE to invocations on device removal
Date:   Tue, 23 May 2023 16:25:49 +0100
Message-Id: <20230523152550.438363-4-srinivas.kandagatla@linaro.org>
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

The return value is initialized as -1, or -EPERM. The completion of an
invocation implies that the return value is set appropriately, but
"Permission denied" does not accurately describe the outcome of the
invocation. Set the invocation's return value to a more appropriate
"Broken pipe", as the cleanup breaks the driver's connection with rpmsg.

Fixes: c68cfb718c8f ("misc: fastrpc: Add support for context Invoke method")
Cc: stable <stable@kernel.org>
Signed-off-by: Richard Acayan <mailingradian@gmail.com>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index a654dc416480..964f67dad2f9 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2349,8 +2349,10 @@ static void fastrpc_notify_users(struct fastrpc_user *user)
 	struct fastrpc_invoke_ctx *ctx;
 
 	spin_lock(&user->lock);
-	list_for_each_entry(ctx, &user->pending, node)
+	list_for_each_entry(ctx, &user->pending, node) {
+		ctx->retval = -EPIPE;
 		complete(&ctx->work);
+	}
 	spin_unlock(&user->lock);
 }
 
-- 
2.25.1

