Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D79611C4B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 23:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiJ1VPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 17:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiJ1VO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 17:14:59 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDB71E3C3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 14:14:58 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 20so5879220pgc.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 14:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f26SHUDCKkAMIj7hIK8sG1Pls1nziet6vydLGNnOxd0=;
        b=dnA/a83rQeSZKqvN0pDy35114DLlbheKhA+37bGgVqAQUo/ykSu5Dq90/g3KNXN3SA
         qUf7BV73LW1eznwf0UQAlYOhfp//Utzl95cSmthb0sq/HG4YonuX1S4YCSmzrn4Par2v
         EVCCwvkjD24A6toOel1z6pvMXJvqQCpaumndY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f26SHUDCKkAMIj7hIK8sG1Pls1nziet6vydLGNnOxd0=;
        b=IOkY/UU3aY0TTjh40K4LUrKXlfTwaS77khvFIJYRD4rZqM+YyoqVrVkruHprwUS1l7
         SF8u7W0BykeAysiNbHKl6mJCG7oYosbv7/ZOwU5INvN9T2iLsFLx8ePwjLqaoZHT4zpN
         ksXGoKC59mQpUjjqQ4p9PFepHMi8b//Txub0MhJzypkzoO6p1Rpl/Bx5DXzhV6X/YQ3q
         +5LFwshnXBstr596tA9sxhivLaVD2v922LFe66PDfJFqOZifjL6iVVyNmtqfpa8PyvGn
         NuMuUdSunSckW2onixJ2BfLWCiVUZb5CPe4PXzGPGODZ9N89bzCytTRcH4/D2RsY/N9B
         Jalw==
X-Gm-Message-State: ACrzQf1mzf858+kZeYDCoGcIpEjczvGI4sAUMD4NaK5VgfJ7J4Zsa8B8
        4ZXcxmU7YUDk/j9DgbpEy5Zep603L1nSnA==
X-Google-Smtp-Source: AMsMyM6zCYGK2VO/1jnIMbAxM6UrX9tbv4zJkSlVOMF9+ietep+0xrHrZNHpu8x7NqXFmgBwtWFoEw==
X-Received: by 2002:a63:2b53:0:b0:439:34d9:5d47 with SMTP id r80-20020a632b53000000b0043934d95d47mr1252271pgr.283.1666991697681;
        Fri, 28 Oct 2022 14:14:57 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:65f9:c180:249c:190f])
        by smtp.gmail.com with UTF8SMTPSA id m2-20020a170902db0200b001868ba9a867sm3498561plx.303.2022.10.28.14.14.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 14:14:57 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 3/5] platform/chrome: cros_ec_debugfs: Set PROBE_PREFER_ASYNCHRONOUS
Date:   Fri, 28 Oct 2022 14:14:47 -0700
Message-Id: <20221028141411.3.Ic9a4f378f73319da323cd55940012fa6b1de24f4@changeid>
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

This driver takes on the order of 40ms to start on some systems. It
shouldn't have many cross-device dependencies to race with, nor racy
access to shared state with other drivers, so this should be a
relatively low risk change.

This driver was pinpointed as part of a survey of top slowest initcalls
(i.e., are built in, and probing synchronously) on a lab of ChromeOS
systems.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

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

