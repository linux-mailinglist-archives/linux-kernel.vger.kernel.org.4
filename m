Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A941637CEE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 16:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiKXP0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 10:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiKXP0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 10:26:06 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6B171F10;
        Thu, 24 Nov 2022 07:26:05 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id m7-20020a05600c090700b003cf8a105d9eso1470421wmp.5;
        Thu, 24 Nov 2022 07:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RFdvIR/Wz5kelouQLG/ubcPsDMhiBZ2xz7S2HW6xiOU=;
        b=EjJkxyb2J6KRyLMJHHWmi5TEzCdqLNFjyjGBsx6WbCNDDygGlXYJg0DYtFDyFNA3mj
         PGliv5ihD2ENQ9wZpHys4oJYDU07QaWo0JGvs0VU7Gbb+xC3TGUtqg9A0y3lV4Gbfmue
         cQitJnXC2WZMDWFOhmSYXPeqEdgq7jjDZT5XBo9HaNhZK4yxwrw4GEdUPjeg9vgbBH68
         umh0AGLbJIBVrmCwNRiTjlM92PptQPnbXjg3ddm4EZntLTkHJyRMe+rA2LBnI0vNXYL3
         5w7lHE+AUGxX8S//P5yf45IfCF9CbzOyarWf6FYupZavoHoq9g2UARVSsQlPY9ZTzCCo
         rDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RFdvIR/Wz5kelouQLG/ubcPsDMhiBZ2xz7S2HW6xiOU=;
        b=DLvRF/d96cfqClDUFO/AVicO8HwCzij5ZNLEzcxVsdKjXXeO6KuNoLQEPn+21xDx75
         WavWR7mn6RYA3/twzeS3vlSTLNTFr5zBiB9UqYpEyO06fmqlZB9V1vQjLwJ0C9m7QiG6
         NSxtAFdNRWiWysLUQukSf2gYTNuJVc5y7fW9ShP3FGQaC3UT+RhYXUn4B9HY6NcDrApM
         B8tAmvvtuEAeRKX03JSvO3U95cF7hfhxTl+tkCt0FdraZ4OuO9ddJFnVk14BIOzlPLqH
         4pIXqMRdHvZFtUEe2uRp957QY9En0NVqJUzd721g0JpV6WZYTGmlvqC2fuUp3mQc0boy
         l7NQ==
X-Gm-Message-State: ANoB5pkwGsDd+07m3PF2RON0gUMoTyoWDVk0HiRynJZ/eUURfJLA85Iv
        7VDTDvMSNscsdRTg9BxRStA=
X-Google-Smtp-Source: AA0mqf6XErspL0vFbZqFpa1fn9RByxSaoiAyw8VREmNItJcab7jAyeuccOjhOLOsfvTfW8y8vmc3CA==
X-Received: by 2002:a05:600c:4fcd:b0:3cf:7514:a80d with SMTP id o13-20020a05600c4fcd00b003cf7514a80dmr3318301wmq.0.1669303563438;
        Thu, 24 Nov 2022 07:26:03 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.13.177])
        by smtp.gmail.com with ESMTPSA id x9-20020a5d6b49000000b002366e3f1497sm1633121wrw.6.2022.11.24.07.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 07:26:03 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
X-Google-Original-From: Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] iio: addac: ad74115: remove unused ad74115_dac_slew_rate_hz_tbl
Date:   Thu, 24 Nov 2022 17:25:59 +0200
Message-Id: <20221124152559.7895-1-cosmin.tanislav@analog.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This table was supposed to be used for handling the DAC rate, but it
ended up being unused. Remove it.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
Reported-by: kernel test robot <lkp@intel.com>
Fixes: 48ea75598db2 ("iio: addac: add AD74115 driver")
---
 drivers/iio/addac/ad74115.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iio/addac/ad74115.c b/drivers/iio/addac/ad74115.c
index 383b92e7b682..e6bc5eb3788d 100644
--- a/drivers/iio/addac/ad74115.c
+++ b/drivers/iio/addac/ad74115.c
@@ -317,10 +317,6 @@ static const unsigned int ad74115_dac_rate_step_tbl[][3] = {
 	{ AD74115_SLEW_MODE_LINEAR, AD74115_SLEW_STEP_22_2_PERCENT, AD74115_SLEW_RATE_240KHZ },
 };
 
-static const unsigned int ad74115_dac_slew_rate_hz_tbl[] = {
-	4000, 64000, 150000, 240000
-};
-
 static const unsigned int ad74115_rtd_excitation_current_ua_tbl[] = {
 	250, 500, 750, 1000
 };
-- 
2.38.1

