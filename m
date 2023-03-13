Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961746B7FEE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjCMSHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCMSHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:07:16 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC2A30B26
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 11:07:15 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id x13so4911161edd.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 11:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678730833;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TGt5AxMHWQcOiTCB8nZSOBEYxGxgT5H6m9rVSzLuKI4=;
        b=JXTiJ57Ywbul0B08SiM+XnEt6Pa1sTLB/25UXpln6gBFs342vnPy6faBkgbZD9aZ6K
         zdJPvBkHdRPB/+R34jjvcpeimzkjkgQEcyingq9+beEJU1BJQvqjCXafJYlddy+jqZav
         3o23JYyggVRmh/wPN9taOWd+LZwgzdp+4EDYmt4VhG1UcjWcOReJHFqs17V8+Pfq8cwU
         1+DQJzd0FkxrRsJd+Ynd0Fc+lyVRez9wNljm62bCnjI9q7qdYZx39B645LI/BVktmXez
         tNq42cXhJ4O9+D2bTd5ncsQdiZiRoTIAH4fjcljdanXMtSsUXYAUvWegxFrmHZUn7OTy
         kfVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678730833;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TGt5AxMHWQcOiTCB8nZSOBEYxGxgT5H6m9rVSzLuKI4=;
        b=o18qhS6hhvUfdynfBtc9JO6MSzFY+d9H2TyfScIQoxRZxDF3Nqa7T75oRl+pO6n+v1
         awHUdmUEQoUxoDspeV21q/FiLCYnvOEnHG/StucOqaAhHR5OgFaYoYZ6Fp6l+RcJyiJh
         nE1m8ItmvOMmI1ffqrh/aDaSyig/rmt3AhP6wBGUXNGYz2bnFeArpo93l9D9vcwHE4U/
         8H+7Ud1WuQ7LTC06UdPA/2uMk1Ip+gUZOj417TnWmZSo4/geivvS2hp3lXQsQYs0rqoK
         Qkk3e4bn6zp8Zb8bQHT8bTDjAPvitO+Flk0zUetT0fSMdfMdrS3lniO0N3RIzpa9lpDP
         J8tA==
X-Gm-Message-State: AO0yUKWQUr1eTGzHYo+J5ELp6e7f5odr2wihkxNppFnj7eMmOkfp43cb
        ZuzYaJDmHjB7zCpPqgmLkPiqVStj/ehExvsK
X-Google-Smtp-Source: AK7set+84wZUkWvYChMNBkCBuAos3Wl9EAsOrYDZZzeMF2RPD63heLxQOk3Sh0lAGFjq4GQLOkZc8w==
X-Received: by 2002:a17:907:dab:b0:8ae:11ca:81de with SMTP id go43-20020a1709070dab00b008ae11ca81demr43476604ejc.34.1678730833384;
        Mon, 13 Mar 2023 11:07:13 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.45.115])
        by smtp.gmail.com with ESMTPSA id u26-20020a1709064ada00b008e125ee7be4sm81663ejt.176.2023.03.13.11.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 11:07:12 -0700 (PDT)
Date:   Mon, 13 Mar 2023 23:07:10 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: axis-fifo: initialize timeouts in probe only
Message-ID: <ZA9mThZ7NyRrQAMX@khadija-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Module parameter, read_timeout, can only be set at the loading time. As
it can only be modified once, initialize read_timeout once in the probe
function.
As a result, only use read_timeout as the last argument in
wait_event_interruptible_timeout() call.

Same goes for write_timeout.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---
 drivers/staging/axis-fifo/axis-fifo.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index dfd2b357f484..563caf155713 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -384,9 +384,7 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
 		mutex_lock(&fifo->read_lock);
 		ret = wait_event_interruptible_timeout(fifo->read_queue,
 			ioread32(fifo->base_addr + XLLF_RDFO_OFFSET),
-				 (read_timeout >= 0) ?
-				  msecs_to_jiffies(read_timeout) :
-				  MAX_SCHEDULE_TIMEOUT);
+			read_timeout);
 
 		if (ret <= 0) {
 			if (ret == 0) {
@@ -528,9 +526,7 @@ static ssize_t axis_fifo_write(struct file *f, const char __user *buf,
 		ret = wait_event_interruptible_timeout(fifo->write_queue,
 			ioread32(fifo->base_addr + XLLF_TDFV_OFFSET)
 				 >= words_to_write,
-				 (write_timeout >= 0) ?
-				  msecs_to_jiffies(write_timeout) :
-				  MAX_SCHEDULE_TIMEOUT);
+			write_timeout);
 
 		if (ret <= 0) {
 			if (ret == 0) {
@@ -815,6 +811,16 @@ static int axis_fifo_probe(struct platform_device *pdev)
 	char *device_name;
 	int rc = 0; /* error return value */
 
+	if (read_timeout >= 0)
+		read_timeout = msecs_to_jiffies(read_timeout);
+	else
+		read_timeout = MAX_SCHEDULE_TIMEOUT;
+
+	if (write_timeout >= 0)
+		write_timeout = msecs_to_jiffies(write_timeout);
+	else
+		write_timeout = MAX_SCHEDULE_TIMEOUT;
+
 	/* ----------------------------
 	 *     init wrapper device
 	 * ----------------------------
-- 
2.34.1

