Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E0D611C4C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 23:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiJ1VPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 17:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiJ1VO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 17:14:58 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C7626106
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 14:14:56 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id g62so5786903pfb.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 14:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ujrrf0uboQfvYL+QX/6R/v6yRcsPGzo+vWDkIBpQC3U=;
        b=hAMboiNXGwzfogwxNxk25ISfrCRUAyN7N3a6mSeDYroLEWBaazVzLEC+zF5fvgia4K
         F6xKEvTkHf3OzZ/LX7vRLmZOMCPETGhoptAdqfilrdBTeqytGpy25zvj2XOaBvJB6tNq
         zLwTDQjHsulpSbhRPP7Qx9mrR80jZr3sO4Tzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ujrrf0uboQfvYL+QX/6R/v6yRcsPGzo+vWDkIBpQC3U=;
        b=Kqm1cf7xxS+x+Dkd5CbSxFpLDOeS0VFl0H3H+s9Sodf0gHGY8pdMous6GoSSU8fOiV
         KoiSyhHgVz6cnG84+d9cB5H6u7w4TQwhHlutw0UFJKsMOxgFPeV6ew2j3DJVmZhL5NwT
         iFP4u0G7Hp4sWfWxpOyJDKSbXJtTihLo1+UjSy4PoP3HXX6nRMtYJGVpt20kd3sTfp0u
         nvMgmqkPMMRIp0dEYzrLu1efZFyFJl7tZqDEXlFkXwKzpDojfw7xSnfVQY3bq1guG2VI
         dl5yiQn3niRM+Arrvr3jn8iAoNeaon6HOJbWu131Xnu1+zE7TOsH0K/hl4DsjLfOzI2I
         cmCw==
X-Gm-Message-State: ACrzQf1KQvpZBoy4xV9WPEcEmbg2Og5RN0pH7vU7jzc93MH9KU0sGAB1
        EiqKAjcz02JKV3YCZynNtM5/M9ciPgRD8w==
X-Google-Smtp-Source: AMsMyM627qTuk0xQ3BfrSeQ3eIIkKsg3SThpR3lEHmzy3WNO0/wNh1VdWV0JXv/sB5TdAaF9gm2wNw==
X-Received: by 2002:a05:6a02:306:b0:46e:de86:8b24 with SMTP id bn6-20020a056a02030600b0046ede868b24mr1229478pgb.385.1666991695906;
        Fri, 28 Oct 2022 14:14:55 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:65f9:c180:249c:190f])
        by smtp.gmail.com with UTF8SMTPSA id b15-20020a170902650f00b00186c54188b4sm3442109plk.240.2022.10.28.14.14.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 14:14:55 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 2/5] platform/chrome: cros_ec_lpc: Mark PROBE_PREFER_ASYNCHRONOUS
Date:   Fri, 28 Oct 2022 14:14:46 -0700
Message-Id: <20221028141411.2.Ib1036816e77aba71ebc16b71f7615c55d054689c@changeid>
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

This takes on the order of 60ms to probe on some systems, so let it
probe asynchronously. It shouldn't have any dependencies that aren't
handled cleanly.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/platform/chrome/cros_ec_lpc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index 0b6c7c912ec7..527092ffdecb 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -559,6 +559,7 @@ static struct platform_driver cros_ec_lpc_driver = {
 		.name = DRV_NAME,
 		.acpi_match_table = cros_ec_lpc_acpi_device_ids,
 		.pm = &cros_ec_lpc_pm_ops,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = cros_ec_lpc_probe,
 	.remove = cros_ec_lpc_remove,
-- 
2.38.1.273.g43a17bfeac-goog

