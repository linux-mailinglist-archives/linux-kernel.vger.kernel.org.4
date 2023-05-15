Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450A1703DD9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 21:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244344AbjEOTvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 15:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242842AbjEOTvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 15:51:00 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE613D2C3;
        Mon, 15 May 2023 12:50:58 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-965a68abfd4so2516951966b.2;
        Mon, 15 May 2023 12:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1684180257; x=1686772257;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1dCiTguXYORtoF4oVzk6CUPb17otNxhaws46Ic3PhU0=;
        b=BlGt6J+ZT9Ni9RSP4xURlBWCFw+xiErx9aEKLboq5QL0xLqU9zyGK0OI55O6sP4Xda
         MVw360SGdBAk0N0CcR0tprvDfck6C5L+SezL/Me7xBbEdurfW7pJiS+IX5nYnNPwlm5q
         BOylS1QtHhw4S6f6LjxnYXoOjnzS7/PkPRO5walUD0POXUbsyB0xsiAFaI9Qib49QNlG
         JlglUa/4v7D0QaVSL59QWJc2YQM1V0OQpcPBFiJK5hsxhea339f43Ys9LWV2KRVHhhgq
         PoBwP41Tv30vTL5Gn17FpCdS9S5x6RumB8dCXISquyQECuy0cAjTWCgtYO2vACAR2CGi
         D0FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684180257; x=1686772257;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1dCiTguXYORtoF4oVzk6CUPb17otNxhaws46Ic3PhU0=;
        b=SmxoDYrJs2XeiOq/u0jqQ54Z9ey3tLgXPw8mZg6QzuoTTGfpqd7TuzZ9P77TlVWxPm
         upkEqrHrTpFIHgiKffUnvRceu3rlSgoGdqAxewP2ESa64ZTRqrzkf/mC860FL6WHe/9h
         58cMTJL9iOpy1lP/ek9aa4IKMPH+QqL8SibdE6wYrfntR3vPg5tRKCthK3VTtEmHwwW0
         l6bGHAa8FlAdLTSjIIxBpj4Nwaa4C9J5bzGUIIFRQvDPHJxiJFvuVT3zZAT3YJlkwqQK
         HtgluRvQFcff14nQRYQ0dbKqmCsIDMxGQF7UaaP3u0seVi3wjlY3kIcJXX5Uo7hjKtTM
         n36Q==
X-Gm-Message-State: AC+VfDwvoRB14v4hZk0fIU3TwMcRs1fcLXKYCEDmLAmdOpzSdvwong0d
        VzTNWboQeSJnk67bbZTa2bV4pyTpH6A=
X-Google-Smtp-Source: ACHHUZ4DqNRezIdT0rAW0VYLUO8cBUwaDwyh4wA5MiN+cWfM+jhwNdeZ2J2kV+PNrQydwKb0Ox1iaQ==
X-Received: by 2002:a17:906:dac8:b0:969:f54c:dee8 with SMTP id xi8-20020a170906dac800b00969f54cdee8mr20836928ejb.35.1684180256867;
        Mon, 15 May 2023 12:50:56 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c22-7250-7200-0000-0000-0000-0e63.c22.pool.telefonica.de. [2a01:c22:7250:7200::e63])
        by smtp.googlemail.com with ESMTPSA id tl14-20020a170907c30e00b00961277a426dsm9810589ejc.205.2023.05.15.12.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 12:50:56 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-wireless@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, pkshih@realtek.com,
        tony0620emma@gmail.com, kvalo@kernel.org, jernej.skrabec@gmail.com,
        linux-sunxi@lists.linux.dev,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Rudi Heitbaum <rudi@heitbaum.com>
Subject: [PATCH wireless v2] wifi: rtw88: sdio: Always use two consecutive bytes for word operations
Date:   Mon, 15 May 2023 21:50:43 +0200
Message-Id: <20230515195043.572375-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.40.1
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

The Allwinner sunxi-mmc controller cannot handle word (16 bit)
transfers. So and sdio_{read,write}w fails with messages like the
following example using an RTL8822BS (but the same problems were also
observed with RTL8822CS and RTL8723DS chips):
  rtw_8822bs mmc1:0001:1: Firmware version 27.2.0, H2C version 13
  sunxi-mmc 4021000.mmc: unaligned scatterlist: os f80 length 2
  sunxi-mmc 4021000.mmc: map DMA failed
  rtw_8822bs mmc1:0001:1: sdio read16 failed (0x10230): -22

Use two consecutive single byte accesses for word operations instead. It
turns out that upon closer inspection this is also what the vendor
driver does, even though it does have support for sdio_{read,write}w. So
we can conclude that the rtw88 chips do support word access but only on
SDIO controllers that also support it. Since there's no way to detect if
the controller supports word access or not the rtw88 sdio driver
switches to the easiest approach: avoiding word access.

Reported-by: Larry Finger <Larry.Finger@lwfinger.net>
Closes: https://lore.kernel.org/linux-wireless/527585e5-9cdd-66ed-c3af-6da162f4b720@lwfinger.net/
Reported-by: Rudi Heitbaum <rudi@heitbaum.com>
Link: https://github.com/LibreELEC/LibreELEC.tv/pull/7837#issue-1708469467
Fixes: 65371a3f14e7 ("wifi: rtw88: sdio: Add HCI implementation for SDIO based chipsets")
Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
Changes since v1:
- Added Link to Rudi Heitbaum's issue report
- Added Ping-Ke's Reviewed-by (thank you!)
- Cc'ed linux-sunxi


 drivers/net/wireless/realtek/rtw88/sdio.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index af0459a79899..06fce7c3adda 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.c
+++ b/drivers/net/wireless/realtek/rtw88/sdio.c
@@ -87,11 +87,6 @@ static void rtw_sdio_writew(struct rtw_dev *rtwdev, u16 val, u32 addr,
 	u8 buf[2];
 	int i;
 
-	if (rtw_sdio_use_memcpy_io(rtwdev, addr, 2)) {
-		sdio_writew(rtwsdio->sdio_func, val, addr, err_ret);
-		return;
-	}
-
 	*(__le16 *)buf = cpu_to_le16(val);
 
 	for (i = 0; i < 2; i++) {
@@ -125,9 +120,6 @@ static u16 rtw_sdio_readw(struct rtw_dev *rtwdev, u32 addr, int *err_ret)
 	u8 buf[2];
 	int i;
 
-	if (rtw_sdio_use_memcpy_io(rtwdev, addr, 2))
-		return sdio_readw(rtwsdio->sdio_func, addr, err_ret);
-
 	for (i = 0; i < 2; i++) {
 		buf[i] = sdio_readb(rtwsdio->sdio_func, addr + i, err_ret);
 		if (*err_ret)
-- 
2.40.1

