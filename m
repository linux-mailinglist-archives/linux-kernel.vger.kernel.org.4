Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D81F67CC05
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 14:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236764AbjAZN0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 08:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236740AbjAZN01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:26:27 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1DB3A9C
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 05:26:24 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id q5so1808108wrv.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 05:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fn4tvNjsH5gVRykTKfXGnLpudCIBWpRMrX6rY6I14Hk=;
        b=puxiwPzgodNGKieKAN0SMyNYUGS1OeGngmB0PP6Y2OjVqqkmj3KGt+YBHaHBvh0C8r
         yrKTFXU2rnHIYxFJT1K6PMRreBQ0PDHFH9oM1IJ3+LMTxvuboNUIRhxW3Ienfcub65PA
         808tg3IUA2TBcSFkwx4yDAej2IzfV66lAdkklEmx2ERDl23RYHLRTrAVnY/KsxnDk+XW
         zkUGLcjYYvHajrkzC8XfXVDJJmP9fao4gAqWzTv8j7I6WX5tggc6zs57JjChwI7OwLfI
         OJ3S1QbfOVDZn+o7qaY0Y/Ju/J5qAvORFZtGYatyiu7Vy2b8LPc2aOePcAa2msdjNIXY
         UK0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fn4tvNjsH5gVRykTKfXGnLpudCIBWpRMrX6rY6I14Hk=;
        b=JbUMIMBle8e76I3hd/fR0iGto8fPlGAUhznMACLR4290m7Jh6aEK4Es6n8f1BNKhJi
         pdmDiqv6ooSECu8v0LUUCUduhwLt6ufqffWYf73coIfTeUtB7cvy6IMpY63cJwI51qzM
         82IjiWT2nF8bMkInkoNenWSTWpXQxFj5OdHqRnlLlWsmFlh0HDycb+T9BDjjtnGjsnHc
         jz4y5da0uRdRWv46dlliecyy42UWsF2sE8IiM5k5bAHRV/q/MTYi+mbpZpIrZLfnfRhA
         +fLPUP3cnF5pe2e12mMn+q6GnXHbPAySj0NKUCZJL6snXAye85bahwE4LpwHzZ3L4FmF
         hnTQ==
X-Gm-Message-State: AFqh2krKq0/XF0cm/h62YlNfsFwrE1Kau04DpaHEs1D8RTSSGyXp2ZVi
        bWgPb1Rojm97O/LlYIKUH3TfyQ==
X-Google-Smtp-Source: AMrXdXsi7X+m/gSTnbURH3bafi2Xz82h2tt8zAyrAztWpjVfrR+v2h5SzTteZhpPoSUNUaN9nsSFEw==
X-Received: by 2002:a05:6000:98d:b0:25f:8ead:96cc with SMTP id by13-20020a056000098d00b0025f8ead96ccmr35145658wrb.70.1674739583099;
        Thu, 26 Jan 2023 05:26:23 -0800 (PST)
Received: from orzel1.c.googlers.com.com (44.232.78.34.bc.googleusercontent.com. [34.78.232.44])
        by smtp.gmail.com with ESMTPSA id p2-20020a5d4582000000b002b6bcc0b64dsm1326108wrq.4.2023.01.26.05.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 05:26:22 -0800 (PST)
From:   =?UTF-8?q?Kornel=20Dul=C4=99ba?= <mindal@semihalf.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
        Intel Corporation <linuxwwan@intel.com>,
        Chiranjeevi Rapolu <chiranjeevi.rapolu@linux.intel.com>,
        Liu Haijun <haijun.liu@mediatek.com>,
        M Chetan Kumar <m.chetan.kumar@linux.intel.com>,
        Ricardo Martinez <ricardo.martinez@linux.intel.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, rad@semihalf.com,
        mw@semihalf.com, upstream@semihalf.com,
        =?UTF-8?q?Kornel=20Dul=C4=99ba?= <mindal@semihalf.com>
Subject: [PATCH 2/2] net: wwan: t7xx: Fix Runtime PM initialization
Date:   Thu, 26 Jan 2023 13:25:35 +0000
Message-Id: <20230126132535.80339-3-mindal@semihalf.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
In-Reply-To: <20230126132535.80339-1-mindal@semihalf.com>
References: <20230126132535.80339-1-mindal@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For PCI devices the Runtime PM refcount is incremented twice:
1. During device enumeration with a call to pm_runtime_forbid.
2. Just before a driver probe logic is called.
Because of that in order to enable Runtime PM on a given device
we have to call both pm_runtime_allow and pm_runtime_put_noidle,
once it's ready to be runtime suspended.
The former was missing causing the pm refcount to never reach 0.

Fixes: d10b3a695ba0 ("net: wwan: t7xx: Runtime PM")
Signed-off-by: Kornel Dulęba <mindal@semihalf.com>
---
 drivers/net/wwan/t7xx/t7xx_pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7xx_pci.c
index 871f2a27a398..226fc1703e90 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.c
+++ b/drivers/net/wwan/t7xx/t7xx_pci.c
@@ -121,6 +121,8 @@ void t7xx_pci_pm_init_late(struct t7xx_pci_dev *t7xx_dev)
 	iowrite32(T7XX_L1_BIT(0), IREG_BASE(t7xx_dev) + ENABLE_ASPM_LOWPWR);
 	atomic_set(&t7xx_dev->md_pm_state, MTK_PM_RESUMED);
 
+	pm_runtime_mark_last_busy(&t7xx_dev->pdev->dev);
+	pm_runtime_allow(&t7xx_dev->pdev->dev);
 	pm_runtime_put_noidle(&t7xx_dev->pdev->dev);
 }
 
-- 
2.39.1.456.gfc5497dd1b-goog

