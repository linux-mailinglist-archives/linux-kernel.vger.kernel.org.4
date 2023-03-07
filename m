Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170586AE71F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjCGQrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:47:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjCGQqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:46:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A621096C3C;
        Tue,  7 Mar 2023 08:43:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58EE9B81986;
        Tue,  7 Mar 2023 16:43:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19355C433A0;
        Tue,  7 Mar 2023 16:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678207417;
        bh=Wq+5k8oC8/u0yNH/aD78uhUqCmSvOQM4I4ENgYqsEkU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XhYOkPxMndsBoqpJdPajozRgjCCsjGLj0y+V/ZVU/9aDc86ZemRCxx7mXr6pJeSJn
         ll9lZraCSfgs4jCVxyJ3CRZc5fDlbqo9yzMJqq3/Ys4wY7YFo+2PuZ7wasndQGUKPe
         FKk2LVMbG+sxgGjPq07K58XcVTDPqdh8Kc4PuSkZvtoEwmMJKrh9tXdkjalA6e70OZ
         Bqu1F+Jn/+t/lM2S1ZjI/nlVY78qvn/4QMCJNsb9HMKuIdjPOPbl16gKdJw7xU+1xm
         D2UjkyW4nofslpdcSIgxxnm9v5zPLoz8oKTa0yob8KPBL+qoVU6MWKTuzN9OWwSS/x
         dxeG21NqNDNHw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pZaQH-0003hs-0z; Tue, 07 Mar 2023 17:44:21 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 2/4] serial: qcom-geni: fix DMA mapping leak on shutdown
Date:   Tue,  7 Mar 2023 17:44:03 +0100
Message-Id: <20230307164405.14218-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307164405.14218-1-johan+linaro@kernel.org>
References: <20230307164405.14218-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix what appears to be a copy-paste error that can lead to a leaked DMA
mapping on close() and failure to restart TX after the port is reopened.

Note that rx_dma_addr is generally NULL when
qcom_geni_serial_stop_tx_dma() is called as part of shutdown() (but
tx_dma_addr need not be).

Fixes: 2aaa43c70778 ("tty: serial: qcom-geni-serial: add support for serial engine DMA")
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 11da05d8f848..2aa3872e6283 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -596,7 +596,7 @@ static void qcom_geni_serial_stop_tx_dma(struct uart_port *uport)
 	if (!qcom_geni_serial_main_active(uport))
 		return;
 
-	if (port->rx_dma_addr) {
+	if (port->tx_dma_addr) {
 		geni_se_tx_dma_unprep(&port->se, port->tx_dma_addr,
 				      port->tx_remaining);
 		port->tx_dma_addr = 0;
-- 
2.39.2

