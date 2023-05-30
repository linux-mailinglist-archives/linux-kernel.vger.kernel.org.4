Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20411715D9E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjE3LnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjE3LnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:43:08 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2060FE
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 04:42:40 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba83a9779f3so8521744276.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 04:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685446960; x=1688038960;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X9Fa1azB0PvxCnVWP8BiPunu4QSKYBQpUml6svSnRR4=;
        b=tBbXFhsb+KwoE9oe/RBk2v9mdJuTTIDySqRMyshEKtOzMZvFQaKqltj5sHLfNCbB7U
         DAAnKAtemaLVdaOI4iW473fBsrZybhyclZ+xr5O5b5ENY90G32ktqV0H86QR+iIXtzHZ
         OeZMWLokaN5xEqQJSKTtN5JZAGE0sJsN67LbpXNt3j89caN3+QHCC3fheu7jptCiaE1N
         zXmwIAk8D8alYIKgLnyC5NuPITFrGAqUPWD9shoJve99mTL4DpTjJD0+CZkCSk1p4Kn/
         fzz2nq26+v2YkNnOA9jUr65xWuXorZL00/yxEw6yG9oS9pifrM1lHyzOIblXi11t1KVx
         mWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685446960; x=1688038960;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X9Fa1azB0PvxCnVWP8BiPunu4QSKYBQpUml6svSnRR4=;
        b=L66VgJLPUOp4ycaS+N6HVb9FUldnf2d9U9nt1MH/FZOYQxXQihX8YYc3CTDp4VJRvc
         Nv1LtdE0DprdIRiLac4j1DYe67yrxjb5h8zlp0UurUtNvvMB2vJ6ditk2GBji9wKVZOv
         NdxOOCTR/cvLsAQv4KdlIC4C2NS4uXzxSVDxixJxcpkHy48vIi1OyzXd/94yYMyhool8
         2HWuA9mWkJGvvng+g7O5WQIUJsgrPvRFkEc4EwnUefOtr9jCAGvY7OifXtkRYJB8pwL+
         XA0HIGKbzRkcCsvtnMs9lM+2A31BzEps7wAXGI14AHA3esc2IJu/WkFwYfUsAEGD3xzg
         Z/Iw==
X-Gm-Message-State: AC+VfDyVMKdn8CnluwEhhM64NmH86zvhouQAuIlIYE/ehsqCdbSXdj2a
        Qq0UslqCbnqvY+zbUyUsKZT4AxgOzn07zGPk7Q==
X-Google-Smtp-Source: ACHHUZ61DYYTIxHM9/yfJ8LhkISK/Pm2f97cTxhbRcqoigrVG6nrYMSvNoZa3zX10Nsp+ldtZk1OSPfsxu8uNWUMWw==
X-Received: from yimingtseng2023.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:94c])
 (user=yimingtseng job=sendgmr) by 2002:a25:d88:0:b0:ba8:373e:acf1 with SMTP
 id 130-20020a250d88000000b00ba8373eacf1mr1217056ybn.12.1685446959912; Tue, 30
 May 2023 04:42:39 -0700 (PDT)
Date:   Tue, 30 May 2023 11:42:16 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230530114216.1420790-1-yimingtseng@google.com>
Subject: [PATCH] PM: domains: fix overflow in genpd_parse_state
From:   YiMing Tseng <yimingtseng@google.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        marscheng@google.com, YiMing Tseng <yimingtseng@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add type casters to prevent 32-bit overflow before assigning to s64
variables. It allows full 32-bit range support for latency and
residency.

Signed-off-by: YiMing Tseng <yimingtseng@google.com>
---
 drivers/base/power/domain.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 32084e38b73d..26a04cd8d8dc 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2939,10 +2939,10 @@ static int genpd_parse_state(struct genpd_power_state *genpd_state,
 
 	err = of_property_read_u32(state_node, "min-residency-us", &residency);
 	if (!err)
-		genpd_state->residency_ns = 1000 * residency;
+		genpd_state->residency_ns = (s64)1000 * residency;
 
-	genpd_state->power_on_latency_ns = 1000 * exit_latency;
-	genpd_state->power_off_latency_ns = 1000 * entry_latency;
+	genpd_state->power_on_latency_ns = (s64)1000 * exit_latency;
+	genpd_state->power_off_latency_ns = (s64)1000 * entry_latency;
 	genpd_state->fwnode = &state_node->fwnode;
 
 	return 0;
-- 
2.41.0.rc0.172.g3f132b7071-goog

