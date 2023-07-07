Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2526274B89B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 23:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbjGGVQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 17:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGGVP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 17:15:57 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419D4E5;
        Fri,  7 Jul 2023 14:15:56 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1b055511f8bso1465564fac.1;
        Fri, 07 Jul 2023 14:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688764555; x=1691356555;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o55RwUJuXKY3r9gG6aD9I7YM7CsRDP5cAsKlf5uWgUk=;
        b=B085CBQvPW70+NDYenuenUfdMqMNhFc3riflGkKV4uO3kpzcIVyn8Sr11t2NIZPW2f
         r8Wfowghw66LmqMPvpgWxSm/GTxz2/7sgKK+r22LYV5ANQiqCyfJQatvU1HkC6bXnMwd
         Pv5kYbqEjLO2qxzbYrzQUH1fIxzPT0Hi4lGHxolOKr+lyZIqOC+LN08AB6OJMqxkUDJC
         lYv2PbZfSBomoUB54i5nvJPZ6fHB8cOPe1k9zaBcr0QZrnxN2fzAkrYMsRp85MClth/o
         4oKqfh7rejDOhcg8ZuSzjBNgmllcB6250A9rOGepwNlsCuiCgRAc5Jg0WnxqfKsFGI2T
         G3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688764555; x=1691356555;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o55RwUJuXKY3r9gG6aD9I7YM7CsRDP5cAsKlf5uWgUk=;
        b=LNmGiIgYQiXv/X0O2qM1fmN0ierq4SVYvdXFM9akuxoUnZAbwtbcoiEkwfqyUlYrX6
         0Rw2Y6akAr2nyqhc+RXQPwEnnpKNr478NQVP1jUuFkw8FbhUBgj6RBdULdVGJjYscxPR
         I13kIlHj7oYDZ/72Ee0GZsBC9EqllGAYOFT2Lu1KhA+EfByQh42nGD5PQfr/50FtID9e
         PMXhqr8r6zrCJWAajvazAGmTqFJML/tGRybfU2b1RM9oeOMvsA6dwsHbB1wvwlEBqGMh
         viBz2gpWLfP3pEpjBtNxrAKhY6Um52Sopev7kHjM4Ld6wpRT/gI1VxJrAxOrx0ZArHjf
         8JuA==
X-Gm-Message-State: ABy/qLbnyBQQ+QX8x2SZblUxTKAUHpIX7i+y6LV54/afVMSijUdFAHeb
        fIJnPkhHS6RhHSbAugiADXYY5YjI+J8maA==
X-Google-Smtp-Source: APBJJlFjE+nuPlRO/M/P4aUGLoAAFMQspI16TJMD3W5TSdipZfRhBo4B14UbW2bS61kYw3BfvYfTiQ==
X-Received: by 2002:a05:6870:2054:b0:1b0:2a6b:edf2 with SMTP id l20-20020a056870205400b001b02a6bedf2mr5110225oad.4.1688764555442;
        Fri, 07 Jul 2023 14:15:55 -0700 (PDT)
Received: from madhu-kernel (99-145-207-128.lightspeed.austtx.sbcglobal.net. [99.145.207.128])
        by smtp.gmail.com with ESMTPSA id di22-20020a0568303a1600b006b58616daa1sm2053188otb.2.2023.07.07.14.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 14:15:55 -0700 (PDT)
Date:   Fri, 7 Jul 2023 16:15:53 -0500
From:   Madhumitha Prabakaran <madhumithabiw@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-staging@lists.linux.dev
Cc:     skhan@linuxfoundation.org, ivan.orlov0322@gmail.com
Subject: [PATCH] Add struct ad9832_platform_data to the include/linux/iio
Message-ID: <20230707211553.GA110890@madhu-kernel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add struct ad9832_platform_data to the include/linux/iio
for maintaining code organization and clarity.

Signed-off-by: Madhumitha Prabakaran <madhumithabiw@gmail.com>
---
 drivers/staging/iio/frequency/ad9832.c |  3 +--
 drivers/staging/iio/frequency/ad9832.h | 34 --------------------------
 include/linux/iio/frequency/ad9832.h   | 30 +++++++++++++++++++++++
 3 files changed, 31 insertions(+), 36 deletions(-)
 delete mode 100644 drivers/staging/iio/frequency/ad9832.h
 create mode 100644 include/linux/iio/frequency/ad9832.h

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 6f9eebd6c7ee..675adfb07b5d 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -19,8 +19,7 @@
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-
-#include "ad9832.h"
+#include <linux/iio/frequency/ad9832.h>
 
 #include "dds.h"
 
diff --git a/drivers/staging/iio/frequency/ad9832.h b/drivers/staging/iio/frequency/ad9832.h
deleted file mode 100644
index 98dfbd9289ab..000000000000
--- a/drivers/staging/iio/frequency/ad9832.h
+++ /dev/null
@@ -1,34 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * AD9832 SPI DDS driver
- *
- * Copyright 2011 Analog Devices Inc.
- */
-#ifndef IIO_DDS_AD9832_H_
-#define IIO_DDS_AD9832_H_
-
-/*
- * TODO: struct ad9832_platform_data needs to go into include/linux/iio
- */
-
-/**
- * struct ad9832_platform_data - platform specific information
- * @mclk:		master clock in Hz
- * @freq0:		power up freq0 tuning word in Hz
- * @freq1:		power up freq1 tuning word in Hz
- * @phase0:		power up phase0 value [0..4095] correlates with 0..2PI
- * @phase1:		power up phase1 value [0..4095] correlates with 0..2PI
- * @phase2:		power up phase2 value [0..4095] correlates with 0..2PI
- * @phase3:		power up phase3 value [0..4095] correlates with 0..2PI
- */
-
-struct ad9832_platform_data {
-	unsigned long		freq0;
-	unsigned long		freq1;
-	unsigned short		phase0;
-	unsigned short		phase1;
-	unsigned short		phase2;
-	unsigned short		phase3;
-};
-
-#endif /* IIO_DDS_AD9832_H_ */
diff --git a/include/linux/iio/frequency/ad9832.h b/include/linux/iio/frequency/ad9832.h
new file mode 100644
index 000000000000..517d954636db
--- /dev/null
+++ b/include/linux/iio/frequency/ad9832.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * AD9832 SPI DDS driver
+ *
+ * Copyright 2011 Analog Devices Inc.
+ */
+#ifndef IIO_DDS_AD9832_H_
+#define IIO_DDS_AD9832_H_
+
+/**
+ * struct ad9832_platform_data - platform specific information
+ * @mclk:   master clock in Hz
+ * @freq0:  power up freq0 tuning word in Hz
+ * @freq1:  power up freq1 tuning word in Hz
+ * @phase0: power up phase0 value [0..4095] correlates with 0..2PI
+ * @phase1: power up phase1 value [0..4095] correlates with 0..2PI
+ * @phase2: power up phase2 value [0..4095] correlates with 0..2PI
+ * @phase3: power up phase3 value [0..4095] correlates with 0..2PI
+ */
+struct ad9832_platform_data {
+	unsigned long freq0;
+	unsigned long freq1;
+	unsigned short phase0;
+	unsigned short phase1;
+	unsigned short phase2;
+	unsigned short phase3;
+};
+
+#endif /* IIO_DDS_AD9832_H_ */
+
-- 
2.25.1

