Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8839F631996
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 06:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiKUFy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 00:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKUFyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 00:54:24 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018F02A942
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 21:54:23 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id fz10so6717718qtb.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 21:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bYLHs4Tv0kzA8jWolRuh27E33bdQTTgUZOnHhl5CH3M=;
        b=hrakBflwl6mnCesxOJqgLI1x1zXR8GYUlRuzuY4HEi/974Eo5XCR4UAkr/66pD/31O
         OpKeHtleGC2X4PtnRKfUg45AzOmEZV6rrmle0NvVFfKJ4dHc/QtefVkLBicrcKYTlwXc
         ZGCzuVaHC9u8jBepT3EcudxWkBz8IBuJni72ChR/XqvcqThGL0tuTV4OxrqnD0ZJ/J7U
         YvcHFENT+2eNcI/DBjJzAfV98IG4FkS4sx8sXx5sbehTfrXxnoH61AjBKk5gY1Tns+I8
         ygq7mS3Mt6nDHYxJzum849SPjAreBRgL//c9BoNzkFa3ObFbK6x1q7t//Kr5/ff54w7V
         N6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bYLHs4Tv0kzA8jWolRuh27E33bdQTTgUZOnHhl5CH3M=;
        b=GBqgoqe7qmD4StOHNLkg0FLmI4hcrWy6cjGvQfDiuTF/oUoaT3Et5tmcf83+7Qpi9/
         F1JyQd5AxRBsJX7jDj3KGn4NJOA23UDpa93HA8xgJ0fKCQsqivWhxFXJtJcTVEon153+
         0jpGFPr7VzsfKx270Usq1luqIIPkdC05EeZeoyIRxPOi5TFtNuft8q7XHSg2Q2nlpxlZ
         cVORcsWwxCAgi7r5cKJkiTWwMJulTXwBf+Q5CT+gUyEVFpsRN01yVbWm5szNa5/D/etx
         mBpjXO3y2mpuQBDqp38PAgSSX9uApXxRONtgzgFC8MN6N4jAQGObe+jULU2cHpEs/0jw
         0sRQ==
X-Gm-Message-State: ANoB5plb5DrQTZ52L9ZWIjYBNITkLMQ0stamUVkr5IL5Iee3ZlOA/7rD
        cSgyqOM6RhIzdlHt67hlir/Vco8vTVfVC1ts9aA=
X-Google-Smtp-Source: AA0mqf5eV/dPNubN1IyiPHhGB9K2GgXwaErCcNw4UIQtIQ3XBSOacEnRAbZsbLZDycHbstbO118agg==
X-Received: by 2002:a05:622a:1a19:b0:3a5:c55a:72c4 with SMTP id f25-20020a05622a1a1900b003a5c55a72c4mr16225709qtb.223.1669010061801;
        Sun, 20 Nov 2022 21:54:21 -0800 (PST)
Received: from localhost.localdomain (bras-base-mtrlpq4362w-grc-30-76-66-139-34.dsl.bell.ca. [76.66.139.34])
        by smtp.googlemail.com with ESMTPSA id cc16-20020a05622a411000b003a606428a59sm6232862qtb.91.2022.11.20.21.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 21:54:21 -0800 (PST)
From:   Jacob Macneal <jake.macneal@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     jake.macneal@gmail.com, John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH] time: copy tai value (International Atomic Time, in seconds) to output __user struct in get_old_timex32().
Date:   Mon, 21 Nov 2022 00:53:45 -0500
Message-Id: <20221121055345.111567-1-jake.macneal@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, this value was not copied into the output struct. This is
despite all other fields of the corresponding __kernel_timex struct being
copied to the old_timex32 __user struct in this function.

Additionally, the matching function put_old_timex32() expects a tai value
to be supplied, and copies it appropriately. It would appear to be a
mistake that this value was never copied over in get_old_timex32().

Signed-off-by: Jacob Macneal <jake.macneal@gmail.com>
---
 kernel/time/time.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/time/time.c b/kernel/time/time.c
index 526257b3727c..7da9951b033a 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -311,6 +311,7 @@ int get_old_timex32(struct __kernel_timex *txc, const struct old_timex32 __user
 	txc->calcnt = tx32.calcnt;
 	txc->errcnt = tx32.errcnt;
 	txc->stbcnt = tx32.stbcnt;
+	txc->tai = tx32.tai;
 
 	return 0;
 }
-- 
2.32.0
