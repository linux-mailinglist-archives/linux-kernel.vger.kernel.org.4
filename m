Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAE46E8E2D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 11:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234243AbjDTJfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 05:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234354AbjDTJfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:35:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F5AFC;
        Thu, 20 Apr 2023 02:35:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1571C645ED;
        Thu, 20 Apr 2023 09:35:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF62C433EF;
        Thu, 20 Apr 2023 09:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681983318;
        bh=7QGfrx5Lylgu2pycxL1l/ScFu4JMnrN+XPP1ENGhSDw=;
        h=From:To:Cc:Subject:Date:From;
        b=REFT8W24+2Tc29e1ywKO6xQLvkg81mp7G5smDtXy3TJxJk0WiU1vAP6jOCCx3oG8R
         6xshBT3V43i/4PGKK96DD6yCD/tRGfU9E7f2ZS1DdLn9QeYeByUMClq3k1NKLN3WJ2
         jnOQ6zh4riRYIwt4PoV8py2I169xzsfehB8FGM1wOHEK42OrmAXVlEKxH0qXSuQCob
         s4HSawuxYufAoh1SIXnnTgQqM7CIX08j5feV/MMBh2FjcjyoUj4AhPqOiUrYuBSe2m
         Qq5NIFfti8w+Fk9ZDlIZUfBxKLEtOBkqeyjOYkHldWWRIiTo50KkbWiDvBecGhO6Sb
         zEMEDV14Nn5Gw==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] tty: serial: simplify qcom_geni_serial_send_chunk_fifo()
Date:   Thu, 20 Apr 2023 11:35:14 +0200
Message-Id: <20230420093514.13055-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* use memcpy() instead of the loop (removes c variable)
* use remaining parameter directly (removes chunk variable)

The code is simpler and easier to follow.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
---
 drivers/tty/serial/qcom_geni_serial.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 1881dd5b3c4d..08dc3e2a729c 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -854,21 +854,19 @@ static void qcom_geni_serial_stop_tx(struct uart_port *uport)
 }
 
 static void qcom_geni_serial_send_chunk_fifo(struct uart_port *uport,
-					     unsigned int chunk)
+					     unsigned int remaining)
 {
 	struct qcom_geni_serial_port *port = to_dev_port(uport);
 	struct circ_buf *xmit = &uport->state->xmit;
-	unsigned int tx_bytes, c, remaining = chunk;
+	unsigned int tx_bytes;
 	u8 buf[BYTES_PER_FIFO_WORD];
 
 	while (remaining) {
 		memset(buf, 0, sizeof(buf));
 		tx_bytes = min(remaining, BYTES_PER_FIFO_WORD);
 
-		for (c = 0; c < tx_bytes ; c++) {
-			buf[c] = xmit->buf[xmit->tail];
-			uart_xmit_advance(uport, 1);
-		}
+		memcpy(buf, &xmit->buf[xmit->tail], tx_bytes);
+		uart_xmit_advance(uport, tx_bytes);
 
 		iowrite32_rep(uport->membase + SE_GENI_TX_FIFOn, buf, 1);
 
-- 
2.40.0

