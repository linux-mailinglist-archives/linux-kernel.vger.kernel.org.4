Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4E95EC87E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 17:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbiI0PtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 11:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbiI0Psh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:48:37 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFCAB602E;
        Tue, 27 Sep 2022 08:46:18 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so15933913pjq.3;
        Tue, 27 Sep 2022 08:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=wMvcXz6njxFqTkf6vcxe/vNIZjFAgSwlMQsOVeR0+8M=;
        b=jPawEHHILhsPfvMKuPsObAHlThgGKv81yzVkz5Ryj7HP6E5dMzCqSjNgKfEDss828w
         GS8xx6/3CeNMdUe9Uppr1P4axJwRPDV5sHljxwyE6gzTdRQ+1qPqMG/UcAJ3l9jZdW/5
         RdYmGHtywCQR69IbIMSBNliNGwaBucPonNNEKl34ARl6MeI5FJMzqFEL6E7guhVEk7jv
         NY1pDTm4pILsLtwJPYbIJlFyeOVI0bk6ZwHlFDW83qE0+lCST8uwHTfpeRN87PEXbRui
         ETWoy95MnLW3p3T3OzYEbML+cbOFTzCVToSGid4ZihQRx/xLGb4TOlm83OS0Cb5R6Ux4
         weIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=wMvcXz6njxFqTkf6vcxe/vNIZjFAgSwlMQsOVeR0+8M=;
        b=P5dnKLyBBIEGZImI1/nKWY2AEHhTMega38k/EBI6wa35udIzK96pKpHxRNUWp/WIeF
         b7Q9pJIRfk9FvH7JUSvDGJIDRWNZlMd6CoYNQhNZplzUy7bJv+XUmPSucht0Wuh6xCo3
         2x7JOV+yF/FGXgUehz/RZ04ZkGtRxzrEhHiJNYfntvR51XdZstCKBZjSM11J3RYVu/vj
         21kimhG5z0yJxWZmgJcgc0fkRyt1DKuaPhvRApk6Fzf8ZyJteyxHvtVZll57hg9e9jBW
         Mvct0nHOyI+r9e/UJ7EMgPlfSCvooPqbjWJV4HkaBBqyd2t7mQPHRsJIGfjbRHiY0dh9
         +iyA==
X-Gm-Message-State: ACrzQf3ndOW70aycMKlVvS0zkhhKEAPZcvNio5uVIpnnTCe1tLcBCMxs
        RSww/jF0EjnG1xWAblfNgaw=
X-Google-Smtp-Source: AMsMyM5r8WFjVQ3qChKKd71TapR7vlIDeaT1mxjSbZ4MzQYLdoiie7jcWk6g7JKGEdRlLyucKRDchw==
X-Received: by 2002:a17:90a:64c8:b0:202:6d4a:90f8 with SMTP id i8-20020a17090a64c800b002026d4a90f8mr5377585pjm.11.1664293578171;
        Tue, 27 Sep 2022 08:46:18 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:9739:ab49:3830:2cbb])
        by smtp.gmail.com with ESMTPSA id cp7-20020a170902e78700b0017839e5abfasm1681204plb.263.2022.09.27.08.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 08:46:17 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>, Lee Jones <lee@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Tony Lindgren <tony@atomide.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] iio: adc: twl4030-madc: add missing of.h include
Date:   Tue, 27 Sep 2022 08:46:11 -0700
Message-Id: <20220927154611.3330871-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20220927154611.3330871-1-dmitry.torokhov@gmail.com>
References: <20220927154611.3330871-1-dmitry.torokhov@gmail.com>
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

The driver is using of_device_id/of_match_ptr() and therefore needs
to include of.h header. We used to get this definition indirectly via
inclusion of matrix_keypad.h from twl.h, but we are cleaning up
matrix_keypad.h from unnecessary includes.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

v2: adjusted patch description

 drivers/iio/adc/twl4030-madc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/twl4030-madc.c b/drivers/iio/adc/twl4030-madc.c
index f8f8aea15612..c279c4f2c9b7 100644
--- a/drivers/iio/adc/twl4030-madc.c
+++ b/drivers/iio/adc/twl4030-madc.c
@@ -30,6 +30,7 @@
 #include <linux/types.h>
 #include <linux/gfp.h>
 #include <linux/err.h>
+#include <linux/of.h>
 #include <linux/regulator/consumer.h>
 
 #include <linux/iio/iio.h>
-- 
2.38.0.rc1.362.ged0d419d3c-goog

