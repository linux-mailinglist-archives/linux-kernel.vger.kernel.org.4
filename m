Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B54D74C505
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 17:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbjGIPNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 11:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjGIPNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 11:13:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3847E1B3;
        Sun,  9 Jul 2023 08:13:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5484460BC5;
        Sun,  9 Jul 2023 15:13:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B5DC433C7;
        Sun,  9 Jul 2023 15:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688915592;
        bh=jAp8mWG+a5X5KuvI4qyYtYYgwdNfhGImxiJ+pfJksXs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WqF1PuVhtEB2DJ4ZIPMYmA/HM0HPgN5zOgi1ynhC/HdgU7R1rPlRscvNAo0BCKBM8
         fn2PYZ9NiqYjN+1+GABDAXrAs2DtjOqDWMRrWX9gFWfDs/49MNffTObzGmgITbxviB
         g2QoKEKBnSFKqZAA7oivdgjdlmOR1Y5gwp4Y5DncdHVbtNIBdTwHkXzpssMrQeYlVk
         9D+fN4QZhEUkY7ql/2jMVXQWnR709KIsdAQ5SYPztpHKxR4tDRc5vdHK579CDtjtUU
         b2fGRTLK19c3z+1gcDKcuyMhRh8k4dk+rTX3qISTuQ7Ozrjs1+R9VKmpZeZ5bPneLD
         j0GAoSJlzmqPQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>, Sasha Levin <sashal@kernel.org>,
        tony0620emma@gmail.com, linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 09/26] wifi: rtw88: sdio: Check the HISR RX_REQUEST bit in rtw_sdio_rx_isr()
Date:   Sun,  9 Jul 2023 11:12:38 -0400
Message-Id: <20230709151255.512931-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230709151255.512931-1-sashal@kernel.org>
References: <20230709151255.512931-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.2
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[ Upstream commit e967229ead0e6c5047a1cfd5a0db58ceb930800b ]

rtw_sdio_rx_isr() is responsible for receiving data from the wifi chip
and is called from the SDIO interrupt handler when the interrupt status
register (HISR) has the RX_REQUEST bit set. After the first batch of
data has been processed by the driver the wifi chip may have more data
ready to be read, which is managed by a loop in rtw_sdio_rx_isr().

It turns out that there are cases where the RX buffer length (from the
REG_SDIO_RX0_REQ_LEN register) does not match the data we receive. The
following two cases were observed with a RTL8723DS card:
- RX length is smaller than the total packet length including overhead
  and actual data bytes (whose length is part of the buffer we read from
  the wifi chip and is stored in rtw_rx_pkt_stat.pkt_len). This can
  result in errors like:
    skbuff: skb_over_panic: text:ffff8000011924ac len:3341 put:3341
  (one case observed was: RX buffer length = 1536 bytes but
   rtw_rx_pkt_stat.pkt_len = 1546 bytes, this is not valid as it means
   we need to read beyond the end of the buffer)
- RX length looks valid but rtw_rx_pkt_stat.pkt_len is zero

Check if the RX_REQUEST is set in the HISR register for each iteration
inside rtw_sdio_rx_isr(). This mimics what the RTL8723DS vendor driver
does and makes the driver only read more data if the RX_REQUEST bit is
set (which seems to be a way for the card's hardware or firmware to
tell the host that data is ready to be processed).

For RTW_WCPU_11AC chips this check is not needed. The RTL8822BS vendor
driver for example states that this check is unnecessary (but still uses
it) and the RTL8822CS drops this check entirely.

Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20230522202425.1827005-2-martin.blumenstingl@googlemail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw88/sdio.c | 24 ++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index 06fce7c3addaa..2c1fb2dabd40a 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.c
+++ b/drivers/net/wireless/realtek/rtw88/sdio.c
@@ -998,9 +998,9 @@ static void rtw_sdio_rxfifo_recv(struct rtw_dev *rtwdev, u32 rx_len)
 
 static void rtw_sdio_rx_isr(struct rtw_dev *rtwdev)
 {
-	u32 rx_len, total_rx_bytes = 0;
+	u32 rx_len, hisr, total_rx_bytes = 0;
 
-	while (total_rx_bytes < SZ_64K) {
+	do {
 		if (rtw_chip_wcpu_11n(rtwdev))
 			rx_len = rtw_read16(rtwdev, REG_SDIO_RX0_REQ_LEN);
 		else
@@ -1012,7 +1012,25 @@ static void rtw_sdio_rx_isr(struct rtw_dev *rtwdev)
 		rtw_sdio_rxfifo_recv(rtwdev, rx_len);
 
 		total_rx_bytes += rx_len;
-	}
+
+		if (rtw_chip_wcpu_11n(rtwdev)) {
+			/* Stop if no more RX requests are pending, even if
+			 * rx_len could be greater than zero in the next
+			 * iteration. This is needed because the RX buffer may
+			 * already contain data while either HW or FW are not
+			 * done filling that buffer yet. Still reading the
+			 * buffer can result in packets where
+			 * rtw_rx_pkt_stat.pkt_len is zero or points beyond the
+			 * end of the buffer.
+			 */
+			hisr = rtw_read32(rtwdev, REG_SDIO_HISR);
+		} else {
+			/* RTW_WCPU_11AC chips have improved hardware or
+			 * firmware and can use rx_len unconditionally.
+			 */
+			hisr = REG_SDIO_HISR_RX_REQUEST;
+		}
+	} while (total_rx_bytes < SZ_64K && hisr & REG_SDIO_HISR_RX_REQUEST);
 }
 
 static void rtw_sdio_handle_interrupt(struct sdio_func *sdio_func)
-- 
2.39.2

