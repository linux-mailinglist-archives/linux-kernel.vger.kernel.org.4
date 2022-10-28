Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0722611C4E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 23:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiJ1VPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 17:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiJ1VPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 17:15:03 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92813FEC6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 14:15:01 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id s196so5882130pgs.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 14:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kCN7I+EqjmDeqN4ZcXaijeJfrEMHUPCGCQAvUPZS81M=;
        b=MRFIWNNIgKHBvh4unQXvkUv/KnK3shaSHRyNpOREhOzFu8iGl+9o5tQiSQV4eDXNOM
         uaH8au+EGSgrOD9dvOLB1t/fra8RMeTVP8KcZgWLqIY6XBnXZky8nl+td/g4Yi3osJ4v
         SxOLmmOQIFljRPJ9HF6N0fH5sqhc4YdW8B48s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kCN7I+EqjmDeqN4ZcXaijeJfrEMHUPCGCQAvUPZS81M=;
        b=2Sgr4qNROKvbW4wqxtHfHzYv6TRP3aY0jCu9tu0aC424NimBp/UcUb7gNo/M6xQ7XD
         SiR8RsU2ZW4SaaS/k0BaIBQIgOT1klVsAqyKBN2jYTpK+udgjW37LzY1P/qllryeSSM0
         SZvzWTDkDydxMbk+Tx9KS7uQsuKBL/AtxT2CXxJm8/dHizfNZI6pWfjgDCsYbKQd0JKJ
         1oLJDkDzSu3gykMOS4WTv1rsyEZKtqD3u1z3VezSgioR8ROsIqckteSxC4Fq9X/2FWQ7
         UX/WFP0jeoBZ1uHmwJXjKiIy1hKnCLgih8hz8iGG4wTdBGyCCD0a14oHqpcAaKi7MAsM
         j24g==
X-Gm-Message-State: ACrzQf1NMwc+OpfRMltMaG6CCRcu4Y3dHDxplvgrUyGcwWlUjI62jb72
        XKuTy0zz36t2NFprd4a3XVYXBg==
X-Google-Smtp-Source: AMsMyM7MS/OMYYDUX0lkL1LaQGX3qWIrIMDAcIQKUccoDumeeijHos49DBizdRWuNJAhXdV0+TDFsA==
X-Received: by 2002:aa7:838a:0:b0:536:101a:9ccf with SMTP id u10-20020aa7838a000000b00536101a9ccfmr1065977pfm.18.1666991701429;
        Fri, 28 Oct 2022 14:15:01 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:65f9:c180:249c:190f])
        by smtp.gmail.com with UTF8SMTPSA id b15-20020a170902650f00b00186c54188b4sm3442174plk.240.2022.10.28.14.15.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 14:15:01 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 5/5] platform/chrome: cros_ec_spi: Set PROBE_PREFER_ASYNCHRONOUS
Date:   Fri, 28 Oct 2022 14:14:49 -0700
Message-Id: <20221028141411.5.Ia458a69e1d592bfa4f04cde7018bbc7486f91a23@changeid>
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

This driver often takes on the order of 10ms to start, but in some cases
as much as 600ms [1]. It shouldn't have many cross-device dependencies
to race with, nor racy access to shared state with other drivers, so
this should be a relatively low risk change.

This driver was pinpointed as part of a survey of top slowest initcalls
(i.e., are built in, and probing synchronously) on a lab of ChromeOS
systems.

[1] 600ms was especially surprising to me, so I checked a little deeper.
This driver is used to interface with Embedded Controllers besides just
the traditional laptop power-state controller -- it also interfaces with
some fingerprint readers, which may start up in parallel with the
kernel, or which may not even be present on some SKUs, despite having a
node for it. Thus, our time is wasted just timing out talking to it. At
least we can do that without blocking everyone else.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/platform/chrome/cros_ec_spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
index 7360b3ff6e4f..21143dba8970 100644
--- a/drivers/platform/chrome/cros_ec_spi.c
+++ b/drivers/platform/chrome/cros_ec_spi.c
@@ -834,6 +834,7 @@ static struct spi_driver cros_ec_driver_spi = {
 		.name	= "cros-ec-spi",
 		.of_match_table = cros_ec_spi_of_match,
 		.pm	= &cros_ec_spi_pm_ops,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe		= cros_ec_spi_probe,
 	.remove		= cros_ec_spi_remove,
-- 
2.38.1.273.g43a17bfeac-goog

