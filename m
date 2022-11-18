Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F8F62F497
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 13:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241855AbiKRM0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 07:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235247AbiKRM0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 07:26:09 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B05997096
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 04:26:08 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id v1so8963218wrt.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 04:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lTVRxd5tZFYcvUoBnJpH34+lxjijlQ63axYU+EIhaXk=;
        b=BhYh54GUE+xzT/TMuZWnyrjmyv/UsQhZctMlScPYOoyvy4C/TGMOlYbyvWZLzt/xos
         lOWqQqfNM+T8o3IfIe/9N0HpoFMnPdF38KUpr4N/Sg7SW74bskjcgO7Buo/9wpNgZho3
         FO7NnEic/tkdb+wEC89PNJaSNh7hACaj4jHPwRb4dqWfhBS8Lju/+5HDiN7mxRi8FYq/
         DtkHmNbWUux+9CD70LNDEYtuEMlg2gQSts9D2qFRkcO7pnf0V2SRcALAG1HtAYVFojO2
         Lb3v8sws7nnhiZRGFRPRHD5pQ3bzj1pYbIHAhwosIPDJJ/Lm673SaRAZkQ2tz2JIZov7
         tcaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lTVRxd5tZFYcvUoBnJpH34+lxjijlQ63axYU+EIhaXk=;
        b=F3imbeNkNpeuCx8fW2UUxRpjPw0SiTIDQn0t4hZ6/tW5QSgnjEmkcn5gRbSGNMjznM
         U8ouD70bUlaWuoyDpb9pTVcXALLaMfhcRWRsC6AqDz4d73rwT1MtX+1MZRG3gY4Q08bL
         OQgaSnSrSUm3YQjiJ1yGHq1RUqp9l4+rbOlEDCzl1uievpnkDhK7dPEXN+QQU/+bAGs9
         K1ZCtf/wVWubFccFCegvBtXY4V4fQP3b7ZU9FpUebih/uSWueL7FEr1qnbEn1RspbYqq
         RvTJUfctaAXssLjHcXWPlORUvL8D85fd9il+mN9EcqsBbJDuPk8rgGGCSdmC5WAszPgi
         vNYg==
X-Gm-Message-State: ANoB5plYOZ2zH6s8W5VBsQgOTKcomo8EmxTvSO8nZE2PJrLAyvBKlJ6w
        9yZWYjRknWKsBA5ZzMAfmdQ+Jg==
X-Google-Smtp-Source: AA0mqf5iPYk7yKUwfRVq+d+rtQIV3SwGoqAMEmt0k4jMrvuEN+ublImMTsgO0pTl5epO8aXVn66pCg==
X-Received: by 2002:adf:f54e:0:b0:241:c68b:6b41 with SMTP id j14-20020adff54e000000b00241c68b6b41mr223529wrp.95.1668774367058;
        Fri, 18 Nov 2022 04:26:07 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:b10c:1279:a704:75d4])
        by smtp.gmail.com with ESMTPSA id f19-20020a05600c155300b003c6f3e5ba42sm9873958wmg.46.2022.11.18.04.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 04:26:06 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 05/15] tty: serial: qcom-geni-serial: remove stray newlines
Date:   Fri, 18 Nov 2022 13:25:29 +0100
Message-Id: <20221118122539.384993-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221118122539.384993-1-brgl@bgdev.pl>
References: <20221118122539.384993-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Remove stray newlines around #ifdefs for consistency with the rest
of the driver code.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 1db2795804e9..dd1491a72deb 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -317,7 +317,6 @@ static void qcom_geni_serial_abort_rx(struct uart_port *uport)
 }
 
 #ifdef CONFIG_CONSOLE_POLL
-
 static int qcom_geni_serial_get_char(struct uart_port *uport)
 {
 	struct qcom_geni_private_data *private_data = uport->private_data;
@@ -542,7 +541,6 @@ static int handle_rx_console(struct uart_port *uport, u32 bytes, bool drop)
 {
 	return -EPERM;
 }
-
 #endif /* CONFIG_SERIAL_QCOM_GENI_CONSOLE */
 
 static int handle_rx_uart(struct uart_port *uport, u32 bytes, bool drop)
-- 
2.37.2

