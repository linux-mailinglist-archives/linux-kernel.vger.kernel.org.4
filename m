Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59EFF6154E5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiKAWXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbiKAWW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:22:56 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856B81A805
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 15:22:55 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id p21so11003866plr.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 15:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ra1DxUtw8duk3xgpznu2G+LVRe7hBZGi32jB2ilzSnQ=;
        b=iXQLCb7yS8xX4ME+5QdaSAHIGdXvLXPpDImW60Izftv/1EOP8FQUyGdvJSgy2CrcVA
         NDeh8roIFXnclEFuowwIJL6z1Gm7axBhj/DrnaQS+bUhWW+FUPndhk14geAqc9m4g0JE
         Eh2OQwEOKTVGH6lTQBJJFQFexxmdmHHHIgyi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ra1DxUtw8duk3xgpznu2G+LVRe7hBZGi32jB2ilzSnQ=;
        b=g1s4tQIBTmS3CzhBRE83FkGAnhyk17p3f/7V6+sPm4fLLW9fmHh0J7YGJocb0H3/3A
         ZPwORF9LXwlBG09U4YM7Q8BX6LWCyg2KE8K/cw1Ip1BzrI4nwY3r1XtkgnOutI1WyGAD
         mYPcjyFJ30eC5a8sH6FhlgzfANuxilbgvLaS6zCkDRo+rNf6w1gzyRKtboGWQG5Q8HMI
         vYF8ucnG/wlH/3TCF34zcI3vexCf4JYr+uIIbEiB9EjCV0afeOjJEe8AaNc+6/08qsgj
         aNMtUO61E9e03KheUBDqcTdeDRFp2txixWydGTyQWvaypRWuKJrPbTy/qr/+obyua85p
         i1xQ==
X-Gm-Message-State: ACrzQf0/i/gX9NqxpdyIOufN9KAIzTCWSDCxTVJg6vGS1fRvWdgbC46m
        OjREU+OcOzhmAsEhtLNeeQ1rNQ==
X-Google-Smtp-Source: AMsMyM7VzAAGq+6n5lYLKgnuYhLF2BBv6ZAjScDJ2lK/wn09iPkr186t67e0nbahn6C04vm8x20w0Q==
X-Received: by 2002:a17:902:ed8e:b0:187:27b3:74e5 with SMTP id e14-20020a170902ed8e00b0018727b374e5mr10525835plj.90.1667341375079;
        Tue, 01 Nov 2022 15:22:55 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:9c5f:7c8e:b8a2:3495])
        by smtp.gmail.com with UTF8SMTPSA id y22-20020aa79af6000000b0056be1581126sm7261255pfp.143.2022.11.01.15.22.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 15:22:54 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 4/5] platform/chrome: cros_ec_lightbar: Set PROBE_PREFER_ASYNCHRONOUS
Date:   Tue,  1 Nov 2022 15:22:09 -0700
Message-Id: <20221101152132.v2.4.I565598102e0bfb03bdf8c090d3bfdf954d026bc5@changeid>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
In-Reply-To: <20221101152132.v2.1.I0728421299079b104710c202d5d7095b2674fd8c@changeid>
References: <20221101152132.v2.1.I0728421299079b104710c202d5d7095b2674fd8c@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

(no changes since v1)

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

