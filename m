Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63A56AE720
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjCGQrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjCGQqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:46:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6701D211D5;
        Tue,  7 Mar 2023 08:43:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB288614D1;
        Tue,  7 Mar 2023 16:43:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C71C4339C;
        Tue,  7 Mar 2023 16:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678207417;
        bh=nr7223xxoM6+3D2kuSbPhGCYTqq1ERzivz361j3EF3E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s5eQ16PbFgS8bt+xxIG7HhBp99LyC48qMXEOdCl6Hkw4Snt938cXBRWAhRcYqo6PZ
         Uyw4joS7AXANqJSP4HrrzO3WfSkYU/HtVtalesDI1LMXLdxZd2koXkS2+j5+6hePsp
         zdWLa9GAT9L33Z+KN7+wHKUxde0AgkIpV3CF/ZpRgQkQYZL5Cdo59YJQMUfBBX0VWZ
         CbnjgDNhd4VFNUr/4KTCyee1nhqjsgHtp4NaGC5w4EliWWd1i1YaI0L2Al6YXzh+1g
         TuQcTLtcN1+z0gtCENyv8dueZI4J55Ljn1jCiyhqoOF/Fa7+M4zlSe15sirQp0yjXA
         +X723GnvHb8sQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pZaQH-0003i9-6y; Tue, 07 Mar 2023 17:44:21 +0100
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
Subject: [PATCH 4/4] serial: qcom-geni: drop bogus uart_write_wakeup()
Date:   Tue,  7 Mar 2023 17:44:05 +0100
Message-Id: <20230307164405.14218-5-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307164405.14218-1-johan+linaro@kernel.org>
References: <20230307164405.14218-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the bogus uart_write_wakeup() from when setting up a new DMA
transfer, which does not free up any more space in the ring buffer.

Any pending writers will be woken up when the transfer completes.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 9871225b2f9b..28fbc927a546 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -634,10 +634,6 @@ static void qcom_geni_serial_start_tx_dma(struct uart_port *uport)
 	if (uart_circ_empty(xmit))
 		return;
 
-	xmit_size = uart_circ_chars_pending(xmit);
-	if (xmit_size < WAKEUP_CHARS)
-		uart_write_wakeup(uport);
-
 	xmit_size = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
 
 	qcom_geni_serial_setup_tx(uport, xmit_size);
-- 
2.39.2

