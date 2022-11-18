Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE3862F49F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 13:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241565AbiKRM0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 07:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241542AbiKRM01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 07:26:27 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8605D9737D
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 04:26:08 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id a14so9049120wru.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 04:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJiQI08Pb3pmpY28T3+Fd6ggBQFLoumFh4Lv/NyHmzg=;
        b=NTwSgH/pPCy0rx9k8+4HSIGh4YIOeNP51I2+IQZNCer+bRZZJMrHL4W8MOAZaSlcHa
         CQ3/fD/YOF7RVGFCC9csekJzz7aov9U4qd78L338s5sACCKRMpjk7BFjGdD7JViUsqKE
         Nc4YU02rLOIRMxsypwq3fAN7CJWgOTIE/AZHR110qhWm5SWYkZgOL2ghf/y9GdG5oQ6Z
         e7OYrK88Uok9baa7uaJTzMVwDpfgce8jdDZi8QKiBjpOCuNJ7x1L+2Si/dUbc1pHN2ol
         erzGM6k83Pov8QlyGvBpFXV3Xm6xzcPIICPjbeblWIjZRX7mbUVasH1o5J3PV/xC9OlN
         CS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zJiQI08Pb3pmpY28T3+Fd6ggBQFLoumFh4Lv/NyHmzg=;
        b=PE0YQv1oyH1mG1vFDUcqHQJVEv6XacwnG89BNPVk/yQPFwR3uQGn3FisTM2cF2rXWP
         yWQ2XMp15C6/HieFCxjKX6b79Qdkvo6+AEkbwwONqOG+82kGdDMEBX2kKCEwg1GKUDNC
         0Cg/uoaJpZpVOBT9AUAUTihfeOANV8nAVpNl6fIJ22Iq7ErTStxc5wtgGNXTRyDjKLs0
         1M3kj/W92/yFK2tcFJEYeLVePAB+j2Hg/5qTHrQqiRCjxmgP3Cw8klUMChBY3JW3hk6Y
         1xlOTizT3I6swU9snPdA49lgm3WBbcT5ggy02G04rQ6rOv+pB5rwg9uijcxUsOdSObDe
         jK8g==
X-Gm-Message-State: ANoB5pl1Sr4RZNh60DDwEzMTLHiXMPJ9pvSh6oDUVBnogWE4OSMBQHiq
        Qv5XfHzkp5ipJMGjZyy8frY5nw==
X-Google-Smtp-Source: AA0mqf59q2fvpqJa3HC7aoMwXyiWX2TtLzh14/FzlTwnW6Ry65yk2a7Yc0oPWE4Kjt69fFUtNKh4dA==
X-Received: by 2002:a5d:678c:0:b0:235:14dc:5e14 with SMTP id v12-20020a5d678c000000b0023514dc5e14mr4302820wru.252.1668774368100;
        Fri, 18 Nov 2022 04:26:08 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:b10c:1279:a704:75d4])
        by smtp.gmail.com with ESMTPSA id f19-20020a05600c155300b003c6f3e5ba42sm9873958wmg.46.2022.11.18.04.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 04:26:07 -0800 (PST)
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
Subject: [PATCH 06/15] tty: serial: qcom-geni-serial: refactor qcom_geni_serial_isr()
Date:   Fri, 18 Nov 2022 13:25:30 +0100
Message-Id: <20221118122539.384993-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221118122539.384993-1-brgl@bgdev.pl>
References: <20221118122539.384993-1-brgl@bgdev.pl>
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

Simplify the conditions in qcom_geni_serial_isr() and fix indentation.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index dd1491a72deb..22c1869c60f4 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -824,20 +824,18 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
 
 	if (m_irq_status & m_irq_en & (M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN))
 		qcom_geni_serial_handle_tx(uport, m_irq_status & M_CMD_DONE_EN,
-					geni_status & M_GENI_CMD_ACTIVE);
+					   geni_status & M_GENI_CMD_ACTIVE);
 
-	if (s_irq_status & S_GP_IRQ_0_EN || s_irq_status & S_GP_IRQ_1_EN) {
+	if (s_irq_status & (S_GP_IRQ_0_EN | S_GP_IRQ_1_EN)) {
 		if (s_irq_status & S_GP_IRQ_0_EN)
 			uport->icount.parity++;
 		drop_rx = true;
-	} else if (s_irq_status & S_GP_IRQ_2_EN ||
-					s_irq_status & S_GP_IRQ_3_EN) {
+	} else if (s_irq_status & (S_GP_IRQ_2_EN | S_GP_IRQ_3_EN)) {
 		uport->icount.brk++;
 		port->brk = true;
 	}
 
-	if (s_irq_status & S_RX_FIFO_WATERMARK_EN ||
-					s_irq_status & S_RX_FIFO_LAST_EN)
+	if (s_irq_status & (S_RX_FIFO_WATERMARK_EN | S_RX_FIFO_LAST_EN))
 		qcom_geni_serial_handle_rx(uport, drop_rx);
 
 out_unlock:
-- 
2.37.2

