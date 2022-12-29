Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE154658E84
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 16:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbiL2PvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 10:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbiL2Pum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 10:50:42 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2CD13F91
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 07:50:41 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id m3so4512884wmq.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 07:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DkB27LPR1wcJc7taGvEiK7AOVm/t2Nr5dcxakfWBn9k=;
        b=LEH6TFS3yo9QeOtdYvcsnaqBkKSh+uPUsa1dokWOiMyJAoALyxlxz2Haou9BOOx3LR
         dqBUCKcYJbrhmjY+CWhwZW6+zLpiGKsuFjy7LsqPOe0SwxCqSvBN4kXfJRLR40Qo017x
         LOmbHZ8d6R5R29SqxD6Tn+CeyIPT+UxLEHMwfcvCOQjbLd90j91FP8D6YAUp+tkOrDOz
         3huBNH4ko659EKNzQ8Wk+fl6BBoWFDodYEq410F2eKpYVL/AUNXb4hMcYeqiHNTx7YsD
         0PFwwA3FaIR1oyTdGFBreJ1Dc6TPcMcxv6CNRxjNe+rRMNgnt0bvbNGuIcQv3FDDhFwO
         w1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DkB27LPR1wcJc7taGvEiK7AOVm/t2Nr5dcxakfWBn9k=;
        b=g8stYde9dq+nK0G7/ljfkJt228uS6LP4nOJZn2dPWyjWb+j3rVKZy1+6qnkalPkSlL
         kPeQqMvk1/qphlKzf22oFmYUjqF0pns8HAtq9AAj8pOXlRIu+lowFfk3+5KoT0iPicrQ
         2yb+NVEpA+KZbZslyk8LlP2UkQTbA/flPq7syS7rOFUpc7ltf9tYRS2y8u7VYo8XQVAo
         HvJrIOcwh6WM7XDWJmPOaWgap3jCjGlMupm62i/5hrt6sd1/QWrrqvR0akZDFUftrcG9
         iJ6LOiIkbirD88StSONrQMoVCL/XZSfnbhK5Jb5NZH5vGtb++LmFp3KiNboNfaFKZDek
         P/YA==
X-Gm-Message-State: AFqh2ko1OskOXXwx7LNhvG1TCP7Aa84GCXkTRkJco2FT9BDw7CbfUEfZ
        aZgCxijlyR97PMvuDGT4ll0SxQ==
X-Google-Smtp-Source: AMrXdXsKJDwO6zphv2uoFJnwJftPC07LYIDOtOdUdl7MRjiySXtYbWUWWA6VqMZHRPvJDsx6GTvI4A==
X-Received: by 2002:a05:600c:22c4:b0:3cf:8ed7:712d with SMTP id 4-20020a05600c22c400b003cf8ed7712dmr23773442wmg.14.1672329039860;
        Thu, 29 Dec 2022 07:50:39 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:8f7a:98d8:9d8d:ced8])
        by smtp.gmail.com with ESMTPSA id bh12-20020a05600c3d0c00b003cfa81e2eb4sm25251647wmb.38.2022.12.29.07.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 07:50:39 -0800 (PST)
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
Subject: [PATCH v6 06/14] tty: serial: qcom-geni-serial: remove stray newlines
Date:   Thu, 29 Dec 2022 16:50:22 +0100
Message-Id: <20221229155030.418800-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221229155030.418800-1-brgl@bgdev.pl>
References: <20221229155030.418800-1-brgl@bgdev.pl>
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
index 803a46ce4179..f4e2486b2115 100644
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

