Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5ACF6B6B66
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 21:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjCLUoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 16:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbjCLUn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 16:43:26 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3023866F;
        Sun, 12 Mar 2023 13:42:52 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id nn12so10024226pjb.5;
        Sun, 12 Mar 2023 13:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678653771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZTj6lDaB879i6vS4ZDrKb4b2c9OODf1NGI0zVIt2OIQ=;
        b=KC3a1z9EFBAXvyyxFRBFqNe8y53x3UcUyQeZSEkxdXoFUAJoXRMW5x12S3KgDohLCq
         HgPllXDe0L7d4jpa0swkH8xEUPkFw+qkPtFiETd3slsVUSiYo1BMGyXc78dOVy4xIsa/
         iQz7mHAZKXq1dPOkNL0Budytd+6487+pbd6M9552NaGPYaDjcY0OoL/Kg3JCLgUOfw1j
         VKsL6McmgvXWpcQP5dDkT0F/Lf8ekwYWTnQmW8G5vhEJFBvpzPwqbXsO+AWYZohCOO6R
         EWELqpscPHrGPQKL7eMTq4bDp1G+IKNbckzIV0LI00pT4l33/MvugcwF0S7AKAFr/dJ+
         +U6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678653771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZTj6lDaB879i6vS4ZDrKb4b2c9OODf1NGI0zVIt2OIQ=;
        b=zZf/mf/mNjE69j0uXSMEK66hVgPFXs/s+ykB22M6Z/dzjee8zhc2Twzv/axebtC+zI
         1cvZZTaN42XcgnAsJmTw0y6elsh1BEiHeOYFER8fNW4TEFjPMeXNeKWkf/CkQ0sw51Pa
         BN7OWqrelLILq5ZE+zOIRieNW6klHX8JxCmM4oiuYhmUKW0CZLHrtJt+gHUTqMQtIqH3
         ms4+REdr3slhKkEfvq6u3sxgPWIdV6JWxM8XQ6veChqgWh07K1VoVcNDevyYHyNQu8/5
         XlUesKlBSyMk25ORN7PSbBnh8Sl34LA9BfkVFzkJG2lw98orG6CX6cSF6A5xyZbk7sqP
         a6+Q==
X-Gm-Message-State: AO0yUKV5FG81HYqh4K2eGcN2hh5mecTXxIv5A9RXOXb9jx2os2lFw1YQ
        RmlaW9Lf91urwfvbZ4L8hJ8=
X-Google-Smtp-Source: AK7set8LS5r2Un4ozPG4+s7BFDawLVgaX+1P9ahu9XWoxUwBD1fydMV+4TYjTw5igtEd4Yq+x4LEeg==
X-Received: by 2002:a17:90b:368c:b0:23c:8ee2:bc14 with SMTP id mj12-20020a17090b368c00b0023c8ee2bc14mr2702243pjb.24.1678653771444;
        Sun, 12 Mar 2023 13:42:51 -0700 (PDT)
Received: from localhost ([2601:1c0:5080:d9fa:9b45:95de:f47d:f85e])
        by smtp.gmail.com with ESMTPSA id it14-20020a17090afb0e00b0023530b1e4a0sm3158971pjb.2.2023.03.12.13.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 13:42:50 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Georgi Djakov <djakov@kernel.org>,
        linux-pm@vger.kernel.org (open list:INTERCONNECT API),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 13/13] interconnect: Teach lockdep about icc_bw_lock order
Date:   Sun, 12 Mar 2023 13:41:41 -0700
Message-Id: <20230312204150.1353517-14-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230312204150.1353517-1-robdclark@gmail.com>
References: <20230312204150.1353517-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Teach lockdep that icc_bw_lock is needed in code paths that could
deadlock if they trigger reclaim.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/interconnect/core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index f7251784765f..5619963ee85c 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -1127,13 +1127,21 @@ void icc_sync_state(struct device *dev)
 			}
 		}
 	}
+	mutex_unlock(&icc_bw_lock);
 	mutex_unlock(&icc_lock);
 }
 EXPORT_SYMBOL_GPL(icc_sync_state);
 
 static int __init icc_init(void)
 {
-	struct device_node *root = of_find_node_by_path("/");
+	struct device_node *root;
+
+	/* Teach lockdep about lock ordering wrt. shrinker: */
+	fs_reclaim_acquire(GFP_KERNEL);
+	might_lock(&icc_bw_lock);
+	fs_reclaim_release(GFP_KERNEL);
+
+	root = of_find_node_by_path("/");
 
 	providers_count = of_count_icc_providers(root);
 	of_node_put(root);
-- 
2.39.2

