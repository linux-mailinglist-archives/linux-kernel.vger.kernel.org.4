Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8446AE71D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjCGQrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjCGQqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:46:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA9596C2F;
        Tue,  7 Mar 2023 08:43:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1F82614DF;
        Tue,  7 Mar 2023 16:43:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC29C433B4;
        Tue,  7 Mar 2023 16:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678207417;
        bh=YjMTLeqUrjD3XZwpoLNymTfC9unMud9yDlDAEDjzs2U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G6i/dTXZ9vd1pcjWL1vwbzOt3WQ0cnyPYlHSN4wG2WigiFGDIZ97wiYCw9tjrL69S
         /3o5tXP6e9nwGRYuY21FaxZje5XxUsTtD36CzApzwQsUyCDHnzT/BnimU+sz9/EeRg
         mZBN4837pTcZt8XzHCULsRREs2n3+vcja7AJFQmM8Cdx7w6CDouhxINQ/gkidc4Sby
         rIwHehqOxIjxuCLrPD1tEzyg67IQZdEhX1+dVBapqrOyeJvqNh3fnNVhfRFA14/4Zx
         7nSB3y+zWZtTHb+lMvx7mQFrttS4vRknRa2M4o9hYWsRfX2fDL5SoEbFOY/7JVqXSX
         xqKa77+PSN++w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pZaQG-0003hq-UG; Tue, 07 Mar 2023 17:44:20 +0100
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
Subject: [PATCH 1/4] serial: qcom-geni: fix console shutdown hang
Date:   Tue,  7 Mar 2023 17:44:02 +0100
Message-Id: <20230307164405.14218-2-johan+linaro@kernel.org>
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

A recent commit added back the calls top stop tx and rx to shutdown()
which had previously been removed by commit e83766334f96 ("tty: serial:
qcom_geni_serial: No need to stop tx/rx on UART shutdown") in order to
be able to use kgdb after stopping the getty.

Not only did this again break kgdb, but it also broke serial consoles
more generally by hanging TX when stopping the getty during reboot.

The underlying problem has been there since the driver was first merged
and fixing it is going to be a bit involved so simply stop calling the
broken stop functions during shutdown for consoles for now.

Fixes: d8aca2f96813 ("tty: serial: qcom-geni-serial: stop operations in progress at shutdown")
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index d69592e5e2ec..11da05d8f848 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1070,6 +1070,10 @@ static int setup_fifos(struct qcom_geni_serial_port *port)
 static void qcom_geni_serial_shutdown(struct uart_port *uport)
 {
 	disable_irq(uport->irq);
+
+	if (uart_console(uport))
+		return;
+
 	qcom_geni_serial_stop_tx(uport);
 	qcom_geni_serial_stop_rx(uport);
 }
-- 
2.39.2

