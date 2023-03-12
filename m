Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850B76B68CD
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 18:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjCLRda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 13:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjCLRd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 13:33:28 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F44D1ACD1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 10:33:23 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id r19-20020a05600c459300b003eb3e2a5e7bso6481252wmo.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 10:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678642402;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SYkkS+oZSSfD9zGRsvgAy1sxi0/N+dGDM4TdmGz9U18=;
        b=HW+MTca27uXJN+ak1iLSRAeq6brTVBups1xzLy7LB6cenwEBkLZPJATE81gKsCehmG
         nVHpyWtEHl7ob/WDwjY81BC1Oyl5TUg323NewaOmGEURAP0p8vdcvPosLdtxGPJMZX6z
         Yq8doMZKqbIOnXwadY/tlO+09l88MR/tNLmTyk1ptkpSN3El3xQ4O4Y/gbReIh4h9hIB
         xTlbS+zj6nUEjXgbA6eFpAjRG0oTgjlBF6JsoBGfWSoAY1Bf68Kb1gZHA4rs0Sw4+yCa
         /vi3VQvktpIVEgK5Oa9GT7fioq2D7NOnvrXnkPfxQc+yE5wMs+YITdxtYruUZLlVvYwb
         4Dlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678642402;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SYkkS+oZSSfD9zGRsvgAy1sxi0/N+dGDM4TdmGz9U18=;
        b=UgL+CJeR/OpksSJ3R5rwRCNIWGrFjKKpQ6HwLQrqQCg81ZCNBFyvyDVHkLTMScSZ0V
         9IwsuW4MtTJWSyzZ2BXdyVmlz/u76FqmuT8rha2Y+eOJliaNDadajOndlOTdDi+W0b2m
         5oQvFagTKFxp5QkVZWl2Vt75tB31SBrJssf6IS/FVoE9qRHxlpFPFh+xiAOxlsusiN5C
         thuSDBskCBns1cnJiWbJ9Ows/HupwHanM1K2NJCle1rDPexMubpy1LIOaIn+4Ox07AsK
         tr+MFs4hRXJab+ntwjiHXd06TUF6eRfYTijhK/gEK/Q073Ly+uBqAzDxKcmJWp+5L0NL
         3d4g==
X-Gm-Message-State: AO0yUKXw/i1mERDhYA1hZrcHmugTXcKg6aZAF7c0WNq+Kz4atPG2nmWY
        sqt/0SVpYh3M/GhtPA/qZzHuVPXHQrUc7U7/
X-Google-Smtp-Source: AK7set8soss/y1o1J91swWqCXh1d4gLr/l28MxM+9gqizZwNxPUiFxGus8uZNNCu04oXMRtdZ/vK0g==
X-Received: by 2002:a05:600c:4751:b0:3ea:f73e:9d8a with SMTP id w17-20020a05600c475100b003eaf73e9d8amr8551875wmo.30.1678642401806;
        Sun, 12 Mar 2023 10:33:21 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.45.115])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c021100b003ed2002fa6dsm2937890wmi.17.2023.03.12.10.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 10:33:21 -0700 (PDT)
Date:   Sun, 12 Mar 2023 22:33:19 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v4] staging: axis-fifo: initialize read_timeout and
 write_timeout once in probe function
Message-ID: <ZA4M3+ZeB1Rl2fbs@khadija-virtual-machine>
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

Module parameter, read_timeout, can only be set at loading time. As it
can only be modified once, initialize read_timeout once in the probe
function.
As a result, only use read_timeout as the last argument in
wait_event_interruptible_timeout() call.

Same goes for write_timeout.

Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---
 drivers/staging/axis-fifo/axis-fifo.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index b119cec25a60..7ec8722cef7d 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -384,9 +384,7 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
 		mutex_lock(&fifo->read_lock);
 		ret = wait_event_interruptible_timeout(fifo->read_queue,
 			ioread32(fifo->base_addr + XLLF_RDFO_OFFSET),
-			(read_timeout >= 0) ?
-			msecs_to_jiffies(read_timeout) :
-			MAX_SCHEDULE_TIMEOUT);
+			read_timeout);
 
 		if (ret <= 0) {
 			if (ret == 0) {
@@ -528,9 +526,7 @@ static ssize_t axis_fifo_write(struct file *f, const char __user *buf,
 		ret = wait_event_interruptible_timeout(fifo->write_queue,
 			ioread32(fifo->base_addr + XLLF_TDFV_OFFSET)
 				 >= words_to_write,
-			(write_timeout >= 0) ?
-			msecs_to_jiffies(write_timeout) :
-			MAX_SCHEDULE_TIMEOUT);
+			write_timeout);
 
 		if (ret <= 0) {
 			if (ret == 0) {
@@ -814,6 +810,16 @@ static int axis_fifo_probe(struct platform_device *pdev)
 	struct axis_fifo *fifo = NULL;
 	char *device_name;
 	int rc = 0; /* error return value */
+	
+	if (read_timeout >= 0)
+		read_timeout = msecs_to_jiffies(read_timeout);
+	else
+		read_timeout = MAX_SCHEDULE_TIMEOUT;
+	
+	if (write_timeout >= 0)
+		write_timeout = msecs_to_jiffies(write_timeout);
+	else
+		write_timeout = MAX_SCHEDULE_TIMEOUT;
 
 	/* ----------------------------
 	 *     init wrapper device
-- 
2.34.1

