Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D91693215
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 16:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjBKPrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 10:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjBKPrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 10:47:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F44C1C7FE
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 07:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676130378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=O7XkEjMNE8+iiPDaPqXuL/eN3ShpzX6KK4M/D+SJvvE=;
        b=esZ8OnBUhF7qo8+RbITdYgwpoO+rYVWjuQceZCjVRBOSDq9DOyljTreHT3rtUeCOG0daFI
        c6mhwZtQVLUk0ttDpNFKXUlHJesxisy7OeCnsZ/nAnUBe0hL7r9ejukXXM/Kkb10ezWiLm
        uH5jlHsNjjZkBIT75mBlmK6wF+gSgEs=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-360-iR3rAA9fM7CLApqpFL2shg-1; Sat, 11 Feb 2023 10:46:01 -0500
X-MC-Unique: iR3rAA9fM7CLApqpFL2shg-1
Received: by mail-qt1-f197.google.com with SMTP id he22-20020a05622a601600b003ba3c280fabso4847989qtb.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 07:46:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O7XkEjMNE8+iiPDaPqXuL/eN3ShpzX6KK4M/D+SJvvE=;
        b=jEaM6progs3Lq4gtd6maS8uu4AjW8IFFP6IcwxLw4oDTk6XRWAslTGtv3ry6ffGfYp
         G3LMf5MdVn/NZq6k9ecTnhexeeAFLtzN+5Olzayqw3oYE8GnkNU0iohMp55W2fnPPeUj
         oGytoyk0hlvgotADfU+wzLUviGzQ1c3MaWH6r4KdHOqJG1iGJulgcNwCdq+I/cimTPFI
         bRH/0QHFJu2N93QEj5ePbqUZeCds+6tYIaYWRhQfwz7Xt1++WacOoH9yNm5ECrlDb71T
         z78jWMPpkhLQOD1KfvK3HskhkvxnJzKl7trAbFpCQjC4uwj483spH3vrDmozVFzPRgLi
         0T5A==
X-Gm-Message-State: AO0yUKWiWorCm0GUeanmqJyXuhk4yb2cqKuoRmZm0ji0YpelM/7Gfy3s
        hL2dofD8O+msDR8QPewGhtg6qndc9eL6S68bSipkpr+2yCpDyqEQTE03/qwjSffiLbjCjj7y7Ah
        SueRxKrzGsPoYLhW9vQbQ70jf
X-Received: by 2002:a05:622a:64b:b0:3bb:89be:8b45 with SMTP id a11-20020a05622a064b00b003bb89be8b45mr12440593qtb.65.1676130361197;
        Sat, 11 Feb 2023 07:46:01 -0800 (PST)
X-Google-Smtp-Source: AK7set8TgpagNQyMM/EhhmI5d/iFi5OKGZteX6jyu06UbjTHrtPOUeLawnKurMDXLzcWPn3V5YiZCA==
X-Received: by 2002:a05:622a:64b:b0:3bb:89be:8b45 with SMTP id a11-20020a05622a064b00b003bb89be8b45mr12440558qtb.65.1676130360863;
        Sat, 11 Feb 2023 07:46:00 -0800 (PST)
Received: from borg.redhat.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id t187-20020ae9dfc4000000b0073902217c00sm4697750qkf.23.2023.02.11.07.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 07:46:00 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] serial: imx: remove a redundant check
Date:   Sat, 11 Feb 2023 07:45:50 -0800
Message-Id: <20230211154550.2130670-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpp_check reports
drivers/tty/serial/imx.c:1207:15: style: Condition 'r_bytes>0' is always true [knownConditionTrueFalse]
  if (r_bytes > 0) {

r_byte is set to
  r_bytes = rx_ring->head - rx_ring->tail;

The head - tail calculation is also done by the earlier check
  if (rx_ring->head <= sg_dma_len(sgl) &&
      rx_ring->head > rx_ring->tail) {

so r_bytes will always be > 0, so the second check is not needed.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/tty/serial/imx.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 363c77a140f0..523f296d5747 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1204,11 +1204,9 @@ static void imx_uart_dma_rx_callback(void *data)
 		r_bytes = rx_ring->head - rx_ring->tail;
 
 		/* If we received something, check for 0xff flood */
-		if (r_bytes > 0) {
-			spin_lock(&sport->port.lock);
-			imx_uart_check_flood(sport, imx_uart_readl(sport, USR2));
-			spin_unlock(&sport->port.lock);
-		}
+		spin_lock(&sport->port.lock);
+		imx_uart_check_flood(sport, imx_uart_readl(sport, USR2));
+		spin_unlock(&sport->port.lock);
 
 		if (!(sport->port.ignore_status_mask & URXD_DUMMY_READ)) {
 
-- 
2.26.3

