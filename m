Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5406AE71E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjCGQrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjCGQqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:46:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A174196C32;
        Tue,  7 Mar 2023 08:43:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A36BB81928;
        Tue,  7 Mar 2023 16:43:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DBAAC433D2;
        Tue,  7 Mar 2023 16:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678207417;
        bh=PAB2kcyznKkTzA0a1Jv3xHQl7lhPaWOJlLVm7w2vvWE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tRqzPZIfbElBEPP9RwjoCEqhk+gxtlXEDVAS2dhQxL9M9EDEpnm86M63FLMU36M5O
         3cyzzxxaUhDqOi1krJ9nIlRANbgCU/Du3DdiYpLCPKpTbJfeSQaPdCKDQyJwHSTHQP
         SfpTMcbklQGdz4bScORVvcRZGA7dVoxpTr2vsGJN+1I9zA7eYzR8okM65CnbmY4JuR
         ujNT7S6mxvPV+ZYsYTbusn5WZfi3HBoAhXUVJy/hbJU6ix62tj307MrbE3V89TcLqY
         ZLvIftZh7nGe0q1QKIQL6PbRVmhhJYkAupeqNzr1QFhnt9+KuQxyAHlFwPwsWY1DBs
         om4GKEuU/BMYA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pZaQH-0003i7-45; Tue, 07 Mar 2023 17:44:21 +0100
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
Subject: [PATCH 3/4] serial: qcom-geni: fix mapping of empty DMA buffer
Date:   Tue,  7 Mar 2023 17:44:04 +0100
Message-Id: <20230307164405.14218-4-johan+linaro@kernel.org>
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

Make sure that there is data in the ring buffer before trying to set up
a zero-length DMA transfer.

This specifically fixes the following warning when unmapping the empty
buffer on the sc8280xp-crd:

   WARNING: CPU: 0 PID: 138 at drivers/iommu/dma-iommu.c:1046 iommu_dma_unmap_page+0xbc/0xd8
   ...
   Call trace:
    iommu_dma_unmap_page+0xbc/0xd8
    dma_unmap_page_attrs+0x30/0x1c8
    geni_se_tx_dma_unprep+0x28/0x38
    qcom_geni_serial_isr+0x358/0x75c

Fixes: 2aaa43c70778 ("tty: serial: qcom-geni-serial: add support for serial engine DMA")
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 2aa3872e6283..9871225b2f9b 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -631,6 +631,9 @@ static void qcom_geni_serial_start_tx_dma(struct uart_port *uport)
 	if (port->tx_dma_addr)
 		return;
 
+	if (uart_circ_empty(xmit))
+		return;
+
 	xmit_size = uart_circ_chars_pending(xmit);
 	if (xmit_size < WAKEUP_CHARS)
 		uart_write_wakeup(uport);
-- 
2.39.2

