Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA07B7085C7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 18:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjERQSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 12:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjERQSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 12:18:01 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2669613E;
        Thu, 18 May 2023 09:18:00 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-50db91640d3so3406780a12.0;
        Thu, 18 May 2023 09:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1684426678; x=1687018678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tx7s4OrARk8t2mLBnmDH++pXkn/KMVh2OKBh1m33oDE=;
        b=NJXCXKeV++0l8oZ9PD5rxfVowNrQ2djGKKSh+Hl22SZ2KQFAyADbkDUJAdSioavIXD
         xUtjTjfpcdr4IFmRzOjzOJllar51eR2K9gRbIERsbIWTIasRR/JNQSrDLjwau0GU3RyO
         3EvTkbY9U0LvLKExeU01EwV2B3INGRdRqLvG07oyO0SRsrrQF1ciXpQymTjOeKlp9Flx
         +Z1S87ikZ1AM551+FU8n4Jua4TPov4pC/elNhbqin0aF+kdFZB0n44Sb4E6KHq65JUur
         gQgCmeIYooes1E3usjf3tGyaupy4BIcRmKRhLdZWUePKD/O9NWJg038A02fbXSN94L4W
         vPXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684426678; x=1687018678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tx7s4OrARk8t2mLBnmDH++pXkn/KMVh2OKBh1m33oDE=;
        b=EB9v0eEkXwkVGf0Mj3u++fuwiQ7QKHQ5RyPrv2DcGty1HOryALsTywN2bEcDeD78kk
         4XnmBWMW9Qk2JAqmF78lnEpDM46SLtgTbaIYCgdLd6HcxZGPN2OAhtHsbNtZALBzwgGj
         UhSsmgeP4d8yZkeP4I8KaTDSDO4XN14Z9TleeMj5r/hy6ul/SU+p9ENAnZ+pEwbxIubU
         XOflaQPBkSI0+63Pd4rYRIkge0bz5QzOCm9FdaJsXkzs7dc2NJn6nZqo27ac9wVBdy69
         aAvjDQX3X+aupEnuwWPDpUFvyrpMtccHOteRCNnckrLxWI+ZhpykmYPK6LaD3jzYXEJs
         AzqA==
X-Gm-Message-State: AC+VfDycmCFzGnZODm7NW2ghIIJBYmwq1qu++VjVgc84mA1ulXE2pb09
        z7A/ZijfQjoF4ZrwWWnZh+HIv2p/dEg=
X-Google-Smtp-Source: ACHHUZ4UcQBNymzA69E29b44BWwch+9k/SIYvZRLyVAXxbQGs3hj1Bbz0N1FYBMCWzIexLr8fcFfSw==
X-Received: by 2002:a05:6402:b2f:b0:510:e902:9678 with SMTP id bo15-20020a0564020b2f00b00510e9029678mr1799893edb.8.1684426678013;
        Thu, 18 May 2023 09:17:58 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c22-73e5-9e00-0000-0000-0000-0e63.c22.pool.telefonica.de. [2a01:c22:73e5:9e00::e63])
        by smtp.googlemail.com with ESMTPSA id c14-20020aa7c74e000000b0050bc13e5aa9sm756307eds.63.2023.05.18.09.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 09:17:57 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-wireless@vger.kernel.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, kvalo@kernel.org, tony0620emma@gmail.com,
        Peter Robinson <pbrobinson@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>, jernej.skrabec@gmail.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH wireless-next v1 1/4] wifi: rtw88: sdio: Check the HISR RX_REQUEST bit in rtw_sdio_rx_isr()
Date:   Thu, 18 May 2023 18:17:46 +0200
Message-Id: <20230518161749.1311949-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230518161749.1311949-1-martin.blumenstingl@googlemail.com>
References: <20230518161749.1311949-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/net/wireless/realtek/rtw88/sdio.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index 06fce7c3adda..32b8c9194b2c 100644
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
@@ -1012,7 +1012,24 @@ static void rtw_sdio_rx_isr(struct rtw_dev *rtwdev)
 		rtw_sdio_rxfifo_recv(rtwdev, rx_len);
 
 		total_rx_bytes += rx_len;
-	}
+
+		if (rtw_chip_wcpu_11n(rtwdev))
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
+		else
+			/* RTW_WCPU_11AC chips have improved hardware or
+			 * firmware and can use rx_len unconditionally.
+			 */
+			hisr = REG_SDIO_HISR_RX_REQUEST;
+	} while (total_rx_bytes < SZ_64K && hisr & REG_SDIO_HISR_RX_REQUEST);
 }
 
 static void rtw_sdio_handle_interrupt(struct sdio_func *sdio_func)
-- 
2.40.1

