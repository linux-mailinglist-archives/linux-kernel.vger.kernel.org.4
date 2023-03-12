Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFC06B6B5E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 21:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjCLUnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 16:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbjCLUnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 16:43:13 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876DB3B87D;
        Sun, 12 Mar 2023 13:42:46 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so177708pjz.1;
        Sun, 12 Mar 2023 13:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678653766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HW0myZZejO7uNMRvPlac+lbEnpvRrjfPGVZeXhkTeDU=;
        b=OcKKy6gVGc8H4VoVwynfn9rLrmB49TMArwvdNaLd0OLRizVZmNpM/2AJ8YkHz4zJoq
         wKJFyuNS3Av4vAwobgw/ePwL42Ik2sdz6JcwsCi+SJYlKrOvYxkWaWWk9xnZBDHEH9B7
         +p56vX3oKPUNiRm0OcsnoJJ05CMcFdIwTpY+S9u0NJxeBz57F/mwzvauoXj8fvl0hmqN
         xSqhTz3Pk+ArgvEdVetcUGjV3K3eVsv7stiatC53RduzetDd6uik24+yV3dgWApu4M5Y
         EiHcBej9o6nb/mOF7R8r/TTBpBANCDpLOlevqjbGfycwC+d6cGEyNbEHP4VTWoGJEYIi
         XJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678653766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HW0myZZejO7uNMRvPlac+lbEnpvRrjfPGVZeXhkTeDU=;
        b=oeWagAWa3XULsJG3FEi3bLV6WIdiJbRhcTxF2yhsSNjJXSuBLYsFR+ESY7KFs5N3fq
         pNkw+pNl9WL22oXmwDtpu9FpKqn/OHbl3QRxnV9zn44WTFqG4MBcK/CFRVg+XZkIOR5w
         gfTlr/Kz//h/XJ8dq1t0CHWpnZQMLVEyC+ZWEeqC/sBh8COlzTcG20T8FSmMlb+ODTRG
         FINCRA0ityJMyC9eweHP/a4OYnES5v6DacBKYnotqrLG+pfhxymyE8Efv4sbJCyqf02y
         N8yoYddNq4jITSni82UsyDWcEQMPAkZ7B7Kl7JsGCVPFUFUyRFd1DMLV3gAgGcGETVCH
         IN7Q==
X-Gm-Message-State: AO0yUKVh0o3s0ILdOu13SvyH3M2Oxi+Qc7dtYh+5pKSCjlQhdQChHqjx
        UohB9VIgTHfY8LPtb99ElVc=
X-Google-Smtp-Source: AK7set+sD263BqssJAZPFv92dbfz/7mD09CQaAZCBC16ymLx6FwS65EELyTh63Y7NjozxBRelVggiw==
X-Received: by 2002:a05:6a20:b71d:b0:cd:929d:27ea with SMTP id fg29-20020a056a20b71d00b000cd929d27eamr25973342pzb.52.1678653766045;
        Sun, 12 Mar 2023 13:42:46 -0700 (PDT)
Received: from localhost ([2601:1c0:5080:d9fa:9b45:95de:f47d:f85e])
        by smtp.gmail.com with ESMTPSA id h5-20020a62b405000000b005a817f72c21sm3058416pfn.131.2023.03.12.13.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 13:42:45 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org (open list:SUSPEND TO RAM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 10/13] PM / QoS: Teach lockdep about dev_pm_qos_mtx locking order
Date:   Sun, 12 Mar 2023 13:41:38 -0700
Message-Id: <20230312204150.1353517-11-robdclark@gmail.com>
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

