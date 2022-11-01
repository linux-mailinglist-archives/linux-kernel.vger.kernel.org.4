Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472766154E4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiKAWXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbiKAWWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:22:54 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD41D1A21B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 15:22:53 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id g62so14734980pfb.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 15:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ekHYZpDEhYvmgLl9ibVW1UrC0RjLNjOHWSwbS/YHNwk=;
        b=We4cGsIeIdDqNRSLbBZwM8NCXtOgrImcozpOe19X4k4kUy2sMr99BV6XbE2pW0sAnN
         XDqAKM5zWARWYRjot6ekw2J13Css968k2n72VBsT23O+oQGiaBdFn+yG/C1JJkM0dtF4
         2RpMAYHLAqXHBI4BoJj+r4j9S9uCRZPfADNkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ekHYZpDEhYvmgLl9ibVW1UrC0RjLNjOHWSwbS/YHNwk=;
        b=WIHY+V5mxX5xj3IYmHuiTo7kfj+1s63YUbswlzMoCuQKzrt6gpIQ5v7PIsEfRAuwtf
         FM0a82TP3IV/ZXuTOg+bPtpk+hGvjVstRDCJ9BjltJKGw+7Fn99s/5fHNqz+Ri+bjLCi
         /u1yGIvBMBkj931DnSV7xYKJay8FhLgG+JojtXzpKXMilGhT6diKRdjAKF7QfZyTXbfa
         zxzmDCMQzR3DBzb4kdmzpgIaq6h1TfqGaHizpR3P191RFO96bjANI9wIyptRMS2EqJJj
         RmU5R/fVsZx2tgrbRfwDg6AhJqdEMr2Mo5i4SCakWAPE6qDMsTa+CV4lAAegckBgufne
         xdBg==
X-Gm-Message-State: ACrzQf32nvxZWcxPx3IysTRnhi2CkbdgJN2NY3w79K9//8mU7ZE2tnML
        URcMOsdS/kwIeuNyiFWaqgngyUIMBhG4Wg==
X-Google-Smtp-Source: AMsMyM6Z/kapNZXYi+y4YDi0ULoqmJ35hoYlfVuPSko31JNn1avbNlegyM4Sun4haQP8GrG47MPTeg==
X-Received: by 2002:a63:2b10:0:b0:451:5df1:4b17 with SMTP id r16-20020a632b10000000b004515df14b17mr18480543pgr.61.1667341373216;
        Tue, 01 Nov 2022 15:22:53 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:9c5f:7c8e:b8a2:3495])
        by smtp.gmail.com with UTF8SMTPSA id 9-20020a631749000000b0046f1e8cb30dsm6300322pgx.26.2022.11.01.15.22.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 15:22:52 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 3/5] platform/chrome: cros_ec_debugfs: Set PROBE_PREFER_ASYNCHRONOUS
Date:   Tue,  1 Nov 2022 15:22:08 -0700
Message-Id: <20221101152132.v2.3.Ic9a4f378f73319da323cd55940012fa6b1de24f4@changeid>
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

This driver takes on the order of 40ms to start on some systems. It
shouldn't have many cross-device dependencies to race with, nor racy
access to shared state with other drivers, so this should be a
relatively low risk change.

This driver was pinpointed as part of a survey of top slowest initcalls
(i.e., are built in, and probing synchronously) on a lab of ChromeOS
systems.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

(no changes since v1)

 drivers/platform/chrome/cros_ec_debugfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
index 4e63adf083ea..21d973fc6be2 100644
--- a/drivers/platform/chrome/cros_ec_debugfs.c
+++ b/drivers/platform/chrome/cros_ec_debugfs.c
@@ -521,6 +521,7 @@ static struct platform_driver cros_ec_debugfs_driver = {
 	.driver = {
 		.name = DRV_NAME,
 		.pm = &cros_ec_debugfs_pm_ops,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = cros_ec_debugfs_probe,
 	.remove = cros_ec_debugfs_remove,
-- 
2.38.1.273.g43a17bfeac-goog

