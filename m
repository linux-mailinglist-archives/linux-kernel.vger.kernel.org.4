Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9C06C1566
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 15:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjCTOqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 10:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbjCTOp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:45:56 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F32EB73;
        Mon, 20 Mar 2023 07:45:11 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id o11so12681606ple.1;
        Mon, 20 Mar 2023 07:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679323511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HW0myZZejO7uNMRvPlac+lbEnpvRrjfPGVZeXhkTeDU=;
        b=PhP6+MY2gm+VfsWU6J4UMRMOHIYbVs8+vizsPZv168wBOIB9PALpYVfd6ZivPoEngY
         t/VUJFnA/t4Ix6GsI7xwhIXMkAYpKhhRp3xvngTue6Yr2fFXbtmHtWpAQB/s+naJOTYw
         IRTZeCf/1OLyWnQopg4LLMR+VeOJW0SWboQWMJmtAUiYKPEyPfrp5RIa7I8htQgDrv7u
         Id7p9NjiUuVcsJhDDDBEShANjbF6FYb4DklqnEW405YxDUdx+2496YftV81PkBEMAJVb
         1iddGsKJ7Zt798qVPBcNgXNRq0rx7b3ZiQPIaKcFfUSv7FPK9Xd9DR2vPRCvRDOQgqRi
         4D2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679323511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HW0myZZejO7uNMRvPlac+lbEnpvRrjfPGVZeXhkTeDU=;
        b=i3CyqmY8vAPd+7VRJnahofMHzed8s099n1auEgtIfB4Uyk6R8naGFiG9YxGv8bUV8d
         EWZuE9kiZafCyNQQEbV/LsrnTmayd/Iy7P4pcYlKDkTUvpGOUzUJM/05uQhTNdCtsOOC
         TQ8GGnGW7o8vFhCLeQGV6lqnG3GYwIpSMyXxyex1Y5y9/q4vIHzLfr11FJ1LBEdLD13D
         ORoSwwwhNeK9puSXWADn06E5tnyoHSK5sl7AlULPQP/6cB8PQYyi5fwqK3amIFtPrUDW
         2pmlYgosfbBmRMEpf79NZBikEObeXjkEkFJKSHa1Z/fuY+3JFg5g/d53rnMk24fIKQds
         d3Qw==
X-Gm-Message-State: AO0yUKUs0PIKSDjE9NPz5e98vFbcgisCeSdjKyh/uGaamXgNb147/Nvm
        91t4hty+BQqEVOoa1bDV7ZM=
X-Google-Smtp-Source: AK7set8dqJQ+HWWTlRCoB9bVOq+YmX/QlpDsIah5XuQdk5bfZ+gnkND2WAlzEoISE8F1IrVQp/Nnmw==
X-Received: by 2002:a05:6a20:be09:b0:d6:9e5e:f240 with SMTP id ge9-20020a056a20be0900b000d69e5ef240mr13319951pzb.4.1679323511174;
        Mon, 20 Mar 2023 07:45:11 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id u15-20020a62ed0f000000b005809d382016sm6433907pfh.74.2023.03.20.07.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 07:45:10 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend,
        aka swsusp)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 19/23] PM / QoS: Teach lockdep about dev_pm_qos_mtx locking order
Date:   Mon, 20 Mar 2023 07:43:41 -0700
Message-Id: <20230320144356.803762-20-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230320144356.803762-1-robdclark@gmail.com>
References: <20230320144356.803762-1-robdclark@gmail.com>
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

Annotate dev_pm_qos_mtx to teach lockdep to scream about allocations
that could trigger reclaim under dev_pm_qos_mtx.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/base/power/qos.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
index 9cba334b3729..d4addda3944a 100644
--- a/drivers/base/power/qos.c
+++ b/drivers/base/power/qos.c
@@ -1012,3 +1012,14 @@ void dev_pm_qos_hide_latency_tolerance(struct device *dev)
 	pm_runtime_put(dev);
 }
 EXPORT_SYMBOL_GPL(dev_pm_qos_hide_latency_tolerance);
+
+static int __init dev_pm_qos_init(void)
+{
+	/* Teach lockdep about lock ordering wrt. shrinker: */
+	fs_reclaim_acquire(GFP_KERNEL);
+	might_lock(&dev_pm_qos_mtx);
+	fs_reclaim_release(GFP_KERNEL);
+
+	return 0;
+}
+early_initcall(dev_pm_qos_init);
-- 
2.39.2

