Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4FCF70D0DB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 04:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbjEWCMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 22:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbjEWCMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 22:12:01 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BBDE0;
        Mon, 22 May 2023 19:12:00 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-76c5749b10fso81691539f.2;
        Mon, 22 May 2023 19:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684807920; x=1687399920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VJfHoPjEdJerv/4mP+VuPfal6WpQQrTrUh+1isiZJiY=;
        b=ebjFmD3EYsiS45a/YwY1gxAJpmXDKpnFV6dz4beCOni1z8I4ePEbgGJDWv84H5g3Qi
         phMjOew7/29ZJLkPHZD+m0FlmbYHRhPoe1AZ5DpLuf307CdMClssLYGZLErYm0I5KSlC
         jnY5TFvKSq6npdmxeE/lDl9rK4cuRHqS5Ry6ovMX1YbiKSnTY4YUck/HsiUtB2oApDdi
         /ezho9onmjgkEHEVO88c8Xk4A5ypY5MdPvLmTLTjAc5lLypcDnWsq+8vNNJca9uxcsBA
         NaCvp7Vc3v+H4lInMS3bwUHA3XtH57I5VP8KC0BwnrmGgwBuRefnLtVrPB2Xpx4UNFSc
         Ph/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684807920; x=1687399920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VJfHoPjEdJerv/4mP+VuPfal6WpQQrTrUh+1isiZJiY=;
        b=ecRID5KbEd5yrOfpR7EdtVQFkhqFcgNA1U+bPrfeqjLhWfvaXf5/zb6MxQ8kVTxY+H
         upRZpbPlM0mverZLm4Y6PsqqKULXYasA24I9e7bvCVZpnPSHf2K82VQyH24IaaCrsq7i
         oDcAvh5p6Jv3Qw4IO0No85URtcuRyHIkF98+Q3L1dlike6CaMfL/ayll47K6IEyMejA3
         XUMgYSavOjnXvCwDgCZ0TZc+W7F90KXbQ7ZhoGdIGKnjrcM3t8wpaEMPnKwvRYBjl6Yz
         9JOT7Gea/Td5dnbvhTS7ppxvODL+O7TQoPPbP4hNtGKOWZxFHnVkzIJCsa8Q/7HYPukB
         sQwQ==
X-Gm-Message-State: AC+VfDw5P+PRhxaNMklh0AOwZs7umhhU0dFg0pHpfcMPZXTT7Cc4zJx4
        bbdRkSCNJJbH0u0axrPCoPE=
X-Google-Smtp-Source: ACHHUZ6WB7FIFjgwqAhfG5aBPHqPf9uYffQux1F67KQSbf53W/IpTYLYR90Yr6ezdN7L+01NXEaSuQ==
X-Received: by 2002:a6b:910:0:b0:76c:570f:ac84 with SMTP id t16-20020a6b0910000000b0076c570fac84mr7450163ioi.15.1684807920022;
        Mon, 22 May 2023 19:12:00 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id b59-20020a0295c1000000b00418507eef02sm2080544jai.31.2023.05.22.19.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 19:11:59 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Subject: [PATCH] i2c: Replace all non-returning strlcpy with strscpy
Date:   Tue, 23 May 2023 02:11:50 +0000
Message-ID: <20230523021150.2406032-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().
No return values were used, so direct replacement is safe.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 drivers/leds/flash/leds-as3645a.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/flash/leds-as3645a.c b/drivers/leds/flash/leds-as3645a.c
index bb2249771acb..7dc574b18f5f 100644
--- a/drivers/leds/flash/leds-as3645a.c
+++ b/drivers/leds/flash/leds-as3645a.c
@@ -651,8 +651,8 @@ static int as3645a_v4l2_setup(struct as3645a *flash)
 		},
 	};
 
-	strlcpy(cfg.dev_name, led->dev->kobj.name, sizeof(cfg.dev_name));
-	strlcpy(cfgind.dev_name, flash->iled_cdev.dev->kobj.name,
+	strscpy(cfg.dev_name, led->dev->kobj.name, sizeof(cfg.dev_name));
+	strscpy(cfgind.dev_name, flash->iled_cdev.dev->kobj.name,
 		sizeof(cfgind.dev_name));
 
 	flash->vf = v4l2_flash_init(

