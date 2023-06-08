Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3A3728B32
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 00:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236293AbjFHWm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 18:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjFHWm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 18:42:57 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC152D4B;
        Thu,  8 Jun 2023 15:42:56 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f732d37d7bso8741265e9.0;
        Thu, 08 Jun 2023 15:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686264175; x=1688856175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z5+I2QWhzf+RiNGGieH6S0XhkG75IeU581JZPazQ2GI=;
        b=IqSmXlKKrCQF3YfLlNtzZEwjkn2rJP/t6RfM79OSim9NNQSqdhL7Mx/hj/B4VryRkP
         Q9eaghh9EiGHItvCrIu/FMhbk0+r3lbnkMQZYHVBtUGDddE+CPoXTSq6145NOrU99HyJ
         BMzuFB/FRiIA/dyTHlbGhNW/TgOFnHUlc39h1mJrNlmzUWqIM8zv8kqfp/3DSwg1g6NC
         2H/xk4O8IE4Fq6++kCspk0MHRc5S6Qavc/JIYvWR1Jq7kUS6RggUPqkztmaYJqKvvDEk
         w90nEEktVeJC9Fs6kzMMytD8EaMOPAnSzwF5MmnJoAvtXlaFNev+G322CqVep8i49GGB
         idKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686264175; x=1688856175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z5+I2QWhzf+RiNGGieH6S0XhkG75IeU581JZPazQ2GI=;
        b=WFQ6bCsxZzogmJJ1fcAgcyFdJu0gkIuikq2YGui2v5+RvGZKqrhFcBD7xKvemxGpyM
         ngVusdZDTIxmjBOHcWS011o5jI/ZV4ZzKbjXVXdGrOsM4az/uqvr8O8LhTwvZgbhdlBB
         CUkF7B2TQfeY7j8QQWqF32TSQD6JOLybY5xSC/STQBorNAY9QZ466NcN76CI4no+aQDJ
         Z+1jyc4oh9KP4Wdmh5MeY6gnA5xtvRmh+hl5V6Ijpl+b+Su0gHViTdIRtr9GZ6I55Via
         nGvk/1aRyWSl304+Wq3UzJAUA49nQjd4s9aTtVdUtaMn0sHBiPrZpVNSIXbLongzywEE
         1qWA==
X-Gm-Message-State: AC+VfDwPhYfrf/uNa2+Jq+sdZNF8idAATImeT9tb/q7Ho0IYBOV80vaD
        8G1WcUXKEu67XDB1v9S99c4=
X-Google-Smtp-Source: ACHHUZ4xO0JlZa9TP0ZuhFKWPo+2u51TbDZEONZ5ifIh/0+ViToGtZphCf+S8K0f2fGLbDBibEpcDA==
X-Received: by 2002:a7b:c40b:0:b0:3f8:1a:6b9f with SMTP id k11-20020a7bc40b000000b003f8001a6b9fmr1250070wmi.2.1686264174959;
        Thu, 08 Jun 2023 15:42:54 -0700 (PDT)
Received: from localhost.localdomain (bba-2-50-150-163.alshamil.net.ae. [2.50.150.163])
        by smtp.gmail.com with ESMTPSA id x5-20020adff0c5000000b003078a3f3a24sm2693912wro.114.2023.06.08.15.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 15:42:53 -0700 (PDT)
From:   YYang <iyysheng@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net
Cc:     linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, YYang <iyysheng@gmai.com>
Subject: [PATCH] Documentation/hwmon: Fix description of devm_hwmon_device_unregister
Date:   Fri,  9 Jun 2023 02:42:30 +0400
Message-ID: <20230608224231.1156-1-iyysheng@gmail.com>
X-Mailer: git-send-email 2.41.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YYang <iyysheng@gmai.com>

Use devm_hwmon_device_register_with_info to replace
hwmon_device_register_with_info in description of
devm_hwmon_device_unregister.

Signed-off-by: YYang <iyysheng@gmai.com>
---
 Documentation/hwmon/hwmon-kernel-api.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/hwmon/hwmon-kernel-api.rst b/Documentation/hwmon/hwmon-kernel-api.rst
index c2d1e0299d8d..6cacf7daf25c 100644
--- a/Documentation/hwmon/hwmon-kernel-api.rst
+++ b/Documentation/hwmon/hwmon-kernel-api.rst
@@ -66,7 +66,7 @@ hwmon_device_register_with_info.
 
 devm_hwmon_device_unregister does not normally have to be called. It is only
 needed for error handling, and only needed if the driver probe fails after
-the call to hwmon_device_register_with_info and if the automatic (device
+the call to devm_hwmon_device_register_with_info and if the automatic (device
 managed) removal would be too late.
 
 All supported hwmon device registration functions only accept valid device
-- 
2.37.1

