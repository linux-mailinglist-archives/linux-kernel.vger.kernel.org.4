Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6965C6A0271
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 06:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjBWFlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 00:41:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbjBWFls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 00:41:48 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149F6497CF
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 21:41:47 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id il18-20020a17090b165200b0023127b2d602so10888509pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 21:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wistron-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FEXPPCK8RfqWIy61SdJSATTm4fO5IDc6+VUaQzEmh4E=;
        b=Iaoybi9FTzh6C/4Q1uAlBnnpbXHAaChef57PMz+L5CNynKlpOVTV1yvWjcgHGLqLdO
         GsdRImZTtGpvoveMc5Q+0hD0MiBMi9/qPjfLkxgGrd9VbQ3ZWkO7LABV3eH+H5wr8Mx2
         xI/dc+0n5Ev0Varn6blZ48V6CSDbiYz+iP+A30M/BwpIwfHkHtJLeItKxus6j9hLd8DX
         mkIFrnsXKUcO7ybl5xvaqzT21jnAvqjKMQHmH1lMkRKM0EioeKEtN1BpWicIw0vz6+oz
         ujFisqnfE9cIiCg5swTO1vOnkrV9rW8RaDgpNhL+e972+kSkdQFk9GOuyYlL4+Gl0HTh
         8KrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FEXPPCK8RfqWIy61SdJSATTm4fO5IDc6+VUaQzEmh4E=;
        b=g0sa8DMHS4/uPVD/FCPcMPBx/Vvt39lfqS7EeW4wRgs6ElB3ptzNdb1VQO7Nn0HWTE
         gz0gk0OxSnUHz5YT7BJ9MCh1J7MtsCrTZSFrkU6oETl3q61dDyKlZRdSLOGzZJpDK94P
         pcIOnHtlXe/jkTgDLMs1UfFRMRK6KPpyk6y48VGzKt0eiwNlDb1s+FHUyF3+ImB+nU+S
         42wX+4hos7/ope2P2+w7AbPSrGSamLbVgHMdF/jrKP/VXkH6089dbjbmAjCv8+G3mauz
         nhYHK4zjtVSa0oES/DjEuu0tdwX5vaO/O4DNBkYVKbgfjSDGwMXshXBcmq4zvvSGyv3M
         sN9Q==
X-Gm-Message-State: AO0yUKU/blXfx6yb2gsa3BOKzm9llNl71bHm17zc3VTNbBCucT3rRRhU
        sD7c1OduOaAjPvuqIw7hlzZRTw==
X-Google-Smtp-Source: AK7set9EfGInk0g9nPYWg1g2YklQ06/aSqmHefF8nH7RZ19edO7NzOiLMGFwQuZ5jFmjjxfAJx84rw==
X-Received: by 2002:a17:902:e1cc:b0:19c:9420:6236 with SMTP id t12-20020a170902e1cc00b0019c94206236mr6420380pla.22.1677130906465;
        Wed, 22 Feb 2023 21:41:46 -0800 (PST)
Received: from localhost.localdomain ([2401:e180:8812:cac3:129e:5c16:92e6:e867])
        by smtp.gmail.com with ESMTPSA id g12-20020a170902c38c00b0019c90f8c831sm4455256plg.242.2023.02.22.21.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 21:41:46 -0800 (PST)
From:   Zoey Wu <zoey_wu@wistron.corp-partner.google.com>
To:     hverkuil-cisco@xs4all.nl
Cc:     mchehab@kernel.org, bleung@chromium.org, groeck@chromium.org,
        scott_chao@wistron.corp-partner.google.com,
        ajye_huang@compal.corp-partner.google.com,
        zoey_wu@wistron.corp-partner.google.com,
        hellojacky0226@hotmail.com, linux-media@vger.kernel.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] media: platform: cros-ec: Add aurash to the match table
Date:   Thu, 23 Feb 2023 13:41:38 +0800
Message-Id: <20230223054138.267849-1-zoey_wu@wistron.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Google aurash device uses the same approach as the Google Brask
which enables the HDMI CEC via the cros-ec-cec driver.

Signed-off-by: Zoey Wu <zoey_wu@wistron.corp-partner.google.com>
---
 drivers/media/cec/platform/cros-ec/cros-ec-cec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
index 6ebedc71d67d..e7cb9509e967 100644
--- a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
+++ b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
@@ -225,6 +225,8 @@ static const struct cec_dmi_match cec_dmi_match_table[] = {
 	{ "Google", "Kinox", "0000:00:02.0", "Port B" },
 	/* Google Kuldax */
 	{ "Google", "Kuldax", "0000:00:02.0", "Port B" },
+	/* Google Aurash */
+	{ "Google", "Aurash", "0000:00:02.0", "Port B" },
 };
 
 static struct device *cros_ec_cec_find_hdmi_dev(struct device *dev,
-- 
2.25.1

