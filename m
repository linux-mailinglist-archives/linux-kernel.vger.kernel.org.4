Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2D7611C4D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 23:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiJ1VPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 17:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiJ1VPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 17:15:00 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A4313F22
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 14:14:59 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id g62so5787012pfb.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 14:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPP9pF7fIvV/nLcvOx6oDjBVViuf9MAG5n+X6Tj0h3Y=;
        b=ZW9XW/GfmujrJzDszG++/tJuCMwJBY7sSL2UrozY9KqH2Q0vlWzgUTXD7vpYtObRm/
         61xOuFMG+ZzrULCo/W9z8JasQoFrm6Dg6gHxExJyQU1D1f4QjBpE7oLrC23Jqd63ycbX
         obYJUiuItCe8/7dqWy6i77dDUD6hvr7XAIWsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZPP9pF7fIvV/nLcvOx6oDjBVViuf9MAG5n+X6Tj0h3Y=;
        b=YPEHVvdYGe/Z0i+QPmsIYp9thfrOQXkImjVIiYCDfqVl12TxkwkTcDW7+pIMWu9SJg
         PYSYylEf8o4QukVP4MLbHQaVdbGOS7o6f4aZQ7ERTfkGqP+EcajKnkr920ZHCFUWvKaL
         y8osxWLCuzIu0z0L6GMmGX08ngdaHMo5YAE1L2Nxiuqqt5hb6gbQ/2/TLPUyd2m9Vz0b
         ESnIbxW/Gse7ZpuA7klhUAo4KcyrnqLm/vZ5EeE4GzEu0APuk8Yte7Rpp2K9bUdrsdtm
         nf89Xzz2LJWxsVr6/wsV/uSa6tA5GyUxTb03GLfKMKZgngpwg1RYLD93o+LI68hV+D9+
         Xj7g==
X-Gm-Message-State: ACrzQf2xjOI2KZyty2KB0nLT2PjIUYsOPAiXqG86yRFn8WGeHjEpyu/3
        auzSRzU4BcHi8syagT+X4DsIHg==
X-Google-Smtp-Source: AMsMyM6ePtsEr6bhRuJOE0O5l6NLMbLUbjQQgLCds/0zyy2pDwvRkeYSpVxPsE++pdwZHk+dQWXyEQ==
X-Received: by 2002:a05:6a00:1749:b0:563:8346:12e9 with SMTP id j9-20020a056a00174900b00563834612e9mr1125101pfc.68.1666991699582;
        Fri, 28 Oct 2022 14:14:59 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:65f9:c180:249c:190f])
        by smtp.gmail.com with UTF8SMTPSA id jc19-20020a17090325d300b00186ae20e8dcsm3415829plb.271.2022.10.28.14.14.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 14:14:59 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 4/5] platform/chrome: cros_ec_lightbar: Set PROBE_PREFER_ASYNCHRONOUS
Date:   Fri, 28 Oct 2022 14:14:48 -0700
Message-Id: <20221028141411.4.I565598102e0bfb03bdf8c090d3bfdf954d026bc5@changeid>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
In-Reply-To: <20221028141411.1.I0728421299079b104710c202d5d7095b2674fd8c@changeid>
References: <20221028141411.1.I0728421299079b104710c202d5d7095b2674fd8c@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver takes on the order of 15ms to start on some systems. Even on
systems where there is no lightbar support, it can take a few
milliseconds just to probe the EC for support. It shouldn't have many
cross-device dependencies to race with, nor racy access to shared state
with other drivers, so this should be a relatively low risk change.

This driver was pinpointed as part of a survey of top slowest initcalls
(i.e., are built in, and probing synchronously) on a lab of ChromeOS
systems.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/platform/chrome/cros_ec_lightbar.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/chrome/cros_ec_lightbar.c b/drivers/platform/chrome/cros_ec_lightbar.c
index 469dfc7a4a03..ff4d619cf924 100644
--- a/drivers/platform/chrome/cros_ec_lightbar.c
+++ b/drivers/platform/chrome/cros_ec_lightbar.c
@@ -601,6 +601,7 @@ static struct platform_driver cros_ec_lightbar_driver = {
 	.driver = {
 		.name = DRV_NAME,
 		.pm = &cros_ec_lightbar_pm_ops,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = cros_ec_lightbar_probe,
 	.remove = cros_ec_lightbar_remove,
-- 
2.38.1.273.g43a17bfeac-goog

