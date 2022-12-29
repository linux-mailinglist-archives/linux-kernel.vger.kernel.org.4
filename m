Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A99B658E77
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 16:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbiL2Puo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 10:50:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbiL2Pui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 10:50:38 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7602813F7E
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 07:50:36 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so13447646wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 07:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRwdQu5MiMvipA/jHJnFPhBPMARfFwJxa4aVOmTfNpg=;
        b=67dGg5+xjqMX/D0bD3SWdlDwwwKvCXeIzJHQBdkaJpKhIJbCAF9GRz8iR3gW6bF0D7
         NKPeaP7a2AO+JKD+fbkHNekVmKtcGtnDoPQLtTY6qbHDYEumqhvpyAHtny7YwwHDcCSG
         JD5dE5eXKHxaXuhLP6YyqKF4yyJwS3o3NA5p3W7u1kZTr+ZJT4lrGs5hEMuS5iO6o/vt
         GIev6LVyYiORGCHre9xtjmsbINYF2OIMHCj3FBc/Im2zuoeLK4zPBQZ+7lkoDno0SLRf
         +ZsWFnbYamxsv/ym6lHs1QUs+N/4s5JTc/4l7U4Oi+X8PKQjWSN3ZEootpSnirmRktvn
         OccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uRwdQu5MiMvipA/jHJnFPhBPMARfFwJxa4aVOmTfNpg=;
        b=XF9n8pcMk+7xr9bBdCA6CWRKscXuAg68v+6CNcQEH47km98FoqyAfb3KdhD32vKBN8
         8HQS+Dm52gPjo0tMD9Cz4EZrf9i7xXLkspM2ujlqRV0FKK7Q9AjS7OPplVL1zdFPAFBJ
         L12xSKIGFImb5g66aP4IH/tFB/AjwvtuxeyrKU1quONIYdxvXn9E4dG+X8YUUqZO5hqb
         r7fENo7y4mLNT3LQPquezujDS6F1w9KpXU9MRLmp/fMR+06Bysy53oXyZBgzUEbPY4gC
         c8jju5q2FeSmzv0Y+j8dWYaTA0CVSPA92hQ9L/8kwLmhlXibhvlJ5RDQPc8KHiQNRj/u
         1GDw==
X-Gm-Message-State: AFqh2kr/JYGPwUsitWnZ/DPe5VK7nFsTWUtN5KuAerXqAh7RYnk6B9SY
        gBDN4ebyC7xl6D00AJJs6UbOgw==
X-Google-Smtp-Source: AMrXdXvKIcEvg6Q7DVBAgfIR7uBHoLavWetAfhN1MjNJPUD9lLXqeIpajYo8Gr9zTKhTqluW2fKxLg==
X-Received: by 2002:a05:600c:600a:b0:3d1:ed41:57c0 with SMTP id az10-20020a05600c600a00b003d1ed4157c0mr23663168wmb.30.1672329034988;
        Thu, 29 Dec 2022 07:50:34 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:8f7a:98d8:9d8d:ced8])
        by smtp.gmail.com with ESMTPSA id bh12-20020a05600c3d0c00b003cfa81e2eb4sm25251647wmb.38.2022.12.29.07.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 07:50:34 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v6 01/14] tty: serial: qcom-geni-serial: stop operations in progress at shutdown
Date:   Thu, 29 Dec 2022 16:50:17 +0100
Message-Id: <20221229155030.418800-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221229155030.418800-1-brgl@bgdev.pl>
References: <20221229155030.418800-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We don't stop transmissions in progress at shutdown. This is fine with
FIFO SE mode but with DMA (support for which we'll introduce later) it
causes trouble so fix it now.

Fixes: e83766334f96 ("tty: serial: qcom_geni_serial: No need to stop tx/rx on UART shutdown")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index b487823f0e61..4f4c12f3c433 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -880,6 +880,8 @@ static void get_tx_fifo_size(struct qcom_geni_serial_port *port)
 static void qcom_geni_serial_shutdown(struct uart_port *uport)
 {
 	disable_irq(uport->irq);
+	qcom_geni_serial_stop_tx(uport);
+	qcom_geni_serial_stop_rx(uport);
 }
 
 static int qcom_geni_serial_port_setup(struct uart_port *uport)
-- 
2.37.2

