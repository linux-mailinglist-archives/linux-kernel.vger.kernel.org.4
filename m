Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E27A635B1C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 12:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237259AbiKWLJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 06:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237539AbiKWLIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 06:08:31 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CC28DA6F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 03:08:10 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id cl5so28866989wrb.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 03:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EonL2PwB0Makj2JepNmLczYfWSZatIPogqShuTJezMI=;
        b=y+h8KSTlvJEDdoUPd4LwiIlAz/2krzVRVWUIA2XxuS+VYYpNHMGi3UVCblbh0TcuAa
         ZIlRRcdXqugHD1hgmV1Qfc1y5TGepgh9rUQM8rJ6g7ApdKGFAxym87H/urDdRayYvWXf
         2IrXxRq+bXsjg8MnjI6AFK7QW9bhav0ftKbu+jC1cYzRnHn8e5k1ofFdBSkg/AB2YpZ2
         DoPGElPz9rigwi7f1opVlTz82twOy1YL+56i2TKsOEMt/k1QGSwwqzv1PGdgUsGLNRit
         4izPXRymbCFuFiSw9xCLsTZXgC7c8/vHMjYZ9FcRNxbQkvTidKnlOXUKJuPfRDQxkaSc
         2opA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EonL2PwB0Makj2JepNmLczYfWSZatIPogqShuTJezMI=;
        b=xggr48O6LpIUsFHrMWaeGXMHk05G6zH7nEw6p8PqONcgZkojvWYvQPi11kheyBi4Y/
         gwDYWUlOrOLRmxca1r0+CeqUct4wepj8tTrFnBJydsWzfGVUoZmvB4naCcGNgMiw6eoK
         6wGWw7uTlLNO51B/7mfjF3PXOwqDapz0U4nxMfmrD54e7f8KF2mhKyUQVli3NC1iPjDu
         OWdmIcYUynf8xWMQ3Re1/pB950JFDVOCyYFgMYODfHijZNuzQRnQEtzW3urOTOALStN/
         /r3FcLgs3++MADd8OE+XIEMfJ9bBtXsmNzf7hx8RV5ezmD3o20BdK88NEUoekiydVzxY
         8pcg==
X-Gm-Message-State: ANoB5plaUaXK8aKsxgj8DjGuAAsTia4s1vWhJ/+ewJH5I4s2AzkdlOJO
        w2ty86ULCUTUTEEl0ru5AYA+Fw==
X-Google-Smtp-Source: AA0mqf70XElT3Cg/4ZdsjWeevIRaFCwEhBcVKoekCLcXAE4C9SQ7IcQXOJqAfJnL1Zd1BQp03FNijg==
X-Received: by 2002:adf:ff83:0:b0:236:6824:c227 with SMTP id j3-20020adfff83000000b002366824c227mr17330446wrr.510.1669201689497;
        Wed, 23 Nov 2022 03:08:09 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:ae74:d94f:4677:3378])
        by smtp.gmail.com with ESMTPSA id f13-20020a05600c4e8d00b003c6c182bef9sm2560406wmq.36.2022.11.23.03.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 03:08:09 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v3 05/13] tty: serial: qcom-geni-serial: remove stray newlines
Date:   Wed, 23 Nov 2022 12:07:51 +0100
Message-Id: <20221123110759.1836666-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221123110759.1836666-1-brgl@bgdev.pl>
References: <20221123110759.1836666-1-brgl@bgdev.pl>
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
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index e4139718e084..ec2523736e99 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -320,7 +320,6 @@ static void qcom_geni_serial_abort_rx(struct uart_port *uport)
 }
 
 #ifdef CONFIG_CONSOLE_POLL
-
 static int qcom_geni_serial_get_char(struct uart_port *uport)
 {
 	struct qcom_geni_private_data *private_data = uport->private_data;
@@ -545,7 +544,6 @@ static int handle_rx_console(struct uart_port *uport, u32 bytes, bool drop)
 {
 	return -EPERM;
 }
-
 #endif /* CONFIG_SERIAL_QCOM_GENI_CONSOLE */
 
 static int handle_rx_uart(struct uart_port *uport, u32 bytes, bool drop)
-- 
2.37.2

