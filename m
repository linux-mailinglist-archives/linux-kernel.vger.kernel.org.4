Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA01739422
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 02:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjFVAwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 20:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjFVAwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 20:52:19 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A18E198
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 17:52:18 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-57320c10635so60051137b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 17:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687395137; x=1689987137;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=udHRmMpy+xwUknnQXeH45s8WH+sOsn0OoP200LprEk8=;
        b=GAJEjs2YZoM/GNZOZEMFVk5T7kspISkVDy/DFO4zdDGLHaO58YIs0C+goCRA6w7FzX
         XsoR4zIwn2U7KXr86Epk78qLKvDKcmlmwzgG8YJt+IFdU5RbFzDfU6LU9T4QK7rt6lOK
         SqOu2GTA7iNSkTXAecvssfTivjwu0eJx57ddopDEq5TgWfb9mUIsSvlzWrm0JkHiaE2k
         tH69P30RnQ6ejx7AwVF6sbLpZEyMoc6/D3ZSNhCqi6rEytTLWhmqclLEdLEQcD3pJEzl
         6SW0KfpS74Qxf7bfjYh972DHh5xr9NNZl83oQhXq2R4dEBPMaSJIw+unH7T+ZD8Qq81U
         7Imw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687395137; x=1689987137;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=udHRmMpy+xwUknnQXeH45s8WH+sOsn0OoP200LprEk8=;
        b=CRzxAjzZtq6/txdkJJYEYbEH3fX49TAChhED/ilPx7KyW8GEbmrwz49fJsiiAyOf0S
         LeLgkAnRVt2Z223KCtep+Z6bqNjlxO+lFrOESnYaPTWhCiRMyfoQCmCo39iP8N1ZuDzt
         4IIwOVgrdrG0uKfFwMT66Snpo+fXSyjleJ3GKfCelCjDGYLHKfhStB3Z6qhK0nYqkAns
         Np3eQywfdsXH0GYvojXtvtJoXx52jhkgaf0sCudzuz3h1YShIxkUfLd0B8GVXQiB2Ex+
         q5SKONWa9R/HXw8yLKih2Xh2sEHNHqRZwz5DYTVQVFe390+7hS5VppcNpebmjOW5qN/4
         mE7w==
X-Gm-Message-State: AC+VfDzb6MV0iYtmDm5ziwrribUIu1cozweDrVRgsg1Sdwb7qFhM1GTq
        OA2NgrOjXp+ewNkm9XrBkS/lAJlzj79HFhG4cuf7Bw==
X-Google-Smtp-Source: ACHHUZ6u/7QlT4SDhN5KmiFjdmeN3Fuopi3BZMJM2tVW4FzTPKmxujg2fqXpY+4iNdUaSWeUTkYINsttv57coIFDE2Na1w==
X-Received: from isaacmanjarres.irv.corp.google.com ([2620:15c:2d:3:e855:b0d7:44f2:fbb7])
 (user=isaacmanjarres job=sendgmr) by 2002:a81:af46:0:b0:56c:e6fa:6ce9 with
 SMTP id x6-20020a81af46000000b0056ce6fa6ce9mr7022607ywj.8.1687395137684; Wed,
 21 Jun 2023 17:52:17 -0700 (PDT)
Date:   Wed, 21 Jun 2023 17:52:13 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.178.g377b9f9a00-goog
Message-ID: <20230622005213.458236-1-isaacmanjarres@google.com>
Subject: [PATCH] pstore/ram: Add support for dynamically allocated ramoops
 memory regions
From:   "Isaac J. Manjarres" <isaacmanjarres@google.com>
To:     Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        "Isaac J . Manjarres" <isaacmanjarres@google.com>,
        kernel-team@android.com, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Isaac J. Manjarres" <isaacm@codeaurora.org>

The reserved memory region for ramoops is assumed to be at a fixed
and known location when read from the devicetree. This is not desirable
in environments where it is preferred for the region to be dynamically
allocated early during boot (i.e. the memory region is defined with
the "alloc-ranges" property instead of the "reg" property).

If the location of the ramoops region is not fixed via the "reg"
devicetree property, the call to platform_get_resource() will fail
because resources of type IORESOURCE_MEM must be described with the
"reg" property.

Since ramoops regions are part of the reserved-memory devicetree
node, they exist in the reserved_mem array. This means that the
of_reserved_mem_lookup() function can be used to retrieve the
reserved_mem structure for the ramoops region, and that structure
contains the base and size of the region, even if it has been
dynamically allocated.

Thus invoke of_reserved_mem_lookup() in case the call to
platform_get_resource() fails in order to support dynamically
allocated ramoops memory regions.

Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
---
 fs/pstore/ram.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index ade66dbe5f39..e4bbba187011 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -20,6 +20,7 @@
 #include <linux/compiler.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_reserved_mem.h>
 
 #include "internal.h"
 #include "ram_internal.h"
@@ -643,6 +644,7 @@ static int ramoops_parse_dt(struct platform_device *pdev,
 {
 	struct device_node *of_node = pdev->dev.of_node;
 	struct device_node *parent_node;
+	struct reserved_mem *rmem;
 	struct resource *res;
 	u32 value;
 	int ret;
@@ -651,13 +653,20 @@ static int ramoops_parse_dt(struct platform_device *pdev,
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
-		dev_err(&pdev->dev,
-			"failed to locate DT /reserved-memory resource\n");
-		return -EINVAL;
+		rmem = of_reserved_mem_lookup(of_node);
+		if (rmem) {
+			pdata->mem_size = rmem->size;
+			pdata->mem_address = rmem->base;
+		} else {
+			dev_err(&pdev->dev,
+				"failed to locate DT /reserved-memory resource\n");
+			return -EINVAL;
+		}
+	} else {
+		pdata->mem_size = resource_size(res);
+		pdata->mem_address = res->start;
 	}
 
-	pdata->mem_size = resource_size(res);
-	pdata->mem_address = res->start;
 	/*
 	 * Setting "unbuffered" is deprecated and will be ignored if
 	 * "mem_type" is also specified.
-- 
2.41.0.178.g377b9f9a00-goog

